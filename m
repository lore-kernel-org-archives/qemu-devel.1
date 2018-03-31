Received: from eggs.gnu.org ([2001:4830:134:3::10]:46027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiangshanlai@gmail.com>) id 1f2C8R-0007Kl-59
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 04:45:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiangshanlai@gmail.com>) id 1f2C8N-0003KV-6E
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 04:45:15 -0400
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d]:34032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jiangshanlai@gmail.com>)
	id 1f2C8M-0003JX-SR
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 04:45:11 -0400
Received: by mail-pf0-x22d.google.com with SMTP id q9so6815813pff.1
	for <qemu-devel@nongnu.org>; Sat, 31 Mar 2018 01:45:10 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Sat, 31 Mar 2018 16:45:00 +0800
Message-Id: <20180331084500.33313-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] migration: add capability to bypass the shared
 memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, "James O . D . Hunt" <james.o.hunt@intel.com>, Xu Wang <gnawux@gmail.com>, Peng Tao <bergwolf@gmail.com>, Xiao Guangrong <xiaoguangrong@tencent.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

1) What's this

When the migration capability 'bypass-shared-memory'
is set, the shared memory will be bypassed when migration.

It is the key feature to enable several excellent features for
the qemu, such as qemu-local-migration, qemu-live-update,
extremely-fast-save-restore, vm-template, vm-fast-live-clone,
yet-another-post-copy-migration, etc..

The philosophy behind this key feature, including the resulting
advanced key features, is that a part of the memory management
is separated out from the qemu, and let the other toolkits
such as libvirt, kata-containers (https://github.com/kata-containers)
runv(https://github.com/hyperhq/runv/) or some multiple cooperative
qemu commands directly access to it, manage it, provide features on it.

2) Status in real world

The hyperhq(http://hyper.sh  http://hypercontainer.io/)
introduced the feature vm-template(vm-fast-live-clone)
to the hyper container for several years, it works perfect.
(see https://github.com/hyperhq/runv/pull/297).

The feature vm-template makes the containers(VMs) can
be started in 130ms and save 80M memory for every
container(VM). So that the hyper containers are fast
and high-density as normal containers.

kata-containers project (https://github.com/kata-containers)
which was launched by hyper, intel and friends and which descended
from runv (and clear-container) should have this feature enabled.
Unfortunately, due to the code confliction between runv&cc,
this feature was temporary disabled and it is being brought
back by hyper and intel team.

3) How to use and bring up advanced features.

In current qemu command line, shared memory has
to be configured via memory-object.

a) feature: qemu-local-migration, qemu-live-update
Set the mem-path on the tmpfs and set share=on for it when
start the vm. example:
-object \
memory-backend-file,id=mem,size=128M,mem-path=/dev/shm/memory,share=on \
-numa node,nodeid=0,cpus=0-7,memdev=mem

when you want to migrate the vm locally (after fixed a security bug
of the qemu-binary, or other reason), you can start a new qemu with
the same command line and -incoming, then you can migrate the
vm from the old qemu to the new qemu with the migration capability
'bypass-shared-memory' set. The migration will migrate the device-state
*ONLY*, the memory is the origin memory backed by tmpfs file.

b) feature: extremely-fast-save-restore
the same above, but the mem-path is on the persistent file system.

c)  feature: vm-template, vm-fast-live-clone
the template vm is started as 1), and paused when the guest reaches
the template point(example: the guest app is ready), then the template
vm is saved. (the qemu process of the template can be killed now, because
we need only the memory and the device state files (in tmpfs)).

Then we can launch one or multiple VMs base on the template vm states,
the new VMs are started without the “share=on”, all the new VMs share
the initial memory from the memory file, they save a lot of memory.
all the new VMs start from the template point, the guest app can go to
work quickly.

The new VM booted from template vm can’t become template again,
if you need this unusual chained-template feature, you can write
a cloneable-tmpfs kernel module for it.

The libvirt toolkit can’t manage vm-template currently, in the
hyperhq/runv, we use qemu wrapper script to do it. I hope someone add
“libvrit managed template” feature to libvirt.

d) feature: yet-another-post-copy-migration
It is a possible feature, no toolkit can do it well now.
Using nbd server/client on the memory file is reluctantly Ok but
inconvenient. A special feature for tmpfs might be needed to
fully complete this feature.
No one need yet another post copy migration method,
but it is possible when some crazy man need it.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Sebastien Boeuf <sebastien.boeuf@intel.com>
Cc: James O. D. Hunt <james.o.hunt@intel.com>
Cc: Xu Wang <gnawux@gmail.com>
Cc: Peng Tao <bergwolf@gmail.com>
Cc: Xiao Guangrong <xiaoguangrong@tencent.com>
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
---
 migration/migration.c | 13 +++++++++++++
 migration/migration.h |  1 +
 migration/ram.c       | 26 +++++++++++++++++---------
 qapi/migration.json   |  8 +++++++-
 4 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index d780601f0c..880d58889f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1476,6 +1476,19 @@ bool migrate_release_ram(void)
     return s->enabled_capabilities[MIGRATION_CAPABILITY_RELEASE_RAM];
 }
 
+bool migrate_bypass_shared_memory(void)
+{
+    MigrationState *s;
+
+    /* it is not workable with postcopy yet. */
+    if (migrate_postcopy_ram())
+        return false;
+
+    s = migrate_get_current();
+
+    return s->enabled_capabilities[MIGRATION_CAPABILITY_BYPASS_SHARED_MEMORY];
+}
+
 bool migrate_postcopy_ram(void)
 {
     MigrationState *s;
diff --git a/migration/migration.h b/migration/migration.h
index 663415fe48..54f0f541de 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -178,6 +178,7 @@ MigrationState *migrate_get_current(void);
 
 bool migrate_postcopy(void);
 
+bool migrate_bypass_shared_memory(void);
 bool migrate_release_ram(void);
 bool migrate_postcopy_ram(void);
 bool migrate_zero_blocks(void);
diff --git a/migration/ram.c b/migration/ram.c
index 021d583b9b..75990dd2ba 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -772,6 +772,10 @@ unsigned long migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
     unsigned long *bitmap = rb->bmap;
     unsigned long next;
 
+    /* when this ramblock is requested bypassing */
+    if (!bitmap)
+        return size;
+
     if (rs->ram_bulk_stage && start > 0) {
         next = start + 1;
     } else {
@@ -842,7 +846,9 @@ static void migration_bitmap_sync(RAMState *rs)
     qemu_mutex_lock(&rs->bitmap_mutex);
     rcu_read_lock();
     RAMBLOCK_FOREACH(block) {
-        migration_bitmap_sync_range(rs, block, 0, block->used_length);
+        if (!migrate_bypass_shared_memory() || !qemu_ram_is_shared(block)) {
+            migration_bitmap_sync_range(rs, block, 0, block->used_length);
+        }
     }
     rcu_read_unlock();
     qemu_mutex_unlock(&rs->bitmap_mutex);
@@ -2123,18 +2129,12 @@ static int ram_state_init(RAMState **rsp)
     qemu_mutex_init(&(*rsp)->src_page_req_mutex);
     QSIMPLEQ_INIT(&(*rsp)->src_page_requests);
 
-    /*
-     * Count the total number of pages used by ram blocks not including any
-     * gaps due to alignment or unplugs.
-     */
-    (*rsp)->migration_dirty_pages = ram_bytes_total() >> TARGET_PAGE_BITS;
-
     ram_state_reset(*rsp);
 
     return 0;
 }
 
-static void ram_list_init_bitmaps(void)
+static void ram_list_init_bitmaps(RAMState *rs)
 {
     RAMBlock *block;
     unsigned long pages;
@@ -2142,9 +2142,17 @@ static void ram_list_init_bitmaps(void)
     /* Skip setting bitmap if there is no RAM */
     if (ram_bytes_total()) {
         QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
+            if (migrate_bypass_shared_memory() && qemu_ram_is_shared(block)) {
+                continue;
+            }
             pages = block->max_length >> TARGET_PAGE_BITS;
             block->bmap = bitmap_new(pages);
             bitmap_set(block->bmap, 0, pages);
+            /*
+             * Count the total number of pages used by ram blocks not
+             * including any gaps due to alignment or unplugs.
+             */
+            rs->migration_dirty_pages += pages;
             if (migrate_postcopy_ram()) {
                 block->unsentmap = bitmap_new(pages);
                 bitmap_set(block->unsentmap, 0, pages);
@@ -2160,7 +2168,7 @@ static void ram_init_bitmaps(RAMState *rs)
     qemu_mutex_lock_ramlist();
     rcu_read_lock();
 
-    ram_list_init_bitmaps();
+    ram_list_init_bitmaps(rs);
     memory_global_dirty_log_start();
     migration_bitmap_sync(rs);
 
diff --git a/qapi/migration.json b/qapi/migration.json
index 03f57c9616..f18ee1bcc5 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -352,12 +352,17 @@
 #
 # @x-multifd: Use more than one fd for migration (since 2.11)
 #
+# @bypass-shared-memory: the shared memory region will be bypassed on migration.
+#          This feature allows the memory region to be reused by new qemu(s)
+#          or be migrated separately. (since 2.12)
+#
 # Since: 1.2
 ##
 { 'enum': 'MigrationCapability',
   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
            'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
-           'block', 'return-path', 'pause-before-switchover', 'x-multifd' ] }
+           'block', 'return-path', 'pause-before-switchover', 'x-multifd',
+           'bypass-shared-memory'] }
 
 ##
 # @MigrationCapabilityStatus:
@@ -412,6 +417,7 @@
 #       {"state": true, "capability": "events"},
 #       {"state": false, "capability": "postcopy-ram"},
 #       {"state": false, "capability": "x-colo"}
+#       {"state": false, "capability": "bypass-shared-memory"}
 #    ]}
 #
 ##
-- 
2.14.3 (Apple Git-98)
