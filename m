Received: from eggs.gnu.org ([2001:4830:134:3::10]:58938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3o-0002lI-Hn
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3m-0001uh-Q7
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:44 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 12 Jun 2018 16:44:49 +1000
Message-Id: <20180612064503.14282-20-david@gibson.dropbear.id.au>
In-Reply-To: <20180612064503.14282-1-david@gibson.dropbear.id.au>
References: <20180612064503.14282-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 19/33] cuda: embed mos6522_cuda device directly
 rather than using QOM object link
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, clg@kaod.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Examining the migration stream it can be seen that the mos6522 device state is
being stored separately rather than as part of the CUDA device which is
incorrect (and likely to cause issues if another mos6522 device is added to
the machine).

Resolve this by embedding the mos6522_cuda device directly within the CUDA
device rather than using a QOM object link to reference the device separately.

Note that we also bump the version in vmstate_cuda to reflect this change: this
isn't particularly important for the moment as the Mac machine migration isn't
100% reliable due to issues migrating the timebase under TCG.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/misc/macio/cuda.c         | 44 +++++++++++++++---------------------
 hw/misc/mos6522.c            |  2 +-
 include/hw/misc/macio/cuda.h | 27 ++++++++++------------
 include/hw/misc/mos6522.h    |  2 ++
 4 files changed, 33 insertions(+), 42 deletions(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index bd9b862034..8aba2e63ec 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -65,7 +65,7 @@ static void cuda_receive_packet_from_host(CUDAState *s,
 static uint64_t cuda_get_counter_value(MOS6522State *s, MOS6522Timer *ti)
 {
     MOS6522CUDAState *mcs = container_of(s, MOS6522CUDAState, parent_obj);
-    CUDAState *cs = mcs->cuda;
+    CUDAState *cs = container_of(mcs, CUDAState, mos6522_cuda);
 
     /* Reverse of the tb calculation algorithm that Mac OS X uses on bootup */
     uint64_t tb_diff = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
@@ -78,7 +78,7 @@ static uint64_t cuda_get_counter_value(MOS6522State *s, MOS6522Timer *ti)
 static uint64_t cuda_get_load_time(MOS6522State *s, MOS6522Timer *ti)
 {
     MOS6522CUDAState *mcs = container_of(s, MOS6522CUDAState, parent_obj);
-    CUDAState *cs = mcs->cuda;
+    CUDAState *cs = container_of(mcs, CUDAState, mos6522_cuda);
 
     uint64_t load_time = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
                                   cs->tb_frequency, NANOSECONDS_PER_SECOND);
@@ -88,7 +88,7 @@ static uint64_t cuda_get_load_time(MOS6522State *s, MOS6522Timer *ti)
 static void cuda_set_sr_int(void *opaque)
 {
     CUDAState *s = opaque;
-    MOS6522CUDAState *mcs = s->mos6522_cuda;
+    MOS6522CUDAState *mcs = &s->mos6522_cuda;
     MOS6522State *ms = MOS6522(mcs);
     MOS6522DeviceClass *mdc = MOS6522_DEVICE_GET_CLASS(ms);
 
@@ -97,7 +97,7 @@ static void cuda_set_sr_int(void *opaque)
 
 static void cuda_delay_set_sr_int(CUDAState *s)
 {
-    MOS6522CUDAState *mcs = s->mos6522_cuda;
+    MOS6522CUDAState *mcs = &s->mos6522_cuda;
     MOS6522State *ms = MOS6522(mcs);
     MOS6522DeviceClass *mdc = MOS6522_DEVICE_GET_CLASS(ms);
     int64_t expire;
@@ -117,7 +117,7 @@ static void cuda_delay_set_sr_int(CUDAState *s)
 /* NOTE: TIP and TREQ are negated */
 static void cuda_update(CUDAState *s)
 {
-    MOS6522CUDAState *mcs = s->mos6522_cuda;
+    MOS6522CUDAState *mcs = &s->mos6522_cuda;
     MOS6522State *ms = MOS6522(mcs);
     int packet_received, len;
 
@@ -462,7 +462,7 @@ static void cuda_receive_packet_from_host(CUDAState *s,
 static uint64_t mos6522_cuda_read(void *opaque, hwaddr addr, unsigned size)
 {
     CUDAState *s = opaque;
-    MOS6522CUDAState *mcs = s->mos6522_cuda;
+    MOS6522CUDAState *mcs = &s->mos6522_cuda;
     MOS6522State *ms = MOS6522(mcs);
 
     addr = (addr >> 9) & 0xf;
@@ -473,7 +473,7 @@ static void mos6522_cuda_write(void *opaque, hwaddr addr, uint64_t val,
                                unsigned size)
 {
     CUDAState *s = opaque;
-    MOS6522CUDAState *mcs = s->mos6522_cuda;
+    MOS6522CUDAState *mcs = &s->mos6522_cuda;
     MOS6522State *ms = MOS6522(mcs);
 
     addr = (addr >> 9) & 0xf;
@@ -492,9 +492,11 @@ static const MemoryRegionOps mos6522_cuda_ops = {
 
 static const VMStateDescription vmstate_cuda = {
     .name = "cuda",
-    .version_id = 4,
-    .minimum_version_id = 4,
+    .version_id = 5,
+    .minimum_version_id = 5,
     .fields = (VMStateField[]) {
+        VMSTATE_STRUCT(mos6522_cuda.parent_obj, CUDAState, 0, vmstate_mos6522,
+                       MOS6522State),
         VMSTATE_UINT8(last_b, CUDAState),
         VMSTATE_UINT8(last_acr, CUDAState),
         VMSTATE_INT32(data_in_size, CUDAState),
@@ -530,12 +532,8 @@ static void cuda_realize(DeviceState *dev, Error **errp)
     DeviceState *d;
     struct tm tm;
 
-    d = qdev_create(NULL, TYPE_MOS6522_CUDA);
-    object_property_set_link(OBJECT(d), OBJECT(s), "cuda", errp);
-    qdev_init_nofail(d);
-    s->mos6522_cuda = MOS6522_CUDA(d);
-
     /* Pass IRQ from 6522 */
+    d = DEVICE(&s->mos6522_cuda);
     ms = MOS6522(d);
     sbd = SYS_BUS_DEVICE(s);
     sysbus_pass_irq(sbd, SYS_BUS_DEVICE(ms));
@@ -556,6 +554,10 @@ static void cuda_init(Object *obj)
     CUDAState *s = CUDA(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
+    object_initialize(&s->mos6522_cuda, sizeof(s->mos6522_cuda),
+                      TYPE_MOS6522_CUDA);
+    qdev_set_parent_bus(DEVICE(&s->mos6522_cuda), sysbus_get_default());
+
     memory_region_init_io(&s->mem, obj, &mos6522_cuda_ops, s, "cuda", 0x2000);
     sysbus_init_mmio(sbd, &s->mem);
 
@@ -590,8 +592,9 @@ static const TypeInfo cuda_type_info = {
 static void mos6522_cuda_portB_write(MOS6522State *s)
 {
     MOS6522CUDAState *mcs = container_of(s, MOS6522CUDAState, parent_obj);
+    CUDAState *cs = container_of(mcs, CUDAState, mos6522_cuda);
 
-    cuda_update(mcs->cuda);
+    cuda_update(cs);
 }
 
 static void mos6522_cuda_realize(DeviceState *dev, Error **errp)
@@ -605,16 +608,6 @@ static void mos6522_cuda_realize(DeviceState *dev, Error **errp)
     ms->timers[1].frequency = (SCALE_US * 6000) / 4700;
 }
 
-static void mos6522_cuda_init(Object *obj)
-{
-    MOS6522CUDAState *s = MOS6522_CUDA(obj);
-
-    object_property_add_link(obj, "cuda", TYPE_CUDA,
-                             (Object **) &s->cuda,
-                             qdev_prop_allow_set_link_before_realize,
-                             0, NULL);
-}
-
 static void mos6522_cuda_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -632,7 +625,6 @@ static const TypeInfo mos6522_cuda_type_info = {
     .name = TYPE_MOS6522_CUDA,
     .parent = TYPE_MOS6522,
     .instance_size = sizeof(MOS6522CUDAState),
-    .instance_init = mos6522_cuda_init,
     .class_init = mos6522_cuda_class_init,
 };
 
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index bcb306d357..524a250329 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -390,7 +390,7 @@ static const VMStateDescription vmstate_mos6522_timer = {
     }
 };
 
-static const VMStateDescription vmstate_mos6522 = {
+const VMStateDescription vmstate_mos6522 = {
     .name = "mos6522",
     .version_id = 0,
     .minimum_version_id = 0,
diff --git a/include/hw/misc/macio/cuda.h b/include/hw/misc/macio/cuda.h
index 494b709579..7dad469142 100644
--- a/include/hw/misc/macio/cuda.h
+++ b/include/hw/misc/macio/cuda.h
@@ -54,12 +54,21 @@
 #define CUDA_TIMER_TICKLE              0x24
 #define CUDA_COMBINED_FORMAT_IIC       0x25
 
+
+/* MOS6522 CUDA */
+typedef struct MOS6522CUDAState {
+    /*< private >*/
+    MOS6522State parent_obj;
+} MOS6522CUDAState;
+
+#define TYPE_MOS6522_CUDA "mos6522-cuda"
+#define MOS6522_CUDA(obj) OBJECT_CHECK(MOS6522CUDAState, (obj), \
+                                       TYPE_MOS6522_CUDA)
+
 /* Cuda */
 #define TYPE_CUDA "cuda"
 #define CUDA(obj) OBJECT_CHECK(CUDAState, (obj), TYPE_CUDA)
 
-typedef struct MOS6522CUDAState MOS6522CUDAState;
-
 typedef struct CUDAState {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -67,7 +76,7 @@ typedef struct CUDAState {
     MemoryRegion mem;
 
     ADBBusState adb_bus;
-    MOS6522CUDAState *mos6522_cuda;
+    MOS6522CUDAState mos6522_cuda;
 
     uint32_t tick_offset;
     uint64_t tb_frequency;
@@ -92,16 +101,4 @@ typedef struct CUDAState {
     QEMUTimer *adb_poll_timer;
 } CUDAState;
 
-/* MOS6522 CUDA */
-struct MOS6522CUDAState {
-    /*< private >*/
-    MOS6522State parent_obj;
-
-    CUDAState *cuda;
-};
-
-#define TYPE_MOS6522_CUDA "mos6522-cuda"
-#define MOS6522_CUDA(obj) OBJECT_CHECK(MOS6522CUDAState, (obj), \
-                                       TYPE_MOS6522_CUDA)
-
 #endif /* CUDA_H */
diff --git a/include/hw/misc/mos6522.h b/include/hw/misc/mos6522.h
index a53c161b00..cb0fd7db78 100644
--- a/include/hw/misc/mos6522.h
+++ b/include/hw/misc/mos6522.h
@@ -146,6 +146,8 @@ typedef struct MOS6522DeviceClass {
 #define MOS6522_DEVICE_GET_CLASS(obj) \
     OBJECT_GET_CLASS(MOS6522DeviceClass, (obj), TYPE_MOS6522)
 
+extern const VMStateDescription vmstate_mos6522;
+
 uint64_t mos6522_read(void *opaque, hwaddr addr, unsigned size);
 void mos6522_write(void *opaque, hwaddr addr, uint64_t val, unsigned size);
 
-- 
2.17.1
