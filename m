Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6FCC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:23:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 621D82084D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621D82084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cMU-0007Op-VD
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i7c3Q-0007HC-Ap
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:03:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i7c3P-0007j9-Bi
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:03:16 -0400
Received: from relay.sw.ru ([185.231.240.75]:57658)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i7c3P-0007hH-4b
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:03:15 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1i7c3L-0007PU-ON; Tue, 10 Sep 2019 12:03:11 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 12:03:10 +0300
Message-Id: <20190910090310.14032-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH] util/ioc.c: try to reassure Coverity about
 qemu_iovec_init_extended
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, stefanha@redhat.com,
 den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make it more obvious, that filling qiov corresponds to qiov allocation,
which in turn corresponds to total_niov calculation, based on mid_niov
(not mid_len). Still add an assertion to show that there should be no
difference.

Reported-by: Coverity (CID 1405302)
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 util/iov.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/util/iov.c b/util/iov.c
index 5059e10431..a4689ff3c9 100644
--- a/util/iov.c
+++ b/util/iov.c
@@ -446,7 +446,8 @@ void qemu_iovec_init_extended(
         p++;
     }
 
-    if (mid_len) {
+    assert(!mid_niov == !mid_len);
+    if (mid_niov) {
         memcpy(p, mid_iov, mid_niov * sizeof(*p));
         p[0].iov_base = (uint8_t *)p[0].iov_base + mid_head;
         p[0].iov_len -= mid_head;
-- 
2.18.0


