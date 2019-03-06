Received: from eggs.gnu.org ([209.51.188.92]:47408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h1gR7-00038F-Cn
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 18:58:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h1gR6-0003lY-5y
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 18:58:57 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:51684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1h1gR5-0003kt-Rw
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 18:58:56 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Thu,  7 Mar 2019 00:58:43 +0100
Message-Id: <20190306235850.30110-6-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190306235850.30110-1-samuel.thibault@ens-lyon.org>
References: <20190306235850.30110-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/12] slirp: Mark pieces missing IPv6 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com, jan.kiszka@siemens.com

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 net/slirp.c       | 1 +
 slirp/misc.c      | 3 +++
 slirp/slirp.c     | 5 +++++
 slirp/socket.c    | 1 +
 slirp/tcp_input.c | 2 ++
 slirp/tcp_subr.c  | 2 ++
 slirp/udp.c       | 1 +
 7 files changed, 15 insertions(+)

diff --git a/net/slirp.c b/net/slirp.c
index 4ec989b592..a8fd9e6364 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -885,6 +885,7 @@ static ssize_t guestfwd_write(const void *buf, size_t=
 len, void *chr)
=20
 static int slirp_guestfwd(SlirpState *s, const char *config_str, Error *=
*errp)
 {
+    /* TODO: IPv6 */
     struct in_addr server =3D { .s_addr =3D 0 };
     struct GuestFwd *fwd;
     const char *p;
diff --git a/slirp/misc.c b/slirp/misc.c
index d9fc586a24..937a418d4e 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -28,6 +28,7 @@ remque(void *a)
   element->qh_rlink =3D NULL;
 }
=20
+/* TODO: IPv6 */
 struct gfwd_list *
 add_guestfwd(struct gfwd_list **ex_ptr,
              SlirpWriteCb write_cb, void *opaque,
@@ -254,6 +255,8 @@ char *slirp_connection_info(Slirp *slirp)
         "  Protocol[State]    FD  Source Address  Port   "
         "Dest. Address  Port RecvQ SendQ\n");
=20
+    /* TODO: IPv6 */
+
     for (so =3D slirp->tcb.so_next; so !=3D &slirp->tcb; so =3D so->so_n=
ext) {
         if (so->so_state & SS_HOSTFWD) {
             state =3D "HOST_FORWARD";
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 55591430dc..cbdf9f778d 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -729,6 +729,7 @@ static void arp_input(Slirp *slirp, const uint8_t *pk=
t, int pkt_len)
             if (ah->ar_tip =3D=3D slirp->vnameserver_addr.s_addr ||
                 ah->ar_tip =3D=3D slirp->vhost_addr.s_addr)
                 goto arp_ok;
+            /* TODO: IPv6 */
             for (ex_ptr =3D slirp->guestfwd_list; ex_ptr; ex_ptr =3D ex_=
ptr->ex_next) {
                 if (ex_ptr->ex_addr.s_addr =3D=3D ah->ar_tip)
                     goto arp_ok;
@@ -945,6 +946,7 @@ int if_encap(Slirp *slirp, struct mbuf *ifm)
 }
=20
 /* Drop host forwarding rule, return 0 if found. */
+/* TODO: IPv6 */
 int slirp_remove_hostfwd(Slirp *slirp, int is_udp, struct in_addr host_a=
ddr,
                          int host_port)
 {
@@ -970,6 +972,7 @@ int slirp_remove_hostfwd(Slirp *slirp, int is_udp, st=
ruct in_addr host_addr,
     return -1;
 }
=20
+/* TODO: IPv6 */
 int slirp_add_hostfwd(Slirp *slirp, int is_udp, struct in_addr host_addr=
,
                       int host_port, struct in_addr guest_addr, int gues=
t_port)
 {
@@ -988,6 +991,7 @@ int slirp_add_hostfwd(Slirp *slirp, int is_udp, struc=
t in_addr host_addr,
     return 0;
 }
=20
+/* TODO: IPv6 */
 static bool
 check_guestfwd(Slirp *slirp, struct in_addr *guest_addr, int guest_port)
 {
@@ -1065,6 +1069,7 @@ slirp_find_ctl_socket(Slirp *slirp, struct in_addr =
guest_addr, int guest_port)
 {
     struct socket *so;
=20
+    /* TODO: IPv6 */
     for (so =3D slirp->tcb.so_next; so !=3D &slirp->tcb; so =3D so->so_n=
ext) {
         if (so->so_faddr.s_addr =3D=3D guest_addr.s_addr &&
             htons(so->so_fport) =3D=3D guest_port) {
diff --git a/slirp/socket.c b/slirp/socket.c
index 4dc5e2907d..f2428a3ae8 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -687,6 +687,7 @@ struct socket *
 tcp_listen(Slirp *slirp, uint32_t haddr, unsigned hport, uint32_t laddr,
            unsigned lport, int flags)
 {
+        /* TODO: IPv6 */
 	struct sockaddr_in addr;
 	struct socket *so;
 	int s, opt =3D 1;
diff --git a/slirp/tcp_input.c b/slirp/tcp_input.c
index 6749b32f5d..b10477fc57 100644
--- a/slirp/tcp_input.c
+++ b/slirp/tcp_input.c
@@ -388,6 +388,7 @@ findso:
 	 * as if it was LISTENING, and continue...
 	 */
         if (so =3D=3D NULL) {
+          /* TODO: IPv6 */
           if (slirp->restricted) {
             /* Any hostfwds will have an existing socket, so we only get=
 here
              * for non-hostfwd connections. These should be dropped, unl=
ess it
@@ -609,6 +610,7 @@ findso:
 	   * If this is destined for the control address, then flag to
 	   * tcp_ctl once connected, otherwise connect
 	   */
+          /* TODO: IPv6 */
 	  if (af =3D=3D AF_INET &&
 	         (so->so_faddr.s_addr & slirp->vnetwork_mask.s_addr) =3D=3D
 	         slirp->vnetwork_addr.s_addr) {
diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index 1d7e72dca7..1db59caa89 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -626,6 +626,7 @@ tcp_emu(struct socket *so, struct mbuf *m)
 	switch(so->so_emu) {
 		int x, i;
=20
+        /* TODO: IPv6 */
 	 case EMU_IDENT:
 		/*
 		 * Identification protocol as per rfc-1413
@@ -964,6 +965,7 @@ int tcp_ctl(struct socket *so)
     DEBUG_CALL("tcp_ctl");
     DEBUG_ARG("so =3D %p", so);
=20
+    /* TODO: IPv6 */
     if (so->so_faddr.s_addr !=3D slirp->vhost_addr.s_addr) {
         /* Check if it's pty_exec */
         for (ex_ptr =3D slirp->guestfwd_list; ex_ptr; ex_ptr =3D ex_ptr-=
>ex_next) {
diff --git a/slirp/udp.c b/slirp/udp.c
index 3d9a19b85a..fa9f4a08bd 100644
--- a/slirp/udp.c
+++ b/slirp/udp.c
@@ -322,6 +322,7 @@ struct socket *
 udp_listen(Slirp *slirp, uint32_t haddr, unsigned hport, uint32_t laddr,
            unsigned lport, int flags)
 {
+        /* TODO: IPv6 */
 	struct sockaddr_in addr;
 	struct socket *so;
 	socklen_t addrlen =3D sizeof(struct sockaddr_in);
--=20
2.20.1
