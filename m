Received: from eggs.gnu.org ([2001:4830:134:3::10]:51148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f3y5P-0006eb-SQ
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 02:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f3y5O-0008Gw-SG
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 02:09:27 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  5 Apr 2018 08:09:11 +0200
Message-Id: <1522908551-14885-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12] hw/arm/fsl-imx: Fix introspection
 problem with fsl-imx6 and fsl-imx7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

QEMU currently exits unexpectedly when trying to introspect the fsl-imx6
and fsl-imx7 devices on systems with many SMP CPUs:

$ echo "{'execute':'qmp_capabilities'}"\
       "{'execute':'device-list-properties',"\
       " 'arguments':{'typename':'fsl,imx6'}}" \
       | arm-softmmu/qemu-system-arm -M virt,accel=qtest -qmp stdio -smp 8
{"QMP": {"version": {"qemu": {"micro": 91, "minor": 11, "major": 2},
 "package": "build-all"}, "capabilities": []}}
{"return": {}}
fsl,imx6: Only 4 CPUs are supported (8 requested)

And:

$ echo "{'execute':'qmp_capabilities'}"\
       "{'execute':'device-list-properties',"\
       " 'arguments':{'typename':'fsl,imx7'}}" \
       | arm-softmmu/qemu-system-arm -M raspi2,accel=qtest -qmp stdio
{"QMP": {"version": {"qemu": {"micro": 91, "minor": 11, "major": 2},
 "package": "build-all"}, "capabilities": []}}
{"return": {}}
fsl,imx7: Only 2 CPUs are supported (4 requested)

This happens because these devices are doing an exit() from their
instance_init function - which should never be done since instance_init
can be called at any time for device introspection! Fix it by moving
the deadly check into the realize() function instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/fsl-imx6.c | 14 +++++++-------
 hw/arm/fsl-imx7.c | 13 +++++++------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index b6ac72d..9dfbc9a 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -37,13 +37,7 @@ static void fsl_imx6_init(Object *obj)
     char name[NAME_SIZE];
     int i;
 
-    if (smp_cpus > FSL_IMX6_NUM_CPUS) {
-        error_report("%s: Only %d CPUs are supported (%d requested)",
-                     TYPE_FSL_IMX6, FSL_IMX6_NUM_CPUS, smp_cpus);
-        exit(1);
-    }
-
-    for (i = 0; i < smp_cpus; i++) {
+    for (i = 0; i < MIN(smp_cpus, FSL_IMX6_NUM_CPUS); i++) {
         object_initialize(&s->cpu[i], sizeof(s->cpu[i]),
                           "cortex-a9-" TYPE_ARM_CPU);
         snprintf(name, NAME_SIZE, "cpu%d", i);
@@ -119,6 +113,12 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
     uint16_t i;
     Error *err = NULL;
 
+    if (smp_cpus > FSL_IMX6_NUM_CPUS) {
+        error_setg(errp, "%s: Only %d CPUs are supported (%d requested)",
+                   TYPE_FSL_IMX6, FSL_IMX6_NUM_CPUS, smp_cpus);
+        return;
+    }
+
     for (i = 0; i < smp_cpus; i++) {
 
         /* On uniprocessor, the CBAR is set to 0 */
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 26ef36c..390b431 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -35,13 +35,8 @@ static void fsl_imx7_init(Object *obj)
     char name[NAME_SIZE];
     int i;
 
-    if (smp_cpus > FSL_IMX7_NUM_CPUS) {
-        error_report("%s: Only %d CPUs are supported (%d requested)",
-                     TYPE_FSL_IMX7, FSL_IMX7_NUM_CPUS, smp_cpus);
-        exit(1);
-    }
 
-    for (i = 0; i < smp_cpus; i++) {
+    for (i = 0; i < MIN(smp_cpus, FSL_IMX7_NUM_CPUS); i++) {
         object_initialize(&s->cpu[i], sizeof(s->cpu[i]),
                           ARM_CPU_TYPE_NAME("cortex-a7"));
         snprintf(name, NAME_SIZE, "cpu%d", i);
@@ -197,6 +192,12 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     qemu_irq irq;
     char name[NAME_SIZE];
 
+    if (smp_cpus > FSL_IMX7_NUM_CPUS) {
+        error_setg(errp, "%s: Only %d CPUs are supported (%d requested)",
+                   TYPE_FSL_IMX7, FSL_IMX7_NUM_CPUS, smp_cpus);
+        return;
+    }
+
     for (i = 0; i < smp_cpus; i++) {
         o = OBJECT(&s->cpu[i]);
 
-- 
1.8.3.1
