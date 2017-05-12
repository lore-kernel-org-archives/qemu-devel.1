Received: from eggs.gnu.org ([2001:4830:134:3::10]:57403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d9FYQ-0001lU-5f
	for qemu-devel@nongnu.org; Fri, 12 May 2017 14:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d9FYL-0005Mq-4I
	for qemu-devel@nongnu.org; Fri, 12 May 2017 14:44:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d9FYK-0005Kt-RL
	for qemu-devel@nongnu.org; Fri, 12 May 2017 14:44:37 -0400
Date: Fri, 12 May 2017 15:44:30 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170512184430.GA22043@thinpad.lan.raisama.net>
References: <20170503203604.31462-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170503203604.31462-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RESEND v2 00/21] qdev/sysbus: Set
 user_creatable=false by default on sysbus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>

Ping? If there are no objections to this series, I plan to merge
it through the Machine Core tree.

If anybody is interested, below are the results of squashing
patches 2-20 together:

---
 hw/core/sysbus.c         | 11 +++++++++++
 hw/i386/amd_iommu.c      |  2 ++
 hw/i386/intel_iommu.c    |  2 ++
 hw/net/fsl_etsec/etsec.c |  2 ++
 hw/ppc/spapr_pci.c       |  2 ++
 hw/vfio/amd-xgbe.c       |  2 ++
 hw/vfio/calxeda-xgmac.c  |  2 ++
 hw/xen/xen_backend.c     |  2 ++
 8 files changed, 25 insertions(+)

diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index c0f560b289..5d0887f499 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -326,6 +326,17 @@ static void sysbus_device_class_init(ObjectClass *klass, void *data)
     DeviceClass *k = DEVICE_CLASS(klass);
     k->init = sysbus_device_init;
     k->bus_type = TYPE_SYSTEM_BUS;
+    /*
+     * device_add plugs devices into a suitable bus.  For "real" buses,
+     * that actually connects the device.  For sysbus, the connections
+     * need to be made separately, and device_add can't do that.  The
+     * device would be left unconnected, and will probably not work
+     *
+     * However, a few machines can handle device_add/-device with
+     * a few specific sysbus devices. In those cases, the device
+     * subclass needs to override it and set user_creatable=true.
+     */
+    k->user_creatable = false;
 }
 
 static const TypeInfo sysbus_device_type_info = {
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index f86a40aa30..efcc93cbfd 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1186,6 +1186,8 @@ static void amdvi_class_init(ObjectClass *klass, void* data)
     dc->vmsd = &vmstate_amdvi;
     dc->hotpluggable = false;
     dc_class->realize = amdvi_realize;
+    /* Supported by the pc-q35-* machine types */
+    dc->user_creatable = true;
 }
 
 static const TypeInfo amdvi = {
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 02f047c8e3..327a46cd19 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3009,6 +3009,8 @@ static void vtd_class_init(ObjectClass *klass, void *data)
     dc->hotpluggable = false;
     x86_class->realize = vtd_realize;
     x86_class->int_remap = vtd_int_remap;
+    /* Supported by the pc-q35-* machine types */
+    dc->user_creatable = true;
 }
 
 static const TypeInfo vtd_info = {
diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index aa2b0d5a85..9da1932970 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -416,6 +416,8 @@ static void etsec_class_init(ObjectClass *klass, void *data)
     dc->realize = etsec_realize;
     dc->reset = etsec_reset;
     dc->props = etsec_properties;
+    /* Supported by ppce500 machine */
+    dc->user_creatable = true;
 }
 
 static TypeInfo etsec_info = {
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index e7567e2e8f..a7cff32bbf 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1994,6 +1994,8 @@ static void spapr_phb_class_init(ObjectClass *klass, void *data)
     dc->props = spapr_phb_properties;
     dc->reset = spapr_phb_reset;
     dc->vmsd = &vmstate_spapr_pci;
+    /* Supported by TYPE_SPAPR_MACHINE */
+    dc->user_creatable = true;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     hp->plug = spapr_phb_hot_plug_child;
     hp->unplug = spapr_phb_hot_unplug_child;
diff --git a/hw/vfio/amd-xgbe.c b/hw/vfio/amd-xgbe.c
index 2c60310cf9..fab196cebf 100644
--- a/hw/vfio/amd-xgbe.c
+++ b/hw/vfio/amd-xgbe.c
@@ -38,6 +38,8 @@ static void vfio_amd_xgbe_class_init(ObjectClass *klass, void *data)
     dc->realize = amd_xgbe_realize;
     dc->desc = "VFIO AMD XGBE";
     dc->vmsd = &vfio_platform_amd_xgbe_vmstate;
+    /* Supported by TYPE_VIRT_MACHINE */
+    dc->user_creatable = true;
 }
 
 static const TypeInfo vfio_amd_xgbe_dev_info = {
diff --git a/hw/vfio/calxeda-xgmac.c b/hw/vfio/calxeda-xgmac.c
index bb15d588e5..7bb17af7ad 100644
--- a/hw/vfio/calxeda-xgmac.c
+++ b/hw/vfio/calxeda-xgmac.c
@@ -38,6 +38,8 @@ static void vfio_calxeda_xgmac_class_init(ObjectClass *klass, void *data)
     dc->realize = calxeda_xgmac_realize;
     dc->desc = "VFIO Calxeda XGMAC";
     dc->vmsd = &vfio_platform_calxeda_xgmac_vmstate;
+    /* Supported by TYPE_VIRT_MACHINE */
+    dc->user_creatable = true;
 }
 
 static const TypeInfo vfio_calxeda_xgmac_dev_info = {
diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
index c85f1637e4..f29b2b027b 100644
--- a/hw/xen/xen_backend.c
+++ b/hw/xen/xen_backend.c
@@ -619,6 +619,8 @@ static void xendev_class_init(ObjectClass *klass, void *data)
 
     dc->props = xendev_properties;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    /* xen-backend devices can be plugged/unplugged dynamically */
+    dc->user_creatable = true;
 }
 
 static const TypeInfo xendev_type_info = {
-- 
2.11.0.259.g40922b1

-- 
Eduardo
