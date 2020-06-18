Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0CFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D7F5217A0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yLEh0+RC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D7F5217A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jln22-0001wt-9K
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 01:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmF7-0007M3-9M
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:33:37 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmF2-0003gf-Ku
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:33:36 -0400
Received: by mail-pg1-x542.google.com with SMTP id v14so2353164pgl.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xBh5uP+VsyRG2eGl2r1/scWIQoivVaaYepquCqsvaWY=;
 b=yLEh0+RCFOiEIeahemHD1DRUg6jARgCjpKs+yxEYXAuEYP7NbLBdsA8T/RDRkGX576
 cQpulVuiqEv9/I0rxqaDIo5bfPDfl4HDwkAwKJ6HgRdRu+kKHhUJ23t026trpBJpc1R4
 pD1xyQSiV0z4j9jfResay07aEmhSzRVQDFFjXZf+Vmf2Ax7ri84v4bHO2jmY3R8nwlIf
 G6bIxIMOtUPjZGYx9V2pm0nhwfjzmRZ6wvfSBzsU/HLqlQYJ9QnZ6v31wRHEpGQZnCuf
 J+65l9e9Fn9HJSpuopED1TXZHyQdMqR/KGvWviWaSehfesqVEfApbZoB2LHEvQaJNYro
 0cRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xBh5uP+VsyRG2eGl2r1/scWIQoivVaaYepquCqsvaWY=;
 b=ANJQ0hmjVbWENEZGX9F7U9B8RPV8lQyat4MBWJ+mzp/qG3xgbd3dplcSnWPGLFafz/
 lFKyTEoRzCNPxqF8jluG1HUAvqhU+AqS2zkOh1VLdLSHwD6TdXvdc4ih36O4DbuDrImp
 t5uKLEOygsDQKhFjhNSTbNzaWisWcqp5XHSvnxAJyJw5eC9e7lMh6YPsi82H8Ycj5UJ1
 c9prKaTlh7zs6WgZi8tNXQHvSK+snBe8Hb8z213DuDPsuBSu8KJ3XNPUY6n0X5Cl4pBK
 X35m02dJ/WsxwG3JNO5clEy0kGKDOvWK+XTNGooMpn1GhwKAuMERAhnqgTtAQFe6ev/S
 3vKQ==
X-Gm-Message-State: AOAM53283on5onCDt2PVqqbHuRY/RSkYd5TIgKx77PA11FD36E+oka6S
 /H6A0DLxWsjG8B8Pdlg9BytdPJobhXc=
X-Google-Smtp-Source: ABdhPJzkHxCT+1PL1yWya84LFd6sh3nr/fczKJTjrviOKJxeF1r8VnF3aT/FzIcJcdk7umuWvjvEvg==
X-Received: by 2002:a62:6404:: with SMTP id y4mr1943853pfb.92.1592454810834;
 Wed, 17 Jun 2020 21:33:30 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id q22sm1288212pfg.192.2020.06.17.21.33.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:33:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 096/100] target/arm: Share table of sve load functions
Date: Wed, 17 Jun 2020 21:26:40 -0700
Message-Id: <20200618042644.1685561-97-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
Cc: qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The table used by do_ldrq is a subset of the table used
by do_ld_zpa; we can share them by passing dtype instead
of msz to do_ldrq.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 120 ++++++++++++++++++-------------------
 1 file changed, 58 insertions(+), 62 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index f3b2463b7c..6bdff5ceca 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -5190,61 +5190,63 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
     tcg_temp_free_i32(t_desc);
 }
 
+/* Indexed by [be][dtype][nreg] */
+static gen_helper_gvec_mem * const ldr_fns[2][16][4] = {
+    /* Little-endian */
+    { { gen_helper_sve_ld1bb_r, gen_helper_sve_ld2bb_r,
+        gen_helper_sve_ld3bb_r, gen_helper_sve_ld4bb_r },
+      { gen_helper_sve_ld1bhu_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1bsu_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1bdu_r, NULL, NULL, NULL },
+
+      { gen_helper_sve_ld1sds_le_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1hh_le_r, gen_helper_sve_ld2hh_le_r,
+        gen_helper_sve_ld3hh_le_r, gen_helper_sve_ld4hh_le_r },
+      { gen_helper_sve_ld1hsu_le_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1hdu_le_r, NULL, NULL, NULL },
+
+      { gen_helper_sve_ld1hds_le_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1hss_le_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1ss_le_r, gen_helper_sve_ld2ss_le_r,
+        gen_helper_sve_ld3ss_le_r, gen_helper_sve_ld4ss_le_r },
+      { gen_helper_sve_ld1sdu_le_r, NULL, NULL, NULL },
+
+      { gen_helper_sve_ld1bds_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1bss_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1bhs_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1dd_le_r, gen_helper_sve_ld2dd_le_r,
+        gen_helper_sve_ld3dd_le_r, gen_helper_sve_ld4dd_le_r } },
+
+    /* Big-endian */
+    { { gen_helper_sve_ld1bb_r, gen_helper_sve_ld2bb_r,
+        gen_helper_sve_ld3bb_r, gen_helper_sve_ld4bb_r },
+      { gen_helper_sve_ld1bhu_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1bsu_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1bdu_r, NULL, NULL, NULL },
+
+      { gen_helper_sve_ld1sds_be_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1hh_be_r, gen_helper_sve_ld2hh_be_r,
+        gen_helper_sve_ld3hh_be_r, gen_helper_sve_ld4hh_be_r },
+      { gen_helper_sve_ld1hsu_be_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1hdu_be_r, NULL, NULL, NULL },
+
+      { gen_helper_sve_ld1hds_be_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1hss_be_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1ss_be_r, gen_helper_sve_ld2ss_be_r,
+        gen_helper_sve_ld3ss_be_r, gen_helper_sve_ld4ss_be_r },
+      { gen_helper_sve_ld1sdu_be_r, NULL, NULL, NULL },
+
+      { gen_helper_sve_ld1bds_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1bss_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1bhs_r, NULL, NULL, NULL },
+      { gen_helper_sve_ld1dd_be_r, gen_helper_sve_ld2dd_be_r,
+        gen_helper_sve_ld3dd_be_r, gen_helper_sve_ld4dd_be_r } }
+};
+
 static void do_ld_zpa(DisasContext *s, int zt, int pg,
                       TCGv_i64 addr, int dtype, int nreg)
 {
-    static gen_helper_gvec_mem * const fns[2][16][4] = {
-        /* Little-endian */
-        { { gen_helper_sve_ld1bb_r, gen_helper_sve_ld2bb_r,
-            gen_helper_sve_ld3bb_r, gen_helper_sve_ld4bb_r },
-          { gen_helper_sve_ld1bhu_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1bsu_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1bdu_r, NULL, NULL, NULL },
-
-          { gen_helper_sve_ld1sds_le_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1hh_le_r, gen_helper_sve_ld2hh_le_r,
-            gen_helper_sve_ld3hh_le_r, gen_helper_sve_ld4hh_le_r },
-          { gen_helper_sve_ld1hsu_le_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1hdu_le_r, NULL, NULL, NULL },
-
-          { gen_helper_sve_ld1hds_le_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1hss_le_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1ss_le_r, gen_helper_sve_ld2ss_le_r,
-            gen_helper_sve_ld3ss_le_r, gen_helper_sve_ld4ss_le_r },
-          { gen_helper_sve_ld1sdu_le_r, NULL, NULL, NULL },
-
-          { gen_helper_sve_ld1bds_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1bss_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1bhs_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1dd_le_r, gen_helper_sve_ld2dd_le_r,
-            gen_helper_sve_ld3dd_le_r, gen_helper_sve_ld4dd_le_r } },
-
-        /* Big-endian */
-        { { gen_helper_sve_ld1bb_r, gen_helper_sve_ld2bb_r,
-            gen_helper_sve_ld3bb_r, gen_helper_sve_ld4bb_r },
-          { gen_helper_sve_ld1bhu_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1bsu_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1bdu_r, NULL, NULL, NULL },
-
-          { gen_helper_sve_ld1sds_be_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1hh_be_r, gen_helper_sve_ld2hh_be_r,
-            gen_helper_sve_ld3hh_be_r, gen_helper_sve_ld4hh_be_r },
-          { gen_helper_sve_ld1hsu_be_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1hdu_be_r, NULL, NULL, NULL },
-
-          { gen_helper_sve_ld1hds_be_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1hss_be_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1ss_be_r, gen_helper_sve_ld2ss_be_r,
-            gen_helper_sve_ld3ss_be_r, gen_helper_sve_ld4ss_be_r },
-          { gen_helper_sve_ld1sdu_be_r, NULL, NULL, NULL },
-
-          { gen_helper_sve_ld1bds_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1bss_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1bhs_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1dd_be_r, gen_helper_sve_ld2dd_be_r,
-            gen_helper_sve_ld3dd_be_r, gen_helper_sve_ld4dd_be_r } }
-    };
-    gen_helper_gvec_mem *fn = fns[s->be_data == MO_BE][dtype][nreg];
+    gen_helper_gvec_mem *fn = ldr_fns[s->be_data == MO_BE][dtype][nreg];
 
     /* While there are holes in the table, they are not
      * accessible via the instruction encoding.
@@ -5397,14 +5399,8 @@ static bool trans_LDNF1_zpri(DisasContext *s, arg_rpri_load *a)
     return true;
 }
 
-static void do_ldrq(DisasContext *s, int zt, int pg, TCGv_i64 addr, int msz)
+static void do_ldrq(DisasContext *s, int zt, int pg, TCGv_i64 addr, int dtype)
 {
-    static gen_helper_gvec_mem * const fns[2][4] = {
-        { gen_helper_sve_ld1bb_r,    gen_helper_sve_ld1hh_le_r,
-          gen_helper_sve_ld1ss_le_r, gen_helper_sve_ld1dd_le_r },
-        { gen_helper_sve_ld1bb_r,    gen_helper_sve_ld1hh_be_r,
-          gen_helper_sve_ld1ss_be_r, gen_helper_sve_ld1dd_be_r },
-    };
     unsigned vsz = vec_full_reg_size(s);
     TCGv_ptr t_pg;
     TCGv_i32 t_desc;
@@ -5436,7 +5432,7 @@ static void do_ldrq(DisasContext *s, int zt, int pg, TCGv_i64 addr, int msz)
     t_pg = tcg_temp_new_ptr();
     tcg_gen_addi_ptr(t_pg, cpu_env, poff);
 
-    fns[s->be_data == MO_BE][msz](cpu_env, t_pg, addr, t_desc);
+    ldr_fns[s->be_data == MO_BE][dtype][0](cpu_env, t_pg, addr, t_desc);
 
     tcg_temp_free_ptr(t_pg);
     tcg_temp_free_i32(t_desc);
@@ -5458,7 +5454,7 @@ static bool trans_LD1RQ_zprr(DisasContext *s, arg_rprr_load *a)
         TCGv_i64 addr = new_tmp_a64(s);
         tcg_gen_shli_i64(addr, cpu_reg(s, a->rm), msz);
         tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, a->rn));
-        do_ldrq(s, a->rd, a->pg, addr, msz);
+        do_ldrq(s, a->rd, a->pg, addr, a->dtype);
     }
     return true;
 }
@@ -5468,7 +5464,7 @@ static bool trans_LD1RQ_zpri(DisasContext *s, arg_rpri_load *a)
     if (sve_access_check(s)) {
         TCGv_i64 addr = new_tmp_a64(s);
         tcg_gen_addi_i64(addr, cpu_reg_sp(s, a->rn), a->imm * 16);
-        do_ldrq(s, a->rd, a->pg, addr, dtype_msz(a->dtype));
+        do_ldrq(s, a->rd, a->pg, addr, a->dtype);
     }
     return true;
 }
-- 
2.25.1


