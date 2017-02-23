Received: from eggs.gnu.org ([2001:4830:134:3::10]:60916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cgs9K-0007j4-S6
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:05:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cgs3P-0006a5-Gi
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:59:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cgs3P-0006Zq-8h
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:59:23 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3521C61BB4
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 11:59:23 +0000 (UTC)
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Thu, 23 Feb 2017 13:59:17 +0200
Message-Id: <1487851157-9354-1-git-send-email-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH V2] hw/pxb-pcie: fix PCI Express hotplug support
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
see 6.2.10.3 OSC Implementation Example for PCI Host Bridge Devices, ACPI 5.0:

    It is recommended that a machine with multiple host bridge devices
    should report the same capabilities for all host bridges, and also
    negotiate control of the features described in the Control Field in
    the same way for all host bridges.

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---

Note to maintainer:
 Please update ACPI test files.

V1 -> V2:
    Addressed Michael S. Tsirkin's comments:
      - Added documentation to q35 osc function
      - Made _osc serialized. I did not add compat property
        since it seems guest OSs do not care anyway about the OSC
        being serialized.
      - Kept the SUPP field even if is not used and also
        left both SUPP and CTRL out of the _osc because all
        systems I checked and the ACPI spec keep them that way,
        maybe is some kind of documentation contract.

Thanks,
Marcel


 hw/i386/acpi-build.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 1c928ab..dca4609 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1796,7 +1796,7 @@ static void build_piix4_pci_hotplug(Aml *table)
     aml_append(table, scope);
 }
 
-static Aml *build_q35_osc_method(void)
+static void build_q35_osc_method(Aml *dev)
 {
     Aml *if_ctx;
     Aml *if_ctx2;
@@ -1805,7 +1805,35 @@ static Aml *build_q35_osc_method(void)
     Aml *a_cwd1 = aml_name("CDW1");
     Aml *a_ctrl = aml_name("CTRL");
 
-    method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
+    /*
+     * Bits defined in the Support Field provide information
+     * regarding OS supported features.
+     *
+     * This field is not actually used and can be removed,
+     * however it appears even if unused on most DSDTs.
+     *
+     * See:
+     *     Table 6-148 Interpretation of _OSC Support Field,
+     *     Passed in via Arg2, APCI 5.0
+     */
+    aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
+
+    /*
+     * Bits defined in the Control Field are used to submit
+     * request by the OS for control/handling of the associated feature
+     *
+     * See: Table 6-149 Interpretation of _OSC Control Field,
+     *      Passed in via Arg3, ACPI 5.0
+     *      Table 6-150 Interpretation of _OSC Control Field,
+     *      Returned Value, APCI 5.0
+     */
+    aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
+
+
+   /*
+    * 6.2.10 _OSC (Operating System Capabilities), APCI 5.0
+    */
+    method = aml_method("_OSC", 4, AML_SERIALIZED);
     aml_append(method, aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
 
     if_ctx = aml_if(aml_equal(
@@ -1842,7 +1870,7 @@ static Aml *build_q35_osc_method(void)
     aml_append(method, else_ctx);
 
     aml_append(method, aml_return(aml_arg(3)));
-    return method;
+    aml_append(dev, method);
 }
 
 static void
@@ -1898,9 +1926,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
         aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
         aml_append(dev, aml_name_decl("_UID", aml_int(1)));
-        aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
-        aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
-        aml_append(dev, build_q35_osc_method());
+        build_q35_osc_method(dev);
         aml_append(sb_scope, dev);
         aml_append(dsdt, sb_scope);
 
@@ -1964,6 +1990,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
             aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
             aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
+            if (pci_bus_is_express(bus)) {
+                build_q35_osc_method(dev);
+            }
 
             if (numa_node != NUMA_NODE_UNASSIGNED) {
                 aml_append(dev, aml_name_decl("_PXM", aml_int(numa_node)));
-- 
2.5.5
