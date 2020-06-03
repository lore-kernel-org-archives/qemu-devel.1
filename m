Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B096C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 08:12:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1259B2067B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 08:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1259B2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgOVb-0005Cz-6d
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 04:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maozhongyi@cmss.chinamobile.com>)
 id 1jgOTE-0000Yl-4D
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 04:09:56 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:3995)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jgOT9-0000Dh-R1
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 04:09:55 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.15]) by
 rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee15ed75ab36a7-8ad9a;
 Wed, 03 Jun 2020 16:09:24 +0800 (CST)
X-RM-TRANSID: 2ee15ed75ab36a7-8ad9a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
 by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee85ed75aae43e-61016;
 Wed, 03 Jun 2020 16:09:24 +0800 (CST)
X-RM-TRANSID: 2ee85ed75aae43e-61016
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/9] tests/migration: fix unreachable path in stress test
Date: Wed,  3 Jun 2020 16:08:57 +0800
Message-Id: <20200603080904.997083-3-maozhongyi@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603080904.997083-1-maozhongyi@cmss.chinamobile.com>
References: <20200603080904.997083-1-maozhongyi@cmss.chinamobile.com>
Received-SPF: pass client-ip=221.176.66.79;
 envelope-from=maozhongyi@cmss.chinamobile.com; helo=cmccmta1.chinamobile.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 04:09:40
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If stressone() or stress() exits it's because of a failure
because the test runs forever otherwise, so change stressone
and stress type to void to make the exit_failure() as the exit
function of main().

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 tests/migration/stress.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/tests/migration/stress.c b/tests/migration/stress.c
index f9626d50ee..a062ef6b55 100644
--- a/tests/migration/stress.c
+++ b/tests/migration/stress.c
@@ -167,7 +167,7 @@ static unsigned long long now(void)
     return (tv.tv_sec * 1000ull) + (tv.tv_usec / 1000ull);
 }
 
-static int stressone(unsigned long long ramsizeMB)
+static void stressone(unsigned long long ramsizeMB)
 {
     size_t pagesPerMB = 1024 * 1024 / PAGE_SIZE;
     g_autofree char *ram = g_malloc(ramsizeMB * 1024 * 1024);
@@ -186,7 +186,7 @@ static int stressone(unsigned long long ramsizeMB)
     memset(ram, 0xfe, ramsizeMB * 1024 * 1024);
 
     if (random_bytes(data, PAGE_SIZE) < 0) {
-        return -1;
+        return;
     }
 
     before = now();
@@ -225,7 +225,7 @@ static void *stressthread(void *arg)
     return NULL;
 }
 
-static int stress(unsigned long long ramsizeGB, int ncpus)
+static void stress(unsigned long long ramsizeGB, int ncpus)
 {
     size_t i;
     unsigned long long ramsizeMB = ramsizeGB * 1024 / ncpus;
@@ -238,8 +238,6 @@ static int stress(unsigned long long ramsizeGB, int ncpus)
     }
 
     stressone(ramsizeMB);
-
-    return 0;
 }
 
 
@@ -335,8 +333,7 @@ int main(int argc, char **argv)
     fprintf(stdout, "%s (%05d): INFO: RAM %llu GiB across %d CPUs\n",
             argv0, gettid(), ramsizeGB, ncpus);
 
-    if (stress(ramsizeGB, ncpus) < 0)
-        exit_failure();
+    stress(ramsizeGB, ncpus);
 
-    exit_success();
+    exit_failure();
 }
-- 
2.17.1




