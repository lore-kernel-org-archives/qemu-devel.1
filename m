Received: from eggs.gnu.org ([209.51.188.92]:54213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h2XDk-0007xA-Ku
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 03:20:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h2XDj-0006Qj-Mk
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 03:20:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h2XDj-0006My-Cl
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 03:20:39 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Sat,  9 Mar 2019 09:12:50 +0100
Message-Id: <1552119170-15474-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/char/parallel: Make it possible to compile
 also without CONFIG_PARALLEL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Miroslav Rezanina <mrezanin@redhat.com>

For the downstream distribution of QEMU, we want to compile without
CONFIG_PARALLEL. Commit 9157eee1b1c076ff3 already moved the function
parallel_hds_isa_init() (which is still required for linking) into a file
that is included anyway, but commit bb3d5ea858e7f888563a moved it
to a separate file which is only compiled again if CONFIG_PARALLEL is
set. To be able to link QEMU again without CONFIG_PARALLEL, let's
move this file unconditionally to common-obj-y again. And while we're
at it, also rename it to parallel-helper.c (since parallel.c is also
about ISA already), add a proper comment in there with the rationale
for the separate file, and a check via object_class_by_name() to see
whether the device class is available in the binary or not.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/char/Makefile.objs                         |  2 +-
 hw/char/{parallel-isa.c => parallel-helper.c} | 10 +++++++++-
 hw/char/parallel.c                            |  1 -
 hw/i386/Kconfig                               |  2 --
 include/hw/char/parallel.h                    |  2 ++
 5 files changed, 12 insertions(+), 5 deletions(-)
 rename hw/char/{parallel-isa.c => parallel-helper.c} (70%)

diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
index c4947d7..5476803 100644
--- a/hw/char/Makefile.objs
+++ b/hw/char/Makefile.objs
@@ -2,7 +2,7 @@ common-obj-$(CONFIG_IPACK) += ipoctal232.o
 common-obj-$(CONFIG_ESCC) += escc.o
 common-obj-$(CONFIG_NRF51_SOC) += nrf51_uart.o
 common-obj-$(CONFIG_PARALLEL) += parallel.o
-common-obj-$(CONFIG_PARALLEL) += parallel-isa.o
+common-obj-y += parallel-helper.o
 common-obj-$(CONFIG_PL011) += pl011.o
 common-obj-$(CONFIG_SERIAL) += serial.o
 common-obj-$(CONFIG_SERIAL_ISA) += serial-isa.o
diff --git a/hw/char/parallel-isa.c b/hw/char/parallel-helper.c
similarity index 70%
rename from hw/char/parallel-isa.c
rename to hw/char/parallel-helper.c
index 639e179..c3e868b 100644
--- a/hw/char/parallel-isa.c
+++ b/hw/char/parallel-helper.c
@@ -1,11 +1,15 @@
 /*
  * QEMU Parallel PORT (ISA bus helpers)
  *
+ * These functions reside in a separate file since they also might be
+ * required for linking when compiling QEMU without CONFIG_PARALLEL.
+ *
  * Copyright (c) 2003 Fabrice Bellard
  *
  * SPDX-License-Identifier: MIT
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
 #include "hw/isa/isa.h"
 #include "hw/char/parallel.h"
@@ -15,7 +19,7 @@ static void parallel_init(ISABus *bus, int index, Chardev *chr)
     DeviceState *dev;
     ISADevice *isadev;
 
-    isadev = isa_create(bus, "isa-parallel");
+    isadev = isa_create(bus, TYPE_ISA_PARALLEL);
     dev = DEVICE(isadev);
     qdev_prop_set_uint32(dev, "index", index);
     qdev_prop_set_chr(dev, "chardev", chr);
@@ -28,6 +32,10 @@ void parallel_hds_isa_init(ISABus *bus, int n)
 
     assert(n <= MAX_PARALLEL_PORTS);
 
+    if (!object_class_by_name(TYPE_ISA_PARALLEL)) {
+        return;
+    }
+
     for (i = 0; i < n; i++) {
         if (parallel_hds[i]) {
             parallel_init(bus, i, parallel_hds[i]);
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index a80da47..a19e7d9 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -85,7 +85,6 @@ typedef struct ParallelState {
     PortioList portio_list;
 } ParallelState;
 
-#define TYPE_ISA_PARALLEL "isa-parallel"
 #define ISA_PARALLEL(obj) \
     OBJECT_CHECK(ISAParallelState, (obj), TYPE_ISA_PARALLEL)
 
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 78fd703..4d8247a 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -25,8 +25,6 @@ config PC
     select I82374
     select I8257
     select MC146818RTC
-    # Needed by the board code:
-    select PARALLEL
     # For ACPI builder:
     select SERIAL_ISA
     select ACPI_VMGENID
diff --git a/include/hw/char/parallel.h b/include/hw/char/parallel.h
index d6dd62f..e0a7fe1 100644
--- a/include/hw/char/parallel.h
+++ b/include/hw/char/parallel.h
@@ -5,6 +5,8 @@
 #include "hw/isa/isa.h"
 #include "chardev/char.h"
 
+#define TYPE_ISA_PARALLEL "isa-parallel"
+
 void parallel_hds_isa_init(ISABus *bus, int n);
 
 bool parallel_mm_init(MemoryRegion *address_space,
-- 
1.8.3.1
