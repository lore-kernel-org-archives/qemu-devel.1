Received: from eggs.gnu.org ([2001:4830:134:3::10]:39072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cdKm0-0003Xt-DG
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:50:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cdKlv-0005v0-Hs
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:50:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cdKlv-0005uh-8V
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:50:43 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 13 Feb 2017 17:50:23 +0000
Message-Id: <20170213175033.7314-5-dgilbert@redhat.com>
In-Reply-To: <20170213175033.7314-1-dgilbert@redhat.com>
References: <20170213175033.7314-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 04/14] add 'release-ram' migrate capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, ashijeetacharya@gmail.com, amit@kernel.org, pbutsykin@virtuozzo.com, zhang.zhanghailiang@huawei.com

From: Pavel Butsykin <pbutsykin@virtuozzo.com>

This feature frees the migrated memory on the source during postcopy-ram
migration. In the second step of postcopy-ram migration when the source vm
is put on pause we can free unnecessary memory. It will allow, in particular,
to start relaxing the memory stress on the source host in a load-balancing
scenario.

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-Id: <20170203152321.19739-3-pbutsykin@virtuozzo.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
   Manually merged in Pavel's 'migration: madvise error_report fixup!'
---
 include/migration/migration.h |  1 +
 include/migration/qemu-file.h |  3 ++-
 migration/migration.c         |  9 +++++++
 migration/qemu-file.c         | 59 ++++++++++++++++++++++++++++++++++++++-----
 migration/ram.c               | 22 +++++++++++++++-
 qapi-schema.json              |  5 +++-
 6 files changed, 89 insertions(+), 10 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 7528cc2..b9b706a 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -304,6 +304,7 @@ int migrate_add_blocker(Error *reason, Error **errp);
  */
 void migrate_del_blocker(Error *reason);
 
+bool migrate_release_ram(void);
 bool migrate_postcopy_ram(void);
 bool migrate_zero_blocks(void);
 
diff --git a/include/migration/qemu-file.h b/include/migration/qemu-file.h
index abedd46..0cd648a 100644
--- a/include/migration/qemu-file.h
+++ b/include/migration/qemu-file.h
@@ -132,7 +132,8 @@ void qemu_put_byte(QEMUFile *f, int v);
  * put_buffer without copying the buffer.
  * The buffer should be available till it is sent asynchronously.
  */
-void qemu_put_buffer_async(QEMUFile *f, const uint8_t *buf, size_t size);
+void qemu_put_buffer_async(QEMUFile *f, const uint8_t *buf, size_t size,
+                           bool may_free);
 bool qemu_file_mode_is_not_valid(const char *mode);
 bool qemu_file_is_writable(QEMUFile *f);
 
diff --git a/migration/migration.c b/migration/migration.c
index 2b179c6..68afc07 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1297,6 +1297,15 @@ void qmp_migrate_set_downtime(double value, Error **errp)
     qmp_migrate_set_parameters(&p, errp);
 }
 
+bool migrate_release_ram(void)
+{
+    MigrationState *s;
+
+    s = migrate_get_current();
+
+    return s->enabled_capabilities[MIGRATION_CAPABILITY_RELEASE_RAM];
+}
+
 bool migrate_postcopy_ram(void)
 {
     MigrationState *s;
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index e9fae31..195fa94 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -49,6 +49,7 @@ struct QEMUFile {
     int buf_size; /* 0 when writing */
     uint8_t buf[IO_BUF_SIZE];
 
+    DECLARE_BITMAP(may_free, MAX_IOV_SIZE);
     struct iovec iov[MAX_IOV_SIZE];
     unsigned int iovcnt;
 
@@ -132,6 +133,41 @@ bool qemu_file_is_writable(QEMUFile *f)
     return f->ops->writev_buffer;
 }
 
+static void qemu_iovec_release_ram(QEMUFile *f)
+{
+    struct iovec iov;
+    unsigned long idx;
+
+    /* Find and release all the contiguous memory ranges marked as may_free. */
+    idx = find_next_bit(f->may_free, f->iovcnt, 0);
+    if (idx >= f->iovcnt) {
+        return;
+    }
+    iov = f->iov[idx];
+
+    /* The madvise() in the loop is called for iov within a continuous range and
+     * then reinitialize the iov. And in the end, madvise() is called for the
+     * last iov.
+     */
+    while ((idx = find_next_bit(f->may_free, f->iovcnt, idx + 1)) < f->iovcnt) {
+        /* check for adjacent buffer and coalesce them */
+        if (iov.iov_base + iov.iov_len == f->iov[idx].iov_base) {
+            iov.iov_len += f->iov[idx].iov_len;
+            continue;
+        }
+        if (qemu_madvise(iov.iov_base, iov.iov_len, QEMU_MADV_DONTNEED) < 0) {
+            error_report("migrate: madvise DONTNEED failed %p %zd: %s",
+                         iov.iov_base, iov.iov_len, strerror(errno));
+        }
+        iov = f->iov[idx];
+    }
+    if (qemu_madvise(iov.iov_base, iov.iov_len, QEMU_MADV_DONTNEED) < 0) {
+            error_report("migrate: madvise DONTNEED failed %p %zd: %s",
+                         iov.iov_base, iov.iov_len, strerror(errno));
+    }
+    memset(f->may_free, 0, sizeof(f->may_free));
+}
+
 /**
  * Flushes QEMUFile buffer
  *
@@ -151,6 +187,8 @@ void qemu_fflush(QEMUFile *f)
     if (f->iovcnt > 0) {
         expect = iov_size(f->iov, f->iovcnt);
         ret = f->ops->writev_buffer(f->opaque, f->iov, f->iovcnt, f->pos);
+
+        qemu_iovec_release_ram(f);
     }
 
     if (ret >= 0) {
@@ -304,13 +342,19 @@ int qemu_fclose(QEMUFile *f)
     return ret;
 }
 
-static void add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size)
+static void add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size,
+                         bool may_free)
 {
     /* check for adjacent buffer and coalesce them */
     if (f->iovcnt > 0 && buf == f->iov[f->iovcnt - 1].iov_base +
-        f->iov[f->iovcnt - 1].iov_len) {
+        f->iov[f->iovcnt - 1].iov_len &&
+        may_free == test_bit(f->iovcnt - 1, f->may_free))
+    {
         f->iov[f->iovcnt - 1].iov_len += size;
     } else {
+        if (may_free) {
+            set_bit(f->iovcnt, f->may_free);
+        }
         f->iov[f->iovcnt].iov_base = (uint8_t *)buf;
         f->iov[f->iovcnt++].iov_len = size;
     }
@@ -320,14 +364,15 @@ static void add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size)
     }
 }
 
-void qemu_put_buffer_async(QEMUFile *f, const uint8_t *buf, size_t size)
+void qemu_put_buffer_async(QEMUFile *f, const uint8_t *buf, size_t size,
+                           bool may_free)
 {
     if (f->last_error) {
         return;
     }
 
     f->bytes_xfer += size;
-    add_to_iovec(f, buf, size);
+    add_to_iovec(f, buf, size, may_free);
 }
 
 void qemu_put_buffer(QEMUFile *f, const uint8_t *buf, size_t size)
@@ -345,7 +390,7 @@ void qemu_put_buffer(QEMUFile *f, const uint8_t *buf, size_t size)
         }
         memcpy(f->buf + f->buf_index, buf, l);
         f->bytes_xfer += l;
-        add_to_iovec(f, f->buf + f->buf_index, l);
+        add_to_iovec(f, f->buf + f->buf_index, l, false);
         f->buf_index += l;
         if (f->buf_index == IO_BUF_SIZE) {
             qemu_fflush(f);
@@ -366,7 +411,7 @@ void qemu_put_byte(QEMUFile *f, int v)
 
     f->buf[f->buf_index] = v;
     f->bytes_xfer++;
-    add_to_iovec(f, f->buf + f->buf_index, 1);
+    add_to_iovec(f, f->buf + f->buf_index, 1, false);
     f->buf_index++;
     if (f->buf_index == IO_BUF_SIZE) {
         qemu_fflush(f);
@@ -647,7 +692,7 @@ ssize_t qemu_put_compression_data(QEMUFile *f, const uint8_t *p, size_t size,
     }
     qemu_put_be32(f, blen);
     if (f->ops->writev_buffer) {
-        add_to_iovec(f, f->buf + f->buf_index, blen);
+        add_to_iovec(f, f->buf + f->buf_index, blen, false);
     }
     f->buf_index += blen;
     if (f->buf_index == IO_BUF_SIZE) {
diff --git a/migration/ram.c b/migration/ram.c
index 91443b3..c22209d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -705,6 +705,16 @@ static int save_zero_page(QEMUFile *f, RAMBlock *block, ram_addr_t offset,
     return pages;
 }
 
+static void ram_release_pages(MigrationState *ms, const char *block_name,
+                              uint64_t offset, int pages)
+{
+    if (!migrate_release_ram() || !migration_in_postcopy(ms)) {
+        return;
+    }
+
+    ram_discard_range(NULL, block_name, offset, pages << TARGET_PAGE_BITS);
+}
+
 /**
  * ram_save_page: Send the given page to the stream
  *
@@ -765,6 +775,7 @@ static int ram_save_page(MigrationState *ms, QEMUFile *f, PageSearchStatus *pss,
              * page would be stale
              */
             xbzrle_cache_zero_page(current_addr);
+            ram_release_pages(ms, block->idstr, pss->offset, pages);
         } else if (!ram_bulk_stage &&
                    !migration_in_postcopy(ms) && migrate_use_xbzrle()) {
             pages = save_xbzrle_page(f, &p, current_addr, block,
@@ -783,7 +794,9 @@ static int ram_save_page(MigrationState *ms, QEMUFile *f, PageSearchStatus *pss,
         *bytes_transferred += save_page_header(f, block,
                                                offset | RAM_SAVE_FLAG_PAGE);
         if (send_async) {
-            qemu_put_buffer_async(f, p, TARGET_PAGE_SIZE);
+            qemu_put_buffer_async(f, p, TARGET_PAGE_SIZE,
+                                  migrate_release_ram() &
+                                  migration_in_postcopy(ms));
         } else {
             qemu_put_buffer(f, p, TARGET_PAGE_SIZE);
         }
@@ -813,6 +826,8 @@ static int do_compress_ram_page(QEMUFile *f, RAMBlock *block,
         error_report("compressed data failed!");
     } else {
         bytes_sent += blen;
+        ram_release_pages(migrate_get_current(), block->idstr,
+                          offset & TARGET_PAGE_MASK, 1);
     }
 
     return bytes_sent;
@@ -952,12 +967,17 @@ static int ram_save_compressed_page(MigrationState *ms, QEMUFile *f,
                     error_report("compressed data failed!");
                 }
             }
+            if (pages > 0) {
+                ram_release_pages(ms, block->idstr, pss->offset, pages);
+            }
         } else {
             offset |= RAM_SAVE_FLAG_CONTINUE;
             pages = save_zero_page(f, block, offset, p, bytes_transferred);
             if (pages == -1) {
                 pages = compress_page_with_multi_thread(f, block, offset,
                                                         bytes_transferred);
+            } else {
+                ram_release_pages(ms, block->idstr, pss->offset, pages);
             }
         }
     }
diff --git a/qapi-schema.json b/qapi-schema.json
index 61151f3..9330541 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -865,11 +865,14 @@
 #        side, this process is called COarse-Grain LOck Stepping (COLO) for
 #        Non-stop Service. (since 2.8)
 #
+# @release-ram: if enabled, qemu will free the migrated ram pages on the source
+#        during postcopy-ram migration. (since 2.9)
+#
 # Since: 1.2
 ##
 { 'enum': 'MigrationCapability',
   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
-           'compress', 'events', 'postcopy-ram', 'x-colo'] }
+           'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram'] }
 
 ##
 # @MigrationCapabilityStatus:
-- 
2.9.3
