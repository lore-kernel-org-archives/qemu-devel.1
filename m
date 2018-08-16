Received: from eggs.gnu.org ([2001:4830:134:3::10]:50691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqDmq-0001AK-H1
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqDmf-0005NQ-Hk
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53666 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqDmT-00059P-2G
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 79C854076076
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:37:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-56.ams2.redhat.com
	[10.36.116.56])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 567A410194
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:37:04 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Aug 2018 10:36:47 +0200
Message-Id: <20180816083701.3932-12-armbru@redhat.com>
In-Reply-To: <20180816083701.3932-1-armbru@redhat.com>
References: <20180816083701.3932-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/25] tests: Pass literal format strings
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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180806065344.7103-12-armbru@redhat.com>
---
 tests/ahci-test.c | 4 +---
 tests/ide-test.c  | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/tests/ahci-test.c b/tests/ahci-test.c
index 555f02112e..60ba32f4f2 100644
--- a/tests/ahci-test.c
+++ b/tests/ahci-test.c
@@ -1355,7 +1355,6 @@ static void test_flush_migrate(void)
     AHCIQState *src, *dst;
     AHCICommand *cmd;
     uint8_t px;
-    const char *s;
     char *uri =3D g_strdup_printf("unix:%s", mig_socket);
=20
     prepare_blkdebug_script(debug_path, "flush_to_disk");
@@ -1391,8 +1390,7 @@ static void test_flush_migrate(void)
     ahci_migrate(src, dst, uri);
=20
     /* Complete the command */
-    s =3D "{'execute':'cont' }";
-    qmp_send(s);
+    qmp_send("{'execute':'cont' }");
     qmp_eventwait("RESUME");
     ahci_command_wait(dst, cmd);
     ahci_command_verify(dst, cmd);
diff --git a/tests/ide-test.c b/tests/ide-test.c
index 7ab09c3448..89c4468c83 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -697,7 +697,6 @@ static void test_retry_flush(const char *machine)
     QPCIDevice *dev;
     QPCIBar bmdma_bar, ide_bar;
     uint8_t data;
-    const char *s;
=20
     prepare_blkdebug_script(debug_path, "flush_to_disk");
=20
@@ -725,8 +724,7 @@ static void test_retry_flush(const char *machine)
     qmp_eventwait("STOP");
=20
     /* Complete the command */
-    s =3D "{'execute':'cont' }";
-    qmp_discard_response(s);
+    qmp_discard_response("{'execute':'cont' }");
=20
     /* Check registers */
     data =3D qpci_io_readb(dev, ide_bar, reg_device);
--=20
2.17.1
