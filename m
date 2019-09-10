Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723A3C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 12:12:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3810B2089F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 12:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3810B2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7f0u-0007bM-Qo
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 08:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1i7eyQ-0006Et-Kf
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1i7eyP-0006M7-Nm
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:10:18 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:3006)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1i7eyP-0006KG-56
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:10:17 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by
 rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee15d77928b8a4-e1eb3;
 Tue, 10 Sep 2019 20:09:51 +0800 (CST)
X-RM-TRANSID: 2ee15d77928b8a4-e1eb3
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.148])
 by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35d7792822a8-7d7f1;
 Tue, 10 Sep 2019 20:09:51 +0800 (CST)
X-RM-TRANSID: 2ee35d7792822a8-7d7f1
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 20:09:25 +0800
Message-Id: <20190910120927.1669283-2-maozhongyi@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190910120927.1669283-1-maozhongyi@cmss.chinamobile.com>
References: <20190910120927.1669283-1-maozhongyi@cmss.chinamobile.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 221.176.66.79
Subject: [Qemu-devel] [PATCH 1/3] tests/migration: mem leak fix
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
Cc: tony.nguyen@bt.com, armbru@redhat.com,
 Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: armbru@redhat.com
Cc: laurent@vivier.eu
Cc: tony.nguyen@bt.com

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
---
 tests/migration/stress.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/migration/stress.c b/tests/migration/stress.c
index d9aa4afe92..e6c9a6b243 100644
--- a/tests/migration/stress.c
+++ b/tests/migration/stress.c
@@ -181,6 +181,8 @@ static int stressone(unsigned long long ramsizeMB)
     if (!ram) {
         fprintf(stderr, "%s (%05d): ERROR: cannot allocate %llu MB of RAM: %s\n",
                 argv0, gettid(), ramsizeMB, strerror(errno));
+        if (data)
+            free(data);
         return -1;
     }
     if (!data) {
-- 
2.17.1




