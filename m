Received: from eggs.gnu.org ([2001:4830:134:3::10]:42925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1ceVHA-0000R5-EV
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 18:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1ceVH9-0000ub-4c
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 18:15:48 -0500
Received: from mail-pg0-x234.google.com ([2607:f8b0:400e:c05::234]:33437)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1ceVH8-0000tp-Vd
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 18:15:47 -0500
Received: by mail-pg0-x234.google.com with SMTP id y6so6221678pgy.0
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 15:15:46 -0800 (PST)
From: ben@skyportsystems.com
Date: Thu, 16 Feb 2017 15:15:35 -0800
Message-Id: <7c0c0ce878bdba95f08d3c7385e07ab2c654b9d7.1487286467.git.ben@skyportsystems.com>
In-Reply-To: <cover.1487286467.git.ben@skyportsystems.com>
References: <cover.1487286467.git.ben@skyportsystems.com>
In-Reply-To: <cover.1487286467.git.ben@skyportsystems.com>
References: <cover.1487286467.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v8 3/8] ACPI: Add vmgenid blob storage to the
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
Cc: lersek@redhat.com, mst@redhat.com, imammedo@redhat.com, Ben Warren <ben@skyportsystems.com>

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
---
 hw/acpi/aml-build.c         | 2 ++
 include/hw/acpi/aml-build.h | 1 +
 2 files changed, 3 insertions(+)

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
 
-- 
2.7.4
