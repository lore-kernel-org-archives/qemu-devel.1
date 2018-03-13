Received: from eggs.gnu.org ([2001:4830:134:3::10]:51364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robinhe@robinhe-hp.sh.intel.com>) id 1ewT4q-0005hY-LQ
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 09:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robinhe@robinhe-hp.sh.intel.com>) id 1ewT4k-0004sb-GV
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 09:37:52 -0400
Received: from [112.64.68.174] (port=39097 helo=robinhe-hp.sh.intel.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robinhe@robinhe-hp.sh.intel.com>)
	id 1ewT4j-0004lN-JQ
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 09:37:46 -0400
From: junyan.he@intel.com
Date: Tue, 13 Mar 2018 16:33:49 +0800
Message-Id: <1520930033-18885-7-git-send-email-junyan.he@intel.com>
In-Reply-To: <1520930033-18885-1-git-send-email-junyan.he@intel.com>
References: <1520930033-18885-1-git-send-email-junyan.he@intel.com>
Subject: [Qemu-devel] [PATCH 06/10] RFC: Add save dependency functions to
 qemu_file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, quintela@redhat.com, rth@twiddle.net, dgilbert@redhat.com, famz@redhat.com, Junyan He <junyan.he@intel.com>

From: Junyan He <junyan.he@intel.com>

When we save snapshot, we need qemu_file to support save dependency
operations. It should call brv_driver's save dependency functions
to implement these operations.

Signed-off-by: Junyan He <junyan.he@intel.com>
---
 migration/qemu-file.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++
 migration/qemu-file.h | 14 ++++++++++++
 migration/savevm.c    | 33 +++++++++++++++++++++++++---
 3 files changed, 105 insertions(+), 3 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 2ab2bf3..9d2a39a 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -46,10 +46,13 @@ struct QEMUFile {
     int buf_index;
     int buf_size; /* 0 when writing */
     uint8_t buf[IO_BUF_SIZE];
+    char ref_name_str[128]; /* maybe snapshot id */
 
     DECLARE_BITMAP(may_free, MAX_IOV_SIZE);
     struct iovec iov[MAX_IOV_SIZE];
     unsigned int iovcnt;
+    bool support_dependency;
+    int32_t dependency_aligment;
 
     int last_error;
 };
@@ -745,3 +748,61 @@ void qemu_file_set_blocking(QEMUFile *f, bool block)
         f->ops->set_blocking(f->opaque, block);
     }
 }
+
+void qemu_file_set_support_dependency(QEMUFile *f, int32_t alignment)
+{
+    f->dependency_aligment = alignment;
+    f->support_dependency = true;
+}
+
+bool qemu_file_is_support_dependency(QEMUFile *f, int32_t *alignment)
+{
+    if (f->support_dependency && alignment) {
+        *alignment = f->dependency_aligment;
+    }
+
+    return f->support_dependency;
+}
+
+/* This function set the reference name for snapshot usage. Sometimes it needs
+ * to depend on other snapshot's data to avoid redundance.
+ */
+bool qemu_file_set_ref_name(QEMUFile *f, const char *name)
+{
+    if (strlen(name) + 1 > sizeof(f->ref_name_str)) {
+        return false;
+    }
+
+    memcpy(f->ref_name_str, name, strlen(name) + 1);
+    return true;
+}
+
+ssize_t qemu_file_save_dependency(QEMUFile *f, int64_t depend_offset,
+                                  int64_t size)
+{
+    ssize_t ret;
+
+    if (f->support_dependency == false) {
+        return -1;
+    }
+
+    assert(f->ops->save_dependency);
+
+    if (!QEMU_IS_ALIGNED(depend_offset, f->dependency_aligment)) {
+        return -1;
+    }
+
+    qemu_fflush(f);
+
+    if (!QEMU_IS_ALIGNED(f->pos, f->dependency_aligment)) {
+        return -1;
+    }
+
+    ret = f->ops->save_dependency(f->opaque, f->ref_name_str,
+                                  depend_offset, size, f->pos);
+    if (ret > 0) {
+        f->pos += size;
+    }
+
+    return ret;
+}
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index aae4e5e..137b917 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -57,6 +57,14 @@ typedef ssize_t (QEMUFileWritevBufferFunc)(void *opaque, struct iovec *iov,
                                            int iovcnt, int64_t pos);
 
 /*
+ * This function add reference to the dependency data in snapshot specified by
+ * ref_name_str to this file's offset
+ */
+typedef ssize_t (QEMUFileSaveDependencyFunc)(void *opaque, const char *name,
+                                             int64_t depend_offset,
+                                             int64_t offset, int64_t size);
+
+/*
  * This function provides hooks around different
  * stages of RAM migration.
  * 'opaque' is the backend specific data in QEMUFile
@@ -104,6 +112,7 @@ typedef struct QEMUFileOps {
     QEMUFileWritevBufferFunc *writev_buffer;
     QEMURetPathFunc *get_return_path;
     QEMUFileShutdownFunc *shut_down;
+    QEMUFileSaveDependencyFunc *save_dependency;
 } QEMUFileOps;
 
 typedef struct QEMUFileHooks {
@@ -153,6 +162,11 @@ int qemu_file_shutdown(QEMUFile *f);
 QEMUFile *qemu_file_get_return_path(QEMUFile *f);
 void qemu_fflush(QEMUFile *f);
 void qemu_file_set_blocking(QEMUFile *f, bool block);
+bool qemu_file_set_ref_name(QEMUFile *f, const char *name);
+void qemu_file_set_support_dependency(QEMUFile *f, int32_t alignment);
+bool qemu_file_is_support_dependency(QEMUFile *f, int32_t *alignment);
+ssize_t qemu_file_save_dependency(QEMUFile *f, int64_t depend_offset,
+                                  int64_t size);
 
 size_t qemu_get_counted_string(QEMUFile *f, char buf[256]);
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 358c5b5..1bbd6aa 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -196,6 +196,20 @@ static ssize_t block_writev_buffer(void *opaque, struct iovec *iov, int iovcnt,
     return qiov.size;
 }
 
+static ssize_t block_save_dependency(void *opaque, const char *id_name,
+                                     int64_t depend_offset,
+                                     int64_t offset, int64_t size)
+{
+    int ret = bdrv_snapshot_save_dependency(opaque, id_name,
+                                            depend_offset, offset,
+                                            size, NULL);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return size;
+}
+
 static ssize_t block_get_buffer(void *opaque, uint8_t *buf, int64_t pos,
                                 size_t size)
 {
@@ -213,15 +227,28 @@ static const QEMUFileOps bdrv_read_ops = {
 };
 
 static const QEMUFileOps bdrv_write_ops = {
-    .writev_buffer  = block_writev_buffer,
-    .close          = bdrv_fclose
+    .writev_buffer   = block_writev_buffer,
+    .close           = bdrv_fclose,
+    .save_dependency = block_save_dependency
 };
 
 static QEMUFile *qemu_fopen_bdrv(BlockDriverState *bs, int is_writable)
 {
+    int ret = 0;
+    int32_t alignment = 0;
+    QEMUFile *f = NULL;
+
     if (is_writable) {
-        return qemu_fopen_ops(bs, &bdrv_write_ops);
+        f = qemu_fopen_ops(bs, &bdrv_write_ops);
+
+        ret = bdrv_snapshot_support_dependency(bs, &alignment);
+        if (ret > 0) {
+            qemu_file_set_support_dependency(f, alignment);
+        }
+
+        return f;
     }
+
     return qemu_fopen_ops(bs, &bdrv_read_ops);
 }
 
-- 
2.7.4
