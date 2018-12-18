Received: from eggs.gnu.org ([2001:4830:134:3::10]:40496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQy-00007T-Nq
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQq-0004pB-Ax
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:50 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:41690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZOQh-0004S2-MB
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:39 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:04:20 +0100
Message-Id: <20181218230442.27887-43-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 42/64] net: do not depend on slirp internals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Only slirp/libslirp.h should be included.

Instead of using some slirp declarations and utility functions directly,
let's copy them in net/util.h.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 net/colo-compare.c    | 11 +++++----
 net/colo.c            |  1 +
 net/colo.h            |  7 +++---
 net/filter-rewriter.c |  9 +++----
 net/slirp.c           |  2 +-
 net/util.h            | 55 +++++++++++++++++++++++++++++++++++++++++++
 stubs/slirp.c         |  2 +-
 7 files changed, 72 insertions(+), 15 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 9156ab3349..3e515f3023 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -30,6 +30,7 @@
 #include "net/colo-compare.h"
 #include "migration/colo.h"
 #include "migration/migration.h"
+#include "util.h"
=20
 #define TYPE_COLO_COMPARE "colo-compare"
 #define COLO_COMPARE(obj) \
@@ -129,19 +130,19 @@ static int compare_chr_send(CompareState *s,
=20
 static gint seq_sorter(Packet *a, Packet *b, gpointer data)
 {
-    struct tcphdr *atcp, *btcp;
+    struct tcp_hdr *atcp, *btcp;
=20
-    atcp =3D (struct tcphdr *)(a->transport_header);
-    btcp =3D (struct tcphdr *)(b->transport_header);
+    atcp =3D (struct tcp_hdr *)(a->transport_header);
+    btcp =3D (struct tcp_hdr *)(b->transport_header);
     return ntohl(atcp->th_seq) - ntohl(btcp->th_seq);
 }
=20
 static void fill_pkt_tcp_info(void *data, uint32_t *max_ack)
 {
     Packet *pkt =3D data;
-    struct tcphdr *tcphd;
+    struct tcp_hdr *tcphd;
=20
-    tcphd =3D (struct tcphdr *)pkt->transport_header;
+    tcphd =3D (struct tcp_hdr *)pkt->transport_header;
=20
     pkt->tcp_seq =3D ntohl(tcphd->th_seq);
     pkt->tcp_ack =3D ntohl(tcphd->th_ack);
diff --git a/net/colo.c b/net/colo.c
index 49176bf07b..8196b35837 100644
--- a/net/colo.c
+++ b/net/colo.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
 #include "trace.h"
 #include "colo.h"
+#include "util.h"
=20
 uint32_t connection_key_hash(const void *opaque)
 {
diff --git a/net/colo.h b/net/colo.h
index 11c5226488..b21c6830b5 100644
--- a/net/colo.h
+++ b/net/colo.h
@@ -15,10 +15,9 @@
 #ifndef QEMU_COLO_PROXY_H
 #define QEMU_COLO_PROXY_H
=20
-#include "slirp/slirp.h"
 #include "qemu/jhash.h"
 #include "qemu/timer.h"
-#include "slirp/tcp.h"
+#include "net/eth.h"
=20
 #define HASHTABLE_MAX_SIZE 16384
=20
@@ -81,10 +80,10 @@ typedef struct Connection {
     /* the maximum of acknowledgement number in secondary_list queue */
     uint32_t sack;
     /* offset =3D secondary_seq - primary_seq */
-    tcp_seq  offset;
+    uint32_t  offset;
=20
     int tcp_state; /* TCP FSM state */
-    tcp_seq fin_ack_seq; /* the seq of 'fin=3D1,ack=3D1' */
+    uint32_t fin_ack_seq; /* the seq of 'fin=3D1,ack=3D1' */
 } Connection;
=20
 uint32_t connection_key_hash(const void *opaque);
diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index 2e26839bc2..b464abe5e8 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -22,6 +22,7 @@
 #include "net/checksum.h"
 #include "net/colo.h"
 #include "migration/colo.h"
+#include "util.h"
=20
 #define FILTER_COLO_REWRITER(obj) \
     OBJECT_CHECK(RewriterState, (obj), TYPE_FILTER_REWRITER)
@@ -73,9 +74,9 @@ static int handle_primary_tcp_pkt(RewriterState *rf,
                                   Connection *conn,
                                   Packet *pkt, ConnectionKey *key)
 {
-    struct tcphdr *tcp_pkt;
+    struct tcp_hdr *tcp_pkt;
=20
-    tcp_pkt =3D (struct tcphdr *)pkt->transport_header;
+    tcp_pkt =3D (struct tcp_hdr *)pkt->transport_header;
     if (trace_event_get_state_backends(TRACE_COLO_FILTER_REWRITER_DEBUG)=
) {
         trace_colo_filter_rewriter_pkt_info(__func__,
                     inet_ntoa(pkt->ip->ip_src), inet_ntoa(pkt->ip->ip_ds=
t),
@@ -176,9 +177,9 @@ static int handle_secondary_tcp_pkt(RewriterState *rf=
,
                                     Connection *conn,
                                     Packet *pkt, ConnectionKey *key)
 {
-    struct tcphdr *tcp_pkt;
+    struct tcp_hdr *tcp_pkt;
=20
-    tcp_pkt =3D (struct tcphdr *)pkt->transport_header;
+    tcp_pkt =3D (struct tcp_hdr *)pkt->transport_header;
=20
     if (trace_event_get_state_backends(TRACE_COLO_FILTER_REWRITER_DEBUG)=
) {
         trace_colo_filter_rewriter_pkt_info(__func__,
diff --git a/net/slirp.c b/net/slirp.c
index 00f7306b69..30eda2cca1 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -38,12 +38,12 @@
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
 #include "slirp/libslirp.h"
-#include "slirp/ip6.h"
 #include "chardev/char-fe.h"
 #include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
+#include "util.h"
=20
 static int get_str_sep(char *buf, int buf_size, const char **pp, int sep=
)
 {
diff --git a/net/util.h b/net/util.h
index 60b73d372d..358185fd50 100644
--- a/net/util.h
+++ b/net/util.h
@@ -26,6 +26,61 @@
 #define QEMU_NET_UTIL_H
=20
=20
+/*
+ * Structure of an internet header, naked of options.
+ */
+struct ip {
+#ifdef HOST_WORDS_BIGENDIAN
+    uint8_t ip_v:4,         /* version */
+            ip_hl:4;        /* header length */
+#else
+    uint8_t ip_hl:4,        /* header length */
+            ip_v:4;         /* version */
+#endif
+    uint8_t ip_tos;         /* type of service */
+    uint16_t ip_len;        /* total length */
+    uint16_t ip_id;         /* identification */
+    uint16_t ip_off;        /* fragment offset field */
+#define IP_DF 0x4000        /* don't fragment flag */
+#define IP_MF 0x2000        /* more fragments flag */
+#define IP_OFFMASK 0x1fff   /* mask for fragmenting bits */
+    uint8_t ip_ttl;         /* time to live */
+    uint8_t ip_p;           /* protocol */
+    uint16_t ip_sum;        /* checksum */
+    struct in_addr ip_src, ip_dst;  /* source and dest address */
+} QEMU_PACKED;
+
+static inline bool in6_equal_net(const struct in6_addr *a,
+                                 const struct in6_addr *b,
+                                 int prefix_len)
+{
+    if (memcmp(a, b, prefix_len / 8) !=3D 0) {
+        return 0;
+    }
+
+    if (prefix_len % 8 =3D=3D 0) {
+        return 1;
+    }
+
+    return a->s6_addr[prefix_len / 8] >> (8 - (prefix_len % 8))
+        =3D=3D b->s6_addr[prefix_len / 8] >> (8 - (prefix_len % 8));
+}
+
+#define TCPS_CLOSED             0       /* closed */
+#define TCPS_LISTEN             1       /* listening for connection */
+#define TCPS_SYN_SENT           2       /* active, have sent syn */
+#define TCPS_SYN_RECEIVED       3       /* have send and received syn */
+/* states < TCPS_ESTABLISHED are those where connections not established=
 */
+#define TCPS_ESTABLISHED        4       /* established */
+#define TCPS_CLOSE_WAIT         5       /* rcvd fin, waiting for close *=
/
+/* states > TCPS_CLOSE_WAIT are those where user has closed */
+#define TCPS_FIN_WAIT_1         6       /* have closed, sent fin */
+#define TCPS_CLOSING            7       /* closed xchd FIN; await FIN AC=
K */
+#define TCPS_LAST_ACK           8       /* had fin and close; await FIN =
ACK */
+/* states > TCPS_CLOSE_WAIT && < TCPS_FIN_WAIT_2 await ACK of FIN */
+#define TCPS_FIN_WAIT_2         9       /* have closed, fin is acked */
+#define TCPS_TIME_WAIT          10      /* in 2*msl quiet wait after clo=
se */
+
 int net_parse_macaddr(uint8_t *macaddr, const char *p);
=20
 #endif /* QEMU_NET_UTIL_H */
diff --git a/stubs/slirp.c b/stubs/slirp.c
index 42f7e1afd0..70704346fd 100644
--- a/stubs/slirp.c
+++ b/stubs/slirp.c
@@ -1,7 +1,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/host-utils.h"
-#include "slirp/slirp.h"
+#include "slirp/libslirp.h"
=20
 void slirp_pollfds_fill(GArray *pollfds, uint32_t *timeout)
 {
--=20
2.19.2
