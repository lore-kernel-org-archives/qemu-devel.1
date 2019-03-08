Received: from eggs.gnu.org ([209.51.188.92]:36605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2FLO-00058E-JM
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:15:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2FLK-0007yF-Er
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:15:21 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  8 Mar 2019 14:14:39 +0100
Message-Id: <20190308131445.17502-7-armbru@redhat.com>
In-Reply-To: <20190308131445.17502-1-armbru@redhat.com>
References: <20190308131445.17502-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 06/12] vl: Factor configure_blockdev() out
 of main()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, pkrempa@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, marcandre.lureau@redhat.com, philmd@redhat.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 vl.c | 74 ++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 42 insertions(+), 32 deletions(-)

diff --git a/vl.c b/vl.c
index 3045ab0df3..573de5ec4a 100644
--- a/vl.c
+++ b/vl.c
@@ -1201,6 +1201,47 @@ typedef struct BlockdevOptionsQueueEntry {
=20
 typedef QSIMPLEQ_HEAD(, BlockdevOptionsQueueEntry) BlockdevOptionsQueue;
=20
+static void configure_blockdev(BlockdevOptionsQueue *bdo_queue,
+                               MachineClass *machine_class, int snapshot=
)
+{
+    /*
+     * If the currently selected machine wishes to override the
+     * units-per-bus property of its default HBA interface type, do so
+     * now.
+     */
+    if (machine_class->units_per_default_bus) {
+        override_max_devs(machine_class->block_default_type,
+                          machine_class->units_per_default_bus);
+    }
+
+    /* open the virtual block devices */
+    while (!QSIMPLEQ_EMPTY(bdo_queue)) {
+        BlockdevOptionsQueueEntry *bdo =3D QSIMPLEQ_FIRST(bdo_queue);
+
+        QSIMPLEQ_REMOVE_HEAD(bdo_queue, entry);
+        loc_push_restore(&bdo->loc);
+        qmp_blockdev_add(bdo->bdo, &error_fatal);
+        loc_pop(&bdo->loc);
+        qapi_free_BlockdevOptions(bdo->bdo);
+        g_free(bdo);
+    }
+    if (snapshot || replay_mode !=3D REPLAY_MODE_NONE) {
+        qemu_opts_foreach(qemu_find_opts("drive"), drive_enable_snapshot=
,
+                          NULL, NULL);
+    }
+    if (qemu_opts_foreach(qemu_find_opts("drive"), drive_init_func,
+                          &machine_class->block_default_type, &error_fat=
al)) {
+        /* We printed help */
+        exit(0);
+    }
+
+    default_drive(default_cdrom, snapshot, machine_class->block_default_=
type, 2,
+                  CDROM_OPTS);
+    default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
+    default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
+
+}
+
 static QemuOptsList qemu_smp_opts =3D {
     .name =3D "smp-opts",
     .implied_opt_name =3D "cpus",
@@ -4361,38 +4402,7 @@ int main(int argc, char **argv, char **envp)
     ram_mig_init();
     dirty_bitmap_mig_init();
=20
-    /* If the currently selected machine wishes to override the units-pe=
r-bus
-     * property of its default HBA interface type, do so now. */
-    if (machine_class->units_per_default_bus) {
-        override_max_devs(machine_class->block_default_type,
-                          machine_class->units_per_default_bus);
-    }
-
-    /* open the virtual block devices */
-    while (!QSIMPLEQ_EMPTY(&bdo_queue)) {
-        BlockdevOptionsQueueEntry *bdo =3D QSIMPLEQ_FIRST(&bdo_queue);
-
-        QSIMPLEQ_REMOVE_HEAD(&bdo_queue, entry);
-        loc_push_restore(&bdo->loc);
-        qmp_blockdev_add(bdo->bdo, &error_fatal);
-        loc_pop(&bdo->loc);
-        qapi_free_BlockdevOptions(bdo->bdo);
-        g_free(bdo);
-    }
-    if (snapshot || replay_mode !=3D REPLAY_MODE_NONE) {
-        qemu_opts_foreach(qemu_find_opts("drive"), drive_enable_snapshot=
,
-                          NULL, NULL);
-    }
-    if (qemu_opts_foreach(qemu_find_opts("drive"), drive_init_func,
-                          &machine_class->block_default_type, &error_fat=
al)) {
-        /* We printed help */
-        exit(0);
-    }
-
-    default_drive(default_cdrom, snapshot, machine_class->block_default_=
type, 2,
-                  CDROM_OPTS);
-    default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
-    default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
+    configure_blockdev(&bdo_queue, machine_class, snapshot);
=20
     qemu_opts_foreach(qemu_find_opts("mon"),
                       mon_init_func, NULL, &error_fatal);
--=20
2.17.2
