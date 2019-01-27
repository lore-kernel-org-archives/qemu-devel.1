Received: from eggs.gnu.org ([209.51.188.92]:52519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCC-0001O7-8t
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCA-0007Od-6U
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:52 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:43202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gnjC9-0006z8-R5
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:50 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 27 Jan 2019 13:04:59 +0100
Message-Id: <20190127120526.15457-5-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
References: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/31] slirp: generalize guestfwd with a
 callback based approach
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

Instead of calling into QEMU chardev directly, and mixing it with
slirp_add_exec() handling, add a new function slirp_add_guestfwd()
which takes a write callback.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 net/slirp.c      | 14 ++++++++++----
 slirp/libslirp.h |  6 +++++-
 slirp/misc.c     | 37 +++++++++++++++++++++++--------------
 slirp/misc.h     | 15 +++++++++++++--
 slirp/slirp.c    | 27 +++++++++++++++++++--------
 slirp/socket.h   |  4 +++-
 slirp/tcp_subr.c |  4 ++--
 7 files changed, 75 insertions(+), 32 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index f98425ee9f..ec07f662c0 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -704,8 +704,8 @@ static int slirp_smb(SlirpState* s, const char *expor=
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
@@ -736,6 +736,11 @@ static void guestfwd_read(void *opaque, const uint8_=
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
@@ -769,7 +774,7 @@ static int slirp_guestfwd(SlirpState *s, const char *=
config_str, Error **errp)
     snprintf(buf, sizeof(buf), "guestfwd.tcp.%d", port);
=20
     if ((strlen(p) > 4) && !strncmp(p, "cmd:", 4)) {
-        if (slirp_add_exec(s->slirp, NULL, &p[4], &server, port) < 0) {
+        if (slirp_add_exec(s->slirp, &p[4], &server, port) < 0) {
             error_setg(errp, "Conflicting/invalid host:port in guest "
                        "forwarding rule '%s'", config_str);
             return -1;
@@ -796,7 +801,8 @@ static int slirp_guestfwd(SlirpState *s, const char *=
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
diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index 4611a7447b..ea019828e8 100644
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
@@ -45,7 +47,9 @@ int slirp_add_hostfwd(Slirp *slirp, int is_udp,
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
diff --git a/slirp/misc.c b/slirp/misc.c
index eae9596a55..b8a2bf971a 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -32,24 +32,33 @@ remque(void *a)
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
 static int
 slirp_socketpair_with_oob(int sv[2])
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
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 739f364770..a411221914 100644
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
@@ -1068,23 +1067,35 @@ check_guestfwd(Slirp *slirp, struct in_addr *gues=
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
@@ -1449,7 +1460,7 @@ static void slirp_state_save(QEMUFile *f, void *opa=
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
@@ -1484,7 +1495,7 @@ static int slirp_state_load(QEMUFile *f, void *opaq=
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
diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index 23a841f26e..4e81736d6f 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -964,9 +964,9 @@ int tcp_ctl(struct socket *so)
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
                 DEBUG_MISC(" executing %s", ex_ptr->ex_exec);
--=20
2.20.1
