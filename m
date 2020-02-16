Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D2AC3B1BF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 19:48:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD4B920726
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 19:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qcYh2Upb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD4B920726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3Pu9-0001S8-Ul
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 14:48:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3PpX-0003fG-H4
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 14:43:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3PpV-0005Yf-Fg
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 14:43:51 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46027)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3PpV-0005XT-9q
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 14:43:49 -0500
Received: by mail-pf1-x443.google.com with SMTP id 2so7689141pfg.12
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 11:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Qe8zug4Z0mtaHwBh2av/LIOpMaLY4DsO8Azuq2pRmxw=;
 b=qcYh2Upbxze5Ns3eU6RcXNvldmM2IdObrKSayDRs42WJ4QhBY+tNoZzRnE0ShCA9au
 FuxvVT8L3GGw3BHXuH9MaPfYJkIRHApyxdtZrPaUXI95KDFDeDTd+zbepnxVZDewi7/6
 bqxEvwv64iz7jtJky+XhVEvq+xJijWMIF1tBvLGHjzT/Q6k4D5N/ZK86Wc2tlyOyACET
 zyFwBQdbPEhle0mWN/pbKCPEujmhLKgI85CX3vq6S0huDw4H8IEVLuroWqUXoz7zh5mr
 TDqAKxJX/4ksRhpVje4FNCtw7YFjlHwfe53u/zTyaucxd5wcQMhDCM5lQAUNt3cUluaQ
 CKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Qe8zug4Z0mtaHwBh2av/LIOpMaLY4DsO8Azuq2pRmxw=;
 b=pJqMzriT+nSOIxxpFNRUpbjcjqjUEIHjonkxeRiTTHL9TJSwvy7ghIK6JIKbZdrqbw
 P3Gey60CjfRLEw52tgTHhSLDPNQKdDjhoHmtiSEYsl0ahLXNl4StKUWyhazxR9tDuYxU
 Gri5Tac+DmxN746g/0qV8X5gNKqH1MjRjvykrfp0KVnSAfP/dtm7f29K8gzouqhDtSXh
 YKltYEI8J18r+FJWnuXTgcPsBxPjhg1PXdZkolleTgK6u1lQcG+o23qP4FvvUoUcch32
 JuuaFQRZb3a87xdSoSl0yB6sojsvd2AtUHpCI6gANOfjIilM7/9H3OOzm3ZnP8/+I/bY
 NGEA==
X-Gm-Message-State: APjAAAUm5iS6FDjCXnC2Su8u4VdZDz/BJF42Ge0A6ftcVXPMKsmovevb
 QagUsPq4DZTdV0j4QRhPl37UiK/0MPo=
X-Google-Smtp-Source: APXvYqzM5SFn+PvHAs8EArDYttG3fvKF5vfRIosEmJl2U88boAtbyY1uDGLJjFk/GRi0PubyKalGxA==
X-Received: by 2002:a63:9143:: with SMTP id l64mr8829773pge.435.1581882227941; 
 Sun, 16 Feb 2020 11:43:47 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id y127sm13945188pfg.22.2020.02.16.11.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2020 11:43:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/4] target/arm: Fix select for aa64_va_parameters_both
Date: Sun, 16 Feb 2020 11:43:41 -0800
Message-Id: <20200216194343.21331-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200216194343.21331-1-richard.henderson@linaro.org>
References: <20200216194343.21331-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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

Select should always be 0 for a regime with one range.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 46 +++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 366dbcf460..b09a501284 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10241,13 +10241,8 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
     bool tbi, tbid, epd, hpd, using16k, using64k;
     int select, tsz;
 
-    /*
-     * Bit 55 is always between the two regions, and is canonical for
-     * determining if address tagging is enabled.
-     */
-    select = extract64(va, 55, 1);
-
     if (!regime_has_2_ranges(mmu_idx)) {
+        select = 0;
         tsz = extract32(tcr, 0, 6);
         using64k = extract32(tcr, 14, 1);
         using16k = extract32(tcr, 15, 1);
@@ -10260,23 +10255,30 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
             tbid = extract32(tcr, 29, 1);
         }
         epd = false;
-    } else if (!select) {
-        tsz = extract32(tcr, 0, 6);
-        epd = extract32(tcr, 7, 1);
-        using64k = extract32(tcr, 14, 1);
-        using16k = extract32(tcr, 15, 1);
-        tbi = extract64(tcr, 37, 1);
-        hpd = extract64(tcr, 41, 1);
-        tbid = extract64(tcr, 51, 1);
     } else {
-        int tg = extract32(tcr, 30, 2);
-        using16k = tg == 1;
-        using64k = tg == 3;
-        tsz = extract32(tcr, 16, 6);
-        epd = extract32(tcr, 23, 1);
-        tbi = extract64(tcr, 38, 1);
-        hpd = extract64(tcr, 42, 1);
-        tbid = extract64(tcr, 52, 1);
+        /*
+         * Bit 55 is always between the two regions, and is canonical for
+         * determining if address tagging is enabled.
+         */
+        select = extract64(va, 55, 1);
+        if (!select) {
+            tsz = extract32(tcr, 0, 6);
+            epd = extract32(tcr, 7, 1);
+            using64k = extract32(tcr, 14, 1);
+            using16k = extract32(tcr, 15, 1);
+            tbi = extract64(tcr, 37, 1);
+            hpd = extract64(tcr, 41, 1);
+            tbid = extract64(tcr, 51, 1);
+        } else {
+            int tg = extract32(tcr, 30, 2);
+            using16k = tg == 1;
+            using64k = tg == 3;
+            tsz = extract32(tcr, 16, 6);
+            epd = extract32(tcr, 23, 1);
+            tbi = extract64(tcr, 38, 1);
+            hpd = extract64(tcr, 42, 1);
+            tbid = extract64(tcr, 52, 1);
+        }
     }
     tsz = MIN(tsz, 39);  /* TODO: ARMv8.4-TTST */
     tsz = MAX(tsz, 16);  /* TODO: ARMv8.2-LVA  */
-- 
2.20.1


