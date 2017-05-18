Received: from eggs.gnu.org ([2001:4830:134:3::10]:57523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBPBp-0000sh-2s
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:26:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBPBm-0006wK-De
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:26:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dBPBm-0006w4-3x
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:26:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1CF5980481
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 17:26:13 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 18 May 2017 19:25:35 +0200
Message-Id: <20170518172543.32694-4-quintela@redhat.com>
In-Reply-To: <20170518172543.32694-1-quintela@redhat.com>
References: <20170518172543.32694-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 03/11] migration: Split qemu-file.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Split the file into public and internal interfaces.  I have to rename
the external one because we can't have two include files with the same
name in the same directory.  Build system gets confused.  The only
exported functions are the ones that handle basic types.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/i2c/i2c-ddc.c                             |   1 +
 hw/intc/s390_flic.c                          |   1 -
 hw/intc/s390_flic_kvm.c                      |   1 -
 hw/s390x/s390-skeys.c                        |   1 -
 include/hw/hw.h                              |   2 +-
 include/migration/qemu-file-types.h          | 164 +++++++++++++++++++++++++++
 migration/block.c                            |   2 +-
 migration/colo.c                             |   2 +-
 migration/migration.c                        |   2 +-
 migration/postcopy-ram.c                     |   2 +-
 migration/qemu-file-channel.c                |   3 +-
 migration/qemu-file.c                        |   2 +-
 {include/migration => migration}/qemu-file.h | 157 +------------------------
 migration/ram.c                              |   2 +-
 migration/rdma.c                             |   2 +-
 migration/savevm.c                           |   1 +
 migration/socket.c                           |   2 +-
 migration/vmstate-types.c                    |   3 +-
 migration/vmstate.c                          |   2 +-
 tests/test-vmstate.c                         |   3 +-
 20 files changed, 186 insertions(+), 169 deletions(-)
 create mode 100644 include/migration/qemu-file-types.h
 rename {include/migration => migration}/qemu-file.h (62%)

diff --git a/hw/i2c/i2c-ddc.c b/hw/i2c/i2c-ddc.c
index 66899d7..6b92e95 100644
--- a/hw/i2c/i2c-ddc.c
+++ b/hw/i2c/i2c-ddc.c
@@ -17,6 +17,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu/log.h"
 #include "hw/i2c/i2c.h"
 #include "hw/i2c/i2c-ddc.h"
diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 711c114..a26e906 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -13,7 +13,6 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "hw/sysbus.h"
-#include "migration/qemu-file.h"
 #include "hw/s390x/s390_flic.h"
 #include "trace.h"
 #include "hw/qdev.h"
diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index cc44bc4..b4c61d8 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -17,7 +17,6 @@
 #include "qemu/error-report.h"
 #include "hw/sysbus.h"
 #include "sysemu/kvm.h"
-#include "migration/qemu-file.h"
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/adapter.h"
 #include "trace.h"
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index e2d4e1a..619152c 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -12,7 +12,6 @@
 #include "qemu/osdep.h"
 #include "hw/boards.h"
 #include "qmp-commands.h"
-#include "migration/qemu-file.h"
 #include "hw/s390x/storage-keys.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
diff --git a/include/hw/hw.h b/include/hw/hw.h
index af9eae1..ab4950c 100644
--- a/include/hw/hw.h
+++ b/include/hw/hw.h
@@ -11,7 +11,7 @@
 #include "exec/memory.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
-#include "migration/qemu-file.h"
+#include "migration/qemu-file-types.h"
 #include "qemu/module.h"
 #include "sysemu/reset.h"
 
diff --git a/include/migration/qemu-file-types.h b/include/migration/qemu-file-types.h
new file mode 100644
index 0000000..bd6d7dd
--- /dev/null
+++ b/include/migration/qemu-file-types.h
@@ -0,0 +1,164 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef QEMU_FILE_H
+#define QEMU_FILE_H
+
+void qemu_put_buffer(QEMUFile *f, const uint8_t *buf, size_t size);
+void qemu_put_byte(QEMUFile *f, int v);
+
+#define qemu_put_sbyte qemu_put_byte
+
+void qemu_put_be16(QEMUFile *f, unsigned int v);
+void qemu_put_be32(QEMUFile *f, unsigned int v);
+void qemu_put_be64(QEMUFile *f, uint64_t v);
+size_t qemu_get_buffer(QEMUFile *f, uint8_t *buf, size_t size);
+
+int qemu_get_byte(QEMUFile *f);
+
+static inline unsigned int qemu_get_ubyte(QEMUFile *f)
+{
+    return (unsigned int)qemu_get_byte(f);
+}
+
+#define qemu_get_sbyte qemu_get_byte
+
+unsigned int qemu_get_be16(QEMUFile *f);
+unsigned int qemu_get_be32(QEMUFile *f);
+uint64_t qemu_get_be64(QEMUFile *f);
+
+static inline void qemu_put_be64s(QEMUFile *f, const uint64_t *pv)
+{
+    qemu_put_be64(f, *pv);
+}
+
+static inline void qemu_put_be32s(QEMUFile *f, const uint32_t *pv)
+{
+    qemu_put_be32(f, *pv);
+}
+
+static inline void qemu_put_be16s(QEMUFile *f, const uint16_t *pv)
+{
+    qemu_put_be16(f, *pv);
+}
+
+static inline void qemu_put_8s(QEMUFile *f, const uint8_t *pv)
+{
+    qemu_put_byte(f, *pv);
+}
+
+static inline void qemu_get_be64s(QEMUFile *f, uint64_t *pv)
+{
+    *pv = qemu_get_be64(f);
+}
+
+static inline void qemu_get_be32s(QEMUFile *f, uint32_t *pv)
+{
+    *pv = qemu_get_be32(f);
+}
+
+static inline void qemu_get_be16s(QEMUFile *f, uint16_t *pv)
+{
+    *pv = qemu_get_be16(f);
+}
+
+static inline void qemu_get_8s(QEMUFile *f, uint8_t *pv)
+{
+    *pv = qemu_get_byte(f);
+}
+
+/* Signed versions for type safety */
+static inline void qemu_put_sbe16(QEMUFile *f, int v)
+{
+    qemu_put_be16(f, (unsigned int)v);
+}
+
+static inline void qemu_put_sbe32(QEMUFile *f, int v)
+{
+    qemu_put_be32(f, (unsigned int)v);
+}
+
+static inline void qemu_put_sbe64(QEMUFile *f, int64_t v)
+{
+    qemu_put_be64(f, (uint64_t)v);
+}
+
+static inline int qemu_get_sbe16(QEMUFile *f)
+{
+    return (int)qemu_get_be16(f);
+}
+
+static inline int qemu_get_sbe32(QEMUFile *f)
+{
+    return (int)qemu_get_be32(f);
+}
+
+static inline int64_t qemu_get_sbe64(QEMUFile *f)
+{
+    return (int64_t)qemu_get_be64(f);
+}
+
+static inline void qemu_put_s8s(QEMUFile *f, const int8_t *pv)
+{
+    qemu_put_8s(f, (const uint8_t *)pv);
+}
+
+static inline void qemu_put_sbe16s(QEMUFile *f, const int16_t *pv)
+{
+    qemu_put_be16s(f, (const uint16_t *)pv);
+}
+
+static inline void qemu_put_sbe32s(QEMUFile *f, const int32_t *pv)
+{
+    qemu_put_be32s(f, (const uint32_t *)pv);
+}
+
+static inline void qemu_put_sbe64s(QEMUFile *f, const int64_t *pv)
+{
+    qemu_put_be64s(f, (const uint64_t *)pv);
+}
+
+static inline void qemu_get_s8s(QEMUFile *f, int8_t *pv)
+{
+    qemu_get_8s(f, (uint8_t *)pv);
+}
+
+static inline void qemu_get_sbe16s(QEMUFile *f, int16_t *pv)
+{
+    qemu_get_be16s(f, (uint16_t *)pv);
+}
+
+static inline void qemu_get_sbe32s(QEMUFile *f, int32_t *pv)
+{
+    qemu_get_be32s(f, (uint32_t *)pv);
+}
+
+static inline void qemu_get_sbe64s(QEMUFile *f, int64_t *pv)
+{
+    qemu_get_be64s(f, (uint64_t *)pv);
+}
+
+int qemu_file_rate_limit(QEMUFile *f);
+
+#endif
diff --git a/migration/block.c b/migration/block.c
index 13f90d3..3e27499 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -26,7 +26,7 @@
 #include "migration/block.h"
 #include "migration/migration.h"
 #include "sysemu/blockdev.h"
-#include "migration/qemu-file.h"
+#include "qemu-file.h"
 #include "migration/vmstate.h"
 #include "sysemu/block-backend.h"
 
diff --git a/migration/colo.c b/migration/colo.c
index 8c2ade4..5be4656 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -15,7 +15,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu-file-channel.h"
 #include "migration/migration.h"
-#include "migration/qemu-file.h"
+#include "qemu-file.h"
 #include "savevm.h"
 #include "migration/colo.h"
 #include "migration/block.h"
diff --git a/migration/migration.c b/migration/migration.c
index 7087d1a..b65f5cc 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -21,7 +21,7 @@
 #include "migration/migration.h"
 #include "savevm.h"
 #include "qemu-file-channel.h"
-#include "migration/qemu-file.h"
+#include "qemu-file.h"
 #include "migration/vmstate.h"
 #include "sysemu/sysemu.h"
 #include "block/block.h"
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 3f9ae1b..6f239f9 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -21,7 +21,7 @@
 #include "qemu-common.h"
 #include "exec/target_page.h"
 #include "migration/migration.h"
-#include "migration/qemu-file.h"
+#include "qemu-file.h"
 #include "savevm.h"
 #include "postcopy-ram.h"
 #include "sysemu/sysemu.h"
diff --git a/migration/qemu-file-channel.c b/migration/qemu-file-channel.c
index dc991c9..e202d73 100644
--- a/migration/qemu-file-channel.c
+++ b/migration/qemu-file-channel.c
@@ -24,7 +24,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu-file-channel.h"
-#include "migration/qemu-file.h"
+#include "exec/cpu-common.h"
+#include "qemu-file.h"
 #include "io/channel-socket.h"
 #include "qemu/iov.h"
 
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 195fa94..ab26f4e 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -29,7 +29,7 @@
 #include "qemu/sockets.h"
 #include "qemu/coroutine.h"
 #include "migration/migration.h"
-#include "migration/qemu-file.h"
+#include "qemu-file.h"
 #include "trace.h"
 
 #define IO_BUF_SIZE 32768
diff --git a/include/migration/qemu-file.h b/migration/qemu-file.h
similarity index 62%
rename from include/migration/qemu-file.h
rename to migration/qemu-file.h
index b5ac800..49fd697 100644
--- a/include/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -22,11 +22,8 @@
  * THE SOFTWARE.
  */
 
-#ifndef QEMU_FILE_H
-#define QEMU_FILE_H
-
-#include "qemu-common.h"
-#include "exec/cpu-common.h"
+#ifndef MIGRATION_QEMU_FILE_H
+#define MIGRATION_QEMU_FILE_H
 
 /* Read a chunk of data from a file at the given position.  The pos argument
  * can be ignored if the file is only be used for streaming.  The number of
@@ -122,8 +119,6 @@ int qemu_get_fd(QEMUFile *f);
 int qemu_fclose(QEMUFile *f);
 int64_t qemu_ftell(QEMUFile *f);
 int64_t qemu_ftell_fast(QEMUFile *f);
-void qemu_put_buffer(QEMUFile *f, const uint8_t *buf, size_t size);
-void qemu_put_byte(QEMUFile *f, int v);
 /*
  * put_buffer without copying the buffer.
  * The buffer should be available till it is sent asynchronously.
@@ -133,19 +128,9 @@ void qemu_put_buffer_async(QEMUFile *f, const uint8_t *buf, size_t size,
 bool qemu_file_mode_is_not_valid(const char *mode);
 bool qemu_file_is_writable(QEMUFile *f);
 
+#include "migration/qemu-file-types.h"
 
-static inline void qemu_put_ubyte(QEMUFile *f, unsigned int v)
-{
-    qemu_put_byte(f, (int)v);
-}
-
-#define qemu_put_sbyte qemu_put_byte
-
-void qemu_put_be16(QEMUFile *f, unsigned int v);
-void qemu_put_be32(QEMUFile *f, unsigned int v);
-void qemu_put_be64(QEMUFile *f, uint64_t v);
 size_t qemu_peek_buffer(QEMUFile *f, uint8_t **buf, size_t size, size_t offset);
-size_t qemu_get_buffer(QEMUFile *f, uint8_t *buf, size_t size);
 size_t qemu_get_buffer_in_place(QEMUFile *f, uint8_t **buf, size_t size);
 ssize_t qemu_put_compression_data(QEMUFile *f, const uint8_t *p, size_t size,
                                   int level);
@@ -157,22 +142,8 @@ int qemu_put_qemu_file(QEMUFile *f_des, QEMUFile *f_src);
  * previously peeked +n-1.
  */
 int qemu_peek_byte(QEMUFile *f, int offset);
-int qemu_get_byte(QEMUFile *f);
 void qemu_file_skip(QEMUFile *f, int size);
 void qemu_update_position(QEMUFile *f, size_t size);
-
-static inline unsigned int qemu_get_ubyte(QEMUFile *f)
-{
-    return (unsigned int)qemu_get_byte(f);
-}
-
-#define qemu_get_sbyte qemu_get_byte
-
-unsigned int qemu_get_be16(QEMUFile *f);
-unsigned int qemu_get_be32(QEMUFile *f);
-uint64_t qemu_get_be64(QEMUFile *f);
-
-int qemu_file_rate_limit(QEMUFile *f);
 void qemu_file_reset_rate_limit(QEMUFile *f);
 void qemu_file_set_rate_limit(QEMUFile *f, int64_t new_rate);
 int64_t qemu_file_get_rate_limit(QEMUFile *f);
@@ -183,127 +154,7 @@ QEMUFile *qemu_file_get_return_path(QEMUFile *f);
 void qemu_fflush(QEMUFile *f);
 void qemu_file_set_blocking(QEMUFile *f, bool block);
 
-static inline void qemu_put_be64s(QEMUFile *f, const uint64_t *pv)
-{
-    qemu_put_be64(f, *pv);
-}
-
-static inline void qemu_put_be32s(QEMUFile *f, const uint32_t *pv)
-{
-    qemu_put_be32(f, *pv);
-}
-
-static inline void qemu_put_be16s(QEMUFile *f, const uint16_t *pv)
-{
-    qemu_put_be16(f, *pv);
-}
-
-static inline void qemu_put_8s(QEMUFile *f, const uint8_t *pv)
-{
-    qemu_put_byte(f, *pv);
-}
-
-static inline void qemu_get_be64s(QEMUFile *f, uint64_t *pv)
-{
-    *pv = qemu_get_be64(f);
-}
-
-static inline void qemu_get_be32s(QEMUFile *f, uint32_t *pv)
-{
-    *pv = qemu_get_be32(f);
-}
-
-static inline void qemu_get_be16s(QEMUFile *f, uint16_t *pv)
-{
-    *pv = qemu_get_be16(f);
-}
-
-static inline void qemu_get_8s(QEMUFile *f, uint8_t *pv)
-{
-    *pv = qemu_get_byte(f);
-}
-
-// Signed versions for type safety
-static inline void qemu_put_sbuffer(QEMUFile *f, const int8_t *buf, size_t size)
-{
-    qemu_put_buffer(f, (const uint8_t *)buf, size);
-}
-
-static inline void qemu_put_sbe16(QEMUFile *f, int v)
-{
-    qemu_put_be16(f, (unsigned int)v);
-}
-
-static inline void qemu_put_sbe32(QEMUFile *f, int v)
-{
-    qemu_put_be32(f, (unsigned int)v);
-}
-
-static inline void qemu_put_sbe64(QEMUFile *f, int64_t v)
-{
-    qemu_put_be64(f, (uint64_t)v);
-}
-
-static inline size_t qemu_get_sbuffer(QEMUFile *f, int8_t *buf, int size)
-{
-    return qemu_get_buffer(f, (uint8_t *)buf, size);
-}
-
-static inline int qemu_get_sbe16(QEMUFile *f)
-{
-    return (int)qemu_get_be16(f);
-}
-
-static inline int qemu_get_sbe32(QEMUFile *f)
-{
-    return (int)qemu_get_be32(f);
-}
-
-static inline int64_t qemu_get_sbe64(QEMUFile *f)
-{
-    return (int64_t)qemu_get_be64(f);
-}
-
-static inline void qemu_put_s8s(QEMUFile *f, const int8_t *pv)
-{
-    qemu_put_8s(f, (const uint8_t *)pv);
-}
-
-static inline void qemu_put_sbe16s(QEMUFile *f, const int16_t *pv)
-{
-    qemu_put_be16s(f, (const uint16_t *)pv);
-}
-
-static inline void qemu_put_sbe32s(QEMUFile *f, const int32_t *pv)
-{
-    qemu_put_be32s(f, (const uint32_t *)pv);
-}
-
-static inline void qemu_put_sbe64s(QEMUFile *f, const int64_t *pv)
-{
-    qemu_put_be64s(f, (const uint64_t *)pv);
-}
-
-static inline void qemu_get_s8s(QEMUFile *f, int8_t *pv)
-{
-    qemu_get_8s(f, (uint8_t *)pv);
-}
-
-static inline void qemu_get_sbe16s(QEMUFile *f, int16_t *pv)
-{
-    qemu_get_be16s(f, (uint16_t *)pv);
-}
-
-static inline void qemu_get_sbe32s(QEMUFile *f, int32_t *pv)
-{
-    qemu_get_be32s(f, (uint32_t *)pv);
-}
-
-static inline void qemu_get_sbe64s(QEMUFile *f, int64_t *pv)
-{
-    qemu_get_be64s(f, (uint64_t *)pv);
-}
-
 size_t qemu_get_counted_string(QEMUFile *f, char buf[256]);
 
+
 #endif
diff --git a/migration/ram.c b/migration/ram.c
index c07a9c0..cbb7b7a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -37,7 +37,7 @@
 #include "qemu/main-loop.h"
 #include "xbzrle.h"
 #include "migration/migration.h"
-#include "migration/qemu-file.h"
+#include "qemu-file.h"
 #include "migration/vmstate.h"
 #include "postcopy-ram.h"
 #include "exec/address-spaces.h"
diff --git a/migration/rdma.c b/migration/rdma.c
index 166cd60..4cb5bf8 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -18,7 +18,7 @@
 #include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "migration/migration.h"
-#include "migration/qemu-file.h"
+#include "qemu-file.h"
 #include "exec/cpu-common.h"
 #include "qemu-file-channel.h"
 #include "qemu/error-report.h"
diff --git a/migration/savevm.c b/migration/savevm.c
index d840731..0a32474 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -36,6 +36,7 @@
 #include "qemu/timer.h"
 #include "migration/migration.h"
 #include "qemu-file-channel.h"
+#include "qemu-file.h"
 #include "savevm.h"
 #include "postcopy-ram.h"
 #include "qapi/qmp/qerror.h"
diff --git a/migration/socket.c b/migration/socket.c
index 53f9d61..3f8ffc9 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -21,7 +21,7 @@
 #include "qapi/error.h"
 #include "channel.h"
 #include "migration/migration.h"
-#include "migration/qemu-file.h"
+#include "qemu-file.h"
 #include "io/channel-socket.h"
 #include "trace.h"
 
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index cc95e47..7287c6b 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -12,8 +12,9 @@
 
 #include "qemu/osdep.h"
 #include "qemu-common.h"
+#include "exec/cpu-common.h"
+#include "qemu-file.h"
 #include "migration/migration.h"
-#include "migration/qemu-file.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
diff --git a/migration/vmstate.c b/migration/vmstate.c
index ff54531..51a19b6 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -13,8 +13,8 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "migration/migration.h"
-#include "migration/qemu-file.h"
 #include "migration/vmstate.h"
+#include "qemu-file.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
 #include "trace.h"
diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
index 25389bc..c52aff9 100644
--- a/tests/test-vmstate.c
+++ b/tests/test-vmstate.c
@@ -27,7 +27,8 @@
 #include "qemu-common.h"
 #include "migration/migration.h"
 #include "migration/vmstate.h"
-#include "migration/qemu-file.h"
+#include "migration/qemu-file-types.h"
+#include "../migration/qemu-file.h"
 #include "../migration/qemu-file-channel.h"
 #include "qemu/coroutine.h"
 #include "io/channel-file.h"
-- 
2.9.3
