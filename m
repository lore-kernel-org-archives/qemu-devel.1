Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05988C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:49:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C665F20637
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cbH31Di9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C665F20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTpq-0007xN-Sy
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjF-0005Tv-1a
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTj9-000250-IX
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:47 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45505)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTj9-00023a-CZ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:43 -0400
Received: by mail-pf1-x443.google.com with SMTP id 2so3750614pfg.12
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Smx0MhjIAblCuxDsW4fQawwrkcOGFEYFkfhp999nt6s=;
 b=cbH31Di9eWnm7xBxmIPPoPDx6u3hvM44tAQf8SBzLmev6t6MsJ6JKpAggJ1kdMIwfr
 29QLsWOLKIV/GBdBFAAos/1SSoYkdRQilSvqfqKDFGXMwK9VS3y9KBtq3uMMPdZRCweJ
 SSRyK9dc4ZfGdnxxXSZQC5PM2CXC7+sEe9ASQOUS0crepDcrmxQvZW65dDSxQ7kaZvH6
 zGNBjwLwSrE8O2nPwLsuYr1Df93Ch4zHAUKTJanlZW0WmY/47IveniyARmTirq4oVHt9
 Pyz6vC5hjrOVfaDZD5vkb0STwSCM16TKFFs1xGqFQUNSEauidiYeFy6byIk5AcFOulJ/
 8SbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Smx0MhjIAblCuxDsW4fQawwrkcOGFEYFkfhp999nt6s=;
 b=UfZN/wO6DVkMHPonQNeHVnfCjAhxp5pXCeCkJDap2fO67V3VcsqGQw42a6XD0wgIae
 thGaFkdxsAGCTPfyr1OOBDW3qjxKy80JbpCvhN+m+QwVQL0ixubmEsNJkvTzQS3DhseX
 MNWZjBZb9LGSIpN/8hU2jbAO9zEuYlY823KvuxYy+CLg4ChVk3lZ7uaJt9m8KatRrXKB
 8BzvZqhzwzVFCQ6oTNrs0aF1jpgBDMFpMobBGYGoOGJo7FrsiOAfsTniVImHLH3UweF1
 Q9nLGhu3fxYHrNSDv4bRRxvDSeJAvrav9wOzDiGM59D0ji3wsaZ6iU553fSf6J6Rb5fl
 q7qg==
X-Gm-Message-State: ANhLgQ3fPkt4d5d39rMcFuG1H971kh06LBmFbGcrgXplkRKjGtxdHg1Q
 w9aPunw3X1bujl4GoiA146lhy3fojCM=
X-Google-Smtp-Source: ADFU+vsUYgo0QV0IXMcrceFM0NBZFcc5/in0k4BkSy9QTqsscMASK4d+LJD/JrBlupmDKJw33F3Jaw==
X-Received: by 2002:a62:be0a:: with SMTP id l10mr10243743pff.110.1584042162090; 
 Thu, 12 Mar 2020 12:42:42 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:42:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 16/42] target/arm: Implement the STGP instruction
Date: Thu, 12 Mar 2020 12:41:53 -0700
Message-Id: <20200312194219.24406-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Handle atomicity, require pre-cleaned address.
v6: Fix constant offset shift, non-checked address, use pre-computed ata.
---
 target/arm/translate-a64.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index b99973b5b1..048140ddc0 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -2735,7 +2735,7 @@ static void disas_ld_lit(DisasContext *s, uint32_t insn)
  * +-----+-------+---+---+-------+---+-------+-------+------+------+
  *
  * opc: LDP/STP/LDNP/STNP        00 -> 32 bit, 10 -> 64 bit
- *      LDPSW                    01
+ *      LDPSW/STGP               01
  *      LDP/STP/LDNP/STNP (SIMD) 00 -> 32 bit, 01 -> 64 bit, 10 -> 128 bit
  *   V: 0 -> GPR, 1 -> Vector
  * idx: 00 -> signed offset with non-temporal hint, 01 -> post-index,
@@ -2760,6 +2760,7 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
     bool is_signed = false;
     bool postindex = false;
     bool wback = false;
+    bool set_tag = false;
 
     TCGv_i64 clean_addr, dirty_addr;
 
@@ -2772,6 +2773,14 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
 
     if (is_vector) {
         size = 2 + opc;
+    } else if (opc == 1 && !is_load) {
+        /* STGP */
+        if (!dc_isar_feature(aa64_mte_insn_reg, s) || index == 0) {
+            unallocated_encoding(s);
+            return;
+        }
+        size = 3;
+        set_tag = true;
     } else {
         size = 2 + extract32(opc, 1, 1);
         is_signed = extract32(opc, 0, 1);
@@ -2812,7 +2821,7 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
         return;
     }
 
-    offset <<= size;
+    offset <<= (set_tag ? LOG2_TAG_GRANULE : size);
 
     if (rn == 31) {
         gen_check_sp_alignment(s);
@@ -2822,8 +2831,22 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
     if (!postindex) {
         tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
     }
-    clean_addr = clean_data_tbi(s, dirty_addr);
 
+    if (set_tag) {
+        if (!s->ata) {
+             /*
+              * TODO: We could rely on the stores below, at least for
+              * system mode, if we arrange to add MO_ALIGN_16.
+              */
+            gen_helper_stg_stub(cpu_env, dirty_addr);
+        } else if (tb_cflags(s->base.tb) & CF_PARALLEL) {
+            gen_helper_stg_parallel(cpu_env, dirty_addr, dirty_addr);
+        } else {
+            gen_helper_stg(cpu_env, dirty_addr, dirty_addr);
+        }
+    }
+
+    clean_addr = clean_data_tbi(s, dirty_addr);
     if (is_vector) {
         if (is_load) {
             do_fp_ld(s, rt, clean_addr, size);
-- 
2.20.1


