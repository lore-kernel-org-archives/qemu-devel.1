Received: from eggs.gnu.org ([209.51.188.92]:35234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gjB7J-0004nM-05
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:54:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gjB7I-0001i4-6T
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:54:00 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:37596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gjB7H-0001Yq-Se
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:54:00 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Mon, 14 Jan 2019 23:52:47 +0100
Message-Id: <20190114225306.21569-47-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190114225306.21569-1-samuel.thibault@ens-lyon.org>
References: <20190114225306.21569-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 46/65] slirp: Enable fork_exec support on Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com, jan.kiszka@siemens.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>

g_spawn_async_with_fds is portable on Windows, so we can now enable
fork_exec support there.

Thanks Daniel P. Berrang=C3=A9 for the notice!

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 slirp/misc.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/slirp/misc.c b/slirp/misc.c
index b141446319..2d092624d3 100644
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
2.20.1
