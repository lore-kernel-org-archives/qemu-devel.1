Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B11C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 13:53:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 011522064A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 13:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dGxHV+m5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 011522064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIvMJ-0000Rc-Mn
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 09:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvJB-0005kb-ES
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvJA-0003yN-C8
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:17 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:41699)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIvJA-0003y6-8o
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:16 -0400
Received: by mail-yw1-xc42.google.com with SMTP id 129so3491286ywb.8
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 06:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=pcMD6K9ABOmTlLHKMBTY6fPd9eU2rhpEHRshToPyGV0=;
 b=dGxHV+m5uqvHH6DiyrQWtbYyx7jpaXPmW2wrVX5XXMnLXk09jViHydpQ3bM0L2imtK
 T0e0fJiP0y2LJ33BwbeRChUcY/JSsnCpylRoMcaFcioU3ZWkvgt2TWSbo+GwC26i9FWK
 +Z1bRmbXk+opvgu/RTXHH2H9JRgzgGV3Hm2lptSMLA7yqIe00OToGgPf4FmosXMYseER
 Hbdg/aXTdwhSLlwXB7vRAbdW/qILAXnpVo5z8dgRrZnNCCo3Yl25keS7oo4ka+apTZwh
 TLo0E/d/L/xIqh8dE9RrabTvXPK6F0mIfkUSXd6c15FBvggmErdFL9AbEVn3DOnzHOmP
 LA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=pcMD6K9ABOmTlLHKMBTY6fPd9eU2rhpEHRshToPyGV0=;
 b=WyYV1lbiYT0asaqcOdYWuAOExD4b8Y/hoWVibsu7injS2ZmgmsB3BV7MI/K4zPqb+b
 7OXzpsGG6NdGW1l/CwxlHZUysujOFVMYGSgHyuesh3K+olKFVotSGuW8oiMDpekMB3+y
 ccTGt2qn0XwNqenWrdEjWJvSwEJ6NG1osxmlQzNC8GNmLe218eDNBqcYH0Rti/aV2CBo
 1509rH3BLUQiVbauM/WH7rceK9S6wydp5+lDRIsSR0XZOGsCB5YGHdtX9vklbLB2/4oJ
 id6PFY8mjjppRvZLEMQi0haI6ZsffvFvTn5lwooQHruGIQCLhDQs4bm1q/ZWWjFZIOxs
 Spvg==
X-Gm-Message-State: APjAAAXgAa1sfiL9dy8d7Jdmdsmh7HBgJ9GTgUy9G+kQOP62mXU7oPzl
 kOZxbzyoSCPZt2L2/PPlebg8zhfVkxM=
X-Google-Smtp-Source: APXvYqwyO/ifGAxsFCzYZ2HQlnQg3Ad2WSanLyampFnqEEMu+OZdw3Zr1kMFuPhlFbC3uo2GFuM3oQ==
X-Received: by 2002:a81:1ac4:: with SMTP id a187mr2528455ywa.482.1570801815337; 
 Fri, 11 Oct 2019 06:50:15 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id f68sm2534000ywb.96.2019.10.11.06.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 06:50:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 09/22] target/arm: Implement the SUBP instruction
Date: Fri, 11 Oct 2019 09:47:31 -0400
Message-Id: <20191011134744.2477-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011134744.2477-1-richard.henderson@linaro.org>
References: <20191011134744.2477-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Fix extraction length.
---
 target/arm/translate-a64.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 4184d65d97..cf341c98d3 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5162,19 +5162,39 @@ static void handle_crc32(DisasContext *s,
  */
 static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
 {
-    unsigned int sf, rm, opcode, rn, rd;
+    unsigned int sf, rm, opcode, rn, rd, setflag;
     sf = extract32(insn, 31, 1);
+    setflag = extract32(insn, 29, 1);
     rm = extract32(insn, 16, 5);
     opcode = extract32(insn, 10, 6);
     rn = extract32(insn, 5, 5);
     rd = extract32(insn, 0, 5);
 
-    if (extract32(insn, 29, 1)) {
+    if (setflag && opcode != 0) {
         unallocated_encoding(s);
         return;
     }
 
     switch (opcode) {
+    case 0: /* SUBP(S) */
+        if (sf == 0 || !dc_isar_feature(aa64_mte_insn_reg, s)) {
+            goto do_unallocated;
+        } else {
+            TCGv_i64 tcg_n, tcg_m, tcg_d;
+
+            tcg_n = read_cpu_reg_sp(s, rn, true);
+            tcg_m = read_cpu_reg_sp(s, rm, true);
+            tcg_gen_sextract_i64(tcg_n, tcg_n, 0, 56);
+            tcg_gen_sextract_i64(tcg_m, tcg_m, 0, 56);
+            tcg_d = cpu_reg(s, rd);
+
+            if (setflag) {
+                gen_sub_CC(true, tcg_d, tcg_n, tcg_m);
+            } else {
+                tcg_gen_sub_i64(tcg_d, tcg_n, tcg_m);
+            }
+        }
+        break;
     case 2: /* UDIV */
         handle_div(s, false, sf, rm, rn, rd);
         break;
-- 
2.17.1


