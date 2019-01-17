Received: from eggs.gnu.org ([209.51.188.92]:57135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk66G-0005SB-8i
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:44:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk66D-0004Sn-S7
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:44:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gk66D-0004Ii-GK
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:44:41 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 17 Jan 2019 15:43:37 +0400
Message-Id: <20190117114359.5164-6-marcandre.lureau@redhat.com>
In-Reply-To: <20190117114359.5164-1-marcandre.lureau@redhat.com>
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 05/27] slirp: add callbacks for timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, pbonzini@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/libslirp.h | 14 +++++++++++---
 slirp/slirp.h    |  2 +-
 net/slirp.c      | 21 +++++++++++++++++++++
 slirp/ip6_icmp.c | 16 +++++++---------
 4 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index ea019828e8d..3e75dadfa31 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -6,19 +6,27 @@
 typedef struct Slirp Slirp;
=20
 typedef int (*SlirpWriteCb)(const void *buf, size_t len, void *opaque);
+typedef void (*SlirpTimerCb)(void *opaque);
=20
 /*
  * Callbacks from slirp
- *
- * The opaque parameter comes from the opaque parameter given to slirp_i=
nit().
  */
 typedef struct SlirpCb {
-    /* Send an ethernet frame to the guest network.  */
+    /*
+     * Send an ethernet frame to the guest network. The opaque parameter
+     * is the one given to slirp_init().
+     */
     void (*output)(void *opaque, const uint8_t *pkt, int pkt_len);
     /* Print a message for an error due to guest misbehavior.  */
     void (*guest_error)(const char *msg);
     /* Return the virtual clock value in nanoseconds */
     int64_t (*clock_get_ns)(void);
+    /* Create a new timer with the given callback and opaque data */
+    void *(*timer_new)(SlirpTimerCb cb, void *opaque);
+    /* Remove and free a timer */
+    void (*timer_free)(void *timer);
+    /* Modify a timer to expire at @expire_time */
+    void (*timer_mod)(void *timer, int64_t expire_time);
 } SlirpCb;
=20
=20
diff --git a/slirp/slirp.h b/slirp/slirp.h
index 9aa245715dd..17056f4b836 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -193,7 +193,7 @@ struct Slirp {
     NdpTable ndp_table;
=20
     GRand *grand;
-    QEMUTimer *ra_timer;
+    void *ra_timer;
=20
     const SlirpCb *cb;
     void *opaque;
diff --git a/net/slirp.c b/net/slirp.c
index 0b15f427f5c..c24a779425b 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -168,10 +168,31 @@ static int64_t net_slirp_clock_get_ns(void)
     return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 }
=20
+static void *net_slirp_timer_new(SlirpTimerCb cb, void *opaque)
+{
+    return timer_new_full(NULL, QEMU_CLOCK_VIRTUAL,
+                          SCALE_MS, QEMU_TIMER_ATTR_EXTERNAL,
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
 static const SlirpCb slirp_cb =3D {
     .output =3D net_slirp_output,
     .guest_error =3D net_slirp_guest_error,
     .clock_get_ns =3D net_slirp_clock_get_ns,
+    .timer_new =3D net_slirp_timer_new,
+    .timer_free =3D net_slirp_timer_free,
+    .timer_mod =3D net_slirp_timer_mod,
 };
=20
 static int net_slirp_init(NetClientState *peer, const char *model,
diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
index 5261baae271..e72c57a81dc 100644
--- a/slirp/ip6_icmp.c
+++ b/slirp/ip6_icmp.c
@@ -16,8 +16,9 @@
 static void ra_timer_handler(void *opaque)
 {
     Slirp *slirp =3D opaque;
-    timer_mod(slirp->ra_timer,
-              slirp->cb->clock_get_ns() / SCALE_MS + NDP_Interval);
+
+    slirp->cb->timer_mod(slirp->ra_timer,
+                         slirp->cb->clock_get_ns() / SCALE_MS + NDP_Inte=
rval);
     ndp_send_ra(slirp);
 }
=20
@@ -27,11 +28,9 @@ void icmp6_init(Slirp *slirp)
         return;
     }
=20
-    slirp->ra_timer =3D timer_new_full(NULL, QEMU_CLOCK_VIRTUAL,
-                                     SCALE_MS, QEMU_TIMER_ATTR_EXTERNAL,
-                                     ra_timer_handler, slirp);
-    timer_mod(slirp->ra_timer,
-              slirp->cb->clock_get_ns() / SCALE_MS + NDP_Interval);
+    slirp->ra_timer =3D slirp->cb->timer_new(ra_timer_handler, slirp);
+    slirp->cb->timer_mod(slirp->ra_timer,
+                         slirp->cb->clock_get_ns() / SCALE_MS + NDP_Inte=
rval);
 }
=20
 void icmp6_cleanup(Slirp *slirp)
@@ -40,8 +39,7 @@ void icmp6_cleanup(Slirp *slirp)
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
2.20.1.98.gecbdaf0899
