Received: from eggs.gnu.org ([2001:4830:134:3::10]:34784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eg07Y-0004SW-2n
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 22:28:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eg07W-0001cF-3M
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 22:28:36 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 29 Jan 2018 14:28:16 +1100
Message-Id: <20180129032826.16876-3-david@gibson.dropbear.id.au>
In-Reply-To: <20180129032826.16876-1-david@gibson.dropbear.id.au>
References: <20180129032826.16876-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 02/12] ppc: Deprecate qemu-system-ppcemb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, surajjs@au1.ibm.com, groug@kaod.org, "thuth@redhat.com" <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: "thuth@redhat.com" <thuth@redhat.com>

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
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc405_boards.c | 14 ++++++++++++++
 hw/ppc/ppc440_bamboo.c |  9 +++++++++
 hw/ppc/virtex_ml507.c  |  8 ++++++++
 qemu-doc.texi          |  6 ++++++
 4 files changed, 37 insertions(+)

diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index e92db2c66a..6f7f2ee168 100644
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
index 693c215108..a299206fd4 100644
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
index 5ac4f76613..9fe7655074 100644
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
index 79d08b3f04..19a82bfea3 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2773,6 +2773,12 @@ The ``host_net_remove'' command is replaced by the ``netdev_del'' command.
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
2.14.3
