Received: from eggs.gnu.org ([2001:4830:134:3::10]:50459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ew9QT-0007a9-Gj
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ew9QR-0004MO-Th
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:38:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35956 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ew9QR-0004M2-OV
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:38:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 538C5406E968
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 16:38:51 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 14 Mar 2018 17:38:35 +0100
Message-Id: <20180314163838.7158-6-quintela@redhat.com>
In-Reply-To: <20180314163838.7158-1-quintela@redhat.com>
References: <20180314163838.7158-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v6 5/8] tests: Migration ppc now inlines its
 program
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

No need to write it to a file.  Just need a proper firmware O:-)

Signed-off-by: Juan Quintela <quintela@redhat.com>
CC: Laurent Vivier <lvivier@redhat.com>
---
 tests/migration-test.c | 41 +++++------------------------------------
 1 file changed, 5 insertions(+), 36 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index fd885ba909..4a94d3d598 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -19,9 +19,6 @@
 #include "qemu/sockets.h"
 #include "chardev/char.h"
 #include "sysemu/sysemu.h"
-#include "hw/nvram/chrp_nvram.h"
-
-#define MIN_NVRAM_SIZE 8192 /* from spapr_nvram.c */
 
 const unsigned start_address = 1024 * 1024;
 const unsigned end_address = 100 * 1024 * 1024;
@@ -90,36 +87,6 @@ static void init_bootfile_x86(const char *bootpath)
     fclose(bootfile);
 }
 
-static void init_bootfile_ppc(const char *bootpath)
-{
-    FILE *bootfile;
-    char buf[MIN_NVRAM_SIZE];
-    ChrpNvramPartHdr *header = (ChrpNvramPartHdr *)buf;
-
-    memset(buf, 0, MIN_NVRAM_SIZE);
-
-    /* Create a "common" partition in nvram to store boot-command property */
-
-    header->signature = CHRP_NVPART_SYSTEM;
-    memcpy(header->name, "common", 6);
-    chrp_nvram_finish_partition(header, MIN_NVRAM_SIZE);
-
-    /* FW_MAX_SIZE is 4MB, but slof.bin is only 900KB,
-     * so let's modify memory between 1MB and 100MB
-     * to do like PC bootsector
-     */
-
-    sprintf(buf + 16,
-            "boot-command=hex .\" _\" begin %x %x do i c@ 1 + i c! 1000 +loop "
-            ".\" B\" 0 until", end_address, start_address);
-
-    /* Write partition to the NVRAM file */
-
-    bootfile = fopen(bootpath, "wb");
-    g_assert_cmpint(fwrite(buf, MIN_NVRAM_SIZE, 1, bootfile), ==, 1);
-    fclose(bootfile);
-}
-
 /*
  * Wait for some output in the serial output file,
  * we get an 'A' followed by an endless string of 'B's
@@ -410,12 +377,14 @@ static void test_migrate_start(QTestState **from, QTestState **to,
         if (access("/sys/module/kvm_hv", F_OK)) {
             accel = "tcg";
         }
-        init_bootfile_ppc(bootpath);
         cmd_src = g_strdup_printf("-machine accel=%s -m 256M"
                                   " -name source,debug-threads=on"
                                   " -serial file:%s/src_serial"
-                                  " -drive file=%s,if=pflash,format=raw",
-                                  accel, tmpfs, bootpath);
+                                  " -prom-env '"
+                                  "boot-command=hex .\" _\" begin %x %x "
+                                  "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
+                                  "until'",  accel, tmpfs, end_address,
+                                  start_address);
         cmd_dst = g_strdup_printf("-machine accel=%s -m 256M"
                                   " -name target,debug-threads=on"
                                   " -serial file:%s/dest_serial"
-- 
2.14.3
