Received: from eggs.gnu.org ([209.51.188.92]:51085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gipk2-0002uz-TA
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:04:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gipk1-0006K3-PR
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:04:34 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gipk1-0006Ff-H2
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:04:33 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Mon, 14 Jan 2019 01:02:30 +0100
Message-Id: <20190114000326.29847-10-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190114000326.29847-1-samuel.thibault@ens-lyon.org>
References: <20190114000326.29847-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/65] slirp: fix slirp_add_exec() leaks
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

Free the list elements allocated in add_exec().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/misc.h  | 2 +-
 slirp/slirp.c | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/slirp/misc.h b/slirp/misc.h
index 94829722cd..0bc5e74bc5 100644
--- a/slirp/misc.h
+++ b/slirp/misc.h
@@ -12,7 +12,7 @@ struct ex_list {
 	void *ex_chardev;
 	struct in_addr ex_addr;		/* Server address */
 	int ex_fport;                   /* Port to telnet to */
-	const char *ex_exec;            /* Command line of what to exec */
+	char *ex_exec;                  /* Command line of what to exec */
 	struct ex_list *ex_next;
 };
=20
diff --git a/slirp/slirp.c b/slirp/slirp.c
index ab08694e37..1627436e7d 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -342,6 +342,14 @@ Slirp *slirp_init(int restricted, bool in_enabled, s=
truct in_addr vnetwork,
=20
 void slirp_cleanup(Slirp *slirp)
 {
+    struct ex_list *e, *next;
+
+    for (e =3D slirp->exec_list; e; e =3D next) {
+        next =3D e->ex_next;
+        g_free(e->ex_exec);
+        g_free(e);
+    }
+
     QTAILQ_REMOVE(&slirp_instances, slirp, entry);
=20
     unregister_savevm(NULL, "slirp", slirp);
--=20
2.20.1
