Received: from eggs.gnu.org ([2001:4830:134:3::10]:56399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqJ1-0007eH-Ea
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqIw-00027P-RL
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:04:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dnqIw-00026t-ME
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:04:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C888E356F6
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 18:04:24 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri,  1 Sep 2017 13:03:37 -0500
Message-Id: <20170901180340.30009-27-eblake@redhat.com>
In-Reply-To: <20170901180340.30009-1-eblake@redhat.com>
References: <20170901180340.30009-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 26/29] fw_cfg-test: Drop dependence on
 global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com

As a general rule, we prefer avoiding implicit global state
because it makes code harder to safely copy and paste without
thinking about the global state.  It turns out that with the
recent changes to libqos, fw_cfg-test was not even using
global_qtest any more.  Avoid a pointless strdup while at it.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/fw_cfg-test.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
index 47596c57a1..3a8dc7a2cd 100644
--- a/tests/fw_cfg-test.c
+++ b/tests/fw_cfg-test.c
@@ -102,14 +102,11 @@ static void test_fw_cfg_boot_menu(void)
 int main(int argc, char **argv)
 {
     QTestState *s;
-    char *cmdline;
     int ret;

     g_test_init(&argc, &argv, NULL);

-    cmdline = g_strdup_printf("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8 ");
-    s = qtest_start(cmdline);
-    g_free(cmdline);
+    s = qtest_init("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8");

     fw_cfg = pc_fw_cfg_init(s);

-- 
2.13.5
