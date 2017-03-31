Received: from eggs.gnu.org ([2001:4830:134:3::10]:50129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu2Ct-0006sq-K5
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 15:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu2Cr-0004JL-61
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 15:27:35 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 31 Mar 2017 16:27:23 -0300
Message-Id: <20170331192724.14339-2-ehabkost@redhat.com>
In-Reply-To: <20170331192724.14339-1-ehabkost@redhat.com>
References: <20170331192724.14339-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 1/2] etsec: Rename (TYPE_)ETSEC_COMMON
 to (TYPE_)ETSEC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Scott Wood <scottwood@freescale.com>, qemu-ppc@nongnu.org, Fabien Chouteau <chouteau@adacore.com>, Jason Wang <jasowang@redhat.com>

Types named *_COMMON are normally used when there's a common
parent class for multiple classes. We have only one eTSEC type,
so rename the TYPE_ETSEC_COMMON and ETSEC_COMMON macros to
TYPE_ETSEC and TYPE_ETSEC_COMMON.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/net/fsl_etsec/etsec.h | 6 +++---
 hw/net/fsl_etsec/etsec.c | 6 +++---
 hw/ppc/e500.c            | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/net/fsl_etsec/etsec.h b/hw/net/fsl_etsec/etsec.h
index 30c828e241..3da412e733 100644
--- a/hw/net/fsl_etsec/etsec.h
+++ b/hw/net/fsl_etsec/etsec.h
@@ -149,9 +149,9 @@ typedef struct eTSEC {
     bool need_flush;
 } eTSEC;
 
-#define TYPE_ETSEC_COMMON "eTSEC"
-#define ETSEC_COMMON(obj) \
-     OBJECT_CHECK(eTSEC, (obj), TYPE_ETSEC_COMMON)
+#define TYPE_ETSEC "eTSEC"
+#define ETSEC(obj) \
+     OBJECT_CHECK(eTSEC, (obj), TYPE_ETSEC)
 
 #define eTSEC_TRANSMIT 1
 #define eTSEC_RECEIVE  2
diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index aa2b0d5a85..ddefaf560c 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -303,7 +303,7 @@ static void etsec_timer_hit(void *opaque)
 
 static void etsec_reset(DeviceState *d)
 {
-    eTSEC *etsec = ETSEC_COMMON(d);
+    eTSEC *etsec = ETSEC(d);
     int i = 0;
     int reg_index = 0;
 
@@ -378,7 +378,7 @@ static NetClientInfo net_etsec_info = {
 
 static void etsec_realize(DeviceState *dev, Error **errp)
 {
-    eTSEC        *etsec = ETSEC_COMMON(dev);
+    eTSEC        *etsec = ETSEC(dev);
 
     etsec->nic = qemu_new_nic(&net_etsec_info, &etsec->conf,
                               object_get_typename(OBJECT(dev)), dev->id, etsec);
@@ -392,7 +392,7 @@ static void etsec_realize(DeviceState *dev, Error **errp)
 
 static void etsec_instance_init(Object *obj)
 {
-    eTSEC        *etsec = ETSEC_COMMON(obj);
+    eTSEC        *etsec = ETSEC(obj);
     SysBusDevice *sbd   = SYS_BUS_DEVICE(obj);
 
     memory_region_init_io(&etsec->io_area, OBJECT(etsec), &etsec_ops, etsec,
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index f7df2388c1..f6478b3a68 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -161,7 +161,7 @@ typedef struct PlatformDevtreeData {
 
 static int create_devtree_etsec(SysBusDevice *sbdev, PlatformDevtreeData *data)
 {
-    eTSEC *etsec = ETSEC_COMMON(sbdev);
+    eTSEC *etsec = ETSEC(sbdev);
     PlatformBusDevice *pbus = data->pbus;
     hwaddr mmio0 = platform_bus_get_mmio_addr(pbus, sbdev, 0);
     int irq0 = platform_bus_get_irqn(pbus, sbdev, 0);
@@ -201,7 +201,7 @@ static void sysbus_device_create_devtree(SysBusDevice *sbdev, void *opaque)
     PlatformDevtreeData *data = opaque;
     bool matched = false;
 
-    if (object_dynamic_cast(OBJECT(sbdev), TYPE_ETSEC_COMMON)) {
+    if (object_dynamic_cast(OBJECT(sbdev), TYPE_ETSEC)) {
         create_devtree_etsec(sbdev, data);
         matched = true;
     }
-- 
2.11.0.259.g40922b1
