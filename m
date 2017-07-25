Received: from eggs.gnu.org ([2001:4830:134:3::10]:46071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da7BM-0002AE-8f
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da7BL-0004MN-9k
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:15:56 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 25 Jul 2017 16:15:15 -0500
Message-Id: <20170725211523.3998-5-eblake@redhat.com>
In-Reply-To: <20170725211523.3998-1-eblake@redhat.com>
References: <20170725211523.3998-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 04/12] tests: Pass literal format strings
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
Cc: stefanha@redhat.com, armbru@redhat.com, John Snow <jsnow@redhat.com>, "open list:IDE" <qemu-block@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

The qmp_FOO() take a printf-like format string.  In a few places, we
assign a string literal to a variable and pass that instead of simply
passing the literal.  Clean that up.

Bonus: gets rid of non-literal format strings.  A step towards
compile-time format string checking without triggering
-Wformat-nonliteral.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1500645206-13559-4-git-send-email-armbru@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/ahci-test.c | 4 +---
 tests/ide-test.c  | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/tests/ahci-test.c b/tests/ahci-test.c
index 999121bb7c..97622e0044 100644
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
index bfd79ddbdc..ea2657d3d1 100644
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
2.13.3
