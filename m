Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C2AC433E8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 07:12:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 989A4207E8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 07:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989A4207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0JmR-0000sr-Tm
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 03:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hogan.wang@huawei.com>)
 id 1k0Jlh-0008J7-Uw
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 03:11:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4160 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hogan.wang@huawei.com>)
 id 1k0Jlf-0007oI-Jr
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 03:11:21 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id E717ADA38931473CEA7F;
 Tue, 28 Jul 2020 15:11:13 +0800 (CST)
Received: from localhost (10.174.149.56) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Tue, 28 Jul 2020
 15:11:07 +0800
From: Hogan Wang <hogan.wang@huawei.com>
To: <pbonzini@redhat.com>, <qemu-devel@nongnu.org>
Subject: [PATCH 1/3] qemu-options: introduce functions to parse options
Date: Tue, 28 Jul 2020 15:11:02 +0800
Message-ID: <20200728071104.3835-1-hogan.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.149.56]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=hogan.wang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 03:11:14
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
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
Cc: wangxinxin.wang@huawei.com, weidong.huang@huawei.com, hogan.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: w00506750 <hogan.wang@huawei.com>

All of the qemu options are parsed in qemu_init function,
and make qemu_init function too long and nasty. Introduce
'parser' function pointer in QEMUOption struct to parse
one option or a set of options.

Signed-off-by: Hogan Wang <hogan.wang@huawei.com>
---
 qemu-options-wrapper.h | 10 +++++-----
 qemu-options.hx        | 12 ++++++++----
 softmmu/vl.c           | 33 +++++++++++++++++----------------
 3 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/qemu-options-wrapper.h b/qemu-options-wrapper.h
index 6f548e3922..efdfbf1dfd 100644
--- a/qemu-options-wrapper.h
+++ b/qemu-options-wrapper.h
@@ -1,15 +1,15 @@
 
 #if defined(QEMU_OPTIONS_GENERATE_ENUM)
 
-#define DEF(option, opt_arg, opt_enum, opt_help, arch_mask)     \
+#define DEF(option, opt_arg, opt_enum, opt_help, arch_mask, ...)     \
     opt_enum,
 #define DEFHEADING(text)
 #define ARCHHEADING(text, arch_mask)
 
 #elif defined(QEMU_OPTIONS_GENERATE_HELP)
 
-#define DEF(option, opt_arg, opt_enum, opt_help, arch_mask)    \
-    if ((arch_mask) & arch_type)                               \
+#define DEF(option, opt_arg, opt_enum, opt_help, arch_mask, ...)    \
+    if ((arch_mask) & arch_type)                                    \
         fputs(opt_help, stdout);
 
 #define ARCHHEADING(text, arch_mask) \
@@ -20,8 +20,8 @@
 
 #elif defined(QEMU_OPTIONS_GENERATE_OPTIONS)
 
-#define DEF(option, opt_arg, opt_enum, opt_help, arch_mask)     \
-    { option, opt_arg, opt_enum, arch_mask },
+#define DEF(option, opt_arg, opt_enum, opt_help, arch_mask, ...)     \
+    { option, opt_arg, opt_enum, arch_mask, __VA_ARGS__},
 #define DEFHEADING(text)
 #define ARCHHEADING(text, arch_mask)
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 708583b4ce..988fa4026b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3352,7 +3352,8 @@ testing of various kernels.
 ERST
 
 DEF("kernel", HAS_ARG, QEMU_OPTION_kernel, \
-    "-kernel bzImage use 'bzImage' as kernel image\n", QEMU_ARCH_ALL)
+    "-kernel bzImage use 'bzImage' as kernel image\n", QEMU_ARCH_ALL, \
+    parse_linux_boot)
 SRST
 ``-kernel bzImage``
     Use bzImage as kernel image. The kernel can be either a Linux kernel
@@ -3360,14 +3361,16 @@ SRST
 ERST
 
 DEF("append", HAS_ARG, QEMU_OPTION_append, \
-    "-append cmdline use 'cmdline' as kernel command line\n", QEMU_ARCH_ALL)
+    "-append cmdline use 'cmdline' as kernel command line\n", QEMU_ARCH_ALL, \
+    parse_linux_boot)
 SRST
 ``-append cmdline``
     Use cmdline as kernel command line
 ERST
 
 DEF("initrd", HAS_ARG, QEMU_OPTION_initrd, \
-           "-initrd file    use 'file' as initial ram disk\n", QEMU_ARCH_ALL)
+           "-initrd file    use 'file' as initial ram disk\n", QEMU_ARCH_ALL, \
+    parse_linux_boot)
 SRST
 ``-initrd file``
     Use file as initial ram disk.
@@ -3380,7 +3383,8 @@ SRST
 ERST
 
 DEF("dtb", HAS_ARG, QEMU_OPTION_dtb, \
-    "-dtb    file    use 'file' as device tree image\n", QEMU_ARCH_ALL)
+    "-dtb    file    use 'file' as device tree image\n", QEMU_ARCH_ALL, \
+    parse_linux_boot)
 SRST
 ``-dtb file``
     Use file as a device tree binary (dtb) image and pass it to the
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 4eb9d1f7fd..edb24fd3f7 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -1715,8 +1715,16 @@ typedef struct QEMUOption {
     int flags;
     int index;
     uint32_t arch_mask;
+    int (*parser)(const struct QEMUOption *popt, const char* optarg);
 } QEMUOption;
 
+static int parse_linux_boot(const QEMUOption *popt, const char* optarg)
+{
+    qemu_opts_set(qemu_find_opts("machine"), NULL, popt->name, optarg,
+                  &error_abort);
+    return 0;
+}
+
 static const QEMUOption qemu_options[] = {
     { "h", 0, QEMU_OPTION_h, QEMU_ARCH_ALL },
 #define QEMU_OPTIONS_GENERATE_OPTIONS
@@ -2981,6 +2989,15 @@ void qemu_init(int argc, char **argv, char **envp)
                 error_report("Option not supported for this target");
                 exit(1);
             }
+
+            if (popt->parser) {
+                if (popt->parser(popt, optarg)) {
+                    error_report("Parser '%s' option error", popt->name);
+                    exit(1);
+                }
+                continue;
+            }
+
             switch(popt->index) {
             case QEMU_OPTION_cpu:
                 /* hw initialization will check this */
@@ -3075,22 +3092,6 @@ void qemu_init(int argc, char **argv, char **envp)
                     exit(1);
                 }
                 break;
-            case QEMU_OPTION_kernel:
-                qemu_opts_set(qemu_find_opts("machine"), NULL, "kernel", optarg,
-                              &error_abort);
-                break;
-            case QEMU_OPTION_initrd:
-                qemu_opts_set(qemu_find_opts("machine"), NULL, "initrd", optarg,
-                              &error_abort);
-                break;
-            case QEMU_OPTION_append:
-                qemu_opts_set(qemu_find_opts("machine"), NULL, "append", optarg,
-                              &error_abort);
-                break;
-            case QEMU_OPTION_dtb:
-                qemu_opts_set(qemu_find_opts("machine"), NULL, "dtb", optarg,
-                              &error_abort);
-                break;
             case QEMU_OPTION_cdrom:
                 drive_add(IF_DEFAULT, 2, optarg, CDROM_OPTS);
                 break;
-- 
2.27.0



