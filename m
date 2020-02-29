Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59595C3F2CD
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 01:29:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 290232468D
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 01:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a6u/iGa1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 290232468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7qwX-0006aq-9r
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 20:29:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36955)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7qvU-0004jJ-VI
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:28:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7qvS-0005yZ-RF
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:28:20 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:39945)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7qvS-0005yI-MP
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:28:18 -0500
Received: by mail-pf1-x435.google.com with SMTP id b185so2590503pfb.7
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 17:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=15dGinytmIYJq1+1xe7e6vb7+URJHdY4dHT+WNni3JI=;
 b=a6u/iGa1oErJitQ224lJ8kY4ser0SN/V7YDITWcENvTLWsTQkxXuCuSYwECyOT6Fft
 weW7wJhhublhXfn2yLlcv7ClAxeXHvf73rHlrrKBtHsEZOemLohF6Nzq6q/lqQ2px2Ji
 xaEoB9G9GB1VqohQrMk5wp///AtQPURef5MY/WY0iaBscjVYIY9yAnzewUenPCrf6uec
 Thha871GE/H9N0uuYzbEVNkx0kAv1bRbYOVyp1nF3VQQ97uzSOrUJ8IZ89LFjJo+xd4j
 sWJfFoEqrR6zgw40ouMP+w0jcbAkU8iRNkDvToXe2xEbOCC1klLpoM6xXwA2X05RROAU
 XncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=15dGinytmIYJq1+1xe7e6vb7+URJHdY4dHT+WNni3JI=;
 b=SXMgVpRN8582IEpp6QhwkOdw8q59/MlR7lfWFpVifEmX/Ol5H6pKKGRFsThXQGjIij
 3Y0Bs0rdMGA1+YdfiargtmptDiQ93yGVUqetRGiJElib+eNxvy/xi38BoHBkM20gy5F5
 U7UuaN2UCQ9egulGVJEmZH9IYPpzF2K1iZIlCLAV+b4o1W8I4hQ4Xq/iHP4DqIsFtF1J
 y7ux9JXpiwf6XA3+9qo99V9bi92+N9iWYTRJmdPElHayif8jXYV0D/2m0mbjp+vPYLGd
 ECAgd/2NgvblRMK1/b4FYMER5riBPRvF5hI4bqSxAsBXoXhUYTcplFy3BWdWAOvkYOjf
 1tAA==
X-Gm-Message-State: APjAAAUJhfncB0RGvIIJb1H04elDtnYGcRXR1EZ3rzpuI/kUz05Di4HL
 e6FI3gq3LxC/PPHNpDJa4onAzzYSkmw=
X-Google-Smtp-Source: APXvYqy9TkuAsCssihXWmiBSR26dvwhgnENeHA60MQxtB3ujLg65Uwsr2qsTouDwFI8sTiAFvUKJkw==
X-Received: by 2002:a62:f842:: with SMTP id c2mr7230735pfm.104.1582939697381; 
 Fri, 28 Feb 2020 17:28:17 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm4606313pfq.126.2020.02.28.17.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 17:28:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 02/12] target/arm: Add HCR_EL2 bit definitions from ARMv8.6
Date: Fri, 28 Feb 2020 17:28:01 -0800
Message-Id: <20200229012811.24129-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200229012811.24129-1-richard.henderson@linaro.org>
References: <20200229012811.24129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::435
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0b84742b66..0ae07a72e4 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1410,6 +1410,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define HCR_TERR      (1ULL << 36)
 #define HCR_TEA       (1ULL << 37)
 #define HCR_MIOCNCE   (1ULL << 38)
+/* RES0 bit 39 */
 #define HCR_APK       (1ULL << 40)
 #define HCR_API       (1ULL << 41)
 #define HCR_NV        (1ULL << 42)
@@ -1418,13 +1419,19 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define HCR_NV2       (1ULL << 45)
 #define HCR_FWB       (1ULL << 46)
 #define HCR_FIEN      (1ULL << 47)
+/* RES0 bit 48 */
 #define HCR_TID4      (1ULL << 49)
 #define HCR_TICAB     (1ULL << 50)
+#define HCR_AMVOFFEN  (1ULL << 51)
 #define HCR_TOCU      (1ULL << 52)
+#define HCR_ENSCXT    (1ULL << 53)
 #define HCR_TTLBIS    (1ULL << 54)
 #define HCR_TTLBOS    (1ULL << 55)
 #define HCR_ATA       (1ULL << 56)
 #define HCR_DCT       (1ULL << 57)
+#define HCR_TID5      (1ULL << 58)
+#define HCR_TWEDEN    (1ULL << 59)
+#define HCR_TWEDEL    MAKE_64BIT_MASK(60, 4)
 
 #define SCR_NS                (1U << 0)
 #define SCR_IRQ               (1U << 1)
-- 
2.20.1


