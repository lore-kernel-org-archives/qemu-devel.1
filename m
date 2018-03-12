Received: from eggs.gnu.org ([2001:4830:134:3::10]:44612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSIL-000835-Ke
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:35:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSIK-0005Ir-Go
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:35:37 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:43792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <x1917x@gmail.com>) id 1evSIK-0005Ic-90
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:35:36 -0400
Received: by mail-pg0-x241.google.com with SMTP id e9so6864016pgs.10
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 11:35:36 -0700 (PDT)
From: Alexey Gerasimenko <x1917x@gmail.com>
Date: Tue, 13 Mar 2018 04:34:01 +1000
Message-Id: <4a65e8b30fe9d2a6c1c53b85ef2697f02e01d13f.1520867956.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 16/30] q35/xen: Add Xen platform device
 support for Q35
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org
Cc: Alexey Gerasimenko <x1917x@gmail.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>

Current Xen/QEMU method to control Xen Platform device on i440 is a bit
odd -- enabling/disabling Xen platform device actually modifies the QEMU
emulated machine type, namely xenfv <--> pc.

In order to avoid multiplying machine types, use a new way to control Xen
Platform device for QEMU -- "xen-platform-dev" machine property (bool).
To maintain backward compatibility with existing Xen/QEMU setups, this
is only applicable to q35 machine currently. i440 emulation still uses the
old method (i.e. xenfv/pc machine selection) to control Xen Platform
device, this may be changed later to xen-platform-dev property as well.

This way we can use a single machine type (q35) and change just
xen-platform-dev value to on/off to control Xen platform device.

Signed-off-by: Alexey Gerasimenko <x1917x@gmail.com>
---
 hw/core/machine.c   | 21 +++++++++++++++++++++
 hw/i386/pc_q35.c    | 14 ++++++++++++++
 include/hw/boards.h |  1 +
 qemu-options.hx     |  1 +
 4 files changed, 37 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 5e2bbcdace..205e7da3ce 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -290,6 +290,20 @@ static void machine_set_igd_gfx_passthru(Object *obj, bool value, Error **errp)
     ms->igd_gfx_passthru = value;
 }
 
+static bool machine_get_xen_platform_dev(Object *obj, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    return ms->xen_platform_dev;
+}
+
+static void machine_set_xen_platform_dev(Object *obj, bool value, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    ms->xen_platform_dev = value;
+}
+
 static char *machine_get_firmware(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -595,6 +609,13 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "igd-passthru",
         "Set on/off to enable/disable igd passthrou", &error_abort);
 
+    object_class_property_add_bool(oc, "xen-platform-dev",
+        machine_get_xen_platform_dev,
+        machine_set_xen_platform_dev, &error_abort);
+    object_class_property_set_description(oc, "xen-platform-dev",
+        "Set on/off to enable/disable Xen Platform device",
+        &error_abort);
+
     object_class_property_add_str(oc, "firmware",
         machine_get_firmware, machine_set_firmware,
         &error_abort);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 0db670f6d7..62caf924cf 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -56,6 +56,18 @@
 /* ICH9 AHCI has 6 ports */
 #define MAX_SATA_PORTS     6
 
+static void q35_xen_hvm_init(MachineState *machine)
+{
+    PCMachineState *pcms = PC_MACHINE(machine);
+
+    if (xen_enabled()) {
+        /* check if Xen Platform device is enabled */
+        if (machine->xen_platform_dev) {
+            pci_create_simple(pcms->bus, -1, "xen-platform");
+        }
+    }
+}
+
 /* PC hardware initialisation */
 static void pc_q35_init(MachineState *machine)
 {
@@ -207,6 +219,8 @@ static void pc_q35_init(MachineState *machine)
     if (xen_enabled()) {
         pci_bus_irqs(host_bus, xen_cmn_set_irq, xen_cmn_pci_slot_get_pirq,
                      ich9_lpc, ICH9_XEN_NUM_IRQ_SOURCES);
+
+        q35_xen_hvm_init(machine);
     } else {
         pci_bus_irqs(host_bus, ich9_lpc_set_irq, ich9_lpc_map_irq, ich9_lpc,
                      ICH9_LPC_NB_PIRQS);
diff --git a/include/hw/boards.h b/include/hw/boards.h
index efb0a9edfd..f35fc1cc03 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -238,6 +238,7 @@ struct MachineState {
     bool usb;
     bool usb_disabled;
     bool igd_gfx_passthru;
+    bool xen_platform_dev;
     char *firmware;
     bool iommu;
     bool suppress_vmdesc;
diff --git a/qemu-options.hx b/qemu-options.hx
index 6585058c6c..cee0b92028 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -38,6 +38,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                dump-guest-core=on|off include guest memory in a core dump (default=on)\n"
     "                mem-merge=on|off controls memory merge support (default: on)\n"
     "                igd-passthru=on|off controls IGD GFX passthrough support (default=off)\n"
+    "                xen-platform-dev=on|off controls Xen Platform device (default=off)\n"
     "                aes-key-wrap=on|off controls support for AES key wrapping (default=on)\n"
     "                dea-key-wrap=on|off controls support for DEA key wrapping (default=on)\n"
     "                suppress-vmdesc=on|off disables self-describing migration (default=off)\n"
-- 
2.11.0
