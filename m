Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FA7C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:24:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CAF0206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GFYANrnz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CAF0206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58IF-0000DE-Ou
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:24:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582V-0007VJ-Im
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582U-000362-Gk
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:19 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42010)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582U-00035h-AP
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:18 -0500
Received: by mail-wr1-x444.google.com with SMTP id k11so1984905wrd.9
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=JZA6WWoqNvxJ8t7RB0a9zhQRcd4pYujNBUcXHYtibLo=;
 b=GFYANrnzRAH4Ceb53VS3wMUVL76i37br/wfLhM2cU54NCz6Nv4y8tFGyz8/li5dzww
 U9pF9/u0pJfieitDmJicMbzOZnw2s7dcC9oIoaPaiUmgIJh6b7N5jRtEeVwz//ovcrsR
 JMyOPD3Sq/Qp3AcrpTbTs9vYUcWGkwOuCms2GY0vFJb2ISYfwTDBtm6bI/Rm89a1JIRi
 w+TKHaqrAfIDPtbzJktM6f3ZP5THQ4LXfM80L0uO/tNgBIys505M4CIB1aiq6H/JFBrD
 /E54xqxW9IfnerU0Ib19assSmgJkMkVEdh/WVXYSoq771AbLnrBQtiRYY5BusO+k1RHt
 NJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JZA6WWoqNvxJ8t7RB0a9zhQRcd4pYujNBUcXHYtibLo=;
 b=saVfRK2Rx4Caxuzpf72cfExH+O3V3hNyY1sybROdOfGgQGfijblKDkO/H7xKnl33XF
 IBNsB1WofTLRBcaFUAiriweOc+a/OduqKNuQ0g6PZH22KE8tIyf4z+YwZZw4ay8gruMn
 rKS8e89F7LaP88TGVMrOKMRO4l6hmv+/ZIjKrTt9dcmSYA13n+eFzkL/CvKxEbYvwq/1
 YJL9WqJNPqEdHNn2HBq9EVFRAY+f0uZ9MdsuiWSitA+BRObb4sT3D9yWEWqwn/yfS9ms
 DEC/Vf/YAV49ByblJJA4uUlBZCDg8XZbyItb5eTA7FZiw31zvkCc0KIVsO21OArifnlp
 aHpg==
X-Gm-Message-State: APjAAAVeMF7pbzljnE5DxGrsFEz3fafzzwp2HyeKbWzNJAc1qretttZk
 6Bo1BtWloGLAqXenapsVUseQKTp64gAysg==
X-Google-Smtp-Source: APXvYqyZ7uCMCW+UANk5+sM+nF4zzE2mgPNuzSGRRtvva6BBtA5xZSA68ubIayFraQvWUjHryZuuAg==
X-Received: by 2002:a5d:6987:: with SMTP id g7mr47294161wru.422.1582290496812; 
 Fri, 21 Feb 2020 05:08:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.08.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/52] target/arm: Provide ARMv8.4-PMU in '-cpu max'
Date: Fri, 21 Feb 2020 13:07:16 +0000
Message-Id: <20200221130740.7583-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

Set the ID register bits to provide ARMv8.4-PMU (and implicitly
also ARMv8.1-PMU) in the 'max' CPU.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200214175116.9164-16-peter.maydell@linaro.org
---
 target/arm/cpu64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index f8f74a7ecda..c9452894035 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -703,6 +703,14 @@ static void aarch64_max_initfn(Object *obj)
         u = FIELD_DP32(u, ID_MMFR3, PAN, 2); /* ATS1E1 */
         cpu->id_mmfr3 = u;
 
+        u = cpu->isar.id_aa64dfr0;
+        u = FIELD_DP64(u, ID_AA64DFR0, PMUVER, 5); /* v8.4-PMU */
+        cpu->isar.id_aa64dfr0 = u;
+
+        u = cpu->isar.id_dfr0;
+        u = FIELD_DP32(u, ID_DFR0, PERFMON, 5); /* v8.4-PMU */
+        cpu->isar.id_dfr0 = u;
+
         /*
          * FIXME: We do not yet support ARMv8.2-fp16 for AArch32 yet,
          * so do not set MVFR1.FPHP.  Strictly speaking this is not legal,
-- 
2.20.1


