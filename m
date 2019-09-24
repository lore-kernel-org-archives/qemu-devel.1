Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6488C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 20:11:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BCFF207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 20:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BCFF207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCrA2-0002h1-OU
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 16:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iCr87-0000Rt-B0
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iCr86-0002qA-DO
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:09:47 -0400
Received: from relay.sw.ru ([185.231.240.75]:38030)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iCr86-0002pf-5e
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:09:46 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iCr84-0001Mk-K6; Tue, 24 Sep 2019 23:09:44 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/25] hw/core/loader-fit: fix freeing errp in fit_load_fdt
Date: Tue, 24 Sep 2019 23:08:39 +0300
Message-Id: <20190924200902.4703-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190924200902.4703-1-vsementsov@virtuozzo.com>
References: <20190924200902.4703-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 Paul Burton <pburton@wavecomp.com>, vsementsov@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

fit_load_fdt forget to zero errp. Fix it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 hw/core/loader-fit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
index 953b16bc82..11e4fad595 100644
--- a/hw/core/loader-fit.c
+++ b/hw/core/loader-fit.c
@@ -201,6 +201,7 @@ static int fit_load_fdt(const struct fit_loader *ldr, const void *itb,
     if (err == -ENOENT) {
         load_addr = ROUND_UP(kernel_end, 64 * KiB) + (10 * MiB);
         error_free(*errp);
+        *errp = NULL;
     } else if (err) {
         error_prepend(errp, "unable to read FDT load address from FIT: ");
         ret = err;
-- 
2.21.0


