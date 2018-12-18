Received: from eggs.gnu.org ([2001:4830:134:3::10]:40402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQh-0008N1-RX
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQb-0004cG-T4
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:33 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZOQW-0004Ls-Jq
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:27 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:04:14 +0100
Message-Id: <20181218230442.27887-37-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 36/64] slirp: add a callback to log guest errors
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 net/slirp.c      | 7 +++++++
 slirp/dhcpv6.c   | 6 +++---
 slirp/ip6_icmp.c | 7 +++----
 slirp/libslirp.h | 2 ++
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index a7802ddbcc..00f7306b69 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "net/slirp.h"
=20
=20
@@ -140,8 +141,14 @@ static NetClientInfo net_slirp_info =3D {
     .cleanup =3D net_slirp_cleanup,
 };
=20
+static void net_slirp_guest_error(const char *msg)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "%s", msg);
+}
+
 static const SlirpCb slirp_cb =3D {
     .output =3D net_slirp_output,
+    .guest_error =3D net_slirp_guest_error,
 };
=20
 static int net_slirp_init(NetClientState *peer, const char *model,
diff --git a/slirp/dhcpv6.c b/slirp/dhcpv6.c
index 943a13bca8..5d703e8ae6 100644
--- a/slirp/dhcpv6.c
+++ b/slirp/dhcpv6.c
@@ -50,7 +50,7 @@ struct requested_infos {
  * the odata region, thus the caller must keep odata valid as long as it
  * needs to access the requested_infos struct.
  */
-static int dhcpv6_parse_info_request(uint8_t *odata, int olen,
+static int dhcpv6_parse_info_request(Slirp *slirp, uint8_t *odata, int o=
len,
                                      struct requested_infos *ri)
 {
     int i, req_opt;
@@ -61,7 +61,7 @@ static int dhcpv6_parse_info_request(uint8_t *odata, in=
t olen,
         int len =3D odata[2] << 8 | odata[3];
=20
         if (len + 4 > olen) {
-            qemu_log_mask(LOG_GUEST_ERROR, "Guest sent bad DHCPv6 packet=
!\n");
+            slirp->cb->guest_error("Guest sent bad DHCPv6 packet!");
             return -E2BIG;
         }
=20
@@ -121,7 +121,7 @@ static void dhcpv6_info_request(Slirp *slirp, struct =
sockaddr_in6 *srcsas,
     struct mbuf *m;
     uint8_t *resp;
=20
-    if (dhcpv6_parse_info_request(odata, olen, &ri) < 0) {
+    if (dhcpv6_parse_info_request(slirp, odata, olen, &ri) < 0) {
         return;
     }
=20
diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
index 595647b1b1..3f74d172f4 100644
--- a/slirp/ip6_icmp.c
+++ b/slirp/ip6_icmp.c
@@ -342,8 +342,7 @@ static void ndp_input(struct mbuf *m, Slirp *slirp, s=
truct ip6 *ip,
=20
     case ICMP6_NDP_RA:
         DEBUG_CALL(" type =3D Router Advertisement");
-        qemu_log_mask(LOG_GUEST_ERROR,
-                "Warning: guest sent NDP RA, but shouldn't");
+        slirp->cb->guest_error("Warning: guest sent NDP RA, but shouldn'=
t");
         break;
=20
     case ICMP6_NDP_NS:
@@ -376,8 +375,8 @@ static void ndp_input(struct mbuf *m, Slirp *slirp, s=
truct ip6 *ip,
=20
     case ICMP6_NDP_REDIRECT:
         DEBUG_CALL(" type =3D Redirect");
-        qemu_log_mask(LOG_GUEST_ERROR,
-                "Warning: guest sent NDP REDIRECT, but shouldn't");
+        slirp->cb->guest_error(
+            "Warning: guest sent NDP REDIRECT, but shouldn't");
         break;
     }
 }
diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index a5d1b27b5e..3e0aa19f4b 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -13,6 +13,8 @@ typedef struct Slirp Slirp;
 typedef struct SlirpCb {
     /* Send an ethernet frame to the guest network.  */
     void (*output)(void *opaque, const uint8_t *pkt, int pkt_len);
+    /* Print a message for an error due to guest misbehavior.  */
+    void (*guest_error)(const char *msg);
 } SlirpCb;
=20
=20
--=20
2.19.2
