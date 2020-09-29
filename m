Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A4FC4727F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:29:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E52AC20774
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Lph2J4PS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52AC20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNLJn-0004KB-KZ
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 15:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKxM-0004VF-La
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:06:33 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:36175)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKxK-00023u-0J
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:06:32 -0400
Received: by mail-pf1-x435.google.com with SMTP id d9so5543026pfd.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=5yG0MfZOQqJVHzuLAaEhf+yBiYx6PzrZyOA3eoswGW4=;
 b=Lph2J4PS29E5W3X3TAIRY5bI7rSAOTM+lyBQ74gtEgJmqnAxwz6DLwmgA633cEs2Zm
 svuT58drPwnHF2w5pohH/IZU5G+AqPKT+TesfAb6CflnWB3yTHEgzRi+KdAtC72U4f33
 eW7RbVa8uWbSEtzhTEL01Wr57siNrR8w3FAOs2ZA+VtubqEp0bJgxk/1h/G9N8spMB2r
 WEFPKkn7AVF4x7b5k8HxJeQiLdJBtNEue8pq2BVWFX/wim7EQ2eE8jD94xSkLI7RGbzy
 DjMkTCc1XQXp6LSmmlTKYB1buu/ezYpDqDy0AIEtPU2Qm/2jORN8WX2V4HxRqVqWldZE
 +uaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=5yG0MfZOQqJVHzuLAaEhf+yBiYx6PzrZyOA3eoswGW4=;
 b=hlQc1wS0K3PMglou2lq62tB9C+0ehCPxfzCXy3bsPjGFIdAvmqhxd3NpeYmhsdgV9Q
 DL6FJQhWkW2L8Pas+YJUOOmYBFoUV4GQOeX5U28DyMiIymch6vhBFJ0NK+0iY1Enb9W6
 hOQvgCDGNhfh04+6phfpWWYe7TpJGs7wbtlWM2OFuj/8kYnFvdQANhy4CkUGHwFSSUk/
 +AUEkpIyWAoiNaH/1U4D8K76R0WBNr8oTNvCQkkxOa7FnxrE2w6BTqsLqN5wer2u/7Te
 5Ih6gc0o1RIELNImuPP+I/MueBPs1QIaay3zEcli5re88JQHK3Hg9fzV+PK8gW5G3Cex
 KUYw==
X-Gm-Message-State: AOAM533OBIfHryzW2NHat++qZsJ+oyVViSHYoLiSkTWEyWkdQysAhTPW
 aLlu8YrNnmDQ3AakZR9il6Y0KX+DGmrskg==
X-Google-Smtp-Source: ABdhPJzFXKo+Rvi43E1m/lyzRlvIwFgGc8laApRsbephh6HIzuijuGgU2rFrFoCthgZfAO1m6J6bzg==
X-Received: by 2002:a62:1410:0:b029:13e:d13d:a129 with SMTP id
 16-20020a6214100000b029013ed13da129mr5331532pfu.17.1601406388434; 
 Tue, 29 Sep 2020 12:06:28 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:06:28 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 21/68] target/riscv: rvv-1.0: fault-only-first unit stride
 load
Date: Wed, 30 Sep 2020 03:03:56 +0800
Message-Id: <20200929190448.31116-22-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x435.google.com
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
 target/riscv/helper.h                   | 27 +++---------
 target/riscv/insn32.decode              | 14 +++----
 target/riscv/insn_trans/trans_rvv.c.inc | 33 ++++-----------
 target/riscv/vector_helper.c            | 56 +++++++++----------------
 4 files changed, 39 insertions(+), 91 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index cb0f59460f..d10cce17ef 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -144,28 +144,11 @@ DEF_HELPER_6(vsxei64_8_v, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vsxei64_16_v, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vsxei64_32_v, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vsxei64_64_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_5(vlbff_v_b, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlbff_v_h, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlbff_v_w, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlbff_v_d, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlhff_v_h, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlhff_v_w, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlhff_v_d, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlwff_v_w, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlwff_v_d, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vleff_v_b, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vleff_v_h, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vleff_v_w, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vleff_v_d, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlbuff_v_b, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlbuff_v_h, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlbuff_v_w, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlbuff_v_d, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlhuff_v_h, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlhuff_v_w, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlhuff_v_d, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlwuff_v_w, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlwuff_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle8ff_v, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle16ff_v, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle32ff_v, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle64ff_v, void, ptr, ptr, tl, env, i32)
+
 #ifdef TARGET_RISCV64
 DEF_HELPER_6(vamoswapw_v_d, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vamoswapd_v_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 4e88d21ac4..866c8704d3 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -260,14 +260,6 @@ vsse16_v    ... 010 . ..... ..... 101 ..... 0100111 @r_nfvm
 vsse32_v    ... 010 . ..... ..... 110 ..... 0100111 @r_nfvm
 vsse64_v    ... 010 . ..... ..... 111 ..... 0100111 @r_nfvm
 
-vlbff_v    ... 100 . 10000 ..... 000 ..... 0000111 @r2_nfvm
-vlhff_v    ... 100 . 10000 ..... 101 ..... 0000111 @r2_nfvm
-vlwff_v    ... 100 . 10000 ..... 110 ..... 0000111 @r2_nfvm
-vleff_v    ... 000 . 10000 ..... 111 ..... 0000111 @r2_nfvm
-vlbuff_v   ... 000 . 10000 ..... 000 ..... 0000111 @r2_nfvm
-vlhuff_v   ... 000 . 10000 ..... 101 ..... 0000111 @r2_nfvm
-vlwuff_v   ... 000 . 10000 ..... 110 ..... 0000111 @r2_nfvm
-
 # Vector indexed load insns.
 vlxei8_v      ... 011 . ..... ..... 000 ..... 0000111 @r_nfvm
 vlxei16_v     ... 011 . ..... ..... 101 ..... 0000111 @r_nfvm
@@ -280,6 +272,12 @@ vsxei16_v     ... 0-1 . ..... ..... 101 ..... 0100111 @r_nfvm
 vsxei32_v     ... 0-1 . ..... ..... 110 ..... 0100111 @r_nfvm
 vsxei64_v     ... 0-1 . ..... ..... 111 ..... 0100111 @r_nfvm
 
+# Vector unit-stride fault-only-first load insns.
+vle8ff_v      ... 000 . 10000 ..... 000 ..... 0000111 @r2_nfvm
+vle16ff_v     ... 000 . 10000 ..... 101 ..... 0000111 @r2_nfvm
+vle32ff_v     ... 000 . 10000 ..... 110 ..... 0000111 @r2_nfvm
+vle64ff_v     ... 000 . 10000 ..... 111 ..... 0000111 @r2_nfvm
+
 #*** Vector AMO operations are encoded under the standard AMO major opcode ***
 vamoswapw_v     00001 . . ..... ..... 110 ..... 0101111 @r_wdvm
 vamoaddw_v      00000 . . ..... ..... 110 ..... 0101111 @r_wdvm
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 99aed12982..9bfe72aa77 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -960,28 +960,16 @@ static bool ldff_trans(uint32_t vd, uint32_t rs1, uint32_t data,
     return true;
 }
 
-static bool ldff_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
+static bool ldff_op(DisasContext *s, arg_r2nfvm *a, uint8_t eew)
 {
     uint32_t data = 0;
     gen_helper_ldst_us *fn;
-    static gen_helper_ldst_us * const fns[7][4] = {
-        { gen_helper_vlbff_v_b,  gen_helper_vlbff_v_h,
-          gen_helper_vlbff_v_w,  gen_helper_vlbff_v_d },
-        { NULL,                  gen_helper_vlhff_v_h,
-          gen_helper_vlhff_v_w,  gen_helper_vlhff_v_d },
-        { NULL,                  NULL,
-          gen_helper_vlwff_v_w,  gen_helper_vlwff_v_d },
-        { gen_helper_vleff_v_b,  gen_helper_vleff_v_h,
-          gen_helper_vleff_v_w,  gen_helper_vleff_v_d },
-        { gen_helper_vlbuff_v_b, gen_helper_vlbuff_v_h,
-          gen_helper_vlbuff_v_w, gen_helper_vlbuff_v_d },
-        { NULL,                  gen_helper_vlhuff_v_h,
-          gen_helper_vlhuff_v_w, gen_helper_vlhuff_v_d },
-        { NULL,                  NULL,
-          gen_helper_vlwuff_v_w, gen_helper_vlwuff_v_d }
+    static gen_helper_ldst_us * const fns[4] = {
+        gen_helper_vle8ff_v, gen_helper_vle16ff_v,
+        gen_helper_vle32ff_v, gen_helper_vle64ff_v
     };
 
-    fn =  fns[seq][s->sew];
+    fn = fns[eew];
     if (fn == NULL) {
         return false;
     }
@@ -992,13 +980,10 @@ static bool ldff_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
     return ldff_trans(a->rd, a->rs1, data, fn, s);
 }
 
-GEN_VEXT_TRANS(vlbff_v, 0, r2nfvm, ldff_op, ld_us_check)
-GEN_VEXT_TRANS(vlhff_v, 1, r2nfvm, ldff_op, ld_us_check)
-GEN_VEXT_TRANS(vlwff_v, 2, r2nfvm, ldff_op, ld_us_check)
-GEN_VEXT_TRANS(vleff_v, 3, r2nfvm, ldff_op, ld_us_check)
-GEN_VEXT_TRANS(vlbuff_v, 4, r2nfvm, ldff_op, ld_us_check)
-GEN_VEXT_TRANS(vlhuff_v, 5, r2nfvm, ldff_op, ld_us_check)
-GEN_VEXT_TRANS(vlwuff_v, 6, r2nfvm, ldff_op, ld_us_check)
+GEN_VEXT_TRANS(vle8ff_v,  MO_8,  r2nfvm, ldff_op, ld_us_check)
+GEN_VEXT_TRANS(vle16ff_v, MO_16, r2nfvm, ldff_op, ld_us_check)
+GEN_VEXT_TRANS(vle32ff_v, MO_32, r2nfvm, ldff_op, ld_us_check)
+GEN_VEXT_TRANS(vle64ff_v, MO_64, r2nfvm, ldff_op, ld_us_check)
 
 /*
  *** vector atomic operation
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 9349a36b41..fd398af855 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -458,7 +458,7 @@ static inline void
 vext_ldff(void *vd, void *v0, target_ulong base,
           CPURISCVState *env, uint32_t desc,
           vext_ldst_elem_fn *ldst_elem,
-          uint32_t esz, uint32_t msz, uintptr_t ra)
+          uint32_t esz, uintptr_t ra)
 {
     void *host;
     uint32_t i, k, vl = 0;
@@ -472,24 +472,24 @@ vext_ldff(void *vd, void *v0, target_ulong base,
         if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
-        addr = base + nf * i * msz;
+        addr = base + nf * i * esz;
         if (i == 0) {
-            probe_pages(env, addr, nf * msz, ra, MMU_DATA_LOAD);
+            probe_pages(env, addr, nf * esz, ra, MMU_DATA_LOAD);
         } else {
             /* if it triggers an exception, no need to check watchpoint */
-            remain = nf * msz;
+            remain = nf * esz;
             while (remain > 0) {
                 offset = -(addr | TARGET_PAGE_MASK);
                 host = tlb_vaddr_to_host(env, addr, MMU_DATA_LOAD,
                                          cpu_mmu_index(env, false));
                 if (host) {
 #ifdef CONFIG_USER_ONLY
-                    if (page_check_range(addr, nf * msz, PAGE_READ) < 0) {
+                    if (page_check_range(addr, nf * esz, PAGE_READ) < 0) {
                         vl = i;
                         goto ProbeSuccess;
                     }
 #else
-                    probe_pages(env, addr, nf * msz, ra, MMU_DATA_LOAD);
+                    probe_pages(env, addr, nf * esz, ra, MMU_DATA_LOAD);
 #endif
                 } else {
                     vl = i;
@@ -514,43 +514,25 @@ ProbeSuccess:
             continue;
         }
         while (k < nf) {
-            target_ulong addr = base + (i * nf + k) * msz;
+            target_ulong addr = base + (i * nf + k) * esz;
             ldst_elem(env, addr, i + k * vlmax, vd, ra);
             k++;
         }
     }
 }
 
-#define GEN_VEXT_LDFF(NAME, MTYPE, ETYPE, LOAD_FN)               \
-void HELPER(NAME)(void *vd, void *v0, target_ulong base,         \
-                  CPURISCVState *env, uint32_t desc)             \
-{                                                                \
-    vext_ldff(vd, v0, base, env, desc, LOAD_FN,                  \
-              sizeof(ETYPE), sizeof(MTYPE), GETPC());            \
-}
-
-GEN_VEXT_LDFF(vlbff_v_b,  int8_t,   int8_t,   ldb_b)
-GEN_VEXT_LDFF(vlbff_v_h,  int8_t,   int16_t,  ldb_h)
-GEN_VEXT_LDFF(vlbff_v_w,  int8_t,   int32_t,  ldb_w)
-GEN_VEXT_LDFF(vlbff_v_d,  int8_t,   int64_t,  ldb_d)
-GEN_VEXT_LDFF(vlhff_v_h,  int16_t,  int16_t,  ldh_h)
-GEN_VEXT_LDFF(vlhff_v_w,  int16_t,  int32_t,  ldh_w)
-GEN_VEXT_LDFF(vlhff_v_d,  int16_t,  int64_t,  ldh_d)
-GEN_VEXT_LDFF(vlwff_v_w,  int32_t,  int32_t,  ldw_w)
-GEN_VEXT_LDFF(vlwff_v_d,  int32_t,  int64_t,  ldw_d)
-GEN_VEXT_LDFF(vleff_v_b,  int8_t,   int8_t,   lde_b)
-GEN_VEXT_LDFF(vleff_v_h,  int16_t,  int16_t,  lde_h)
-GEN_VEXT_LDFF(vleff_v_w,  int32_t,  int32_t,  lde_w)
-GEN_VEXT_LDFF(vleff_v_d,  int64_t,  int64_t,  lde_d)
-GEN_VEXT_LDFF(vlbuff_v_b, uint8_t,  uint8_t,  ldbu_b)
-GEN_VEXT_LDFF(vlbuff_v_h, uint8_t,  uint16_t, ldbu_h)
-GEN_VEXT_LDFF(vlbuff_v_w, uint8_t,  uint32_t, ldbu_w)
-GEN_VEXT_LDFF(vlbuff_v_d, uint8_t,  uint64_t, ldbu_d)
-GEN_VEXT_LDFF(vlhuff_v_h, uint16_t, uint16_t, ldhu_h)
-GEN_VEXT_LDFF(vlhuff_v_w, uint16_t, uint32_t, ldhu_w)
-GEN_VEXT_LDFF(vlhuff_v_d, uint16_t, uint64_t, ldhu_d)
-GEN_VEXT_LDFF(vlwuff_v_w, uint32_t, uint32_t, ldwu_w)
-GEN_VEXT_LDFF(vlwuff_v_d, uint32_t, uint64_t, ldwu_d)
+#define GEN_VEXT_LDFF(NAME, ETYPE, LOAD_FN)               \
+void HELPER(NAME)(void *vd, void *v0, target_ulong base,  \
+                  CPURISCVState *env, uint32_t desc)      \
+{                                                         \
+    vext_ldff(vd, v0, base, env, desc, LOAD_FN,           \
+              sizeof(ETYPE), GETPC());                    \
+}
+
+GEN_VEXT_LDFF(vle8ff_v,  int8_t,  lde_b)
+GEN_VEXT_LDFF(vle16ff_v, int16_t, lde_h)
+GEN_VEXT_LDFF(vle32ff_v, int32_t, lde_w)
+GEN_VEXT_LDFF(vle64ff_v, int64_t, lde_d)
 
 /*
  *** Vector AMO Operations (Zvamo)
-- 
2.17.1


