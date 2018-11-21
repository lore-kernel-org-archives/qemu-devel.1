Received: from eggs.gnu.org ([2001:4830:134:3::10]:50534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPaem-0003si-6W
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:07:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPaei-0001fQ-5G
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:07:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gPaeh-0001ZR-UF
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:07:32 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Nov 2018 02:06:22 +0400
Message-Id: <20181121220647.18844-6-marcandre.lureau@redhat.com>
In-Reply-To: <20181121220647.18844-1-marcandre.lureau@redhat.com>
References: <20181121220647.18844-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 for-3.2 v2 05/30] slirp: rename exec_list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This list is not only used to handle command to execute on guest
connection, it can also redirect to an arbitrary object, such as a
chardev. Let's rename the struct and the field to "guestfwd".

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/misc.h      |  6 +++---
 slirp/slirp.h     |  2 +-
 slirp/misc.c      |  6 +++---
 slirp/slirp.c     | 18 +++++++++---------
 slirp/tcp_input.c |  6 +++---
 slirp/tcp_subr.c  |  4 ++--
 6 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/slirp/misc.h b/slirp/misc.h
index 0bc5e74bc5..1df707c052 100644
--- a/slirp/misc.h
+++ b/slirp/misc.h
@@ -8,12 +8,12 @@
 #ifndef MISC_H
 #define MISC_H
=20
-struct ex_list {
+struct gfwd_list {
 	void *ex_chardev;
 	struct in_addr ex_addr;		/* Server address */
 	int ex_fport;                   /* Port to telnet to */
 	char *ex_exec;                  /* Command line of what to exec */
-	struct ex_list *ex_next;
+	struct gfwd_list *ex_next;
 };
=20
 #define EMU_NONE 0x0
@@ -51,7 +51,7 @@ struct slirp_quehead {
=20
 void slirp_insque(void *, void *);
 void slirp_remque(void *);
-int add_exec(struct ex_list **, void *, const char *, struct in_addr, in=
t);
+int add_exec(struct gfwd_list **, void *, const char *, struct in_addr, =
int);
 int fork_exec(struct socket *so, const char *ex);
=20
 #endif
diff --git a/slirp/slirp.h b/slirp/slirp.h
index fdf397256b..9aa245715d 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -147,7 +147,7 @@ struct Slirp {
     char client_hostname[33];
=20
     int restricted;
-    struct ex_list *exec_list;
+    struct gfwd_list *guestfwd_list;
=20
     /* mbuf states */
     struct quehead m_freelist;
diff --git a/slirp/misc.c b/slirp/misc.c
index 753b3da25b..cf7cc3a787 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -36,10 +36,10 @@ remque(void *a)
   element->qh_rlink =3D NULL;
 }
=20
-int add_exec(struct ex_list **ex_ptr, void *chardev, const char *cmdline=
,
+int add_exec(struct gfwd_list **ex_ptr, void *chardev, const char *cmdli=
ne,
              struct in_addr addr, int port)
 {
-	struct ex_list *tmp_ptr;
+	struct gfwd_list *tmp_ptr;
=20
 	/* First, check if the port is "bound" */
 	for (tmp_ptr =3D *ex_ptr; tmp_ptr; tmp_ptr =3D tmp_ptr->ex_next) {
@@ -49,7 +49,7 @@ int add_exec(struct ex_list **ex_ptr, void *chardev, co=
nst char *cmdline,
 	}
=20
 	tmp_ptr =3D *ex_ptr;
-	*ex_ptr =3D g_new0(struct ex_list, 1);
+	*ex_ptr =3D g_new0(struct gfwd_list, 1);
 	(*ex_ptr)->ex_fport =3D port;
 	(*ex_ptr)->ex_addr =3D addr;
 	if (chardev) {
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 8da528afaa..4949d17c73 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -345,9 +345,9 @@ Slirp *slirp_init(int restricted, bool in_enabled, st=
ruct in_addr vnetwork,
=20
 void slirp_cleanup(Slirp *slirp)
 {
-    struct ex_list *e, *next;
+    struct gfwd_list *e, *next;
=20
-    for (e =3D slirp->exec_list; e; e =3D next) {
+    for (e =3D slirp->guestfwd_list; e; e =3D next) {
         next =3D e->ex_next;
         g_free(e->ex_exec);
         g_free(e);
@@ -760,7 +760,7 @@ static void arp_input(Slirp *slirp, const uint8_t *pk=
t, int pkt_len)
     struct ethhdr *reh =3D (struct ethhdr *)arp_reply;
     struct slirp_arphdr *rah =3D (struct slirp_arphdr *)(arp_reply + ETH=
_HLEN);
     int ar_op;
-    struct ex_list *ex_ptr;
+    struct gfwd_list *ex_ptr;
=20
     if (!slirp->in_enabled) {
         return;
@@ -780,7 +780,7 @@ static void arp_input(Slirp *slirp, const uint8_t *pk=
t, int pkt_len)
             if (ah->ar_tip =3D=3D slirp->vnameserver_addr.s_addr ||
                 ah->ar_tip =3D=3D slirp->vhost_addr.s_addr)
                 goto arp_ok;
-            for (ex_ptr =3D slirp->exec_list; ex_ptr; ex_ptr =3D ex_ptr-=
>ex_next) {
+            for (ex_ptr =3D slirp->guestfwd_list; ex_ptr; ex_ptr =3D ex_=
ptr->ex_next) {
                 if (ex_ptr->ex_addr.s_addr =3D=3D ah->ar_tip)
                     goto arp_ok;
             }
@@ -1052,7 +1052,7 @@ int slirp_add_exec(Slirp *slirp, void *chardev, con=
st char *cmdline,
         return -1;
     }
=20
-    return add_exec(&slirp->exec_list, chardev, cmdline, *guest_addr,
+    return add_exec(&slirp->guestfwd_list, chardev, cmdline, *guest_addr=
,
                     htons(guest_port));
 }
=20
@@ -1423,9 +1423,9 @@ static const VMStateDescription vmstate_slirp =3D {
 static void slirp_state_save(QEMUFile *f, void *opaque)
 {
     Slirp *slirp =3D opaque;
-    struct ex_list *ex_ptr;
+    struct gfwd_list *ex_ptr;
=20
-    for (ex_ptr =3D slirp->exec_list; ex_ptr; ex_ptr =3D ex_ptr->ex_next=
)
+    for (ex_ptr =3D slirp->guestfwd_list; ex_ptr; ex_ptr =3D ex_ptr->ex_=
next)
         if (ex_ptr->ex_chardev) {
             struct socket *so;
             so =3D slirp_find_ctl_socket(slirp, ex_ptr->ex_addr,
@@ -1445,7 +1445,7 @@ static void slirp_state_save(QEMUFile *f, void *opa=
que)
 static int slirp_state_load(QEMUFile *f, void *opaque, int version_id)
 {
     Slirp *slirp =3D opaque;
-    struct ex_list *ex_ptr;
+    struct gfwd_list *ex_ptr;
=20
     while (qemu_get_byte(f)) {
         int ret;
@@ -1460,7 +1460,7 @@ static int slirp_state_load(QEMUFile *f, void *opaq=
ue, int version_id)
             slirp->vnetwork_addr.s_addr) {
             return -EINVAL;
         }
-        for (ex_ptr =3D slirp->exec_list; ex_ptr; ex_ptr =3D ex_ptr->ex_=
next) {
+        for (ex_ptr =3D slirp->guestfwd_list; ex_ptr; ex_ptr =3D ex_ptr-=
>ex_next) {
             if (ex_ptr->ex_chardev &&
                 so->so_faddr.s_addr =3D=3D ex_ptr->ex_addr.s_addr &&
                 so->so_fport =3D=3D ex_ptr->ex_fport) {
diff --git a/slirp/tcp_input.c b/slirp/tcp_input.c
index b67ec24075..bc4aa60046 100644
--- a/slirp/tcp_input.c
+++ b/slirp/tcp_input.c
@@ -211,7 +211,7 @@ tcp_input(struct mbuf *m, int iphlen, struct socket *=
inso, unsigned short af)
 	struct sockaddr_storage lhost, fhost;
 	struct sockaddr_in *lhost4, *fhost4;
 	struct sockaddr_in6 *lhost6, *fhost6;
-    struct ex_list *ex_ptr;
+    struct gfwd_list *ex_ptr;
     Slirp *slirp;
=20
 	DEBUG_CALL("tcp_input");
@@ -394,7 +394,7 @@ findso:
              * for non-hostfwd connections. These should be dropped, unl=
ess it
              * happens to be a guestfwd.
              */
-            for (ex_ptr =3D slirp->exec_list; ex_ptr; ex_ptr =3D ex_ptr-=
>ex_next) {
+            for (ex_ptr =3D slirp->guestfwd_list; ex_ptr; ex_ptr =3D ex_=
ptr->ex_next) {
                 if (ex_ptr->ex_fport =3D=3D ti->ti_dport &&
                     ti->ti_dst.s_addr =3D=3D ex_ptr->ex_addr.s_addr) {
                     break;
@@ -616,7 +616,7 @@ findso:
 	    if (so->so_faddr.s_addr !=3D slirp->vhost_addr.s_addr &&
 		so->so_faddr.s_addr !=3D slirp->vnameserver_addr.s_addr) {
 		/* May be an add exec */
-		for (ex_ptr =3D slirp->exec_list; ex_ptr;
+		for (ex_ptr =3D slirp->guestfwd_list; ex_ptr;
 		     ex_ptr =3D ex_ptr->ex_next) {
 		  if(ex_ptr->ex_fport =3D=3D so->so_fport &&
 		     so->so_faddr.s_addr =3D=3D ex_ptr->ex_addr.s_addr) {
diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index 00cee73163..3b14684107 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -949,14 +949,14 @@ int tcp_ctl(struct socket *so)
 {
     Slirp *slirp =3D so->slirp;
     struct sbuf *sb =3D &so->so_snd;
-    struct ex_list *ex_ptr;
+    struct gfwd_list *ex_ptr;
=20
     DEBUG_CALL("tcp_ctl");
     DEBUG_ARG("so =3D %p", so);
=20
     if (so->so_faddr.s_addr !=3D slirp->vhost_addr.s_addr) {
         /* Check if it's pty_exec */
-        for (ex_ptr =3D slirp->exec_list; ex_ptr; ex_ptr =3D ex_ptr->ex_=
next) {
+        for (ex_ptr =3D slirp->guestfwd_list; ex_ptr; ex_ptr =3D ex_ptr-=
>ex_next) {
             if (ex_ptr->ex_fport =3D=3D so->so_fport &&
                 so->so_faddr.s_addr =3D=3D ex_ptr->ex_addr.s_addr) {
                 if (ex_ptr->ex_chardev) {
--=20
2.20.0.rc1
