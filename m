Received: from eggs.gnu.org ([2001:4830:134:3::10]:59598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ehEup-0004mR-3L
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:28:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ehEuj-0000Eb-4q
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:28:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ehEui-0000Da-SW
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:28:29 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3107849023
	for <qemu-devel@nongnu.org>; Thu,  1 Feb 2018 13:28:28 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  1 Feb 2018 14:27:52 +0100
Message-Id: <20180201132757.23063-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180201132757.23063-1-marcandre.lureau@redhat.com>
References: <20180201132757.23063-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 2/7] memfd: add hugetlb support
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

Linux commit 749df87bd7bee5a79cef073f5d032ddb2b211de8 (v4.14-rc1)
added a new flag MFD_HUGETLB to memfd_create() that specify the file
to be created resides in the hugetlbfs filesystem.  This is the
generic hugetlbfs filesystem not associated with any specific mount
point.

hugetlbfs does not support sealing operations in v4.14, therefore
specifying MFD_ALLOW_SEALING with MFD_HUGETLB will result in EINVAL.

However, I added sealing support in "[PATCH v3 0/9] memfd: add sealing
to hugetlb-backed memory" series, queued in -mm tree for v4.16.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/memfd.h |  4 ++--
 util/memfd.c         | 13 ++++++++++---
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/qemu/memfd.h b/include/qemu/memfd.h
index b9d09873b5..1d3ecc7458 100644
--- a/include/qemu/memfd.h
+++ b/include/qemu/memfd.h
@@ -16,8 +16,8 @@
 #define F_SEAL_WRITE    0x0008  /* prevent writes */
 #endif
=20
-int qemu_memfd_create(const char *name, size_t size, unsigned int seals,
-                      Error **errp);
+int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
+                      unsigned int seals, Error **errp);
 void *qemu_memfd_alloc(const char *name, size_t size, unsigned int seals=
,
                        int *fd, Error **errp);
 void qemu_memfd_free(void *ptr, size_t size, int fd);
diff --git a/util/memfd.c b/util/memfd.c
index 8d27307137..7594af7089 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -52,7 +52,11 @@ static int memfd_create(const char *name, unsigned int=
 flags)
 #define MFD_ALLOW_SEALING 0x0002U
 #endif
=20
-int qemu_memfd_create(const char *name, size_t size,
+#ifndef MFD_HUGETLB
+#define MFD_HUGETLB 0x0004U
+#endif
+
+int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
                       unsigned int seals, Error **errp)
 {
 #ifdef CONFIG_LINUX
@@ -62,6 +66,9 @@ int qemu_memfd_create(const char *name, size_t size,
     if (seals) {
         flags |=3D MFD_ALLOW_SEALING;
     }
+    if (hugetlb) {
+        flags |=3D MFD_HUGETLB;
+    }
=20
     mfd =3D memfd_create(name, flags);
     if (mfd < 0) {
@@ -97,11 +104,11 @@ void *qemu_memfd_alloc(const char *name, size_t size=
, unsigned int seals,
                        int *fd, Error **errp)
 {
     void *ptr;
-    int mfd =3D qemu_memfd_create(name, size, seals, NULL);
+    int mfd =3D qemu_memfd_create(name, size, false, seals, NULL);
=20
     /* some systems have memfd without sealing */
     if (mfd =3D=3D -1) {
-        mfd =3D qemu_memfd_create(name, size, 0, NULL);
+        mfd =3D qemu_memfd_create(name, size, false, 0, NULL);
     }
=20
     if (mfd =3D=3D -1) {
--=20
2.16.0.rc1.1.gef27df75a1
