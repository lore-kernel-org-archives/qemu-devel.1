Received: from eggs.gnu.org ([2001:4830:134:3::10]:59419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fPiOy-0005Wg-UW
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 01:51:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fPiOv-0005IO-0g
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 01:51:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42286 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fPiOu-0005Ht-RJ
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 01:51:28 -0400
References: <20180603050546.6827-1-zhangckid@gmail.com>
	<20180603050546.6827-2-zhangckid@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f6951f5c-4005-78b3-cd22-738a89829df9@redhat.com>
Date: Mon, 4 Jun 2018 13:51:19 +0800
MIME-Version: 1.0
In-Reply-To: <20180603050546.6827-2-zhangckid@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V8 01/17] filter-rewriter: fix memory leak
 for connection in connection_track_table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>



On 2018=E5=B9=B406=E6=9C=8803=E6=97=A5 13:05, Zhang Chen wrote:
> After a net connection is closed, we didn't clear its releated resource=
s
> in connection_track_table, which will lead to memory leak.
>
> Let't track the state of net connection, if it is closed, its related
> resources will be cleared up.
>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>   net/colo.h            |  4 +++
>   net/filter-rewriter.c | 69 ++++++++++++++++++++++++++++++++++++++----=
-
>   2 files changed, 66 insertions(+), 7 deletions(-)
>
> diff --git a/net/colo.h b/net/colo.h
> index da6c36dcf7..cd118510c5 100644
> --- a/net/colo.h
> +++ b/net/colo.h
> @@ -18,6 +18,7 @@
>   #include "slirp/slirp.h"
>   #include "qemu/jhash.h"
>   #include "qemu/timer.h"
> +#include "slirp/tcp.h"
>  =20
>   #define HASHTABLE_MAX_SIZE 16384
>  =20
> @@ -86,6 +87,9 @@ typedef struct Connection {
>        * run once in independent tcp connection
>        */
>       int syn_flag;
> +
> +    int tcp_state; /* TCP FSM state */
> +    tcp_seq fin_ack_seq; /* the seq of 'fin=3D1,ack=3D1' */

So the question is, the state machine is not complete. I suspect there=20
will be corner cases that will be left because of lacking sufficient=20
states. LAST_ACK happens only for passive close. How about active close?

So I think we need either maintain a full state machine or not instead=20
of a partial one. We don't want endless bugs.

Thanks

>   } Connection;
>  =20
>   uint32_t connection_key_hash(const void *opaque);
> diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
> index 62dad2d773..0909a9a8af 100644
> --- a/net/filter-rewriter.c
> +++ b/net/filter-rewriter.c
> @@ -59,9 +59,9 @@ static int is_tcp_packet(Packet *pkt)
>   }
>  =20
>   /* handle tcp packet from primary guest */
> -static int handle_primary_tcp_pkt(NetFilterState *nf,
> +static int handle_primary_tcp_pkt(RewriterState *rf,
>                                     Connection *conn,
> -                                  Packet *pkt)
> +                                  Packet *pkt, ConnectionKey *key)
>   {
>       struct tcphdr *tcp_pkt;
>  =20
> @@ -99,15 +99,44 @@ static int handle_primary_tcp_pkt(NetFilterState *n=
f,
>               net_checksum_calculate((uint8_t *)pkt->data + pkt->vnet_h=
dr_len,
>                                      pkt->size - pkt->vnet_hdr_len);
>           }
> +        /*
> +         * Case 1:
> +         * The *server* side of this connect is VM, *client* tries to =
close
> +         * the connection.
> +         *
> +         * We got 'ack=3D1' packets from client side, it acks 'fin=3D1=
, ack=3D1'
> +         * packet from server side. From this point, we can ensure tha=
t there
> +         * will be no packets in the connection, except that, some err=
ors
> +         * happen between the path of 'filter object' and vNIC, if thi=
s rare
> +         * case really happen, we can still create a new connection,
> +         * So it is safe to remove the connection from connection_trac=
k_table.
> +         *
> +         */
> +        if ((conn->tcp_state =3D=3D TCPS_LAST_ACK) &&
> +            (ntohl(tcp_pkt->th_ack) =3D=3D (conn->fin_ack_seq + 1))) {
> +            g_hash_table_remove(rf->connection_track_table, key);
> +        }
> +    }
> +    /*
> +     * Case 2:
> +     * The *server* side of this connect is VM, *server* tries to clos=
e
> +     * the connection.
> +     *
> +     * We got 'fin=3D1, ack=3D1' packet from client side, we need to
> +     * record the seq of 'fin=3D1, ack=3D1' packet.
> +     */
> +    if ((tcp_pkt->th_flags & (TH_ACK | TH_FIN)) =3D=3D (TH_ACK | TH_FI=
N)) {
> +        conn->fin_ack_seq =3D htonl(tcp_pkt->th_seq);
> +        conn->tcp_state =3D TCPS_LAST_ACK;
>       }
>  =20
>       return 0;
>   }
>  =20
>   /* handle tcp packet from secondary guest */
> -static int handle_secondary_tcp_pkt(NetFilterState *nf,
> +static int handle_secondary_tcp_pkt(RewriterState *rf,
>                                       Connection *conn,
> -                                    Packet *pkt)
> +                                    Packet *pkt, ConnectionKey *key)
>   {
>       struct tcphdr *tcp_pkt;
>  =20
> @@ -139,8 +168,34 @@ static int handle_secondary_tcp_pkt(NetFilterState=
 *nf,
>               net_checksum_calculate((uint8_t *)pkt->data + pkt->vnet_h=
dr_len,
>                                      pkt->size - pkt->vnet_hdr_len);
>           }
> +        /*
> +         * Case 2:
> +         * The *server* side of this connect is VM, *server* tries to =
close
> +         * the connection.
> +         *
> +         * We got 'ack=3D1' packets from server side, it acks 'fin=3D1=
, ack=3D1'
> +         * packet from client side. Like Case 1, there should be no pa=
ckets
> +         * in the connection from now know, But the difference here is
> +         * if the packet is lost, We will get the resent 'fin=3D1,ack=3D=
1' packet.
> +         * TODO: Fix above case.
> +         */
> +        if ((conn->tcp_state =3D=3D TCPS_LAST_ACK) &&
> +            (ntohl(tcp_pkt->th_ack) =3D=3D (conn->fin_ack_seq + 1))) {
> +            g_hash_table_remove(rf->connection_track_table, key);
> +        }
> +    }
> +    /*
> +     * Case 1:
> +     * The *server* side of this connect is VM, *client* tries to clos=
e
> +     * the connection.
> +     *
> +     * We got 'fin=3D1, ack=3D1' packet from server side, we need to
> +     * record the seq of 'fin=3D1, ack=3D1' packet.
> +     */
> +    if ((tcp_pkt->th_flags & (TH_ACK | TH_FIN)) =3D=3D (TH_ACK | TH_FI=
N)) {
> +        conn->fin_ack_seq =3D ntohl(tcp_pkt->th_seq);
> +        conn->tcp_state =3D TCPS_LAST_ACK;
>       }
> -
>       return 0;
>   }
>  =20
> @@ -190,7 +245,7 @@ static ssize_t colo_rewriter_receive_iov(NetFilterS=
tate *nf,
>  =20
>           if (sender =3D=3D nf->netdev) {
>               /* NET_FILTER_DIRECTION_TX */
> -            if (!handle_primary_tcp_pkt(nf, conn, pkt)) {
> +            if (!handle_primary_tcp_pkt(s, conn, pkt, &key)) {
>                   qemu_net_queue_send(s->incoming_queue, sender, 0,
>                   (const uint8_t *)pkt->data, pkt->size, NULL);
>                   packet_destroy(pkt, NULL);
> @@ -203,7 +258,7 @@ static ssize_t colo_rewriter_receive_iov(NetFilterS=
tate *nf,
>               }
>           } else {
>               /* NET_FILTER_DIRECTION_RX */
> -            if (!handle_secondary_tcp_pkt(nf, conn, pkt)) {
> +            if (!handle_secondary_tcp_pkt(s, conn, pkt, &key)) {
>                   qemu_net_queue_send(s->incoming_queue, sender, 0,
>                   (const uint8_t *)pkt->data, pkt->size, NULL);
>                   packet_destroy(pkt, NULL);
