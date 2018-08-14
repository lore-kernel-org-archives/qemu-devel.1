Received: from eggs.gnu.org ([2001:4830:134:3::10]:49266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fpabG-0000kt-Ho
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fpabE-0005Cm-M6
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:47:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42840 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fpabE-0005Ce-Gq
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:47:08 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 14 Aug 2018 16:46:53 +0200
Message-Id: <1534258018-22859-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1534258018-22859-1-git-send-email-thuth@redhat.com>
References: <1534258018-22859-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 1/6] tests/migration-test: Silence the kvm_hv
 message by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

When running "make check" on a non-POWER host, the output is quite
distorted like this:

  [...]
  GTESTER check-qtest-nios2
  GTESTER check-qtest-or1k
  GTESTER check-qtest-ppc64
Skipping test: kvm_hv not available Skipping test: kvm_hv not available Skipping test: kvm_hv not available Skipping test: kvm_hv not available   GTESTER check-qtest-ppcemb
  GTESTER check-qtest-ppc
  GTESTER check-qtest-riscv32
  GTESTER check-qtest-riscv64
  [...]

Move the check to the beginning of the main function instead, so that
we do not have to test the condition again and again for each test,
and better use g_test_message() instead of g_print() here, like it is
also done in ufd_version_check() already.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/migration-test.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index e079e0b..cb795b2 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -445,15 +445,6 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                   " -incoming %s",
                                   accel, tmpfs, bootpath, uri);
     } else if (strcmp(arch, "ppc64") == 0) {
-
-        /* On ppc64, the test only works with kvm-hv, but not with kvm-pr
-         * and TCG is touchy due to race conditions on dirty bits
-         * (especially on PPC for some reason)
-         */
-        if (access("/sys/module/kvm_hv", F_OK)) {
-            g_print("Skipping test: kvm_hv not available ");
-            return -1;
-        }
         cmd_src = g_strdup_printf("-machine accel=%s -m 256M"
                                   " -name source,debug-threads=on"
                                   " -serial file:%s/src_serial"
@@ -769,6 +760,17 @@ int main(int argc, char **argv)
         return 0;
     }
 
+    /*
+     * On ppc64, the test only works with kvm-hv, but not with kvm-pr and TCG
+     * is touchy due to race conditions on dirty bits (especially on PPC for
+     * some reason)
+     */
+    if (g_str_equal(qtest_get_arch(), "ppc64") &&
+        access("/sys/module/kvm_hv", F_OK)) {
+        g_test_message("Skipping test: kvm_hv not available");
+        return 0;
+    }
+
     tmpfs = mkdtemp(template);
     if (!tmpfs) {
         g_test_message("mkdtemp on path (%s): %s\n", template, strerror(errno));
-- 
1.8.3.1
