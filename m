Received: from eggs.gnu.org ([2001:4830:134:3::10]:47064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1evlxR-0005WF-QG
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1evlxQ-0005t7-CW
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:35:21 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Mar 2018 15:34:57 +0000
Message-Id: <20180313153458.26822-9-peter.maydell@linaro.org>
In-Reply-To: <20180313153458.26822-1-peter.maydell@linaro.org>
References: <20180313153458.26822-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 8/9] hw/arm/bcm2836: Hardcode correct CPU type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Pekka Enberg <penberg@iki.fi>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>

Now we have separate types for BCM2386 and BCM2387, we might as well
just hard-code the CPU type they use rather than having it passed
through as an object property. This then lets us put the initialization
of the CPU object in init rather than realize.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/bcm2836.c | 22 +++++++++++++---------
 hw/arm/raspi.c   |  2 --
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 7140257c98..12f75b55a7 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -25,16 +25,19 @@
 
 struct BCM283XInfo {
     const char *name;
+    const char *cpu_type;
     int clusterid;
 };
 
 static const BCM283XInfo bcm283x_socs[] = {
     {
         .name = TYPE_BCM2836,
+        .cpu_type = ARM_CPU_TYPE_NAME("cortex-a15"),
         .clusterid = 0xf,
     },
     {
         .name = TYPE_BCM2837,
+        .cpu_type = ARM_CPU_TYPE_NAME("cortex-a53"),
         .clusterid = 0x0,
     },
 };
@@ -42,6 +45,16 @@ static const BCM283XInfo bcm283x_socs[] = {
 static void bcm2836_init(Object *obj)
 {
     BCM283XState *s = BCM283X(obj);
+    BCM283XClass *bc = BCM283X_GET_CLASS(obj);
+    const BCM283XInfo *info = bc->info;
+    int n;
+
+    for (n = 0; n < BCM283X_NCPUS; n++) {
+        object_initialize(&s->cpus[n], sizeof(s->cpus[n]),
+                          info->cpu_type);
+        object_property_add_child(obj, "cpu[*]", OBJECT(&s->cpus[n]),
+                                  &error_abort);
+    }
 
     object_initialize(&s->control, sizeof(s->control), TYPE_BCM2836_CONTROL);
     object_property_add_child(obj, "control", OBJECT(&s->control), NULL);
@@ -69,14 +82,6 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
 
     /* common peripherals from bcm2835 */
 
-    obj = OBJECT(dev);
-    for (n = 0; n < BCM283X_NCPUS; n++) {
-        object_initialize(&s->cpus[n], sizeof(s->cpus[n]),
-                          s->cpu_type);
-        object_property_add_child(obj, "cpu[*]", OBJECT(&s->cpus[n]),
-                                  &error_abort);
-    }
-
     obj = object_property_get_link(OBJECT(dev), "ram", &err);
     if (obj == NULL) {
         error_setg(errp, "%s: required ram link not found: %s",
@@ -168,7 +173,6 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
 }
 
 static Property bcm2836_props[] = {
-    DEFINE_PROP_STRING("cpu-type", BCM283XState, cpu_type),
     DEFINE_PROP_UINT32("enabled-cpus", BCM283XState, enabled_cpus,
                        BCM283X_NCPUS),
     DEFINE_PROP_END_OF_LIST()
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index f588720138..ae15997669 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -150,8 +150,6 @@ static void raspi_init(MachineState *machine, int version)
     /* Setup the SOC */
     object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(&s->ram),
                                    &error_abort);
-    object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-type",
-                            &error_abort);
     object_property_set_int(OBJECT(&s->soc), smp_cpus, "enabled-cpus",
                             &error_abort);
     int board_rev = version == 3 ? 0xa02082 : 0xa21041;
-- 
2.16.2
