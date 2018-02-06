Received: from eggs.gnu.org ([2001:4830:134:3::10]:43615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ej5Wk-0003NN-UW
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:51:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ej5Wf-0004lB-BE
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:51:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ej5Wf-0004jo-52
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:51:17 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  6 Feb 2018 15:49:29 +0000
Message-Id: <20180206154936.13565-8-dgilbert@redhat.com>
In-Reply-To: <20180206154936.13565-1-dgilbert@redhat.com>
References: <20180206154936.13565-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 07/14] tests: Consolidate accelerators
 declaration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: peterx@redhat.com, lvivier@redhat.com, groug@kaod.org, ross.lagerwall@citrix.com, wei.w.wang@intel.com, danielhb@linux.vnet.ibm.com

From: Juan Quintela <quintela@redhat.com>

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/migration-test.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 0428d450df..3732682a29 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -422,27 +422,29 @@ static void test_migrate_start(QTestState **from, QTestState **to,
     gchar *cmd_src, *cmd_dst;
     char *bootpath = g_strdup_printf("%s/bootsect", tmpfs);
     const char *arch = qtest_get_arch();
+    const char *accel = "kvm:tcg";
 
     got_stop = false;
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         init_bootfile_x86(bootpath);
-        cmd_src = g_strdup_printf("-machine accel=kvm:tcg -m 150M"
+        cmd_src = g_strdup_printf("-machine accel=%s -m 150M"
                                   " -name pcsource,debug-threads=on"
                                   " -serial file:%s/src_serial"
                                   " -drive file=%s,format=raw",
-                                  tmpfs, bootpath);
-        cmd_dst = g_strdup_printf("-machine accel=kvm:tcg -m 150M"
+                                  accel, tmpfs, bootpath);
+        cmd_dst = g_strdup_printf("-machine accel=%s -m 150M"
                                   " -name pcdest,debug-threads=on"
                                   " -serial file:%s/dest_serial"
                                   " -drive file=%s,format=raw"
                                   " -incoming %s",
-                                  tmpfs, bootpath, uri);
+                                  accel, tmpfs, bootpath, uri);
     } else if (strcmp(arch, "ppc64") == 0) {
-        const char *accel;
 
         /* On ppc64, the test only works with kvm-hv, but not with kvm-pr */
-        accel = access("/sys/module/kvm_hv", F_OK) ? "tcg" : "kvm:tcg";
+        if (access("/sys/module/kvm_hv", F_OK)) {
+            accel = "tcg";
+        }
         init_bootfile_ppc(bootpath);
         cmd_src = g_strdup_printf("-machine accel=%s -m 256M"
                                   " -name pcsource,debug-threads=on"
-- 
2.14.3
