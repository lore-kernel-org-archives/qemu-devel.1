Received: from eggs.gnu.org ([2001:4830:134:3::10]:36911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <renyime@gmail.com>) id 1gUB5J-0007We-7i
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:49:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <renyime@gmail.com>) id 1gUB5F-0001ve-85
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:49:57 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <renyime@gmail.com>) id 1gUB5E-0001rS-Si
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:49:53 -0500
Received: by mail-pg1-x542.google.com with SMTP id v28so7394670pgk.10
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 05:49:47 -0800 (PST)
From: Ivan Ren <renyime@gmail.com>
Date: Tue,  4 Dec 2018 21:49:40 +0800
Message-Id: <1543931380-1773-1-git-send-email-ivanren@tencent.com>
Subject: [Qemu-devel] [PATCH] permit dynamic adjust compress level when
 migration running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com, dgilbert@redhat.com
Cc: qemu-devel@nongnu.org

After commit dcaf446ebda5d87e05eb41cdbafb7ae4a7cc4a62, we can't
dynamic adjust the compress level when migration running.
For some scenes, dynamic adjust the compress level to change the
compress behavior without restart a new migration is useful.

Signed-off-by: Ivan Ren <ivanren@tencent.com>
---
 migration/ram.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 7e7deec..653a484 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -361,6 +361,7 @@ struct CompressParam {
 
     /* internally used fields */
     z_stream stream;
+    int current_compress_level;
     uint8_t *originbuf;
 };
 typedef struct CompressParam CompressParam;
@@ -394,6 +395,27 @@ static QemuThread *decompress_threads;
 static QemuMutex decomp_done_lock;
 static QemuCond decomp_done_cond;
 
+static int initial_compress_stream(CompressParam *param)
+{
+    int ret = -1;
+    int current_compress_level = 0;
+
+    if (param == NULL) {
+        goto exit;
+    }
+
+    current_compress_level = migrate_compress_level();
+    if (deflateInit(&(param->stream), current_compress_level) != Z_OK) {
+        goto exit;
+    }
+
+    param->current_compress_level = current_compress_level;
+    return 0;
+
+exit:
+    return ret;
+}
+
 static bool do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
                                  ram_addr_t offset, uint8_t *source_buf);
 
@@ -410,6 +432,12 @@ static void *do_data_compress(void *opaque)
             block = param->block;
             offset = param->offset;
             param->block = NULL;
+            if (param->current_compress_level != migrate_compress_level()) {
+                if (initial_compress_stream(param) != 0) {
+                    qemu_file_set_error(migrate_get_current()->to_dst_file, -1);
+                    error_report("fail to update compress stream!");
+                }
+            }
             qemu_mutex_unlock(&param->mutex);
 
             zero_page = do_compress_ram_page(param->file, &param->stream,
@@ -488,8 +516,8 @@ static int compress_threads_save_setup(void)
             goto exit;
         }
 
-        if (deflateInit(&comp_param[i].stream,
-                        migrate_compress_level()) != Z_OK) {
+        if (initial_compress_stream(&comp_param[i]) != 0) {
+            error_report("fail to initial compress stream!");
             g_free(comp_param[i].originbuf);
             goto exit;
         }
-- 
1.8.3.1
