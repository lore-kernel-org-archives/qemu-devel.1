Received: from eggs.gnu.org ([2001:4830:134:3::10]:53662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cgkpy-0001HK-Kk
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 23:17:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cgkpv-00072c-CD
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 23:17:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cgkpv-00072S-2h
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 23:16:59 -0500
References: <1487735198-127300-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487735198-127300-3-git-send-email-zhang.zhanghailiang@huawei.com>
	<b0b04c02-7c97-ea04-1e38-99fd9344edae@redhat.com>
	<58AD4F8F.5030703@huawei.com> <58AD5125.4010306@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b792c68e-d67a-ac24-26ea-aaf24f1f9437@redhat.com>
Date: Thu, 23 Feb 2017 12:16:50 +0800
MIME-Version: 1.0
In-Reply-To: <58AD5125.4010306@huawei.com>
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



On 2017=E5=B9=B402=E6=9C=8822=E6=97=A5 16:51, Hailiang Zhang wrote:
> On 2017/2/22 16:45, Hailiang Zhang wrote:
>> On 2017/2/22 16:07, Jason Wang wrote:
>>>
>>>
>>> On 2017=E5=B9=B402=E6=9C=8822=E6=97=A5 11:46, zhanghailiang wrote:
>>>> After a net connection is closed, we didn't clear its releated=20
>>>> resources
>>>> in connection_track_table, which will lead to memory leak.
>>>
>>> Not a real leak but would lead reset of hash table if too many closed
>>> connections.
>>>
>>
>> Yes, you are right, there will be lots of stale connection data in=20
>> hash table
>> if we don't remove it while it is been closed. Which


Ok, so let's come up with a better title of the patch.

>>
>>>>
>>>> Let't track the state of net connection, if it is closed, its relate=
d
>>>> resources will be cleared up.
>>>
>>> The issue is the state were tracked partially, do we need a full stat=
e
>>> machine here?
>>>
>>
>> Not, IMHO, we only care about the last state of it, because, we will=20
>> do nothing
>> even if we track the intermedial states.

Well, you care at least syn state too. Without a complete state machine,=20
it's very hard to track even partial state I believe. And you will fail=20
to track some state transition for sure which makes the code fragile.

>>
>>>>
>>>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>>>> ---
>>>>     net/colo.h            |  4 +++
>>>>     net/filter-rewriter.c | 70=20
>>>> +++++++++++++++++++++++++++++++++++++++++++++------
>>>>     2 files changed, 67 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/net/colo.h b/net/colo.h
>>>> index 7c524f3..cd9027f 100644
>>>> --- a/net/colo.h
>>>> +++ b/net/colo.h
>>>> @@ -18,6 +18,7 @@
>>>>     #include "slirp/slirp.h"
>>>>     #include "qemu/jhash.h"
>>>>     #include "qemu/timer.h"
>>>> +#include "slirp/tcp.h"
>>>>
>>>>     #define HASHTABLE_MAX_SIZE 16384
>>>>
>>>> @@ -69,6 +70,9 @@ typedef struct Connection {
>>>>          * run once in independent tcp connection
>>>>          */
>>>>         int syn_flag;
>>>> +
>>>> +    int tcp_state; /* TCP FSM state */
>>>> +    tcp_seq fin_ack_seq; /* the seq of 'fin=3D1,ack=3D1' */
>>>>     } Connection;
>>>>
>>>>     uint32_t connection_key_hash(const void *opaque);
>>>> diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
>>>> index c4ab91c..7e7ec35 100644
>>>> --- a/net/filter-rewriter.c
>>>> +++ b/net/filter-rewriter.c
>>>> @@ -60,9 +60,9 @@ static int is_tcp_packet(Packet *pkt)
>>>>     }
>>>>
>>>>     /* handle tcp packet from primary guest */
>>>> -static int handle_primary_tcp_pkt(NetFilterState *nf,
>>>> +static int handle_primary_tcp_pkt(RewriterState *rf,
>>>>                                       Connection *conn,
>>>> -                                  Packet *pkt)
>>>> +                                  Packet *pkt, ConnectionKey *key)
>>>>     {
>>>>         struct tcphdr *tcp_pkt;
>>>>
>>>> @@ -97,15 +97,45 @@ static int=20
>>>> handle_primary_tcp_pkt(NetFilterState *nf,
>>>>             tcp_pkt->th_ack =3D htonl(ntohl(tcp_pkt->th_ack) +=20
>>>> conn->offset);
>>>>
>>>>             net_checksum_calculate((uint8_t *)pkt->data, pkt->size);
>>>> +        /*
>>>> +         * Case 1:
>>>> +         * The *server* side of this connect is VM, *client* tries=20
>>>> to close
>>>> +         * the connection.
>>>> +         *
>>>> +         * We got 'ack=3D1' packets from client side, it acks=20
>>>> 'fin=3D1, ack=3D1'
>>>> +         * packet from server side. From this point, we can ensure=20
>>>> that there
>>>> +         * will be no packets in the connection, except that, some=20
>>>> errors
>>>> +         * happen between the path of 'filter object' and vNIC, if=20
>>>> this rare
>>>> +         * case really happen, we can still create a new connection=
,
>>>> +         * So it is safe to remove the connection from=20
>>>> connection_track_table.
>>>> +         *
>>>> +         */
>>>> +        if ((conn->tcp_state =3D=3D TCPS_LAST_ACK) &&
>>>> +            (ntohl(tcp_pkt->th_ack) =3D=3D (conn->fin_ack_seq + 1))=
) {
>>>> +            fprintf(stderr, "Remove conn "
>>>
>>> Can this even compile?
>>>
>>
>> Oops, i forgot to remove it, will remove it in next version.
>>
>>>> + g_hash_table_remove(rf->connection_track_table, key);
>>>> +        }
>>>> +    }
>>>> +    /*
>>>> +     * Case 2:
>>>> +     * The *server* side of this connect is VM, *server* tries to=20
>>>> close
>>>> +     * the connection.
>>>> +     *
>>>> +     * We got 'fin=3D1, ack=3D1' packet from client side, we need t=
o
>>>> +     * record the seq of 'fin=3D1, ack=3D1' packet.
>>>> +     */
>>>> +    if ((tcp_pkt->th_flags & (TH_ACK | TH_FIN)) =3D=3D (TH_ACK |=20
>>>> TH_FIN)) {
>>>> +        conn->fin_ack_seq =3D htonl(tcp_pkt->th_seq);
>>>> +        conn->tcp_state =3D TCPS_LAST_ACK;
>>>>         }
>>>>
>>>>         return 0;
>>>>     }
>>>>
>>>>     /* handle tcp packet from secondary guest */
>>>> -static int handle_secondary_tcp_pkt(NetFilterState *nf,
>>>> +static int handle_secondary_tcp_pkt(RewriterState *rf,
>>>>                                         Connection *conn,
>>>> -                                    Packet *pkt)
>>>> +                                    Packet *pkt, ConnectionKey *key=
)
>>>>     {
>>>>         struct tcphdr *tcp_pkt;
>>>>
>>>> @@ -133,8 +163,34 @@ static int=20
>>>> handle_secondary_tcp_pkt(NetFilterState *nf,
>>>>             tcp_pkt->th_seq =3D htonl(ntohl(tcp_pkt->th_seq) -=20
>>>> conn->offset);
>>>>
>>>>             net_checksum_calculate((uint8_t *)pkt->data, pkt->size);
>>>> +        /*
>>>> +         * Case 2:
>>>> +         * The *server* side of this connect is VM, *server* tries=20
>>>> to close
>>>> +         * the connection.
>>>> +         *
>>>> +         * We got 'ack=3D1' packets from server side, it acks=20
>>>> 'fin=3D1, ack=3D1'
>>>> +         * packet from client side. Like Case 1, there should be=20
>>>> no packets
>>>> +         * in the connection from now know, But the difference=20
>>>> here is
>>>> +         * if the packet is lost, We will get the resent=20
>>>> 'fin=3D1,ack=3D1' packet.
>>>> +         * TODO: Fix above case.
>>>> +         */
>>>> +        if ((conn->tcp_state =3D=3D TCPS_LAST_ACK) &&
>>>> +            (ntohl(tcp_pkt->th_ack) =3D=3D (conn->fin_ack_seq + 1))=
) {
>>>> + g_hash_table_remove(rf->connection_track_table, key);
>>>> +        }
>>>> +    }
>>>> +    /*
>>>> +     * Case 1:
>>>> +     * The *server* side of this connect is VM, *client* tries to=20
>>>> close
>>>> +     * the connection.
>>>> +     *
>>>> +     * We got 'fin=3D1, ack=3D1' packet from server side, we need t=
o
>>>> +     * record the seq of 'fin=3D1, ack=3D1' packet.
>>>> +     */
>>>> +    if ((tcp_pkt->th_flags & (TH_ACK | TH_FIN)) =3D=3D (TH_ACK |=20
>>>> TH_FIN)) {
>>>> +        conn->fin_ack_seq =3D ntohl(tcp_pkt->th_seq);
>>>> +        conn->tcp_state =3D TCPS_LAST_ACK;
>>>
>>> I thought the tcp_state should store the state of TCP from the view o=
f
>>> secondary VM? So TCPS_LAST_ACK is wrong and bring lots of confusion.=20
>>> And
>>> the handle of active close needs more states here. E.g if connection =
is
>>> in FIN_WAIT_2, the connection is only half closed, remote peer can=20
>>> still
>>> send packet to us unless we receive a FIN.
>>>
>>
>> Yes, i know what you mean, actually, here, we try to only track the la=
st
>> two steps for closing a connection, that is 'fin=3D1,ack=3D1,seq=3D2,a=
ck=3Du+1'
>                                              ^=20
> 'FIN=3D1,ACK=3D1,seq=3Dw,ack=3Du+1'
>
>> and 'ack=3D1,seq=3Du+1,ack=3Dw+1', because if we get a 'fin=3D1,ack=3D=
1', we can
>      ^ 'ACK=3D1,seq=3Du+1,ack=3Dw+1'                     ^ 'FIN=3D1=EF=BC=
=8CACK=3D1'
>
>> ensure that the 'fin=3D1,seq=3Du' packet has been posted.
>>
>                   ^ 'FIN=3D1,seq=3Du'

That's just the case I'm saying, the transition above is in fact:

secondary(ESTABLISHED)
secondary(FIN_WAIT_1): ->  FIN,seq=3Dw,ack=3Du+1   -> :remote
secondary(FIN_WAIT_2): <-  seq=3Du+1,ack=3Dw+1     <- :remote

So we are in fact in FIN_WAIT_2, which means the connection is only half=20
closed, but your patch will treat this as fully closed connection and=20
will remove the connection from the hashtable.

What's more I don't think we can decide passive or active close by:


+    if ((tcp_pkt->th_flags & (TH_ACK | TH_FIN)) =3D=3D (TH_ACK | TH_FIN)=
) {

Since both cases will send FIN,ACK for sure.

>
>> Another reason is we may can't track the 'fin=3D1,seq=3Du' packet whil=
e
>> we start COLO while one connection is closing, which the=20
>> 'fin=3D1,seq=3Du' packet
>> has been posted.
>>
>> Actually, here, if we start COLO while one connection is closing,=20
>> which the
>> 'fin=3D1,ack=3D1' has been posted, we can only track 'ack=3D1' packet.=
 In this
>
>  ^ 'FIN=3D1,ACK=3D1'
>
> Sorry for the typo. :)
>
>> case, the connection will be left in hash table for ever though it is=20
>> harmless.
>> Any ideas for this case ?

Sorry I don't follow the question.

>>
>> For the above codes question, i'd like to change tcp_state to=20
>> tap_closing_wait,
>> is it OK ?

You mean "tcp_closing_wait". I think we need first figure out if we can=20
track the state correctly first.

Thanks

>>
>> Thanks.
>> Hailiang
>>
>>> Thanks
>>>
>>>>         }
>>>> -
>>>>         return 0;
>>>>     }
>>>>
>>>> @@ -178,7 +234,7 @@ static ssize_t=20
>>>> colo_rewriter_receive_iov(NetFilterState *nf,
>>>>
>>>>             if (sender =3D=3D nf->netdev) {
>>>>                 /* NET_FILTER_DIRECTION_TX */
>>>> -            if (!handle_primary_tcp_pkt(nf, conn, pkt)) {
>>>> +            if (!handle_primary_tcp_pkt(s, conn, pkt, &key)) {
>>>> qemu_net_queue_send(s->incoming_queue, sender, 0,
>>>>                     (const uint8_t *)pkt->data, pkt->size, NULL);
>>>>                     packet_destroy(pkt, NULL);
>>>> @@ -191,7 +247,7 @@ static ssize_t=20
>>>> colo_rewriter_receive_iov(NetFilterState *nf,
>>>>                 }
>>>>             } else {
>>>>                 /* NET_FILTER_DIRECTION_RX */
>>>> -            if (!handle_secondary_tcp_pkt(nf, conn, pkt)) {
>>>> +            if (!handle_secondary_tcp_pkt(s, conn, pkt, &key)) {
>>>> qemu_net_queue_send(s->incoming_queue, sender, 0,
>>>>                     (const uint8_t *)pkt->data, pkt->size, NULL);
>>>>                     packet_destroy(pkt, NULL);
>>>
>>>
>>> .
>>>
>
>
