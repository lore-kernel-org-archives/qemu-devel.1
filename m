Received: from eggs.gnu.org ([2001:4830:134:3::10]:46476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gOuLm-0005Jf-2I
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 19:57:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gOuLi-0002wy-TP
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 19:57:09 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:58400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gOuLi-0002to-NA
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 19:57:06 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Tue, 20 Nov 2018 01:57:01 +0100
Message-Id: <20181120005701.9304-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] slirp: Enable fork_exec support on Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com, jan.kiszka@siemens.com, eblake@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com

g_spawn_async_with_fds is portable on Windows, so we can now enable
fork_exec support there.

Thanks Daniel P. Berrang=C3=A9 for the notice!

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/misc.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/slirp/misc.c b/slirp/misc.c
index 7972b9b05b..59b4e8f31c 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -62,17 +62,6 @@ int add_exec(struct ex_list **ex_ptr, void *chardev, c=
onst char *cmdline,
 }
=20
=20
-#ifdef _WIN32
-
-int
-fork_exec(struct socket *so, const char *ex)
-{
-    /* not implemented */
-    return 0;
-}
-
-#else
-
 static int
 slirp_socketpair_with_oob(int sv[2])
 {
@@ -132,7 +121,9 @@ err:
 static void
 fork_exec_child_setup(gpointer data)
 {
+#ifndef _WIN32
     setsid();
+#endif
 }
=20
 int
@@ -177,7 +168,6 @@ fork_exec(struct socket *so, const char *ex)
     qemu_set_nonblock(so->s);
     return 1;
 }
-#endif
=20
 char *slirp_connection_info(Slirp *slirp)
 {
--=20
2.19.1
