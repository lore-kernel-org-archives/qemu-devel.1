Received: from eggs.gnu.org ([2001:4830:134:3::10]:50642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPaf1-00049o-03
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:07:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPaew-0001sT-Tk
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:07:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gPaew-0001qt-Kp
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:07:46 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Nov 2018 02:06:24 +0400
Message-Id: <20181121220647.18844-8-marcandre.lureau@redhat.com>
In-Reply-To: <20181121220647.18844-1-marcandre.lureau@redhat.com>
References: <20181121220647.18844-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 for-3.2 v2 07/30] slirp: generalize guestfwd
 with a callback based approach
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

Instead of calling into QEMU chardev directly, and mixing it with
slirp_add_exec() handling, add a new function slirp_add_guestfwd()
which takes a write callback.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/libslirp.h |  6 +++++-
 slirp/misc.h     | 15 +++++++++++++--
 slirp/socket.h   |  4 +++-
 net/slirp.c      | 14 ++++++++++----
 slirp/misc.c     | 37 +++++++++++++++++++++++--------------
 slirp/slirp.c    | 27 +++++++++++++++++++--------
 slirp/tcp_subr.c |  4 ++--
 7 files changed, 75 insertions(+), 32 deletions(-)

diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index 3e0aa19f4b..d7c2b1ae71 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -5,6 +5,8 @@
=20
 typedef struct Slirp Slirp;
=20
+typedef int (*SlirpWriteCb)(const void *buf, size_t len, void *opaque);
+
 /*
  * Callbacks from slirp
  *
@@ -43,7 +45,9 @@ int slirp_add_hostfwd(Slirp *slirp, int is_udp,
                       struct in_addr guest_addr, int guest_port);
 int slirp_remove_hostfwd(Slirp *slirp, int is_udp,
                          struct in_addr host_addr, int host_port);
-int slirp_add_exec(Slirp *slirp, void *chardev, const char *cmdline,
+int slirp_add_exec(Slirp *slirp, const char *cmdline,
+                   struct in_addr *guest_addr, int guest_port);
+int slirp_add_guestfwd(Slirp *slirp, SlirpWriteCb write_cb, void *opaque=
,
                    struct in_addr *guest_addr, int guest_port);
=20
 char *slirp_connection_info(Slirp *slirp);
diff --git a/slirp/misc.h b/slirp/misc.h
index 1df707c052..c2ceadb591 100644
--- a/slirp/misc.h
+++ b/slirp/misc.h
@@ -8,8 +8,11 @@
 #ifndef MISC_H
 #define MISC_H
=20
+#include "libslirp.h"
+
 struct gfwd_list {
-	void *ex_chardev;
+	SlirpWriteCb write_cb;
+	void *opaque;
 	struct in_addr ex_addr;		/* Server address */
 	int ex_fport;                   /* Port to telnet to */
 	char *ex_exec;                  /* Command line of what to exec */
@@ -51,7 +54,15 @@ struct slirp_quehead {
=20
 void slirp_insque(void *, void *);
 void slirp_remque(void *);
-int add_exec(struct gfwd_list **, void *, const char *, struct in_addr, =
int);
 int fork_exec(struct socket *so, const char *ex);
=20
+struct gfwd_list *
+add_guestfwd(struct gfwd_list **ex_ptr,
+             SlirpWriteCb write_cb, void *opaque,
+             struct in_addr addr, int port);
+
+struct gfwd_list *
+add_exec(struct gfwd_list **ex_ptr, const char *cmdline,
+         struct in_addr addr, int port);
+
 #endif
diff --git a/slirp/socket.h b/slirp/socket.h
index 930ed95972..fc35ca5f72 100644
--- a/slirp/socket.h
+++ b/slirp/socket.h
@@ -8,6 +8,8 @@
 #ifndef SLIRP_SOCKET_H
 #define SLIRP_SOCKET_H
=20
+#include "misc.h"
+
 #define SO_EXPIRE 240000
 #define SO_EXPIREFAST 10000
=20
@@ -25,6 +27,7 @@ struct socket {
   struct socket *so_next,*so_prev;      /* For a linked list of sockets =
*/
=20
   int s;                           /* The actual socket */
+  struct gfwd_list *guestfwd;
=20
   int pollfds_idx;                 /* GPollFD GArray index */
=20
@@ -67,7 +70,6 @@ struct socket {
=20
   struct sbuf so_rcv;		/* Receive buffer */
   struct sbuf so_snd;		/* Send buffer */
-  void * chardev;
 };
=20
=20
diff --git a/net/slirp.c b/net/slirp.c
index 4d890287ba..53adb92dd5 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -698,8 +698,8 @@ static int slirp_smb(SlirpState* s, const char *expor=
ted_dir,
              CONFIG_SMBD_COMMAND, s->smb_dir, smb_conf);
     g_free(smb_conf);
=20
-    if (slirp_add_exec(s->slirp, NULL, smb_cmdline, &vserver_addr, 139) =
< 0 ||
-        slirp_add_exec(s->slirp, NULL, smb_cmdline, &vserver_addr, 445) =
< 0) {
+    if (slirp_add_exec(s->slirp, smb_cmdline, &vserver_addr, 139) < 0 ||
+        slirp_add_exec(s->slirp, smb_cmdline, &vserver_addr, 445) < 0) {
         slirp_smb_cleanup(s);
         g_free(smb_cmdline);
         error_setg(errp, "Conflicting/invalid smbserver address");
@@ -730,6 +730,11 @@ static void guestfwd_read(void *opaque, const uint8_=
t *buf, int size)
     slirp_socket_recv(fwd->slirp, fwd->server, fwd->port, buf, size);
 }
=20
+static int guestfwd_write(const void *buf, size_t len, void *chr)
+{
+    return qemu_chr_fe_write_all(chr, buf, len);
+}
+
 static int slirp_guestfwd(SlirpState *s, const char *config_str, Error *=
*errp)
 {
     struct in_addr server =3D { .s_addr =3D 0 };
@@ -763,7 +768,7 @@ static int slirp_guestfwd(SlirpState *s, const char *=
config_str, Error **errp)
     snprintf(buf, sizeof(buf), "guestfwd.tcp.%d", port);
=20
     if ((strlen(p) > 4) && !strncmp(p, "cmd:", 4)) {
-        if (slirp_add_exec(s->slirp, NULL, &p[4], &server, port) < 0) {
+        if (slirp_add_exec(s->slirp, &p[4], &server, port) < 0) {
             error_setg(errp, "Conflicting/invalid host:port in guest "
                        "forwarding rule '%s'", config_str);
             return -1;
@@ -790,7 +795,8 @@ static int slirp_guestfwd(SlirpState *s, const char *=
config_str, Error **errp)
             return -1;
         }
=20
-        if (slirp_add_exec(s->slirp, &fwd->hd, NULL, &server, port) < 0)=
 {
+        if (slirp_add_guestfwd(s->slirp, guestfwd_write, &fwd->hd,
+                               &server, port) < 0) {
             error_setg(errp, "Conflicting/invalid host:port in guest "
                        "forwarding rule '%s'", config_str);
             g_free(fwd);
diff --git a/slirp/misc.c b/slirp/misc.c
index 03bfa31f20..7c2ed8c67f 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -36,24 +36,33 @@ remque(void *a)
   element->qh_rlink =3D NULL;
 }
=20
-int add_exec(struct gfwd_list **ex_ptr, void *chardev, const char *cmdli=
ne,
+struct gfwd_list *
+add_guestfwd(struct gfwd_list **ex_ptr,
+             SlirpWriteCb write_cb, void *opaque,
              struct in_addr addr, int port)
 {
-	struct gfwd_list *tmp_ptr;
-
-	tmp_ptr =3D *ex_ptr;
-	*ex_ptr =3D g_new0(struct gfwd_list, 1);
-	(*ex_ptr)->ex_fport =3D port;
-	(*ex_ptr)->ex_addr =3D addr;
-	if (chardev) {
-		(*ex_ptr)->ex_chardev =3D chardev;
-	} else {
-		(*ex_ptr)->ex_exec =3D g_strdup(cmdline);
-	}
-	(*ex_ptr)->ex_next =3D tmp_ptr;
-	return 0;
+    struct gfwd_list *f =3D g_new0(struct gfwd_list, 1);
+
+    f->write_cb =3D write_cb;
+    f->opaque =3D opaque;
+    f->ex_fport =3D port;
+    f->ex_addr =3D addr;
+    f->ex_next =3D *ex_ptr;
+    *ex_ptr =3D f;
+
+    return f;
 }
=20
+struct gfwd_list *
+add_exec(struct gfwd_list **ex_ptr, const char *cmdline,
+         struct in_addr addr, int port)
+{
+    struct gfwd_list *f =3D add_guestfwd(ex_ptr, NULL, NULL, addr, port)=
;
+
+    f->ex_exec =3D g_strdup(cmdline);
+
+    return f;
+}
=20
 #ifdef _WIN32
=20
diff --git a/slirp/slirp.c b/slirp/slirp.c
index e7256ec05c..cc361885ed 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -25,7 +25,6 @@
 #include "qemu-common.h"
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
-#include "chardev/char-fe.h"
 #include "migration/register.h"
 #include "slirp.h"
 #include "hw/hw.h"
@@ -1064,23 +1063,35 @@ check_guestfwd(Slirp *slirp, struct in_addr *gues=
t_addr, int guest_port)
     return true;
 }
=20
-int slirp_add_exec(Slirp *slirp, void *chardev, const char *cmdline,
+int slirp_add_exec(Slirp *slirp, const char *cmdline,
                    struct in_addr *guest_addr, int guest_port)
 {
     if (!check_guestfwd(slirp, guest_addr, guest_port)) {
         return -1;
     }
=20
-    return add_exec(&slirp->guestfwd_list, chardev, cmdline, *guest_addr=
,
-                    htons(guest_port));
+    add_exec(&slirp->guestfwd_list, cmdline, *guest_addr, htons(guest_po=
rt));
+    return 0;
+}
+
+int slirp_add_guestfwd(Slirp *slirp, SlirpWriteCb write_cb, void *opaque=
,
+                       struct in_addr *guest_addr, int guest_port)
+{
+    if (!check_guestfwd(slirp, guest_addr, guest_port)) {
+        return -1;
+    }
+
+    add_guestfwd(&slirp->guestfwd_list, write_cb, opaque,
+                 *guest_addr, htons(guest_port));
+    return 0;
 }
=20
 ssize_t slirp_send(struct socket *so, const void *buf, size_t len, int f=
lags)
 {
-    if (so->s =3D=3D -1 && so->chardev) {
+    if (so->s =3D=3D -1 && so->guestfwd) {
         /* XXX this blocks entire thread. Rewrite to use
          * qemu_chr_fe_write and background I/O callbacks */
-        qemu_chr_fe_write_all(so->chardev, buf, len);
+        so->guestfwd->write_cb(buf, len, so->guestfwd->opaque);
         return len;
     }
=20
@@ -1445,7 +1456,7 @@ static void slirp_state_save(QEMUFile *f, void *opa=
que)
     struct gfwd_list *ex_ptr;
=20
     for (ex_ptr =3D slirp->guestfwd_list; ex_ptr; ex_ptr =3D ex_ptr->ex_=
next)
-        if (ex_ptr->ex_chardev) {
+        if (ex_ptr->write_cb) {
             struct socket *so;
             so =3D slirp_find_ctl_socket(slirp, ex_ptr->ex_addr,
                                        ntohs(ex_ptr->ex_fport));
@@ -1480,7 +1491,7 @@ static int slirp_state_load(QEMUFile *f, void *opaq=
ue, int version_id)
             return -EINVAL;
         }
         for (ex_ptr =3D slirp->guestfwd_list; ex_ptr; ex_ptr =3D ex_ptr-=
>ex_next) {
-            if (ex_ptr->ex_chardev &&
+            if (ex_ptr->write_cb &&
                 so->so_faddr.s_addr =3D=3D ex_ptr->ex_addr.s_addr &&
                 so->so_fport =3D=3D ex_ptr->ex_fport) {
                 break;
diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index 3b14684107..042fa1e4fb 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -959,9 +959,9 @@ int tcp_ctl(struct socket *so)
         for (ex_ptr =3D slirp->guestfwd_list; ex_ptr; ex_ptr =3D ex_ptr-=
>ex_next) {
             if (ex_ptr->ex_fport =3D=3D so->so_fport &&
                 so->so_faddr.s_addr =3D=3D ex_ptr->ex_addr.s_addr) {
-                if (ex_ptr->ex_chardev) {
+                if (ex_ptr->write_cb) {
                     so->s =3D -1;
-                    so->chardev =3D ex_ptr->ex_chardev;
+                    so->guestfwd =3D ex_ptr;
                     return 1;
                 }
                 DEBUG_MISC(" executing %s\n", ex_ptr->ex_exec);
--=20
2.20.0.rc1
