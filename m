Received: from eggs.gnu.org ([2001:4830:134:3::10]:46727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dkRIn-0006hF-Vn
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:46:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dkRIk-0001vb-UK
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:46:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dkRIk-0001uz-OV
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:46:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BF9957E43E
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 08:39:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 23 Aug 2017 10:39:01 +0200
Message-Id: <20170823083901.852-3-quintela@redhat.com>
In-Reply-To: <20170823083901.852-1-quintela@redhat.com>
References: <20170823083901.852-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] tests: Make acpid test compile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, pbonzini@redhat.com

Compiler gets confused with the size of the struct, so move form
g_new0() to g_malloc0().

I *think* that the problem is in gcc (or glib for that matter), but
the documentation of the g_new0 states that 1sts first argument is an
struct type, and uint32_t is not an struct type.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/vmgenid-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
index 3d5c1c3615..032e1d465a 100644
--- a/tests/vmgenid-test.c
+++ b/tests/vmgenid-test.c
@@ -67,7 +67,7 @@ static uint32_t acpi_find_vgia(void)
     g_assert_cmpint(tables_nr, >, 0);
 
     /* get the addresses of the tables pointed by rsdt */
-    tables = g_new0(uint32_t, tables_nr);
+    tables = g_malloc0(sizeof(uint32_t) * tables_nr);
     ACPI_READ_ARRAY_PTR(tables, tables_nr, rsdt);
 
     for (i = 0; i < tables_nr; i++) {
-- 
2.13.5
