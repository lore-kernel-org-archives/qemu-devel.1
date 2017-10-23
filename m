Received: from eggs.gnu.org ([2001:4830:134:3::10]:40274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e6dZ0-00015J-UE
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 10:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e6dYz-0000ac-Ty
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 10:18:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e6dYz-0000aE-Lg
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 10:18:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C1F12C0587CD
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 14:18:44 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 23 Oct 2017 15:18:11 +0100
Message-Id: <20171023141815.17709-6-marcandre.lureau@redhat.com>
In-Reply-To: <20171023141815.17709-1-marcandre.lureau@redhat.com>
References: <20171023141815.17709-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 5/9] memfd: add hugetlbsize argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Learn to specificy hugetlb size as qemu_memfd_create() argument.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/memfd.h |  2 +-
 util/memfd.c         | 22 ++++++++++++++++++----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/qemu/memfd.h b/include/qemu/memfd.h
index 1d3ecc7458..de10198ed6 100644
--- a/include/qemu/memfd.h
+++ b/include/qemu/memfd.h
@@ -17,7 +17,7 @@
 #endif
=20
 int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
-                      unsigned int seals, Error **errp);
+                      uint64_t hugetlbsize, unsigned int seals, Error **=
errp);
 void *qemu_memfd_alloc(const char *name, size_t size, unsigned int seals=
,
                        int *fd, Error **errp);
 void qemu_memfd_free(void *ptr, size_t size, int fd);
diff --git a/util/memfd.c b/util/memfd.c
index 98294e84de..0144acd476 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -29,6 +29,7 @@
=20
 #include "qapi/error.h"
 #include "qemu/memfd.h"
+#include "qemu/host-utils.h"
=20
 #ifdef CONFIG_MEMFD
 #include <sys/memfd.h>
@@ -58,9 +59,22 @@ static int memfd_create(const char *name, unsigned int=
 flags)
 #define MFD_HUGETLB 0x0004U
 #endif
=20
+#ifndef MFD_HUGE_SHIFT
+#define MFD_HUGE_SHIFT 26
+#endif
+
 int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
-                      unsigned int seals, Error **errp)
+                      uint64_t hugetlbsize, unsigned int seals, Error **=
errp)
 {
+    int htsize =3D hugetlbsize ? ctz64(hugetlbsize) : 0;
+
+    if (htsize && 1 << htsize !=3D hugetlbsize) {
+        error_setg(errp, "Hugepage size must be a power of 2");
+        return -1;
+    }
+
+    htsize =3D htsize << MFD_HUGE_SHIFT;
+
 #ifdef CONFIG_LINUX
     int mfd =3D -1;
     unsigned int flags =3D MFD_CLOEXEC;
@@ -70,8 +84,8 @@ int qemu_memfd_create(const char *name, size_t size, bo=
ol hugetlb,
     }
     if (hugetlb) {
         flags |=3D MFD_HUGETLB;
+        flags |=3D htsize;
     }
-
     mfd =3D memfd_create(name, flags);
     if (mfd < 0) {
         goto err;
@@ -106,11 +120,11 @@ void *qemu_memfd_alloc(const char *name, size_t siz=
e, unsigned int seals,
                        int *fd, Error **errp)
 {
     void *ptr;
-    int mfd =3D qemu_memfd_create(name, size, false, seals, NULL);
+    int mfd =3D qemu_memfd_create(name, size, false, 0, seals, NULL);
=20
     /* some systems have memfd without sealing */
     if (mfd =3D=3D -1) {
-        mfd =3D qemu_memfd_create(name, size, false, 0, NULL);
+        mfd =3D qemu_memfd_create(name, size, false, 0, 0, NULL);
     }
=20
     if (mfd =3D=3D -1) {
--=20
2.15.0.rc0.40.gaefcc5f6f
