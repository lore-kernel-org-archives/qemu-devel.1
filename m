Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE54EC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:36:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B9D20774
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="a/pXlaqs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B9D20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNLQF-0003EI-3x
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 15:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKxl-000584-CT
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:06:57 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:35201)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKxj-000298-N8
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:06:57 -0400
Received: by mail-pf1-x434.google.com with SMTP id k8so5546445pfk.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=meqS5rEIqJ3lN5z0vmhA1onzO2c+vRq1ulNO1cDYlvo=;
 b=a/pXlaqsOfL3u8qLNjjuw19NzjYQ6sSmaIEGDa2W5kx2PwnmB8m5JUMNOCiVRe20PR
 FN93tYkmRUmOgNS8GPQkMBGlBUHsGQAcY0OLFozsz4oMcSwYYAJN9DwZXGLG2wxVIiBw
 ZibGypl6vAN8p1DfGvTkaScJHW0SoCFGmifLcbDV1c1M9bUz5C8VPpxsljrL5ye/kCOd
 GwPbIvw0Jp5KCwdtKbLd+v9THpaaj0w47OF0olB5q1p2WEY2wL4P0LcZ6Gpn7hon4Fsp
 c6axfKvHgSuYwE9y6CXDVIFGfvV1W1NyebYhNxpQeAqSBfHK2uyeUfu4EShzWGD0fRxJ
 BM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=meqS5rEIqJ3lN5z0vmhA1onzO2c+vRq1ulNO1cDYlvo=;
 b=Cn6ndTrLRg56MGbmx35z8mY+GmkScsOlsthoo12lkR9hde0Lw8NUcch7wzu3wqSsZZ
 VbMiULHovy5OB6x2EntFJTJYDB7dqjmvCxi/LSJWTmF8KzKRLhMYwmTwy4um9eAjZU+L
 /RUjeBgQSb4XZTlYRZaGnp+uRJJ3IO7/d8pQtAT2jd/ADO9yU8qtmBaq3q8YGh3K26ac
 yZ6M0q8qJOaTXVm1U3EEu1SfxKvX3ViON0K9lMoKwsuN+XwdGb1u5T7PbTlPkRffuMaA
 XZ7T+yvGv6VIIOunOLReoJNZJ1MpyxNVK+xqrRIqynv1Ep6c4eloNwLVli1YJdT+TwSG
 byWg==
X-Gm-Message-State: AOAM533+b1jmY6/tpOAJvKNlw1aMb88aIV9wpptgJvcw34EmJXhQw9ov
 MKGCOM4vMpjOdBEmTTglVWuowxITv60eaw==
X-Google-Smtp-Source: ABdhPJwQQO8BShIbOYkf696aejPX+caAw3FjHS+mOM/H5C/n9woa99caGjRROw4GggsRANjomBl67g==
X-Received: by 2002:a65:6801:: with SMTP id l1mr4345570pgt.154.1601406414271; 
 Tue, 29 Sep 2020 12:06:54 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:06:53 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 28/68] target/riscv: rvv-1.0: mask population count
 instruction
Date: Wed, 30 Sep 2020 03:04:03 +0800
Message-Id: <20200929190448.31116-29-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Frank Chang <frank.chang@sifive.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/helper.h                   | 2 +-
 target/riscv/insn32.decode              | 2 +-
 target/riscv/insn_trans/trans_rvv.c.inc | 7 ++++---
 target/riscv/vector_helper.c            | 6 +++---
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 50cca2952c..e046591a42 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1070,7 +1070,7 @@ DEF_HELPER_6(vmnor_mm, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vmornot_mm, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vmxnor_mm, void, ptr, ptr, ptr, ptr, env, i32)
 
-DEF_HELPER_4(vmpopc_m, tl, ptr, ptr, env, i32)
+DEF_HELPER_4(vpopc_m, tl, ptr, ptr, env, i32)
 
 DEF_HELPER_4(vmfirst_m, tl, ptr, ptr, env, i32)
 
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 958914458d..0cb76682a0 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -602,7 +602,7 @@ vmor_mm         011010 - ..... ..... 010 ..... 1010111 @r
 vmnor_mm        011110 - ..... ..... 010 ..... 1010111 @r
 vmornot_mm      011100 - ..... ..... 010 ..... 1010111 @r
 vmxnor_mm       011111 - ..... ..... 010 ..... 1010111 @r
-vmpopc_m        010100 . ..... ----- 010 ..... 1010111 @r2_vm
+vpopc_m         010000 . ..... 10000 010 ..... 1010111 @r2_vm
 vmfirst_m       010101 . ..... ----- 010 ..... 1010111 @r2_vm
 vmsbf_m         010110 . ..... 00001 010 ..... 1010111 @r2_vm
 vmsif_m         010110 . ..... 00011 010 ..... 1010111 @r2_vm
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 1cd0f9b8d1..f9d280b0c5 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2911,8 +2911,8 @@ GEN_MM_TRANS(vmnor_mm)
 GEN_MM_TRANS(vmornot_mm)
 GEN_MM_TRANS(vmxnor_mm)
 
-/* Vector mask population count vmpopc */
-static bool trans_vmpopc_m(DisasContext *s, arg_rmr *a)
+/* Vector mask population count vpopc */
+static bool trans_vpopc_m(DisasContext *s, arg_rmr *a)
 {
     if (require_rvv(s) &&
         vext_check_isa_ill(s)) {
@@ -2931,13 +2931,14 @@ static bool trans_vmpopc_m(DisasContext *s, arg_rmr *a)
         tcg_gen_addi_ptr(src2, cpu_env, vreg_ofs(s, a->rs2));
         tcg_gen_addi_ptr(mask, cpu_env, vreg_ofs(s, 0));
 
-        gen_helper_vmpopc_m(dst, mask, src2, cpu_env, desc);
+        gen_helper_vpopc_m(dst, mask, src2, cpu_env, desc);
         gen_set_gpr(a->rd, dst);
 
         tcg_temp_free_ptr(mask);
         tcg_temp_free_ptr(src2);
         tcg_temp_free(dst);
         tcg_temp_free_i32(desc);
+
         return true;
     }
     return false;
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 8556ab3b0d..517e7344b9 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4420,9 +4420,9 @@ GEN_VEXT_MASK_VV(vmnor_mm, DO_NOR)
 GEN_VEXT_MASK_VV(vmornot_mm, DO_ORNOT)
 GEN_VEXT_MASK_VV(vmxnor_mm, DO_XNOR)
 
-/* Vector mask population count vmpopc */
-target_ulong HELPER(vmpopc_m)(void *v0, void *vs2, CPURISCVState *env,
-                              uint32_t desc)
+/* Vector mask population count vpopc */
+target_ulong HELPER(vpopc_m)(void *v0, void *vs2, CPURISCVState *env,
+                             uint32_t desc)
 {
     target_ulong cnt = 0;
     uint32_t vm = vext_vm(desc);
-- 
2.17.1


