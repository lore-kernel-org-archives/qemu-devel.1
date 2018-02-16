Received: from eggs.gnu.org ([2001:4830:134:3::10]:46708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <penberg@gmail.com>) id 1ema2E-0003QS-HF
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 02:02:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <penberg@gmail.com>) id 1ema2A-0007jh-Bk
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 02:02:18 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:35988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <penberg@gmail.com>) id 1ema2A-0007ik-4E
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 02:02:14 -0500
Received: by mail-lf0-x242.google.com with SMTP id t79so2762371lfe.3
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 23:02:13 -0800 (PST)
Sender: Pekka Enberg <penberg@gmail.com>
From: Pekka Enberg <penberg@iki.fi>
Date: Fri, 16 Feb 2018 09:01:59 +0200
Message-Id: <20180216070201.4271-2-penberg@iki.fi>
In-Reply-To: <20180216070201.4271-1-penberg@iki.fi>
References: <20180216070201.4271-1-penberg@iki.fi>
Subject: [Qemu-devel] [PATCH v2 1/3] bcm2836: Make CPU type configurable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Pekka Enberg <penberg@iki.fi>

This patch adds a "cpu-type" property to BCM2836 SoC in preparation for
reusing the code for the Raspberry Pi 3, which has a different processor
model.

Signed-off-by: Pekka Enberg <penberg@iki.fi>
---
 hw/arm/bcm2836.c         | 17 +++++++++--------
 hw/arm/raspi.c           |  3 +++
 include/hw/arm/bcm2836.h |  1 +
 3 files changed, 13 insertions(+), 8 deletions(-)

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
-- 
2.14.3
