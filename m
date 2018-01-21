Received: from eggs.gnu.org ([2001:4830:134:3::10]:43674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1edNcu-0008Kp-F0
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 16:58:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1edNco-00062a-K2
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 16:58:05 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Sun, 21 Jan 2018 22:57:58 +0100
Message-Id: <1516571878-13321-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3] ppc: Deprecate qemu-system-ppcemb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <dgibson@redhat.com>, qemu-ppc@nongnu.org

qemu-system-ppcemb has been once split of qemu-system-ppc to support
CPU page sizes < 4096 for some of the embedded 4xx PowerPC CPUs.
However, there was hardly any OS available in the wild that really
used such small page sizes (Linux uses 4096 on PPC), so there is
no known recent use case for this separate build anymore. It's
rather cumbersome to maintain a separate set of config switches for
this, and it's wasting compile and test time of all the developers
who have to build all QEMU targets to verify that their changes did
not break anything.

Except for the small CPU page sizes, qemu-system-ppc can be used as
a full replacement for qemu-system-ppcemb since it contains all the
embedded 4xx PPC boards and CPUs, too. Thus let's start the deprecation
process for qemu-system-ppcemb to see whether somebody still needs
the small page sizes or whether we could finally remove this unloved
separate build.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v3: Use qtest_enabled() and emit the deprecation message in the
     machine init functions (I unfortunately haven't found a better
     common spot for all 4xx machines where qtest_enabled() works).

 hw/ppc/ppc405_boards.c | 14 ++++++++++++++
 hw/ppc/ppc440_bamboo.c |  9 +++++++++
 hw/ppc/virtex_ml507.c  |  8 ++++++++
 qemu-doc.texi          |  6 ++++++
 4 files changed, 37 insertions(+)

diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index e92db2c..6f7f2ee 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -202,6 +202,13 @@ static void ref405ep_init(MachineState *machine)
     DriveInfo *dinfo;
     MemoryRegion *sysmem = get_system_memory();
 
+#ifdef TARGET_PPCEMB
+    if (!qtest_enabled()) {
+        warn_report("qemu-system-ppcemb is deprecated, "
+                    "please use qemu-system-ppc instead.");
+    }
+#endif
+
     /* XXX: fix this */
     memory_region_allocate_system_memory(&ram_memories[0], NULL, "ef405ep.ram",
                                          0x08000000);
@@ -497,6 +504,13 @@ static void taihu_405ep_init(MachineState *machine)
     int fl_idx, fl_sectors;
     DriveInfo *dinfo;
 
+#ifdef TARGET_PPCEMB
+    if (!qtest_enabled()) {
+        warn_report("qemu-system-ppcemb is deprecated, "
+                    "please use qemu-system-ppc instead.");
+    }
+#endif
+
     /* RAM is soldered to the board so the size cannot be changed */
     ram_size = 0x08000000;
     memory_region_allocate_system_memory(ram, NULL, "taihu_405ep.ram",
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 693c215..a299206 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu-common.h"
+#include "qemu/error-report.h"
 #include "net/net.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
@@ -27,6 +28,7 @@
 #include "hw/ppc/ppc.h"
 #include "ppc405.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/qtest.h"
 #include "hw/sysbus.h"
 
 #define BINARY_DEVICE_TREE_FILE "bamboo.dtb"
@@ -191,6 +193,13 @@ static void bamboo_init(MachineState *machine)
         exit(1);
     }
 
+#ifdef TARGET_PPCEMB
+    if (!qtest_enabled()) {
+        warn_report("qemu-system-ppcemb is deprecated, "
+                    "please use qemu-system-ppc instead.");
+    }
+#endif
+
     qemu_register_reset(main_cpu_reset, cpu);
     ppc_booke_timers_init(cpu, 400000000, 0);
     ppc_dcr_init(env, NULL, NULL);
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 5ac4f76..9fe7655 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -29,6 +29,7 @@
 #include "hw/char/serial.h"
 #include "hw/block/flash.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/qtest.h"
 #include "hw/devices.h"
 #include "hw/boards.h"
 #include "sysemu/device_tree.h"
@@ -210,6 +211,13 @@ static void virtex_init(MachineState *machine)
     int kernel_size;
     int i;
 
+#ifdef TARGET_PPCEMB
+    if (!qtest_enabled()) {
+        warn_report("qemu-system-ppcemb is deprecated, "
+                    "please use qemu-system-ppc instead.");
+    }
+#endif
+
     /* init CPUs */
     cpu = ppc440_init_xilinx(&ram_size, 1, machine->cpu_type, 400000000);
     env = &cpu->env;
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 3e9eb81..b13c633 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2766,6 +2766,12 @@ The ``host_net_remove'' command is replaced by the ``netdev_del'' command.
 The ``ivshmem'' device type is replaced by either the ``ivshmem-plain''
 or ``ivshmem-doorbell`` device types.
 
+@subsection Page size support < 4k for embedded PowerPC CPUs (since 2.12.0)
+
+qemu-system-ppcemb will be removed. qemu-system-ppc (or qemu-system-ppc64)
+should be used instead. That means that embedded 4xx PowerPC CPUs will not
+support page sizes < 4096 any longer.
+
 @section System emulator machines
 
 @subsection Xilinx EP108 (since 2.11.0)
-- 
1.8.3.1
