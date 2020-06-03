Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D3AC433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 08:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1DBA2067B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 08:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DBA2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgOWh-0006wT-8s
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 04:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maozhongyi@cmss.chinamobile.com>)
 id 1jgOTV-00016H-VM
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 04:10:13 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:7105)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jgOTU-0000Gy-Dn
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 04:10:13 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.15]) by
 rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee45ed75ab37ac-8b1fc;
 Wed, 03 Jun 2020 16:09:23 +0800 (CST)
X-RM-TRANSID: 2ee45ed75ab37ac-8b1fc
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
 by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee85ed75aae43e-61014;
 Wed, 03 Jun 2020 16:09:23 +0800 (CST)
X-RM-TRANSID: 2ee85ed75aae43e-61014
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/9] tests/migration: mem leak fix
Date: Wed,  3 Jun 2020 16:08:56 +0800
Message-Id: <20200603080904.997083-2-maozhongyi@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603080904.997083-1-maozhongyi@cmss.chinamobile.com>
References: <20200603080904.997083-1-maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

‘data’ has the possibility of memory leaks， so use the
glib macros g_autofree recommended by CODING_STYLE.rst
to automatically release the memory that returned from
g_malloc().

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 tests/migration/stress.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/tests/migration/stress.c b/tests/migration/stress.c
index 0c23964693..f9626d50ee 100644
--- a/tests/migration/stress.c
+++ b/tests/migration/stress.c
@@ -170,26 +170,14 @@ static unsigned long long now(void)
 static int stressone(unsigned long long ramsizeMB)
 {
     size_t pagesPerMB = 1024 * 1024 / PAGE_SIZE;
-    char *ram = malloc(ramsizeMB * 1024 * 1024);
+    g_autofree char *ram = g_malloc(ramsizeMB * 1024 * 1024);
     char *ramptr;
     size_t i, j, k;
-    char *data = malloc(PAGE_SIZE);
+    g_autofree char *data = g_malloc(PAGE_SIZE);
     char *dataptr;
     size_t nMB = 0;
     unsigned long long before, after;
 
-    if (!ram) {
-        fprintf(stderr, "%s (%05d): ERROR: cannot allocate %llu MB of RAM: %s\n",
-                argv0, gettid(), ramsizeMB, strerror(errno));
-        return -1;
-    }
-    if (!data) {
-        fprintf(stderr, "%s (%d): ERROR: cannot allocate %d bytes of RAM: %s\n",
-                argv0, gettid(), PAGE_SIZE, strerror(errno));
-        free(ram);
-        return -1;
-    }
-
     /* We don't care about initial state, but we do want
      * to fault it all into RAM, otherwise the first iter
      * of the loop below will be quite slow. We can't use
@@ -198,8 +186,6 @@ static int stressone(unsigned long long ramsizeMB)
     memset(ram, 0xfe, ramsizeMB * 1024 * 1024);
 
     if (random_bytes(data, PAGE_SIZE) < 0) {
-        free(ram);
-        free(data);
         return -1;
     }
 
@@ -227,9 +213,6 @@ static int stressone(unsigned long long ramsizeMB)
             }
         }
     }
-
-    free(data);
-    free(ram);
 }
 
 
-- 
2.17.1




