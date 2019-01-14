Received: from eggs.gnu.org ([209.51.188.92]:35415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gjB7S-0004zo-Qe
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:54:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gjB7S-0001qo-1i
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:54:10 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:37684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gjB7R-0001eU-PX
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:54:09 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Mon, 14 Jan 2019 23:53:00 +0100
Message-Id: <20190114225306.21569-60-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190114225306.21569-1-samuel.thibault@ens-lyon.org>
References: <20190114225306.21569-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 59/65] slirp: factor out guestfwd addition checks
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

This will allow reusing the function in a following patch.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/misc.c  |  7 -------
 slirp/slirp.c | 23 +++++++++++++++++++++--
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/slirp/misc.c b/slirp/misc.c
index a0f104be5e..eae9596a55 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -37,13 +37,6 @@ int add_exec(struct gfwd_list **ex_ptr, void *chardev,=
 const char *cmdline,
 {
 	struct gfwd_list *tmp_ptr;
=20
-	/* First, check if the port is "bound" */
-	for (tmp_ptr =3D *ex_ptr; tmp_ptr; tmp_ptr =3D tmp_ptr->ex_next) {
-		if (port =3D=3D tmp_ptr->ex_fport &&
-		    addr.s_addr =3D=3D tmp_ptr->ex_addr.s_addr)
-			return -1;
-	}
-
 	tmp_ptr =3D *ex_ptr;
 	*ex_ptr =3D g_new0(struct gfwd_list, 1);
 	(*ex_ptr)->ex_fport =3D port;
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 851462a4cd..882d28a4de 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -1046,9 +1046,11 @@ int slirp_add_hostfwd(Slirp *slirp, int is_udp, st=
ruct in_addr host_addr,
     return 0;
 }
=20
-int slirp_add_exec(Slirp *slirp, void *chardev, const char *cmdline,
-                   struct in_addr *guest_addr, int guest_port)
+static bool
+check_guestfwd(Slirp *slirp, struct in_addr *guest_addr, int guest_port)
 {
+    struct gfwd_list *tmp_ptr;
+
     if (!guest_addr->s_addr) {
         guest_addr->s_addr =3D slirp->vnetwork_addr.s_addr |
             (htonl(0x0204) & ~slirp->vnetwork_mask.s_addr);
@@ -1057,6 +1059,23 @@ int slirp_add_exec(Slirp *slirp, void *chardev, co=
nst char *cmdline,
         slirp->vnetwork_addr.s_addr ||
         guest_addr->s_addr =3D=3D slirp->vhost_addr.s_addr ||
         guest_addr->s_addr =3D=3D slirp->vnameserver_addr.s_addr) {
+        return false;
+    }
+
+    /* check if the port is "bound" */
+    for (tmp_ptr =3D slirp->guestfwd_list; tmp_ptr; tmp_ptr =3D tmp_ptr-=
>ex_next) {
+        if (guest_port =3D=3D tmp_ptr->ex_fport &&
+            guest_addr->s_addr =3D=3D tmp_ptr->ex_addr.s_addr)
+            return false;
+    }
+
+    return true;
+}
+
+int slirp_add_exec(Slirp *slirp, void *chardev, const char *cmdline,
+                   struct in_addr *guest_addr, int guest_port)
+{
+    if (!check_guestfwd(slirp, guest_addr, guest_port)) {
         return -1;
     }
=20
--=20
2.20.1
