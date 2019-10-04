Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA18C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 17:39:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C59C920862
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 17:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C59C920862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGRYV-0003iH-U8
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 13:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iGRSO-0007mj-RF
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 13:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iGRSK-0006YW-0Y
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 13:33:30 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:2632)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iGRSG-0006TK-8b
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 13:33:25 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by
 rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee85d97824f008-b8d39;
 Sat, 05 Oct 2019 01:33:04 +0800 (CST)
X-RM-TRANSID: 2ee85d97824f008-b8d39
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from maozy-host.lan (unknown[180.108.8.156])
 by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea5d978248272-cd7eb;
 Sat, 05 Oct 2019 01:33:04 +0800 (CST)
X-RM-TRANSID: 2eea5d978248272-cd7eb
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/3] tests/migration: mem leak fix
Date: Sat,  5 Oct 2019 01:32:48 +0800
Message-Id: <95ceba2addaa3136db8ee233ea2e0ff9d13db7c0.1570208781.git.maozhongyi@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1570208781.git.maozhongyi@cmss.chinamobile.com>
References: <cover.1570208781.git.maozhongyi@cmss.chinamobile.com>
In-Reply-To: <cover.1570208781.git.maozhongyi@cmss.chinamobile.com>
References: <cover.1570208781.git.maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 221.176.66.80
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
Cc: tony.nguyen@bt.com, alex.bennee@linaro.org, armbru@redhat.com,
 Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

‘data’ has the possibility of memory leaks， so use the
glib macros g_autofree recommended by CODING_STYLE.rst
to automatically release the memory that returned from
g_malloc().

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/migration/stress.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/tests/migration/stress.c b/tests/migration/stress.c
index d9aa4afe92..d8a6f64af0 100644
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
      * of the loop below will be quite slow. We cna't use
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




