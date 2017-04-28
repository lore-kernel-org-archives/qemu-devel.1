Received: from eggs.gnu.org ([2001:4830:134:3::10]:33936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1d44WK-000492-5c
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 07:57:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1d44WH-0000Wt-4G
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 07:57:08 -0400
From: Bruce Rogers <brogers@suse.com>
Date: Fri, 28 Apr 2017 05:57:06 -0600
Message-Id: <1493380626-10883-1-git-send-email-brogers@suse.com>
Subject: [Qemu-devel] [PATCH v2] ACPI: don't call acpi_pcihp_device_plug_cb
 on xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, sstabellini@kernel.org, mst@redhat.com, qemu-stable@nongnu.org, Bruce Rogers <brogers@suse.com>

Commit f0c9d64a exposed the issue that with a xenfv machine using
pci passthrough, acpi pci hotplug code was being executed by mistake.
Guard calls to acpi_pcihp_device_plug_cb (and corresponding
acpi_pcihp_device_unplug_cb) with a check for xen_enabled(). Without
this check I am seeing the following error report: "Unsupported bus.
Bus doesn't have property 'acpi-pcihp-bsel' set".

Signed-off-by: Bruce Rogers <brogers@suse.com>
---
 hw/acpi/piix4.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index a553a7e..c409374 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -385,7 +385,10 @@ static void piix4_device_plug_cb(HotplugHandler *hotplug_dev,
                                 dev, errp);
         }
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
-        acpi_pcihp_device_plug_cb(hotplug_dev, &s->acpi_pci_hotplug, dev, errp);
+        if (!xen_enabled()) {
+            acpi_pcihp_device_plug_cb(hotplug_dev, &s->acpi_pci_hotplug, dev,
+                                      errp);
+        }
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         if (s->cpu_hotplug_legacy) {
             legacy_acpi_cpu_plug_cb(hotplug_dev, &s->gpe_cpu, dev, errp);
@@ -408,8 +411,10 @@ static void piix4_device_unplug_request_cb(HotplugHandler *hotplug_dev,
         acpi_memory_unplug_request_cb(hotplug_dev, &s->acpi_memory_hotplug,
                                       dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
-        acpi_pcihp_device_unplug_cb(hotplug_dev, &s->acpi_pci_hotplug, dev,
-                                    errp);
+        if (!xen_enabled()) {
+            acpi_pcihp_device_unplug_cb(hotplug_dev, &s->acpi_pci_hotplug, dev,
+                                        errp);
+        }
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
                !s->cpu_hotplug_legacy) {
         acpi_cpu_unplug_request_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
-- 
1.9.0
