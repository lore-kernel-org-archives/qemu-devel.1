Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB84C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:46:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C41D20709
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lW6p9aiS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C41D20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jofKJ-0002Hh-AZ
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 23:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof6K-0000ef-Dz
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:28 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:39750)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof6I-00020O-St
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:28 -0400
Received: by mail-pj1-x1044.google.com with SMTP id b92so4360374pjc.4
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gdhM/fFQlCDkWJ3p0yp6CzsLc3mxWtAVqna6+gIgrh4=;
 b=lW6p9aiSCCB7RSvsyj18TqOadRDFT1YtTpTsLg8r5ue+CQyww1nVGTgpFObj8VeWri
 F1vCKTjM6pfgeb4zvswkqBw+ZFuRSciUt/4ZY23Esj8HVqyd+TSDWGLdM/yszpJEKqG7
 M48kIuQ+5IPrr3HfkhBldqI7/1IL04Rsh9SiE3d7HXzfm/OtBLh97gQUMgcd+rtHFTw7
 plSYZqPpapMABMTXg5xBf7K3n+lYxD1aMN07cqO42qaAZ8l2XDANFTPIaSFFrg3B/nhj
 MhNS5iXGS8wWceKJIrEEBXUqax8u6zRc2Yf0dtKEJybpInbBCeKfTsSLZOB3suqbux/o
 0w9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gdhM/fFQlCDkWJ3p0yp6CzsLc3mxWtAVqna6+gIgrh4=;
 b=JC/Pl5jA6BZkiH4fN6pVtu7B7kEc7y8BjYCLIlfgOY1vvWE9Q9QbkrK/EzCXG39vmk
 RDACR1VlCt/3OvL/b6zaRz4EzT4yoLgpxuCQg2e4rCvj1mzHzN1FkAOYWqLwD/xRSLH3
 mRyNpFPf2gdaUV3oumyUShgt0SX0Q23EFS4nA/lo0Fmnj9ABwTkwi29fmQIEn+hWN0s1
 bGfipwSJPFyVZL3aQkkyDCZtbyfdC8ZNkXak+PXitNuc0zFIDRTS8r+QrOflzd0bdGIE
 9c2RpK0vOeEOJuLUp/9sZQw+weeTT/enRw76YBSJsQoozsJL1IZikQKqOB7ou54eIKaB
 +bkA==
X-Gm-Message-State: AOAM532WogGas2wQmzpzHD9XhUfYyBqF2IdY/4jTZ5ymM+6pH9MkW6S4
 uOsan3bSuRbBylXSpCJJg/ndpuQN6Cg=
X-Google-Smtp-Source: ABdhPJzl0KCWwLNz5ynGQ2KIXO3H4opcQFN24/puGHFevp0n+MPicIQM3ebHFskHGsjDluhnILIrpQ==
X-Received: by 2002:a17:90a:ae11:: with SMTP id
 t17mr1230740pjq.157.1593142345186; 
 Thu, 25 Jun 2020 20:32:25 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y27sm1605256pgc.56.2020.06.25.20.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 20:32:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 29/46] target/arm: Use mte_checkN for sve unpredicated
 stores
Date: Thu, 25 Jun 2020 20:31:27 -0700
Message-Id: <20200626033144.790098-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626033144.790098-1-richard.henderson@linaro.org>
References: <20200626033144.790098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v8: Drop the out-of-line helper (pmm).
---
 target/arm/translate-sve.c | 61 +++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 11e0dfc210..4a613ca689 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4432,10 +4432,12 @@ static void do_str(DisasContext *s, uint32_t vofs, int len, int rn, int imm)
     int len_remain = len % 8;
     int nparts = len / 8 + ctpop8(len_remain);
     int midx = get_mem_index(s);
-    TCGv_i64 addr, t0;
+    TCGv_i64 dirty_addr, clean_addr, t0;
 
-    addr = tcg_temp_new_i64();
-    t0 = tcg_temp_new_i64();
+    dirty_addr = tcg_temp_new_i64();
+    tcg_gen_addi_i64(dirty_addr, cpu_reg_sp(s, rn), imm);
+    clean_addr = gen_mte_checkN(s, dirty_addr, false, rn != 31, len, MO_8);
+    tcg_temp_free_i64(dirty_addr);
 
     /* Note that unpredicated load/store of vector/predicate registers
      * are defined as a stream of bytes, which equates to little-endian
@@ -4448,33 +4450,35 @@ static void do_str(DisasContext *s, uint32_t vofs, int len, int rn, int imm)
     if (nparts <= 4) {
         int i;
 
+        t0 = tcg_temp_new_i64();
         for (i = 0; i < len_align; i += 8) {
             tcg_gen_ld_i64(t0, cpu_env, vofs + i);
-            tcg_gen_addi_i64(addr, cpu_reg_sp(s, rn), imm + i);
-            tcg_gen_qemu_st_i64(t0, addr, midx, MO_LEQ);
+            tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEQ);
+            tcg_gen_addi_i64(clean_addr, cpu_reg_sp(s, rn), 8);
         }
+        tcg_temp_free_i64(t0);
     } else {
         TCGLabel *loop = gen_new_label();
-        TCGv_ptr t2, i = tcg_const_local_ptr(0);
+        TCGv_ptr tp, i = tcg_const_local_ptr(0);
+
+        /* Copy the clean address into a local temp, live across the loop. */
+        t0 = clean_addr;
+        clean_addr = tcg_temp_local_new_i64();
+        tcg_gen_mov_i64(clean_addr, t0);
+        tcg_temp_free_i64(t0);
 
         gen_set_label(loop);
 
-        t2 = tcg_temp_new_ptr();
-        tcg_gen_add_ptr(t2, cpu_env, i);
-        tcg_gen_ld_i64(t0, t2, vofs);
-
-        /* Minimize the number of local temps that must be re-read from
-         * the stack each iteration.  Instead, re-compute values other
-         * than the loop counter.
-         */
-        tcg_gen_addi_ptr(t2, i, imm);
-        tcg_gen_extu_ptr_i64(addr, t2);
-        tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, rn));
-        tcg_temp_free_ptr(t2);
-
-        tcg_gen_qemu_st_i64(t0, addr, midx, MO_LEQ);
-
+        t0 = tcg_temp_new_i64();
+        tp = tcg_temp_new_ptr();
+        tcg_gen_add_ptr(tp, cpu_env, i);
+        tcg_gen_ld_i64(t0, tp, vofs);
         tcg_gen_addi_ptr(i, i, 8);
+        tcg_temp_free_ptr(tp);
+
+        tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEQ);
+        tcg_gen_addi_i64(clean_addr, clean_addr, 8);
+        tcg_temp_free_i64(t0);
 
         tcg_gen_brcondi_ptr(TCG_COND_LTU, i, len_align, loop);
         tcg_temp_free_ptr(i);
@@ -4482,29 +4486,30 @@ static void do_str(DisasContext *s, uint32_t vofs, int len, int rn, int imm)
 
     /* Predicate register stores can be any multiple of 2.  */
     if (len_remain) {
+        t0 = tcg_temp_new_i64();
         tcg_gen_ld_i64(t0, cpu_env, vofs + len_align);
-        tcg_gen_addi_i64(addr, cpu_reg_sp(s, rn), imm + len_align);
 
         switch (len_remain) {
         case 2:
         case 4:
         case 8:
-            tcg_gen_qemu_st_i64(t0, addr, midx, MO_LE | ctz32(len_remain));
+            tcg_gen_qemu_st_i64(t0, clean_addr, midx,
+                                MO_LE | ctz32(len_remain));
             break;
 
         case 6:
-            tcg_gen_qemu_st_i64(t0, addr, midx, MO_LEUL);
-            tcg_gen_addi_i64(addr, addr, 4);
+            tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEUL);
+            tcg_gen_addi_i64(clean_addr, clean_addr, 4);
             tcg_gen_shri_i64(t0, t0, 32);
-            tcg_gen_qemu_st_i64(t0, addr, midx, MO_LEUW);
+            tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEUW);
             break;
 
         default:
             g_assert_not_reached();
         }
+        tcg_temp_free_i64(t0);
     }
-    tcg_temp_free_i64(addr);
-    tcg_temp_free_i64(t0);
+    tcg_temp_free_i64(clean_addr);
 }
 
 static bool trans_LDR_zri(DisasContext *s, arg_rri *a)
-- 
2.25.1


