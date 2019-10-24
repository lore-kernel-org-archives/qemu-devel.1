Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EBBCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:55:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDF26205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FvlpS+bp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF26205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgOh-00070w-FO
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 12:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57955)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxt-0007YF-BX
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxr-0000qB-0H
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:57 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40265)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfxq-0000pq-QM
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:54 -0400
Received: by mail-wm1-x342.google.com with SMTP id w9so2041310wmm.5
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=WFUwsZ8ugMBSw4ZJiorvJWtT/rnVZy1+6h/U7Ubz84I=;
 b=FvlpS+bptjotcCUjpId8+EOAkiPi2lLIi++W0vtndEr+rR8s797acpZQ+qjW4LW5Ik
 7qlbhU180njZNz1xLlsmwMxE7XToRmoZy2oht1zPwbf+UlhLB+l9kXa9rJkwLjd9oYjl
 byGR5/zw2kDZJBe0cIk2kEXFw/lYNxtYuNSPbLhe5gIZqcQgDljs4Wz1rvE1w5OHW/ZK
 yoM7H7HcEu3rGtGdqvaZYUw9bZ3QwgTbRP/1jUKh6LWHB0A2Atk7gSkuhr9p11cKDP44
 s7DQQvmHEcaP+zzFzKq85nCHVHaWCmA6Z30ae0amaDsvjDNAs3MqvtlS/UXAlGWkg44p
 ZXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WFUwsZ8ugMBSw4ZJiorvJWtT/rnVZy1+6h/U7Ubz84I=;
 b=ctPSe7hB/OabZF6PR4khgI7W0uFhbZ71nzkUQrVNTDgw1Afm0lM3Bkj9N7Er8IWChL
 B3QhAE29RDVZwQyo2MXqlkUL4o0r+/PezmGkZOvAs9p6mbiGQlhYFac7cytLh5ay75oK
 DrBcft8Sj53DXh9z13IabjxIE83RX4W1Tx6UQYOBXS7upsTPmF7RRGQfhql3KUjnG2TY
 ksPN4uBnZe1a/pQvbQDK+7lTHbFI/zA3h4ZHZJ1ypgdWetmv5PoBCfslxf5cdD659OBG
 OUfAzSNw3VQPfmIol3V8DtUmW6d4tVPk1jAI0dJqAQVlEt7bsfsSCBLWLb4EV1MElQ9n
 yOgQ==
X-Gm-Message-State: APjAAAV2FAo4QU2eiFlK0t0bFei9ugnTq4IwmzCLZCCfI3TQHmz1J5/E
 0z88HVMSjwVQ4e54B+19n+RNRDoX5yw=
X-Google-Smtp-Source: APXvYqxqL1ESrVS77gWrLuFCA+1FmHqRaR1shvunrDPRZeft/BEN+q8ai01O+tXaHKbMTFPyNSMT0w==
X-Received: by 2002:a1c:7719:: with SMTP id t25mr5531511wmi.56.1571934473623; 
 Thu, 24 Oct 2019 09:27:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.27.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:27:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/51] target/arm: Rebuild hflags at Xscale SCTLR writes
Date: Thu, 24 Oct 2019 17:26:54 +0100
Message-Id: <20191024162724.31675-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

From: Richard Henderson <richard.henderson@linaro.org>

Continue setting, but not relying upon, env->hflags.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191023150057.25731-20-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index aae7b62458f..c55783e5406 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4174,6 +4174,16 @@ static void sctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     /* ??? Lots of these bits are not implemented.  */
     /* This may enable/disable the MMU, so do a TLB flush.  */
     tlb_flush(CPU(cpu));
+
+    if (ri->type & ARM_CP_SUPPRESS_TB_END) {
+        /*
+         * Normally we would always end the TB on an SCTLR write; see the
+         * comment in ARMCPRegInfo sctlr initialization below for why Xscale
+         * is special.  Setting ARM_CP_SUPPRESS_TB_END also stops the rebuild
+         * of hflags from the translator, so do it here.
+         */
+        arm_rebuild_hflags(env);
+    }
 }
 
 static CPAccessResult fpexc32_access(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.20.1


