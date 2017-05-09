Received: from eggs.gnu.org ([2001:4830:134:3::10]:44080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d80AZ-00084e-VE
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:06:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d80AT-0007X2-Tr
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:06:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d80AT-0007W4-N0
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:06:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B22A137E67
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 08:06:48 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  9 May 2017 10:06:28 +0200
Message-Id: <1494317205-2211-12-git-send-email-armbru@redhat.com>
In-Reply-To: <1494317205-2211-1-git-send-email-armbru@redhat.com>
References: <1494317205-2211-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v3 11/28] fdc-test: Avoid deprecated 'change'
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

Use the preferred blockdev-change-medium command instead.

Also, use of 'device' is deprecated; adding an explicit id on
the command line lets us use 'id' for both blockdev-change-medium
and eject.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20170427215821.19397-10-eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/fdc-test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/fdc-test.c b/tests/fdc-test.c
index 738c6b4..325712e 100644
--- a/tests/fdc-test.c
+++ b/tests/fdc-test.c
@@ -298,8 +298,8 @@ static void test_media_insert(void)
 
     /* Insert media in drive. DSKCHK should not be reset until a step pulse
      * is sent. */
-    qmp_discard_response("{'execute':'change', 'arguments':{"
-                         " 'device':'floppy0', 'target': %s, 'arg': 'raw' }}",
+    qmp_discard_response("{'execute':'blockdev-change-medium', 'arguments':{"
+                         " 'id':'floppy0', 'filename': %s, 'format': 'raw' }}",
                          test_image);
 
     dir = inb(FLOPPY_BASE + reg_dir);
@@ -330,7 +330,7 @@ static void test_media_change(void)
     /* Eject the floppy and check that DSKCHG is set. Reading it out doesn't
      * reset the bit. */
     qmp_discard_response("{'execute':'eject', 'arguments':{"
-                         " 'device':'floppy0' }}");
+                         " 'id':'floppy0' }}");
 
     dir = inb(FLOPPY_BASE + reg_dir);
     assert_bit_set(dir, DSKCHG);
@@ -564,7 +564,7 @@ int main(int argc, char **argv)
     /* Run the tests */
     g_test_init(&argc, &argv, NULL);
 
-    qtest_start(NULL);
+    qtest_start("-device floppy,id=floppy0");
     qtest_irq_intercept_in(global_qtest, "ioapic");
     qtest_add_func("/fdc/cmos", test_cmos);
     qtest_add_func("/fdc/no_media_on_start", test_no_media_on_start);
-- 
2.7.4
