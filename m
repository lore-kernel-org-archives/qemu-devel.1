Received: from eggs.gnu.org ([209.51.188.92]:36382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzJYp-0001H4-JN
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzJYn-0003eF-Hu
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:07 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:39918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzJYn-0003ab-4A
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:05 -0500
Received: by mail-wr1-x42f.google.com with SMTP id l5so21464720wrw.6
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 03:09:04 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	c17sm13153241wrs.17.2019.02.28.03.08.59 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 Feb 2019 03:09:02 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 11:08:25 +0000
Message-Id: <20190228110835.16159-7-peter.maydell@linaro.org>
In-Reply-To: <20190228110835.16159-1-peter.maydell@linaro.org>
References: <20190228110835.16159-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/16] hw/arm/iotkit-sysctl: Add SSE-200
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The SYSCTL block in the SSE-200 has some extra registers that
are not present in the IoTKit version. Add these registers
(as reads-as-written stubs), enabled by a new QOM property.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190219125808.25174-7-peter.maydell@linaro.org
---
 include/hw/misc/iotkit-sysctl.h |  20 +++
 hw/arm/armsse.c                 |   2 +
 hw/misc/iotkit-sysctl.c         | 245 +++++++++++++++++++++++++++++++-
 3 files changed, 262 insertions(+), 5 deletions(-)

diff --git a/include/hw/misc/iotkit-sysctl.h b/include/hw/misc/iotkit-sysctl.h
index 17a145517a4..9c2f23ecd28 100644
--- a/include/hw/misc/iotkit-sysctl.h
+++ b/include/hw/misc/iotkit-sysctl.h
@@ -17,6 +17,9 @@
  * "system control register" blocks.
  *
  * QEMU interface:
+ *  + QOM property "SYS_VERSION": value of the SYS_VERSION register of the
+ *    system information block of the SSE
+ *    (used to identify whether to provide SSE-200-only registers)
  *  + sysbus MMIO region 0: the system information register bank
  *  + sysbus MMIO region 1: the system control register bank
  */
@@ -44,6 +47,23 @@ typedef struct IoTKitSysCtl {
     uint32_t initsvtor0;
     uint32_t cpuwait;
     uint32_t wicctrl;
+    uint32_t scsecctrl;
+    uint32_t fclk_div;
+    uint32_t sysclk_div;
+    uint32_t clock_force;
+    uint32_t initsvtor1;
+    uint32_t nmi_enable;
+    uint32_t ewctrl;
+    uint32_t pdcm_pd_sys_sense;
+    uint32_t pdcm_pd_sram0_sense;
+    uint32_t pdcm_pd_sram1_sense;
+    uint32_t pdcm_pd_sram2_sense;
+    uint32_t pdcm_pd_sram3_sense;
+
+    /* Properties */
+    uint32_t sys_version;
+
+    bool is_sse200;
 } IoTKitSysCtl;
 
 #endif
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 97e3d5e807e..6eed2ecf809 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -997,6 +997,8 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     /* System information registers */
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysinfo), 0, 0x40020000);
     /* System control registers */
+    object_property_set_int(OBJECT(&s->sysctl), info->sys_version,
+                            "SYS_VERSION", &err);
     object_property_set_bool(OBJECT(&s->sysctl), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
diff --git a/hw/misc/iotkit-sysctl.c b/hw/misc/iotkit-sysctl.c
index 8c85aea9309..05606017fc2 100644
--- a/hw/misc/iotkit-sysctl.c
+++ b/hw/misc/iotkit-sysctl.c
@@ -17,6 +17,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "trace.h"
 #include "qapi/error.h"
@@ -28,15 +29,26 @@
 REG32(SECDBGSTAT, 0x0)
 REG32(SECDBGSET, 0x4)
 REG32(SECDBGCLR, 0x8)
+REG32(SCSECCTRL, 0xc)
+REG32(FCLK_DIV, 0x10)
+REG32(SYSCLK_DIV, 0x14)
+REG32(CLOCK_FORCE, 0x18)
 REG32(RESET_SYNDROME, 0x100)
 REG32(RESET_MASK, 0x104)
 REG32(SWRESET, 0x108)
     FIELD(SWRESET, SWRESETREQ, 9, 1)
 REG32(GRETREG, 0x10c)
 REG32(INITSVTOR0, 0x110)
+REG32(INITSVTOR1, 0x114)
 REG32(CPUWAIT, 0x118)
-REG32(BUSWAIT, 0x11c)
+REG32(NMI_ENABLE, 0x11c) /* BUSWAIT in IoTKit */
 REG32(WICCTRL, 0x120)
+REG32(EWCTRL, 0x124)
+REG32(PDCM_PD_SYS_SENSE, 0x200)
+REG32(PDCM_PD_SRAM0_SENSE, 0x20c)
+REG32(PDCM_PD_SRAM1_SENSE, 0x210)
+REG32(PDCM_PD_SRAM2_SENSE, 0x214)
+REG32(PDCM_PD_SRAM3_SENSE, 0x218)
 REG32(PID4, 0xfd0)
 REG32(PID5, 0xfd4)
 REG32(PID6, 0xfd8)
@@ -67,6 +79,30 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
     case A_SECDBGSTAT:
         r = s->secure_debug;
         break;
+    case A_SCSECCTRL:
+        if (!s->is_sse200) {
+            goto bad_offset;
+        }
+        r = s->scsecctrl;
+        break;
+    case A_FCLK_DIV:
+        if (!s->is_sse200) {
+            goto bad_offset;
+        }
+        r = s->fclk_div;
+        break;
+    case A_SYSCLK_DIV:
+        if (!s->is_sse200) {
+            goto bad_offset;
+        }
+        r = s->sysclk_div;
+        break;
+    case A_CLOCK_FORCE:
+        if (!s->is_sse200) {
+            goto bad_offset;
+        }
+        r = s->clock_force;
+        break;
     case A_RESET_SYNDROME:
         r = s->reset_syndrome;
         break;
@@ -79,16 +115,62 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
     case A_INITSVTOR0:
         r = s->initsvtor0;
         break;
+    case A_INITSVTOR1:
+        if (!s->is_sse200) {
+            goto bad_offset;
+        }
+        r = s->initsvtor1;
+        break;
     case A_CPUWAIT:
         r = s->cpuwait;
         break;
-    case A_BUSWAIT:
-        /* In IoTKit BUSWAIT is reserved, R/O, zero */
-        r = 0;
+    case A_NMI_ENABLE:
+        /* In IoTKit this is named BUSWAIT but is marked reserved, R/O, zero */
+        if (!s->is_sse200) {
+            r = 0;
+            break;
+        }
+        r = s->nmi_enable;
         break;
     case A_WICCTRL:
         r = s->wicctrl;
         break;
+    case A_EWCTRL:
+        if (!s->is_sse200) {
+            goto bad_offset;
+        }
+        r = s->ewctrl;
+        break;
+    case A_PDCM_PD_SYS_SENSE:
+        if (!s->is_sse200) {
+            goto bad_offset;
+        }
+        r = s->pdcm_pd_sys_sense;
+        break;
+    case A_PDCM_PD_SRAM0_SENSE:
+        if (!s->is_sse200) {
+            goto bad_offset;
+        }
+        r = s->pdcm_pd_sram0_sense;
+        break;
+    case A_PDCM_PD_SRAM1_SENSE:
+        if (!s->is_sse200) {
+            goto bad_offset;
+        }
+        r = s->pdcm_pd_sram1_sense;
+        break;
+    case A_PDCM_PD_SRAM2_SENSE:
+        if (!s->is_sse200) {
+            goto bad_offset;
+        }
+        r = s->pdcm_pd_sram2_sense;
+        break;
+    case A_PDCM_PD_SRAM3_SENSE:
+        if (!s->is_sse200) {
+            goto bad_offset;
+        }
+        r = s->pdcm_pd_sram3_sense;
+        break;
     case A_PID4 ... A_CID3:
         r = sysctl_id[(offset - A_PID4) / 4];
         break;
@@ -101,6 +183,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
         r = 0;
         break;
     default:
+    bad_offset:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "IoTKit SysCtl read: bad offset %x\n", (int)offset);
         r = 0;
@@ -172,14 +255,105 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         }
         break;
-    case A_BUSWAIT:        /* In IoTKit BUSWAIT is reserved, R/O, zero */
+    case A_SCSECCTRL:
+        if (!s->is_sse200) {
+            goto bad_offset;
+        }
+        qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl SCSECCTRL unimplemented\n");
+        s->scsecctrl = value;
+        break;
+    case A_FCLK_DIV:
+        if (!s->is_sse200) {
+            goto bad_offset;
+        }
+        qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl FCLK_DIV unimplemented\n");
+        s->fclk_div = value;
+        break;
+    case A_SYSCLK_DIV:
+        if (!s->is_sse200) {
+            goto bad_offset;
+        }
+        qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl SYSCLK_DIV unimplemented\n");
+        s->sysclk_div = value;
+        break;
+    case A_CLOCK_FORCE:
+        if (!s->is_sse200) {
+            goto bad_offset;
+        }
+        qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl CLOCK_FORCE unimplemented\n");
+        s->clock_force = value;
+        break;
+    case A_INITSVTOR1:
+        if (!s->is_sse200) {
+            goto bad_offset;
+        }
+        qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl INITSVTOR1 unimplemented\n");
+        s->initsvtor1 = value;
+        break;
+    case A_EWCTRL:
+        if (!s->is_sse200) {
+            goto bad_offset;
+        }
+        qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl EWCTRL unimplemented\n");
+        s->ewctrl = value;
+        break;
+    case A_PDCM_PD_SYS_SENSE:
+        if (!s->is_sse200) {
+            goto bad_offset;
+        }
+        qemu_log_mask(LOG_UNIMP,
+                      "IoTKit SysCtl PDCM_PD_SYS_SENSE unimplemented\n");
+        s->pdcm_pd_sys_sense = value;
+        break;
+    case A_PDCM_PD_SRAM0_SENSE:
+        if (!s->is_sse200) {
+            goto bad_offset;
+        }
+        qemu_log_mask(LOG_UNIMP,
+                      "IoTKit SysCtl PDCM_PD_SRAM0_SENSE unimplemented\n");
+        s->pdcm_pd_sram0_sense = value;
+        break;
+    case A_PDCM_PD_SRAM1_SENSE:
+        if (!s->is_sse200) {
+            goto bad_offset;
+        }
+        qemu_log_mask(LOG_UNIMP,
+                      "IoTKit SysCtl PDCM_PD_SRAM1_SENSE unimplemented\n");
+        s->pdcm_pd_sram1_sense = value;
+        break;
+    case A_PDCM_PD_SRAM2_SENSE:
+        if (!s->is_sse200) {
+            goto bad_offset;
+        }
+        qemu_log_mask(LOG_UNIMP,
+                      "IoTKit SysCtl PDCM_PD_SRAM2_SENSE unimplemented\n");
+        s->pdcm_pd_sram2_sense = value;
+        break;
+    case A_PDCM_PD_SRAM3_SENSE:
+        if (!s->is_sse200) {
+            goto bad_offset;
+        }
+        qemu_log_mask(LOG_UNIMP,
+                      "IoTKit SysCtl PDCM_PD_SRAM3_SENSE unimplemented\n");
+        s->pdcm_pd_sram3_sense = value;
+        break;
+    case A_NMI_ENABLE:
+        /* In IoTKit this is BUSWAIT: reserved, R/O, zero */
+        if (!s->is_sse200) {
+            goto ro_offset;
+        }
+        qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl NMI_ENABLE unimplemented\n");
+        s->nmi_enable = value;
+        break;
     case A_SECDBGSTAT:
     case A_PID4 ... A_CID3:
+    ro_offset:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "IoTKit SysCtl write: write of RO offset %x\n",
                       (int)offset);
         break;
     default:
+    bad_offset:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "IoTKit SysCtl write: bad offset %x\n", (int)offset);
         break;
@@ -207,8 +381,20 @@ static void iotkit_sysctl_reset(DeviceState *dev)
     s->reset_mask = 0;
     s->gretreg = 0;
     s->initsvtor0 = 0x10000000;
+    s->initsvtor1 = 0x10000000;
     s->cpuwait = 0;
     s->wicctrl = 0;
+    s->scsecctrl = 0;
+    s->fclk_div = 0;
+    s->sysclk_div = 0;
+    s->clock_force = 0;
+    s->nmi_enable = 0;
+    s->ewctrl = 0;
+    s->pdcm_pd_sys_sense = 0x7f;
+    s->pdcm_pd_sram0_sense = 0;
+    s->pdcm_pd_sram1_sense = 0;
+    s->pdcm_pd_sram2_sense = 0;
+    s->pdcm_pd_sram3_sense = 0;
 }
 
 static void iotkit_sysctl_init(Object *obj)
@@ -221,6 +407,44 @@ static void iotkit_sysctl_init(Object *obj)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
+static void iotkit_sysctl_realize(DeviceState *dev, Error **errp)
+{
+    IoTKitSysCtl *s = IOTKIT_SYSCTL(dev);
+
+    /* The top 4 bits of the SYS_VERSION register tell us if we're an SSE-200 */
+    if (extract32(s->sys_version, 28, 4) == 2) {
+        s->is_sse200 = true;
+    }
+}
+
+static bool sse200_needed(void *opaque)
+{
+    IoTKitSysCtl *s = IOTKIT_SYSCTL(opaque);
+
+    return s->is_sse200;
+}
+
+static const VMStateDescription iotkit_sysctl_sse200_vmstate = {
+    .name = "iotkit-sysctl/sse-200",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = sse200_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(scsecctrl, IoTKitSysCtl),
+        VMSTATE_UINT32(fclk_div, IoTKitSysCtl),
+        VMSTATE_UINT32(sysclk_div, IoTKitSysCtl),
+        VMSTATE_UINT32(clock_force, IoTKitSysCtl),
+        VMSTATE_UINT32(initsvtor1, IoTKitSysCtl),
+        VMSTATE_UINT32(nmi_enable, IoTKitSysCtl),
+        VMSTATE_UINT32(pdcm_pd_sys_sense, IoTKitSysCtl),
+        VMSTATE_UINT32(pdcm_pd_sram0_sense, IoTKitSysCtl),
+        VMSTATE_UINT32(pdcm_pd_sram1_sense, IoTKitSysCtl),
+        VMSTATE_UINT32(pdcm_pd_sram2_sense, IoTKitSysCtl),
+        VMSTATE_UINT32(pdcm_pd_sram3_sense, IoTKitSysCtl),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription iotkit_sysctl_vmstate = {
     .name = "iotkit-sysctl",
     .version_id = 1,
@@ -234,15 +458,26 @@ static const VMStateDescription iotkit_sysctl_vmstate = {
         VMSTATE_UINT32(cpuwait, IoTKitSysCtl),
         VMSTATE_UINT32(wicctrl, IoTKitSysCtl),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription*[]) {
+        &iotkit_sysctl_sse200_vmstate,
+        NULL
     }
 };
 
+static Property iotkit_sysctl_props[] = {
+    DEFINE_PROP_UINT32("SYS_VERSION", IoTKitSysCtl, sys_version, 0),
+    DEFINE_PROP_END_OF_LIST()
+};
+
 static void iotkit_sysctl_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &iotkit_sysctl_vmstate;
     dc->reset = iotkit_sysctl_reset;
+    dc->props = iotkit_sysctl_props;
+    dc->realize = iotkit_sysctl_realize;
 }
 
 static const TypeInfo iotkit_sysctl_info = {
-- 
2.20.1
