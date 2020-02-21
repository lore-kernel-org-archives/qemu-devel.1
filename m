Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E716C35655
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:14:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF6E424672
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nfo2QmVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6E424672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j588o-0001ze-1y
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:14:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582A-0006hR-Gx
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j5829-0002Zc-Aq
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:07:58 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:39956)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j5829-0002YC-4R
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:07:57 -0500
Received: by mail-wr1-x432.google.com with SMTP id t3so1983166wru.7
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=nvzeMWUSUjCUFT9WRsYP0rykgD3WLIPD7Ig/88Et8tY=;
 b=Nfo2QmVemaqSnFMOj7L3uFoFV2aSeRgi4UqeSxEQWD8fS1K4Maq8wWEjlpSVl4Dn9W
 ipOsAgHKQu8v5czeF2RCJn8kNDXunzXP+ujxmEDsYbbQFjBoastQFewY7ndg5lHyC6fO
 NVk9rNV62Kl5kfu8NQ8z1sktpYIvvKck4ETIcwdA8YqoqEauS1NTpx3nBVK87g6chjEy
 t+evPldeBrUhrFEMb+DV6mE39PIGEn8fwuYuJNYR3HH/M2+oQOlzFSxnjbxxym5Y3yBe
 qvfE7EOcECSheNNM5f5TLKHxqgB+pNvQDhN0kScODJcEzWrXs0Zh2v0nuZiqg+1CjfKf
 3sSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nvzeMWUSUjCUFT9WRsYP0rykgD3WLIPD7Ig/88Et8tY=;
 b=XjQoUbFWC7F0D468Qg6HgeTQ+83AuScko1zTqyDACZOz2VbvrY1KqZfbAOg0sjYEX0
 WI83rLCmEXhyoENt8MviKB8wxclHofWnz/ziiDU+Yfcs5Y7DpU21I7/Zp0wXP2KWTpDd
 Lgvnk7dvdx9KekHcUmB+eGYndSoSPvu0pWhReOblyGcx4mqY9GCQxGQST/NlLTG/IbFf
 5i/fI0cwVDENdQYUDm4WFJqKrd8J0u9sfnuJnJRdz75JOeOvX40ChXj5xa/y4zt5M+r6
 wAPRcSZQ6iQDwne5KWjUPTqrRiGjZXsEVP3JsbOc7ibZsETwHlDOVwbG0ZROZ0PwA8E3
 1lZA==
X-Gm-Message-State: APjAAAVLF/HKbSsY9GR1aGETCADFFetKCWgG8DT9qs75dhDxWzwpyE6y
 YjIwI+JGnjh900Ksea0rlRRPQF3d8zXk5Q==
X-Google-Smtp-Source: APXvYqyGdteC5MQmaPv0JTAq1Cycp8lyGv6Dr7ehWb2RWg1fnyrgXvESiLwZ/zcrCtRWbRSpvL0aJQ==
X-Received: by 2002:adf:e683:: with SMTP id r3mr51503006wrm.38.1582290475808; 
 Fri, 21 Feb 2020 05:07:55 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.07.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:07:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/52] target/arm: Fix select for aa64_va_parameters_both
Date: Fri, 21 Feb 2020 13:06:59 +0000
Message-Id: <20200221130740.7583-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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

Select should always be 0 for a regime with one range.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200216194343.21331-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 46 +++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 366dbcf460d..b09a5012841 100644
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


