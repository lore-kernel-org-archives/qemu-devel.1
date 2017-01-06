Received: from eggs.gnu.org ([2001:4830:134:3::10]:46928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsA-0003rs-Q9
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWs9-0004tq-LS
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWs9-0004tW-D8
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:05 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 79C5461BB6
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:05 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:05 +0000
Message-Id: <20170106155543.12827-10-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 09/47] trace: switch hw/intc/ directory to
 modular trace.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Switch files in the hw/intc/ directory to include the
hw/intc/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs              | 2 +-
 hw/intc/Makefile.objs      | 2 ++
 hw/intc/apic.c             | 2 +-
 hw/intc/apic_common.c      | 2 +-
 hw/intc/arm_gic.c          | 2 +-
 hw/intc/arm_gicv3_cpuif.c  | 2 +-
 hw/intc/arm_gicv3_dist.c   | 2 +-
 hw/intc/arm_gicv3_redist.c | 2 +-
 hw/intc/aspeed_vic.c       | 2 +-
 hw/intc/grlib_irqmp.c      | 2 +-
 hw/intc/lm32_pic.c         | 2 +-
 hw/intc/s390_flic.c        | 2 +-
 hw/intc/s390_flic_kvm.c    | 2 +-
 hw/intc/slavio_intctl.c    | 2 +-
 hw/intc/xics.c             | 2 +-
 hw/intc/xics_kvm.c         | 2 +-
 hw/intc/xics_spapr.c       | 2 +-
 17 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 6cbee00..6d30b53 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -127,7 +127,7 @@ trace-events-subdirs += migration
 trace-events-subdirs += block
 trace-events-subdirs += hw/block
 trace-events-subdirs += hw/char
-trace-events-y += hw/intc/trace-events
+trace-events-subdirs += hw/intc
 trace-events-y += hw/net/trace-events
 trace-events-y += hw/virtio/trace-events
 trace-events-y += hw/audio/trace-events
diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index 2f44a2d..f718d66 100644
--- a/hw/intc/Makefile.objs
+++ b/hw/intc/Makefile.objs
@@ -19,6 +19,8 @@ common-obj-$(CONFIG_ARM_GIC) += arm_gicv3_redist.o
 common-obj-$(CONFIG_ARM_GIC) += arm_gicv3_its_common.o
 common-obj-$(CONFIG_OPENPIC) += openpic.o
 common-obj-y += intc.o
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
 
 obj-$(CONFIG_APIC) += apic.o apic_common.o
 obj-$(CONFIG_ARM_GIC_KVM) += arm_gic_kvm.o
diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index fe15fb6..1b2ed92 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -25,7 +25,7 @@
 #include "hw/i386/ioapic.h"
 #include "hw/pci/msi.h"
 #include "qemu/host-utils.h"
-#include "trace.h"
+#include "hw/intc/trace.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/apic-msidef.h"
 #include "qapi/error.h"
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index d78c885..000bc7c 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -25,7 +25,7 @@
 #include "qapi/visitor.h"
 #include "hw/i386/apic.h"
 #include "hw/i386/apic_internal.h"
-#include "trace.h"
+#include "hw/intc/trace.h"
 #include "sysemu/kvm.h"
 #include "hw/qdev.h"
 #include "hw/sysbus.h"
diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 521aac3..206f098 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -24,7 +24,7 @@
 #include "qapi/error.h"
 #include "qom/cpu.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include "hw/intc/trace.h"
 
 //#define DEBUG_GIC
 
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 35e8eb3..d82e4c9 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -13,7 +13,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "trace.h"
+#include "hw/intc/trace.h"
 #include "gicv3_internal.h"
 #include "cpu.h"
 
diff --git a/hw/intc/arm_gicv3_dist.c b/hw/intc/arm_gicv3_dist.c
index 3ea3dd0..dc405e9 100644
--- a/hw/intc/arm_gicv3_dist.c
+++ b/hw/intc/arm_gicv3_dist.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include "hw/intc/trace.h"
 #include "gicv3_internal.h"
 
 /* The GICD_NSACR registers contain a two bit field for each interrupt which
diff --git a/hw/intc/arm_gicv3_redist.c b/hw/intc/arm_gicv3_redist.c
index 77e5cfa..f1a6b08 100644
--- a/hw/intc/arm_gicv3_redist.c
+++ b/hw/intc/arm_gicv3_redist.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include "hw/intc/trace.h"
 #include "gicv3_internal.h"
 
 static uint32_t mask_group(GICv3CPUState *cs, MemTxAttrs attrs)
diff --git a/hw/intc/aspeed_vic.c b/hw/intc/aspeed_vic.c
index 2370e74..c152d78 100644
--- a/hw/intc/aspeed_vic.c
+++ b/hw/intc/aspeed_vic.c
@@ -31,7 +31,7 @@
 #include "hw/intc/aspeed_vic.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include "hw/intc/trace.h"
 
 #define AVIC_NEW_BASE_OFFSET 0x80
 
diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index ac7e63f..26c89af 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -30,7 +30,7 @@
 
 #include "hw/sparc/grlib.h"
 
-#include "trace.h"
+#include "hw/intc/trace.h"
 #include "qapi/error.h"
 
 #define IRQMP_MAX_CPU 16
diff --git a/hw/intc/lm32_pic.c b/hw/intc/lm32_pic.c
index 09e1511..68dfb76 100644
--- a/hw/intc/lm32_pic.c
+++ b/hw/intc/lm32_pic.c
@@ -23,7 +23,7 @@
 #include "hw/i386/pc.h"
 #include "monitor/monitor.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "hw/intc/trace.h"
 #include "hw/lm32/lm32_pic.h"
 #include "hw/intc/intc.h"
 
diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 6ab29ef..44d3ea4 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -15,7 +15,7 @@
 #include "hw/sysbus.h"
 #include "migration/qemu-file.h"
 #include "hw/s390x/s390_flic.h"
-#include "trace.h"
+#include "hw/intc/trace.h"
 
 S390FLICState *s390_get_flic(void)
 {
diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index 21ac2e2..3ac885a 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -20,7 +20,7 @@
 #include "migration/qemu-file.h"
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/adapter.h"
-#include "trace.h"
+#include "hw/intc/trace.h"
 
 #define FLIC_SAVE_INITIAL_SIZE getpagesize()
 #define FLIC_FAILED (-1UL)
diff --git a/hw/intc/slavio_intctl.c b/hw/intc/slavio_intctl.c
index 84e0bee..7ad8c80 100644
--- a/hw/intc/slavio_intctl.c
+++ b/hw/intc/slavio_intctl.c
@@ -27,7 +27,7 @@
 #include "monitor/monitor.h"
 #include "hw/sysbus.h"
 #include "hw/intc/intc.h"
-#include "trace.h"
+#include "hw/intc/trace.h"
 
 //#define DEBUG_IRQ_COUNT
 
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 095c16a..250b381 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -30,7 +30,7 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
-#include "trace.h"
+#include "hw/intc/trace.h"
 #include "qemu/timer.h"
 #include "hw/ppc/xics.h"
 #include "qemu/error-report.h"
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 17694ea..d3f0341 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -30,7 +30,7 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
-#include "trace.h"
+#include "hw/intc/trace.h"
 #include "sysemu/kvm.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/xics.h"
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 2e3f1c5..b953eee 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -28,7 +28,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "hw/hw.h"
-#include "trace.h"
+#include "hw/intc/trace.h"
 #include "qemu/timer.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/xics.h"
-- 
2.9.3
