Received: from eggs.gnu.org ([209.51.188.92]:52861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCR-0001bS-5V
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:06:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCN-0007hS-KJ
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:06:07 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:46486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gnjCN-0007TL-4r
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:06:03 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 27 Jan 2019 13:05:24 +0100
Message-Id: <20190127120526.15457-30-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
References: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 29/31] slirp: use polling callbacks,
 drop glib requirement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

It would be legitimate to use libslirp without glib. Let's
add_poll/get_revents pair of callbacks to provide the same
functionality.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 net/slirp.c      | 72 ++++++++++++++++++++++++++++++++++++++++++++++--
 slirp/libslirp.h | 17 ++++++++++--
 slirp/slirp.c    | 72 +++++++++++++++++-------------------------------
 3 files changed, 109 insertions(+), 52 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index 4d55f64168..a85e42ff43 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -211,6 +211,71 @@ static const SlirpCb slirp_cb =3D {
     .notify =3D qemu_notify_event,
 };
=20
+static int slirp_poll_to_gio(int events)
+{
+    int ret =3D 0;
+
+    if (events & SLIRP_POLL_IN) {
+        ret |=3D G_IO_IN;
+    }
+    if (events & SLIRP_POLL_OUT) {
+        ret |=3D G_IO_OUT;
+    }
+    if (events & SLIRP_POLL_PRI) {
+        ret |=3D G_IO_PRI;
+    }
+    if (events & SLIRP_POLL_ERR) {
+        ret |=3D G_IO_ERR;
+    }
+    if (events & SLIRP_POLL_HUP) {
+        ret |=3D G_IO_HUP;
+    }
+
+    return ret;
+}
+
+static int net_slirp_add_poll(int fd, int events, void *opaque)
+{
+    GArray *pollfds =3D opaque;
+    GPollFD pfd =3D {
+        .fd =3D fd,
+        .events =3D slirp_poll_to_gio(events),
+    };
+    int idx =3D pollfds->len;
+    g_array_append_val(pollfds, pfd);
+    return idx;
+}
+
+static int slirp_gio_to_poll(int events)
+{
+    int ret =3D 0;
+
+    if (events & G_IO_IN) {
+        ret |=3D SLIRP_POLL_IN;
+    }
+    if (events & G_IO_OUT) {
+        ret |=3D SLIRP_POLL_OUT;
+    }
+    if (events & G_IO_PRI) {
+        ret |=3D SLIRP_POLL_PRI;
+    }
+    if (events & G_IO_ERR) {
+        ret |=3D SLIRP_POLL_ERR;
+    }
+    if (events & G_IO_HUP) {
+        ret |=3D SLIRP_POLL_HUP;
+    }
+
+    return ret;
+}
+
+static int net_slirp_get_revents(int idx, void *opaque)
+{
+    GArray *pollfds =3D opaque;
+
+    return slirp_gio_to_poll(g_array_index(pollfds, GPollFD, idx).revent=
s);
+}
+
 static void net_slirp_poll_notify(Notifier *notifier, void *data)
 {
     MainLoopPoll *poll =3D data;
@@ -218,12 +283,13 @@ static void net_slirp_poll_notify(Notifier *notifie=
r, void *data)
=20
     switch (poll->state) {
     case MAIN_LOOP_POLL_FILL:
-        slirp_pollfds_fill(s->slirp, poll->pollfds, &poll->timeout);
+        slirp_pollfds_fill(s->slirp, &poll->timeout,
+                           net_slirp_add_poll, poll->pollfds);
         break;
     case MAIN_LOOP_POLL_OK:
     case MAIN_LOOP_POLL_ERR:
-        slirp_pollfds_poll(s->slirp, poll->pollfds,
-                           poll->state =3D=3D MAIN_LOOP_POLL_ERR);
+        slirp_pollfds_poll(s->slirp, poll->state =3D=3D MAIN_LOOP_POLL_E=
RR,
+                           net_slirp_get_revents, poll->pollfds);
         break;
     default:
         g_assert_not_reached();
diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index 18d5fb0133..b5c1b2122b 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -1,7 +1,6 @@
 #ifndef LIBSLIRP_H
 #define LIBSLIRP_H
=20
-#include <glib.h>
 #include <stdint.h>
 #include <stdbool.h>
=20
@@ -15,8 +14,18 @@
=20
 typedef struct Slirp Slirp;
=20
+enum {
+    SLIRP_POLL_IN  =3D 1 << 0,
+    SLIRP_POLL_OUT =3D 1 << 1,
+    SLIRP_POLL_PRI =3D 1 << 2,
+    SLIRP_POLL_ERR =3D 1 << 3,
+    SLIRP_POLL_HUP =3D 1 << 4,
+};
+
 typedef ssize_t (*SlirpWriteCb)(const void *buf, size_t len, void *opaqu=
e);
 typedef void (*SlirpTimerCb)(void *opaque);
+typedef int (*SlirpAddPollCb)(int fd, int events, void *opaque);
+typedef int (*SlirpGetREventsCb)(int idx, void *opaque);
=20
 /*
  * Callbacks from slirp
@@ -63,9 +72,11 @@ Slirp *slirp_init(int restricted, bool in_enabled, str=
uct in_addr vnetwork,
                   void *opaque);
 void slirp_cleanup(Slirp *slirp);
=20
-void slirp_pollfds_fill(Slirp *slirp, GArray *pollfds, uint32_t *timeout=
);
+void slirp_pollfds_fill(Slirp *slirp, uint32_t *timeout,
+                        SlirpAddPollCb add_poll, void *opaque);
=20
-void slirp_pollfds_poll(Slirp *slirp, GArray *pollfds, int select_error)=
;
+void slirp_pollfds_poll(Slirp *slirp, int select_error,
+                        SlirpGetREventsCb get_revents, void *opaque);
=20
 void slirp_input(Slirp *slirp, const uint8_t *pkt, int pkt_len);
=20
diff --git a/slirp/slirp.c b/slirp/slirp.c
index ecbb5c5b6c..04886d05fd 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -386,7 +386,8 @@ static void slirp_update_timeout(Slirp *slirp, uint32=
_t *timeout)
     *timeout =3D t;
 }
=20
-void slirp_pollfds_fill(Slirp *slirp, GArray *pollfds, uint32_t *timeout=
)
+void slirp_pollfds_fill(Slirp *slirp, uint32_t *timeout,
+                        SlirpAddPollCb add_poll, void *opaque)
 {
     struct socket *so, *so_next;
=20
@@ -428,12 +429,8 @@ void slirp_pollfds_fill(Slirp *slirp, GArray *pollfd=
s, uint32_t *timeout)
          * Set for reading sockets which are accepting
          */
         if (so->so_state & SS_FACCEPTCONN) {
-            GPollFD pfd =3D {
-                .fd =3D so->s,
-                .events =3D G_IO_IN | G_IO_HUP | G_IO_ERR,
-            };
-            so->pollfds_idx =3D pollfds->len;
-            g_array_append_val(pollfds, pfd);
+            so->pollfds_idx =3D add_poll(so->s,
+                SLIRP_POLL_IN | SLIRP_POLL_HUP | SLIRP_POLL_ERR, opaque)=
;
             continue;
         }
=20
@@ -441,12 +438,8 @@ void slirp_pollfds_fill(Slirp *slirp, GArray *pollfd=
s, uint32_t *timeout)
          * Set for writing sockets which are connecting
          */
         if (so->so_state & SS_ISFCONNECTING) {
-            GPollFD pfd =3D {
-                .fd =3D so->s,
-                .events =3D G_IO_OUT | G_IO_ERR,
-            };
-            so->pollfds_idx =3D pollfds->len;
-            g_array_append_val(pollfds, pfd);
+            so->pollfds_idx =3D add_poll(so->s,
+                SLIRP_POLL_OUT | SLIRP_POLL_ERR, opaque);
             continue;
         }
=20
@@ -455,7 +448,7 @@ void slirp_pollfds_fill(Slirp *slirp, GArray *pollfds=
, uint32_t *timeout)
          * we have something to send
          */
         if (CONN_CANFSEND(so) && so->so_rcv.sb_cc) {
-            events |=3D G_IO_OUT | G_IO_ERR;
+            events |=3D SLIRP_POLL_OUT | SLIRP_POLL_ERR;
         }
=20
         /*
@@ -464,16 +457,12 @@ void slirp_pollfds_fill(Slirp *slirp, GArray *pollf=
ds, uint32_t *timeout)
          */
         if (CONN_CANFRCV(so) &&
             (so->so_snd.sb_cc < (so->so_snd.sb_datalen/2))) {
-            events |=3D G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_PRI;
+            events |=3D SLIRP_POLL_IN | SLIRP_POLL_HUP |
+                      SLIRP_POLL_ERR | SLIRP_POLL_PRI;
         }
=20
         if (events) {
-            GPollFD pfd =3D {
-                .fd =3D so->s,
-                .events =3D events,
-            };
-            so->pollfds_idx =3D pollfds->len;
-            g_array_append_val(pollfds, pfd);
+            so->pollfds_idx =3D add_poll(so->s, events, opaque);
         }
     }
=20
@@ -508,12 +497,8 @@ void slirp_pollfds_fill(Slirp *slirp, GArray *pollfd=
s, uint32_t *timeout)
          * (XXX <=3D 4 ?)
          */
         if ((so->so_state & SS_ISFCONNECTED) && so->so_queued <=3D 4) {
-            GPollFD pfd =3D {
-                .fd =3D so->s,
-                .events =3D G_IO_IN | G_IO_HUP | G_IO_ERR,
-            };
-            so->pollfds_idx =3D pollfds->len;
-            g_array_append_val(pollfds, pfd);
+            so->pollfds_idx =3D add_poll(so->s,
+                SLIRP_POLL_IN | SLIRP_POLL_HUP | SLIRP_POLL_ERR, opaque)=
;
         }
     }
=20
@@ -538,19 +523,16 @@ void slirp_pollfds_fill(Slirp *slirp, GArray *pollf=
ds, uint32_t *timeout)
         }
=20
         if (so->so_state & SS_ISFCONNECTED) {
-            GPollFD pfd =3D {
-                .fd =3D so->s,
-                .events =3D G_IO_IN | G_IO_HUP | G_IO_ERR,
-            };
-            so->pollfds_idx =3D pollfds->len;
-            g_array_append_val(pollfds, pfd);
+            so->pollfds_idx =3D add_poll(so->s,
+                SLIRP_POLL_IN | SLIRP_POLL_HUP | SLIRP_POLL_ERR, opaque)=
;
         }
     }
=20
     slirp_update_timeout(slirp, timeout);
 }
=20
-void slirp_pollfds_poll(Slirp *slirp, GArray *pollfds, int select_error)
+void slirp_pollfds_poll(Slirp *slirp, int select_error,
+                        SlirpGetREventsCb get_revents, void *opaque)
 {
     struct socket *so, *so_next;
     int ret;
@@ -587,8 +569,7 @@ void slirp_pollfds_poll(Slirp *slirp, GArray *pollfds=
, int select_error)
=20
             revents =3D 0;
             if (so->pollfds_idx !=3D -1) {
-                revents =3D g_array_index(pollfds, GPollFD,
-                                        so->pollfds_idx).revents;
+                revents =3D get_revents(so->pollfds_idx, opaque);
             }
=20
             if (so->so_state & SS_NOFDREF || so->s =3D=3D -1) {
@@ -598,9 +579,9 @@ void slirp_pollfds_poll(Slirp *slirp, GArray *pollfds=
, int select_error)
             /*
              * Check for URG data
              * This will soread as well, so no need to
-             * test for G_IO_IN below if this succeeds
+             * test for SLIRP_POLL_IN below if this succeeds
              */
-            if (revents & G_IO_PRI) {
+            if (revents & SLIRP_POLL_PRI) {
                 ret =3D sorecvoob(so);
                 if (ret < 0) {
                     /* Socket error might have resulted in the socket be=
ing
@@ -611,7 +592,8 @@ void slirp_pollfds_poll(Slirp *slirp, GArray *pollfds=
, int select_error)
             /*
              * Check sockets for reading
              */
-            else if (revents & (G_IO_IN | G_IO_HUP | G_IO_ERR)) {
+            else if (revents &
+                     (SLIRP_POLL_IN | SLIRP_POLL_HUP | SLIRP_POLL_ERR)) =
{
                 /*
                  * Check for incoming connections
                  */
@@ -636,7 +618,7 @@ void slirp_pollfds_poll(Slirp *slirp, GArray *pollfds=
, int select_error)
              * Check sockets for writing
              */
             if (!(so->so_state & SS_NOFDREF) &&
-                (revents & (G_IO_OUT | G_IO_ERR))) {
+                (revents & (SLIRP_POLL_OUT | SLIRP_POLL_ERR))) {
                 /*
                  * Check for non-blocking, still-connecting sockets
                  */
@@ -689,12 +671,11 @@ void slirp_pollfds_poll(Slirp *slirp, GArray *pollf=
ds, int select_error)
=20
             revents =3D 0;
             if (so->pollfds_idx !=3D -1) {
-                revents =3D g_array_index(pollfds, GPollFD,
-                                        so->pollfds_idx).revents;
+                revents =3D get_revents(so->pollfds_idx, opaque);
             }
=20
             if (so->s !=3D -1 &&
-                (revents & (G_IO_IN | G_IO_HUP | G_IO_ERR))) {
+                (revents & (SLIRP_POLL_IN | SLIRP_POLL_HUP | SLIRP_POLL_=
ERR))) {
                 sorecvfrom(so);
             }
         }
@@ -710,12 +691,11 @@ void slirp_pollfds_poll(Slirp *slirp, GArray *pollf=
ds, int select_error)
=20
             revents =3D 0;
             if (so->pollfds_idx !=3D -1) {
-                revents =3D g_array_index(pollfds, GPollFD,
-                                        so->pollfds_idx).revents;
+                revents =3D get_revents(so->pollfds_idx, opaque);
             }
=20
             if (so->s !=3D -1 &&
-                (revents & (G_IO_IN | G_IO_HUP | G_IO_ERR))) {
+                (revents & (SLIRP_POLL_IN | SLIRP_POLL_HUP | SLIRP_POLL_=
ERR))) {
                 icmp_receive(so);
             }
         }
--=20
2.20.1
