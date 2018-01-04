Received: from eggs.gnu.org ([2001:4830:134:3::10]:36909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eWybR-0003jf-R2
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:02:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eWybO-0004BD-N4
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:02:09 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:42367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1eWybO-0004AX-EU
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:02:06 -0500
Received: by mail-pf0-x243.google.com with SMTP id d23so369671pfe.9
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 22:02:06 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu,  4 Jan 2018 14:01:06 +0800
Message-Id: <1515045675-6993-8-git-send-email-zhangckid@gmail.com>
In-Reply-To: <1515045675-6993-1-git-send-email-zhangckid@gmail.com>
References: <1515045675-6993-1-git-send-email-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH RESEND V3 07/16] COLO: Load dirty pages into
 SVM's RAM cache firstly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>

From: zhanghailiang <zhang.zhanghailiang@huawei.com>

We should not load PVM's state directly into SVM, because there maybe some
errors happen when SVM is receving data, which will break SVM.

We need to ensure receving all data before load the state into SVM. We use
an extra memory to cache these data (PVM's ram). The ram cache in secondary side
is initially the same as SVM/PVM's memory. And in the process of checkpoint,
we cache the dirty pages of PVM into this ram cache firstly, so this ram cache
always the same as PVM's memory at every checkpoint, then we flush this cached ram
to SVM after we receive all PVM's state.

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 include/exec/ram_addr.h |  1 +
 migration/migration.c   |  2 +
 migration/ram.c         | 97 +++++++++++++++++++++++++++++++++++++++++++++++--
 migration/ram.h         |  4 ++
 migration/savevm.c      |  2 +-
 5 files changed, 102 insertions(+), 4 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 6cbc02a..6b7b0dd 100644
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
index 8c16129..315b6d4 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -382,6 +382,8 @@ static void process_incoming_migration_co(void *opaque)
 
         /* Wait checkpoint incoming thread exit before free resource */
         qemu_thread_join(&mis->colo_incoming_thread);
+        /* We hold the global iothread lock, so it is safe here */
+        colo_release_ram_cache();
     }
 
     if (ret < 0) {
diff --git a/migration/ram.c b/migration/ram.c
index 021d583..0fc0aee 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2466,6 +2466,20 @@ static inline void *host_from_ram_block_offset(RAMBlock *block,
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
@@ -2619,6 +2633,55 @@ static void decompress_data_with_multi_threads(QEMUFile *f,
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
+        block->colo_cache = qemu_anon_ram_alloc(block->used_length, NULL);
+        if (!block->colo_cache) {
+            error_report("%s: Can't alloc memory for COLO cache of block %s,"
+                         "size 0x" RAM_ADDR_FMT, __func__, block->idstr,
+                         block->used_length);
+            goto out_locked;
+        }
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
@@ -2632,6 +2695,7 @@ static int ram_load_setup(QEMUFile *f, void *opaque)
     xbzrle_load_setup();
     compress_threads_load_setup();
     ramblock_recv_map_init();
+
     return 0;
 }
 
@@ -2645,6 +2709,7 @@ static int ram_load_cleanup(void *opaque)
         g_free(rb->receivedmap);
         rb->receivedmap = NULL;
     }
+
     return 0;
 }
 
@@ -2845,7 +2910,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
 
     while (!postcopy_running && !ret && !(flags & RAM_SAVE_FLAG_EOS)) {
         ram_addr_t addr, total_ram_bytes;
-        void *host = NULL;
+        void *host = NULL, *host_bak = NULL;
         uint8_t ch;
 
         addr = qemu_get_be64(f);
@@ -2865,13 +2930,36 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
                      RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)) {
             RAMBlock *block = ram_block_from_stream(f, flags);
 
-            host = host_from_ram_block_offset(block, addr);
+             /*
+             * After going into COLO, we should load the Page into colo_cache
+             * NOTE: We need to keep a copy of SVM's ram in colo_cache.
+             * Privously, we copied all these memory in preparing stage of COLO
+             * while we need to stop VM, which is a time-consuming process.
+             * Here we optimize it by a trick, back-up every page while in
+             * migration process while COLO is enabled, though it affects the
+             * speed of the migration, but it obviously reduce the downtime of
+             * back-up all SVM'S memory in COLO preparing stage.
+             */
+            if (migration_incoming_in_colo_state()) {
+                host = colo_cache_from_block_offset(block, addr);
+                /* After goes into COLO state, don't backup it any more */
+                if (!migration_incoming_in_colo_state()) {
+                    host_bak = host;
+                }
+            }
+            if (!migration_incoming_in_colo_state()) {
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
 
@@ -2966,6 +3054,9 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
         if (!ret) {
             ret = qemu_file_get_error(f);
         }
+        if (!ret && host_bak && host) {
+            memcpy(host_bak, host, TARGET_PAGE_SIZE);
+        }
     }
 
     wait_for_decompress_done();
diff --git a/migration/ram.h b/migration/ram.h
index 64d81e9..07abf71 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -62,4 +62,8 @@ int ramblock_recv_bitmap_test(RAMBlock *rb, void *host_addr);
 void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr);
 void ramblock_recv_bitmap_set_range(RAMBlock *rb, void *host_addr, size_t nr);
 
+/* ram cache */
+int colo_init_ram_cache(void);
+void colo_release_ram_cache(void);
+
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index cd753c4..c582716 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1762,7 +1762,7 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
 static int loadvm_process_enable_colo(MigrationIncomingState *mis)
 {
     migration_incoming_enable_colo();
-    return 0;
+    return colo_init_ram_cache();
 }
 
 /*
-- 
2.7.4
