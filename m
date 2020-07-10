Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4363C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:22:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F3D320748
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="O8mIfJmz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3D320748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtsyj-0007SF-Oy
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqeE-0005dy-KI
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:52:54 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:32860)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqeC-0006mq-Fk
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:52:54 -0400
Received: by mail-pj1-x1041.google.com with SMTP id gc15so4423935pjb.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=zXYHYDSZaziuRM0VIkNPoyudqwYvSOpENroC7S+5aAA=;
 b=O8mIfJmztJoY2dYjomvoyOU1ICvHk2aTiEcIPN3i4p1mtWbXxNFda+2YqDQQElV2bn
 o8XDmSGfhb7PUAAv33UD7FFSFNPbtzzsq+qoj/RwwzRA8Yv9oqJYWNmp3teHcg6fv2Gw
 sXIPSRkD3az/KqlsuSnnXPlRa0DSeXtVO4mwcmwZBVtVhiq6nueO2xbD+1RHqvIglBFO
 setBcdRxgi17s884MPhLZKVV0sq6iiQhTZv2wZn4oDUMiwXKaTq3CjkQreqP+BKxFvD6
 OqnH7D01rVH5d1G4CFhqHQfHzDIq7yU8jT5ve3icnMZOyXBwRLPSG28saABCNcDBfgMm
 3JzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=zXYHYDSZaziuRM0VIkNPoyudqwYvSOpENroC7S+5aAA=;
 b=KMeHdKQfEcH8U01+MkXyjkI1xWObxNbYYHQQnkq5WIqAx5Mrd/598kb9VYfr9yqNJX
 Z/t2lD3/rNNF36vSM9iaC95CWMdX2jXuOl/iRNhZmd9wHTSexUWFhQSdjOHhebYvMeT8
 JRhMZVhQjXfNH1YzVPHZeeXY7BrPy8VAHCG7xQa7N9Ak/98mJ/RHbV7Cv2ssYZwDRflB
 iRp/3d3PFTZSOyN2Q4rNVjIyU6D/pJSe92imGemGLzhpY6gkC7VEGzoYLkFRmsUuSwqF
 CJwLWG6DiXe/JyK3k57P3LC0z5sUuAHxb0Gq1l9q/0hVQsyoqRr1XZHUdqEbt9TUSfJA
 3ijQ==
X-Gm-Message-State: AOAM531W3TAnMwQsmY8yXz+tLH0EUBnwZFx4mtGz8GBMj2d9qFNVu7Ue
 +TREpetSOnLi9wB5hpCRBkQBRWzkUZz7tQ==
X-Google-Smtp-Source: ABdhPJwyOaLmVmr1eVzG2H2mvrsXGEOce6wjEk+p52ims8ts9iMdICkC/H58KffKeEqyLiCMJioX3A==
X-Received: by 2002:a17:90b:4d06:: with SMTP id
 mw6mr5336195pjb.190.1594378371087; 
 Fri, 10 Jul 2020 03:52:51 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id r191sm5519406pfr.181.2020.07.10.03.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:52:50 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC 34/65] target/riscv: rvv-0.9: integer
 add-with-carry/subtract-with-borrow
Date: Fri, 10 Jul 2020 18:48:48 +0800
Message-Id: <20200710104920.13550-35-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
References: <20200710104920.13550-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Jul 2020 08:57:17 -0400
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
 target/riscv/insn32.decode              | 20 +++++-----
 target/riscv/insn_trans/trans_rvv.inc.c |  2 +-
 target/riscv/vector_helper.c            | 50 ++++++++++++++-----------
 3 files changed, 40 insertions(+), 32 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 0521ca4ab4..481f909d47 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -324,16 +324,16 @@ vwsubu_wv       110110 . ..... ..... 010 ..... 1010111 @r_vm
 vwsubu_wx       110110 . ..... ..... 110 ..... 1010111 @r_vm
 vwsub_wv        110111 . ..... ..... 010 ..... 1010111 @r_vm
 vwsub_wx        110111 . ..... ..... 110 ..... 1010111 @r_vm
-vadc_vvm        010000 1 ..... ..... 000 ..... 1010111 @r_vm_1
-vadc_vxm        010000 1 ..... ..... 100 ..... 1010111 @r_vm_1
-vadc_vim        010000 1 ..... ..... 011 ..... 1010111 @r_vm_1
-vmadc_vvm       010001 1 ..... ..... 000 ..... 1010111 @r_vm_1
-vmadc_vxm       010001 1 ..... ..... 100 ..... 1010111 @r_vm_1
-vmadc_vim       010001 1 ..... ..... 011 ..... 1010111 @r_vm_1
-vsbc_vvm        010010 1 ..... ..... 000 ..... 1010111 @r_vm_1
-vsbc_vxm        010010 1 ..... ..... 100 ..... 1010111 @r_vm_1
-vmsbc_vvm       010011 1 ..... ..... 000 ..... 1010111 @r_vm_1
-vmsbc_vxm       010011 1 ..... ..... 100 ..... 1010111 @r_vm_1
+vadc_vvm        010000 0 ..... ..... 000 ..... 1010111 @r_vm_1
+vadc_vxm        010000 0 ..... ..... 100 ..... 1010111 @r_vm_1
+vadc_vim        010000 0 ..... ..... 011 ..... 1010111 @r_vm_1
+vmadc_vvm       010001 . ..... ..... 000 ..... 1010111 @r_vm
+vmadc_vxm       010001 . ..... ..... 100 ..... 1010111 @r_vm
+vmadc_vim       010001 . ..... ..... 011 ..... 1010111 @r_vm
+vsbc_vvm        010010 0 ..... ..... 000 ..... 1010111 @r_vm_1
+vsbc_vxm        010010 0 ..... ..... 100 ..... 1010111 @r_vm_1
+vmsbc_vvm       010011 . ..... ..... 000 ..... 1010111 @r_vm
+vmsbc_vxm       010011 . ..... ..... 100 ..... 1010111 @r_vm
 vand_vv         001001 . ..... ..... 000 ..... 1010111 @r_vm
 vand_vx         001001 . ..... ..... 100 ..... 1010111 @r_vm
 vand_vi         001001 . ..... ..... 011 ..... 1010111 @r_vm
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index d90820ff6a..89a909b312 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1588,7 +1588,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
 
 /*
  * For vadc and vsbc, an illegal instruction exception is raised if the
- * destination vector register is v0 and LMUL > 1. (Section 12.3)
+ * destination vector register is v0 and LMUL > 1. (Section 12.4)
  */
 static bool opivv_vadc_check(DisasContext *s, arg_rmrr *a)
 {
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 17cc1a96e9..af4d3c6441 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -1322,24 +1322,28 @@ GEN_VEXT_VADC_VXM(vsbc_vxm_d, uint64_t, H8, DO_VSBC, clearq)
                           (__typeof(N))(N + M) < N)
 #define DO_MSBC(N, M, C) (C ? N <= M : N < M)
 
-#define GEN_VEXT_VMADC_VVM(NAME, ETYPE, H, DO_OP)             \
-void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
-                  CPURISCVState *env, uint32_t desc)          \
-{                                                             \
-    uint32_t vl = env->vl;                                    \
-    uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);        \
-    uint32_t i;                                               \
-                                                              \
-    for (i = 0; i < vl; i++) {                                \
-        ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
-        ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
-        uint8_t carry = vext_elem_mask(v0, i);                \
-                                                              \
-        vext_set_elem_mask(vd, i, DO_OP(s2, s1, carry));      \
-    }                                                         \
-    for (; i < vlmax; i++) {                                  \
-        vext_set_elem_mask(vd, i, 0);                         \
-    }                                                         \
+#define GEN_VEXT_VMADC_VVM(NAME, ETYPE, H, DO_OP)               \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,     \
+                  CPURISCVState *env, uint32_t desc)            \
+{                                                               \
+    uint32_t vl = env->vl;                                      \
+    uint32_t vlmax = vext_max_elems(desc, sizeof(ETYPE), false);\
+    uint32_t vm = vext_vm(desc);                                \
+    uint32_t vta = vext_vta(desc);                              \
+    uint32_t i;                                                 \
+                                                                \
+    for (i = 0; i < vl; i++) {                                  \
+        ETYPE s1 = *((ETYPE *)vs1 + H(i));                      \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                      \
+        uint8_t carry = !vm ? vext_elem_mask(v0, i) : 0;        \
+                                                                \
+        vext_set_elem_mask(vd, i, DO_OP(s2, s1, carry));        \
+    }                                                           \
+    if (vta == 1) {                                             \
+        for (; i < vlmax; i++) {                                \
+            vext_set_elem_mask(vd, i, 0);                       \
+        }                                                       \
+    }                                                           \
 }
 
 GEN_VEXT_VMADC_VVM(vmadc_vvm_b, uint8_t,  H1, DO_MADC)
@@ -1358,17 +1362,21 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,          \
 {                                                               \
     uint32_t vl = env->vl;                                      \
     uint32_t vlmax = vext_max_elems(desc, sizeof(ETYPE), false);\
+    uint32_t vm = vext_vm(desc);                                \
+    uint32_t vta = vext_vta(desc);                              \
     uint32_t i;                                                 \
                                                                 \
     for (i = 0; i < vl; i++) {                                  \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                      \
-        uint8_t carry = vext_elem_mask(v0, i);                  \
+        uint8_t carry = !vm ? vext_elem_mask(v0, i) : 0;         \
                                                                 \
         vext_set_elem_mask(vd, i,                               \
                 DO_OP(s2, (ETYPE)(target_long)s1, carry));      \
     }                                                           \
-    for (; i < vlmax; i++) {                                    \
-        vext_set_elem_mask(vd, i, 0);                           \
+    if (vta == 1) {                                             \
+        for (; i < vlmax; i++) {                                \
+            vext_set_elem_mask(vd, i, 0);                       \
+        }                                                       \
     }                                                           \
 }
 
-- 
2.17.1


