Received: from eggs.gnu.org ([2001:4830:134:3::10]:45038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSc-0004qB-OR
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSb-00059S-P8
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:50 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:43242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimSb-00058s-HL
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:49 -0500
Received: by mail-wr0-x243.google.com with SMTP id b52so10520999wrd.10
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:49 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:51 +0100
Message-Id: <1517858941-5538-38-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 37/47] memfd: add hugetlb support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Linux commit 749df87bd7bee5a79cef073f5d032ddb2b211de8 (v4.14-rc1)
added a new flag MFD_HUGETLB to memfd_create() that specify the file
to be created resides in the hugetlbfs filesystem.  This is the
generic hugetlbfs filesystem not associated with any specific mount
point.

hugetlbfs does not support sealing operations in v4.14, therefore
specifying MFD_ALLOW_SEALING with MFD_HUGETLB will result in EINVAL.

However, I added sealing support in "[PATCH v3 0/9] memfd: add sealing
to hugetlb-backed memory" series, queued in -mm tree for v4.16.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180201132757.23063-3-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/memfd.h |  4 ++--
 util/memfd.c         | 13 ++++++++++---
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/qemu/memfd.h b/include/qemu/memfd.h
index b9d0987..1d3ecc7 100644
--- a/include/qemu/memfd.h
+++ b/include/qemu/memfd.h
@@ -16,8 +16,8 @@
 #define F_SEAL_WRITE    0x0008  /* prevent writes */
 #endif
 
-int qemu_memfd_create(const char *name, size_t size, unsigned int seals,
-                      Error **errp);
+int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
+                      unsigned int seals, Error **errp);
 void *qemu_memfd_alloc(const char *name, size_t size, unsigned int seals,
                        int *fd, Error **errp);
 void qemu_memfd_free(void *ptr, size_t size, int fd);
diff --git a/util/memfd.c b/util/memfd.c
index 8d27307..7594af7 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -52,7 +52,11 @@ static int memfd_create(const char *name, unsigned int flags)
 #define MFD_ALLOW_SEALING 0x0002U
 #endif
 
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
         flags |= MFD_ALLOW_SEALING;
     }
+    if (hugetlb) {
+        flags |= MFD_HUGETLB;
+    }
 
     mfd = memfd_create(name, flags);
     if (mfd < 0) {
@@ -97,11 +104,11 @@ void *qemu_memfd_alloc(const char *name, size_t size, unsigned int seals,
                        int *fd, Error **errp)
 {
     void *ptr;
-    int mfd = qemu_memfd_create(name, size, seals, NULL);
+    int mfd = qemu_memfd_create(name, size, false, seals, NULL);
 
     /* some systems have memfd without sealing */
     if (mfd == -1) {
-        mfd = qemu_memfd_create(name, size, 0, NULL);
+        mfd = qemu_memfd_create(name, size, false, 0, NULL);
     }
 
     if (mfd == -1) {
-- 
1.8.3.1
