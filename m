Received: from eggs.gnu.org ([209.51.188.92]:40384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1gycaU-0005He-He
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:16:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1gycaO-0006y7-S4
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:15:56 -0500
Received: from relay.sw.ru ([185.231.240.75]:43590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1gycaL-0006ux-3g
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:15:51 -0500
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date: Tue, 26 Feb 2019 16:15:33 +0300
Message-Id: <20190226131535.30361-2-dplotnikov@virtuozzo.com>
In-Reply-To: <20190226131535.30361-1-dplotnikov@virtuozzo.com>
References: <20190226131535.30361-1-dplotnikov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/3] migration: rework compression code for
 adding more data compressors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, quintela@redhat.com, eblake@redhat.com, armbru@redhat.com
Cc: den@virtuozzo.com, qemu-devel@nongnu.org

Also, the patch adds new migration parameter parameter: compress-type
to be able choose between data compressors available.

By the moment, the only available data compressor is gzip (zlib)

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 migration/migration.c |  42 ++++++++-
 migration/migration.h |   1 +
 migration/qemu-file.c |  39 +++------
 migration/qemu-file.h |  17 +++-
 migration/ram.c       | 196 +++++++++++++++++++++++++++++++-----------
 qapi/migration.json   |  26 ++++--
 6 files changed, 236 insertions(+), 85 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 37e06b76dc..10cecb0eeb 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -739,6 +739,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->max_postcopy_bandwidth = s->parameters.max_postcopy_bandwidth;
     params->has_max_cpu_throttle = true;
     params->max_cpu_throttle = s->parameters.max_cpu_throttle;
+    params->has_compress_type = true;
+    params->compress_type = s->parameters.compress_type;
 
     return params;
 }
@@ -1027,10 +1029,27 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
  */
 static bool migrate_params_check(MigrationParameters *params, Error **errp)
 {
+    int max_compress_level = -1;
+
+    if (params->has_compress_type) {
+        switch (params->compress_type) {
+        case COMPRESSION_TYPE_ZLIB:
+            max_compress_level = 9;
+            break;
+        default:
+            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "compress_type",
+                       "values: 0 - gzip");
+            return false;
+        }
+    }
+
     if (params->has_compress_level &&
-        (params->compress_level > 9)) {
+        (params->compress_level > max_compress_level)) {
+        char level_range_msg[30];
+        snprintf(level_range_msg, 30, "values from 0 to %d",
+                 max_compress_level);
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "compress_level",
-                   "is invalid, it should be in the range of 0 to 9");
+                   level_range_msg);
         return false;
     }
 
@@ -1125,6 +1144,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     *dest = migrate_get_current()->parameters;
 
     /* TODO use QAPI_CLONE() instead of duplicating it inline */
+    if (params->has_compress_type) {
+        dest->compress_type = params->compress_type;
+    }
 
     if (params->has_compress_level) {
         dest->compress_level = params->compress_level;
@@ -1272,6 +1294,9 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_max_cpu_throttle) {
         s->parameters.max_cpu_throttle = params->max_cpu_throttle;
     }
+    if (params->has_compress_type) {
+        s->parameters.compress_type = params->compress_type;
+    }
 }
 
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
@@ -1938,6 +1963,15 @@ bool migrate_use_compression(void)
     return s->enabled_capabilities[MIGRATION_CAPABILITY_COMPRESS];
 }
 
+int migrate_compress_type(void)
+{
+    MigrationState *s;
+
+    s = migrate_get_current();
+
+    return s->parameters.compress_type;
+}
+
 int migrate_compress_level(void)
 {
     MigrationState *s;
@@ -3234,6 +3268,9 @@ static Property migration_properties[] = {
                       decompress_error_check, true),
 
     /* Migration parameters */
+    DEFINE_PROP_UINT8("x-compress-type", MigrationState,
+                      parameters.compress_type,
+                      COMPRESSION_TYPE_ZLIB),
     DEFINE_PROP_UINT8("x-compress-level", MigrationState,
                       parameters.compress_level,
                       DEFAULT_MIGRATE_COMPRESS_LEVEL),
@@ -3346,6 +3383,7 @@ static void migration_instance_init(Object *obj)
     params->has_xbzrle_cache_size = true;
     params->has_max_postcopy_bandwidth = true;
     params->has_max_cpu_throttle = true;
+    params->has_compress_type = true;
 
     qemu_sem_init(&ms->postcopy_pause_sem, 0);
     qemu_sem_init(&ms->postcopy_pause_rp_sem, 0);
diff --git a/migration/migration.h b/migration/migration.h
index dcd05d9f87..ddb9efec86 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -280,6 +280,7 @@ bool migrate_use_return_path(void);
 uint64_t ram_get_total_transferred_pages(void);
 
 bool migrate_use_compression(void);
+int migrate_compress_type(void);
 int migrate_compress_level(void);
 int migrate_compress_threads(void);
 int migrate_compress_wait_thread(void);
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 977b9ae07c..cd95749aa6 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -662,28 +662,10 @@ uint64_t qemu_get_be64(QEMUFile *f)
     return v;
 }
 
-/* return the size after compression, or negative value on error */
-static int qemu_compress_data(z_stream *stream, uint8_t *dest, size_t dest_len,
+static int qemu_compress_data(Compression *comp, uint8_t *dest, size_t dest_len,
                               const uint8_t *source, size_t source_len)
 {
-    int err;
-
-    err = deflateReset(stream);
-    if (err != Z_OK) {
-        return -1;
-    }
-
-    stream->avail_in = source_len;
-    stream->next_in = (uint8_t *)source;
-    stream->avail_out = dest_len;
-    stream->next_out = dest;
-
-    err = deflate(stream, Z_FINISH);
-    if (err != Z_STREAM_END) {
-        return -1;
-    }
-
-    return stream->next_out - dest;
+    return comp->process(comp, dest, dest_len, source, source_len);
 }
 
 /* Compress size bytes of data start at p and store the compressed
@@ -695,23 +677,30 @@ static int qemu_compress_data(z_stream *stream, uint8_t *dest, size_t dest_len,
  * do fflush first, if f still has no space to save the compressed
  * data, return -1.
  */
-ssize_t qemu_put_compression_data(QEMUFile *f, z_stream *stream,
+ssize_t qemu_put_compression_data(QEMUFile *f, Compression *comp,
                                   const uint8_t *p, size_t size)
 {
-    ssize_t blen = IO_BUF_SIZE - f->buf_index - sizeof(int32_t);
+    int blen = IO_BUF_SIZE - f->buf_index - sizeof(int32_t);
+    unsigned long bound;
 
-    if (blen < compressBound(size)) {
+    bound = comp->get_bound(size);
+
+    if (blen < bound) {
         if (!qemu_file_is_writable(f)) {
+            error_report("compression: qemu file is not writable");
             return -1;
         }
+
         qemu_fflush(f);
         blen = IO_BUF_SIZE - sizeof(int32_t);
-        if (blen < compressBound(size)) {
+        if (blen < bound) {
+            error_report("compression: io buffer is too small:%d needed: %lu",
+                         IO_BUF_SIZE, bound);
             return -1;
         }
     }
 
-    blen = qemu_compress_data(stream, f->buf + f->buf_index + sizeof(int32_t),
+    blen = qemu_compress_data(comp, f->buf + f->buf_index + sizeof(int32_t),
                               blen, p, size);
     if (blen < 0) {
         return -1;
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 2ccfcfb2a8..24cf0d7e25 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -115,6 +115,21 @@ typedef struct QEMUFileHooks {
     QEMURamSaveFunc *save_page;
 } QEMUFileHooks;
 
+typedef enum CompressionType {
+    COMPRESSION_TYPE_ZLIB = 0,
+} CompressionType;
+
+struct Compression {
+    CompressionType type;
+    bool is_decompression;
+    void *stream;
+    int (*process)(struct Compression *comp, uint8_t *dest, size_t dest_len,
+                    const uint8_t *source, size_t source_len);
+    unsigned long (*get_bound)(unsigned long);
+};
+
+typedef struct Compression Compression;
+
 QEMUFile *qemu_fopen_ops(void *opaque, const QEMUFileOps *ops);
 void qemu_file_set_hooks(QEMUFile *f, const QEMUFileHooks *hooks);
 int qemu_get_fd(QEMUFile *f);
@@ -134,7 +149,7 @@ bool qemu_file_is_writable(QEMUFile *f);
 
 size_t qemu_peek_buffer(QEMUFile *f, uint8_t **buf, size_t size, size_t offset);
 size_t qemu_get_buffer_in_place(QEMUFile *f, uint8_t **buf, size_t size);
-ssize_t qemu_put_compression_data(QEMUFile *f, z_stream *stream,
+ssize_t qemu_put_compression_data(QEMUFile *f, Compression *comp,
                                   const uint8_t *p, size_t size);
 int qemu_put_qemu_file(QEMUFile *f_des, QEMUFile *f_src);
 
diff --git a/migration/ram.c b/migration/ram.c
index 59191c1ed2..9ff154ed7b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -360,8 +360,8 @@ struct CompressParam {
     ram_addr_t offset;
 
     /* internally used fields */
-    z_stream stream;
     uint8_t *originbuf;
+    Compression comp;
 };
 typedef struct CompressParam CompressParam;
 
@@ -373,7 +373,7 @@ struct DecompressParam {
     void *des;
     uint8_t *compbuf;
     int len;
-    z_stream stream;
+    Compression comp;
 };
 typedef struct DecompressParam DecompressParam;
 
@@ -394,8 +394,114 @@ static QemuThread *decompress_threads;
 static QemuMutex decomp_done_lock;
 static QemuCond decomp_done_cond;
 
-static bool do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
-                                 ram_addr_t offset, uint8_t *source_buf);
+static bool do_compress_ram_page(QEMUFile *f, Compression *comp,
+                                 RAMBlock *block, ram_addr_t offset,
+                                 uint8_t *source_buf);
+
+static int zlib_compress(Compression *comp, uint8_t *dest, size_t dest_len,
+                         const uint8_t *source, size_t source_len)
+{
+    int err;
+    z_stream *stream = comp->stream;
+
+    err = deflateReset(comp->stream);
+    if (err != Z_OK) {
+        return -1;
+    }
+
+    stream->avail_in = source_len;
+    stream->next_in = (uint8_t *)source;
+    stream->avail_out = dest_len;
+    stream->next_out = dest;
+
+    err = deflate(stream, Z_FINISH);
+    if (err != Z_STREAM_END) {
+        return -1;
+    }
+
+    return stream->next_out - dest;
+}
+
+static int zlib_decompress(Compression *comp, uint8_t *dest, size_t dest_len,
+                         const uint8_t *source, size_t source_len)
+{
+    int err;
+    z_stream *stream = comp->stream;
+
+    err = inflateReset(stream);
+    if (err != Z_OK) {
+        return -1;
+    }
+
+    stream->avail_in = source_len;
+    stream->next_in = (uint8_t *)source;
+    stream->avail_out = dest_len;
+    stream->next_out = dest;
+
+    err = inflate(stream, Z_NO_FLUSH);
+    if (err != Z_STREAM_END) {
+        return -1;
+    }
+
+    return stream->total_out;
+}
+
+static int init_compression(Compression *comp, CompressionType type,
+                            bool is_decompression)
+{
+    int res;
+
+    switch (type) {
+    case COMPRESSION_TYPE_ZLIB:
+        comp->stream = g_new0(z_stream, 1);
+
+        if (is_decompression) {
+            res = inflateInit(comp->stream);
+        } else {
+            res = deflateInit(comp->stream, migrate_compress_level());
+        }
+
+        if (res != Z_OK) {
+            g_free(comp->stream);
+            return 1;
+        }
+
+        if (is_decompression) {
+            comp->process = zlib_decompress;
+        } else {
+            comp->process = zlib_compress;
+        }
+
+        comp->get_bound = compressBound;
+        break;
+    default:
+        return 1;
+    }
+
+    comp->type = type;
+    comp->is_decompression = is_decompression;
+    return 0;
+}
+
+static void destroy_compression(Compression *comp)
+{
+    assert(comp);
+
+    switch (comp->type) {
+    case COMPRESSION_TYPE_ZLIB:
+        if (comp->is_decompression) {
+            inflateEnd(comp->stream);
+        } else {
+            deflateEnd(comp->stream);
+        }
+        g_free(comp->stream);
+        break;
+    default:
+        assert(false);
+    }
+
+    memset(comp, 0, sizeof(Compression));
+}
 
 static void *do_data_compress(void *opaque)
 {
@@ -412,7 +518,7 @@ static void *do_data_compress(void *opaque)
             param->block = NULL;
             qemu_mutex_unlock(&param->mutex);
 
-            zero_page = do_compress_ram_page(param->file, &param->stream,
+            zero_page = do_compress_ram_page(param->file, &param->comp,
                                              block, offset, param->originbuf);
 
             qemu_mutex_lock(&comp_done_lock);
@@ -457,7 +563,7 @@ static void compress_threads_save_cleanup(void)
         qemu_thread_join(compress_threads + i);
         qemu_mutex_destroy(&comp_param[i].mutex);
         qemu_cond_destroy(&comp_param[i].cond);
-        deflateEnd(&comp_param[i].stream);
+        destroy_compression(&comp_param->comp);
         g_free(comp_param[i].originbuf);
         qemu_fclose(comp_param[i].file);
         comp_param[i].file = NULL;
@@ -480,31 +586,32 @@ static int compress_threads_save_setup(void)
     thread_count = migrate_compress_threads();
     compress_threads = g_new0(QemuThread, thread_count);
     comp_param = g_new0(CompressParam, thread_count);
+
     qemu_cond_init(&comp_done_cond);
     qemu_mutex_init(&comp_done_lock);
     for (i = 0; i < thread_count; i++) {
-        comp_param[i].originbuf = g_try_malloc(TARGET_PAGE_SIZE);
-        if (!comp_param[i].originbuf) {
+        CompressParam *comp = &comp_param[i];
+
+        comp->originbuf = g_try_malloc(TARGET_PAGE_SIZE);
+        if (!comp->originbuf) {
             goto exit;
         }
 
-        if (deflateInit(&comp_param[i].stream,
-                        migrate_compress_level()) != Z_OK) {
-            g_free(comp_param[i].originbuf);
+        if (init_compression(&comp->comp, migrate_compress_type(), false)) {
+            g_free(comp->originbuf);
             goto exit;
         }
 
         /* comp_param[i].file is just used as a dummy buffer to save data,
          * set its ops to empty.
          */
-        comp_param[i].file = qemu_fopen_ops(NULL, &empty_ops);
-        comp_param[i].done = true;
-        comp_param[i].quit = false;
-        qemu_mutex_init(&comp_param[i].mutex);
-        qemu_cond_init(&comp_param[i].cond);
-        qemu_thread_create(compress_threads + i, "compress",
-                           do_data_compress, comp_param + i,
-                           QEMU_THREAD_JOINABLE);
+        comp->file = qemu_fopen_ops(NULL, &empty_ops);
+        comp->done = true;
+        comp->quit = false;
+        qemu_mutex_init(&comp->mutex);
+        qemu_cond_init(&comp->cond);
+        qemu_thread_create(compress_threads + i, "compress", do_data_compress,
+                           comp, QEMU_THREAD_JOINABLE);
     }
     return 0;
 
@@ -1890,8 +1997,9 @@ static int ram_save_multifd_page(RAMState *rs, RAMBlock *block,
     return 1;
 }
 
-static bool do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
-                                 ram_addr_t offset, uint8_t *source_buf)
+static bool do_compress_ram_page(QEMUFile *f, Compression *comp,
+                                 RAMBlock *block, ram_addr_t offset,
+                                 uint8_t *source_buf)
 {
     RAMState *rs = ram_state;
     uint8_t *p = block->host + (offset & TARGET_PAGE_MASK);
@@ -1911,7 +2019,7 @@ static bool do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
      * decompression
      */
     memcpy(source_buf, p, TARGET_PAGE_SIZE);
-    ret = qemu_put_compression_data(f, stream, source_buf, TARGET_PAGE_SIZE);
+    ret = qemu_put_compression_data(f, comp, source_buf, TARGET_PAGE_SIZE);
     if (ret < 0) {
         qemu_file_set_error(migrate_get_current()->to_dst_file, ret);
         error_report("compressed data failed!");
@@ -3502,28 +3610,14 @@ void ram_handle_compressed(void *host, uint8_t ch, uint64_t size)
 }
 
 /* return the size after decompression, or negative value on error */
-static int
-qemu_uncompress_data(z_stream *stream, uint8_t *dest, size_t dest_len,
-                     const uint8_t *source, size_t source_len)
+static int qemu_uncompress_data(Compression *comp, uint8_t *dest,
+                                size_t dest_len, const uint8_t *source,
+                                size_t source_len)
 {
-    int err;
-
-    err = inflateReset(stream);
-    if (err != Z_OK) {
+    if (source_len > comp->get_bound(TARGET_PAGE_SIZE)) {
         return -1;
     }
-
-    stream->avail_in = source_len;
-    stream->next_in = (uint8_t *)source;
-    stream->avail_out = dest_len;
-    stream->next_out = dest;
-
-    err = inflate(stream, Z_NO_FLUSH);
-    if (err != Z_STREAM_END) {
-        return -1;
-    }
-
-    return stream->total_out;
+    return comp->process(comp, dest, dest_len, source, source_len);
 }
 
 static void *do_data_decompress(void *opaque)
@@ -3543,7 +3637,7 @@ static void *do_data_decompress(void *opaque)
 
             pagesize = TARGET_PAGE_SIZE;
 
-            ret = qemu_uncompress_data(&param->stream, des, pagesize,
+            ret = qemu_uncompress_data(&param->comp, des, pagesize,
                                        param->compbuf, len);
             if (ret < 0 && migrate_get_current()->decompress_error_check) {
                 error_report("decompress data failed");
@@ -3614,7 +3708,7 @@ static void compress_threads_load_cleanup(void)
         qemu_thread_join(decompress_threads + i);
         qemu_mutex_destroy(&decomp_param[i].mutex);
         qemu_cond_destroy(&decomp_param[i].cond);
-        inflateEnd(&decomp_param[i].stream);
+        destroy_compression(&decomp_param[i].comp);
         g_free(decomp_param[i].compbuf);
         decomp_param[i].compbuf = NULL;
     }
@@ -3640,15 +3734,17 @@ static int compress_threads_load_setup(QEMUFile *f)
     qemu_cond_init(&decomp_done_cond);
     decomp_file = f;
     for (i = 0; i < thread_count; i++) {
-        if (inflateInit(&decomp_param[i].stream) != Z_OK) {
+        DecompressParam *decomp = &decomp_param[i];
+
+        if (init_compression(&decomp->comp, migrate_compress_type(), true)) {
             goto exit;
         }
 
-        decomp_param[i].compbuf = g_malloc0(compressBound(TARGET_PAGE_SIZE));
-        qemu_mutex_init(&decomp_param[i].mutex);
-        qemu_cond_init(&decomp_param[i].cond);
-        decomp_param[i].done = true;
-        decomp_param[i].quit = false;
+        decomp->compbuf = g_malloc0(decomp->comp.get_bound(TARGET_PAGE_SIZE));
+        qemu_mutex_init(&decomp->mutex);
+        qemu_cond_init(&decomp->cond);
+        decomp->done = true;
+        decomp->quit = false;
         qemu_thread_create(decompress_threads + i, "decompress",
                            do_data_decompress, decomp_param + i,
                            QEMU_THREAD_JOINABLE);
@@ -4169,7 +4265,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
 
         case RAM_SAVE_FLAG_COMPRESS_PAGE:
             len = qemu_get_be32(f);
-            if (len < 0 || len > compressBound(TARGET_PAGE_SIZE)) {
+            if (len < 0) {
                 error_report("Invalid compressed data length: %d", len);
                 ret = -EINVAL;
                 break;
diff --git a/qapi/migration.json b/qapi/migration.json
index 7a795ecc16..9a3110e383 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -480,10 +480,15 @@
 #
 # Migration parameters enumeration
 #
+# @compress-type: Set the compression type to be used in live migration,
+#          the compression type is an integer from the list:
+#          0 - gzip
+#
 # @compress-level: Set the compression level to be used in live migration,
-#          the compression level is an integer between 0 and 9, where 0 means
-#          no compression, 1 means the best compression speed, and 9 means best
-#          compression ratio which will consume more CPU.
+#          the compression level is an integer between 0 and 9,
+#          where 0 means no compression, 1 means the best compression speed,
+#          and the highest value depending on the compression type means
+#          the best compression ratio which will consume more CPU.
 #
 # @compress-threads: Set compression thread count to be used in live migration,
 #          the compression thread count is an integer between 1 and 255.
@@ -560,8 +565,8 @@
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
-  'data': ['compress-level', 'compress-threads', 'decompress-threads',
-           'compress-wait-thread',
+  'data': ['compress-type', 'compress-level', 'compress-threads',
+           'decompress-threads', 'compress-wait-thread',
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'tls-creds', 'tls-hostname', 'max-bandwidth',
            'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
@@ -572,6 +577,9 @@
 ##
 # @MigrateSetParameters:
 #
+# @compress-type: Compression type is used for migration.
+#                 Available types:  0 - gzip
+#
 # @compress-level: compression level
 #
 # @compress-threads: compression thread count
@@ -653,7 +661,8 @@
 # TODO either fuse back into MigrationParameters, or make
 # MigrationParameters members mandatory
 { 'struct': 'MigrateSetParameters',
-  'data': { '*compress-level': 'int',
+  'data': { '*compress-type': 'int',
+            '*compress-level': 'int',
             '*compress-threads': 'int',
             '*compress-wait-thread': 'bool',
             '*decompress-threads': 'int',
@@ -692,6 +701,8 @@
 #
 # The optional members aren't actually optional.
 #
+# @compress-type: compression type
+#
 # @compress-level: compression level
 #
 # @compress-threads: compression thread count
@@ -769,7 +780,8 @@
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
-  'data': { '*compress-level': 'uint8',
+  'data': { '*compress-type': 'uint8',
+            '*compress-level': 'uint8',
             '*compress-threads': 'uint8',
             '*compress-wait-thread': 'bool',
             '*decompress-threads': 'uint8',
-- 
2.17.0
