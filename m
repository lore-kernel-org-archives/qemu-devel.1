Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7911C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:41:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 793BD20657
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V5ayK2Hb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 793BD20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsvPh-0001A5-PG
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 16:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60670)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMc-00041q-Qu
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMb-0003K2-PR
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:22 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42363)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsvMb-0003JA-IV
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:21 -0400
Received: by mail-pf1-x444.google.com with SMTP id q10so32498887pff.9
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 13:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7Rs0ix/SYQKzQx2FXXQO106tmFBYyCQIrr3vAmMEheQ=;
 b=V5ayK2HbCrq8lkE6uzbtB+Gh4x+wbDqsfwQvU/DsGlCULld2xwWZQ6oEk4ZWoALJuA
 6uwN/OKw9WpLikQjbhJO76mCnWqYyH+VzGSaCkwioqSitwZd4H1qc4foFdlx+vHbbfff
 d/sE8XnpavzktAWghiBaSNvvM+6wKi1HghKumI9drfM/FleAcJzrT1epZ6/E/avkwR6/
 1Cf18+Eq2YCoRDZZhhv1G/bPeQqx+do3NMXjJfgpEyfvcCHfYkEL5PHiScvFEgYKKD2C
 NbF6UzncMkRIF1uZ2FQUk3h1NF730sZSZt22C3+kCZIq/DpOVj84p5cZxWi6fu7Qjka0
 BxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7Rs0ix/SYQKzQx2FXXQO106tmFBYyCQIrr3vAmMEheQ=;
 b=qD45x25uE5eb/RZ12+X8Cy/EkWFsWVZE2of+V9UBmnW8uUdhUGl3p6rFK1Sq6MrEYL
 RxR0RhyrCRtdNR7Hu7Ail0Bo2EUFtgxzc+346Nw1urStGfbSWxVW68UL9ervxyJwXcGe
 xEA+Skf/WUFmuq7ObNAPcbVasDYHPU/Cs3XPu363MzojqSir61TTUELgIdUQHwW/SbuJ
 jA5EoLs5IdiU0lKC6xnfR2w1bwPOh0j7+3/0EJzrspiWYaMqyAT4hY/e/NH6QYpy4bBU
 1PyifXYtpmOdEcmPMpfjpgGcXO4yTZQuJ61ypBFQG7LqqfDATKovNbjBpk9rhnMeZKbO
 0PsA==
X-Gm-Message-State: APjAAAVe8CVfdrCuIXoKpDt+zvlr9TKUyXC6lKNPaMYRlQaZCIfpR9ND
 d1p3kQJMHuU2+dWphhAt6Yn2xHQuOHc=
X-Google-Smtp-Source: APXvYqzyMRv4i60Cc+tZSoFWbWciYfFyeBgjDAnRVHQlUyW0sDi1GnHafxRO8/5mQC3TXzR5lIEHHg==
X-Received: by 2002:a62:3103:: with SMTP id x3mr48307894pfx.107.1564605500394; 
 Wed, 31 Jul 2019 13:38:20 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g4sm84054164pfo.93.2019.07.31.13.38.19
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 13:38:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:37:45 -0700
Message-Id: <20190731203813.30765-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731203813.30765-1-richard.henderson@linaro.org>
References: <20190731203813.30765-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v2 04/32] target/arm: Install ASIDs for
 short-form from EL1
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is less complex than the LPAE case, but still we now avoid the
flush in case it is only the PROCID field that is changing.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2a65f4127e..c0dc76ed41 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -551,17 +551,31 @@ static void fcse_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 static void contextidr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value)
 {
-    ARMCPU *cpu = env_archcpu(env);
-
-    if (raw_read(env, ri) != value && !arm_feature(env, ARM_FEATURE_PMSA)
-        && !extended_addresses_enabled(env)) {
-        /* For VMSA (when not using the LPAE long descriptor page table
-         * format) this register includes the ASID, so do a TLB flush.
-         * For PMSA it is purely a process ID and no action is needed.
-         */
-        tlb_flush(CPU(cpu));
-    }
     raw_write(env, ri, value);
+
+    /*
+     * For VMSA (when not using the LPAE long descriptor page table format)
+     * this register includes the ASID.  For PMSA it is purely a process ID
+     * and no action is needed.
+     */
+    if (!arm_feature(env, ARM_FEATURE_PMSA) &&
+        !extended_addresses_enabled(env)) {
+        CPUState *cs = env_cpu(env);
+        int asid = extract32(value, 0, 8);
+        int idxmask;
+
+        switch (ri->secure) {
+        case ARM_CP_SECSTATE_S:
+            idxmask = ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
+            break;
+        case ARM_CP_SECSTATE_NS:
+            idxmask = ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        tlb_set_asid_for_mmuidx(cs, asid, idxmask, 0);
+    }
 }
 
 /* IS variants of TLB operations must affect all cores */
-- 
2.17.1


