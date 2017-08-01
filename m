Received: from eggs.gnu.org ([2001:4830:134:3::10]:35927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dcerV-0001D4-3Y
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:37:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dcerU-0004nG-3c
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:37:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dcerT-0004mt-TX
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:37:56 -0400
Date: Wed, 2 Aug 2017 00:37:51 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1501623438-31419-8-git-send-email-mst@redhat.com>
References: <1501623438-31419-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501623438-31419-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 07/10] tests/bios-tables-test: Compiler warning
 fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

gcc 7.1.1 in fedora 26 moans about the:
   tables = g_new0(uint32_t, tables_nr)

because it can't convince itself that tables_nr is positive.
This is fallout from g_assert_cmpint no longer necessarily being
no-return;  replace it with a plain g_assert.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
---
 tests/bios-tables-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 63da978..564da45 100644
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
MST
