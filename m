Received: from eggs.gnu.org ([2001:4830:134:3::10]:36051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fcg63-00018H-6u
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fcg62-0001of-Db
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:01:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55024 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fcg62-0001oR-8I
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:01:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BABD140122D5
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 00:01:33 +0000 (UTC)
Date: Tue, 10 Jul 2018 03:01:33 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180710000024.542612-6-mst@redhat.com>
References: <20180710000024.542612-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710000024.542612-1-mst@redhat.com>
Subject: [Qemu-devel] [PATCH hack dontapply v2 5/7] acpi: init header
 without linking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com

build_header inits the table header and then adds it to list
for checksumming and linking into XSDT.

Dynamically loaded SSDTs are not linked into XSDT so
they just need the header initialized.
Split out the relevant part of build_header so it can
be invoked externally for this purpose.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/aml-build.h |  3 +++
 hw/acpi/aml-build.c         | 18 +++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index f764f71e25..0371a96c46 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -389,6 +389,9 @@ void
 build_header(BIOSLinker *linker, GArray *table_data,
              AcpiTableHeader *h, const char *sig, int len, uint8_t rev,
              const char *oem_id, const char *oem_table_id);
+void
+acpi_init_header(AcpiTableHeader *h, const char *sig, int len, uint8_t rev,
+                 const char *oem_id, const char *oem_table_id);
 void *acpi_data_push(GArray *table_data, unsigned size);
 unsigned acpi_data_len(GArray *table);
 void acpi_add_table(GArray *table_offsets, GArray *table_data);
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index ce691c1618..02f9710caa 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1574,12 +1574,9 @@ Aml *aml_unload(Aml *ddbhandle)
 }
 
 void
-build_header(BIOSLinker *linker, GArray *table_data,
-             AcpiTableHeader *h, const char *sig, int len, uint8_t rev,
-             const char *oem_id, const char *oem_table_id)
+acpi_init_header(AcpiTableHeader *h, const char *sig, int len, uint8_t rev,
+                 const char *oem_id, const char *oem_table_id)
 {
-    unsigned tbl_offset = (char *)h - table_data->data;
-    unsigned checksum_offset = (char *)&h->checksum - table_data->data;
     memcpy(&h->signature, sig, 4);
     h->length = cpu_to_le32(len);
     h->revision = rev;
@@ -1600,6 +1597,17 @@ build_header(BIOSLinker *linker, GArray *table_data,
     h->oem_revision = cpu_to_le32(1);
     memcpy(h->asl_compiler_id, ACPI_BUILD_APPNAME4, 4);
     h->asl_compiler_revision = cpu_to_le32(1);
+}
+
+void
+build_header(BIOSLinker *linker, GArray *table_data,
+             AcpiTableHeader *h, const char *sig, int len, uint8_t rev,
+             const char *oem_id, const char *oem_table_id)
+{
+    unsigned tbl_offset = (char *)h - table_data->data;
+    unsigned checksum_offset = (char *)&h->checksum - table_data->data;
+
+    acpi_init_header(h, sig, len, rev, oem_id, oem_table_id);
     /* Checksum to be filled in by Guest linker */
     bios_linker_loader_add_checksum(linker, ACPI_BUILD_TABLE_FILE,
         tbl_offset, len, checksum_offset);
-- 
MST
