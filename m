Received: from eggs.gnu.org ([209.51.188.92]:58066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk67j-0006rD-A6
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:46:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk67g-00064p-VT
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:46:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gk67f-00061R-2a
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:46:11 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 17 Jan 2019 15:43:55 +0400
Message-Id: <20190117114359.5164-24-marcandre.lureau@redhat.com>
In-Reply-To: <20190117114359.5164-1-marcandre.lureau@redhat.com>
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 23/27] slirp: replace global polling with
 per-instance & notifier
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

Remove hard-coded dependency on slirp in main-loop, and use a "poll"
notifier instead. The notifier is registered per slirp instance.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/main-loop.h |  15 ++
 slirp/libslirp.h         |   4 +-
 net/slirp.c              |  24 ++
 slirp/slirp.c            | 555 +++++++++++++++++++--------------------
 stubs/slirp.c            |  13 -
 util/main-loop.c         |  30 ++-
 stubs/Makefile.objs      |   1 -
 7 files changed, 333 insertions(+), 309 deletions(-)
 delete mode 100644 stubs/slirp.c

diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index e59f9ae1e9d..f6ba78ea739 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -302,4 +302,19 @@ void qemu_fd_register(int fd);
 QEMUBH *qemu_bh_new(QEMUBHFunc *cb, void *opaque);
 void qemu_bh_schedule_idle(QEMUBH *bh);
=20
+enum {
+    MAIN_LOOP_POLL_FILL,
+    MAIN_LOOP_POLL_ERR,
+    MAIN_LOOP_POLL_OK,
+};
+
+typedef struct MainLoopPoll {
+    int state;
+    uint32_t timeout;
+    GArray *pollfds;
+} MainLoopPoll;
+
+void main_loop_poll_add_notifier(Notifier *notify);
+void main_loop_poll_remove_notifier(Notifier *notify);
+
 #endif
diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index 8e5d4ed11b5..18d5fb01335 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -63,9 +63,9 @@ Slirp *slirp_init(int restricted, bool in_enabled, stru=
ct in_addr vnetwork,
                   void *opaque);
 void slirp_cleanup(Slirp *slirp);
=20
-void slirp_pollfds_fill(GArray *pollfds, uint32_t *timeout);
+void slirp_pollfds_fill(Slirp *slirp, GArray *pollfds, uint32_t *timeout=
);
=20
-void slirp_pollfds_poll(GArray *pollfds, int select_error);
+void slirp_pollfds_poll(Slirp *slirp, GArray *pollfds, int select_error)=
;
=20
 void slirp_input(Slirp *slirp, const uint8_t *pkt, int pkt_len);
=20
diff --git a/net/slirp.c b/net/slirp.c
index 664ff1c0022..4d55f641684 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -86,6 +86,7 @@ typedef struct SlirpState {
     NetClientState nc;
     QTAILQ_ENTRY(SlirpState) entry;
     Slirp *slirp;
+    Notifier poll_notifier;
     Notifier exit_notifier;
 #ifndef _WIN32
     gchar *smb_dir;
@@ -144,6 +145,7 @@ static void net_slirp_cleanup(NetClientState *nc)
     SlirpState *s =3D DO_UPCAST(SlirpState, nc, nc);
=20
     g_slist_free_full(s->fwd, slirp_free_fwd);
+    main_loop_poll_remove_notifier(&s->poll_notifier);
     slirp_cleanup(s->slirp);
     if (s->exit_notifier.notify) {
         qemu_remove_exit_notifier(&s->exit_notifier);
@@ -209,6 +211,25 @@ static const SlirpCb slirp_cb =3D {
     .notify =3D qemu_notify_event,
 };
=20
+static void net_slirp_poll_notify(Notifier *notifier, void *data)
+{
+    MainLoopPoll *poll =3D data;
+    SlirpState *s =3D container_of(notifier, SlirpState, poll_notifier);
+
+    switch (poll->state) {
+    case MAIN_LOOP_POLL_FILL:
+        slirp_pollfds_fill(s->slirp, poll->pollfds, &poll->timeout);
+        break;
+    case MAIN_LOOP_POLL_OK:
+    case MAIN_LOOP_POLL_ERR:
+        slirp_pollfds_poll(s->slirp, poll->pollfds,
+                           poll->state =3D=3D MAIN_LOOP_POLL_ERR);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static int net_slirp_init(NetClientState *peer, const char *model,
                           const char *name, int restricted,
                           bool ipv4, const char *vnetwork, const char *v=
host,
@@ -429,6 +450,9 @@ static int net_slirp_init(NetClientState *peer, const=
 char *model,
                           &slirp_cb, s);
     QTAILQ_INSERT_TAIL(&slirp_stacks, s, entry);
=20
+    s->poll_notifier.notify =3D net_slirp_poll_notify;
+    main_loop_poll_add_notifier(&s->poll_notifier);
+
     for (config =3D slirp_configs; config; config =3D config->next) {
         if (config->flags & SLIRP_CFG_HOSTFWD) {
             if (slirp_hostfwd(s, config->str, errp) < 0) {
diff --git a/slirp/slirp.c b/slirp/slirp.c
index f42d31fb632..35630efe5db 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -368,9 +368,8 @@ void slirp_cleanup(Slirp *slirp)
 #define CONN_CANFSEND(so) (((so)->so_state & (SS_FCANTSENDMORE|SS_ISFCON=
NECTED)) =3D=3D SS_ISFCONNECTED)
 #define CONN_CANFRCV(so) (((so)->so_state & (SS_FCANTRCVMORE|SS_ISFCONNE=
CTED)) =3D=3D SS_ISFCONNECTED)
=20
-static void slirp_update_timeout(uint32_t *timeout)
+static void slirp_update_timeout(Slirp *slirp, uint32_t *timeout)
 {
-    Slirp *slirp;
     uint32_t t;
=20
     if (*timeout <=3D TIMEOUT_FAST) {
@@ -382,370 +381,352 @@ static void slirp_update_timeout(uint32_t *timeou=
t)
     /* If we have tcp timeout with slirp, then we will fill @timeout wit=
h
      * more precise value.
      */
-    QTAILQ_FOREACH(slirp, &slirp_instances, entry) {
-        if (slirp->time_fasttimo) {
-            *timeout =3D TIMEOUT_FAST;
-            return;
-        }
-        if (slirp->do_slowtimo) {
-            t =3D MIN(TIMEOUT_SLOW, t);
-        }
+    if (slirp->time_fasttimo) {
+        *timeout =3D TIMEOUT_FAST;
+        return;
+    }
+    if (slirp->do_slowtimo) {
+        t =3D MIN(TIMEOUT_SLOW, t);
     }
     *timeout =3D t;
 }
=20
-void slirp_pollfds_fill(GArray *pollfds, uint32_t *timeout)
+void slirp_pollfds_fill(Slirp *slirp, GArray *pollfds, uint32_t *timeout=
)
 {
-    Slirp *slirp;
     struct socket *so, *so_next;
=20
-    if (QTAILQ_EMPTY(&slirp_instances)) {
-        return;
-    }
-
     /*
      * First, TCP sockets
      */
=20
-    QTAILQ_FOREACH(slirp, &slirp_instances, entry) {
-        /*
-         * *_slowtimo needs calling if there are IP fragments
-         * in the fragment queue, or there are TCP connections active
-         */
-        slirp->do_slowtimo =3D ((slirp->tcb.so_next !=3D &slirp->tcb) ||
-                (&slirp->ipq.ip_link !=3D slirp->ipq.ip_link.next));
-
-        for (so =3D slirp->tcb.so_next; so !=3D &slirp->tcb;
-                so =3D so_next) {
-            int events =3D 0;
-
-            so_next =3D so->so_next;
+    /*
+     * *_slowtimo needs calling if there are IP fragments
+     * in the fragment queue, or there are TCP connections active
+     */
+    slirp->do_slowtimo =3D ((slirp->tcb.so_next !=3D &slirp->tcb) ||
+                          (&slirp->ipq.ip_link !=3D slirp->ipq.ip_link.n=
ext));
=20
-            so->pollfds_idx =3D -1;
+    for (so =3D slirp->tcb.so_next; so !=3D &slirp->tcb; so =3D so_next)=
 {
+        int events =3D 0;
=20
-            /*
-             * See if we need a tcp_fasttimo
-             */
-            if (slirp->time_fasttimo =3D=3D 0 &&
-                so->so_tcpcb->t_flags & TF_DELACK) {
-                slirp->time_fasttimo =3D curtime; /* Flag when want a fa=
sttimo */
-            }
+        so_next =3D so->so_next;
=20
-            /*
-             * NOFDREF can include still connecting to local-host,
-             * newly socreated() sockets etc. Don't want to select these=
.
-             */
-            if (so->so_state & SS_NOFDREF || so->s =3D=3D -1) {
-                continue;
-            }
+        so->pollfds_idx =3D -1;
=20
-            /*
-             * Set for reading sockets which are accepting
-             */
-            if (so->so_state & SS_FACCEPTCONN) {
-                GPollFD pfd =3D {
-                    .fd =3D so->s,
-                    .events =3D G_IO_IN | G_IO_HUP | G_IO_ERR,
-                };
-                so->pollfds_idx =3D pollfds->len;
-                g_array_append_val(pollfds, pfd);
-                continue;
-            }
+        /*
+         * See if we need a tcp_fasttimo
+         */
+        if (slirp->time_fasttimo =3D=3D 0 &&
+            so->so_tcpcb->t_flags & TF_DELACK) {
+            slirp->time_fasttimo =3D curtime; /* Flag when want a fastti=
mo */
+        }
=20
-            /*
-             * Set for writing sockets which are connecting
-             */
-            if (so->so_state & SS_ISFCONNECTING) {
-                GPollFD pfd =3D {
-                    .fd =3D so->s,
-                    .events =3D G_IO_OUT | G_IO_ERR,
-                };
-                so->pollfds_idx =3D pollfds->len;
-                g_array_append_val(pollfds, pfd);
-                continue;
-            }
+        /*
+         * NOFDREF can include still connecting to local-host,
+         * newly socreated() sockets etc. Don't want to select these.
+         */
+        if (so->so_state & SS_NOFDREF || so->s =3D=3D -1) {
+            continue;
+        }
=20
-            /*
-             * Set for writing if we are connected, can send more, and
-             * we have something to send
-             */
-            if (CONN_CANFSEND(so) && so->so_rcv.sb_cc) {
-                events |=3D G_IO_OUT | G_IO_ERR;
-            }
+        /*
+         * Set for reading sockets which are accepting
+         */
+        if (so->so_state & SS_FACCEPTCONN) {
+            GPollFD pfd =3D {
+                .fd =3D so->s,
+                .events =3D G_IO_IN | G_IO_HUP | G_IO_ERR,
+            };
+            so->pollfds_idx =3D pollfds->len;
+            g_array_append_val(pollfds, pfd);
+            continue;
+        }
=20
-            /*
-             * Set for reading (and urgent data) if we are connected, ca=
n
-             * receive more, and we have room for it XXX /2 ?
-             */
-            if (CONN_CANFRCV(so) &&
-                (so->so_snd.sb_cc < (so->so_snd.sb_datalen/2))) {
-                events |=3D G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_PRI;
-            }
+        /*
+         * Set for writing sockets which are connecting
+         */
+        if (so->so_state & SS_ISFCONNECTING) {
+            GPollFD pfd =3D {
+                .fd =3D so->s,
+                .events =3D G_IO_OUT | G_IO_ERR,
+            };
+            so->pollfds_idx =3D pollfds->len;
+            g_array_append_val(pollfds, pfd);
+            continue;
+        }
=20
-            if (events) {
-                GPollFD pfd =3D {
-                    .fd =3D so->s,
-                    .events =3D events,
-                };
-                so->pollfds_idx =3D pollfds->len;
-                g_array_append_val(pollfds, pfd);
-            }
+        /*
+         * Set for writing if we are connected, can send more, and
+         * we have something to send
+         */
+        if (CONN_CANFSEND(so) && so->so_rcv.sb_cc) {
+            events |=3D G_IO_OUT | G_IO_ERR;
         }
=20
         /*
-         * UDP sockets
+         * Set for reading (and urgent data) if we are connected, can
+         * receive more, and we have room for it XXX /2 ?
          */
-        for (so =3D slirp->udb.so_next; so !=3D &slirp->udb;
-                so =3D so_next) {
-            so_next =3D so->so_next;
+        if (CONN_CANFRCV(so) &&
+            (so->so_snd.sb_cc < (so->so_snd.sb_datalen/2))) {
+            events |=3D G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_PRI;
+        }
=20
-            so->pollfds_idx =3D -1;
+        if (events) {
+            GPollFD pfd =3D {
+                .fd =3D so->s,
+                .events =3D events,
+            };
+            so->pollfds_idx =3D pollfds->len;
+            g_array_append_val(pollfds, pfd);
+        }
+    }
=20
-            /*
-             * See if it's timed out
-             */
-            if (so->so_expire) {
-                if (so->so_expire <=3D curtime) {
-                    udp_detach(so);
-                    continue;
-                } else {
-                    slirp->do_slowtimo =3D true; /* Let socket expire */
-                }
-            }
+    /*
+     * UDP sockets
+     */
+    for (so =3D slirp->udb.so_next; so !=3D &slirp->udb; so =3D so_next)=
 {
+        so_next =3D so->so_next;
=20
-            /*
-             * When UDP packets are received from over the
-             * link, they're sendto()'d straight away, so
-             * no need for setting for writing
-             * Limit the number of packets queued by this session
-             * to 4.  Note that even though we try and limit this
-             * to 4 packets, the session could have more queued
-             * if the packets needed to be fragmented
-             * (XXX <=3D 4 ?)
-             */
-            if ((so->so_state & SS_ISFCONNECTED) && so->so_queued <=3D 4=
) {
-                GPollFD pfd =3D {
-                    .fd =3D so->s,
-                    .events =3D G_IO_IN | G_IO_HUP | G_IO_ERR,
-                };
-                so->pollfds_idx =3D pollfds->len;
-                g_array_append_val(pollfds, pfd);
+        so->pollfds_idx =3D -1;
+
+        /*
+         * See if it's timed out
+         */
+        if (so->so_expire) {
+            if (so->so_expire <=3D curtime) {
+                udp_detach(so);
+                continue;
+            } else {
+                slirp->do_slowtimo =3D true; /* Let socket expire */
             }
         }
=20
         /*
-         * ICMP sockets
+         * When UDP packets are received from over the
+         * link, they're sendto()'d straight away, so
+         * no need for setting for writing
+         * Limit the number of packets queued by this session
+         * to 4.  Note that even though we try and limit this
+         * to 4 packets, the session could have more queued
+         * if the packets needed to be fragmented
+         * (XXX <=3D 4 ?)
          */
-        for (so =3D slirp->icmp.so_next; so !=3D &slirp->icmp;
-                so =3D so_next) {
-            so_next =3D so->so_next;
+        if ((so->so_state & SS_ISFCONNECTED) && so->so_queued <=3D 4) {
+            GPollFD pfd =3D {
+                .fd =3D so->s,
+                .events =3D G_IO_IN | G_IO_HUP | G_IO_ERR,
+            };
+            so->pollfds_idx =3D pollfds->len;
+            g_array_append_val(pollfds, pfd);
+        }
+    }
=20
-            so->pollfds_idx =3D -1;
+    /*
+     * ICMP sockets
+     */
+    for (so =3D slirp->icmp.so_next; so !=3D &slirp->icmp; so =3D so_nex=
t) {
+        so_next =3D so->so_next;
=20
-            /*
-             * See if it's timed out
-             */
-            if (so->so_expire) {
-                if (so->so_expire <=3D curtime) {
-                    icmp_detach(so);
-                    continue;
-                } else {
-                    slirp->do_slowtimo =3D true; /* Let socket expire */
-                }
-            }
+        so->pollfds_idx =3D -1;
=20
-            if (so->so_state & SS_ISFCONNECTED) {
-                GPollFD pfd =3D {
-                    .fd =3D so->s,
-                    .events =3D G_IO_IN | G_IO_HUP | G_IO_ERR,
-                };
-                so->pollfds_idx =3D pollfds->len;
-                g_array_append_val(pollfds, pfd);
+        /*
+         * See if it's timed out
+         */
+        if (so->so_expire) {
+            if (so->so_expire <=3D curtime) {
+                icmp_detach(so);
+                continue;
+            } else {
+                slirp->do_slowtimo =3D true; /* Let socket expire */
             }
         }
+
+        if (so->so_state & SS_ISFCONNECTED) {
+            GPollFD pfd =3D {
+                .fd =3D so->s,
+                .events =3D G_IO_IN | G_IO_HUP | G_IO_ERR,
+            };
+            so->pollfds_idx =3D pollfds->len;
+            g_array_append_val(pollfds, pfd);
+        }
     }
-    slirp_update_timeout(timeout);
+
+    slirp_update_timeout(slirp, timeout);
 }
=20
-void slirp_pollfds_poll(GArray *pollfds, int select_error)
+void slirp_pollfds_poll(Slirp *slirp, GArray *pollfds, int select_error)
 {
-    Slirp *slirp =3D QTAILQ_FIRST(&slirp_instances);
     struct socket *so, *so_next;
     int ret;
=20
-    if (!slirp) {
-        return;
-    }
-
     curtime =3D slirp->cb->clock_get_ns() / SCALE_MS;
=20
-    QTAILQ_FOREACH(slirp, &slirp_instances, entry) {
-        /*
-         * See if anything has timed out
-         */
-        if (slirp->time_fasttimo &&
-            ((curtime - slirp->time_fasttimo) >=3D TIMEOUT_FAST)) {
-            tcp_fasttimo(slirp);
-            slirp->time_fasttimo =3D 0;
-        }
-        if (slirp->do_slowtimo &&
-            ((curtime - slirp->last_slowtimo) >=3D TIMEOUT_SLOW)) {
-            ip_slowtimo(slirp);
-            tcp_slowtimo(slirp);
-            slirp->last_slowtimo =3D curtime;
-        }
+    /*
+     * See if anything has timed out
+     */
+    if (slirp->time_fasttimo &&
+        ((curtime - slirp->time_fasttimo) >=3D TIMEOUT_FAST)) {
+        tcp_fasttimo(slirp);
+        slirp->time_fasttimo =3D 0;
+    }
+    if (slirp->do_slowtimo &&
+        ((curtime - slirp->last_slowtimo) >=3D TIMEOUT_SLOW)) {
+        ip_slowtimo(slirp);
+        tcp_slowtimo(slirp);
+        slirp->last_slowtimo =3D curtime;
+    }
=20
+    /*
+     * Check sockets
+     */
+    if (!select_error) {
         /*
-         * Check sockets
+         * Check TCP sockets
          */
-        if (!select_error) {
-            /*
-             * Check TCP sockets
-             */
-            for (so =3D slirp->tcb.so_next; so !=3D &slirp->tcb;
-                    so =3D so_next) {
-                int revents;
+        for (so =3D slirp->tcb.so_next; so !=3D &slirp->tcb;
+             so =3D so_next) {
+            int revents;
=20
-                so_next =3D so->so_next;
+            so_next =3D so->so_next;
=20
-                revents =3D 0;
-                if (so->pollfds_idx !=3D -1) {
-                    revents =3D g_array_index(pollfds, GPollFD,
-                                            so->pollfds_idx).revents;
-                }
+            revents =3D 0;
+            if (so->pollfds_idx !=3D -1) {
+                revents =3D g_array_index(pollfds, GPollFD,
+                                        so->pollfds_idx).revents;
+            }
=20
-                if (so->so_state & SS_NOFDREF || so->s =3D=3D -1) {
+            if (so->so_state & SS_NOFDREF || so->s =3D=3D -1) {
+                continue;
+            }
+
+            /*
+             * Check for URG data
+             * This will soread as well, so no need to
+             * test for G_IO_IN below if this succeeds
+             */
+            if (revents & G_IO_PRI) {
+                ret =3D sorecvoob(so);
+                if (ret < 0) {
+                    /* Socket error might have resulted in the socket be=
ing
+                     * removed, do not try to do anything more with it. =
*/
                     continue;
                 }
-
+            }
+            /*
+             * Check sockets for reading
+             */
+            else if (revents & (G_IO_IN | G_IO_HUP | G_IO_ERR)) {
                 /*
-                 * Check for URG data
-                 * This will soread as well, so no need to
-                 * test for G_IO_IN below if this succeeds
+                 * Check for incoming connections
                  */
-                if (revents & G_IO_PRI) {
-                    ret =3D sorecvoob(so);
-                    if (ret < 0) {
-                        /* Socket error might have resulted in the socke=
t being
-                         * removed, do not try to do anything more with =
it. */
-                        continue;
-                    }
+                if (so->so_state & SS_FACCEPTCONN) {
+                    tcp_connect(so);
+                    continue;
+                } /* else */
+                ret =3D soread(so);
+
+                /* Output it if we read something */
+                if (ret > 0) {
+                    tcp_output(sototcpcb(so));
+                }
+                if (ret < 0) {
+                    /* Socket error might have resulted in the socket be=
ing
+                     * removed, do not try to do anything more with it. =
*/
+                    continue;
                 }
+            }
+
+            /*
+             * Check sockets for writing
+             */
+            if (!(so->so_state & SS_NOFDREF) &&
+                (revents & (G_IO_OUT | G_IO_ERR))) {
                 /*
-                 * Check sockets for reading
+                 * Check for non-blocking, still-connecting sockets
                  */
-                else if (revents & (G_IO_IN | G_IO_HUP | G_IO_ERR)) {
-                    /*
-                     * Check for incoming connections
-                     */
-                    if (so->so_state & SS_FACCEPTCONN) {
-                        tcp_connect(so);
-                        continue;
-                    } /* else */
-                    ret =3D soread(so);
+                if (so->so_state & SS_ISFCONNECTING) {
+                    /* Connected */
+                    so->so_state &=3D ~SS_ISFCONNECTING;
=20
-                    /* Output it if we read something */
-                    if (ret > 0) {
-                        tcp_output(sototcpcb(so));
-                    }
+                    ret =3D send(so->s, (const void *) &ret, 0, 0);
                     if (ret < 0) {
-                        /* Socket error might have resulted in the socke=
t being
-                         * removed, do not try to do anything more with =
it. */
-                        continue;
+                        /* XXXXX Must fix, zero bytes is a NOP */
+                        if (errno =3D=3D EAGAIN || errno =3D=3D EWOULDBL=
OCK ||
+                            errno =3D=3D EINPROGRESS || errno =3D=3D ENO=
TCONN) {
+                            continue;
+                        }
+
+                        /* else failed */
+                        so->so_state &=3D SS_PERSISTENT_MASK;
+                        so->so_state |=3D SS_NOFDREF;
                     }
-                }
+                    /* else so->so_state &=3D ~SS_ISFCONNECTING; */
=20
-                /*
-                 * Check sockets for writing
-                 */
-                if (!(so->so_state & SS_NOFDREF) &&
-                        (revents & (G_IO_OUT | G_IO_ERR))) {
                     /*
-                     * Check for non-blocking, still-connecting sockets
+                     * Continue tcp_input
                      */
-                    if (so->so_state & SS_ISFCONNECTING) {
-                        /* Connected */
-                        so->so_state &=3D ~SS_ISFCONNECTING;
-
-                        ret =3D send(so->s, (const void *) &ret, 0, 0);
-                        if (ret < 0) {
-                            /* XXXXX Must fix, zero bytes is a NOP */
-                            if (errno =3D=3D EAGAIN || errno =3D=3D EWOU=
LDBLOCK ||
-                                errno =3D=3D EINPROGRESS || errno =3D=3D=
 ENOTCONN) {
-                                continue;
-                            }
-
-                            /* else failed */
-                            so->so_state &=3D SS_PERSISTENT_MASK;
-                            so->so_state |=3D SS_NOFDREF;
-                        }
-                        /* else so->so_state &=3D ~SS_ISFCONNECTING; */
-
-                        /*
-                         * Continue tcp_input
-                         */
-                        tcp_input((struct mbuf *)NULL, sizeof(struct ip)=
, so,
-                                  so->so_ffamily);
-                        /* continue; */
-                    } else {
-                        ret =3D sowrite(so);
-                        if (ret > 0) {
-                            /* Call tcp_output in case we need to send a=
 window
-                             * update to the guest, otherwise it will be=
 stuck
-                             * until it sends a window probe. */
-                            tcp_output(sototcpcb(so));
-                        }
+                    tcp_input((struct mbuf *)NULL, sizeof(struct ip), so=
,
+                              so->so_ffamily);
+                    /* continue; */
+                } else {
+                    ret =3D sowrite(so);
+                    if (ret > 0) {
+                        /* Call tcp_output in case we need to send a win=
dow
+                         * update to the guest, otherwise it will be stu=
ck
+                         * until it sends a window probe. */
+                        tcp_output(sototcpcb(so));
                     }
                 }
             }
+        }
=20
-            /*
-             * Now UDP sockets.
-             * Incoming packets are sent straight away, they're not buff=
ered.
-             * Incoming UDP data isn't buffered either.
-             */
-            for (so =3D slirp->udb.so_next; so !=3D &slirp->udb;
-                    so =3D so_next) {
-                int revents;
+        /*
+         * Now UDP sockets.
+         * Incoming packets are sent straight away, they're not buffered=
.
+         * Incoming UDP data isn't buffered either.
+         */
+        for (so =3D slirp->udb.so_next; so !=3D &slirp->udb;
+             so =3D so_next) {
+            int revents;
=20
-                so_next =3D so->so_next;
+            so_next =3D so->so_next;
=20
-                revents =3D 0;
-                if (so->pollfds_idx !=3D -1) {
-                    revents =3D g_array_index(pollfds, GPollFD,
-                            so->pollfds_idx).revents;
-                }
+            revents =3D 0;
+            if (so->pollfds_idx !=3D -1) {
+                revents =3D g_array_index(pollfds, GPollFD,
+                                        so->pollfds_idx).revents;
+            }
=20
-                if (so->s !=3D -1 &&
-                    (revents & (G_IO_IN | G_IO_HUP | G_IO_ERR))) {
-                    sorecvfrom(so);
-                }
+            if (so->s !=3D -1 &&
+                (revents & (G_IO_IN | G_IO_HUP | G_IO_ERR))) {
+                sorecvfrom(so);
             }
+        }
=20
-            /*
-             * Check incoming ICMP relies.
-             */
-            for (so =3D slirp->icmp.so_next; so !=3D &slirp->icmp;
-                    so =3D so_next) {
-                    int revents;
+        /*
+         * Check incoming ICMP relies.
+         */
+        for (so =3D slirp->icmp.so_next; so !=3D &slirp->icmp;
+             so =3D so_next) {
+            int revents;
=20
-                    so_next =3D so->so_next;
+            so_next =3D so->so_next;
=20
-                    revents =3D 0;
-                    if (so->pollfds_idx !=3D -1) {
-                        revents =3D g_array_index(pollfds, GPollFD,
-                                                so->pollfds_idx).revents=
;
-                    }
+            revents =3D 0;
+            if (so->pollfds_idx !=3D -1) {
+                revents =3D g_array_index(pollfds, GPollFD,
+                                        so->pollfds_idx).revents;
+            }
=20
-                    if (so->s !=3D -1 &&
-                        (revents & (G_IO_IN | G_IO_HUP | G_IO_ERR))) {
-                    icmp_receive(so);
-                }
+            if (so->s !=3D -1 &&
+                (revents & (G_IO_IN | G_IO_HUP | G_IO_ERR))) {
+                icmp_receive(so);
             }
         }
-
-        if_start(slirp);
     }
+
+    if_start(slirp);
 }
=20
 static void arp_input(Slirp *slirp, const uint8_t *pkt, int pkt_len)
diff --git a/stubs/slirp.c b/stubs/slirp.c
deleted file mode 100644
index 70704346fdf..00000000000
--- a/stubs/slirp.c
+++ /dev/null
@@ -1,13 +0,0 @@
-#include "qemu/osdep.h"
-#include "qemu-common.h"
-#include "qemu/host-utils.h"
-#include "slirp/libslirp.h"
-
-void slirp_pollfds_fill(GArray *pollfds, uint32_t *timeout)
-{
-}
-
-void slirp_pollfds_poll(GArray *pollfds, int select_error)
-{
-}
-
diff --git a/util/main-loop.c b/util/main-loop.c
index affe0403c58..5f15cdf88d1 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -469,25 +469,42 @@ static int os_host_main_loop_wait(int64_t timeout)
 }
 #endif
=20
+static NotifierList main_loop_poll_notifiers =3D
+    NOTIFIER_LIST_INITIALIZER(main_loop_poll_notifiers);
+
+void main_loop_poll_add_notifier(Notifier *notify)
+{
+    notifier_list_add(&main_loop_poll_notifiers, notify);
+}
+
+void main_loop_poll_remove_notifier(Notifier *notify)
+{
+    notifier_remove(notify);
+}
+
 void main_loop_wait(int nonblocking)
 {
+    MainLoopPoll mlpoll =3D {
+        .state =3D MAIN_LOOP_POLL_FILL,
+        .timeout =3D UINT32_MAX,
+        .pollfds =3D gpollfds,
+    };
     int ret;
-    uint32_t timeout =3D UINT32_MAX;
     int64_t timeout_ns;
=20
     if (nonblocking) {
-        timeout =3D 0;
+        mlpoll.timeout =3D 0;
     }
=20
     /* poll any events */
     g_array_set_size(gpollfds, 0); /* reset for new iteration */
     /* XXX: separate device handlers from system ones */
-    slirp_pollfds_fill(gpollfds, &timeout);
+    notifier_list_notify(&main_loop_poll_notifiers, &mlpoll);
=20
-    if (timeout =3D=3D UINT32_MAX) {
+    if (mlpoll.timeout =3D=3D UINT32_MAX) {
         timeout_ns =3D -1;
     } else {
-        timeout_ns =3D (uint64_t)timeout * (int64_t)(SCALE_MS);
+        timeout_ns =3D (uint64_t)mlpoll.timeout * (int64_t)(SCALE_MS);
     }
=20
     timeout_ns =3D qemu_soonest_timeout(timeout_ns,
@@ -495,7 +512,8 @@ void main_loop_wait(int nonblocking)
                                           &main_loop_tlg));
=20
     ret =3D os_host_main_loop_wait(timeout_ns);
-    slirp_pollfds_poll(gpollfds, (ret < 0));
+    mlpoll.state =3D ret < 0 ? MAIN_LOOP_POLL_ERR : MAIN_LOOP_POLL_OK;
+    notifier_list_notify(&main_loop_poll_notifiers, &mlpoll);
=20
     /* CPU thread can infinitely wait for event after
        missing the warp */
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index cda0efa4e86..1558ff1fe72 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -26,7 +26,6 @@ stub-obj-y +=3D qtest.o
 stub-obj-y +=3D replay.o
 stub-obj-y +=3D runstate-check.o
 stub-obj-y +=3D set-fd-handler.o
-stub-obj-y +=3D slirp.o
 stub-obj-y +=3D sysbus.o
 stub-obj-y +=3D tpm.o
 stub-obj-y +=3D trace-control.o
--=20
2.20.1.98.gecbdaf0899
