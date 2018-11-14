Received: from eggs.gnu.org ([2001:4830:134:3::10]:58955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuRX-0000iQ-IE
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:38:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuRR-0001Z3-U3
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:38:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gMuRP-0001JT-DA
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:38:43 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Nov 2018 16:36:10 +0400
Message-Id: <20181114123643.24091-9-marcandre.lureau@redhat.com>
In-Reply-To: <20181114123643.24091-1-marcandre.lureau@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 08/41] slirp: add callbacks for timer
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
 slirp/libslirp.h |  6 ++++++
 slirp/slirp.h    |  2 +-
 net/slirp.c      | 23 +++++++++++++++++++++++
 slirp/ip6_icmp.c | 21 ++++++++++-----------
 4 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index fcebcd1e58..88185e6c33 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -10,10 +10,16 @@ typedef enum SlirpClockType {
     SLIRP_CLOCK_REALTIME,
 } SlirpClockType;
=20
+typedef void (*SlirpTimerCb)(void *opaque);
+
 typedef struct SlirpCb {
     void (*output)(void *opaque, const uint8_t *pkt, int pkt_len);
     int (*chr_write_all)(void *chr, const void *buf, size_t len);
     int64_t (*clock_get_ns)(SlirpClockType type);
+    void *(*timer_new)(SlirpClockType type, int scale,
+                      SlirpTimerCb cb, void *opaque);
+    void (*timer_free)(void *timer);
+    void (*timer_mod)(void *timer, int64_t expire_timer);
 } SlirpCb;
=20
=20
diff --git a/slirp/slirp.h b/slirp/slirp.h
index f7c087456a..e5abf1c594 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -218,7 +218,7 @@ struct Slirp {
     NdpTable ndp_table;
=20
     GRand *grand;
-    QEMUTimer *ra_timer;
+    void *ra_timer;
=20
     const SlirpCb *cb;
     void *opaque;
diff --git a/net/slirp.c b/net/slirp.c
index af6c643b82..7b28886802 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -163,10 +163,33 @@ static int64_t net_slirp_clock_get_ns(SlirpClockTyp=
e type)
     return qemu_clock_get_ns(slirp_clock_to_qemu(type));
 }
=20
+static void *net_slirp_timer_new(SlirpClockType type,
+                                 int scale,
+                                 SlirpTimerCb cb, void *opaque)
+{
+    return timer_new_full(NULL, slirp_clock_to_qemu(type),
+                          scale, QEMU_TIMER_ATTR_EXTERNAL,
+                          cb, opaque);
+}
+
+static void net_slirp_timer_free(void *timer)
+{
+    timer_del(timer);
+    timer_free(timer);
+}
+
+static void net_slirp_timer_mod(void *timer, int64_t expire_timer)
+{
+    timer_mod(timer, expire_timer);
+}
+
 static SlirpCb slirp_cb =3D {
     .output =3D net_slirp_output,
     .chr_write_all =3D net_slirp_chr_write_all,
     .clock_get_ns =3D net_slirp_clock_get_ns,
+    .timer_new =3D net_slirp_timer_new,
+    .timer_free =3D net_slirp_timer_free,
+    .timer_mod =3D net_slirp_timer_mod,
 };
=20
 static int net_slirp_init(NetClientState *peer, const char *model,
diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
index 0f80d49ef9..71d95daef0 100644
--- a/slirp/ip6_icmp.c
+++ b/slirp/ip6_icmp.c
@@ -16,9 +16,10 @@
 static void ra_timer_handler(void *opaque)
 {
     Slirp *slirp =3D opaque;
-    timer_mod(slirp->ra_timer,
-              slirp->cb->clock_get_ns(SLIRP_CLOCK_VIRTUAL) / SCALE_MS +
-              NDP_Interval);
+
+    slirp->cb->timer_mod(slirp->ra_timer,
+        slirp->cb->clock_get_ns(SLIRP_CLOCK_VIRTUAL) / SCALE_MS +
+        NDP_Interval);
     ndp_send_ra(slirp);
 }
=20
@@ -28,12 +29,11 @@ void icmp6_init(Slirp *slirp)
         return;
     }
=20
-    slirp->ra_timer =3D timer_new_full(NULL, QEMU_CLOCK_VIRTUAL,
-                                     SCALE_MS, QEMU_TIMER_ATTR_EXTERNAL,
-                                     ra_timer_handler, slirp);
-    timer_mod(slirp->ra_timer,
-              slirp->cb->clock_get_ns(SLIRP_CLOCK_VIRTUAL) / SCALE_MS +
-              NDP_Interval);
+    slirp->ra_timer =3D slirp->cb->timer_new(SLIRP_CLOCK_VIRTUAL, SCALE_=
MS,
+                                           ra_timer_handler, slirp);
+    slirp->cb->timer_mod(slirp->ra_timer,
+        slirp->cb->clock_get_ns(SLIRP_CLOCK_VIRTUAL) / SCALE_MS +
+        NDP_Interval);
 }
=20
 void icmp6_cleanup(Slirp *slirp)
@@ -42,8 +42,7 @@ void icmp6_cleanup(Slirp *slirp)
         return;
     }
=20
-    timer_del(slirp->ra_timer);
-    timer_free(slirp->ra_timer);
+    slirp->cb->timer_free(slirp->ra_timer);
 }
=20
 static void icmp6_send_echoreply(struct mbuf *m, Slirp *slirp, struct ip=
6 *ip,
--=20
2.19.1.708.g4ede3d42df
