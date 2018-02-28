Received: from eggs.gnu.org ([2001:4830:134:3::10]:55276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eqw8K-0004lz-Ab
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 02:26:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eqw8J-0000Qv-CK
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 02:26:36 -0500
Received: from mga02.intel.com ([134.134.136.20]:30637)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eqw8J-0000CT-0R
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 02:26:35 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Wed, 28 Feb 2018 15:25:57 +0800
Message-Id: <20180228072558.7434-8-haozhong.zhang@intel.com>
In-Reply-To: <20180228072558.7434-1-haozhong.zhang@intel.com>
References: <20180228072558.7434-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v4 7/8] migration/ram: ensure write persistence
 on loading compressed pages to PMEM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Juan Quintela <quintela@redhat.com>, dgilbert@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

When loading a compressed page to persistent memory, flush CPU cache
after the data is decompressed. Combined with a call to pmem_drain()
at the end of memory loading, we can guarantee those compressed pages
are persistently loaded to PMEM.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
 include/qemu/pmem.h |  1 +
 migration/ram.c     | 16 +++++++++++-----
 stubs/pmem.c        |  4 ++++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/qemu/pmem.h b/include/qemu/pmem.h
index 127b87c326..120439ecb8 100644
--- a/include/qemu/pmem.h
+++ b/include/qemu/pmem.h
@@ -20,6 +20,7 @@ void *pmem_memcpy_nodrain(void *pmemdest, const void *src, size_t len);
 void *pmem_memcpy_persist(void *pmemdest, const void *src, size_t len);
 void *pmem_memset_nodrain(void *pmemdest, int c, size_t len);
 void pmem_drain(void);
+void pmem_flush(const void *addr, size_t len);
 
 #endif /* CONFIG_LIBPMEM */
 
diff --git a/migration/ram.c b/migration/ram.c
index ea2ad7dff0..37f3c39cee 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -276,6 +276,7 @@ struct DecompressParam {
     void *des;
     uint8_t *compbuf;
     int len;
+    bool is_pmem;
 };
 typedef struct DecompressParam DecompressParam;
 
@@ -2498,7 +2499,7 @@ static void *do_data_decompress(void *opaque)
     DecompressParam *param = opaque;
     unsigned long pagesize;
     uint8_t *des;
-    int len;
+    int len, rc;
 
     qemu_mutex_lock(&param->mutex);
     while (!param->quit) {
@@ -2514,8 +2515,11 @@ static void *do_data_decompress(void *opaque)
              * not a problem because the dirty page will be retransferred
              * and uncompress() won't break the data in other pages.
              */
-            uncompress((Bytef *)des, &pagesize,
-                       (const Bytef *)param->compbuf, len);
+            rc = uncompress((Bytef *)des, &pagesize,
+                            (const Bytef *)param->compbuf, len);
+            if (rc == Z_OK && param->is_pmem) {
+                pmem_flush(des, len);
+            }
 
             qemu_mutex_lock(&decomp_done_lock);
             param->done = true;
@@ -2601,7 +2605,8 @@ static void compress_threads_load_cleanup(void)
 }
 
 static void decompress_data_with_multi_threads(QEMUFile *f,
-                                               void *host, int len)
+                                               void *host, int len,
+                                               bool is_pmem)
 {
     int idx, thread_count;
 
@@ -2615,6 +2620,7 @@ static void decompress_data_with_multi_threads(QEMUFile *f,
                 qemu_get_buffer(f, decomp_param[idx].compbuf, len);
                 decomp_param[idx].des = host;
                 decomp_param[idx].len = len;
+                decomp_param[idx].is_pmem = is_pmem;
                 qemu_cond_signal(&decomp_param[idx].cond);
                 qemu_mutex_unlock(&decomp_param[idx].mutex);
                 break;
@@ -2969,7 +2975,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
                 ret = -EINVAL;
                 break;
             }
-            decompress_data_with_multi_threads(f, host, len);
+            decompress_data_with_multi_threads(f, host, len, is_pmem);
             break;
 
         case RAM_SAVE_FLAG_XBZRLE:
diff --git a/stubs/pmem.c b/stubs/pmem.c
index e172f31174..cfab830131 100644
--- a/stubs/pmem.c
+++ b/stubs/pmem.c
@@ -31,3 +31,7 @@ void *pmem_memcpy_nodrain(void *pmemdest, const void *src, size_t len)
 {
     return memcpy(pmemdest, src, len);
 }
+
+void pmem_flush(const void *addr, size_t len)
+{
+}
-- 
2.14.1
