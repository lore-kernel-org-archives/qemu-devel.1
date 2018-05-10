Received: from eggs.gnu.org ([2001:4830:134:3::10]:37292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fGb1Q-00036k-5S
	for qemu-devel@nongnu.org; Wed, 09 May 2018 22:09:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fGb1O-0006oA-Pf
	for qemu-devel@nongnu.org; Wed, 09 May 2018 22:09:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:24344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@gmx.com>) id 1fGb1O-0006fc-GW
	for qemu-devel@nongnu.org; Wed, 09 May 2018 22:09:30 -0400
From: junyan.he@gmx.com
Date: Thu, 10 May 2018 10:08:55 +0800
Message-Id: <1525918138-6189-7-git-send-email-junyan.he@gmx.com>
In-Reply-To: <1525918138-6189-1-git-send-email-junyan.he@gmx.com>
References: <1525918138-6189-1-git-send-email-junyan.he@gmx.com>
Subject: [Qemu-devel] [PATCH 6/9 V5] migration/ram: ensure write persistence
 on loading normal pages to PMEM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, xiaoguangrong.eric@gmail.com, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, Junyan He <junyan.he@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

From: Junyan He <junyan.he@intel.com>

When loading a normal page to persistent memory, load its data by
libpmem function pmem_memcpy_nodrain() instead of memcpy(). Combined
with a call to pmem_drain() at the end of memory loading, we can
guarantee all those normal pages are persistenly loaded to PMEM.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
 include/migration/qemu-file-types.h |  2 ++
 include/qemu/pmem.h                 |  1 +
 migration/qemu-file.c               | 29 +++++++++++++++++++----------
 migration/ram.c                     |  2 +-
 stubs/pmem.c                        |  5 +++++
 tests/Makefile.include              |  2 +-
 6 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/include/migration/qemu-file-types.h b/include/migration/qemu-file-types.h
index bd6d7dd..c7c3f66 100644
--- a/include/migration/qemu-file-types.h
+++ b/include/migration/qemu-file-types.h
@@ -33,6 +33,8 @@ void qemu_put_byte(QEMUFile *f, int v);
 void qemu_put_be16(QEMUFile *f, unsigned int v);
 void qemu_put_be32(QEMUFile *f, unsigned int v);
 void qemu_put_be64(QEMUFile *f, uint64_t v);
+size_t qemu_get_buffer_common(QEMUFile *f, uint8_t *buf, size_t size,
+                              bool is_pmem);
 size_t qemu_get_buffer(QEMUFile *f, uint8_t *buf, size_t size);
 
 int qemu_get_byte(QEMUFile *f);
diff --git a/include/qemu/pmem.h b/include/qemu/pmem.h
index 9f39ce8..cb9fa5f 100644
--- a/include/qemu/pmem.h
+++ b/include/qemu/pmem.h
@@ -16,6 +16,7 @@
 #include <libpmem.h>
 #else  /* !CONFIG_LIBPMEM */
 
+void *pmem_memcpy_nodrain(void *pmemdest, const void *src, size_t len);
 void *pmem_memcpy_persist(void *pmemdest, const void *src, size_t len);
 void *pmem_memset_nodrain(void *pmemdest, int c, size_t len);
 void pmem_drain(void);
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 0463f4c..1ec31d5 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -26,6 +26,7 @@
 #include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "qemu/iov.h"
+#include "qemu/pmem.h"
 #include "migration.h"
 #include "qemu-file.h"
 #include "trace.h"
@@ -471,18 +472,13 @@ size_t qemu_peek_buffer(QEMUFile *f, uint8_t **buf, size_t size, size_t offset)
     return size;
 }
 
-/*
- * Read 'size' bytes of data from the file into buf.
- * 'size' can be larger than the internal buffer.
- *
- * It will return size bytes unless there was an error, in which case it will
- * return as many as it managed to read (assuming blocking fd's which
- * all current QEMUFile are)
- */
-size_t qemu_get_buffer(QEMUFile *f, uint8_t *buf, size_t size)
+size_t qemu_get_buffer_common(QEMUFile *f, uint8_t *buf, size_t size,
+                              bool is_pmem)
 {
     size_t pending = size;
     size_t done = 0;
+    void *(*memcpy_func)(void *d, const void *s, size_t n) =
+        is_pmem ? pmem_memcpy_nodrain : memcpy;
 
     while (pending > 0) {
         size_t res;
@@ -492,7 +488,7 @@ size_t qemu_get_buffer(QEMUFile *f, uint8_t *buf, size_t size)
         if (res == 0) {
             return done;
         }
-        memcpy(buf, src, res);
+        memcpy_func(buf, src, res);
         qemu_file_skip(f, res);
         buf += res;
         pending -= res;
@@ -502,6 +498,19 @@ size_t qemu_get_buffer(QEMUFile *f, uint8_t *buf, size_t size)
 }
 
 /*
+ * Read 'size' bytes of data from the file into buf.
+ * 'size' can be larger than the internal buffer.
+ *
+ * It will return size bytes unless there was an error, in which case it will
+ * return as many as it managed to read (assuming blocking fd's which
+ * all current QEMUFile are)
+ */
+size_t qemu_get_buffer(QEMUFile *f, uint8_t *buf, size_t size)
+{
+    return qemu_get_buffer_common(f, buf, size, false);
+}
+
+/*
  * Read 'size' bytes of data from the file.
  * 'size' can be larger than the internal buffer.
  *
diff --git a/migration/ram.c b/migration/ram.c
index e6ae9e3..2a180bc 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3063,7 +3063,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
             break;
 
         case RAM_SAVE_FLAG_PAGE:
-            qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
+            qemu_get_buffer_common(f, host, TARGET_PAGE_SIZE, is_pmem);
             break;
 
         case RAM_SAVE_FLAG_COMPRESS_PAGE:
diff --git a/stubs/pmem.c b/stubs/pmem.c
index 2f07ae0..b50c35e 100644
--- a/stubs/pmem.c
+++ b/stubs/pmem.c
@@ -26,3 +26,8 @@ void *pmem_memset_nodrain(void *pmemdest, int c, size_t len)
 void pmem_drain(void)
 {
 }
+
+void *pmem_memcpy_nodrain(void *pmemdest, const void *src, size_t len)
+{
+    return memcpy(pmemdest, src, len);
+}
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3b9a5e3..5c25b9b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -652,7 +652,7 @@ tests/test-qdev-global-props$(EXESUF): tests/test-qdev-global-props.o \
 	$(test-qapi-obj-y)
 tests/test-vmstate$(EXESUF): tests/test-vmstate.o \
 	migration/vmstate.o migration/vmstate-types.o migration/qemu-file.o \
-        migration/qemu-file-channel.o migration/qjson.o \
+	migration/qemu-file-channel.o migration/qjson.o stubs/pmem.o \
 	$(test-io-obj-y)
 tests/test-timed-average$(EXESUF): tests/test-timed-average.o $(test-util-obj-y)
 tests/test-base64$(EXESUF): tests/test-base64.o $(test-util-obj-y)
-- 
2.7.4
