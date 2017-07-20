Received: from eggs.gnu.org ([2001:4830:134:3::10]:50836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dYEQT-00031y-IC
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:35:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dYEQS-0001DH-Eo
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:35:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dYEQS-0001Bp-7d
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:35:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3187CC1EAA15
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 16:35:43 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 20 Jul 2017 17:35:36 +0100
Message-Id: <20170720163536.26183-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH] tests/bios-tables-test: Compiler warning fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, berrange@redhat.com, mst@redhat.com, imammedo@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

gcc 7.1.1 in fedora 26 moans about the:
   tables = g_new0(uint32_t, tables_nr)

because it can't convince itself that tables_nr is positive.
This is fallout from g_assert_cmpint no longer necessarily being
no-return;  replace it with a plain g_assert.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/bios-tables-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 63da978f0b..564da45f65 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -108,7 +108,7 @@ static void test_acpi_rsdt_table(test_data *data)
     /* compute the table entries in rsdt */
     tables_nr = (rsdt_table->length - sizeof(AcpiRsdtDescriptorRev1)) /
                 sizeof(uint32_t);
-    g_assert_cmpint(tables_nr, >, 0);
+    g_assert(tables_nr > 0);
 
     /* get the addresses of the tables pointed by rsdt */
     tables = g_new0(uint32_t, tables_nr);
-- 
2.13.3
