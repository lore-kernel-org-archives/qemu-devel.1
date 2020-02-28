Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ECCC3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:44:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2982468D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="duU6eQxr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2982468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7ikk-0002Ms-Px
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:44:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56421)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7if5-0007GQ-VQ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7if5-0001oh-11
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:51 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:36809)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7if4-0001oB-RH
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:50 -0500
Received: by mail-wr1-x436.google.com with SMTP id j16so3687467wrt.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=nSlxCsltQjy6FqvEdHt6MRzvJ+bEsn0aUcxipAHAa08=;
 b=duU6eQxr59a/ZLa/KtZsCIruH2vUmm0JznT0rQC45r+d28EzzUbe/eOYLunn5U9Azc
 4cAQ4p7gpiVr5NJA4T/5lCEy7B1lkyOwdz0uOaoudnqCHmO1TrXe9P+PEbJHEdmi2lYa
 KsA0dtZtap3siyHcnG1qckb5ZjErQgNl3obC6PbxFYVUud5K3c+cWAvGcFN8SvbRlJ59
 94jzN65EWkjZ5PyylZJ9KIfEPbacfa8iSvCt7FFoPLTqA+Z+vmVjpGrmT49R24R1rxfN
 jnxFQGfVWHMLU4tBjUQ3PKLEpoJyJsj9Tm0kZcE7HjZ1GCuuEZ2PzM0KmfPN3BrC/Ik0
 tRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nSlxCsltQjy6FqvEdHt6MRzvJ+bEsn0aUcxipAHAa08=;
 b=iVH8mF5KAiyNzF0lKRhMDvogZIQZrF0TD8wRDSat042Edm0uQC+xRBwUNm7tuOe46L
 215JFkuYezNpSgzmo340onM3RTBuxynsGNeYukprCD+jIT4Mree4ersxqXbWVewyRGoU
 v7n/r9oacVVrsSvOMDHaBwgrtqIk0svOkK9fTQcJXKwiamymBl1KizEWzxz/JKDtbAW7
 v7FhEZ+K3jgKmWoQaaJKrfnLcpjswBhfc+L0kYDK7/8VHGEZ+FDXYRvHrEnyRWNh8/cG
 lnoDoPvqC6zdrg0fja/X+b9UFOxEwWITJqxnoEB2K02DaDKi9yqWZjKZ13ZrQpuqTfOt
 PXXg==
X-Gm-Message-State: APjAAAWG38/eUpVeU7BTPxK1RQUYLx6/e9YBysihUvBa3MJjyw3gxThH
 WwgCtdY9CBNt7H7q6QnEuPAobb3BrKoLCg==
X-Google-Smtp-Source: APXvYqzrrHqr8PrgwnmeNH5ZOwq/ND8bgckwSZ29hgVOCgwQ0qpngRjQ3u8eNI8n3Ux4ZHic3BRRyw==
X-Received: by 2002:a5d:518b:: with SMTP id k11mr5816187wrv.114.1582907929532; 
 Fri, 28 Feb 2020 08:38:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.38.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:38:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/33] cpu/arm11mpcore: Set number of GIC priority bits to 4
Date: Fri, 28 Feb 2020 16:38:13 +0000
Message-Id: <20200228163840.23585-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

The GIC built into the ARM11MPCore is always implemented with 4
priority bits; set the GIC property accordingly.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1582537164-764-4-git-send-email-sai.pavan.boddu@xilinx.com
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: tweaked commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/cpu/arm11mpcore.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/cpu/arm11mpcore.c b/hw/cpu/arm11mpcore.c
index 2e3e87cc1b3..ab9fadb67cb 100644
--- a/hw/cpu/arm11mpcore.c
+++ b/hw/cpu/arm11mpcore.c
@@ -15,6 +15,7 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 
+#define ARM11MPCORE_NUM_GIC_PRIORITY_BITS    4
 
 static void mpcore_priv_set_irq(void *opaque, int irq, int level)
 {
@@ -86,6 +87,10 @@ static void mpcore_priv_realize(DeviceState *dev, Error **errp)
 
     qdev_prop_set_uint32(gicdev, "num-cpu", s->num_cpu);
     qdev_prop_set_uint32(gicdev, "num-irq", s->num_irq);
+    qdev_prop_set_uint32(gicdev, "num-priority-bits",
+                         ARM11MPCORE_NUM_GIC_PRIORITY_BITS);
+
+
     object_property_set_bool(OBJECT(&s->gic), true, "realized", &err);
     if (err != NULL) {
         error_propagate(errp, err);
-- 
2.20.1


