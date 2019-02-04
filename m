Received: from eggs.gnu.org ([209.51.188.92]:45802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfaU-00066J-KJ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:51:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfTa-0005gU-JS
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:43:59 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:39294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gqfTa-0005gJ-BZ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:43:58 -0500
Received: by mail-qt1-f176.google.com with SMTP id u47so88911qtj.6
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 06:43:58 -0800 (PST)
Date: Mon, 4 Feb 2019 09:43:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190204142638.27021-20-mst@redhat.com>
References: <20190204142638.27021-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204142638.27021-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 19/25] acpi: Make TPM 2.0 with TIS available as
 MSFT0101
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Berger <stefanb@linux.ibm.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Stefan Berger <stefanb@linux.ibm.com>

This patch makes the a TPM 2.0 with TIS interface available under the
HID 'MSF0101'. This is supported by Linux and also Windows now
recognizes the TPM 2.0 with TIS interface. Leave the TPM 1.2 as before.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/acpi-build.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index d60603abd7..26cef4af2d 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2141,8 +2141,16 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
 
             if (TPM_IS_TIS(tpm)) {
-                dev = aml_device("ISA.TPM");
-                aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C31")));
+                if (misc->tpm_version == TPM_VERSION_2_0) {
+                    dev = aml_device("TPM");
+                    aml_append(dev, aml_name_decl("_HID",
+                                                  aml_string("MSFT0101")));
+                } else {
+                    dev = aml_device("ISA.TPM");
+                    aml_append(dev, aml_name_decl("_HID",
+                                                  aml_eisaid("PNP0C31")));
+                }
+
                 aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
                 crs = aml_resource_template();
                 aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
-- 
MST
