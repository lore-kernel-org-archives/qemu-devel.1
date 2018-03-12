Received: from eggs.gnu.org ([2001:4830:134:3::10]:44717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSIe-0008N6-Sj
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSId-0005Wu-BB
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:35:56 -0400
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231]:40930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <x1917x@gmail.com>) id 1evSId-0005W7-2G
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:35:55 -0400
Received: by mail-pg0-x231.google.com with SMTP id g8so6863328pgv.7
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 11:35:54 -0700 (PDT)
From: Alexey Gerasimenko <x1917x@gmail.com>
Date: Tue, 13 Mar 2018 04:34:06 +1000
Message-Id: <bc91bcb3b29bda26289019574cac4302eb7ca085.1520867956.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 21/30] xen/pt: Xen PCIe passthrough support
 for Q35: bypass PCIe topology check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org
Cc: Alexey Gerasimenko <x1917x@gmail.com>, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

Compared to legacy i440 system, there are certain difficulties while
passing through PCIe devices to guest OSes like Windows 7 and above
on platforms with native support of PCIe bus (in our case Q35). This
problem is not applicable to older OSes like Windows XP -- PCIe
passthrough on such OSes can be used normally as these OSes have
no support for PCIe-specific features and treat all PCIe devices as legacy
PCI ones.

The problem manifests itself as "Code 10" error for a passed thru PCIe
device in Windows Device Manager (along with exclamation mark on it). The
device with such error do not function no matter the fact that Windows
successfully booted while actually using this device, ex. as a primary VGA
card with VBE features, LFB, etc. working properly during boot time.
It doesn't matter which PCI class the device have -- the problem is common
to GPUs, NIC cards, USB controllers, etc. In the same time, all these
devices can be passed thru successfully using i440 emulation on same
Windows 7+ OSes.

The actual root cause of the problem lies in the fact that Windows kernel
(PnP manager particularly) while processing StartDevice IRP refuses
to continue to start the device and control flow actually doesn't even
reach the IRP handler in the device driver at all. The real reason for
this typically does not appear at the time PnP manager tries to start the
device, but happens much earlier -- during the Windows boot stage, while
enumerating devices on a PCI/PCIe bus in the Windows pci.sys driver. There
is a set of checks for every discovered device on the PCIe bus. Failing
some of them leads to marking the discovered PCIe device as 'invalid'
by setting the flag. Later on, StartDevice attempt will fail due to this
flag, finally resulting in Code 10 error.

The actual check in pci.sys which results in the PCIe device being marked
as 'invalid' in our case is a validation of upstream PCIe bus hierarchy
to which passed through device belongs. Basically, pci.sys checks if the
PCIe device has parent devices, such as PCIe Root Port or upstream PCIe
switch. In our case the PCIe device has no parents and resides on bus
0 without eg. corresponding Root Port.

Therefore, in order to resolve this problem in a architecturally correct
way, we need to introduce to Xen some support of at least trivial non-flat
PCI bus hierarchy. In very simplest case - just one virtual Root Port,
on secondary bus of which all physical functions of the real passed thru
device will reside, eg. GPU and its HDAudio function.

This solution is not hard to implement technically, but there are multiple
affecting limitations present in Xen (many related to each other)
currently:

- in many places the code is limited to use bus 0 only. This applicable
  to both hypervisor and supplemental modules like hvmloader. This
  limitation is enforced on API level -- many functions and interfaces
  allow to specify only devfn argument while bus 0 being implied.

- lot of code assumes Type0 PCI config space layout only, while we need
  to handle Type1 PCI devices as well

- currently there no way to assign to a guest domain even a simplest
  linked hierarchy of passed thru PCI devices. In some cases we might need
  to passthrough a real PCIe Switch/Root Port with his downstream child
  devices.

- in a similar way Xen/hvmloader lacks the concept of IO/MMIO space
  nesting. Both code which does MMIO hole sizing and code which allocates
  BARs to MMIO hole have no idea of MMIO ranges nesting and their relations.
  In case of virtual Root Port we have basically an emulated PCI-PCI bridge
  with some parts of its MMIO range used for real MMIO ranges of passed
  through device(s).

So, adding to Xen multiple PCI buses support will require a bit of effort
and discussions regarding the actual design of the feature.  Nevertheless,
this task is crucial for PCI/GPU passthrough features of Xen to work
properly.

To summarize, we need to implement following things in the future:
1) Get rid of PCI bus 0 limitation everywhere. This could've been
  a simplest of subtasks but in reality this will require to change
  interfaces as well - AFAIR even adding a PCI device via QMP only allows
  to specify a device slot while we need to have some way to place the
  device on an arbitrary bus.

2) Fully or partially emulated PCI-PCI bridge which will provide
  a secondary bus for PCIe device placement - there might be a possibility
  to reuse some existing emulation QEMU provides. This also includes Type1
  devices support.
  The task will become more complicated if there arise necessity, for
  example, to control the PCIe link for a passed through PCIe device. As PT
  device reset is mandatory in most cases, there might be a chance
  to encounter a situation when we need to retrain the PCIe link to restore
  PCIe link speed after the reset. In this case there will be a need
  to selectively translate accesses to certain registers of emulated PCIe
  Switch/Root Port to the corresponding physical upstream PCIe
  Switch/RootPort. This will require some interaction with Dom0, hopefully
  extending xen-pciback will be enough.

3) The concept of I/O and MMIO ranges nesting, for tasks like sizing MMIO
  hole or PCI BAR allocation. This one should be pretty simple.

The actual implementation still is a matter to discuss of course.

In the meantime there can be used a very simple workaround which allows
to bypass pci.sys limitation for PCIe topology check - there exist one
good exception to "must have upstream PCIe parent" rule of pci.sys. It's
chipset-integrated devices. How pci.sys can tell if it deals with
a chipset built-in device? It checks one of PCI Express Capability fields
in the device PCI conf space. For chipset built-in devices this field will
state "root complex integrated device" while in our  case for a normal
passed thru PCIe device there will be a "PCIe endpoint" type. So that's
what the workaround does - it intercepts reading of this particular field
for passed through devices and returns the "root complex integrated
device" value for PCIe endpoints. This makes pci.sys happy and allows
Windows 7 and above to use PT device on PCIe-capable system normally.
So far no negative side effects were encountered while using this
approach, so it's a good temporary solution until multiple PCI bus support
will be added to Xen.

Signed-off-by: Alexey Gerasimenko <x1917x@gmail.com>
---
 hw/xen/xen_pt_config_init.c | 60 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index 02e8c97f3c..91de215407 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -902,6 +902,55 @@ static int xen_pt_linkctrl2_reg_init(XenPCIPassthroughState *s,
     *data = reg_field;
     return 0;
 }
+/* initialize PCI Express Capabilities register */
+static int xen_pt_pcie_capabilities_reg_init(XenPCIPassthroughState *s,
+                                             XenPTRegInfo *reg,
+                                             uint32_t real_offset,
+                                             uint32_t *data)
+{
+    uint8_t dev_type = get_pcie_device_type(s);
+    uint16_t reg_field;
+
+    if (xen_host_pci_get_word(&s->real_device,
+                             real_offset - reg->offset + PCI_EXP_FLAGS,
+                             &reg_field)) {
+        XEN_PT_ERR(&s->dev, "Error reading PCIe Capabilities reg\n");
+        *data = 0;
+        return 0;
+    }
+
+    /*
+     * Q35 workaround for Win7+ pci.sys PCIe topology check.
+     * As our PT device currently located on a bus 0, fake the
+     * device/port type field to the "Root Complex integrated device"
+     * value to bypass the check
+     */
+    switch (dev_type) {
+    case PCI_EXP_TYPE_ENDPOINT:
+    case PCI_EXP_TYPE_LEG_END:
+        XEN_PT_LOG(&s->dev, "Original PCIe Capabilities reg is 0x%04X\n",
+            reg_field);
+        reg_field &= ~PCI_EXP_FLAGS_TYPE;
+        reg_field |= ((PCI_EXP_TYPE_RC_END /*9*/ << 4) & PCI_EXP_FLAGS_TYPE);
+        XEN_PT_LOG(&s->dev, "Q35 PCIe topology check workaround: "
+                   "faking Capabilities reg to 0x%04X\n", reg_field);
+        break;
+
+    case PCI_EXP_TYPE_ROOT_PORT:
+    case PCI_EXP_TYPE_UPSTREAM:
+    case PCI_EXP_TYPE_DOWNSTREAM:
+    case PCI_EXP_TYPE_PCI_BRIDGE:
+    case PCI_EXP_TYPE_PCIE_BRIDGE:
+    case PCI_EXP_TYPE_RC_END:
+    case PCI_EXP_TYPE_RC_EC:
+    default:
+        /* do nothing, return as is */
+        break;
+    }
+
+    *data = reg_field;
+    return 0;
+}
 
 /* PCI Express Capability Structure reg static information table */
 static XenPTRegInfo xen_pt_emu_reg_pcie[] = {
@@ -916,6 +965,17 @@ static XenPTRegInfo xen_pt_emu_reg_pcie[] = {
         .u.b.read   = xen_pt_byte_reg_read,
         .u.b.write  = xen_pt_byte_reg_write,
     },
+    /* PCI Express Capabilities Register */
+    {
+        .offset     = PCI_EXP_FLAGS,
+        .size       = 2,
+        .init_val   = 0x0000,
+        .ro_mask    = 0xFFFF,
+        .emu_mask   = 0xFFFF,
+        .init       = xen_pt_pcie_capabilities_reg_init,
+        .u.w.read   = xen_pt_word_reg_read,
+        .u.w.write  = xen_pt_word_reg_write,
+    },
     /* Device Capabilities reg */
     {
         .offset     = PCI_EXP_DEVCAP,
-- 
2.11.0
