Received: from eggs.gnu.org ([2001:4830:134:3::10]:59924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qNm-00021N-Cp
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:27:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qNj-0000tR-87
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:27:06 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3404
	helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qNi-0000sJ-Bw
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:27:03 -0400
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Sat, 22 Apr 2017 16:25:47 +0800
Message-ID: <1492849558-17540-8-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1492849558-17540-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1492849558-17540-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 07/18] COLO: Load dirty pages into SVM's RAM
 cache firstly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, gilbert@redhat.com
Cc: quintela@redhat.com, lizhijian@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

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
---
v2:
- Move colo_init_ram_cache() and colo_release_ram_cache() out of
  incoming thread since both of them need the global lock, if we keep
  colo_release_ram_cache() in incoming thread, there are potential
  dead-lock.
- Remove bool ram_cache_enable flag, use migration_incoming_in_state() instead.
- Remove the Reviewd-by tag because of the above changes.
---
 include/exec/ram_addr.h       |  1 +
 include/migration/migration.h |  4 +++
 migration/migration.c         |  6 ++++
 migration/ram.c               | 71 ++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index c9ddcd0..0b3d77c 100644
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
diff --git a/include/migration/migration.h b/include/migration/migration.h
index ba1a16c..ba765eb 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -360,4 +360,8 @@ uint64_t ram_pagesize_summary(void);
 PostcopyState postcopy_state_get(void);
 /* Set the state and return the old state */
 PostcopyState postcopy_state_set(PostcopyState new_state);
+
+/* ram cache */
+int colo_init_ram_cache(void);
+void colo_release_ram_cache(void);
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 755ea54..7419404 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -441,6 +441,10 @@ static void process_incoming_migration_co(void *opaque)
             error_report_err(local_err);
             exit(EXIT_FAILURE);
         }
+        if (colo_init_ram_cache() < 0) {
+            error_report("Init ram cache failed");
+            exit(EXIT_FAILURE);
+        }
         mis->migration_incoming_co = qemu_coroutine_self();
         qemu_thread_create(&mis->colo_incoming_thread, "COLO incoming",
              colo_process_incoming_thread, mis, QEMU_THREAD_JOINABLE);
@@ -449,6 +453,8 @@ static void process_incoming_migration_co(void *opaque)
 
         /* Wait checkpoint incoming thread exit before free resource */
         qemu_thread_join(&mis->colo_incoming_thread);
+        /* We hold the global iothread lock, so it is safe here */
+        colo_release_ram_cache();
     }
 
     if (ret < 0) {
diff --git a/migration/ram.c b/migration/ram.c
index f48664e..05d1b06 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2265,6 +2265,20 @@ static inline void *host_from_ram_block_offset(RAMBlock *block,
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
@@ -2605,7 +2619,12 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
                      RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)) {
             RAMBlock *block = ram_block_from_stream(f, flags);
 
-            host = host_from_ram_block_offset(block, addr);
+            /* After going into COLO, we should load the Page into colo_cache */
+            if (migration_incoming_in_colo_state()) {
+                host = colo_cache_from_block_offset(block, addr);
+            } else {
+                host = host_from_ram_block_offset(block, addr);
+            }
             if (!host) {
                 error_report("Illegal RAM offset " RAM_ADDR_FMT, addr);
                 ret = -EINVAL;
@@ -2712,6 +2731,56 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
     return ret;
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
 static SaveVMHandlers savevm_ram_handlers = {
     .save_live_setup = ram_save_setup,
     .save_live_iterate = ram_save_iterate,
-- 
1.8.3.1
