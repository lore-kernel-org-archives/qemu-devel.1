Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E5AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 19:08:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2D1020702
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 19:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZfAsh+mX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D1020702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joAkm-000654-0n
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 15:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1joAd9-000367-AG
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 15:00:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25442
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1joAd7-0004Tu-9C
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 15:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593025216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8UDbZPa3zDEE1UUML1O45YWn6QN5yhBRLIdhQszmnhc=;
 b=ZfAsh+mXoMkAcSPUxFO2dKoo+G9J1jhW6d9tbqEsV1TWQszmzlR/MnqZtht6PJk6nrSTJ8
 0GgD47igCBx0qiGT7P27ZuAixM9e2bST/7bh+AL6m+yYce5d2UUW08q9KzAbxTi8wiWYtM
 N45gY+qllwRJV6J62RZuErd/EuTe+P8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-uoT3h1jvPJyFg3Z9Fd8K9A-1; Wed, 24 Jun 2020 14:58:11 -0400
X-MC-Unique: uoT3h1jvPJyFg3Z9Fd8K9A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BE03800C60;
 Wed, 24 Jun 2020 18:58:10 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.74.8.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A12441DC;
 Wed, 24 Jun 2020 18:58:05 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 4/9] prep: add ppc-parity write method
Date: Thu, 25 Jun 2020 00:25:18 +0530
Message-Id: <20200624185523.762240-5-ppandit@redhat.com>
In-Reply-To: <20200624185523.762240-1-ppandit@redhat.com>
References: <20200624185523.762240-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Lei Sun <slei.casper@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Add ppc-parity mmio write method to avoid NULL pointer dereference
issue.

Reported-by: Lei Sun <slei.casper@gmail.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/ppc/prep_systemio.c | 8 ++++++++
 1 file changed, 8 insertions(+)

Update v2: use LOG_GUEST_ERROR
  -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg04975.html

diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
index bbc51b6e9a..03a2f8af6e 100644
--- a/hw/ppc/prep_systemio.c
+++ b/hw/ppc/prep_systemio.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
@@ -235,8 +236,15 @@ static uint64_t ppc_parity_error_readl(void *opaque, hwaddr addr,
     return val;
 }
 
+static void ppc_parity_error_writel(void *opaque, hwaddr addr,
+                                    uint64_t data, unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "%s not implemented\n", __func__);
+}
+
 static const MemoryRegionOps ppc_parity_error_ops = {
     .read = ppc_parity_error_readl,
+    .write = ppc_parity_error_writel,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
-- 
2.26.2


