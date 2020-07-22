Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FE2C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:34:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 918B8206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GJNkN0qo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 918B8206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyB8S-00057J-Ql
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAuB-0000fL-8F
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:19:16 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035]:50618)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAu8-0005XG-P6
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:19:14 -0400
Received: by mail-pj1-x1035.google.com with SMTP id k71so870495pje.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pkzNxNIam0e+PifZifmH8dRM/Wplj6vc8TfHyDoWJk4=;
 b=GJNkN0qol/Rlmr05feSFcV3rbhvsccp3wyo2vWOjLEMTWaNNzDIHg9w9Rw9qSSILSk
 wSlxLc3fMO9qKXosdva+TOUCAw9Dz3V85UNO4UkiNqVXztqzkLh1rZ7Cx+kQYlWfS1b7
 hYp0xbO+ye+MVYZhJDF+FA/QQeVqTs9K4xNz11dKQCsLG7JilOhPuKny/rKthajlYLE3
 SqpnkPHS3/2OCFL2qG2dIX1oR10UviW+z6cuxcyQIlziDqi5BOmFlPSO2VPS3O6jGhUr
 HBYYdG9A1lyIayLaKUQbPtr9MP1DLIcZe30r2bIxzDbBnAhPpqWax15QCGNiBPgly19X
 bjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pkzNxNIam0e+PifZifmH8dRM/Wplj6vc8TfHyDoWJk4=;
 b=snfW95ThD4d58PnFRLw8euF4nCxzEmvc3/CyAQ3m41t5kd+xe1n44mP0N+NGqXqA+4
 KtwdxSPWi3UkexTgUBaHosKTcmwYqEdTthaPeEqDFXBkZ4UlEeJPS9VTy4W4koNmrX+c
 xZH6er0zJs9tCjQjbl6iO0S4oEQfKy4eYhhGZktIgSfA9w9h9PWzXXcTWdC+Qje91hxw
 6saWe9XIWKnRnkNJGZmS/g03E3cmLO+DRvEBo0Rj9/6cyERupuIun9YUVLX2wM0WhtpF
 KvZbjlldFZXQey3tMtCpoGJ7uw1mF1gkioJCU9pZKcgT6CP9BCkq/2H1fx4zlrPpjZXj
 G3FA==
X-Gm-Message-State: AOAM533aCqnhln3wi70KWB0wLyqcxzy63EuuXffIRYqJ59ej0LCrLHuG
 jHmIhoK9vejtqNM9ycPmSqKeGwK5ypE=
X-Google-Smtp-Source: ABdhPJzku7jZBdzXWc933UETP3E6Vr7UZVuYpDHUSgqrg1xYBge9hvB55gKmY9wscVdUteVtoPeaIg==
X-Received: by 2002:a17:90a:368c:: with SMTP id
 t12mr9074869pjb.90.1595409550935; 
 Wed, 22 Jul 2020 02:19:10 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:19:10 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 23/76] target/riscv: rvv-0.9: index load and store
 instructions
Date: Wed, 22 Jul 2020 17:15:46 +0800
Message-Id: <20200722091641.8834-24-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1035.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
---
 target/riscv/helper.h                   |  67 +++++----
 target/riscv/insn32.decode              |  21 ++-
 target/riscv/insn_trans/trans_rvv.inc.c | 177 +++++++++++++++++-------
 target/riscv/vector_helper.c            |  84 ++++++-----
 4 files changed, 206 insertions(+), 143 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index db479f92cf..4890b2aa02 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -108,41 +108,38 @@ DEF_HELPER_6(vsse8_v, void, ptr, ptr, tl, tl, env, i32)
 DEF_HELPER_6(vsse16_v, void, ptr, ptr, tl, tl, env, i32)
 DEF_HELPER_6(vsse32_v, void, ptr, ptr, tl, tl, env, i32)
 DEF_HELPER_6(vsse64_v, void, ptr, ptr, tl, tl, env, i32)
-DEF_HELPER_6(vlxb_v_b, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxb_v_h, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxb_v_w, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxb_v_d, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxh_v_h, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxh_v_w, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxh_v_d, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxw_v_w, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxw_v_d, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxe_v_b, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxe_v_h, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxe_v_w, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxe_v_d, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxbu_v_b, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxbu_v_h, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxbu_v_w, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxbu_v_d, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxhu_v_h, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxhu_v_w, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxhu_v_d, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxwu_v_w, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vlxwu_v_d, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vsxb_v_b, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vsxb_v_h, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vsxb_v_w, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vsxb_v_d, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vsxh_v_h, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vsxh_v_w, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vsxh_v_d, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vsxw_v_w, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vsxw_v_d, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vsxe_v_b, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vsxe_v_h, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vsxe_v_w, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vsxe_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxei8_8_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxei8_16_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxei8_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxei8_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxei16_8_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxei16_16_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxei16_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxei16_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxei32_8_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxei32_16_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxei32_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxei32_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxei64_8_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxei64_16_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxei64_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxei64_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxei8_8_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxei8_16_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxei8_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxei8_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxei16_8_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxei16_16_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxei16_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxei16_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxei32_8_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxei32_16_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxei32_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxei32_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxei64_8_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxei64_16_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxei64_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxei64_64_v, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_5(vlbff_v_b, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vlbff_v_h, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vlbff_v_w, void, ptr, ptr, tl, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 012c844f60..46542d162e 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -257,18 +257,17 @@ vlbuff_v   ... 000 . 10000 ..... 000 ..... 0000111 @r2_nfvm
 vlhuff_v   ... 000 . 10000 ..... 101 ..... 0000111 @r2_nfvm
 vlwuff_v   ... 000 . 10000 ..... 110 ..... 0000111 @r2_nfvm
 
-vlxb_v     ... 111 . ..... ..... 000 ..... 0000111 @r_nfvm
-vlxh_v     ... 111 . ..... ..... 101 ..... 0000111 @r_nfvm
-vlxw_v     ... 111 . ..... ..... 110 ..... 0000111 @r_nfvm
-vlxe_v     ... 011 . ..... ..... 111 ..... 0000111 @r_nfvm
-vlxbu_v    ... 011 . ..... ..... 000 ..... 0000111 @r_nfvm
-vlxhu_v    ... 011 . ..... ..... 101 ..... 0000111 @r_nfvm
-vlxwu_v    ... 011 . ..... ..... 110 ..... 0000111 @r_nfvm
+# Vector indexed load insns.
+vlxei8_v      ... 011 . ..... ..... 000 ..... 0000111 @r_nfvm
+vlxei16_v     ... 011 . ..... ..... 101 ..... 0000111 @r_nfvm
+vlxei32_v     ... 011 . ..... ..... 110 ..... 0000111 @r_nfvm
+vlxei64_v     ... 011 . ..... ..... 111 ..... 0000111 @r_nfvm
+
 # Vector ordered-indexed and unordered-indexed store insns.
-vsxb_v     ... -11 . ..... ..... 000 ..... 0100111 @r_nfvm
-vsxh_v     ... -11 . ..... ..... 101 ..... 0100111 @r_nfvm
-vsxw_v     ... -11 . ..... ..... 110 ..... 0100111 @r_nfvm
-vsxe_v     ... -11 . ..... ..... 111 ..... 0100111 @r_nfvm
+vsxei8_v      ... 0-1 . ..... ..... 000 ..... 0100111 @r_nfvm
+vsxei16_v     ... 0-1 . ..... ..... 101 ..... 0100111 @r_nfvm
+vsxei32_v     ... 0-1 . ..... ..... 110 ..... 0100111 @r_nfvm
+vsxei64_v     ... 0-1 . ..... ..... 111 ..... 0100111 @r_nfvm
 
 #*** Vector AMO operations are encoded under the standard AMO major opcode ***
 vamoswapw_v     00001 . . ..... ..... 110 ..... 0101111 @r_wdvm
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index d49891ad26..b902462741 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -200,12 +200,69 @@ static bool vext_check_load(DisasContext *s, int vd, int nf, int vm)
     return vext_check_store(s, vd, nf) && require_vm(vm, vd);
 }
 
+/*
+ * Vector indexed, indexed segment store check function.
+ *
+ * Rules to be checked here:
+ *   1. EMUL must within the range: 1/8 <= EMUL <= 8. (Section 7.3)
+ *   2. Index vector register number is multiples of EMUL.
+ *      (Section 3.3.2, 7.3)
+ *   3. Destination vector register number is multiples of LMUL.
+ *      (Section 3.3.2, 7.3)
+ *   4. The EMUL setting must be such that EMUL * NFIELDS ≤ 8. (Section 7.8)
+ *   5. Vector register numbers accessed by the segment load or store
+ *      cannot increment past 31. (Section 7.8)
  */
-static bool vext_check_isa_ill(DisasContext *s)
+static bool vext_check_st_index(DisasContext *s, int vd, int vs2, int nf)
 {
-    return !s->vill;
+    uint32_t flmul_r = s->flmul < 1 ? 1 : s->flmul;
+    return (s->emul >= 0.125 && s->emul <= 8) &&
+           require_align(vs2, s->emul) &&
+           require_align(vd, s->flmul) &&
+           ((nf * flmul_r) <= (NVPR / 4) &&
+            (vd + nf * flmul_r) <= NVPR);
+}
+
+/*
+ * Vector indexed, indexed segment load check function.
+ *
+ * Rules to be checked here:
+ *   1. All rules applies to store instructions are applies
+ *      to load instructions.
+ *   2. Destination vector register group for a masked vector
+ *      instruction cannot overlap the source mask register (v0).
+ *      (Section 5.3)
+ *   3. Destination vector register cannot overlap a source vector
+ *      register (vs2) group.
+ *      (Section 5.2)
+ *   4. Destination vector register groups cannot overlap
+ *      the source vector register (vs2) group for
+ *      indexed segment load instructions. (Section 7.8.3)
+ */
+static bool vext_check_ld_index(DisasContext *s, int vd, int vs2,
+                                int nf, int vm)
+{
+    bool ret = vext_check_st_index(s, vd, vs2, nf) &&
+               require_vm(vm, vd);
+    if (s->eew > (1 << (s->sew + 3))) {
+        if (vd != vs2) {
+            ret &= require_noover(vd, s->flmul, vs2, s->emul);
+        }
+    } else if (s->eew < (1 << (s->sew + 3))) {
+        if (s->emul < 1) {
+            ret &= require_noover(vd, s->flmul, vs2, s->emul);
+        } else {
+            ret &= require_noover_widen(vd, s->flmul, vs2, s->emul);
+        }
+    }
+    if (nf > 1) {
+        ret &= (require_noover(vd, s->flmul, vs2, s->emul) &&
+                require_noover(vd, nf, vs2, 1));
+    }
+    return ret;
 }
 
+
 /*
  * Check function for vector instruction with format:
  * single-width result and single-width sources (SEW = SEW op SEW)
@@ -761,27 +818,34 @@ static bool ld_index_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
 {
     uint32_t data = 0;
     gen_helper_ldst_index *fn;
-    static gen_helper_ldst_index * const fns[7][4] = {
-        { gen_helper_vlxb_v_b,  gen_helper_vlxb_v_h,
-          gen_helper_vlxb_v_w,  gen_helper_vlxb_v_d },
-        { NULL,                 gen_helper_vlxh_v_h,
-          gen_helper_vlxh_v_w,  gen_helper_vlxh_v_d },
-        { NULL,                 NULL,
-          gen_helper_vlxw_v_w,  gen_helper_vlxw_v_d },
-        { gen_helper_vlxe_v_b,  gen_helper_vlxe_v_h,
-          gen_helper_vlxe_v_w,  gen_helper_vlxe_v_d },
-        { gen_helper_vlxbu_v_b, gen_helper_vlxbu_v_h,
-          gen_helper_vlxbu_v_w, gen_helper_vlxbu_v_d },
-        { NULL,                 gen_helper_vlxhu_v_h,
-          gen_helper_vlxhu_v_w, gen_helper_vlxhu_v_d },
-        { NULL,                 NULL,
-          gen_helper_vlxwu_v_w, gen_helper_vlxwu_v_d },
+    static gen_helper_ldst_index * const fns[4][4] = {
+        /*
+         * offset vector register group EEW = 8,
+         * data vector register group EEW = SEW
+         */
+        { gen_helper_vlxei8_8_v,  gen_helper_vlxei8_16_v,
+          gen_helper_vlxei8_32_v, gen_helper_vlxei8_64_v },
+        /*
+         * offset vector register group EEW = 16,
+         * data vector register group EEW = SEW
+         */
+        { gen_helper_vlxei16_8_v, gen_helper_vlxei16_16_v,
+          gen_helper_vlxei16_32_v, gen_helper_vlxei16_64_v },
+        /*
+         * offset vector register group EEW = 32,
+         * data vector register group EEW = SEW
+         */
+        { gen_helper_vlxei32_8_v, gen_helper_vlxei32_16_v,
+          gen_helper_vlxei32_32_v, gen_helper_vlxei32_64_v },
+        /*
+         * offset vector register group EEW = 64,
+         * data vector register group EEW = SEW
+         */
+        { gen_helper_vlxei64_8_v, gen_helper_vlxei64_16_v,
+          gen_helper_vlxei64_32_v, gen_helper_vlxei64_64_v }
     };
 
-    fn =  fns[seq][s->sew];
-    if (fn == NULL) {
-        return false;
-    }
+    fn = fns[seq][s->sew];
 
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
@@ -794,40 +858,48 @@ static bool ld_index_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
 
 static bool ld_index_check(DisasContext *s, arg_rnfvm* a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs2, false) &&
-            vext_check_nf(s, a->nf));
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_ld_index(s, a->rd, a->rs2, a->nf, a->vm);
 }
 
-GEN_VEXT_TRANS(vlxb_v, 0, rnfvm, ld_index_op, ld_index_check)
-GEN_VEXT_TRANS(vlxh_v, 1, rnfvm, ld_index_op, ld_index_check)
-GEN_VEXT_TRANS(vlxw_v, 2, rnfvm, ld_index_op, ld_index_check)
-GEN_VEXT_TRANS(vlxe_v, 3, rnfvm, ld_index_op, ld_index_check)
-GEN_VEXT_TRANS(vlxbu_v, 4, rnfvm, ld_index_op, ld_index_check)
-GEN_VEXT_TRANS(vlxhu_v, 5, rnfvm, ld_index_op, ld_index_check)
-GEN_VEXT_TRANS(vlxwu_v, 6, rnfvm, ld_index_op, ld_index_check)
+GEN_VEXT_TRANS(vlxei8_v,  8,  0, rnfvm, ld_index_op, ld_index_check)
+GEN_VEXT_TRANS(vlxei16_v, 16, 1, rnfvm, ld_index_op, ld_index_check)
+GEN_VEXT_TRANS(vlxei32_v, 32, 2, rnfvm, ld_index_op, ld_index_check)
+GEN_VEXT_TRANS(vlxei64_v, 64, 3, rnfvm, ld_index_op, ld_index_check)
 
 static bool st_index_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
 {
     uint32_t data = 0;
     gen_helper_ldst_index *fn;
     static gen_helper_ldst_index * const fns[4][4] = {
-        { gen_helper_vsxb_v_b,  gen_helper_vsxb_v_h,
-          gen_helper_vsxb_v_w,  gen_helper_vsxb_v_d },
-        { NULL,                 gen_helper_vsxh_v_h,
-          gen_helper_vsxh_v_w,  gen_helper_vsxh_v_d },
-        { NULL,                 NULL,
-          gen_helper_vsxw_v_w,  gen_helper_vsxw_v_d },
-        { gen_helper_vsxe_v_b,  gen_helper_vsxe_v_h,
-          gen_helper_vsxe_v_w,  gen_helper_vsxe_v_d }
+        /*
+         * offset vector register group EEW = 8,
+         * data vector register group EEW = SEW
+         */
+        { gen_helper_vsxei8_8_v,  gen_helper_vsxei8_16_v,
+          gen_helper_vsxei8_32_v, gen_helper_vsxei8_64_v },
+        /*
+         * offset vector register group EEW = 16,
+         * data vector register group EEW = SEW
+         */
+        { gen_helper_vsxei16_8_v, gen_helper_vsxei16_16_v,
+          gen_helper_vsxei16_32_v, gen_helper_vsxei16_64_v },
+        /*
+         * offset vector register group EEW = 32,
+         * data vector register group EEW = SEW
+         */
+        { gen_helper_vsxei32_8_v, gen_helper_vsxei32_16_v,
+          gen_helper_vsxei32_32_v, gen_helper_vsxei32_64_v },
+        /*
+         * offset vector register group EEW = 64,
+         * data vector register group EEW = SEW
+         */
+        { gen_helper_vsxei64_8_v, gen_helper_vsxei64_16_v,
+          gen_helper_vsxei64_32_v, gen_helper_vsxei64_64_v }
     };
 
-    fn =  fns[seq][s->sew];
-    if (fn == NULL) {
-        return false;
-    }
+    fn = fns[seq][s->sew];
 
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
@@ -840,16 +912,15 @@ static bool st_index_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
 
 static bool st_index_check(DisasContext *s, arg_rnfvm* a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs2, false) &&
-            vext_check_nf(s, a->nf));
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_st_index(s, a->rd, a->rs2, a->nf);
 }
 
-GEN_VEXT_TRANS(vsxb_v, 0, rnfvm, st_index_op, st_index_check)
-GEN_VEXT_TRANS(vsxh_v, 1, rnfvm, st_index_op, st_index_check)
-GEN_VEXT_TRANS(vsxw_v, 2, rnfvm, st_index_op, st_index_check)
-GEN_VEXT_TRANS(vsxe_v, 3, rnfvm, st_index_op, st_index_check)
+GEN_VEXT_TRANS(vsxei8_v,  8,  0, rnfvm, st_index_op, st_index_check)
+GEN_VEXT_TRANS(vsxei16_v, 16, 1, rnfvm, st_index_op, st_index_check)
+GEN_VEXT_TRANS(vsxei32_v, 32, 2, rnfvm, st_index_op, st_index_check)
+GEN_VEXT_TRANS(vsxei64_v, 64, 3, rnfvm, st_index_op, st_index_check)
 
 /*
  *** unit stride fault-only-first load
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 74a22fb607..13634be66a 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -459,8 +459,7 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
                 void *vs2, CPURISCVState *env, uint32_t desc,
                 vext_get_index_addr get_index_addr,
                 vext_ldst_elem_fn *ldst_elem,
-                clear_fn *clear_elem,
-                uint32_t esz, uint32_t msz, uintptr_t ra,
+                clear_fn *clear_elem, uint32_t esz, uintptr_t ra,
                 MMUAccessType access_type)
 {
     uint32_t i, k;
@@ -474,7 +473,7 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
         if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
-        probe_pages(env, get_index_addr(base, i, vs2), nf * msz, ra,
+        probe_pages(env, get_index_addr(base, i, vs2), nf * esz, ra,
                     access_type);
     }
     /* load bytes from guest memory */
@@ -484,7 +483,7 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
             continue;
         }
         while (k < nf) {
-            abi_ptr addr = get_index_addr(base, i, vs2) + k * msz;
+            abi_ptr addr = get_index_addr(base, i, vs2) + k * esz;
             ldst_elem(env, addr, i + k * vlmax, vd, ra);
             k++;
         }
@@ -498,60 +497,57 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
     }
 }
 
-#define GEN_VEXT_LD_INDEX(NAME, MTYPE, ETYPE, INDEX_FN, LOAD_FN, CLEAR_FN) \
+#define GEN_VEXT_LD_INDEX(NAME, ETYPE, INDEX_FN, LOAD_FN, CLEAR_FN)        \
 void HELPER(NAME)(void *vd, void *v0, target_ulong base,                   \
                   void *vs2, CPURISCVState *env, uint32_t desc)            \
 {                                                                          \
     vext_ldst_index(vd, v0, base, vs2, env, desc, INDEX_FN,                \
-                    LOAD_FN, CLEAR_FN, sizeof(ETYPE), sizeof(MTYPE),       \
+                    LOAD_FN, CLEAR_FN, sizeof(ETYPE),                      \
                     GETPC(), MMU_DATA_LOAD);                               \
 }
 
-GEN_VEXT_LD_INDEX(vlxb_v_b,  int8_t,   int8_t,   idx_b, ldb_b,  clearb)
-GEN_VEXT_LD_INDEX(vlxb_v_h,  int8_t,   int16_t,  idx_h, ldb_h,  clearh)
-GEN_VEXT_LD_INDEX(vlxb_v_w,  int8_t,   int32_t,  idx_w, ldb_w,  clearl)
-GEN_VEXT_LD_INDEX(vlxb_v_d,  int8_t,   int64_t,  idx_d, ldb_d,  clearq)
-GEN_VEXT_LD_INDEX(vlxh_v_h,  int16_t,  int16_t,  idx_h, ldh_h,  clearh)
-GEN_VEXT_LD_INDEX(vlxh_v_w,  int16_t,  int32_t,  idx_w, ldh_w,  clearl)
-GEN_VEXT_LD_INDEX(vlxh_v_d,  int16_t,  int64_t,  idx_d, ldh_d,  clearq)
-GEN_VEXT_LD_INDEX(vlxw_v_w,  int32_t,  int32_t,  idx_w, ldw_w,  clearl)
-GEN_VEXT_LD_INDEX(vlxw_v_d,  int32_t,  int64_t,  idx_d, ldw_d,  clearq)
-GEN_VEXT_LD_INDEX(vlxe_v_b,  int8_t,   int8_t,   idx_b, lde_b,  clearb)
-GEN_VEXT_LD_INDEX(vlxe_v_h,  int16_t,  int16_t,  idx_h, lde_h,  clearh)
-GEN_VEXT_LD_INDEX(vlxe_v_w,  int32_t,  int32_t,  idx_w, lde_w,  clearl)
-GEN_VEXT_LD_INDEX(vlxe_v_d,  int64_t,  int64_t,  idx_d, lde_d,  clearq)
-GEN_VEXT_LD_INDEX(vlxbu_v_b, uint8_t,  uint8_t,  idx_b, ldbu_b, clearb)
-GEN_VEXT_LD_INDEX(vlxbu_v_h, uint8_t,  uint16_t, idx_h, ldbu_h, clearh)
-GEN_VEXT_LD_INDEX(vlxbu_v_w, uint8_t,  uint32_t, idx_w, ldbu_w, clearl)
-GEN_VEXT_LD_INDEX(vlxbu_v_d, uint8_t,  uint64_t, idx_d, ldbu_d, clearq)
-GEN_VEXT_LD_INDEX(vlxhu_v_h, uint16_t, uint16_t, idx_h, ldhu_h, clearh)
-GEN_VEXT_LD_INDEX(vlxhu_v_w, uint16_t, uint32_t, idx_w, ldhu_w, clearl)
-GEN_VEXT_LD_INDEX(vlxhu_v_d, uint16_t, uint64_t, idx_d, ldhu_d, clearq)
-GEN_VEXT_LD_INDEX(vlxwu_v_w, uint32_t, uint32_t, idx_w, ldwu_w, clearl)
-GEN_VEXT_LD_INDEX(vlxwu_v_d, uint32_t, uint64_t, idx_d, ldwu_d, clearq)
-
-#define GEN_VEXT_ST_INDEX(NAME, MTYPE, ETYPE, INDEX_FN, STORE_FN)\
+GEN_VEXT_LD_INDEX(vlxei8_8_v,   int8_t,  idx_b, lde_b, clearb)
+GEN_VEXT_LD_INDEX(vlxei8_16_v,  int16_t, idx_b, lde_h, clearh)
+GEN_VEXT_LD_INDEX(vlxei8_32_v,  int32_t, idx_b, lde_w, clearl)
+GEN_VEXT_LD_INDEX(vlxei8_64_v,  int64_t, idx_b, lde_d, clearq)
+GEN_VEXT_LD_INDEX(vlxei16_8_v,  int8_t,  idx_h, lde_b, clearb)
+GEN_VEXT_LD_INDEX(vlxei16_16_v, int16_t, idx_h, lde_h, clearh)
+GEN_VEXT_LD_INDEX(vlxei16_32_v, int32_t, idx_h, lde_w, clearl)
+GEN_VEXT_LD_INDEX(vlxei16_64_v, int64_t, idx_h, lde_d, clearq)
+GEN_VEXT_LD_INDEX(vlxei32_8_v,  int8_t,  idx_w, lde_b, clearb)
+GEN_VEXT_LD_INDEX(vlxei32_16_v, int16_t, idx_w, lde_h, clearh)
+GEN_VEXT_LD_INDEX(vlxei32_32_v, int32_t, idx_w, lde_w, clearl)
+GEN_VEXT_LD_INDEX(vlxei32_64_v, int64_t, idx_w, lde_d, clearq)
+GEN_VEXT_LD_INDEX(vlxei64_8_v,  int8_t,  idx_d, lde_b, clearb)
+GEN_VEXT_LD_INDEX(vlxei64_16_v, int16_t, idx_d, lde_h, clearh)
+GEN_VEXT_LD_INDEX(vlxei64_32_v, int32_t, idx_d, lde_w, clearl)
+GEN_VEXT_LD_INDEX(vlxei64_64_v, int64_t, idx_d, lde_d, clearq)
+
+#define GEN_VEXT_ST_INDEX(NAME, ETYPE, INDEX_FN, STORE_FN)       \
 void HELPER(NAME)(void *vd, void *v0, target_ulong base,         \
                   void *vs2, CPURISCVState *env, uint32_t desc)  \
 {                                                                \
     vext_ldst_index(vd, v0, base, vs2, env, desc, INDEX_FN,      \
-                    STORE_FN, NULL, sizeof(ETYPE), sizeof(MTYPE),\
+                    STORE_FN, NULL, sizeof(ETYPE),               \
                     GETPC(), MMU_DATA_STORE);                    \
 }
 
-GEN_VEXT_ST_INDEX(vsxb_v_b, int8_t,  int8_t,  idx_b, stb_b)
-GEN_VEXT_ST_INDEX(vsxb_v_h, int8_t,  int16_t, idx_h, stb_h)
-GEN_VEXT_ST_INDEX(vsxb_v_w, int8_t,  int32_t, idx_w, stb_w)
-GEN_VEXT_ST_INDEX(vsxb_v_d, int8_t,  int64_t, idx_d, stb_d)
-GEN_VEXT_ST_INDEX(vsxh_v_h, int16_t, int16_t, idx_h, sth_h)
-GEN_VEXT_ST_INDEX(vsxh_v_w, int16_t, int32_t, idx_w, sth_w)
-GEN_VEXT_ST_INDEX(vsxh_v_d, int16_t, int64_t, idx_d, sth_d)
-GEN_VEXT_ST_INDEX(vsxw_v_w, int32_t, int32_t, idx_w, stw_w)
-GEN_VEXT_ST_INDEX(vsxw_v_d, int32_t, int64_t, idx_d, stw_d)
-GEN_VEXT_ST_INDEX(vsxe_v_b, int8_t,  int8_t,  idx_b, ste_b)
-GEN_VEXT_ST_INDEX(vsxe_v_h, int16_t, int16_t, idx_h, ste_h)
-GEN_VEXT_ST_INDEX(vsxe_v_w, int32_t, int32_t, idx_w, ste_w)
-GEN_VEXT_ST_INDEX(vsxe_v_d, int64_t, int64_t, idx_d, ste_d)
+GEN_VEXT_ST_INDEX(vsxei8_8_v,   int8_t,  idx_b, ste_b)
+GEN_VEXT_ST_INDEX(vsxei8_16_v,  int16_t, idx_b, ste_h)
+GEN_VEXT_ST_INDEX(vsxei8_32_v,  int32_t, idx_b, ste_w)
+GEN_VEXT_ST_INDEX(vsxei8_64_v,  int64_t, idx_b, ste_d)
+GEN_VEXT_ST_INDEX(vsxei16_8_v,  int8_t,  idx_h, ste_b)
+GEN_VEXT_ST_INDEX(vsxei16_16_v, int16_t, idx_h, ste_h)
+GEN_VEXT_ST_INDEX(vsxei16_32_v, int32_t, idx_h, ste_w)
+GEN_VEXT_ST_INDEX(vsxei16_64_v, int64_t, idx_h, ste_d)
+GEN_VEXT_ST_INDEX(vsxei32_8_v,  int8_t,  idx_w, ste_b)
+GEN_VEXT_ST_INDEX(vsxei32_16_v, int16_t, idx_w, ste_h)
+GEN_VEXT_ST_INDEX(vsxei32_32_v, int32_t, idx_w, ste_w)
+GEN_VEXT_ST_INDEX(vsxei32_64_v, int64_t, idx_w, ste_d)
+GEN_VEXT_ST_INDEX(vsxei64_8_v,  int8_t,  idx_d, ste_b)
+GEN_VEXT_ST_INDEX(vsxei64_16_v, int16_t, idx_d, ste_h)
+GEN_VEXT_ST_INDEX(vsxei64_32_v, int32_t, idx_d, ste_w)
+GEN_VEXT_ST_INDEX(vsxei64_64_v, int64_t, idx_d, ste_d)
 
 /*
  *** unit-stride fault-only-fisrt load instructions
-- 
2.17.1


