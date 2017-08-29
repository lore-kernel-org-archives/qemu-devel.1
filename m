Received: from eggs.gnu.org ([2001:4830:134:3::10]:47342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUC6-0000r2-GK
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUC2-00053w-3p
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUC1-000535-Rt
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:46 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0EDJ6090293
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:15:45 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmvyehjxw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:15:44 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 20:15:43 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:13:46 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-12-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 11/79] ACPI: don't call
 acpi_pcihp_device_plug_cb on xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bruce Rogers <brogers@suse.com>, "Michael S . Tsirkin" <mst@redhat.com>

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
(cherry picked from commit 153eba4726dfa1bdfc31d1fe973b2a61b9035492)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
2.7.4
