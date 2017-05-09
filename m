Received: from eggs.gnu.org ([2001:4830:134:3::10]:54731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d84zc-0002O3-6A
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d84zb-0003Sf-BX
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:15:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1d84zb-0003SW-4n
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:15:55 -0400
Date: Tue, 9 May 2017 16:15:47 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1494330527-24163-9-git-send-email-mst@redhat.com>
References: <1494330527-24163-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1494330527-24163-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 8/8] ACPI: don't call acpi_pcihp_device_plug_cb
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Bruce Rogers <brogers@suse.com>, Igor Mammedov <imammedo@redhat.com>

From: Bruce Rogers <brogers@suse.com>

Commit f0c9d64a exposed the issue that with a xenfv machine using
pci passthrough, acpi pci hotplug code was being executed by mistake.
Guard calls to acpi_pcihp_device_plug_cb (and corresponding
acpi_pcihp_device_unplug_cb) with a check for xen_enabled(). Without
this check I am seeing an error that the bus doesn't have the
acpi-pcihp-bsel property set.

Signed-off-by: Bruce Rogers <brogers@suse.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST
