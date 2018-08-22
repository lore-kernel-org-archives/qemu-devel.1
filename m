Received: from eggs.gnu.org ([2001:4830:134:3::10]:39036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsRpK-0006pw-Eu
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsRpG-000070-6k
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41928 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsRpF-00006V-WE
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A85984021CC1
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 12:01:25 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 22 Aug 2018 14:00:43 +0200
Message-Id: <20180822120050.12694-14-quintela@redhat.com>
In-Reply-To: <20180822120050.12694-1-quintela@redhat.com>
References: <20180822120050.12694-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 13/20] tests/migration-test: Silence the kvm_hv
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
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

When running "make check" on a non-POWER host, there is currently an ugly
line in the output like this:

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
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/migration-test.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index eb58d0a48e..0e687b7512 100644
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
2.17.1
