Received: from eggs.gnu.org ([2001:4830:134:3::10]:38379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eXZvA-0002M1-Q1
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:53:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eXZv9-0003BX-Ev
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:53:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eXZv9-00039z-0F
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:52:59 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 15C0861D0D
	for <qemu-devel@nongnu.org>; Fri,  5 Jan 2018 21:52:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri,  5 Jan 2018 22:52:38 +0100
Message-Id: <20180105215246.908-4-quintela@redhat.com>
In-Reply-To: <20180105215246.908-1-quintela@redhat.com>
References: <20180105215246.908-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v4 03/11] tests: Consolidate accelerators
 declaration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/migration-test.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 32f3bb86a8..d81f22118b 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -434,27 +434,29 @@ static void test_migrate_start(QTestState **from, QTestState **to,
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
