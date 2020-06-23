Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A23C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:10:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F000620CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GcBxor4W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F000620CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnpFL-00028U-A7
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 16:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnok0-000531-T5
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:56 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:43619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojv-0005t6-VY
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:56 -0400
Received: by mail-pl1-x643.google.com with SMTP id g12so9532997pll.10
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 12:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=x8aLnTbJaNLIaCAiz76x9Qe9dWMjhM4HvVRSF6yOJsA=;
 b=GcBxor4WIP3+Ief5TrQJb9n5RvCon3vQJ2ucPPEstnKSu09KllXQqe/uqHGlcNwZS1
 s9Qgsx/L70jdi6kPCkVB5CtorO10gw9YUN8WPs+6ULapqxik9iSddip7Ge1GkZF+fmt5
 QppPfqryLrj8N7YAkHn4BHHMxBvuXcnJgc9uOYa0B8VC5rCYaKNCZUr+STvLULPWUy23
 9Si05+bPTMiHukfQe7oMx9x4o2moLspgti/zYOOwd0bFAT5J54l/BT1oFLIUT90H3i1P
 Ebhz7Bb3yogW5ZwPMbry1TmVUlthk8lUPwPDvBZRH46fCcpSeog7vJjNwUdczZ8AEyav
 lM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x8aLnTbJaNLIaCAiz76x9Qe9dWMjhM4HvVRSF6yOJsA=;
 b=GwbrukYAJ0EzbIpw6cbP9tGQ6NLuP2dI+krsWhiuCcuNVwZPTqJMWLByAD8+/PaxWL
 XsejE6/fsGChEP7xriXKSAnqVI4+4QSf82LUFyWqU3lmyaAqUEC2Z5+DV4RmfGWo0L4O
 DH6lTwtq8Yg527x6aXHs7GTmnwwEcTRZvka0qb+7stt4Jsf3t5pK73QCFgi4Jn1TIKsV
 HHVaUy2iz6ixBNdFY9h6mQAnHedHhy1xQDEE00/7Wa7DkXCk2zvqXqqOYsHzwsYXSMt+
 Z4IiQQjvLZHgFAjLeoUgbaAgyv4quahGh3S4BaTIGp/y/wdMBR4vmhqVUh9ss00VHTkW
 3UDA==
X-Gm-Message-State: AOAM533WPlCpDP7+aeZ9q9WtTRy3hLkjTduv2p4VpGMjC6Z1P58uB5Rj
 NTtmxTGWAWtnlaX6hU/QrTFOFpNNGtU=
X-Google-Smtp-Source: ABdhPJxAXOL3kzfvM12NdWSHAj5gknsYnEeu3hRPpjcHoF56LzAwPqxoOoT5RU4fpvXa1MxB9E17kw==
X-Received: by 2002:a17:902:aa92:: with SMTP id
 d18mr25328419plr.210.1592941069985; 
 Tue, 23 Jun 2020 12:37:49 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p12sm17927642pfq.69.2020.06.23.12.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 12:37:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 36/45] target/arm: Handle TBI for sve scalar + int memory
 ops
Date: Tue, 23 Jun 2020 12:36:49 -0700
Message-Id: <20200623193658.623279-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623193658.623279-1-richard.henderson@linaro.org>
References: <20200623193658.623279-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We still need to handle tbi for user-only when mte is inactive.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.h | 1 +
 target/arm/translate-a64.c | 2 +-
 target/arm/translate-sve.c | 6 ++++--
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index 781c441399..49e4865918 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -40,6 +40,7 @@ TCGv_ptr get_fpstatus_ptr(bool);
 bool logic_imm_decode_wmask(uint64_t *result, unsigned int immn,
                             unsigned int imms, unsigned int immr);
 bool sve_access_check(DisasContext *s);
+TCGv_i64 clean_data_tbi(DisasContext *s, TCGv_i64 addr);
 TCGv_i64 gen_mte_check1(DisasContext *s, TCGv_i64 addr, bool is_write,
                         bool tag_checked, int log2_size);
 TCGv_i64 gen_mte_checkN(DisasContext *s, TCGv_i64 addr, bool is_write,
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index ec2295393d..f35b122ded 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -215,7 +215,7 @@ static void gen_a64_set_pc(DisasContext *s, TCGv_i64 src)
  * of the write-back address.
  */
 
-static TCGv_i64 clean_data_tbi(DisasContext *s, TCGv_i64 addr)
+TCGv_i64 clean_data_tbi(DisasContext *s, TCGv_i64 addr)
 {
     TCGv_i64 clean = new_tmp_a64(s);
 #ifdef CONFIG_USER_ONLY
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index e4fbe48493..04eda9a126 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4587,9 +4587,8 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
      * For e.g. LD4, there are not enough arguments to pass all 4
      * registers as pointers, so encode the regno into the data field.
      * For consistency, do this even for LD1.
-     * TODO: mte_n check here while callers are updated.
      */
-    if (mte_n && s->mte_active[0]) {
+    if (s->mte_active[0]) {
         int msz = dtype_msz(dtype);
 
         desc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
@@ -4599,7 +4598,10 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
         desc = FIELD_DP32(desc, MTEDESC, ESIZE, 1 << msz);
         desc = FIELD_DP32(desc, MTEDESC, TSIZE, mte_n << msz);
         desc <<= SVE_MTEDESC_SHIFT;
+    } else {
+        addr = clean_data_tbi(s, addr);
     }
+
     desc = simd_desc(vsz, vsz, zt | desc);
     t_desc = tcg_const_i32(desc);
     t_pg = tcg_temp_new_ptr();
-- 
2.25.1


