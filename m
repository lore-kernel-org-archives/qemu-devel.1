Received: from eggs.gnu.org ([209.51.188.92]:58202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk67y-00074m-IR
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:46:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk67w-0006DS-MD
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:46:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gk67u-0006CT-Ne
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:46:28 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 17 Jan 2019 15:43:58 +0400
Message-Id: <20190117114359.5164-27-marcandre.lureau@redhat.com>
In-Reply-To: <20190117114359.5164-1-marcandre.lureau@redhat.com>
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 26/27] slirp: pass opaque to all callbacks
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

This is friendlier for FFI bindings.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/libslirp.h | 16 ++++++++--------
 net/slirp.c      | 25 ++++++++++++++++---------
 slirp/dhcpv6.c   |  2 +-
 slirp/if.c       |  2 +-
 slirp/ip6_icmp.c | 15 +++++++++------
 slirp/ip_icmp.c  |  2 +-
 slirp/misc.c     |  2 +-
 slirp/slirp.c    | 13 ++++++-------
 slirp/socket.c   |  2 +-
 slirp/tcp_subr.c |  8 ++++----
 slirp/udp.c      |  2 +-
 11 files changed, 49 insertions(+), 40 deletions(-)

diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index b5c1b2122bc..9b13d8250c6 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -40,21 +40,21 @@ typedef struct SlirpCb {
      */
     SlirpWriteCb send_packet;
     /* Print a message for an error due to guest misbehavior.  */
-    void (*guest_error)(const char *msg);
+    void (*guest_error)(const char *msg, void *opaque);
     /* Return the virtual clock value in nanoseconds */
-    int64_t (*clock_get_ns)(void);
+    int64_t (*clock_get_ns)(void *opaque);
     /* Create a new timer with the given callback and opaque data */
-    void *(*timer_new)(SlirpTimerCb cb, void *opaque);
+    void *(*timer_new)(SlirpTimerCb cb, void *cb_opaque, void *opaque);
     /* Remove and free a timer */
-    void (*timer_free)(void *timer);
+    void (*timer_free)(void *timer, void *opaque);
     /* Modify a timer to expire at @expire_time */
-    void (*timer_mod)(void *timer, int64_t expire_time);
+    void (*timer_mod)(void *timer, int64_t expire_time, void *opaque);
     /* Register a fd for future polling */
-    void (*register_poll_fd)(int fd);
+    void (*register_poll_fd)(int fd, void *opaque);
     /* Unregister a fd */
-    void (*unregister_poll_fd)(int fd);
+    void (*unregister_poll_fd)(int fd, void *opaque);
     /* Kick the io-thread, to signal that new events may be processed */
-    void (*notify)(void);
+    void (*notify)(void *opaque);
 } SlirpCb;
=20
=20
diff --git a/net/slirp.c b/net/slirp.c
index a85e42ff432..7a16d8d6150 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -161,44 +161,51 @@ static NetClientInfo net_slirp_info =3D {
     .cleanup =3D net_slirp_cleanup,
 };
=20
-static void net_slirp_guest_error(const char *msg)
+static void net_slirp_guest_error(const char *msg, void *opaque)
 {
     qemu_log_mask(LOG_GUEST_ERROR, "%s", msg);
 }
=20
-static int64_t net_slirp_clock_get_ns(void)
+static int64_t net_slirp_clock_get_ns(void *opaque)
 {
     return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 }
=20
-static void *net_slirp_timer_new(SlirpTimerCb cb, void *opaque)
+static void *net_slirp_timer_new(SlirpTimerCb cb,
+                                 void *cb_opaque, void *opaque)
 {
     return timer_new_full(NULL, QEMU_CLOCK_VIRTUAL,
                           SCALE_MS, QEMU_TIMER_ATTR_EXTERNAL,
-                          cb, opaque);
+                          cb, cb_opaque);
 }
=20
-static void net_slirp_timer_free(void *timer)
+static void net_slirp_timer_free(void *timer, void *opaque)
 {
     timer_del(timer);
     timer_free(timer);
 }
=20
-static void net_slirp_timer_mod(void *timer, int64_t expire_timer)
+static void net_slirp_timer_mod(void *timer, int64_t expire_timer,
+                                void *opaque)
 {
     timer_mod(timer, expire_timer);
 }
=20
-static void net_slirp_register_poll_fd(int fd)
+static void net_slirp_register_poll_fd(int fd, void *opaque)
 {
     qemu_fd_register(fd);
 }
=20
-static void net_slirp_unregister_poll_fd(int fd)
+static void net_slirp_unregister_poll_fd(int fd, void *opaque)
 {
     /* no qemu_fd_unregister */
 }
=20
+static void net_slirp_notify(void *opaque)
+{
+    qemu_notify_event();
+}
+
 static const SlirpCb slirp_cb =3D {
     .send_packet =3D net_slirp_send_packet,
     .guest_error =3D net_slirp_guest_error,
@@ -208,7 +215,7 @@ static const SlirpCb slirp_cb =3D {
     .timer_mod =3D net_slirp_timer_mod,
     .register_poll_fd =3D net_slirp_register_poll_fd,
     .unregister_poll_fd =3D net_slirp_unregister_poll_fd,
-    .notify =3D qemu_notify_event,
+    .notify =3D net_slirp_notify,
 };
=20
 static int slirp_poll_to_gio(int events)
diff --git a/slirp/dhcpv6.c b/slirp/dhcpv6.c
index 9ffba38e8f4..e655c7d5b10 100644
--- a/slirp/dhcpv6.c
+++ b/slirp/dhcpv6.c
@@ -59,7 +59,7 @@ static int dhcpv6_parse_info_request(Slirp *slirp, uint=
8_t *odata, int olen,
         int len =3D odata[2] << 8 | odata[3];
=20
         if (len + 4 > olen) {
-            slirp->cb->guest_error("Guest sent bad DHCPv6 packet!");
+            slirp->cb->guest_error("Guest sent bad DHCPv6 packet!", slir=
p->opaque);
             return -E2BIG;
         }
=20
diff --git a/slirp/if.c b/slirp/if.c
index 2ad03b8a79b..1830cc396c5 100644
--- a/slirp/if.c
+++ b/slirp/if.c
@@ -146,7 +146,7 @@ diddit:
  */
 void if_start(Slirp *slirp)
 {
-    uint64_t now =3D slirp->cb->clock_get_ns();
+    uint64_t now =3D slirp->cb->clock_get_ns(slirp->opaque);
     bool from_batchq =3D false;
     struct mbuf *ifm, *ifm_next, *ifqt;
=20
diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
index 2a432ebbd48..c1e3d30470a 100644
--- a/slirp/ip6_icmp.c
+++ b/slirp/ip6_icmp.c
@@ -14,7 +14,8 @@ static void ra_timer_handler(void *opaque)
     Slirp *slirp =3D opaque;
=20
     slirp->cb->timer_mod(slirp->ra_timer,
-                         slirp->cb->clock_get_ns() / SCALE_MS + NDP_Inte=
rval);
+        slirp->cb->clock_get_ns(slirp->opaque) / SCALE_MS + NDP_Interval=
,
+        slirp->opaque);
     ndp_send_ra(slirp);
 }
=20
@@ -24,9 +25,10 @@ void icmp6_init(Slirp *slirp)
         return;
     }
=20
-    slirp->ra_timer =3D slirp->cb->timer_new(ra_timer_handler, slirp);
+    slirp->ra_timer =3D slirp->cb->timer_new(ra_timer_handler, slirp, sl=
irp->opaque);
     slirp->cb->timer_mod(slirp->ra_timer,
-                         slirp->cb->clock_get_ns() / SCALE_MS + NDP_Inte=
rval);
+        slirp->cb->clock_get_ns(slirp->opaque) / SCALE_MS + NDP_Interval=
,
+        slirp->opaque);
 }
=20
 void icmp6_cleanup(Slirp *slirp)
@@ -35,7 +37,7 @@ void icmp6_cleanup(Slirp *slirp)
         return;
     }
=20
-    slirp->cb->timer_free(slirp->ra_timer);
+    slirp->cb->timer_free(slirp->ra_timer, slirp->opaque);
 }
=20
 static void icmp6_send_echoreply(struct mbuf *m, Slirp *slirp, struct ip=
6 *ip,
@@ -334,7 +336,8 @@ static void ndp_input(struct mbuf *m, Slirp *slirp, s=
truct ip6 *ip,
=20
     case ICMP6_NDP_RA:
         DEBUG_CALL(" type =3D Router Advertisement");
-        slirp->cb->guest_error("Warning: guest sent NDP RA, but shouldn'=
t");
+        slirp->cb->guest_error("Warning: guest sent NDP RA, but shouldn'=
t",
+                               slirp->opaque);
         break;
=20
     case ICMP6_NDP_NS:
@@ -368,7 +371,7 @@ static void ndp_input(struct mbuf *m, Slirp *slirp, s=
truct ip6 *ip,
     case ICMP6_NDP_REDIRECT:
         DEBUG_CALL(" type =3D Redirect");
         slirp->cb->guest_error(
-            "Warning: guest sent NDP REDIRECT, but shouldn't");
+            "Warning: guest sent NDP REDIRECT, but shouldn't", slirp->op=
aque);
         break;
     }
 }
diff --git a/slirp/ip_icmp.c b/slirp/ip_icmp.c
index 7c5cb75ae51..ce79c0b051c 100644
--- a/slirp/ip_icmp.c
+++ b/slirp/ip_icmp.c
@@ -113,7 +113,7 @@ static int icmp_send(struct socket *so, struct mbuf *=
m, int hlen)
=20
 void icmp_detach(struct socket *so)
 {
-    so->slirp->cb->unregister_poll_fd(so->s);
+    so->slirp->cb->unregister_poll_fd(so->s, so->slirp->opaque);
     slirp_closesocket(so->s);
     sofree(so);
 }
diff --git a/slirp/misc.c b/slirp/misc.c
index 4662071be0a..edb0d187d7d 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -160,7 +160,7 @@ fork_exec(struct socket *so, const char *ex)
     opt =3D 1;
     slirp_setsockopt(so->s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int))=
;
     slirp_set_nonblock(so->s);
-    so->slirp->cb->register_poll_fd(so->s);
+    so->slirp->cb->register_poll_fd(so->s, so->slirp->opaque);
     return 1;
 }
=20
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 8fb3ae06c41..b50fba95853 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -289,6 +289,7 @@ Slirp *slirp_init(int restricted, bool in_enabled, st=
ruct in_addr vnetwork,
=20
     slirp_init_once();
=20
+    slirp->opaque =3D opaque;
     slirp->cb =3D callbacks;
     slirp->grand =3D g_rand_new();
     slirp->restricted =3D restricted;
@@ -325,12 +326,9 @@ Slirp *slirp_init(int restricted, bool in_enabled, s=
truct in_addr vnetwork,
         translate_dnssearch(slirp, vdnssearch);
     }
=20
-    slirp->opaque =3D opaque;
-
 #ifdef WITH_QEMU
     slirp_state_register(slirp);
 #endif
-
     return slirp;
 }
=20
@@ -537,7 +535,7 @@ void slirp_pollfds_poll(Slirp *slirp, int select_erro=
r,
     struct socket *so, *so_next;
     int ret;
=20
-    curtime =3D slirp->cb->clock_get_ns() / SCALE_MS;
+    curtime =3D slirp->cb->clock_get_ns(slirp->opaque) / SCALE_MS;
=20
     /*
      * See if anything has timed out
@@ -860,7 +858,8 @@ static int if_encap4(Slirp *slirp, struct mbuf *ifm, =
struct ethhdr *eh,
             ifm->resolution_requested =3D true;
=20
             /* Expire request and drop outgoing packet after 1 second */
-            ifm->expiration_date =3D slirp->cb->clock_get_ns() + 1000000=
000ULL;
+            ifm->expiration_date =3D
+                slirp->cb->clock_get_ns(slirp->opaque) + 1000000000ULL;
         }
         return 0;
     } else {
@@ -886,7 +885,7 @@ static int if_encap6(Slirp *slirp, struct mbuf *ifm, =
struct ethhdr *eh,
         if (!ifm->resolution_requested) {
             ndp_send_ns(slirp, ip6h->ip_dst);
             ifm->resolution_requested =3D true;
-            ifm->expiration_date =3D slirp->cb->clock_get_ns() + 1000000=
000ULL;
+            ifm->expiration_date =3D slirp->cb->clock_get_ns(slirp->opaq=
ue) + 1000000000ULL;
         }
         return 0;
     } else {
@@ -961,7 +960,7 @@ int slirp_remove_hostfwd(Slirp *slirp, int is_udp, st=
ruct in_addr host_addr,
             getsockname(so->s, (struct sockaddr *)&addr, &addr_len) =3D=3D=
 0 &&
             addr.sin_addr.s_addr =3D=3D host_addr.s_addr &&
             addr.sin_port =3D=3D port) {
-            so->slirp->cb->unregister_poll_fd(so->s);
+            so->slirp->cb->unregister_poll_fd(so->s, so->slirp->opaque);
             slirp_closesocket(so->s);
             sofree(so);
             return 0;
diff --git a/slirp/socket.c b/slirp/socket.c
index c896fa6da33..ce1d6ffa1d2 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -930,6 +930,6 @@ void sotranslate_accept(struct socket *so)
 void sodrop(struct socket *s, int num)
 {
     if (sbdrop(&s->so_snd, num)) {
-        s->slirp->cb->notify();
+        s->slirp->cb->notify(s->slirp->opaque);
     }
 }
diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index e35628a892a..cda94815f62 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -336,7 +336,7 @@ tcp_close(struct tcpcb *tp)
 	/* clobber input socket cache if we're closing the cached connection */
 	if (so =3D=3D slirp->tcp_last_so)
 		slirp->tcp_last_so =3D &slirp->tcb;
-	so->slirp->cb->unregister_poll_fd(so->s);
+	so->slirp->cb->unregister_poll_fd(so->s, so->slirp->opaque);
 	slirp_closesocket(so->s);
 	sbfree(&so->so_rcv);
 	sbfree(&so->so_snd);
@@ -413,7 +413,7 @@ int tcp_fconnect(struct socket *so, unsigned short af=
)
     struct sockaddr_storage addr;
=20
     slirp_set_nonblock(s);
-    so->slirp->cb->register_poll_fd(so->s);
+    so->slirp->cb->register_poll_fd(so->s, so->slirp->opaque);
     slirp_socket_set_fast_reuse(s);
     opt =3D 1;
     slirp_setsockopt(s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(opt));
@@ -486,7 +486,7 @@ void tcp_connect(struct socket *inso)
         return;
     }
     slirp_set_nonblock(s);
-    so->slirp->cb->register_poll_fd(so->s);
+    so->slirp->cb->register_poll_fd(so->s, so->slirp->opaque);
     slirp_socket_set_fast_reuse(s);
     opt =3D 1;
     slirp_setsockopt(s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int));
@@ -498,7 +498,7 @@ void tcp_connect(struct socket *inso)
     /* Close the accept() socket, set right state */
     if (inso->so_state & SS_FACCEPTONCE) {
         /* If we only accept once, close the accept() socket */
-        so->slirp->cb->unregister_poll_fd(so->s);
+        so->slirp->cb->unregister_poll_fd(so->s, so->slirp->opaque);
         slirp_closesocket(so->s);
=20
         /* Don't select it yet, even though we have an FD */
diff --git a/slirp/udp.c b/slirp/udp.c
index 5baa604b33a..29a31e9400d 100644
--- a/slirp/udp.c
+++ b/slirp/udp.c
@@ -291,7 +291,7 @@ udp_attach(struct socket *so, unsigned short af)
 void
 udp_detach(struct socket *so)
 {
-	so->slirp->cb->unregister_poll_fd(so->s);
+	so->slirp->cb->unregister_poll_fd(so->s, so->slirp->opaque);
 	slirp_closesocket(so->s);
 	sofree(so);
 }
--=20
2.20.1.98.gecbdaf0899
