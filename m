Received: from eggs.gnu.org ([2001:4830:134:3::10]:60885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA3x-0001Al-8X
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA3o-0005hC-O3
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:20 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:37167)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA3n-0005c0-JN
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:16 -0400
Received: by mail-wr1-x42f.google.com with SMTP id u12-v6so16460851wrr.4
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:15 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:01:42 +0200
Message-Id: <1534870966-9287-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 10/74] tests/migration-test: Silence the kvm_hv
 message by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

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

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1534419358-10932-2-git-send-email-thuth@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/migration-test.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index eb58d0a..0e687b7 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -438,15 +438,6 @@ static int test_migrate_start(QTestState **from, QTestState **to,
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
@@ -750,6 +741,17 @@ int main(int argc, char **argv)
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
