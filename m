Received: from eggs.gnu.org ([2001:4830:134:3::10]:47476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fPh0W-0004QJ-8S
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 00:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fPh0U-00075S-FQ
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 00:22:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43274 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fPh0U-000755-9L
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 00:22:10 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Mon,  4 Jun 2018 06:21:53 +0200
Message-Id: <20180604042156.13812-3-quintela@redhat.com>
In-Reply-To: <20180604042156.13812-1-quintela@redhat.com>
References: <20180604042156.13812-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/5] migration: discard non-migratable RAMBlocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

On the POWER9 processor, the XIVE interrupt controller can control
interrupt sources using MMIO to trigger events, to EOI or to turn off
the sources. Priority management and interrupt acknowledgment is also
controlled by MMIO in the presenter sub-engine.

These MMIO regions are exposed to guests in QEMU with a set of 'ram
device' memory mappings, similarly to VFIO, and the VMAs are populated
dynamically with the appropriate pages using a fault handler.

But, these regions are an issue for migration. We need to discard the
associated RAMBlocks from the RAM state on the source VM and let the
destination VM rebuild the memory mappings on the new host in the
post_load() operation just before resuming the system.

To achieve this goal, the following introduces a new RAMBlock flag
RAM_MIGRATABLE which is updated in the vmstate_register_ram() and
vmstate_unregister_ram() routines. This flag is then used by the
migration to identify RAMBlocks to discard on the source. Some checks
are also performed on the destination to make sure nothing invalid was
sent.

This change impacts the boston, malta and jazz mips boards for which
migration compatibility is broken.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 exec.c                    | 38 ++++++++++++++++++++++++++++++++
 include/exec/cpu-common.h |  4 ++++
 migration/postcopy-ram.c  | 12 +++++-----
 migration/ram.c           | 46 +++++++++++++++++++++++++++++----------
 migration/savevm.c        |  2 ++
 5 files changed, 84 insertions(+), 18 deletions(-)

diff --git a/exec.c b/exec.c
index c30f905598..af90e914cf 100644
--- a/exec.c
+++ b/exec.c
@@ -104,6 +104,9 @@ static MemoryRegion io_mem_unassigned;
  * (Set during postcopy)
  */
 #define RAM_UF_ZEROPAGE (1 << 3)
+
+/* RAM can be migrated */
+#define RAM_MIGRATABLE (1 << 4)
 #endif
=20
 #ifdef TARGET_PAGE_BITS_VARY
@@ -1838,6 +1841,21 @@ void qemu_ram_set_uf_zeroable(RAMBlock *rb)
     rb->flags |=3D RAM_UF_ZEROPAGE;
 }
=20
+bool qemu_ram_is_migratable(RAMBlock *rb)
+{
+    return rb->flags & RAM_MIGRATABLE;
+}
+
+void qemu_ram_set_migratable(RAMBlock *rb)
+{
+    rb->flags |=3D RAM_MIGRATABLE;
+}
+
+void qemu_ram_unset_migratable(RAMBlock *rb)
+{
+    rb->flags &=3D ~RAM_MIGRATABLE;
+}
+
 /* Called with iothread lock held.  */
 void qemu_ram_set_idstr(RAMBlock *new_block, const char *name, DeviceSta=
te *dev)
 {
@@ -3893,6 +3911,26 @@ int qemu_ram_foreach_block(RAMBlockIterFunc func, =
void *opaque)
     return ret;
 }
=20
+int qemu_ram_foreach_migratable_block(RAMBlockIterFunc func, void *opaqu=
e)
+{
+    RAMBlock *block;
+    int ret =3D 0;
+
+    rcu_read_lock();
+    RAMBLOCK_FOREACH(block) {
+        if (!qemu_ram_is_migratable(block)) {
+            continue;
+        }
+        ret =3D func(block->idstr, block->host, block->offset,
+                   block->used_length, opaque);
+        if (ret) {
+            break;
+        }
+    }
+    rcu_read_unlock();
+    return ret;
+}
+
 /*
  * Unmap pages of memory from start to start+length such that
  * they a) read as 0, b) Trigger whatever fault mechanism
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 24d335f95d..0b58e262f3 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -75,6 +75,9 @@ const char *qemu_ram_get_idstr(RAMBlock *rb);
 bool qemu_ram_is_shared(RAMBlock *rb);
 bool qemu_ram_is_uf_zeroable(RAMBlock *rb);
 void qemu_ram_set_uf_zeroable(RAMBlock *rb);
+bool qemu_ram_is_migratable(RAMBlock *rb);
+void qemu_ram_set_migratable(RAMBlock *rb);
+void qemu_ram_unset_migratable(RAMBlock *rb);
=20
 size_t qemu_ram_pagesize(RAMBlock *block);
 size_t qemu_ram_pagesize_largest(void);
@@ -119,6 +122,7 @@ typedef int (RAMBlockIterFunc)(const char *block_name=
, void *host_addr,
     ram_addr_t offset, ram_addr_t length, void *opaque);
=20
 int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
+int qemu_ram_foreach_migratable_block(RAMBlockIterFunc func, void *opaqu=
e);
 int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)=
;
=20
 #endif
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 658b750a8e..48e51556a7 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -374,7 +374,7 @@ bool postcopy_ram_supported_by_host(MigrationIncoming=
State *mis)
     }
=20
     /* We don't support postcopy with shared RAM yet */
-    if (qemu_ram_foreach_block(test_ramblock_postcopiable, NULL)) {
+    if (qemu_ram_foreach_migratable_block(test_ramblock_postcopiable, NU=
LL)) {
         goto out;
     }
=20
@@ -502,7 +502,7 @@ static int cleanup_range(const char *block_name, void=
 *host_addr,
  */
 int postcopy_ram_incoming_init(MigrationIncomingState *mis, size_t ram_p=
ages)
 {
-    if (qemu_ram_foreach_block(init_range, NULL)) {
+    if (qemu_ram_foreach_migratable_block(init_range, NULL)) {
         return -1;
     }
=20
@@ -524,7 +524,7 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingSt=
ate *mis)
             return -1;
         }
=20
-        if (qemu_ram_foreach_block(cleanup_range, mis)) {
+        if (qemu_ram_foreach_migratable_block(cleanup_range, mis)) {
             return -1;
         }
         /* Let the fault thread quit */
@@ -593,7 +593,7 @@ static int nhp_range(const char *block_name, void *ho=
st_addr,
  */
 int postcopy_ram_prepare_discard(MigrationIncomingState *mis)
 {
-    if (qemu_ram_foreach_block(nhp_range, mis)) {
+    if (qemu_ram_foreach_migratable_block(nhp_range, mis)) {
         return -1;
     }
=20
@@ -604,7 +604,7 @@ int postcopy_ram_prepare_discard(MigrationIncomingSta=
te *mis)
=20
 /*
  * Mark the given area of RAM as requiring notification to unwritten are=
as
- * Used as a  callback on qemu_ram_foreach_block.
+ * Used as a  callback on qemu_ram_foreach_migratable_block.
  *   host_addr: Base of area to mark
  *   offset: Offset in the whole ram arena
  *   length: Length of the section
@@ -1099,7 +1099,7 @@ int postcopy_ram_enable_notify(MigrationIncomingSta=
te *mis)
     mis->have_fault_thread =3D true;
=20
     /* Mark so that we get notified of accesses to unwritten areas */
-    if (qemu_ram_foreach_block(ram_block_enable_notify, mis)) {
+    if (qemu_ram_foreach_migratable_block(ram_block_enable_notify, mis))=
 {
         return -1;
     }
=20
diff --git a/migration/ram.c b/migration/ram.c
index 090187ca04..290b281446 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -157,11 +157,16 @@ out:
     return ret;
 }
=20
+/* Should be holding either ram_list.mutex, or the RCU lock. */
+#define RAMBLOCK_FOREACH_MIGRATABLE(block)             \
+    RAMBLOCK_FOREACH(block)                            \
+        if (!qemu_ram_is_migratable(block)) {} else
+
 static void ramblock_recv_map_init(void)
 {
     RAMBlock *rb;
=20
-    RAMBLOCK_FOREACH(rb) {
+    RAMBLOCK_FOREACH_MIGRATABLE(rb) {
         assert(!rb->receivedmap);
         rb->receivedmap =3D bitmap_new(rb->max_length >> qemu_target_pag=
e_bits());
     }
@@ -1078,6 +1083,10 @@ unsigned long migration_bitmap_find_dirty(RAMState=
 *rs, RAMBlock *rb,
     unsigned long *bitmap =3D rb->bmap;
     unsigned long next;
=20
+    if (!qemu_ram_is_migratable(rb)) {
+        return size;
+    }
+
     if (rs->ram_bulk_stage && start > 0) {
         next =3D start + 1;
     } else {
@@ -1123,7 +1132,7 @@ uint64_t ram_pagesize_summary(void)
     RAMBlock *block;
     uint64_t summary =3D 0;
=20
-    RAMBLOCK_FOREACH(block) {
+    RAMBLOCK_FOREACH_MIGRATABLE(block) {
         summary |=3D block->page_size;
     }
=20
@@ -1147,7 +1156,7 @@ static void migration_bitmap_sync(RAMState *rs)
=20
     qemu_mutex_lock(&rs->bitmap_mutex);
     rcu_read_lock();
-    RAMBLOCK_FOREACH(block) {
+    RAMBLOCK_FOREACH_MIGRATABLE(block) {
         migration_bitmap_sync_range(rs, block, 0, block->used_length);
     }
     rcu_read_unlock();
@@ -1786,6 +1795,11 @@ static int ram_save_host_page(RAMState *rs, PageSe=
archStatus *pss,
     size_t pagesize_bits =3D
         qemu_ram_pagesize(pss->block) >> TARGET_PAGE_BITS;
=20
+    if (!qemu_ram_is_migratable(pss->block)) {
+        error_report("block %s should not be migrated !", pss->block->id=
str);
+        return 0;
+    }
+
     do {
         /* Check the pages is dirty and if it is send it */
         if (!migration_bitmap_clear_dirty(rs, pss->block, pss->page)) {
@@ -1884,7 +1898,7 @@ uint64_t ram_bytes_total(void)
     uint64_t total =3D 0;
=20
     rcu_read_lock();
-    RAMBLOCK_FOREACH(block) {
+    RAMBLOCK_FOREACH_MIGRATABLE(block) {
         total +=3D block->used_length;
     }
     rcu_read_unlock();
@@ -1939,7 +1953,7 @@ static void ram_save_cleanup(void *opaque)
      */
     memory_global_dirty_log_stop();
=20
-    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
+    RAMBLOCK_FOREACH_MIGRATABLE(block) {
         g_free(block->bmap);
         block->bmap =3D NULL;
         g_free(block->unsentmap);
@@ -2002,7 +2016,7 @@ void ram_postcopy_migrated_memory_release(Migration=
State *ms)
 {
     struct RAMBlock *block;
=20
-    RAMBLOCK_FOREACH(block) {
+    RAMBLOCK_FOREACH_MIGRATABLE(block) {
         unsigned long *bitmap =3D block->bmap;
         unsigned long range =3D block->used_length >> TARGET_PAGE_BITS;
         unsigned long run_start =3D find_next_zero_bit(bitmap, range, 0)=
;
@@ -2080,7 +2094,7 @@ static int postcopy_each_ram_send_discard(Migration=
State *ms)
     struct RAMBlock *block;
     int ret;
=20
-    RAMBLOCK_FOREACH(block) {
+    RAMBLOCK_FOREACH_MIGRATABLE(block) {
         PostcopyDiscardState *pds =3D
             postcopy_discard_send_init(ms, block->idstr);
=20
@@ -2288,7 +2302,7 @@ int ram_postcopy_send_discard_bitmap(MigrationState=
 *ms)
     rs->last_sent_block =3D NULL;
     rs->last_page =3D 0;
=20
-    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
+    RAMBLOCK_FOREACH_MIGRATABLE(block) {
         unsigned long pages =3D block->used_length >> TARGET_PAGE_BITS;
         unsigned long *bitmap =3D block->bmap;
         unsigned long *unsentmap =3D block->unsentmap;
@@ -2447,7 +2461,7 @@ static void ram_list_init_bitmaps(void)
=20
     /* Skip setting bitmap if there is no RAM */
     if (ram_bytes_total()) {
-        QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
+        RAMBLOCK_FOREACH_MIGRATABLE(block) {
             pages =3D block->max_length >> TARGET_PAGE_BITS;
             block->bmap =3D bitmap_new(pages);
             bitmap_set(block->bmap, 0, pages);
@@ -2563,7 +2577,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque=
)
=20
     qemu_put_be64(f, ram_bytes_total() | RAM_SAVE_FLAG_MEM_SIZE);
=20
-    RAMBLOCK_FOREACH(block) {
+    RAMBLOCK_FOREACH_MIGRATABLE(block) {
         qemu_put_byte(f, strlen(block->idstr));
         qemu_put_buffer(f, (uint8_t *)block->idstr, strlen(block->idstr)=
);
         qemu_put_be64(f, block->used_length);
@@ -2807,6 +2821,11 @@ static inline RAMBlock *ram_block_from_stream(QEMU=
File *f, int flags)
         return NULL;
     }
=20
+    if (!qemu_ram_is_migratable(block)) {
+        error_report("block %s should not be migrated !", id);
+        return NULL;
+    }
+
     return block;
 }
=20
@@ -3049,7 +3068,7 @@ static int ram_load_cleanup(void *opaque)
     xbzrle_load_cleanup();
     compress_threads_load_cleanup();
=20
-    RAMBLOCK_FOREACH(rb) {
+    RAMBLOCK_FOREACH_MIGRATABLE(rb) {
         g_free(rb->receivedmap);
         rb->receivedmap =3D NULL;
     }
@@ -3311,7 +3330,10 @@ static int ram_load(QEMUFile *f, void *opaque, int=
 version_id)
                 length =3D qemu_get_be64(f);
=20
                 block =3D qemu_ram_block_by_name(id);
-                if (block) {
+                if (block && !qemu_ram_is_migratable(block)) {
+                    error_report("block %s should not be migrated !", id=
);
+                    ret =3D -EINVAL;
+                } else if (block) {
                     if (length !=3D block->used_length) {
                         Error *local_err =3D NULL;
=20
diff --git a/migration/savevm.c b/migration/savevm.c
index 4251125831..a68a9ac635 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2688,11 +2688,13 @@ void vmstate_register_ram(MemoryRegion *mr, Devic=
eState *dev)
 {
     qemu_ram_set_idstr(mr->ram_block,
                        memory_region_name(mr), dev);
+    qemu_ram_set_migratable(mr->ram_block);
 }
=20
 void vmstate_unregister_ram(MemoryRegion *mr, DeviceState *dev)
 {
     qemu_ram_unset_idstr(mr->ram_block);
+    qemu_ram_unset_migratable(mr->ram_block);
 }
=20
 void vmstate_register_ram_global(MemoryRegion *mr)
--=20
2.17.0
