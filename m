Received: from eggs.gnu.org ([2001:4830:134:3::10]:58345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cZPVy-0005x5-Su
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 17:06:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cZPVu-0006qF-Tx
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 17:06:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:16645)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cZPVu-0006pw-Ns
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 17:05:58 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8AFB0C057FAD
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 22:05:58 +0000 (UTC)
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Fri,  3 Feb 2017 00:05:52 +0200
Message-Id: <1486073152-27152-1-git-send-email-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/pxb-pcie: fix PCI Express hotplug support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, marcel@redhat.com

Add the missing osc method for pxb-pcie devices

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---

Note: The patch is based on the fact that Q35's osc method is quite generic.

Thanks,
Marcel

 hw/i386/acpi-build.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 1c928ab..555aab3 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1964,6 +1964,11 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
             aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
             aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
+            if (pci_bus_is_express(bus)) {
+                aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
+                aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
+                aml_append(dev, build_q35_osc_method());
+            }
 
             if (numa_node != NUMA_NODE_UNASSIGNED) {
                 aml_append(dev, aml_name_decl("_PXM", aml_int(numa_node)));
-- 
2.5.5
