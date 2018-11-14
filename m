Received: from eggs.gnu.org ([2001:4830:134:3::10]:60178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuVO-000475-QN
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:42:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuVK-00040Z-NI
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:42:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:28983)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gMuVI-0003xa-VH
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:42:45 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Nov 2018 16:36:33 +0400
Message-Id: <20181114123643.24091-32-marcandre.lureau@redhat.com>
In-Reply-To: <20181114123643.24091-1-marcandre.lureau@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 31/41] slirp: add a callback to log
 guest errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/libslirp.h | 1 +
 net/slirp.c      | 7 +++++++
 slirp/dhcpv6.c   | 6 +++---
 slirp/ip6_icmp.c | 7 +++----
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index f2e7f94ebb..c7582e6516 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -21,6 +21,7 @@ typedef struct SlirpCb {
     void (*timer_free)(void *timer);
     void (*timer_mod)(void *timer, int64_t expire_timer);
     void (*set_nonblock)(int fd);
+    void (*guest_error)(const char *msg);
 } SlirpCb;
=20
=20
diff --git a/net/slirp.c b/net/slirp.c
index 5ea8c255f6..b36092c948 100644
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
@@ -183,6 +184,11 @@ static void net_slirp_timer_mod(void *timer, int64_t=
 expire_timer)
     timer_mod(timer, expire_timer);
 }
=20
+static void net_slirp_guest_error(const char *msg)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "%s", msg);
+}
+
 static SlirpCb slirp_cb =3D {
     .output =3D net_slirp_output,
     .chr_write_all =3D net_slirp_chr_write_all,
@@ -191,6 +197,7 @@ static SlirpCb slirp_cb =3D {
     .timer_free =3D net_slirp_timer_free,
     .timer_mod =3D net_slirp_timer_mod,
     .set_nonblock =3D qemu_set_nonblock,
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
index 6f20190a0a..d523852a1f 100644
--- a/slirp/ip6_icmp.c
+++ b/slirp/ip6_icmp.c
@@ -343,8 +343,7 @@ static void ndp_input(struct mbuf *m, Slirp *slirp, s=
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
@@ -377,8 +376,8 @@ static void ndp_input(struct mbuf *m, Slirp *slirp, s=
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
--=20
2.19.1.708.g4ede3d42df
