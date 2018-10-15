Received: from eggs.gnu.org ([2001:4830:134:3::10]:45639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gByXC-0004Vg-Au
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gByX8-0004Ii-O2
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gByX8-0003lW-6X
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:26 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Oct 2018 16:46:07 +0800
Message-Id: <1539593186-32183-8-git-send-email-jasowang@redhat.com>
In-Reply-To: <1539593186-32183-1-git-send-email-jasowang@redhat.com>
References: <1539593186-32183-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 07/26] COLO: Load dirty pages into SVM's RAM
 cache firstly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>

From: Zhang Chen <zhangckid@gmail.com>

We should not load PVM's state directly into SVM, because there maybe some
errors happen when SVM is receving data, which will break SVM.

We need to ensure receving all data before load the state into SVM. We use
an extra memory to cache these data (PVM's ram). The ram cache in secondary side
is initially the same as SVM/PVM's memory. And in the process of checkpoint,
we cache the dirty pages of PVM into this ram cache firstly, so this ram cache
always the same as PVM's memory at every checkpoint, then we flush this cached ram
to SVM after we receive all PVM's state.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/exec/ram_addr.h |  1 +
 migration/migration.c   |  7 +++++
 migration/ram.c         | 83 +++++++++++++++++++++++++++++++++++++++++++++++--
 migration/ram.h         |  4 +++
 migration/savevm.c      |  2 +-
 5 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 3abb639..9ecd911 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -27,6 +27,7 @@ struct RAMBlock {
     struct rcu_head rcu;
     struct MemoryRegion *mr;
     uint8_t *host;
+    uint8_t *colo_cache; /* For colo, VM's ram cache */
     ram_addr_t offset;
     ram_addr_t used_length;
     ram_addr_t max_length;
diff --git a/migration/migration.c b/migration/migration.c
index 215e81a..7696729 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -444,6 +444,11 @@ static void process_incoming_migration_co(void *opaque)
             exit(EXIT_FAILURE);
         }
 
+        if (colo_init_ram_cache() < 0) {
+            error_report("Init ram cache failed");
+            exit(EXIT_FAILURE);
+        }
+
         qemu_thread_create(&mis->colo_incoming_thread, "COLO incoming",
              colo_process_incoming_thread, mis, QEMU_THREAD_JOINABLE);
         mis->have_colo_incoming_thread = true;
@@ -451,6 +456,8 @@ static void process_incoming_migration_co(void *opaque)
 
         /* Wait checkpoint incoming thread exit before free resource */
         qemu_thread_join(&mis->colo_incoming_thread);
+        /* We hold the global iothread lock, so it is safe here */
+        colo_release_ram_cache();
     }
 
     if (ret < 0) {
diff --git a/migration/ram.c b/migration/ram.c
index bc38d98..cd7a446 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3447,6 +3447,20 @@ static inline void *host_from_ram_block_offset(RAMBlock *block,
     return block->host + offset;
 }
 
+static inline void *colo_cache_from_block_offset(RAMBlock *block,
+                                                 ram_addr_t offset)
+{
+    if (!offset_in_ramblock(block, offset)) {
+        return NULL;
+    }
+    if (!block->colo_cache) {
+        error_report("%s: colo_cache is NULL in block :%s",
+                     __func__, block->idstr);
+        return NULL;
+    }
+    return block->colo_cache + offset;
+}
+
 /**
  * ram_handle_compressed: handle the zero page case
  *
@@ -3651,6 +3665,58 @@ static void decompress_data_with_multi_threads(QEMUFile *f,
     qemu_mutex_unlock(&decomp_done_lock);
 }
 
+/*
+ * colo cache: this is for secondary VM, we cache the whole
+ * memory of the secondary VM, it is need to hold the global lock
+ * to call this helper.
+ */
+int colo_init_ram_cache(void)
+{
+    RAMBlock *block;
+
+    rcu_read_lock();
+    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
+        block->colo_cache = qemu_anon_ram_alloc(block->used_length,
+                                                NULL,
+                                                false);
+        if (!block->colo_cache) {
+            error_report("%s: Can't alloc memory for COLO cache of block %s,"
+                         "size 0x" RAM_ADDR_FMT, __func__, block->idstr,
+                         block->used_length);
+            goto out_locked;
+        }
+        memcpy(block->colo_cache, block->host, block->used_length);
+    }
+    rcu_read_unlock();
+    return 0;
+
+out_locked:
+    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
+        if (block->colo_cache) {
+            qemu_anon_ram_free(block->colo_cache, block->used_length);
+            block->colo_cache = NULL;
+        }
+    }
+
+    rcu_read_unlock();
+    return -errno;
+}
+
+/* It is need to hold the global lock to call this helper */
+void colo_release_ram_cache(void)
+{
+    RAMBlock *block;
+
+    rcu_read_lock();
+    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
+        if (block->colo_cache) {
+            qemu_anon_ram_free(block->colo_cache, block->used_length);
+            block->colo_cache = NULL;
+        }
+    }
+    rcu_read_unlock();
+}
+
 /**
  * ram_load_setup: Setup RAM for migration incoming side
  *
@@ -3667,6 +3733,7 @@ static int ram_load_setup(QEMUFile *f, void *opaque)
 
     xbzrle_load_setup();
     ramblock_recv_map_init();
+
     return 0;
 }
 
@@ -3687,6 +3754,7 @@ static int ram_load_cleanup(void *opaque)
         g_free(rb->receivedmap);
         rb->receivedmap = NULL;
     }
+
     return 0;
 }
 
@@ -3924,13 +3992,24 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
                      RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)) {
             RAMBlock *block = ram_block_from_stream(f, flags);
 
-            host = host_from_ram_block_offset(block, addr);
+            /*
+             * After going into COLO, we should load the Page into colo_cache.
+             */
+            if (migration_incoming_in_colo_state()) {
+                host = colo_cache_from_block_offset(block, addr);
+            } else {
+                host = host_from_ram_block_offset(block, addr);
+            }
             if (!host) {
                 error_report("Illegal RAM offset " RAM_ADDR_FMT, addr);
                 ret = -EINVAL;
                 break;
             }
-            ramblock_recv_bitmap_set(block, host);
+
+            if (!migration_incoming_in_colo_state()) {
+                ramblock_recv_bitmap_set(block, host);
+            }
+
             trace_ram_load_loop(block->idstr, (uint64_t)addr, flags, host);
         }
 
diff --git a/migration/ram.h b/migration/ram.h
index a139066..83ff1bc 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -71,4 +71,8 @@ int64_t ramblock_recv_bitmap_send(QEMUFile *file,
                                   const char *block_name);
 int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *rb);
 
+/* ram cache */
+int colo_init_ram_cache(void);
+void colo_release_ram_cache(void);
+
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index 09ad962..288b807 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1933,7 +1933,7 @@ static int loadvm_handle_recv_bitmap(MigrationIncomingState *mis,
 static int loadvm_process_enable_colo(MigrationIncomingState *mis)
 {
     migration_incoming_enable_colo();
-    return 0;
+    return colo_init_ram_cache();
 }
 
 /*
-- 
2.5.0
