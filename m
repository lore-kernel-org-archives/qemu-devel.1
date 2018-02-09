Received: from eggs.gnu.org ([2001:4830:134:3::10]:43732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wg-0002Mc-9D
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:26:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wb-0006Hm-Uo
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:26:14 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  9 Feb 2018 10:25:14 +0100
Message-Id: <20180209092524.31348-20-cohuck@redhat.com>
In-Reply-To: <20180209092524.31348-1-cohuck@redhat.com>
References: <20180209092524.31348-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 19/29] s390x/flic: cache the common flic class
 in a central function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

This avoids tons of conversions when handling interrupts.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180129125623.21729-19-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/intc/s390_flic.c          | 13 ++++++++++++-
 hw/s390x/css.c               | 10 +++++-----
 hw/s390x/virtio-ccw.c        |  4 ++--
 include/hw/s390x/s390_flic.h |  1 +
 target/s390x/interrupt.c     |  6 +++---
 5 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index b46c0f1bb4..a85a149c6d 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -22,6 +22,17 @@
 #include "qapi/error.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 
+S390FLICStateClass *s390_get_flic_class(S390FLICState *fs)
+{
+    static S390FLICStateClass *class;
+
+    if (!class) {
+        /* we only have one flic device, so this is fine to cache */
+        class = S390_FLIC_COMMON_GET_CLASS(fs);
+    }
+    return class;
+}
+
 QEMUS390FLICState *s390_get_qemu_flic(S390FLICState *fs)
 {
     static QEMUS390FLICState *flic;
@@ -146,7 +157,7 @@ static int qemu_s390_inject_airq(S390FLICState *fs, uint8_t type,
                                  uint8_t isc, uint8_t flags)
 {
     QEMUS390FLICState *flic = s390_get_qemu_flic(fs);
-    S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);
+    S390FLICStateClass *fsc = s390_get_flic_class(fs);
     bool flag = flags & S390_ADAPTER_SUPPRESSIBLE;
     uint32_t io_int_word = (isc << 27) | IO_INT_WORD_AI;
 
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 1c526fd7e2..301bf1772f 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -439,7 +439,7 @@ static int s390_io_adapter_map(AdapterInfo *adapter, uint64_t map_addr,
                                bool do_map)
 {
     S390FLICState *fs = s390_get_flic();
-    S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);
+    S390FLICStateClass *fsc = s390_get_flic_class(fs);
 
     return fsc->io_adapter_map(fs, adapter->adapter_id, map_addr, do_map);
 }
@@ -520,7 +520,7 @@ void css_register_io_adapters(CssIoAdapterType type, bool swap, bool maskable,
     int ret, isc;
     IoAdapter *adapter;
     S390FLICState *fs = s390_get_flic();
-    S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);
+    S390FLICStateClass *fsc = s390_get_flic_class(fs);
 
     /*
      * Disallow multiple registrations for the same device type.
@@ -566,7 +566,7 @@ static void css_clear_io_interrupt(uint16_t subchannel_id,
     Error *err = NULL;
     static bool no_clear_irq;
     S390FLICState *fs = s390_get_flic();
-    S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);
+    S390FLICStateClass *fsc = s390_get_flic_class(fs);
     int r;
 
     if (unlikely(no_clear_irq)) {
@@ -640,7 +640,7 @@ void css_conditional_io_interrupt(SubchDev *sch)
 int css_do_sic(CPUS390XState *env, uint8_t isc, uint16_t mode)
 {
     S390FLICState *fs = s390_get_flic();
-    S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);
+    S390FLICStateClass *fsc = s390_get_flic_class(fs);
     int r;
 
     if (env->psw.mask & PSW_MASK_PSTATE) {
@@ -666,7 +666,7 @@ out:
 void css_adapter_interrupt(CssIoAdapterType type, uint8_t isc)
 {
     S390FLICState *fs = s390_get_flic();
-    S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);
+    S390FLICStateClass *fsc = s390_get_flic_class(fs);
     uint32_t io_int_word = (isc << 27) | IO_INT_WORD_AI;
     IoAdapter *adapter = channel_subsys.io_adapters[type][isc];
 
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 3d8f26949b..8f7fbc2ab7 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1111,7 +1111,7 @@ static int virtio_ccw_setup_irqroutes(VirtioCcwDevice *dev, int nvqs)
     VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
     int ret;
     S390FLICState *fs = s390_get_flic();
-    S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);
+    S390FLICStateClass *fsc = s390_get_flic_class(fs);
 
     ret = virtio_ccw_get_mappings(dev);
     if (ret) {
@@ -1129,7 +1129,7 @@ static int virtio_ccw_setup_irqroutes(VirtioCcwDevice *dev, int nvqs)
 static void virtio_ccw_release_irqroutes(VirtioCcwDevice *dev, int nvqs)
 {
     S390FLICState *fs = s390_get_flic();
-    S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);
+    S390FLICStateClass *fsc = s390_get_flic_class(fs);
 
     fsc->release_adapter_routes(fs, &dev->routes);
 }
diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
index a636afce42..4687ecfe83 100644
--- a/include/hw/s390x/s390_flic.h
+++ b/include/hw/s390x/s390_flic.h
@@ -136,6 +136,7 @@ void s390_flic_init(void);
 
 S390FLICState *s390_get_flic(void);
 QEMUS390FLICState *s390_get_qemu_flic(S390FLICState *fs);
+S390FLICStateClass *s390_get_flic_class(S390FLICState *fs);
 bool ais_needed(void *opaque);
 
 #endif /* HW_S390_FLIC_H */
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 1947012b25..25cfb3eef8 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -134,7 +134,7 @@ void cpu_inject_stop(S390CPU *cpu)
 void s390_sclp_extint(uint32_t parm)
 {
     S390FLICState *fs = s390_get_flic();
-    S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);
+    S390FLICStateClass *fsc = s390_get_flic_class(fs);
 
     fsc->inject_service(fs, parm);
 }
@@ -143,7 +143,7 @@ void s390_io_interrupt(uint16_t subchannel_id, uint16_t subchannel_nr,
                        uint32_t io_int_parm, uint32_t io_int_word)
 {
     S390FLICState *fs = s390_get_flic();
-    S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);
+    S390FLICStateClass *fsc = s390_get_flic_class(fs);
 
     fsc->inject_io(fs, subchannel_id, subchannel_nr, io_int_parm, io_int_word);
 }
@@ -151,7 +151,7 @@ void s390_io_interrupt(uint16_t subchannel_id, uint16_t subchannel_nr,
 void s390_crw_mchk(void)
 {
     S390FLICState *fs = s390_get_flic();
-    S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);
+    S390FLICStateClass *fsc = s390_get_flic_class(fs);
 
     fsc->inject_crw_mchk(fs);
 }
-- 
2.13.6
