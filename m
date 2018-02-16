Received: from eggs.gnu.org ([2001:4830:134:3::10]:44476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1embfm-0004Tc-8y
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 03:47:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1embfj-0001Kk-0K
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 03:47:14 -0500
Received: from mga17.intel.com ([192.55.52.151]:12665)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1embfi-0001Da-Ji
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 03:47:10 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Fri, 16 Feb 2018 16:46:12 +0800
Message-Id: <20180216084615.26483-6-haozhong.zhang@intel.com>
In-Reply-To: <20180216084615.26483-1-haozhong.zhang@intel.com>
References: <20180216084615.26483-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v3 5/8] migration/ram: ensure write persistence
 on loading zero pages to PMEM
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

When loading a zero page, check whether it will be loaded to
persistent memory If yes, load it by libpmem function
pmem_memset_nodrain().  Combined with a call to pmem_drain() at the
end of RAM loading, we can guarantee all those zero pages are
persistently loaded.

Depending on the host HW/SW configurations, pmem_drain() can be
"sfence".  Therefore, we do not call pmem_drain() after each
pmem_memset_nodrain(), or use pmem_memset_persist() (equally
pmem_memset_nodrain() + pmem_drain()), in order to avoid unnecessary
overhead.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
 include/qemu/pmem.h |  2 ++
 migration/ram.c     | 25 +++++++++++++++++++++----
 migration/ram.h     |  2 +-
 migration/rdma.c    |  2 +-
 stubs/pmem.c        |  9 +++++++++
 5 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/include/qemu/pmem.h b/include/qemu/pmem.h
index 16f5b2653a..ce96379f3c 100644
--- a/include/qemu/pmem.h
+++ b/include/qemu/pmem.h
@@ -17,6 +17,8 @@
 #else  /* !CONFIG_LIBPMEM */
 
 void *pmem_memcpy_persist(void *pmemdest, const void *src, size_t len);
+void *pmem_memset_nodrain(void *pmemdest, int c, size_t len);
+void pmem_drain(void);
 
 #endif /* CONFIG_LIBPMEM */
 
diff --git a/migration/ram.c b/migration/ram.c
index 8333d8e35e..cb93f9fafe 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -51,6 +51,7 @@
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
 #include "migration/block.h"
+#include "qemu/pmem.h"
 
 /***********************************************************/
 /* ram save/restore */
@@ -2477,11 +2478,16 @@ static inline void *host_from_ram_block_offset(RAMBlock *block,
  * @host: host address for the zero page
  * @ch: what the page is filled from.  We only support zero
  * @size: size of the zero page
+ * @is_pmem: whether @host is in the persistent memory
  */
-void ram_handle_compressed(void *host, uint8_t ch, uint64_t size)
+void ram_handle_compressed(void *host, uint8_t ch, uint64_t size, bool is_pmem)
 {
     if (ch != 0 || !is_zero_range(host, size)) {
-        memset(host, ch, size);
+        if (!is_pmem) {
+            memset(host, ch, size);
+        } else {
+            pmem_memset_nodrain(host, ch, size);
+        }
     }
 }
 
@@ -2824,6 +2830,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
     bool postcopy_running = postcopy_is_running();
     /* ADVISE is earlier, it shows the source has the postcopy capability on */
     bool postcopy_advised = postcopy_is_advised();
+    bool need_pmem_drain = false;
 
     seq_iter++;
 
@@ -2849,6 +2856,8 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
         ram_addr_t addr, total_ram_bytes;
         void *host = NULL;
         uint8_t ch;
+        RAMBlock *block = NULL;
+        bool is_pmem = false;
 
         addr = qemu_get_be64(f);
         flags = addr & ~TARGET_PAGE_MASK;
@@ -2865,7 +2874,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
 
         if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
                      RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)) {
-            RAMBlock *block = ram_block_from_stream(f, flags);
+            block = ram_block_from_stream(f, flags);
 
             host = host_from_ram_block_offset(block, addr);
             if (!host) {
@@ -2875,6 +2884,9 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
             }
             ramblock_recv_bitmap_set(block, host);
             trace_ram_load_loop(block->idstr, (uint64_t)addr, flags, host);
+
+            is_pmem = ramblock_is_pmem(block);
+            need_pmem_drain = need_pmem_drain || is_pmem;
         }
 
         switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
@@ -2928,7 +2940,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
 
         case RAM_SAVE_FLAG_ZERO:
             ch = qemu_get_byte(f);
-            ram_handle_compressed(host, ch, TARGET_PAGE_SIZE);
+            ram_handle_compressed(host, ch, TARGET_PAGE_SIZE, is_pmem);
             break;
 
         case RAM_SAVE_FLAG_PAGE:
@@ -2971,6 +2983,11 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
     }
 
     wait_for_decompress_done();
+
+    if (need_pmem_drain) {
+        pmem_drain();
+    }
+
     rcu_read_unlock();
     trace_ram_load_complete(ret, seq_iter);
     return ret;
diff --git a/migration/ram.h b/migration/ram.h
index f3a227b4fc..18934ae9e4 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -57,7 +57,7 @@ int ram_postcopy_send_discard_bitmap(MigrationState *ms);
 int ram_discard_range(const char *block_name, uint64_t start, size_t length);
 int ram_postcopy_incoming_init(MigrationIncomingState *mis);
 
-void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
+void ram_handle_compressed(void *host, uint8_t ch, uint64_t size, bool is_pmem);
 
 int ramblock_recv_bitmap_test(RAMBlock *rb, void *host_addr);
 void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr);
diff --git a/migration/rdma.c b/migration/rdma.c
index da474fc19f..573bcd2cb0 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3229,7 +3229,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f, void *opaque)
             host_addr = block->local_host_addr +
                             (comp->offset - block->offset);
 
-            ram_handle_compressed(host_addr, comp->value, comp->length);
+            ram_handle_compressed(host_addr, comp->value, comp->length, false);
             break;
 
         case RDMA_CONTROL_REGISTER_FINISHED:
diff --git a/stubs/pmem.c b/stubs/pmem.c
index 03d990e571..a65b3bfc6b 100644
--- a/stubs/pmem.c
+++ b/stubs/pmem.c
@@ -17,3 +17,12 @@ void *pmem_memcpy_persist(void *pmemdest, const void *src, size_t len)
 {
     return memcpy(pmemdest, src, len);
 }
+
+void *pmem_memset_nodrain(void *pmemdest, int c, size_t len)
+{
+    return memset(pmemdest, c, len);
+}
+
+void pmem_drain(void)
+{
+}
-- 
2.16.1
