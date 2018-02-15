Received: from eggs.gnu.org ([2001:4830:134:3::10]:52740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emK2H-00084e-NO
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:57:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emK2G-00052F-Mc
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:57:17 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1emK2G-0004ta-DU
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:57:16 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1emK26-0001kx-3R
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:57:06 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 13:56:44 +0000
Message-Id: <20180215135702.1340-4-peter.maydell@linaro.org>
In-Reply-To: <20180215135702.1340-1-peter.maydell@linaro.org>
References: <20180215135702.1340-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 03/21] bcm2836: Make CPU type configurable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Pekka Enberg <penberg@iki.fi>

This patch adds a "cpu-type" property to BCM2836 SoC in preparation for
reusing the code for the Raspberry Pi 3, which has a different processor
model.

Signed-off-by: Pekka Enberg <penberg@iki.fi>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/bcm2836.h |  1 +
 hw/arm/bcm2836.c         | 17 +++++++++--------
 hw/arm/raspi.c           |  3 +++
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index 76de1996af..4758b4ae54 100644
--- a/include/hw/arm/bcm2836.h
+++ b/include/hw/arm/bcm2836.h
@@ -25,6 +25,7 @@ typedef struct BCM2836State {
     DeviceState parent_obj;
     /*< public >*/
 
+    char *cpu_type;
     uint32_t enabled_cpus;
 
     ARMCPU cpus[BCM2836_NCPUS];
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 8c43291112..40e8b25a46 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -26,14 +26,6 @@
 static void bcm2836_init(Object *obj)
 {
     BCM2836State *s = BCM2836(obj);
-    int n;
-
-    for (n = 0; n < BCM2836_NCPUS; n++) {
-        object_initialize(&s->cpus[n], sizeof(s->cpus[n]),
-                          "cortex-a15-" TYPE_ARM_CPU);
-        object_property_add_child(obj, "cpu[*]", OBJECT(&s->cpus[n]),
-                                  &error_abort);
-    }
 
     object_initialize(&s->control, sizeof(s->control), TYPE_BCM2836_CONTROL);
     object_property_add_child(obj, "control", OBJECT(&s->control), NULL);
@@ -59,6 +51,14 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
 
     /* common peripherals from bcm2835 */
 
+    obj = OBJECT(dev);
+    for (n = 0; n < BCM2836_NCPUS; n++) {
+        object_initialize(&s->cpus[n], sizeof(s->cpus[n]),
+                          s->cpu_type);
+        object_property_add_child(obj, "cpu[*]", OBJECT(&s->cpus[n]),
+                                  &error_abort);
+    }
+
     obj = object_property_get_link(OBJECT(dev), "ram", &err);
     if (obj == NULL) {
         error_setg(errp, "%s: required ram link not found: %s",
@@ -150,6 +150,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
 }
 
 static Property bcm2836_props[] = {
+    DEFINE_PROP_STRING("cpu-type", BCM2836State, cpu_type),
     DEFINE_PROP_UINT32("enabled-cpus", BCM2836State, enabled_cpus, BCM2836_NCPUS),
     DEFINE_PROP_END_OF_LIST()
 };
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index cd5fa8c3dc..c24a4a1b14 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -135,6 +135,8 @@ static void raspi2_init(MachineState *machine)
     /* Setup the SOC */
     object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(&s->ram),
                                    &error_abort);
+    object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-type",
+                            &error_abort);
     object_property_set_int(OBJECT(&s->soc), smp_cpus, "enabled-cpus",
                             &error_abort);
     object_property_set_int(OBJECT(&s->soc), 0xa21041, "board-rev",
@@ -166,6 +168,7 @@ static void raspi2_machine_init(MachineClass *mc)
     mc->no_parallel = 1;
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
     mc->max_cpus = BCM2836_NCPUS;
     mc->min_cpus = BCM2836_NCPUS;
     mc->default_cpus = BCM2836_NCPUS;
-- 
2.16.1
