Received: from eggs.gnu.org ([209.51.188.92]:39234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glevQ-0008Da-Bs
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:08:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gleff-0002tn-Gb
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:47 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gleff-0002pQ-4D
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:43 -0500
Received: by mail-wm1-x342.google.com with SMTP id r24so6819069wmh.0
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:51:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 18:51:09 +0000
Message-Id: <20190121185118.18550-15-peter.maydell@linaro.org>
In-Reply-To: <20190121185118.18550-1-peter.maydell@linaro.org>
References: <20190121185118.18550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 14/23] iotkit-sysinfo: Make SYS_VERSION and
 SYS_CONFIG configurable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

The SYS_VERSION and SYS_CONFIG register values differ between the
IoTKit and SSE-200. Make them configurable via QOM properties rather
than hard-coded, and set them appropriately in the ARMSSE code that
instantiates the IOTKIT_SYSINFO device.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/iotkit-sysinfo.h |  6 ++++
 hw/arm/armsse.c                  | 51 ++++++++++++++++++++++++++++++++
 hw/misc/iotkit-sysinfo.c         | 15 ++++++++--
 3 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/include/hw/misc/iotkit-sysinfo.h b/include/hw/misc/iotkit-sysinfo.h
index 7b2e1a5e48b..d84eb203b90 100644
--- a/include/hw/misc/iotkit-sysinfo.h
+++ b/include/hw/misc/iotkit-sysinfo.h
@@ -14,6 +14,8 @@
  * Arm IoTKit and documented in
  * http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ecm0601256/index.html
  * QEMU interface:
+ *  + QOM property "SYS_VERSION": value to use for SYS_VERSION register
+ *  + QOM property "SYS_CONFIG": value to use for SYS_CONFIG register
  *  + sysbus MMIO region 0: the system information register bank
  */
 
@@ -32,6 +34,10 @@ typedef struct IoTKitSysInfo {
 
     /*< public >*/
     MemoryRegion iomem;
+
+    /* Properties */
+    uint32_t sys_version;
+    uint32_t sys_config;
 } IoTKitSysInfo;
 
 #endif
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 2eb4ea3bfe0..19cae77e770 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -18,10 +18,18 @@
 #include "hw/arm/armsse.h"
 #include "hw/arm/arm.h"
 
+/* Format of the System Information block SYS_CONFIG register */
+typedef enum SysConfigFormat {
+    IoTKitFormat,
+    SSE200Format,
+} SysConfigFormat;
+
 struct ARMSSEInfo {
     const char *name;
     int sram_banks;
     int num_cpus;
+    uint32_t sys_version;
+    SysConfigFormat sys_config_format;
 };
 
 static const ARMSSEInfo armsse_variants[] = {
@@ -29,9 +37,39 @@ static const ARMSSEInfo armsse_variants[] = {
         .name = TYPE_IOTKIT,
         .sram_banks = 1,
         .num_cpus = 1,
+        .sys_version = 0x41743,
+        .sys_config_format = IoTKitFormat,
     },
 };
 
+static uint32_t armsse_sys_config_value(ARMSSE *s, const ARMSSEInfo *info)
+{
+    /* Return the SYS_CONFIG value for this SSE */
+    uint32_t sys_config;
+
+    switch (info->sys_config_format) {
+    case IoTKitFormat:
+        sys_config = 0;
+        sys_config = deposit32(sys_config, 0, 4, info->sram_banks);
+        sys_config = deposit32(sys_config, 4, 4, s->sram_addr_width - 12);
+        break;
+    case SSE200Format:
+        sys_config = 0;
+        sys_config = deposit32(sys_config, 0, 4, info->sram_banks);
+        sys_config = deposit32(sys_config, 4, 5, s->sram_addr_width);
+        sys_config = deposit32(sys_config, 24, 4, 2);
+        if (info->num_cpus > 1) {
+            sys_config = deposit32(sys_config, 10, 1, 1);
+            sys_config = deposit32(sys_config, 20, 4, info->sram_banks - 1);
+            sys_config = deposit32(sys_config, 28, 4, 2);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return sys_config;
+}
+
 /* Clock frequency in HZ of the 32KHz "slow clock" */
 #define S32KCLK (32 * 1000)
 
@@ -726,6 +764,19 @@ static void armsse_realize(DeviceState *dev, Error **errp)
                           qdev_get_gpio_in_named(dev_apb_ppc1,
                                                  "cfg_sec_resp", 0));
 
+    object_property_set_int(OBJECT(&s->sysinfo), info->sys_version,
+                            "SYS_VERSION", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    object_property_set_int(OBJECT(&s->sysinfo),
+                            armsse_sys_config_value(s, info),
+                            "SYS_CONFIG", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(&s->sysinfo), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
diff --git a/hw/misc/iotkit-sysinfo.c b/hw/misc/iotkit-sysinfo.c
index 78955bc45f5..026ba942613 100644
--- a/hw/misc/iotkit-sysinfo.c
+++ b/hw/misc/iotkit-sysinfo.c
@@ -51,15 +51,16 @@ static const int sysinfo_id[] = {
 static uint64_t iotkit_sysinfo_read(void *opaque, hwaddr offset,
                                     unsigned size)
 {
+    IoTKitSysInfo *s = IOTKIT_SYSINFO(opaque);
     uint64_t r;
 
     switch (offset) {
     case A_SYS_VERSION:
-        r = 0x41743;
+        r = s->sys_version;
         break;
 
     case A_SYS_CONFIG:
-        r = 0x31;
+        r = s->sys_config;
         break;
     case A_PID4 ... A_CID3:
         r = sysinfo_id[(offset - A_PID4) / 4];
@@ -94,6 +95,12 @@ static const MemoryRegionOps iotkit_sysinfo_ops = {
     .valid.max_access_size = 4,
 };
 
+static Property iotkit_sysinfo_props[] = {
+    DEFINE_PROP_UINT32("SYS_VERSION", IoTKitSysInfo, sys_version, 0),
+    DEFINE_PROP_UINT32("SYS_CONFIG", IoTKitSysInfo, sys_config, 0),
+    DEFINE_PROP_END_OF_LIST()
+};
+
 static void iotkit_sysinfo_init(Object *obj)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
@@ -106,10 +113,14 @@ static void iotkit_sysinfo_init(Object *obj)
 
 static void iotkit_sysinfo_class_init(ObjectClass *klass, void *data)
 {
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
     /*
      * This device has no guest-modifiable state and so it
      * does not need a reset function or VMState.
      */
+
+    dc->props = iotkit_sysinfo_props;
 }
 
 static const TypeInfo iotkit_sysinfo_info = {
-- 
2.20.1
