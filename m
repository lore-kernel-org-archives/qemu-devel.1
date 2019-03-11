Received: from eggs.gnu.org ([209.51.188.92]:57513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h3HaW-0006Zj-FQ
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:51:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h3HaU-00008h-MG
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:51:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h3HaU-00004t-8z
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:51:14 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 11 Mar 2019 10:50:54 +0100
Message-Id: <1552297854-25847-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2] hw/char/parallel: Make it possible to
 compile also without CONFIG_PARALLEL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Miroslav Rezanina <mrezanin@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

For the downstream distribution of QEMU, we want to compile without
CONFIG_PARALLEL. Commit 9157eee1b1c076ff3 already moved the function
parallel_hds_isa_init() (which is still required for linking) into a file
that is included anyway, but commit bb3d5ea858e7f888563a moved it
to a separate file which is only compiled again if CONFIG_PARALLEL is
set. To be able to link QEMU again without CONFIG_PARALLEL, the file
should be considered for linking for all targets that have CONFIG_ISA_BUS.
And while we're at it, add a proper comment in there with the rationale
for the separate file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2:
 - Include parallel-isa.o only for CONFIG_ISA_BUS (since it depends on ISA)
 - Do not rename the file anymore
 - Removed the check via object_class_by_name() - otherwise user might get
   confused if the specify one parallel port which is then silently ignored

 hw/char/Makefile.objs  | 2 +-
 hw/char/parallel-isa.c | 3 +++
 hw/i386/Kconfig        | 3 +--
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
index c4947d7..cf086e7 100644
--- a/hw/char/Makefile.objs
+++ b/hw/char/Makefile.objs
@@ -2,7 +2,7 @@ common-obj-$(CONFIG_IPACK) += ipoctal232.o
 common-obj-$(CONFIG_ESCC) += escc.o
 common-obj-$(CONFIG_NRF51_SOC) += nrf51_uart.o
 common-obj-$(CONFIG_PARALLEL) += parallel.o
-common-obj-$(CONFIG_PARALLEL) += parallel-isa.o
+common-obj-$(CONFIG_ISA_BUS) += parallel-isa.o
 common-obj-$(CONFIG_PL011) += pl011.o
 common-obj-$(CONFIG_SERIAL) += serial.o
 common-obj-$(CONFIG_SERIAL_ISA) += serial-isa.o
diff --git a/hw/char/parallel-isa.c b/hw/char/parallel-isa.c
index 639e179..a043832 100644
--- a/hw/char/parallel-isa.c
+++ b/hw/char/parallel-isa.c
@@ -1,6 +1,9 @@
 /*
  * QEMU Parallel PORT (ISA bus helpers)
  *
+ * These functions reside in a separate file since they also might be
+ * required for linking when compiling QEMU without CONFIG_PARALLEL.
+ *
  * Copyright (c) 2003 Fabrice Bellard
  *
  * SPDX-License-Identifier: MIT
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 78fd703..4e4415f 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -9,6 +9,7 @@ config PC
     imply ISA_IPMI_KCS
     imply ISA_IPMI_BT
     imply ISA_DEBUG
+    imply PARALLEL
     imply PCI_DEVICES
     imply PVPANIC
     imply QXL
@@ -25,8 +26,6 @@ config PC
     select I82374
     select I8257
     select MC146818RTC
-    # Needed by the board code:
-    select PARALLEL
     # For ACPI builder:
     select SERIAL_ISA
     select ACPI_VMGENID
-- 
1.8.3.1
