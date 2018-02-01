Received: from eggs.gnu.org ([2001:4830:134:3::10]:59637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ehEuq-0004nu-83
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:28:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ehEum-0000HT-QC
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:28:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ehEum-0000Gq-Gv
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:28:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CDD54C0587DF
	for <qemu-devel@nongnu.org>; Thu,  1 Feb 2018 13:28:31 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  1 Feb 2018 14:27:53 +0100
Message-Id: <20180201132757.23063-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180201132757.23063-1-marcandre.lureau@redhat.com>
References: <20180201132757.23063-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 3/7] memfd: add hugetlbsize argument
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
index 7594af7089..07d579ea7d 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -29,6 +29,7 @@
=20
 #include "qapi/error.h"
 #include "qemu/memfd.h"
+#include "qemu/host-utils.h"
=20
 #if defined CONFIG_LINUX && !defined CONFIG_MEMFD
 #include <sys/syscall.h>
@@ -56,9 +57,22 @@ static int memfd_create(const char *name, unsigned int=
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
@@ -68,8 +82,8 @@ int qemu_memfd_create(const char *name, size_t size, bo=
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
@@ -104,11 +118,11 @@ void *qemu_memfd_alloc(const char *name, size_t siz=
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
2.16.0.rc1.1.gef27df75a1
