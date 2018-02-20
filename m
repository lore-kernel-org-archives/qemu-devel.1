Received: from eggs.gnu.org ([2001:4830:134:3::10]:60767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eo5Ur-000150-A8
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 05:50:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eo5Um-0000ws-BZ
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 05:50:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46306)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eo5Um-0000qC-2k
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 05:50:00 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1KAmu4Y112268
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 05:49:52 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g8hmshkk9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 05:49:51 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 20 Feb 2018 10:49:49 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 20 Feb 2018 11:49:41 +0100
In-Reply-To: <20180220104942.14531-1-groug@kaod.org>
References: <20180220104942.14531-1-groug@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20180220104942.14531-2-groug@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] 9p: v9fs_path_copy() readability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

lhs/rhs doesn't tell much about how argument are handled, dst/src is
and const arguments is clearer in my mind. Use g_memdup() while at it.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c | 9 ++++-----
 hw/9pfs/9p.h | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 85a1ed8171a4..48fa48e72074 100644
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
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 5ced427d861b..bad8ee719c4b 100644
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
--=20
2.13.6
