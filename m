Received: from eggs.gnu.org ([2001:4830:134:3::10]:45215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dLtVM-0002nM-Gs
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:49:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dLtVK-0002nZ-Uq
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:49:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dLtVK-0002n3-KM
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:49:46 -0400
Date: Fri, 16 Jun 2017 18:49:42 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1497628168-30489-2-git-send-email-mst@redhat.com>
References: <1497628168-30489-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497628168-30489-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 1/7] q35/mch: implement extended TSEG sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Laszlo Ersek <lersek@redhat.com>

The q35 machine type currently lets the guest firmware select a 1MB, 2MB
or 8MB TSEG (basically, SMRAM) size. In edk2/OVMF, we use 8MB, but even
that is not enough when a lot of VCPUs (more than approx. 224) are
configured -- SMRAM footprint scales largely proportionally with VCPU
count.

Introduce a new property for "mch" called "extended-tseg-mbytes", which
expresses (in megabytes) the user's choice of TSEG (SMRAM) size.

Invent a new, QEMU-specific register in the config space of the DRAM
Controller, at offset 0x50, in order to allow guest firmware to query the
TSEG (SMRAM) size.

According to Intel Document Number 316966-002, Table 5-1 "DRAM Controller
Register Address Map (D0:F0)":

    Warning: Address locations that are not listed are considered Intel
             Reserved registers locations. Reads to Reserved registers may
             return non-zero values. Writes to reserved locations may
             cause system failures.

             All registers that are defined in the PCI 2.3 specification,
             but are not necessary or implemented in this component are
             simply not included in this document. The
             reserved/unimplemented space in the PCI configuration header
             space is not documented as such in this summary.

Offsets 0x50 and 0x51 are not listed in Table 5-1. They are also not part
of the standard PCI config space header. And they precede the capability
list as well, which starts at 0xe0 for this device.

When the guest writes value 0xffff to this register, the value that can be
read back is that of "mch.extended-tseg-mbytes" -- unless it remains
0xffff. The guest is required to write 0xffff first (as opposed to a
read-only register) because PCI config space is generally not cleared on
QEMU reset, and after S3 resume or reboot, new guest firmware running on
old QEMU could read a guest OS-injected value from this register.

After reading the available "extended" TSEG size, the guest firmware may
actually request that TSEG size by writing pattern 11b to the ESMRAMC
register's TSEG_SZ bit-field. (The Intel spec referenced above defines
only patterns 00b (1MB), 01b (2MB) and 10b (8MB); 11b is reserved.)

On the QEMU command line, the value can be set with

  -global mch.extended-tseg-mbytes=N

The default value for 2.10+ q35 machine types is 16. The value is limited
to 0xfff (4095) at the moment, purely so that the product (4095 MB) can be
stored to the uint32_t variable "tseg_size" in mch_update_smram(). Users
are responsible for choosing sensible TSEG sizes.

On 2.9 and earlier q35 machine types, the default value is 0. This lets
the 11b bit pattern in ESMRAMC.TSEG_SZ, and the register at offset 0x50,
keep their original behavior.

When "extended-tseg-mbytes" is nonzero, the new register at offset 0x50 is
set to that value on reset, for completeness.

PCI config space is migrated automatically, so no VMSD changes are
necessary.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Ref: https://bugzilla.redhat.com/show_bug.cgi?id=1447027
Ref: https://lists.01.org/pipermail/edk2-devel/2017-May/010456.html
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/pc.h      |  5 +++++
 include/hw/pci-host/q35.h |  6 ++++++
 hw/pci-host/q35.c         | 41 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d071c9c..233216a 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -384,6 +384,11 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
 #define PC_COMPAT_2_9 \
     HW_COMPAT_2_9 \
+    {\
+        .driver   = "mch",\
+        .property = "extended-tseg-mbytes",\
+        .value    = stringify(0),\
+    },\
 
 #define PC_COMPAT_2_8 \
     HW_COMPAT_2_8 \
diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
index 53b6760..58983c0 100644
--- a/include/hw/pci-host/q35.h
+++ b/include/hw/pci-host/q35.h
@@ -60,6 +60,7 @@ typedef struct MCHPCIState {
     uint64_t above_4g_mem_size;
     uint64_t pci_hole64_size;
     uint32_t short_root_bus;
+    uint16_t ext_tseg_mbytes;
 } MCHPCIState;
 
 typedef struct Q35PCIHost {
@@ -91,6 +92,11 @@ typedef struct Q35PCIHost {
 /* D0:F0 configuration space */
 #define MCH_HOST_BRIDGE_REVISION_DEFAULT       0x0
 
+#define MCH_HOST_BRIDGE_EXT_TSEG_MBYTES        0x50
+#define MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_SIZE   2
+#define MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_QUERY  0xffff
+#define MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_MAX    0xfff
+
 #define MCH_HOST_BRIDGE_PCIEXBAR               0x60    /* 64bit register */
 #define MCH_HOST_BRIDGE_PCIEXBAR_SIZE          8       /* 64bit register */
 #define MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT       0xb0000000
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index cd5c496..28cb97b 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -134,7 +134,7 @@ static void q35_host_get_mmcfg_size(Object *obj, Visitor *v, const char *name,
     visit_type_uint32(v, name, &value, errp);
 }
 
-static Property mch_props[] = {
+static Property q35_host_props[] = {
     DEFINE_PROP_UINT64(PCIE_HOST_MCFG_BASE, Q35PCIHost, parent_obj.base_addr,
                         MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT),
     DEFINE_PROP_SIZE(PCI_HOST_PROP_PCI_HOLE64_SIZE, Q35PCIHost,
@@ -154,7 +154,7 @@ static void q35_host_class_init(ObjectClass *klass, void *data)
 
     hc->root_bus_path = q35_host_root_bus_path;
     dc->realize = q35_host_realize;
-    dc->props = mch_props;
+    dc->props = q35_host_props;
     /* Reason: needs to be wired up by pc_q35_init */
     dc->user_creatable = false;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
@@ -369,7 +369,7 @@ static void mch_update_smram(MCHPCIState *mch)
             tseg_size = 1024 * 1024 * 8;
             break;
         default:
-            tseg_size = 0;
+            tseg_size = 1024 * 1024 * (uint32_t)mch->ext_tseg_mbytes;
             break;
         }
     } else {
@@ -392,6 +392,17 @@ static void mch_update_smram(MCHPCIState *mch)
     memory_region_transaction_commit();
 }
 
+static void mch_update_ext_tseg_mbytes(MCHPCIState *mch)
+{
+    PCIDevice *pd = PCI_DEVICE(mch);
+    uint8_t *reg = pd->config + MCH_HOST_BRIDGE_EXT_TSEG_MBYTES;
+
+    if (mch->ext_tseg_mbytes > 0 &&
+        pci_get_word(reg) == MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_QUERY) {
+        pci_set_word(reg, mch->ext_tseg_mbytes);
+    }
+}
+
 static void mch_write_config(PCIDevice *d,
                               uint32_t address, uint32_t val, int len)
 {
@@ -413,6 +424,11 @@ static void mch_write_config(PCIDevice *d,
                        MCH_HOST_BRIDGE_SMRAM_SIZE)) {
         mch_update_smram(mch);
     }
+
+    if (ranges_overlap(address, len, MCH_HOST_BRIDGE_EXT_TSEG_MBYTES,
+                       MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_SIZE)) {
+        mch_update_ext_tseg_mbytes(mch);
+    }
 }
 
 static void mch_update(MCHPCIState *mch)
@@ -420,6 +436,7 @@ static void mch_update(MCHPCIState *mch)
     mch_update_pciexbar(mch);
     mch_update_pam(mch);
     mch_update_smram(mch);
+    mch_update_ext_tseg_mbytes(mch);
 }
 
 static int mch_post_load(void *opaque, int version_id)
@@ -457,6 +474,11 @@ static void mch_reset(DeviceState *qdev)
     d->wmask[MCH_HOST_BRIDGE_SMRAM] = MCH_HOST_BRIDGE_SMRAM_WMASK;
     d->wmask[MCH_HOST_BRIDGE_ESMRAMC] = MCH_HOST_BRIDGE_ESMRAMC_WMASK;
 
+    if (mch->ext_tseg_mbytes > 0) {
+        pci_set_word(d->config + MCH_HOST_BRIDGE_EXT_TSEG_MBYTES,
+                     MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_QUERY);
+    }
+
     mch_update(mch);
 }
 
@@ -465,6 +487,12 @@ static void mch_realize(PCIDevice *d, Error **errp)
     int i;
     MCHPCIState *mch = MCH_PCI_DEVICE(d);
 
+    if (mch->ext_tseg_mbytes > MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_MAX) {
+        error_setg(errp, "invalid extended-tseg-mbytes value: %" PRIu16,
+                   mch->ext_tseg_mbytes);
+        return;
+    }
+
     /* setup pci memory mapping */
     pc_pci_as_mapping_init(OBJECT(mch), mch->system_memory,
                            mch->pci_address_space);
@@ -530,6 +558,12 @@ uint64_t mch_mcfg_base(void)
     return MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT;
 }
 
+static Property mch_props[] = {
+    DEFINE_PROP_UINT16("extended-tseg-mbytes", MCHPCIState, ext_tseg_mbytes,
+                       16),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void mch_class_init(ObjectClass *klass, void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -538,6 +572,7 @@ static void mch_class_init(ObjectClass *klass, void *data)
     k->realize = mch_realize;
     k->config_write = mch_write_config;
     dc->reset = mch_reset;
+    dc->props = mch_props;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->desc = "Host bridge";
     dc->vmsd = &vmstate_mch;
-- 
MST
