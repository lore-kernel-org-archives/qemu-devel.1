Received: from eggs.gnu.org ([2001:4830:134:3::10]:45632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ciCAl-000783-29
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 22:40:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ciCAf-0001ix-Sq
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 22:40:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ciCAf-0001gf-JT
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 22:40:21 -0500
References: <1487735198-127300-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487735198-127300-3-git-send-email-zhang.zhanghailiang@huawei.com>
	<b0b04c02-7c97-ea04-1e38-99fd9344edae@redhat.com>
	<58AD4F8F.5030703@huawei.com> <58AD5125.4010306@huawei.com>
	<b792c68e-d67a-ac24-26ea-aaf24f1f9437@redhat.com>
	<58B398F8.1020205@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c7883f1d-99ed-d082-3eee-7e0c641257e6@redhat.com>
Date: Mon, 27 Feb 2017 11:40:11 +0800
MIME-Version: 1.0
In-Reply-To: <58B398F8.1020205@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/3] filter-rewriter: fix memory leak
 for connection in connection_track_table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>, zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, pss.wulizhen@huawei.com



On 2017=E5=B9=B402=E6=9C=8827=E6=97=A5 11:11, Hailiang Zhang wrote:
> On 2017/2/23 12:16, Jason Wang wrote:
>>
>>
>> On 2017=E5=B9=B402=E6=9C=8822=E6=97=A5 16:51, Hailiang Zhang wrote:
>>> On 2017/2/22 16:45, Hailiang Zhang wrote:
>>>> On 2017/2/22 16:07, Jason Wang wrote:
>>>>>
>>>>>
>>>>> On 2017=E5=B9=B402=E6=9C=8822=E6=97=A5 11:46, zhanghailiang wrote:
>>>>>> After a net connection is closed, we didn't clear its releated
>>>>>> resources
>>>>>> in connection_track_table, which will lead to memory leak.
>>>>>
>>>>> Not a real leak but would lead reset of hash table if too many clos=
ed
>>>>> connections.
>>>>>
>>>>
>>>> Yes, you are right, there will be lots of stale connection data in
>>>> hash table
>>>> if we don't remove it while it is been closed. Which
>>
>>
>> Ok, so let's come up with a better title of the patch.
>>
>
> OK.
>
>>>>
>>>>>>
>>>>>> Let't track the state of net connection, if it is closed, its=20
>>>>>> related
>>>>>> resources will be cleared up.
>>>>>
>>>>> The issue is the state were tracked partially, do we need a full=20
>>>>> state
>>>>> machine here?
>>>>>
>>>>
>>>> Not, IMHO, we only care about the last state of it, because, we will
>>>> do nothing
>>>> even if we track the intermedial states.
>>
>> Well, you care at least syn state too. Without a complete state machin=
e,
>> it's very hard to track even partial state I believe. And you will fai=
l
>> to track some state transition for sure which makes the code fragile.
>>
>
> Agree, but here things are a little different. There are some extreme=20
> cases
> that we may can't track the complete process of closing connection.
> For example (I have explained that in the bellow, it seems that you=20
> didn't
> got it ;) ).
> If VM is running before we want to make it goes into COLO FT state,
> there maybe some connections exist already, in extreme case, VM is=20
> going into
> COLO state while some connections are in half closing state, we can=20
> only track
> the bellow half closing state in filter-rewriter and colo compare objec=
t.
>
>>>>
>>>>>>
>>>>>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>>>>>> ---
>>>>>>      net/colo.h            |  4 +++
>>>>>>      net/filter-rewriter.c | 70
>>>>>> +++++++++++++++++++++++++++++++++++++++++++++------
>>>>>>      2 files changed, 67 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/net/colo.h b/net/colo.h
>>>>>> index 7c524f3..cd9027f 100644
>>>>>> --- a/net/colo.h
>>>>>> +++ b/net/colo.h
>>>>>> @@ -18,6 +18,7 @@
>>>>>>      #include "slirp/slirp.h"
>>>>>>      #include "qemu/jhash.h"
>>>>>>      #include "qemu/timer.h"
>>>>>> +#include "slirp/tcp.h"
>>>>>>
>>>>>>      #define HASHTABLE_MAX_SIZE 16384
>>>>>>
>>>>>> @@ -69,6 +70,9 @@ typedef struct Connection {
>>>>>>           * run once in independent tcp connection
>>>>>>           */
>>>>>>          int syn_flag;
>>>>>> +
>>>>>> +    int tcp_state; /* TCP FSM state */
>>>>>> +    tcp_seq fin_ack_seq; /* the seq of 'fin=3D1,ack=3D1' */
>>>>>>      } Connection;
>>>>>>
>>>>>>      uint32_t connection_key_hash(const void *opaque);
>>>>>> diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
>>>>>> index c4ab91c..7e7ec35 100644
>>>>>> --- a/net/filter-rewriter.c
>>>>>> +++ b/net/filter-rewriter.c
>>>>>> @@ -60,9 +60,9 @@ static int is_tcp_packet(Packet *pkt)
>>>>>>      }
>>>>>>
>>>>>>      /* handle tcp packet from primary guest */
>>>>>> -static int handle_primary_tcp_pkt(NetFilterState *nf,
>>>>>> +static int handle_primary_tcp_pkt(RewriterState *rf,
>>>>>>                                        Connection *conn,
>>>>>> -                                  Packet *pkt)
>>>>>> +                                  Packet *pkt, ConnectionKey *key=
)
>>>>>>      {
>>>>>>          struct tcphdr *tcp_pkt;
>>>>>>
>>>>>> @@ -97,15 +97,45 @@ static int
>>>>>> handle_primary_tcp_pkt(NetFilterState *nf,
>>>>>>              tcp_pkt->th_ack =3D htonl(ntohl(tcp_pkt->th_ack) +
>>>>>> conn->offset);
>>>>>>
>>>>>>              net_checksum_calculate((uint8_t *)pkt->data,=20
>>>>>> pkt->size);
>>>>>> +        /*
>>>>>> +         * Case 1:
>>>>>> +         * The *server* side of this connect is VM, *client* trie=
s
>>>>>> to close
>>>>>> +         * the connection.
>>>>>> +         *
>>>>>> +         * We got 'ack=3D1' packets from client side, it acks
>>>>>> 'fin=3D1, ack=3D1'
>>>>>> +         * packet from server side. From this point, we can ensur=
e
>>>>>> that there
>>>>>> +         * will be no packets in the connection, except that, som=
e
>>>>>> errors
>>>>>> +         * happen between the path of 'filter object' and vNIC, i=
f
>>>>>> this rare
>>>>>> +         * case really happen, we can still create a new=20
>>>>>> connection,
>>>>>> +         * So it is safe to remove the connection from
>>>>>> connection_track_table.
>>>>>> +         *
>>>>>> +         */
>>>>>> +        if ((conn->tcp_state =3D=3D TCPS_LAST_ACK) &&
>>>>>> +            (ntohl(tcp_pkt->th_ack) =3D=3D (conn->fin_ack_seq + 1=
))) {
>>>>>> +            fprintf(stderr, "Remove conn "
>>>>>
>>>>> Can this even compile?
>>>>>
>>>>
>>>> Oops, i forgot to remove it, will remove it in next version.
>>>>
>>>>>> + g_hash_table_remove(rf->connection_track_table, key);
>>>>>> +        }
>>>>>> +    }
>>>>>> +    /*
>>>>>> +     * Case 2:
>>>>>> +     * The *server* side of this connect is VM, *server* tries to
>>>>>> close
>>>>>> +     * the connection.
>>>>>> +     *
>>>>>> +     * We got 'fin=3D1, ack=3D1' packet from client side, we need=
 to
>>>>>> +     * record the seq of 'fin=3D1, ack=3D1' packet.
>>>>>> +     */
>>>>>> +    if ((tcp_pkt->th_flags & (TH_ACK | TH_FIN)) =3D=3D (TH_ACK |
>>>>>> TH_FIN)) {
>>>>>> +        conn->fin_ack_seq =3D htonl(tcp_pkt->th_seq);
>>>>>> +        conn->tcp_state =3D TCPS_LAST_ACK;
>>>>>>          }
>>>>>>
>>>>>>          return 0;
>>>>>>      }
>>>>>>
>>>>>>      /* handle tcp packet from secondary guest */
>>>>>> -static int handle_secondary_tcp_pkt(NetFilterState *nf,
>>>>>> +static int handle_secondary_tcp_pkt(RewriterState *rf,
>>>>>>                                          Connection *conn,
>>>>>> -                                    Packet *pkt)
>>>>>> +                                    Packet *pkt, ConnectionKey=20
>>>>>> *key)
>>>>>>      {
>>>>>>          struct tcphdr *tcp_pkt;
>>>>>>
>>>>>> @@ -133,8 +163,34 @@ static int
>>>>>> handle_secondary_tcp_pkt(NetFilterState *nf,
>>>>>>              tcp_pkt->th_seq =3D htonl(ntohl(tcp_pkt->th_seq) -
>>>>>> conn->offset);
>>>>>>
>>>>>>              net_checksum_calculate((uint8_t *)pkt->data,=20
>>>>>> pkt->size);
>>>>>> +        /*
>>>>>> +         * Case 2:
>>>>>> +         * The *server* side of this connect is VM, *server* trie=
s
>>>>>> to close
>>>>>> +         * the connection.
>>>>>> +         *
>>>>>> +         * We got 'ack=3D1' packets from server side, it acks
>>>>>> 'fin=3D1, ack=3D1'
>>>>>> +         * packet from client side. Like Case 1, there should be
>>>>>> no packets
>>>>>> +         * in the connection from now know, But the difference
>>>>>> here is
>>>>>> +         * if the packet is lost, We will get the resent
>>>>>> 'fin=3D1,ack=3D1' packet.
>>>>>> +         * TODO: Fix above case.
>>>>>> +         */
>>>>>> +        if ((conn->tcp_state =3D=3D TCPS_LAST_ACK) &&
>>>>>> +            (ntohl(tcp_pkt->th_ack) =3D=3D (conn->fin_ack_seq + 1=
))) {
>>>>>> + g_hash_table_remove(rf->connection_track_table, key);
>>>>>> +        }
>>>>>> +    }
>>>>>> +    /*
>>>>>> +     * Case 1:
>>>>>> +     * The *server* side of this connect is VM, *client* tries to
>>>>>> close
>>>>>> +     * the connection.
>>>>>> +     *
>>>>>> +     * We got 'fin=3D1, ack=3D1' packet from server side, we need=
 to
>>>>>> +     * record the seq of 'fin=3D1, ack=3D1' packet.
>>>>>> +     */
>>>>>> +    if ((tcp_pkt->th_flags & (TH_ACK | TH_FIN)) =3D=3D (TH_ACK |
>>>>>> TH_FIN)) {
>>>>>> +        conn->fin_ack_seq =3D ntohl(tcp_pkt->th_seq);
>>>>>> +        conn->tcp_state =3D TCPS_LAST_ACK;
>>>>>
>>>>> I thought the tcp_state should store the state of TCP from the=20
>>>>> view of
>>>>> secondary VM? So TCPS_LAST_ACK is wrong and bring lots of confusion=
.
>>>>> And
>>>>> the handle of active close needs more states here. E.g if=20
>>>>> connection is
>>>>> in FIN_WAIT_2, the connection is only half closed, remote peer can
>>>>> still
>>>>> send packet to us unless we receive a FIN.
>>>>>
>>>>
>>>> Yes, i know what you mean, actually, here, we try to only track the=20
>>>> last
>>>> two steps for closing a connection, that is=20
>>>> 'fin=3D1,ack=3D1,seq=3D2,ack=3Du+1'
>>>                                               ^
>>> 'FIN=3D1,ACK=3D1,seq=3Dw,ack=3Du+1'
>>>
>>>> and 'ack=3D1,seq=3Du+1,ack=3Dw+1', because if we get a 'fin=3D1,ack=3D=
1', we can
>>>       ^ 'ACK=3D1,seq=3Du+1,ack=3Dw+1'                     ^ 'FIN=3D1=EF=
=BC=8CACK=3D1'
>>>
>>>> ensure that the 'fin=3D1,seq=3Du' packet has been posted.
>>>>
>>>                    ^ 'FIN=3D1,seq=3Du'
>>
>> That's just the case I'm saying, the transition above is in fact:
>>
>> secondary(ESTABLISHED)
>> secondary(FIN_WAIT_1): ->  FIN,seq=3Dw,ack=3Du+1   -> :remote
>> secondary(FIN_WAIT_2): <-  seq=3Du+1,ack=3Dw+1     <- :remote
>>
>> So we are in fact in FIN_WAIT_2, which means the connection is only ha=
lf
>> closed, but your patch will treat this as fully closed connection and
>> will remove the connection from the hashtable.
>>
>
> Er, here we track the last two states 'FIN=3D1, ACK=3D1' and  'ACK=3D1'=
 (=20
> which asks
> the 'FIN=3D1,ACK=3D1' packet, We will remove the connection while got t=
he=20
> 'ACK=3D1'
> packet, so  is it enough ?

But the connection is not closed in fact, no? It's legal for remote to=20
continue sending tons of packet to us even after this.

>
>> What's more I don't think we can decide passive or active close by:
>>
>>
>> +    if ((tcp_pkt->th_flags & (TH_ACK | TH_FIN)) =3D=3D (TH_ACK | TH_F=
IN)) {
>>
>> Since both cases will send FIN,ACK for sure.
>>
>
> I didn't quite understand, here we have tracked the closing request no=20
> matter
> it is from the server side (passive close ?) or client side ( active=20
> close ?).
> You can refer to the comment in codes, 'Case 1' and 'Case 2' comments.

I think you need differ them since passive close is much simpler, and it=20
seems that your code may work only in this case.

>
> Here, it seems that we can't track one case which both sides send the=20
> closing
> requests at the same time, in that case, there are only 'FIN=3D1' and=20
> 'ACK=3D1'
> packets.
>

Yes, RFC allows this.

Thanks

>
> Thanks.
> Hailiang
>
>>>
>>>> Another reason is we may can't track the 'fin=3D1,seq=3Du' packet wh=
ile
>>>> we start COLO while one connection is closing, which the
>>>> 'fin=3D1,seq=3Du' packet
>>>> has been posted.
>>>>
>>>> Actually, here, if we start COLO while one connection is closing,
>>>> which the
>>>> 'fin=3D1,ack=3D1' has been posted, we can only track 'ack=3D1' packe=
t. In=20
>>>> this
>>>
>>>   ^ 'FIN=3D1,ACK=3D1'
>>>
>>> Sorry for the typo. :)
>>>
>>>> case, the connection will be left in hash table for ever though it i=
s
>>>> harmless.
>>>> Any ideas for this case ?
>>
>> Sorry I don't follow the question.
>>
>>>>
>>>> For the above codes question, i'd like to change tcp_state to
>>>> tap_closing_wait,
>>>> is it OK ?
>>
>> You mean "tcp_closing_wait". I think we need first figure out if we ca=
n
>> track the state correctly first.
>>
>> Thanks
>>
>>>>
>>>> Thanks.
>>>> Hailiang
>>>>
>>>>> Thanks
>>>>>
>>>>>>          }
>>>>>> -
>>>>>>          return 0;
>>>>>>      }
>>>>>>
>>>>>> @@ -178,7 +234,7 @@ static ssize_t
>>>>>> colo_rewriter_receive_iov(NetFilterState *nf,
>>>>>>
>>>>>>              if (sender =3D=3D nf->netdev) {
>>>>>>                  /* NET_FILTER_DIRECTION_TX */
>>>>>> -            if (!handle_primary_tcp_pkt(nf, conn, pkt)) {
>>>>>> +            if (!handle_primary_tcp_pkt(s, conn, pkt, &key)) {
>>>>>> qemu_net_queue_send(s->incoming_queue, sender, 0,
>>>>>>                      (const uint8_t *)pkt->data, pkt->size, NULL);
>>>>>>                      packet_destroy(pkt, NULL);
>>>>>> @@ -191,7 +247,7 @@ static ssize_t
>>>>>> colo_rewriter_receive_iov(NetFilterState *nf,
>>>>>>                  }
>>>>>>              } else {
>>>>>>                  /* NET_FILTER_DIRECTION_RX */
>>>>>> -            if (!handle_secondary_tcp_pkt(nf, conn, pkt)) {
>>>>>> +            if (!handle_secondary_tcp_pkt(s, conn, pkt, &key)) {
>>>>>> qemu_net_queue_send(s->incoming_queue, sender, 0,
>>>>>>                      (const uint8_t *)pkt->data, pkt->size, NULL);
>>>>>>                      packet_destroy(pkt, NULL);
>>>>>
>>>>>
>>>>> .
>>>>>
>>>
>>>
>>
>>
>> .
>>
>
