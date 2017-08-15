Received: from eggs.gnu.org ([2001:4830:134:3::10]:42293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=393356efa=anthony.perard@citrix.com>)
	id 1dhZpF-0000fZ-9o
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 07:15:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=393356efa=anthony.perard@citrix.com>)
	id 1dhZpA-0005kI-VW
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 07:15:57 -0400
Received: from smtp.citrix.com ([66.165.176.89]:12209)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=393356efa=anthony.perard@citrix.com>)
	id 1dhZpA-0005ja-Ob
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 07:15:52 -0400
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Tue, 15 Aug 2017 12:15:49 +0100
Message-ID: <20170815111549.6232-3-anthony.perard@citrix.com>
In-Reply-To: <20170815111549.6232-1-anthony.perard@citrix.com>
References: <20170815111549.6232-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.10 v2 2/2] Revert "ACPI: don't call
 acpi_pcihp_device_plug_cb on xen"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Bruce Rogers <brogers@suse.com>, "Michael S.
	Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

This reverts commit 153eba4726dfa1bdfc31d1fe973b2a61b9035492.

This patch prevents PCI passthrough hotplug on Xen. Even if the Xen tool
stack prepares its own ACPI tables, we still rely on QEMU for hotplug
ACPI notifications.

The original issue is fixed by the previous patch (hw/acpi: Call
acpi_set_pci_info when no ACPI tables needed).

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
CC: Stefano Stabellini <sstabellini@kernel.org>
CC: Bruce Rogers <brogers@suse.com>
---
 hw/acpi/piix4.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index f276967365..f4fd5907b8 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -385,10 +385,7 @@ static void piix4_device_plug_cb(HotplugHandler *hotplug_dev,
                                 dev, errp);
         }
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
-        if (!xen_enabled()) {
-            acpi_pcihp_device_plug_cb(hotplug_dev, &s->acpi_pci_hotplug, dev,
-                                      errp);
-        }
+        acpi_pcihp_device_plug_cb(hotplug_dev, &s->acpi_pci_hotplug, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         if (s->cpu_hotplug_legacy) {
             legacy_acpi_cpu_plug_cb(hotplug_dev, &s->gpe_cpu, dev, errp);
@@ -411,10 +408,8 @@ static void piix4_device_unplug_request_cb(HotplugHandler *hotplug_dev,
         acpi_memory_unplug_request_cb(hotplug_dev, &s->acpi_memory_hotplug,
                                       dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
-        if (!xen_enabled()) {
-            acpi_pcihp_device_unplug_cb(hotplug_dev, &s->acpi_pci_hotplug, dev,
-                                        errp);
-        }
+        acpi_pcihp_device_unplug_cb(hotplug_dev, &s->acpi_pci_hotplug, dev,
+                                    errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
                !s->cpu_hotplug_legacy) {
         acpi_cpu_unplug_request_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
-- 
Anthony PERARD
