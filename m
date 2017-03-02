Received: from eggs.gnu.org ([2001:4830:134:3::10]:44510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6n-0001vT-N9
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:21:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6m-0004HZ-Qn
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:21:01 -0500
Received: from mail.kernel.org ([198.145.29.136]:51450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6m-0004H8-Kw
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:21:00 -0500
Date: Thu, 2 Mar 2017 08:20:56 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1488435591-17882-16-git-send-email-mst@redhat.com>
References: <1488435591-17882-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488435591-17882-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 15/15] hw/pxb-pcie: fix PCI Express hotplug
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Marcel Apfelbaum <marcel@redhat.com>

Add the missing osc method for pxb-pcie devices as APCI spec recommends,
see 6.2.9.1 OSC Implementation Example for PCI Host Bridge Devices, ACPI 3.0a:

    It is recommended that a machine with multiple host bridge devices
    should report the same capabilities for all host bridges, and also
    negotiate control of the features described in the Control Field in
    the same way for all host bridges.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c | 3 +++
 dtc                  | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index efbbfcb..8018f05 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1962,6 +1962,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
             aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
             aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
+            if (pci_bus_is_express(bus)) {
+                aml_append(dev, build_q35_osc_method());
+            }
 
             if (numa_node != NUMA_NODE_UNASSIGNED) {
                 aml_append(dev, aml_name_decl("_PXM", aml_int(numa_node)));
diff --git a/dtc b/dtc
index ec02b34..65cc4d2 160000
--- a/dtc
+++ b/dtc
@@ -1 +1 @@
-Subproject commit ec02b34c05be04f249ffaaca4b666f5246877dea
+Subproject commit 65cc4d2748a2c2e6f27f1cf39e07a5dbabd80ebf
-- 
MST
