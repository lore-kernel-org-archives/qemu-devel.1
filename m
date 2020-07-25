Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5AFC433E3
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 16:07:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67AA1206D7
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 16:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="je89Ztd6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67AA1206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzMhV-0003Au-M1
	for qemu-devel@archiver.kernel.org; Sat, 25 Jul 2020 12:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jzMgP-0001sL-53
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 12:05:57 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:52426)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jzMgL-0001qu-Pr
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 12:05:56 -0400
Received: by mail-pj1-x1044.google.com with SMTP id gc9so6914557pjb.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2020 09:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gnoa1BdhL7kq2tWG7eJrriXOQiqaVJzb5Vy0Oiklyc8=;
 b=je89Ztd6wGMQ3POyBHQWGk6sexvcNih6H0rmDaVoEhwd4Bkq37z3162GMe+E1R7UVg
 VNgP6ER0tum9g2nF3w0Mu/pEZADZf2G2O0R72LmkyBk+LYbLbN/SD0rCbRdWJsYBrwOX
 c6tafMLx1WFGRtVcF1/pzt9Y+97GYWKFTOCJrAD75ElWyETlHNm4vrfpq6t2eRZK/iCU
 H3BKMvyHSoVJfZ0k6W2elej1d1VDNl4vv2FHsifty/rbsRkDq81WnkzCc8Uiqu5wW580
 mvscmBDkqRJOxxtkdAq9fRVXZcvUKKkNni/MWBiL9EO1RarpUFvqZ/VD38vbMgl8UdjT
 1bKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gnoa1BdhL7kq2tWG7eJrriXOQiqaVJzb5Vy0Oiklyc8=;
 b=sNWVR7Qk8o2hlOgzMIAQqi9gaJonK2UnKTAudFG02+DJOBsiznEhBm610DpDamwdVB
 fHWX8yByGibjqbr4Her9iiVseQDMEWurQP+ESVZXmzHLExB3AxxL6+/Q2X6Wex3UAzLO
 0r+DjLnq3ZVXqYYu9CdZ86aWFAUqtdpiE3os8qiip6yWOwvwOQxabvMygo+jhhyc4Usd
 AqVbRWuspG4AQBov+uizg1jIQ5fFP0/uJsl71K5ihM5gvKxdpMmlHh1PuLW6jMOW0LKh
 00I6jYlREf5kiM5TebRYrlui8hV9qj3C2SBlrDV+6x33uPX4CEmn82k35Od9TQ9L8LnO
 AsRQ==
X-Gm-Message-State: AOAM531xR3gYRHSGDrG7x+wVXecCb7R5ljEEqYMCQq7L8vQ1woFTP0xr
 NfnNH4nFCYyYN1FwPdPggnrNEsIlzcU=
X-Google-Smtp-Source: ABdhPJxOP+HQ85hKiLfzyefqqLK4dICoirXaIapYqCPMi1NbinBdkvSmsAGnbZBE6qRtVnYYJN4Jzw==
X-Received: by 2002:a17:902:8e86:: with SMTP id
 bg6mr13120012plb.57.1595693151407; 
 Sat, 25 Jul 2020 09:05:51 -0700 (PDT)
Received: from localhost.localdomain (216-160-65-90.tukw.qwest.net.
 [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id e18sm9731801pff.37.2020.07.25.09.05.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2020 09:05:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] tcg: update comments for save_iotlb_data in cputlb
Date: Sat, 25 Jul 2020 09:05:46 -0700
Message-Id: <20200725160548.750749-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200725160548.750749-1-richard.henderson@linaro.org>
References: <20200725160548.750749-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, "Emilio G . Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Bennée <alex.bennee@linaro.org>

I missed Emilio's review comments:

  Message-ID: <20200718205107.GA994221@sff>

and the patch got merged. Correcting the comments now.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200720122358.26881-1-alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index d370aedb47..5698292749 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1075,10 +1075,8 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
 
 /*
  * Save a potentially trashed IOTLB entry for later lookup by plugin.
- *
- * We also need to track the thread storage address because the RCU
- * cleanup that runs when we leave the critical region (the current
- * execution) is actually in a different thread.
+ * This is read by tlb_plugin_lookup if the iotlb entry doesn't match
+ * because of the side effect of io_writex changing memory layout.
  */
 static void save_iotlb_data(CPUState *cs, hwaddr addr,
                             MemoryRegionSection *section, hwaddr mr_offset)
@@ -1408,8 +1406,9 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
  * This almost never fails as the memory access being instrumented
  * should have just filled the TLB. The one corner case is io_writex
  * which can cause TLB flushes and potential resizing of the TLBs
- * loosing the information we need. In those cases we need to recover
- * data from a copy of the io_tlb entry.
+ * losing the information we need. In those cases we need to recover
+ * data from a copy of the iotlbentry. As long as this always occurs
+ * from the same thread (which a mem callback will be) this is safe.
  */
 
 bool tlb_plugin_lookup(CPUState *cpu, target_ulong addr, int mmu_idx,
-- 
2.25.1


