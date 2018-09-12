Received: from eggs.gnu.org ([2001:4830:134:3::10]:36411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fzzhl-0004gZ-84
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 03:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fzzhh-0003E9-SQ
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 03:36:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41142 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fzzhh-0003AA-Kt
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 03:36:49 -0400
References: <20180903043900.28592-1-zhangckid@gmail.com>
	<20180903043900.28592-2-zhangckid@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <88bb118b-7838-c276-f04b-b5b795be964b@redhat.com>
Date: Wed, 12 Sep 2018 15:36:40 +0800
MIME-Version: 1.0
In-Reply-To: <20180903043900.28592-2-zhangckid@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V12 01/19] filter-rewriter: Add TCP state
 machine and fix memory leak in connection_track_table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <chen.zhang@intel.com>



On 2018=E5=B9=B409=E6=9C=8803=E6=97=A5 12:38, Zhang Chen wrote:
> We add almost full TCP state machine in filter-rewriter, except
> TCPS_LISTEN and some simplify in VM active close FIN states.

Need to explain why it can be simplified.

>
> After a net connection is closed, we didn't clear its releated resource=
s
> in connection_track_table, which will lead to memory leak.
>
> Let't track the state of net connection, if it is closed, its related
> resources will be cleared up.
>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>   net/colo.c            |   2 +-
>   net/colo.h            |   9 ++--
>   net/filter-rewriter.c | 105 ++++++++++++++++++++++++++++++++++++++---=
-
>   3 files changed, 100 insertions(+), 16 deletions(-)
>
> diff --git a/net/colo.c b/net/colo.c
> index 6dda4ed66e..97c8fc928f 100644
> --- a/net/colo.c
> +++ b/net/colo.c
> @@ -137,7 +137,7 @@ Connection *connection_new(ConnectionKey *key)
>       conn->ip_proto =3D key->ip_proto;
>       conn->processing =3D false;
>       conn->offset =3D 0;
> -    conn->syn_flag =3D 0;
> +    conn->tcp_state =3D TCPS_CLOSED;
>       conn->pack =3D 0;
>       conn->sack =3D 0;
>       g_queue_init(&conn->primary_list);
> diff --git a/net/colo.h b/net/colo.h
> index da6c36dcf7..0277e0e9ba 100644
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
> @@ -81,11 +82,9 @@ typedef struct Connection {
>       uint32_t sack;
>       /* offset =3D secondary_seq - primary_seq */
>       tcp_seq  offset;
> -    /*
> -     * we use this flag update offset func
> -     * run once in independent tcp connection
> -     */
> -    int syn_flag;
> +
> +    int tcp_state; /* TCP FSM state */
> +    tcp_seq fin_ack_seq; /* the seq of 'fin=3D1,ack=3D1' */
>   } Connection;
>  =20
>   uint32_t connection_key_hash(const void *opaque);
> diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
> index f584e4eba4..f18a71bf2e 100644
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
> @@ -74,23 +74,28 @@ static int handle_primary_tcp_pkt(NetFilterState *n=
f,
>           trace_colo_filter_rewriter_conn_offset(conn->offset);
>       }
>  =20
> +    if (((tcp_pkt->th_flags & (TH_ACK | TH_SYN)) =3D=3D (TH_ACK | TH_S=
YN)) &&
> +        conn->tcp_state =3D=3D TCPS_SYN_SENT) {
> +        conn->tcp_state =3D TCPS_ESTABLISHED;
> +    }
> +
>       if (((tcp_pkt->th_flags & (TH_ACK | TH_SYN)) =3D=3D TH_SYN)) {
>           /*
>            * we use this flag update offset func
>            * run once in independent tcp connection
>            */
> -        conn->syn_flag =3D 1;
> +        conn->tcp_state =3D TCPS_SYN_RECEIVED;
>       }
>  =20
>       if (((tcp_pkt->th_flags & (TH_ACK | TH_SYN)) =3D=3D TH_ACK)) {
> -        if (conn->syn_flag) {
> +        if (conn->tcp_state =3D=3D TCPS_SYN_RECEIVED) {
>               /*
>                * offset =3D secondary_seq - primary seq
>                * ack packet sent by guest from primary node,
>                * so we use th_ack - 1 get primary_seq
>                */
>               conn->offset -=3D (ntohl(tcp_pkt->th_ack) - 1);
> -            conn->syn_flag =3D 0;
> +            conn->tcp_state =3D TCPS_ESTABLISHED;
>           }
>           if (conn->offset) {
>               /* handle packets to the secondary from the primary */
> @@ -99,15 +104,63 @@ static int handle_primary_tcp_pkt(NetFilterState *=
nf,
>               net_checksum_calculate((uint8_t *)pkt->data + pkt->vnet_h=
dr_len,
>                                      pkt->size - pkt->vnet_hdr_len);
>           }
> +        /*
> +         * Case 1:
> +         * Step 3:

Better have gathered comment instead of several scattered ones. This=20
will make the code much more easier to be read.

> +         * The *server* side of this connect is VM, *client* tries to =
close
> +         * the connection.

Better use "passive close" here since:

- Server can active close the connection
- TCP allows distributed computing which does not differ much between=20
server and client.

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
> +            conn->tcp_state =3D TCPS_CLOSED;
> +            g_hash_table_remove(rf->connection_track_table, key);
> +        }
> +    }
> +
> +    if ((tcp_pkt->th_flags & TH_FIN) =3D=3D TH_FIN) {
> +        /*
> +         * Case 1:
> +         * Step 1:
> +         * The *server* side of this connect is VM, *client* tries to =
close
> +         * the connection. We will into CLOSE_WAIT status.
> +         */
> +        if (conn->tcp_state =3D=3D TCPS_ESTABLISHED) {
> +            conn->tcp_state =3D TCPS_CLOSE_WAIT;
> +        }
> +
> +        /*
> +         * Case 2:
> +         * Step 2:
> +         * The *server* side of this connect is VM, *server* tries to =
close
> +         * the connection. We will into CLOSE_WAIT status.
> +         * We simplify the TCPS_FIN_WAIT_2, TCPS_TIME_WAIT and CLOSING=
 status.
> +         */

Better explain why you can do the simplification. E.g what happens if=20
packets

> +        if (conn->tcp_state =3D=3D TCPS_FIN_WAIT_1) {
> +            conn->tcp_state =3D TCPS_TIME_WAIT;
> +            /*
> +             * For simplify implementation, we needn't wait 2MSL time
> +             * in filter rewriter.
> +             */
> +            conn->tcp_state =3D TCPS_CLOSED;
> +            g_hash_table_remove(rf->connection_track_table, key);
> +        }
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
> @@ -121,7 +174,8 @@ static int handle_secondary_tcp_pkt(NetFilterState =
*nf,
>           trace_colo_filter_rewriter_conn_offset(conn->offset);
>       }
>  =20
> -    if (((tcp_pkt->th_flags & (TH_ACK | TH_SYN)) =3D=3D (TH_ACK | TH_S=
YN))) {
> +    if (conn->tcp_state =3D=3D TCPS_SYN_RECEIVED &&
> +        ((tcp_pkt->th_flags & (TH_ACK | TH_SYN)) =3D=3D (TH_ACK | TH_S=
YN))) {
>           /*
>            * save offset =3D secondary_seq and then
>            * in handle_primary_tcp_pkt make offset
> @@ -130,6 +184,12 @@ static int handle_secondary_tcp_pkt(NetFilterState=
 *nf,
>           conn->offset =3D ntohl(tcp_pkt->th_seq);
>       }
>  =20
> +    /* VM active connect */
> +    if (conn->tcp_state =3D=3D TCPS_CLOSED &&
> +        ((tcp_pkt->th_flags & (TH_ACK | TH_SYN)) =3D=3D TH_SYN)) {
> +        conn->tcp_state =3D TCPS_SYN_SENT;
> +    }
> +
>       if ((tcp_pkt->th_flags & (TH_ACK | TH_SYN)) =3D=3D TH_ACK) {
>           /* Only need to adjust seq while offset is Non-zero */
>           if (conn->offset) {
> @@ -140,6 +200,31 @@ static int handle_secondary_tcp_pkt(NetFilterState=
 *nf,
>                                      pkt->size - pkt->vnet_hdr_len);
>           }
>       }
> +    /*
> +     * Case 1:
> +     * Step 2:
> +     * The *server* side of this connect is VM, *client* tries to clos=
e
> +     * the connection. In this step we will into LAST_ACK status.
> +     *
> +     * We got 'fin=3D1, ack=3D1' packet from server side, we need to
> +     * record the seq of 'fin=3D1, ack=3D1' packet.
> +     */
> +    if (conn->tcp_state =3D=3D TCPS_CLOSE_WAIT &&
> +        (tcp_pkt->th_flags & (TH_ACK | TH_FIN)) =3D=3D (TH_ACK | TH_FI=
N)) {
> +        conn->fin_ack_seq =3D ntohl(tcp_pkt->th_seq);
> +        conn->tcp_state =3D TCPS_LAST_ACK;
> +    }
> +
> +    /*
> +     * Case 2:
> +     * Step 1:
> +     * The *server* side of this connect is VM, *server* tries to clos=
e
> +     * the connection.
> +     */
> +    if (conn->tcp_state =3D=3D TCPS_ESTABLISHED &&
> +        (tcp_pkt->th_flags & (TH_ACK | TH_FIN)) =3D=3D TH_FIN) {
> +        conn->tcp_state =3D TCPS_FIN_WAIT_1;
> +    }
>  =20
>       return 0;
>   }
> @@ -190,7 +275,7 @@ static ssize_t colo_rewriter_receive_iov(NetFilterS=
tate *nf,
>  =20
>           if (sender =3D=3D nf->netdev) {
>               /* NET_FILTER_DIRECTION_TX */
> -            if (!handle_primary_tcp_pkt(nf, conn, pkt)) {
> +            if (!handle_primary_tcp_pkt(s, conn, pkt, &key)) {
>                   qemu_net_queue_send(s->incoming_queue, sender, 0,
>                   (const uint8_t *)pkt->data, pkt->size, NULL);
>                   packet_destroy(pkt, NULL);
> @@ -203,7 +288,7 @@ static ssize_t colo_rewriter_receive_iov(NetFilterS=
tate *nf,
>               }
>           } else {
>               /* NET_FILTER_DIRECTION_RX */
> -            if (!handle_secondary_tcp_pkt(nf, conn, pkt)) {
> +            if (!handle_secondary_tcp_pkt(s, conn, pkt, &key)) {
>                   qemu_net_queue_send(s->incoming_queue, sender, 0,
>                   (const uint8_t *)pkt->data, pkt->size, NULL);
>                   packet_destroy(pkt, NULL);
