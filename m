Received: from eggs.gnu.org ([2001:4830:134:3::10]:51168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fiFeP-0008By-BM
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:00:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fiFeM-0002Dp-E9
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:00:05 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 25 Jul 2018 09:59:40 +0100
Message-Id: <20180725085944.11856-4-stefanha@redhat.com>
In-Reply-To: <20180725085944.11856-1-stefanha@redhat.com>
References: <20180725085944.11856-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/7] hw/arm: make bitbanded IO optional on
 ARM M Profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mail@steffen-goertz.de, Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, ilg@livius.net, qemu-arm@nongnu.org, Julia Suvorova <jusual@mail.ru>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Su Hang <suhang16@mails.ucas.ac.cn>, Steffen Gortz <qemu.ml@steffen-goertz.de>, jim@groklearning.com, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@redhat.com>

Some ARM CPUs have bitbanded IO, a memory region that allows convenient
bit access via 32-bit memory loads/stores.  This eliminates the need for
read-modify-update instruction sequences.

This patch makes this optional feature a ARMMProfile qdev property,
allowing boards to choose whether they want bitbanding or not.

Status of boards:
 * iotkit (Cortex M33), no bitband
 * mps2 (Cortex M3), bitband
 * msf2 (Cortex M3), bitband
 * stellaris (Cortex M3), bitband
 * stm32f205 (Cortex M3), bitband

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/arm/arm-m-profile.h |  2 ++
 hw/arm/arm-m-profile.c         | 38 +++++++++++++++++++---------------
 hw/arm/mps2.c                  |  1 +
 hw/arm/msf2-soc.c              |  1 +
 hw/arm/stellaris.c             |  1 +
 hw/arm/stm32f205_soc.c         |  1 +
 6 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/include/hw/arm/arm-m-profile.h b/include/hw/arm/arm-m-profile.h
index ea496d9b88..1eb7a5c328 100644
--- a/include/hw/arm/arm-m-profile.h
+++ b/include/hw/arm/arm-m-profile.h
@@ -50,6 +50,7 @@ typedef struct {
  *   devices will be automatically layered on top of this view.)
  * + Property "idau": IDAU interface (forwarded to CPU object)
  * + Property "init-svtor": secure VTOR reset value (forwarded to CPU object)
+ * + Property "enable-bitband": expose bitbanded IO
  */
 typedef struct {
     /*< private >*/
@@ -70,6 +71,7 @@ typedef struct {
     MemoryRegion *board_memory;
     Object *idau;
     uint32_t init_svtor;
+    bool enable_bitband;
 } ARMMProfileState;
 
 typedef struct {
diff --git a/hw/arm/arm-m-profile.c b/hw/arm/arm-m-profile.c
index b7dd2370d4..8bafd6602d 100644
--- a/hw/arm/arm-m-profile.c
+++ b/hw/arm/arm-m-profile.c
@@ -212,25 +212,27 @@ static void arm_m_profile_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->container, 0xe000e000,
                                 sysbus_mmio_get_region(sbd, 0));
 
-    for (i = 0; i < ARRAY_SIZE(s->bitband); i++) {
-        Object *obj = OBJECT(&s->bitband[i]);
-        SysBusDevice *sbd = SYS_BUS_DEVICE(&s->bitband[i]);
+    if (s->enable_bitband) {
+        for (i = 0; i < ARRAY_SIZE(s->bitband); i++) {
+            Object *obj = OBJECT(&s->bitband[i]);
+            SysBusDevice *sbd = SYS_BUS_DEVICE(&s->bitband[i]);
 
-        object_property_set_int(obj, bitband_input_addr[i], "base", &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
-            return;
-        }
-        object_property_set_link(obj, OBJECT(s->board_memory),
-                                 "source-memory", &error_abort);
-        object_property_set_bool(obj, true, "realized", &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
-            return;
-        }
+            object_property_set_int(obj, bitband_input_addr[i], "base", &err);
+            if (err != NULL) {
+                error_propagate(errp, err);
+                return;
+            }
+            object_property_set_link(obj, OBJECT(s->board_memory),
+                                     "source-memory", &error_abort);
+            object_property_set_bool(obj, true, "realized", &err);
+            if (err != NULL) {
+                error_propagate(errp, err);
+                return;
+            }
 
-        memory_region_add_subregion(&s->container, bitband_output_addr[i],
-                                    sysbus_mmio_get_region(sbd, 0));
+            memory_region_add_subregion(&s->container, bitband_output_addr[i],
+                                        sysbus_mmio_get_region(sbd, 0));
+        }
     }
 }
 
@@ -241,6 +243,8 @@ static Property arm_m_profile_properties[] = {
     DEFINE_PROP_LINK("idau", ARMMProfileState, idau,
                      TYPE_IDAU_INTERFACE, Object *),
     DEFINE_PROP_UINT32("init-svtor", ARMMProfileState, init_svtor, 0),
+    DEFINE_PROP_BOOL("enable-bitband", ARMMProfileState,
+                     enable_bitband, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 912e1297d5..b232162dbd 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -186,6 +186,7 @@ static void mps2_common_init(MachineState *machine)
         g_assert_not_reached();
     }
     qdev_prop_set_string(armv7m, "cpu-type", machine->cpu_type);
+    qdev_prop_set_bit(armv7m, "enable-bitband", true);
     object_property_set_link(OBJECT(&mms->armv7m), OBJECT(system_memory),
                              "memory", &error_abort);
     object_property_set_bool(OBJECT(&mms->armv7m), true, "realized",
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index 09cdc61f44..fb5d16338f 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -117,6 +117,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     armv7m = DEVICE(&s->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 81);
     qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
+    qdev_prop_set_bit(armv7m, "enable-bitband", true);
     object_property_set_link(OBJECT(&s->armv7m), OBJECT(get_system_memory()),
                                      "memory", &error_abort);
     object_property_set_bool(OBJECT(&s->armv7m), true, "realized", &err);
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 42785f5bd1..cb22684ffe 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1304,6 +1304,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     nvic = qdev_create(NULL, TYPE_ARM_M_PROFILE);
     qdev_prop_set_uint32(nvic, "num-irq", NUM_IRQ_LINES);
     qdev_prop_set_string(nvic, "cpu-type", ms->cpu_type);
+    qdev_prop_set_bit(nvic, "enable-bitband", true);
     object_property_set_link(OBJECT(nvic), OBJECT(get_system_memory()),
                                      "memory", &error_abort);
     /* This will exit with an error if the user passed us a bad cpu_type */
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index 7de1474ade..f78b89d205 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -109,6 +109,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     armv7m = DEVICE(&s->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 96);
     qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
+    qdev_prop_set_bit(armv7m, "enable-bitband", true);
     object_property_set_link(OBJECT(&s->armv7m), OBJECT(get_system_memory()),
                                      "memory", &error_abort);
     object_property_set_bool(OBJECT(&s->armv7m), true, "realized", &err);
-- 
2.17.1
