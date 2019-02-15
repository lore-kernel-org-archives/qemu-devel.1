Received: from eggs.gnu.org ([209.51.188.92]:44110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1guhZ1-00064b-2n
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:46:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1guhYz-0002I4-AL
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:46:15 -0500
Received: from forwardcorp1j.cmail.yandex.net ([2a02:6b8:0:1630::190]:43569)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1guhYy-0002Fk-Ur
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:46:13 -0500
From: Yury Kotov <yury-kotov@yandex-team.ru>
Date: Fri, 15 Feb 2019 20:45:46 +0300
Message-Id: <20190215174548.2630-4-yury-kotov@yandex-team.ru>
In-Reply-To: <20190215174548.2630-1-yury-kotov@yandex-team.ru>
References: <20190215174548.2630-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 3/5] migration: Add an ability to ignore
 shared RAM blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: wrfsh@yandex-team.ru, jiangshanlai@gmail.com, qemu-devel@lists.ewheeler.net, peter.maydell@linaro.org

If ignore-shared capability is set then skip shared RAMBlocks during the
RAM migration.
Also, move qemu_ram_foreach_migratable_block (and rename) to the
migration code, because it requires access to the migration capabilities.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 exec.c                    |  19 -------
 include/exec/cpu-common.h |   1 -
 migration/migration.h     |   4 +-
 migration/postcopy-ram.c  |  12 ++---
 migration/ram.c           | 110 +++++++++++++++++++++++++++++---------
 migration/rdma.c          |   2 +-
 6 files changed, 94 insertions(+), 54 deletions(-)

diff --git a/exec.c b/exec.c
index bf71462929..1d4f3784d6 100644
--- a/exec.c
+++ b/exec.c
@@ -3985,25 +3985,6 @@ int qemu_ram_foreach_block(RAMBlockIterFunc func, =
void *opaque)
     return ret;
 }
=20
-int qemu_ram_foreach_migratable_block(RAMBlockIterFunc func, void *opaqu=
e)
-{
-    RAMBlock *block;
-    int ret =3D 0;
-
-    rcu_read_lock();
-    RAMBLOCK_FOREACH(block) {
-        if (!qemu_ram_is_migratable(block)) {
-            continue;
-        }
-        ret =3D func(block, opaque);
-        if (ret) {
-            break;
-        }
-    }
-    rcu_read_unlock();
-    return ret;
-}
-
 /*
  * Unmap pages of memory from start to start+length such that
  * they a) read as 0, b) Trigger whatever fault mechanism
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 9cd1f94bc5..cef8b88a2a 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -122,7 +122,6 @@ extern struct MemoryRegion io_mem_notdirty;
 typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
=20
 int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
-int qemu_ram_foreach_migratable_block(RAMBlockIterFunc func, void *opaqu=
e);
 int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)=
;
=20
 #endif
diff --git a/migration/migration.h b/migration/migration.h
index 4211995c53..2c88f8a555 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -302,8 +302,10 @@ void migrate_send_rp_resume_ack(MigrationIncomingSta=
te *mis, uint32_t value);
 void dirty_bitmap_mig_before_vm_start(void);
 void init_dirty_bitmap_incoming_migration(void);
=20
+int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
+
 #define qemu_ram_foreach_block \
-  #warning "Use qemu_ram_foreach_block_migratable in migration code"
+  #warning "Use foreach_not_ignored_block in migration code"
=20
 void migration_make_urgent_request(void);
 void migration_consume_urgent_request(void);
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index b098816221..e2aa57a701 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -374,7 +374,7 @@ bool postcopy_ram_supported_by_host(MigrationIncoming=
State *mis)
     }
=20
     /* We don't support postcopy with shared RAM yet */
-    if (qemu_ram_foreach_migratable_block(test_ramblock_postcopiable, NU=
LL)) {
+    if (foreach_not_ignored_block(test_ramblock_postcopiable, NULL)) {
         goto out;
     }
=20
@@ -508,7 +508,7 @@ static int cleanup_range(RAMBlock *rb, void *opaque)
  */
 int postcopy_ram_incoming_init(MigrationIncomingState *mis)
 {
-    if (qemu_ram_foreach_migratable_block(init_range, NULL)) {
+    if (foreach_not_ignored_block(init_range, NULL)) {
         return -1;
     }
=20
@@ -550,7 +550,7 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingSt=
ate *mis)
             return -1;
         }
=20
-        if (qemu_ram_foreach_migratable_block(cleanup_range, mis)) {
+        if (foreach_not_ignored_block(cleanup_range, mis)) {
             return -1;
         }
=20
@@ -617,7 +617,7 @@ static int nhp_range(RAMBlock *rb, void *opaque)
  */
 int postcopy_ram_prepare_discard(MigrationIncomingState *mis)
 {
-    if (qemu_ram_foreach_migratable_block(nhp_range, mis)) {
+    if (foreach_not_ignored_block(nhp_range, mis)) {
         return -1;
     }
=20
@@ -628,7 +628,7 @@ int postcopy_ram_prepare_discard(MigrationIncomingSta=
te *mis)
=20
 /*
  * Mark the given area of RAM as requiring notification to unwritten are=
as
- * Used as a  callback on qemu_ram_foreach_migratable_block.
+ * Used as a  callback on foreach_not_ignored_block.
  *   host_addr: Base of area to mark
  *   offset: Offset in the whole ram arena
  *   length: Length of the section
@@ -1122,7 +1122,7 @@ int postcopy_ram_enable_notify(MigrationIncomingSta=
te *mis)
     mis->have_fault_thread =3D true;
=20
     /* Mark so that we get notified of accesses to unwritten areas */
-    if (qemu_ram_foreach_migratable_block(ram_block_enable_notify, mis))=
 {
+    if (foreach_not_ignored_block(ram_block_enable_notify, mis)) {
         error_report("ram_block_enable_notify failed");
         return -1;
     }
diff --git a/migration/ram.c b/migration/ram.c
index 59191c1ed2..01315edd66 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -159,18 +159,44 @@ out:
     return ret;
 }
=20
+static bool ramblock_is_ignored(RAMBlock *block)
+{
+    return !qemu_ram_is_migratable(block) ||
+           (migrate_ignore_shared() && qemu_ram_is_shared(block));
+}
+
 /* Should be holding either ram_list.mutex, or the RCU lock. */
+#define RAMBLOCK_FOREACH_NOT_IGNORED(block)            \
+    INTERNAL_RAMBLOCK_FOREACH(block)                   \
+        if (ramblock_is_ignored(block)) {} else
+
 #define RAMBLOCK_FOREACH_MIGRATABLE(block)             \
     INTERNAL_RAMBLOCK_FOREACH(block)                   \
         if (!qemu_ram_is_migratable(block)) {} else
=20
 #undef RAMBLOCK_FOREACH
=20
+int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque)
+{
+    RAMBlock *block;
+    int ret =3D 0;
+
+    rcu_read_lock();
+    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
+        ret =3D func(block, opaque);
+        if (ret) {
+            break;
+        }
+    }
+    rcu_read_unlock();
+    return ret;
+}
+
 static void ramblock_recv_map_init(void)
 {
     RAMBlock *rb;
=20
-    RAMBLOCK_FOREACH_MIGRATABLE(rb) {
+    RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
         assert(!rb->receivedmap);
         rb->receivedmap =3D bitmap_new(rb->max_length >> qemu_target_pag=
e_bits());
     }
@@ -1545,7 +1571,7 @@ unsigned long migration_bitmap_find_dirty(RAMState =
*rs, RAMBlock *rb,
     unsigned long *bitmap =3D rb->bmap;
     unsigned long next;
=20
-    if (!qemu_ram_is_migratable(rb)) {
+    if (ramblock_is_ignored(rb)) {
         return size;
     }
=20
@@ -1594,7 +1620,7 @@ uint64_t ram_pagesize_summary(void)
     RAMBlock *block;
     uint64_t summary =3D 0;
=20
-    RAMBLOCK_FOREACH_MIGRATABLE(block) {
+    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
         summary |=3D block->page_size;
     }
=20
@@ -1664,7 +1690,7 @@ static void migration_bitmap_sync(RAMState *rs)
=20
     qemu_mutex_lock(&rs->bitmap_mutex);
     rcu_read_lock();
-    RAMBLOCK_FOREACH_MIGRATABLE(block) {
+    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
         migration_bitmap_sync_range(rs, block, 0, block->used_length);
     }
     ram_counters.remaining =3D ram_bytes_remaining();
@@ -2388,7 +2414,7 @@ static int ram_save_host_page(RAMState *rs, PageSea=
rchStatus *pss,
     size_t pagesize_bits =3D
         qemu_ram_pagesize(pss->block) >> TARGET_PAGE_BITS;
=20
-    if (!qemu_ram_is_migratable(pss->block)) {
+    if (ramblock_is_ignored(pss->block)) {
         error_report("block %s should not be migrated !", pss->block->id=
str);
         return 0;
     }
@@ -2486,19 +2512,30 @@ void acct_update_position(QEMUFile *f, size_t siz=
e, bool zero)
     }
 }
=20
-uint64_t ram_bytes_total(void)
+static uint64_t ram_bytes_total_common(bool count_ignored)
 {
     RAMBlock *block;
     uint64_t total =3D 0;
=20
     rcu_read_lock();
-    RAMBLOCK_FOREACH_MIGRATABLE(block) {
-        total +=3D block->used_length;
+    if (count_ignored) {
+        RAMBLOCK_FOREACH_MIGRATABLE(block) {
+            total +=3D block->used_length;
+        }
+    } else {
+        RAMBLOCK_FOREACH_NOT_IGNORED(block) {
+            total +=3D block->used_length;
+        }
     }
     rcu_read_unlock();
     return total;
 }
=20
+uint64_t ram_bytes_total(void)
+{
+    return ram_bytes_total_common(false);
+}
+
 static void xbzrle_load_setup(void)
 {
     XBZRLE.decoded_buf =3D g_malloc(TARGET_PAGE_SIZE);
@@ -2547,7 +2584,7 @@ static void ram_save_cleanup(void *opaque)
      */
     memory_global_dirty_log_stop();
=20
-    RAMBLOCK_FOREACH_MIGRATABLE(block) {
+    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
         g_free(block->bmap);
         block->bmap =3D NULL;
         g_free(block->unsentmap);
@@ -2610,7 +2647,7 @@ void ram_postcopy_migrated_memory_release(Migration=
State *ms)
 {
     struct RAMBlock *block;
=20
-    RAMBLOCK_FOREACH_MIGRATABLE(block) {
+    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
         unsigned long *bitmap =3D block->bmap;
         unsigned long range =3D block->used_length >> TARGET_PAGE_BITS;
         unsigned long run_start =3D find_next_zero_bit(bitmap, range, 0)=
;
@@ -2688,7 +2725,7 @@ static int postcopy_each_ram_send_discard(Migration=
State *ms)
     struct RAMBlock *block;
     int ret;
=20
-    RAMBLOCK_FOREACH_MIGRATABLE(block) {
+    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
         PostcopyDiscardState *pds =3D
             postcopy_discard_send_init(ms, block->idstr);
=20
@@ -2896,7 +2933,7 @@ int ram_postcopy_send_discard_bitmap(MigrationState=
 *ms)
     rs->last_sent_block =3D NULL;
     rs->last_page =3D 0;
=20
-    RAMBLOCK_FOREACH_MIGRATABLE(block) {
+    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
         unsigned long pages =3D block->used_length >> TARGET_PAGE_BITS;
         unsigned long *bitmap =3D block->bmap;
         unsigned long *unsentmap =3D block->unsentmap;
@@ -3062,7 +3099,7 @@ static void ram_list_init_bitmaps(void)
=20
     /* Skip setting bitmap if there is no RAM */
     if (ram_bytes_total()) {
-        RAMBLOCK_FOREACH_MIGRATABLE(block) {
+        RAMBLOCK_FOREACH_NOT_IGNORED(block) {
             pages =3D block->max_length >> TARGET_PAGE_BITS;
             block->bmap =3D bitmap_new(pages);
             bitmap_set(block->bmap, 0, pages);
@@ -3117,7 +3154,7 @@ static void ram_state_resume_prepare(RAMState *rs, =
QEMUFile *out)
      * about dirty page logging as well.
      */
=20
-    RAMBLOCK_FOREACH_MIGRATABLE(block) {
+    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
         pages +=3D bitmap_count_one(block->bmap,
                                   block->used_length >> TARGET_PAGE_BITS=
);
     }
@@ -3176,7 +3213,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque=
)
=20
     rcu_read_lock();
=20
-    qemu_put_be64(f, ram_bytes_total() | RAM_SAVE_FLAG_MEM_SIZE);
+    qemu_put_be64(f, ram_bytes_total_common(true) | RAM_SAVE_FLAG_MEM_SI=
ZE);
=20
     RAMBLOCK_FOREACH_MIGRATABLE(block) {
         qemu_put_byte(f, strlen(block->idstr));
@@ -3185,6 +3222,10 @@ static int ram_save_setup(QEMUFile *f, void *opaqu=
e)
         if (migrate_postcopy_ram() && block->page_size !=3D qemu_host_pa=
ge_size) {
             qemu_put_be64(f, block->page_size);
         }
+        if (migrate_ignore_shared()) {
+            qemu_put_be64(f, block->mr->addr);
+            qemu_put_byte(f, ramblock_is_ignored(block) ? 1 : 0);
+        }
     }
=20
     rcu_read_unlock();
@@ -3443,7 +3484,7 @@ static inline RAMBlock *ram_block_from_stream(QEMUF=
ile *f, int flags)
         return NULL;
     }
=20
-    if (!qemu_ram_is_migratable(block)) {
+    if (ramblock_is_ignored(block)) {
         error_report("block %s should not be migrated !", id);
         return NULL;
     }
@@ -3698,7 +3739,7 @@ int colo_init_ram_cache(void)
     RAMBlock *block;
=20
     rcu_read_lock();
-    RAMBLOCK_FOREACH_MIGRATABLE(block) {
+    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
         block->colo_cache =3D qemu_anon_ram_alloc(block->used_length,
                                                 NULL,
                                                 false);
@@ -3719,7 +3760,7 @@ int colo_init_ram_cache(void)
     if (ram_bytes_total()) {
         RAMBlock *block;
=20
-        RAMBLOCK_FOREACH_MIGRATABLE(block) {
+        RAMBLOCK_FOREACH_NOT_IGNORED(block) {
             unsigned long pages =3D block->max_length >> TARGET_PAGE_BIT=
S;
=20
             block->bmap =3D bitmap_new(pages);
@@ -3734,7 +3775,7 @@ int colo_init_ram_cache(void)
=20
 out_locked:
=20
-    RAMBLOCK_FOREACH_MIGRATABLE(block) {
+    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
         if (block->colo_cache) {
             qemu_anon_ram_free(block->colo_cache, block->used_length);
             block->colo_cache =3D NULL;
@@ -3751,14 +3792,14 @@ void colo_release_ram_cache(void)
     RAMBlock *block;
=20
     memory_global_dirty_log_stop();
-    RAMBLOCK_FOREACH_MIGRATABLE(block) {
+    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
         g_free(block->bmap);
         block->bmap =3D NULL;
     }
=20
     rcu_read_lock();
=20
-    RAMBLOCK_FOREACH_MIGRATABLE(block) {
+    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
         if (block->colo_cache) {
             qemu_anon_ram_free(block->colo_cache, block->used_length);
             block->colo_cache =3D NULL;
@@ -3794,7 +3835,7 @@ static int ram_load_cleanup(void *opaque)
 {
     RAMBlock *rb;
=20
-    RAMBLOCK_FOREACH_MIGRATABLE(rb) {
+    RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
         if (ramblock_is_pmem(rb)) {
             pmem_persist(rb->host, rb->used_length);
         }
@@ -3803,7 +3844,7 @@ static int ram_load_cleanup(void *opaque)
     xbzrle_load_cleanup();
     compress_threads_load_cleanup();
=20
-    RAMBLOCK_FOREACH_MIGRATABLE(rb) {
+    RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
         g_free(rb->receivedmap);
         rb->receivedmap =3D NULL;
     }
@@ -4003,7 +4044,7 @@ static void colo_flush_ram_cache(void)
=20
     memory_global_dirty_log_sync();
     rcu_read_lock();
-    RAMBLOCK_FOREACH_MIGRATABLE(block) {
+    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
         migration_bitmap_sync_range(ram_state, block, 0, block->used_len=
gth);
     }
     rcu_read_unlock();
@@ -4146,6 +4187,23 @@ static int ram_load(QEMUFile *f, void *opaque, int=
 version_id)
                             ret =3D -EINVAL;
                         }
                     }
+                    if (migrate_ignore_shared()) {
+                        hwaddr addr =3D qemu_get_be64(f);
+                        bool ignored =3D qemu_get_byte(f);
+                        if (ignored !=3D ramblock_is_ignored(block)) {
+                            error_report("RAM block %s should %s be migr=
ated",
+                                         id, ignored ? "" : "not");
+                            ret =3D -EINVAL;
+                        }
+                        if (ramblock_is_ignored(block) &&
+                            block->mr->addr !=3D addr) {
+                            error_report("Mismatched GPAs for block %s "
+                                         "%" PRId64 "!=3D %" PRId64,
+                                         id, (uint64_t)addr,
+                                         (uint64_t)block->mr->addr);
+                            ret =3D -EINVAL;
+                        }
+                    }
                     ram_control_load_hook(f, RAM_CONTROL_BLOCK_REG,
                                           block->idstr);
                 } else {
@@ -4216,7 +4274,7 @@ static int ram_load(QEMUFile *f, void *opaque, int =
version_id)
 static bool ram_has_postcopy(void *opaque)
 {
     RAMBlock *rb;
-    RAMBLOCK_FOREACH_MIGRATABLE(rb) {
+    RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
         if (ramblock_is_pmem(rb)) {
             info_report("Block: %s, host: %p is a nvdimm memory, postcop=
y"
                          "is not supported now!", rb->idstr, rb->host);
@@ -4236,7 +4294,7 @@ static int ram_dirty_bitmap_sync_all(MigrationState=
 *s, RAMState *rs)
=20
     trace_ram_dirty_bitmap_sync_start();
=20
-    RAMBLOCK_FOREACH_MIGRATABLE(block) {
+    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
         qemu_savevm_send_recv_bitmap(file, block->idstr);
         trace_ram_dirty_bitmap_request(block->idstr);
         ramblock_count++;
diff --git a/migration/rdma.c b/migration/rdma.c
index 7eb38ee764..3cb579cc99 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -644,7 +644,7 @@ static int qemu_rdma_init_ram_blocks(RDMAContext *rdm=
a)
=20
     assert(rdma->blockmap =3D=3D NULL);
     memset(local, 0, sizeof *local);
-    qemu_ram_foreach_migratable_block(qemu_rdma_init_one_block, rdma);
+    foreach_not_ignored_block(qemu_rdma_init_one_block, rdma);
     trace_qemu_rdma_init_ram_blocks(local->nb_blocks);
     rdma->dest_blocks =3D g_new0(RDMADestBlock,
                                rdma->local_ram_blocks.nb_blocks);
--=20
2.20.1
