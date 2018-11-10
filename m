Received: from eggs.gnu.org ([2001:4830:134:3::10]:36727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gLTbR-0004od-I7
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 08:47:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gLTbM-0000cF-Hy
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 08:47:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gLTbM-0000bn-BZ
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 08:47:04 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 10 Nov 2018 17:45:44 +0400
Message-Id: <20181110134548.14741-10-marcandre.lureau@redhat.com>
In-Reply-To: <20181110134548.14741-1-marcandre.lureau@redhat.com>
References: <20181110134548.14741-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 09/13] slirp: fix slirp_add_exec() leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Free the list elements allocated in add_exec().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
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
index d6623a2bbf..29fe4702cc 100644
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
2.19.1.708.g4ede3d42df
