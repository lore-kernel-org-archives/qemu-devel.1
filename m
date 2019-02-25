Received: from eggs.gnu.org ([209.51.188.92]:59017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gyL8r-00075n-Oh
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 13:38:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gyL8o-0005Z9-Si
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 13:38:17 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 25 Feb 2019 19:37:56 +0100
Message-Id: <20190225183757.27378-6-armbru@redhat.com>
In-Reply-To: <20190225183757.27378-1-armbru@redhat.com>
References: <20190225183757.27378-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 5/6] vl: Create block backends before
 setting machine properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, pkrempa@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com

qemu-system-FOO's main() acts on command line arguments in its own
idiosyncratic order.  There's not much method to its madness.
Whenever we find a case where one kind of command line argument needs
to refer to something created for another kind later, we rejigger the
order.

Block devices get created long after machine properties get processed.
Therefore, block device machine properties can be created, but not
set.  No such properties exist.  But the next commit will create some.
Time to rejigger again: create block devices earlier.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 vl.c | 66 ++++++++++++++++++++++++++++++------------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/vl.c b/vl.c
index 6ce3d2d448..5cb0810ffa 100644
--- a/vl.c
+++ b/vl.c
@@ -4232,6 +4232,39 @@ int main(int argc, char **argv, char **envp)
         exit(0);
     }
 
+    /* If the currently selected machine wishes to override the units-per-bus
+     * property of its default HBA interface type, do so now. */
+    if (machine_class->units_per_default_bus) {
+        override_max_devs(machine_class->block_default_type,
+                          machine_class->units_per_default_bus);
+    }
+
+    /* open the virtual block devices */
+    while (!QSIMPLEQ_EMPTY(&bdo_queue)) {
+        BlockdevOptions_queue *bdo = QSIMPLEQ_FIRST(&bdo_queue);
+
+        QSIMPLEQ_REMOVE_HEAD(&bdo_queue, entry);
+        loc_push_restore(&bdo->loc);
+        qmp_blockdev_add(bdo->bdo, &error_fatal);
+        loc_pop(&bdo->loc);
+        qapi_free_BlockdevOptions(bdo->bdo);
+        g_free(bdo);
+    }
+    if (snapshot || replay_mode != REPLAY_MODE_NONE) {
+        qemu_opts_foreach(qemu_find_opts("drive"), drive_enable_snapshot,
+                          NULL, NULL);
+    }
+    if (qemu_opts_foreach(qemu_find_opts("drive"), drive_init_func,
+                          &machine_class->block_default_type, &error_fatal)) {
+        /* We printed help */
+        exit(0);
+    }
+
+    default_drive(default_cdrom, snapshot, machine_class->block_default_type, 2,
+                  CDROM_OPTS);
+    default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
+    default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
+
     machine_opts = qemu_get_machine_opts();
     qemu_opt_foreach(machine_opts, machine_set_property, current_machine,
                      &error_fatal);
@@ -4355,39 +4388,6 @@ int main(int argc, char **argv, char **envp)
     ram_mig_init();
     dirty_bitmap_mig_init();
 
-    /* If the currently selected machine wishes to override the units-per-bus
-     * property of its default HBA interface type, do so now. */
-    if (machine_class->units_per_default_bus) {
-        override_max_devs(machine_class->block_default_type,
-                          machine_class->units_per_default_bus);
-    }
-
-    /* open the virtual block devices */
-    while (!QSIMPLEQ_EMPTY(&bdo_queue)) {
-        BlockdevOptions_queue *bdo = QSIMPLEQ_FIRST(&bdo_queue);
-
-        QSIMPLEQ_REMOVE_HEAD(&bdo_queue, entry);
-        loc_push_restore(&bdo->loc);
-        qmp_blockdev_add(bdo->bdo, &error_fatal);
-        loc_pop(&bdo->loc);
-        qapi_free_BlockdevOptions(bdo->bdo);
-        g_free(bdo);
-    }
-    if (snapshot || replay_mode != REPLAY_MODE_NONE) {
-        qemu_opts_foreach(qemu_find_opts("drive"), drive_enable_snapshot,
-                          NULL, NULL);
-    }
-    if (qemu_opts_foreach(qemu_find_opts("drive"), drive_init_func,
-                          &machine_class->block_default_type, &error_fatal)) {
-        /* We printed help */
-        exit(0);
-    }
-
-    default_drive(default_cdrom, snapshot, machine_class->block_default_type, 2,
-                  CDROM_OPTS);
-    default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
-    default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
-
     qemu_opts_foreach(qemu_find_opts("mon"),
                       mon_init_func, NULL, &error_fatal);
 
-- 
2.17.2
