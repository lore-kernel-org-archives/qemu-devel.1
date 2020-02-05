Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D5FC33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:34:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5389920661
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TILI/D/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5389920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izH58-0002QL-FY
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 04:34:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izH3f-0000gR-DB
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:33:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izH3e-0004xU-4z
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:33:19 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41535)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izH3d-0004Yd-UG
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:33:18 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200205093315euoutp024fab0caf68e7eca75bbc838207639127~wd830lAhY1428814288euoutp02d
 for <qemu-devel@nongnu.org>; Wed,  5 Feb 2020 09:33:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200205093315euoutp024fab0caf68e7eca75bbc838207639127~wd830lAhY1428814288euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580895195;
 bh=ibNqqK8kMJTR6I/8H1P2J6EA3/WKQtaT/ZbDNoeJndI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TILI/D/6Pmtp2T1OVmmA1Y7YPUt2cqmNBaolwH/RbpRiUysovJB19KBfXkEXj3tpW
 frQzc/fT6prwMpeYCTcCQhSo410lO5tMcb8bs3n3e5eeiGLOcD1emc3x866VqX4wg9
 UUI0SsfqzZrLmCUHpof9k+Uaq7hK6Gv+0bcc/qoQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200205093315eucas1p1659d0bb62e8a0e5ea4e9e30747e5f886~wd83iKgo42000320003eucas1p1N;
 Wed,  5 Feb 2020 09:33:15 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id BD.19.61286.BDB8A3E5; Wed,  5
 Feb 2020 09:33:15 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200205093315eucas1p1b77dcc2238588a6b6efb5e89aa902b6d~wd83NOUKu3061730617eucas1p1o;
 Wed,  5 Feb 2020 09:33:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200205093314eusmtrp16ed2e5b5e59501cd5056ec80093fb2b3~wd83MxAE51029010290eusmtrp1W;
 Wed,  5 Feb 2020 09:33:14 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-53-5e3a8bdb8eff
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id BD.8D.08375.ADB8A3E5; Wed,  5
 Feb 2020 09:33:14 +0000 (GMT)
Received: from AMDC3304.digital.local (unknown [106.120.51.21]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200205093314eusmtip2ae18c554db84e1488a305d02a6f85b9a~wd825APGN0075700757eusmtip2L;
 Wed,  5 Feb 2020 09:33:14 +0000 (GMT)
From: i.kotrasinsk@partner.samsung.com
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 3/9] memory: Hack - use shared memory when possible
Date: Wed,  5 Feb 2020 10:32:59 +0100
Message-Id: <1580895185-24341-4-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580895185-24341-1-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsWy7djPc7q3u63iDD78FLLYc+Exm8X+bf9Y
 LeacecBicbx3B4sDi8eda3vYPJ5c28zkcfDdHiaP9/uusgWwRHHZpKTmZJalFunbJXBlrDzU
 xVLwna1i3uqNjA2MP1m6GDk5JARMJL6cucPaxcjFISSwglHi4dGzzBDOF0aJ2/tPs0M4nxkl
 Xs7ewQTT0tl5ggkisZxR4vyRl2xwLZfeHgMbzCagJrHzyGdGEFtEQFLid9dpZhCbWSBD4vms
 bjBbWMBL4uijLawgNouAqsTcY21gG3gFAiTeN7axQmyTk7h5rhOsnlMgUGLTp49gyyQELrNJ
 zH23kRmiyEVi0eLtUA3CEq+Ob2GHsGUkTk/ugfq0XqLlzg4miOYORom+ldPZIBLWEl82LAUq
 4gC6TlNi/S59iLCjxJT7IMdxANl8EjfeCkLczycxadt0Zogwr0RHmxBEtZ5E95ObTDBblzU+
 gtrqIXGg8SLYZUICSxglfrdaT2CUn4WwawEj4ypG8dTS4tz01GLDvNRyveLE3OLSvHS95Pzc
 TYzA+D/97/inHYxfLyUdYhTgYFTi4V0xyTJOiDWxrLgy9xCjBAezkgjveX2gEG9KYmVValF+
 fFFpTmrxIUZpDhYlcV7jRS9jhQTSE0tSs1NTC1KLYLJMHJxSDYxdNtfOiW+2i1vQ865a/UUl
 35vXXA2af0T1U9Vv7VlU892gO2aT0fEVx/y5f1QUqCrP5Cvt2Xv+iM3cSGen/XWKcSqZV6Xn
 OTCuyvcPM8/QPGJZE586U/2NZcptdnuZ1oyaqk1XWj+rewtumRZ3PGvHuUKjRX79oj+a1qmq
 1hoxca79k+XXq8RSnJFoqMVcVJwIAJPuQCX7AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsVy+t/xe7q3uq3iDCZftrTYc+Exm8X+bf9Y
 LeacecBicbx3B4sDi8eda3vYPJ5c28zkcfDdHiaP9/uusgWwROnZFOWXlqQqZOQXl9gqRRta
 GOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlrDzUxVLwna1i3uqNjA2MP1m6GDk5
 JARMJDo7TzB1MXJxCAksZZS49/gbI0RCRuLH6TVsELawxJ9rXWwQRZ8YJRp3fmMHSbAJqEns
 PPIZrEFEQFLid9dpZhCbWSBLYufs+0wgtrCAl8TRR1tYQWwWAVWJucfawOK8AgES7xvbWCEW
 yEncPNcJ1sspECix6dNHsMVCQDXXvn5lncDIt4CRYRWjSGppcW56brGhXnFibnFpXrpecn7u
 JkZgOG479nPzDsZLG4MPMQpwMCrx8K6YZBknxJpYVlyZe4hRgoNZSYT3vD5QiDclsbIqtSg/
 vqg0J7X4EKMp0FETmaVEk/OBsZJXEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1
 CKaPiYNTqoGxKKv1qfzvLdPiC++7CnasKCrIOfhisReby2e/uwInj01h+xeyMqil8sGx5RPt
 98+bEeHb+fsD25UVmx65Lbuxzfr7BePEVTWqDEVz5F9sUJkaUyr9guUPx+ZGq8mvrzMHPlLa
 UNOU+/qgZt2f2OdL1+mtU+Q6cPrL6mnVx9IvWAluqOetvV52TImlOCPRUIu5qDgRAKMCOeJd
 AgAA
X-CMS-MailID: 20200205093315eucas1p1b77dcc2238588a6b6efb5e89aa902b6d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200205093315eucas1p1b77dcc2238588a6b6efb5e89aa902b6d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200205093315eucas1p1b77dcc2238588a6b6efb5e89aa902b6d
References: <1580895185-24341-1-git-send-email-i.kotrasinsk@partner.samsung.com>
 <CGME20200205093315eucas1p1b77dcc2238588a6b6efb5e89aa902b6d@eucas1p1.samsung.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.12
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
Cc: peter.maydell@linaro.org,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>

Signed-off-by: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
---
 hw/core/numa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index 0d1b4be..02fd7f5 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -785,8 +785,8 @@ static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
     if (mem_path) {
 #ifdef __linux__
         Error *err = NULL;
-        memory_region_init_ram_from_file(mr, owner, name, ram_size, 0, 0,
-                                         mem_path, &err);
+        memory_region_init_ram_from_file(mr, owner, name, ram_size, 0,
+                                         RAM_SHARED, mem_path, &err);
         if (err) {
             error_report_err(err);
             if (mem_prealloc) {
-- 
2.7.4


