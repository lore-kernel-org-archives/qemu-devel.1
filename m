Received: from eggs.gnu.org ([2001:4830:134:3::10]:41993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUwPH-0004It-SL
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 10:17:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUwPH-00062K-2F
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 10:17:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eUwPG-00061z-T2
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 10:17:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 22C9E2CE92B
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 15:17:10 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 29 Dec 2017 16:16:42 +0100
Message-Id: <1514560602-280058-6-git-send-email-imammedo@redhat.com>
In-Reply-To: <1514560602-280058-1-git-send-email-imammedo@redhat.com>
References: <1514560602-280058-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] tests: acpi: fix FADT not being compared
 to reference table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin " <mst@redhat.com>, Thomas Huth <thuth@redhat.com>

It turns out that FADT isn't actually tested for changes
against reference table, since it happens to be the 1st
table in RSDT which is currently ignored.
Fix it by making sure that all tables from RSDT are added
to test list.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/bios-tables-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 81c558e..c5dccdb 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -248,14 +248,14 @@ static void test_acpi_dsdt_table(test_data *data)
 /* Load all tables and add to test list directly RSDT referenced tables */
 static void fetch_rsdt_referenced_tables(test_data *data)
 {
-    int tables_nr = data->rsdt_tables_nr - 1; /* fadt is first */
+    int tables_nr = data->rsdt_tables_nr;
     int i;
 
     for (i = 0; i < tables_nr; i++) {
         AcpiSdtTable ssdt_table;
         uint32_t addr;
 
-        addr = le32_to_cpu(data->rsdt_tables_addr[i + 1]); /* fadt is first */
+        addr = le32_to_cpu(data->rsdt_tables_addr[i]);
         fetch_table(&ssdt_table, addr);
 
         /* Add table to ASL test tables list */
-- 
2.7.4
