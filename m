Received: from eggs.gnu.org ([2001:4830:134:3::10]:43713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eFJ9b-00044D-Fk
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 07:20:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eFJ9X-0001WD-6s
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 07:20:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eFJ9W-0001V2-TA
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 07:20:19 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 16 Nov 2017 20:20:06 +0800
Message-Id: <1510834806-25666-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH] Revert "Add new PCI ID for i82559a"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com, mst@redhat.com, marcel@redhat.com, qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, Michael Nawrocki <michael.nawrocki@gtri.gatech.edu>, Peter Maydell <peter.maydell@linaro.org>

This reverts commit 5e89dc01133f8f5e621f6b66b356c6f37d31dafb since:

- we should use ID in the spec instead the one used by OEM
- in the future, we should allow changing id through either property
  or EEPROM file.

Cc: Stefan Weil <sw@weilnetz.de>
Cc: Michael Nawrocki <michael.nawrocki@gtri.gatech.edu>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/eepro100.c    | 13 -------------
 include/hw/compat.h  |  4 ----
 include/hw/pci/pci.h |  1 -
 qemu-options.hx      |  2 +-
 4 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index a63ed2c..91dd058 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -132,7 +132,6 @@ typedef struct {
     const char *name;
     const char *desc;
     uint16_t device_id;
-    uint16_t alt_device_id;
     uint8_t revision;
     uint16_t subsystem_vendor_id;
     uint16_t subsystem_id;
@@ -277,7 +276,6 @@ typedef struct {
     /* Quasi static device properties (no need to save them). */
     uint16_t stats_size;
     bool has_extended_tcb_support;
-    bool use_alt_device_id;
 } EEPRO100State;
 
 /* Word indices in EEPROM. */
@@ -1857,14 +1855,6 @@ static void e100_nic_realize(PCIDevice *pci_dev, Error **errp)
 
     TRACE(OTHER, logout("\n"));
 
-    /* By default, the i82559a adapter uses the legacy PCI ID (for the
-     * i82557). This allows the PCI ID to be changed to the alternate
-     * i82559 ID if needed.
-     */
-    if (s->use_alt_device_id && strcmp(info->name, "i82559a") == 0) {
-        pci_config_set_device_id(s->dev.config, info->alt_device_id);
-    }
-
     s->device = info->device;
 
     e100_pci_reset(s, &local_err);
@@ -1984,7 +1974,6 @@ static E100PCIDeviceInfo e100_devices[] = {
         .desc = "Intel i82559A Ethernet",
         .device = i82559A,
         .device_id = PCI_DEVICE_ID_INTEL_82557,
-        .alt_device_id = PCI_DEVICE_ID_INTEL_82559,
         .revision = 0x06,
         .stats_size = 80,
         .has_extended_tcb_support = true,
@@ -2078,8 +2067,6 @@ static E100PCIDeviceInfo *eepro100_get_class(EEPRO100State *s)
 
 static Property e100_properties[] = {
     DEFINE_NIC_PROPERTIES(EEPRO100State, conf),
-    DEFINE_PROP_BOOL("x-use-alt-device-id", EEPRO100State, use_alt_device_id,
-                     true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/compat.h b/include/hw/compat.h
index f96212c..cf389b4 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -10,10 +10,6 @@
         .driver   = "virtio-tablet-device",\
         .property = "wheel-axis",\
         .value    = "false",\
-    },{\
-        .driver   = "i82559a",\
-        .property = "x-use-alt-device-id",\
-        .value    = "false",\
     },
 
 #define HW_COMPAT_2_9 \
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index f30e2cf..8d02a0a 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -70,7 +70,6 @@ extern bool pci_available;
 /* Intel (0x8086) */
 #define PCI_DEVICE_ID_INTEL_82551IT      0x1209
 #define PCI_DEVICE_ID_INTEL_82557        0x1229
-#define PCI_DEVICE_ID_INTEL_82559        0x1030
 #define PCI_DEVICE_ID_INTEL_82801IR      0x2922
 
 /* Red Hat / Qumranet (for QEMU) -- see pci-ids.txt */
diff --git a/qemu-options.hx b/qemu-options.hx
index a39c7e4..3728e9b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2047,7 +2047,7 @@ that the card should have; this option currently only affects virtio cards; set
 @var{v} = 0 to disable MSI-X. If no @option{-net} option is specified, a single
 NIC is created.  QEMU can emulate several different models of network card.
 Valid values for @var{type} are
-@code{virtio}, @code{i82551}, @code{i82557b}, @code{i82559a}, @code{i82559er},
+@code{virtio}, @code{i82551}, @code{i82557b}, @code{i82559er},
 @code{ne2k_pci}, @code{ne2k_isa}, @code{pcnet}, @code{rtl8139},
 @code{e1000}, @code{smc91c111}, @code{lance} and @code{mcf_fec}.
 Not all devices are supported on all targets.  Use @code{-net nic,model=help}
-- 
2.7.4
