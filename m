Received: from eggs.gnu.org ([2001:4830:134:3::10]:34450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ciiX4-0000Fj-CP
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:13:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ciiX3-0005H1-Gu
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:13:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ciiX3-0005Ge-BO
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:13:37 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 84D3CC04BD3A
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 14:13:37 +0000 (UTC)
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Tue, 28 Feb 2017 16:13:29 +0200
Message-Id: <1488291209-29430-3-git-send-email-marcel@redhat.com>
In-Reply-To: <1488291209-29430-1-git-send-email-marcel@redhat.com>
References: <1488291209-29430-1-git-send-email-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH V4 2/2] hw/pxb-pcie: fix PCI Express hotplug
 support
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

Add the missing osc method for pxb-pcie devices as APCI spec recommends,
see 6.2.9.1 OSC Implementation Example for PCI Host Bridge Devices, ACPI 3.0a:

    It is recommended that a machine with multiple host bridge devices
    should report the same capabilities for all host bridges, and also
    negotiate control of the features described in the Control Field in
    the same way for all host bridges.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 dtc                  | 2 +-
 hw/i386/acpi-build.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/dtc b/dtc
index ec02b34..65cc4d2 160000
--- a/dtc
+++ b/dtc
@@ -1 +1 @@
-Subproject commit ec02b34c05be04f249ffaaca4b666f5246877dea
+Subproject commit 65cc4d2748a2c2e6f27f1cf39e07a5dbabd80ebf
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 1da6d9f..04029f6 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1961,6 +1961,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
             aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
             aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
+            if (pci_bus_is_express(bus)) {
+                aml_append(dev, build_q35_osc_method());
+            }
 
             if (numa_node != NUMA_NODE_UNASSIGNED) {
                 aml_append(dev, aml_name_decl("_PXM", aml_int(numa_node)));
-- 
2.5.5
