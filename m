Received: from eggs.gnu.org ([2001:4830:134:3::10]:44192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6I-0001T0-4l
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:20:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6G-00038E-ST
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:20:30 -0500
Received: from mail.kernel.org ([198.145.29.136]:51094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6G-00037N-N3
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:20:28 -0500
Date: Thu, 2 Mar 2017 08:20:24 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1488435591-17882-4-git-send-email-mst@redhat.com>
References: <1488435591-17882-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488435591-17882-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 03/15] ACPI: Add vmgenid blob storage to the
 build tables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ben Warren <ben@skyportsystems.com>, Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: Ben Warren <ben@skyportsystems.com>

This allows them to be centrally initialized and destroyed

The "AcpiBuildTables.vmgenid" array will be used to construct the
"etc/vmgenid_guid" fw_cfg blob.

Its contents will be linked into fw_cfg after being built on the
pc_machine_done() -> acpi_setup() -> acpi_build() call path, and dropped
without use on the subsequent, guest triggered, acpi_build_update() ->
acpi_build() call path.

Signed-off-by: Ben Warren <ben@skyportsystems.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/aml-build.h | 1 +
 hw/acpi/aml-build.c         | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 559326c..00c21f1 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -210,6 +210,7 @@ struct AcpiBuildTables {
     GArray *table_data;
     GArray *rsdp;
     GArray *tcpalog;
+    GArray *vmgenid;
     BIOSLinker *linker;
 } AcpiBuildTables;
 
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index b2a1e40..c6f2032 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1559,6 +1559,7 @@ void acpi_build_tables_init(AcpiBuildTables *tables)
     tables->rsdp = g_array_new(false, true /* clear */, 1);
     tables->table_data = g_array_new(false, true /* clear */, 1);
     tables->tcpalog = g_array_new(false, true /* clear */, 1);
+    tables->vmgenid = g_array_new(false, true /* clear */, 1);
     tables->linker = bios_linker_loader_init();
 }
 
@@ -1568,6 +1569,7 @@ void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre)
     g_array_free(tables->rsdp, true);
     g_array_free(tables->table_data, true);
     g_array_free(tables->tcpalog, mfre);
+    g_array_free(tables->vmgenid, mfre);
 }
 
 /* Build rsdt table */
-- 
MST
