Received: from eggs.gnu.org ([2001:4830:134:3::10]:39985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f6ZKJ-00044X-Lx
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 06:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f6ZKG-0004Ep-Fg
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 06:19:35 -0400
Received: from 6.mo3.mail-out.ovh.net ([188.165.43.173]:57318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f6ZKG-0004DB-5N
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 06:19:32 -0400
Received: from player773.ha.ovh.net (unknown [10.109.122.84])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id DB3601A55BA
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 12:19:29 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 12 Apr 2018 12:18:58 +0200
Message-Id: <20180412101858.21304-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] migration: discard RAMBlocks of type ram_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Yulei Zhang <yulei.zhang@intel.com>, kevin.tian@intel.com, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, kwankhede@nvidia.com, zhi.a.wang@intel.com, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

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

To achieve this goal, the following introduces a new helper,
ram_block_is_migratable(), which identifies RAMBlocks to discard on
the source. Some checks are also performed on the destination to make
sure nothing invalid was sent.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 I am not sure we want to taker into account patchew complaint :
=20
   ERROR: braces {} are necessary for all arms of this statement
   #52: FILE: migration/ram.c:203:
   +        if (ram_block_is_migratable(block))
   [...]

   total: 1 errors, 0 warnings, 136 lines checked

 migration/ram.c | 52 ++++++++++++++++++++++++++++++++++++++++++---------=
-
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 0e90efa09236..32371950865b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -188,6 +188,21 @@ void ramblock_recv_bitmap_set_range(RAMBlock *rb, vo=
id *host_addr,
 }
=20
 /*
+ * Identifies RAM blocks which should be discarded from migration. For
+ * the moment, it only applies to blocks backed by a 'ram_device'
+ * memory region.
+ */
+static inline bool ram_block_is_migratable(RAMBlock *block)
+{
+    return !memory_region_is_ram_device(block->mr);
+}
+
+/* Should be holding either ram_list.mutex, or the RCU lock. */
+#define RAMBLOCK_FOREACH_MIGRATABLE(block)             \
+    RAMBLOCK_FOREACH(block)                            \
+        if (ram_block_is_migratable(block))
+
+/*
  * An outstanding page request, on the source, having been received
  * and queued
  */
@@ -780,6 +795,10 @@ unsigned long migration_bitmap_find_dirty(RAMState *=
rs, RAMBlock *rb,
     unsigned long *bitmap =3D rb->bmap;
     unsigned long next;
=20
+    if (!ram_block_is_migratable(rb)) {
+        return size;
+    }
+
     if (rs->ram_bulk_stage && start > 0) {
         next =3D start + 1;
     } else {
@@ -825,7 +844,7 @@ uint64_t ram_pagesize_summary(void)
     RAMBlock *block;
     uint64_t summary =3D 0;
=20
-    RAMBLOCK_FOREACH(block) {
+    RAMBLOCK_FOREACH_MIGRATABLE(block) {
         summary |=3D block->page_size;
     }
=20
@@ -849,7 +868,7 @@ static void migration_bitmap_sync(RAMState *rs)
=20
     qemu_mutex_lock(&rs->bitmap_mutex);
     rcu_read_lock();
-    RAMBLOCK_FOREACH(block) {
+    RAMBLOCK_FOREACH_MIGRATABLE(block) {
         migration_bitmap_sync_range(rs, block, 0, block->used_length);
     }
     rcu_read_unlock();
@@ -1499,6 +1518,10 @@ static int ram_save_host_page(RAMState *rs, PageSe=
archStatus *pss,
     size_t pagesize_bits =3D
         qemu_ram_pagesize(pss->block) >> TARGET_PAGE_BITS;
=20
+    if (!ram_block_is_migratable(pss->block)) {
+        return 0;
+    }
+
     do {
         tmppages =3D ram_save_target_page(rs, pss, last_stage);
         if (tmppages < 0) {
@@ -1587,7 +1610,7 @@ uint64_t ram_bytes_total(void)
     uint64_t total =3D 0;
=20
     rcu_read_lock();
-    RAMBLOCK_FOREACH(block) {
+    RAMBLOCK_FOREACH_MIGRATABLE(block) {
         total +=3D block->used_length;
     }
     rcu_read_unlock();
@@ -1642,7 +1665,7 @@ static void ram_save_cleanup(void *opaque)
      */
     memory_global_dirty_log_stop();
=20
-    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
+    RAMBLOCK_FOREACH_MIGRATABLE(block) {
         g_free(block->bmap);
         block->bmap =3D NULL;
         g_free(block->unsentmap);
@@ -1705,7 +1728,7 @@ void ram_postcopy_migrated_memory_release(Migration=
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
@@ -1783,7 +1806,7 @@ static int postcopy_each_ram_send_discard(Migration=
State *ms)
     struct RAMBlock *block;
     int ret;
=20
-    RAMBLOCK_FOREACH(block) {
+    RAMBLOCK_FOREACH_MIGRATABLE(block) {
         PostcopyDiscardState *pds =3D
             postcopy_discard_send_init(ms, block->idstr);
=20
@@ -1991,7 +2014,7 @@ int ram_postcopy_send_discard_bitmap(MigrationState=
 *ms)
     rs->last_sent_block =3D NULL;
     rs->last_page =3D 0;
=20
-    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
+    RAMBLOCK_FOREACH_MIGRATABLE(block) {
         unsigned long pages =3D block->used_length >> TARGET_PAGE_BITS;
         unsigned long *bitmap =3D block->bmap;
         unsigned long *unsentmap =3D block->unsentmap;
@@ -2150,7 +2173,7 @@ static void ram_list_init_bitmaps(void)
=20
     /* Skip setting bitmap if there is no RAM */
     if (ram_bytes_total()) {
-        QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
+        RAMBLOCK_FOREACH_MIGRATABLE(block) {
             pages =3D block->max_length >> TARGET_PAGE_BITS;
             block->bmap =3D bitmap_new(pages);
             bitmap_set(block->bmap, 0, pages);
@@ -2226,7 +2249,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque=
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
@@ -2471,6 +2494,11 @@ static inline RAMBlock *ram_block_from_stream(QEMU=
File *f, int flags)
         return NULL;
     }
=20
+    if (!ram_block_is_migratable(block)) {
+        error_report("block %s should not be migrated !", id);
+        return NULL;
+    }
+
     return block;
 }
=20
@@ -2921,7 +2949,11 @@ static int ram_load(QEMUFile *f, void *opaque, int=
 version_id)
                 length =3D qemu_get_be64(f);
=20
                 block =3D qemu_ram_block_by_name(id);
-                if (block) {
+                if (block && !ram_block_is_migratable(block)) {
+                    error_report("block %s should not be migrated !", id=
);
+                    ret =3D -EINVAL;
+
+                } else if (block) {
                     if (length !=3D block->used_length) {
                         Error *local_err =3D NULL;
=20
--=20
2.13.6
