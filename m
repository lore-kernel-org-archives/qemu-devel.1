Received: from eggs.gnu.org ([2001:4830:134:3::10]:48321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYYN2-0007g1-Tu
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYYN0-00044x-59
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:53:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dYYMz-00044K-V1
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:53:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DCA35272BC
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 13:53:28 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 21 Jul 2017 15:53:20 +0200
Message-Id: <1500645206-13559-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1500645206-13559-1-git-send-email-armbru@redhat.com>
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 3/9] tests: Pass literal format strings
 directly to qmp_FOO()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The qmp_FOO() take a printf-like format string.  In a few places, we
assign a string literal to a variable and pass that instead of simply
passing the literal.  Clean that up.

Bonus: gets rid of non-literal format strings.  A step towards
compile-time format string checking without triggering
-Wformat-nonliteral.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/ahci-test.c | 4 +---
 tests/ide-test.c  | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/tests/ahci-test.c b/tests/ahci-test.c
index 999121b..97622e0 100644
--- a/tests/ahci-test.c
+++ b/tests/ahci-test.c
@@ -1350,7 +1350,6 @@ static void test_flush_migrate(void)
     AHCIQState *src, *dst;
     AHCICommand *cmd;
     uint8_t px;
-    const char *s;
     char *uri = g_strdup_printf("unix:%s", mig_socket);
 
     prepare_blkdebug_script(debug_path, "flush_to_disk");
@@ -1386,8 +1385,7 @@ static void test_flush_migrate(void)
     ahci_migrate(src, dst, uri);
 
     /* Complete the command */
-    s = "{'execute':'cont' }";
-    qmp_async(s);
+    qmp_async("{'execute':'cont' }");
     qmp_eventwait("RESUME");
     ahci_command_wait(dst, cmd);
     ahci_command_verify(dst, cmd);
diff --git a/tests/ide-test.c b/tests/ide-test.c
index bfd79dd..ea2657d 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -624,7 +624,6 @@ static void test_retry_flush(const char *machine)
     QPCIDevice *dev;
     QPCIBar bmdma_bar, ide_bar;
     uint8_t data;
-    const char *s;
 
     prepare_blkdebug_script(debug_path, "flush_to_disk");
 
@@ -652,8 +651,7 @@ static void test_retry_flush(const char *machine)
     qmp_eventwait("STOP");
 
     /* Complete the command */
-    s = "{'execute':'cont' }";
-    qmp_discard_response(s);
+    qmp_discard_response("{'execute':'cont' }");
 
     /* Check registers */
     data = qpci_io_readb(dev, ide_bar, reg_device);
-- 
2.7.5
