Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54683C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:35:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13A482068E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="evxaY1QU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A482068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iby2c-0000Qr-QQ
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 21:35:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxwh-00031M-C9
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:29:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxwf-00080c-TO
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:29:46 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43923)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxwf-0007zY-O3
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:29:45 -0500
Received: by mail-pl1-x642.google.com with SMTP id q16so995479plr.10
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g10Bq1OMZeg/ZBhQAkp+7YToyhofBnM8pkI8wVPAgyc=;
 b=evxaY1QU7cax/t6xE2PUpr+13+A251LZLRN3oAz75ntZuNfYGfS/eO5AUq4KF2KY5g
 DzLsiFAwfOz5m2V1uTm/ybHgR+ndnQfa4DoMyD9DM6SGWhMSu9cKENC0GKty7mnQYAYt
 VHklVwlgODSrS2nVTxxNv3SmHaHeXk9c7HZHltFrGT6dBXTEOjS20Um7ZOw+0xH/Fb59
 c724Twcse0A+Vd9PUBEM7TPGp0I+9ygwppyZCoezMUoYc7NWWqdSs4AX99b0ZwXrKSLF
 8AF0FxNvUbX+IYCI7FY8A5GqulKzcCB7493i+l9n+1Lhngxv4Ve+P+yPpmjNUzba6YEA
 za5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g10Bq1OMZeg/ZBhQAkp+7YToyhofBnM8pkI8wVPAgyc=;
 b=FDy0DpOaKWxMDszjMWEqi7u3/bc0dHij2QTlJ9UFeCgEW9tpCvofpiyyMip8XZepGv
 5v5XPrVB7Qb6kg3VVvWkemyB7578fPpYEaxGUEsBfP14tR5CXQ4gxHCmYW2bClwiyMOd
 pkSMIcqWP6mTlYImptl5IkiSwmMPkefuLSe2Xut+iYbRDs7u/3vA9C/R6GX42l7lRVZm
 EY2YBJVBbSDXDNn03rrPNSfzaYtDVS1HCKRJoQyE87h9kkyQ01AQAXxzyHwzqfsNaP+G
 NFRPDaDlWxTeqSrQ4+zHa5mRHOjKu+nKAgu1GO7rt1Xth6v5gPfEc6UtiT/fo6Zl8llk
 bFhw==
X-Gm-Message-State: APjAAAUH6ex20yjRUlCpq+gvCe3f2kUNnnlyPjHlnCJT2SuLnctjly7S
 YIg3VnJRiofKBdRkYm/4vIt4FaCu4C0=
X-Google-Smtp-Source: APXvYqzaVXWRlWCV6+3NUyB1ghGeoSQ0gz7MuhW59xKJzwyyHwSoFcU3vNQvrMHCdqb8HswZKsXsdA==
X-Received: by 2002:a17:902:ac8b:: with SMTP id
 h11mr2668987plr.87.1575340184343; 
 Mon, 02 Dec 2019 18:29:44 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:29:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 04/40] target/arm: Add TTBR1_EL2
Date: Mon,  2 Dec 2019 18:29:01 -0800
Message-Id: <20191203022937.1474-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203022937.1474-1-richard.henderson@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At the same time, add writefn to TTBR0_EL2 and TCR_EL2.
A later patch will update any ASID therein.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b4d774632d..06ec4641f3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3484,6 +3484,12 @@ static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     raw_write(env, ri, value);
 }
 
+static void vmsa_tcr_ttbr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                    uint64_t value)
+{
+    raw_write(env, ri, value);
+}
+
 static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
@@ -4893,10 +4899,8 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .resetvalue = 0 },
     { .name = "TCR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 2,
-      .access = PL2_RW,
-      /* no .writefn needed as this can't cause an ASID change;
-       * no .raw_writefn or .resetfn needed as we never use mask/base_mask
-       */
+      .access = PL2_RW, .writefn = vmsa_tcr_ttbr_el2_write,
+      /* no .raw_writefn or .resetfn needed as we never use mask/base_mask */
       .fieldoffset = offsetof(CPUARMState, cp15.tcr_el[2]) },
     { .name = "VTCR", .state = ARM_CP_STATE_AA32,
       .cp = 15, .opc1 = 4, .crn = 2, .crm = 1, .opc2 = 2,
@@ -4930,7 +4934,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.tpidr_el[2]) },
     { .name = "TTBR0_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 0,
-      .access = PL2_RW, .resetvalue = 0,
+      .access = PL2_RW, .resetvalue = 0, .writefn = vmsa_tcr_ttbr_el2_write,
       .fieldoffset = offsetof(CPUARMState, cp15.ttbr0_el[2]) },
     { .name = "HTTBR", .cp = 15, .opc1 = 4, .crm = 2,
       .access = PL2_RW, .type = ARM_CP_64BIT | ARM_CP_ALIAS,
@@ -6959,6 +6963,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 4, .crn = 13, .crm = 0, .opc2 = 1,
               .access = PL2_RW,
               .fieldoffset = offsetof(CPUARMState, cp15.contextidr_el[2]) },
+            { .name = "TTBR1_EL2", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 1,
+              .access = PL2_RW, .writefn = vmsa_tcr_ttbr_el2_write,
+              .fieldoffset = offsetof(CPUARMState, cp15.ttbr1_el[2]) },
             REGINFO_SENTINEL
         };
         define_arm_cp_regs(cpu, vhe_reginfo);
-- 
2.17.1


