Received: from eggs.gnu.org ([2001:4830:134:3::10]:43945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1ejKFL-0004zP-B8
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 02:34:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1ejKFK-0000eW-CP
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 02:34:23 -0500
Received: from mga09.intel.com ([134.134.136.24]:13680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1ejKFJ-0000Td-VF
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 02:34:22 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Wed,  7 Feb 2018 15:33:30 +0800
Message-Id: <20180207073331.14158-8-haozhong.zhang@intel.com>
In-Reply-To: <20180207073331.14158-1-haozhong.zhang@intel.com>
References: <20180207073331.14158-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v2 7/8] migration/ram: ensure write persistence
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
 include/qemu/pmem.h |  4 ++++
 migration/ram.c     | 16 +++++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/qemu/pmem.h b/include/qemu/pmem.h
index 77ee1fc4eb..20e3f6e71d 100644
--- a/include/qemu/pmem.h
+++ b/include/qemu/pmem.h
@@ -37,6 +37,10 @@ static inline void *pmem_memset_nodrain(void *pmemdest, int c, size_t len)
     return memset(pmemdest, c, len);
 }
 
+static inline void pmem_flush(const void *addr, size_t len)
+{
+}
+
 static inline void pmem_drain(void)
 {
 }
diff --git a/migration/ram.c b/migration/ram.c
index 5a79bbff64..924d2b9537 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -274,6 +274,7 @@ struct DecompressParam {
     void *des;
     uint8_t *compbuf;
     int len;
+    bool is_pmem;
 };
 typedef struct DecompressParam DecompressParam;
 
@@ -2502,7 +2503,7 @@ static void *do_data_decompress(void *opaque)
     DecompressParam *param = opaque;
     unsigned long pagesize;
     uint8_t *des;
-    int len;
+    int len, rc;
 
     qemu_mutex_lock(&param->mutex);
     while (!param->quit) {
@@ -2518,8 +2519,11 @@ static void *do_data_decompress(void *opaque)
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
@@ -2605,7 +2609,8 @@ static void compress_threads_load_cleanup(void)
 }
 
 static void decompress_data_with_multi_threads(QEMUFile *f,
-                                               void *host, int len)
+                                               void *host, int len,
+                                               bool is_pmem)
 {
     int idx, thread_count;
 
@@ -2619,6 +2624,7 @@ static void decompress_data_with_multi_threads(QEMUFile *f,
                 qemu_get_buffer(f, decomp_param[idx].compbuf, len);
                 decomp_param[idx].des = host;
                 decomp_param[idx].len = len;
+                decomp_param[idx].is_pmem = is_pmem;
                 qemu_cond_signal(&decomp_param[idx].cond);
                 qemu_mutex_unlock(&decomp_param[idx].mutex);
                 break;
@@ -2964,7 +2970,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
                 ret = -EINVAL;
                 break;
             }
-            decompress_data_with_multi_threads(f, host, len);
+            decompress_data_with_multi_threads(f, host, len, is_pmem);
             break;
 
         case RAM_SAVE_FLAG_XBZRLE:
-- 
2.14.1
