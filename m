Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22DCC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 06:16:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 856EA206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 06:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856EA206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxlZj-00089e-Qh
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 02:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1jxlYT-0006rH-OK
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 02:15:09 -0400
Received: from mail.ispras.ru ([83.149.199.84]:53676)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1jxlYR-0001dy-WC
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 02:15:09 -0400
Received: from [127.0.1.1] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 0023F40A92BA;
 Tue, 21 Jul 2020 06:15:05 +0000 (UTC)
Subject: [PATCH v2 1/2] hw/mips: remove exit(1) in case of missing ROM
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
To: qemu-devel@nongnu.org
Date: Tue, 21 Jul 2020 09:15:05 +0300
Message-ID: <159531210571.24117.231100997794891819.stgit@pasha-ThinkPad-X280>
In-Reply-To: <159531210010.24117.10018704762356020189.stgit@pasha-ThinkPad-X280>
References: <159531210010.24117.10018704762356020189.stgit@pasha-ThinkPad-X280>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 02:15:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, pavel.dovgalyuk@ispras.ru, f4bug@amsat.org,
 aleksandar.qemu.devel@gmail.com, antonynpavlov@gmail.com, chenhc@lemote.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch updates MIPS-based machines to allow starting them without ROM.
In this case CPU starts to execute instructions from the empty memory,
but QEMU allows introspecting the machine configuration.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
---
 hw/mips/fuloong2e.c |    8 +++-----
 hw/mips/jazz.c      |    8 +++-----
 hw/mips/malta.c     |   11 ++++-------
 hw/mips/mipssim.c   |   10 +++-------
 4 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 8ca31e5162..3e8a073922 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -336,10 +336,8 @@ static void mips_fuloong2e_init(MachineState *machine)
         kernel_entry = load_kernel(env);
         write_bootloader(env, memory_region_get_ram_ptr(bios), kernel_entry);
     } else {
-        if (bios_name == NULL) {
-                bios_name = FULOONG_BIOSNAME;
-        }
-        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS,
+                                  bios_name ?: FULOONG_BIOSNAME);
         if (filename) {
             bios_size = load_image_targphys(filename, 0x1fc00000LL,
                                             BIOS_SIZE);
@@ -349,7 +347,7 @@ static void mips_fuloong2e_init(MachineState *machine)
         }
 
         if ((bios_size < 0 || bios_size > BIOS_SIZE) &&
-            !kernel_filename && !qtest_enabled()) {
+            bios_name && !qtest_enabled()) {
             error_report("Could not load MIPS bios '%s'", bios_name);
             exit(1);
         }
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 82a6e3220e..b6dee3eb1f 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -205,10 +205,7 @@ static void mips_jazz_init(MachineState *machine,
     memory_region_add_subregion(address_space, 0xfff00000LL, bios2);
 
     /* load the BIOS image. */
-    if (bios_name == NULL) {
-        bios_name = BIOS_FILENAME;
-    }
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name ?: BIOS_FILENAME);
     if (filename) {
         bios_size = load_image_targphys(filename, 0xfff00000LL,
                                         MAGNUM_BIOS_SIZE);
@@ -216,7 +213,8 @@ static void mips_jazz_init(MachineState *machine,
     } else {
         bios_size = -1;
     }
-    if ((bios_size < 0 || bios_size > MAGNUM_BIOS_SIZE) && !qtest_enabled()) {
+    if ((bios_size < 0 || bios_size > MAGNUM_BIOS_SIZE)
+        && bios_name && !qtest_enabled()) {
         error_report("Could not load MIPS bios '%s'", bios_name);
         exit(1);
     }
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index a59e20c81c..838de0f905 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1334,10 +1334,8 @@ void mips_malta_init(MachineState *machine)
         /* Load firmware from flash. */
         if (!dinfo) {
             /* Load a BIOS image. */
-            if (bios_name == NULL) {
-                bios_name = BIOS_FILENAME;
-            }
-            filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+            filename = qemu_find_file(QEMU_FILE_TYPE_BIOS,
+                                      bios_name ?: BIOS_FILENAME);
             if (filename) {
                 bios_size = load_image_targphys(filename, FLASH_ADDRESS,
                                                 BIOS_SIZE);
@@ -1346,9 +1344,8 @@ void mips_malta_init(MachineState *machine)
                 bios_size = -1;
             }
             if ((bios_size < 0 || bios_size > BIOS_SIZE) &&
-                !kernel_filename && !qtest_enabled()) {
-                error_report("Could not load MIPS bios '%s', and no "
-                             "-kernel argument was specified", bios_name);
+                bios_name && !qtest_enabled()) {
+                error_report("Could not load MIPS bios '%s'", bios_name);
                 exit(1);
             }
         }
diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index 1b3b762203..f259e7041e 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -173,10 +173,7 @@ mips_mipssim_init(MachineState *machine)
     /* Map the BIOS / boot exception handler. */
     memory_region_add_subregion(address_space_mem, 0x1fc00000LL, bios);
     /* Load a BIOS / boot exception handler image. */
-    if (bios_name == NULL) {
-        bios_name = BIOS_FILENAME;
-    }
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name ?: BIOS_FILENAME);
     if (filename) {
         bios_size = load_image_targphys(filename, 0x1fc00000LL, BIOS_SIZE);
         g_free(filename);
@@ -184,10 +181,9 @@ mips_mipssim_init(MachineState *machine)
         bios_size = -1;
     }
     if ((bios_size < 0 || bios_size > BIOS_SIZE) &&
-        !kernel_filename && !qtest_enabled()) {
+        bios_name && !qtest_enabled()) {
         /* Bail out if we have neither a kernel image nor boot vector code. */
-        error_report("Could not load MIPS bios '%s', and no "
-                     "-kernel argument was specified", bios_name);
+        error_report("Could not load MIPS bios '%s'", bios_name);
         exit(1);
     } else {
         /* We have a boot vector start address. */


