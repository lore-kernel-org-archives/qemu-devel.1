Received: from eggs.gnu.org ([2001:4830:134:3::10]:47121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1evlxV-0005ba-2k
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:35:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1evlxQ-0005vH-VA
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:35:25 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Mar 2018 15:34:56 +0000
Message-Id: <20180313153458.26822-8-peter.maydell@linaro.org>
In-Reply-To: <20180313153458.26822-1-peter.maydell@linaro.org>
References: <20180313153458.26822-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 7/9] hw/arm/bcm2836: Use correct affinity
 values for BCM2837
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

The BCM2837 sets the Aff1 field of the MPIDR affinity values for the
CPUs to 0, whereas the BCM2836 uses 0xf. Set this correctly, as it
is required for Linux to boot.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/bcm2836.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 07d2705f96..7140257c98 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -25,14 +25,17 @@
 
 struct BCM283XInfo {
     const char *name;
+    int clusterid;
 };
 
 static const BCM283XInfo bcm283x_socs[] = {
     {
         .name = TYPE_BCM2836,
+        .clusterid = 0xf,
     },
     {
         .name = TYPE_BCM2837,
+        .clusterid = 0x0,
     },
 };
 
@@ -58,6 +61,8 @@ static void bcm2836_init(Object *obj)
 static void bcm2836_realize(DeviceState *dev, Error **errp)
 {
     BCM283XState *s = BCM283X(dev);
+    BCM283XClass *bc = BCM283X_GET_CLASS(dev);
+    const BCM283XInfo *info = bc->info;
     Object *obj;
     Error *err = NULL;
     int n;
@@ -119,7 +124,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
         /* Mirror bcm2836, which has clusterid set to 0xf
          * TODO: this should be converted to a property of ARM_CPU
          */
-        s->cpus[n].mp_affinity = 0xF00 | n;
+        s->cpus[n].mp_affinity = (info->clusterid << 8) | n;
 
         /* set periphbase/CBAR value for CPU-local registers */
         object_property_set_int(OBJECT(&s->cpus[n]),
-- 
2.16.2
