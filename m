Received: from eggs.gnu.org ([2001:4830:134:3::10]:53727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJRZ-0002yX-NP
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:51:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJRX-00022J-Gl
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:51:53 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:33398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJRX-00021p-9O
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:51:51 -0400
Received: by mail-oi0-x242.google.com with SMTP id f193so13214170oib.0
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 06:51:51 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 16:51:50 +0300
Message-ID: <CA+KKJYC5XSQRAGXd7_ahr-6tydukz-pcqoKioQr7Lk2moqSumQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 16/43] intc: made printf always compile in
 debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, i.mitsyanko@gmail.com, agraf@suse.de, mst@redhat.com, pbonzini@redhat.com, gxt@mprc.pku.edu.cn

>From 3985e3226a996f019649b6b7a4d6e3e64f81ea8d Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:30:06 +0300
Subject: [PATCH 16/43] intc: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 hw/intc/arm_gicv3_kvm.c       | 16 +++++++++-------
 hw/intc/exynos4210_combiner.c | 18 +++++++++---------
 hw/intc/heathrow_pic.c        | 17 ++++++++++-------
 hw/intc/i8259.c               | 16 +++++++++-------
 hw/intc/ioapic.c              | 16 +++++++++-------
 hw/intc/puv3_intc.c           |  4 ++--
 6 files changed, 48 insertions(+), 39 deletions(-)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 81f0403..32e75c0 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -30,13 +30,15 @@
 #include "vgic_common.h"
 #include "migration/migration.h"

-#ifdef DEBUG_GICV3_KVM
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, "kvm_gicv3: " fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
+#ifndef DEBUG_GICV3_KVM
+#define DEBUG_GICV3_KVM 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                               \
+    if (DEBUG_GICV3_KVM) {                                   \
+        fprintf(stderr, "kvm_gicv3: " fmt , ## __VA_ARGS__); \
+    }                                                        \
+} while (0);

 #define TYPE_KVM_ARM_GICV3 "kvm-arm-gicv3"
 #define KVM_ARM_GICV3(obj) \
diff --git a/hw/intc/exynos4210_combiner.c b/hw/intc/exynos4210_combiner.c
index f19a706..512fda6 100644
--- a/hw/intc/exynos4210_combiner.c
+++ b/hw/intc/exynos4210_combiner.c
@@ -32,15 +32,15 @@

 #include "hw/arm/exynos4210.h"

-//#define DEBUG_COMBINER
-
-#ifdef DEBUG_COMBINER
-#define DPRINTF(fmt, ...) \
-        do { fprintf(stdout, "COMBINER: [%s:%d] " fmt, __func__ ,
__LINE__, \
-                ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
-#endif
+#ifndef DEBUG_COMBINER
+#define DEBUG_COMBINER 0
+#endif
+
+#define DPRINTF(fmt, ...) do
{                                                          \
+    if (DEBUG_COMBINER)
{                                                               \
+        fprintf(stdout, "COMBINER: [%s:%d] " fmt, __func__ , __LINE__, ##
__VA_ARGS__); \
+
}
\
+} while (0);

 #define    IIC_NGRP        64            /* Internal Interrupt Combiner
                                             Groups number */
diff --git a/hw/intc/heathrow_pic.c b/hw/intc/heathrow_pic.c
index 171f5ed..b9593f7 100644
--- a/hw/intc/heathrow_pic.c
+++ b/hw/intc/heathrow_pic.c
@@ -29,12 +29,15 @@
 /* debug PIC */
 //#define DEBUG_PIC

-#ifdef DEBUG_PIC
-#define PIC_DPRINTF(fmt, ...)                                   \
-    do { printf("PIC: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define PIC_DPRINTF(fmt, ...)
-#endif
+#ifndef DEBUG_PIC
+#define DEBUG_PIC 0
+#endif
+
+#define PIC_DPRINTF(fmt, ...) do {                    \
+    if (DEBUG_PIC) {                          \
+        fprintf(stderr, "PIC: " fmt , ## __VA_ARGS__); \
+    }                                             \
+} while (0);

 typedef struct HeathrowPIC {
     uint32_t events;
@@ -72,7 +75,7 @@ static void pic_write(void *opaque, hwaddr addr,
     unsigned int n;

     n = ((addr & 0xfff) - 0x10) >> 4;
-    PIC_DPRINTF("writel: " TARGET_FMT_plx " %u: %08x\n", addr, n, value);
+    PIC_DPRINTF("writel: " TARGET_FMT_plx " %u: %08x\n", addr, n, (int)
value);
     if (n >= 2)
         return;
     pic = &s->pics[n];
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index fe9ecd6..43a20ce 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -32,14 +32,16 @@
 #include "hw/intc/intc.h"

 /* debug PIC */
-//#define DEBUG_PIC

-#ifdef DEBUG_PIC
-#define DPRINTF(fmt, ...)                                       \
-    do { printf("pic: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...)
-#endif
+#ifndef DEBUG_PIC
+#define DEBUG_PIC 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                         \
+    if (DEBUG_PIC) {                                   \
+        fprintf(stderr, "pic: " fmt , ## __VA_ARGS__); \
+    }                                                  \
+} while (0);

 //#define DEBUG_IRQ_LATENCY
 //#define DEBUG_IRQ_COUNT
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 37c4386..684401a 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -35,14 +35,16 @@
 #include "hw/i386/x86-iommu.h"
 #include "trace.h"

-//#define DEBUG_IOAPIC

-#ifdef DEBUG_IOAPIC
-#define DPRINTF(fmt, ...)                                       \
-    do { printf("ioapic: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...)
-#endif
+#ifndef DEBUG_IOAPIC
+#define DEBUG_IOAPIC 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                            \
+    if (DEBUG_IOAPIC) {                                   \
+        fprintf(stderr, "ioapic: " fmt , ## __VA_ARGS__); \
+    }                                                     \
+} while (0);

 #define APIC_DELIVERY_MODE_SHIFT 8
 #define APIC_POLARITY_SHIFT 14
diff --git a/hw/intc/puv3_intc.c b/hw/intc/puv3_intc.c
index ef8488a..80934f2 100644
--- a/hw/intc/puv3_intc.c
+++ b/hw/intc/puv3_intc.c
@@ -67,7 +67,7 @@ static uint64_t puv3_intc_read(void *opaque, hwaddr
offset,
     default:
         DPRINTF("Bad offset %x\n", (int)offset);
     }
-    DPRINTF("offset 0x%x, value 0x%x\n", offset, ret);
+    DPRINTF("offset 0x%lx, value 0x%x\n", offset, ret);
     return ret;
 }

@@ -76,7 +76,7 @@ static void puv3_intc_write(void *opaque, hwaddr offset,
 {
     PUV3INTCState *s = opaque;

-    DPRINTF("offset 0x%x, value 0x%x\n", offset, value);
+    DPRINTF("offset 0x%lx, value 0x%lx\n", offset, value);
     switch (offset) {
     case 0x00: /* INTC_ICLR */
     case 0x14: /* INTC_ICCR */
-- 
2.8.0.rc3
