Received: from eggs.gnu.org ([2001:4830:134:3::10]:38892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ekDQX-0003Dd-FT
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:29:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ekDQS-0007Cu-Jp
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:29:37 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55288 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ekDQS-0007Cd-En
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:29:32 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  9 Feb 2018 19:29:19 +0100
Message-Id: <20180209182920.29711-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] 9p: v9fs_path_copy() readability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Greg Kurz <groug@kaod.org>

lhs/rhs doesn't tell much about how argument are handled, dst/src is
and const arguments is clearer in my mind. Use g_memdup() while at it.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/9pfs/9p.h | 2 +-
 hw/9pfs/9p.c | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 5ced427d86..bad8ee719c 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -343,7 +343,7 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu);
 void v9fs_path_init(V9fsPath *path);
 void v9fs_path_free(V9fsPath *path);
 void v9fs_path_sprintf(V9fsPath *path, const char *fmt, ...);
-void v9fs_path_copy(V9fsPath *lhs, V9fsPath *rhs);
+void v9fs_path_copy(V9fsPath *dst, const V9fsPath *src);
 int v9fs_name_to_path(V9fsState *s, V9fsPath *dirpath,
                       const char *name, V9fsPath *path);
 int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 85a1ed8171..48fa48e720 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -190,12 +190,11 @@ v9fs_path_sprintf(V9fsPath *path, const char *fmt, =
...)
     va_end(ap);
 }
=20
-void v9fs_path_copy(V9fsPath *lhs, V9fsPath *rhs)
+void v9fs_path_copy(V9fsPath *dst, const V9fsPath *src)
 {
-    v9fs_path_free(lhs);
-    lhs->data =3D g_malloc(rhs->size);
-    memcpy(lhs->data, rhs->data, rhs->size);
-    lhs->size =3D rhs->size;
+    v9fs_path_free(dst);
+    dst->size =3D src->size;
+    dst->data =3D g_memdup(src->data, src->size);
 }
=20
 int v9fs_name_to_path(V9fsState *s, V9fsPath *dirpath,
--=20
2.16.1.73.g5832b7e9f2
