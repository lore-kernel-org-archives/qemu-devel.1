Received: from eggs.gnu.org ([2001:4830:134:3::10]:59198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQp-0000ux-1Y
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQm-0002CM-Up
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:18 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fqIQl-00021R-VZ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:16 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQk-0000CZ-CM
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:35:14 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 14:34:38 +0100
Message-Id: <20180816133438.17061-31-peter.maydell@linaro.org>
In-Reply-To: <20180816133438.17061-1-peter.maydell@linaro.org>
References: <20180816133438.17061-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 30/30] hw/arm/mps2-tz: Replace
 init_sysbus_child() with sysbus_init_child_obj()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Thomas Huth <thuth@redhat.com>

Now that we've got the common sysbus_init_child_obj() function, we do
not need the local init_sysbus_child() anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-id: 1534420566-15799-1-git-send-email-thuth@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/mps2-tz.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 22180c56fb7..dc0f34abe53 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -107,16 +107,6 @@ static void make_ram_alias(MemoryRegion *mr, const char *name,
     memory_region_add_subregion(get_system_memory(), base, mr);
 }
 
-static void init_sysbus_child(Object *parent, const char *childname,
-                              void *child, size_t childsize,
-                              const char *childtype)
-{
-    object_initialize(child, childsize, childtype);
-    object_property_add_child(parent, childname, OBJECT(child), &error_abort);
-    qdev_set_parent_bus(DEVICE(child), sysbus_get_default());
-
-}
-
 /* Most of the devices in the AN505 FPGA image sit behind
  * Peripheral Protection Controllers. These data structures
  * define the layout of which devices sit behind which PPCs.
@@ -149,9 +139,9 @@ static MemoryRegion *make_unimp_dev(MPS2TZMachineState *mms,
      */
     UnimplementedDeviceState *uds = opaque;
 
-    init_sysbus_child(OBJECT(mms), name, uds,
-                      sizeof(UnimplementedDeviceState),
-                      TYPE_UNIMPLEMENTED_DEVICE);
+    sysbus_init_child_obj(OBJECT(mms), name, uds,
+                          sizeof(UnimplementedDeviceState),
+                          TYPE_UNIMPLEMENTED_DEVICE);
     qdev_prop_set_string(DEVICE(uds), "name", name);
     qdev_prop_set_uint64(DEVICE(uds), "size", size);
     object_property_set_bool(OBJECT(uds), true, "realized", &error_fatal);
@@ -170,8 +160,8 @@ static MemoryRegion *make_uart(MPS2TZMachineState *mms, void *opaque,
     DeviceState *iotkitdev = DEVICE(&mms->iotkit);
     DeviceState *orgate_dev = DEVICE(&mms->uart_irq_orgate);
 
-    init_sysbus_child(OBJECT(mms), name, uart,
-                      sizeof(mms->uart[0]), TYPE_CMSDK_APB_UART);
+    sysbus_init_child_obj(OBJECT(mms), name, uart, sizeof(mms->uart[0]),
+                          TYPE_CMSDK_APB_UART);
     qdev_prop_set_chr(DEVICE(uart), "chardev", serial_hd(i));
     qdev_prop_set_uint32(DEVICE(uart), "pclk-frq", SYSCLK_FRQ);
     object_property_set_bool(OBJECT(uart), true, "realized", &error_fatal);
@@ -248,8 +238,8 @@ static MemoryRegion *make_mpc(MPS2TZMachineState *mms, void *opaque,
 
     memory_region_init_ram(ssram, NULL, name, ramsize[i], &error_fatal);
 
-    init_sysbus_child(OBJECT(mms), mpcname, mpc,
-                      sizeof(mms->ssram_mpc[0]), TYPE_TZ_MPC);
+    sysbus_init_child_obj(OBJECT(mms), mpcname, mpc, sizeof(mms->ssram_mpc[0]),
+                          TYPE_TZ_MPC);
     object_property_set_link(OBJECT(mpc), OBJECT(ssram),
                              "downstream", &error_fatal);
     object_property_set_bool(OBJECT(mpc), true, "realized", &error_fatal);
@@ -288,8 +278,8 @@ static void mps2tz_common_init(MachineState *machine)
         exit(1);
     }
 
-    init_sysbus_child(OBJECT(machine), "iotkit", &mms->iotkit,
-                      sizeof(mms->iotkit), TYPE_IOTKIT);
+    sysbus_init_child_obj(OBJECT(machine), "iotkit", &mms->iotkit,
+                          sizeof(mms->iotkit), TYPE_IOTKIT);
     iotkitdev = DEVICE(&mms->iotkit);
     object_property_set_link(OBJECT(&mms->iotkit), OBJECT(system_memory),
                              "memory", &error_abort);
@@ -421,8 +411,8 @@ static void mps2tz_common_init(MachineState *machine)
         int port;
         char *gpioname;
 
-        init_sysbus_child(OBJECT(machine), ppcinfo->name, ppc,
-                          sizeof(TZPPC), TYPE_TZ_PPC);
+        sysbus_init_child_obj(OBJECT(machine), ppcinfo->name, ppc,
+                              sizeof(TZPPC), TYPE_TZ_PPC);
         ppcdev = DEVICE(ppc);
 
         for (port = 0; port < TZ_NUM_PORTS; port++) {
-- 
2.18.0
