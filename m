Received: from eggs.gnu.org ([2001:4830:134:3::10]:49785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1exzc3-0002Ov-K7
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1exzc2-0007kt-Mu
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:34:27 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1exzc2-0007jV-GY
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:34:26 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1exzc1-00033f-Hg
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 18:34:25 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Mar 2018 18:34:13 +0000
Message-Id: <20180319183415.1976-12-peter.maydell@linaro.org>
In-Reply-To: <20180319183415.1976-1-peter.maydell@linaro.org>
References: <20180319183415.1976-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/13] hw/arm/bcm2836: Use correct affinity
 values for BCM2837
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The BCM2837 sets the Aff1 field of the MPIDR affinity values for the
CPUs to 0, whereas the BCM2836 uses 0xf. Set this correctly, as it
is required for Linux to boot.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180313153458.26822-8-peter.maydell@linaro.org
---
 hw/arm/bcm2836.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 07d2705f96..d775a33969 100644
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
@@ -116,10 +121,8 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
         qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-fiq", 0));
 
     for (n = 0; n < BCM283X_NCPUS; n++) {
-        /* Mirror bcm2836, which has clusterid set to 0xf
-         * TODO: this should be converted to a property of ARM_CPU
-         */
-        s->cpus[n].mp_affinity = 0xF00 | n;
+        /* TODO: this should be converted to a property of ARM_CPU */
+        s->cpus[n].mp_affinity = (info->clusterid << 8) | n;
 
         /* set periphbase/CBAR value for CPU-local registers */
         object_property_set_int(OBJECT(&s->cpus[n]),
-- 
2.16.2
