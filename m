Received: from eggs.gnu.org ([2001:4830:134:3::10]:48718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cy0sw-00036o-VO
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 14:51:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cy0sw-0004sA-3j
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 14:51:27 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 11 Apr 2017 13:50:33 -0500
Message-Id: <20170411185034.13460-13-eblake@redhat.com>
In-Reply-To: <20170411185034.13460-1-eblake@redhat.com>
References: <20170411185034.13460-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 12/13] fdc-test: Avoid deprecated 'change'
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
Cc: armbru@redhat.com, John Snow <jsnow@redhat.com>, "open list:Floppy" <qemu-block@nongnu.org>

Use the preferred blockdev-change-medium command instead.

Also, use of 'device' is deprecated; adding an explicit id on
the command line lets us use 'id' for both blockdev-change-medium
and eject.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v4: use 'id' rather than 'device' [thanks to John and Kevin]
v3: update commit message to point out that we are still using
deprecated 'device'
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
2.9.3
