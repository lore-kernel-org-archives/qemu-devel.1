Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644C9C38A29
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 15:59:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DE5E21D6C
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 15:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OAOk90dP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE5E21D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPpsS-00020n-CM
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 11:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jPpq0-0006yV-RR
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 11:57:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jPppz-0002mj-Hb
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 11:57:00 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:53306)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jPppz-0002lU-Bh
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 11:56:59 -0400
Received: by mail-pj1-x1044.google.com with SMTP id hi11so1829753pjb.3
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2020 08:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yo0JFxbi1JQMS1C5IWuwNJ4cHonOrcnEkwrUJKkp0u0=;
 b=OAOk90dPG7IQflKcg2lah7u11hKgaZp3mdfoPlM9YQlUqvyLaXotiOBmUqHIbxEJXt
 sS0zX5/eu6F00A4PIHUobNr76qZ+K9mT5FvoCGLqIe9y4D/Ml43uAu9W3vvwobUI7nsW
 b61GDK6aDiv/6IMTiW1jXigT4Za/s8evxh614FgOiKXa2StY1aeJ5CudLM8I2cNqU7Qk
 Au8CqPmBarbUnOTaZXovwflbGaN2gxizOMFOWXHBQV5q4WCSGHhtREdQt/xsY2lZEODW
 E0HOWSEK2m/rtxEEvtTq80cXM+Dl+x+IWiOzadSSyBOumLEFPX3Kb1UgMgMK+3bkeO7h
 Kgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yo0JFxbi1JQMS1C5IWuwNJ4cHonOrcnEkwrUJKkp0u0=;
 b=tNpgeSey7lKdVKrG15m5htDwnahIRBWgv+++7WKfUyM5rfalJTA2ka/6yiJ3/UO5Sc
 RzzF6EaI8rrk9ug9c/fOma1ZmXe0SvFuac0rd2yMIyAHGUw+mHcNv3fHTONop4d+vtio
 +4pVGHMloGsNKTbg/0+hBbdj4K4fCXgLAlZGcwU+gM8UulHJy8VCzUAQxSJV6X0EKFk7
 U2d6KBeNgkH51VVyxMbivSfz05uOxMp+7fYQjJV3iP3Hc1wgntIoozX1naPfgr7vZrfn
 mc/RY9kd3xR1Pwqzq6cr0vwo5KoJD6Zu1xuGKNL2HAgiz4sFnmEwuEOOCAtTg4GQ4+3N
 7vfA==
X-Gm-Message-State: AGi0PuY3JOICg1QOLdM8sWwx275bshkD8iDRuMvLhfFVfOb4q+UwCYIK
 xYZggm3MqQpHr25M8B+tfK2jD6Tg6Xc=
X-Google-Smtp-Source: APiQypJ4MDMhghhhF3T6drb/MXMrCCuCvV121GiBZmNkY+4F2JIvWVXpa1F78+izPB+LxtjWXBdaDQ==
X-Received: by 2002:a17:90a:aa84:: with SMTP id
 l4mr2208196pjq.177.1587225418014; 
 Sat, 18 Apr 2020 08:56:58 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m189sm13928532pfm.60.2020.04.18.08.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2020 08:56:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] target/arm: Use clear_vec_high more effectively
Date: Sat, 18 Apr 2020 08:56:51 -0700
Message-Id: <20200418155651.3901-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418155651.3901-1-richard.henderson@linaro.org>
References: <20200418155651.3901-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not explicitly store zero to the NEON high part
when we can pass !is_q to clear_vec_high.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 59 +++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 23 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d57aa54d6a..bf82a2e115 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -948,11 +948,10 @@ static void do_fp_ld(DisasContext *s, int destidx, TCGv_i64 tcg_addr, int size)
 {
     /* This always zero-extends and writes to a full 128 bit wide vector */
     TCGv_i64 tmplo = tcg_temp_new_i64();
-    TCGv_i64 tmphi;
+    TCGv_i64 tmphi = NULL;
 
     if (size < 4) {
         MemOp memop = s->be_data + size;
-        tmphi = tcg_const_i64(0);
         tcg_gen_qemu_ld_i64(tmplo, tcg_addr, get_mem_index(s), memop);
     } else {
         bool be = s->be_data == MO_BE;
@@ -970,12 +969,13 @@ static void do_fp_ld(DisasContext *s, int destidx, TCGv_i64 tcg_addr, int size)
     }
 
     tcg_gen_st_i64(tmplo, cpu_env, fp_reg_offset(s, destidx, MO_64));
-    tcg_gen_st_i64(tmphi, cpu_env, fp_reg_hi_offset(s, destidx));
-
     tcg_temp_free_i64(tmplo);
-    tcg_temp_free_i64(tmphi);
 
-    clear_vec_high(s, true, destidx);
+    if (tmphi) {
+        tcg_gen_st_i64(tmphi, cpu_env, fp_reg_hi_offset(s, destidx));
+        tcg_temp_free_i64(tmphi);
+    }
+    clear_vec_high(s, tmphi != NULL, destidx);
 }
 
 /*
@@ -6969,8 +6969,8 @@ static void disas_simd_ext(DisasContext *s, uint32_t insn)
         return;
     }
 
-    tcg_resh = tcg_temp_new_i64();
     tcg_resl = tcg_temp_new_i64();
+    tcg_resh = NULL;
 
     /* Vd gets bits starting at pos bits into Vm:Vn. This is
      * either extracting 128 bits from a 128:128 concatenation, or
@@ -6982,7 +6982,6 @@ static void disas_simd_ext(DisasContext *s, uint32_t insn)
             read_vec_element(s, tcg_resh, rm, 0, MO_64);
             do_ext64(s, tcg_resh, tcg_resl, pos);
         }
-        tcg_gen_movi_i64(tcg_resh, 0);
     } else {
         TCGv_i64 tcg_hh;
         typedef struct {
@@ -6997,6 +6996,7 @@ static void disas_simd_ext(DisasContext *s, uint32_t insn)
             pos -= 64;
         }
 
+        tcg_resh = tcg_temp_new_i64();
         read_vec_element(s, tcg_resl, elt->reg, elt->elt, MO_64);
         elt++;
         read_vec_element(s, tcg_resh, elt->reg, elt->elt, MO_64);
@@ -7012,9 +7012,12 @@ static void disas_simd_ext(DisasContext *s, uint32_t insn)
 
     write_vec_element(s, tcg_resl, rd, 0, MO_64);
     tcg_temp_free_i64(tcg_resl);
-    write_vec_element(s, tcg_resh, rd, 1, MO_64);
-    tcg_temp_free_i64(tcg_resh);
-    clear_vec_high(s, true, rd);
+
+    if (is_q) {
+        write_vec_element(s, tcg_resh, rd, 1, MO_64);
+        tcg_temp_free_i64(tcg_resh);
+    }
+    clear_vec_high(s, is_q, rd);
 }
 
 /* TBL/TBX
@@ -7051,17 +7054,21 @@ static void disas_simd_tb(DisasContext *s, uint32_t insn)
      * the input.
      */
     tcg_resl = tcg_temp_new_i64();
-    tcg_resh = tcg_temp_new_i64();
+    tcg_resh = NULL;
 
     if (is_tblx) {
         read_vec_element(s, tcg_resl, rd, 0, MO_64);
     } else {
         tcg_gen_movi_i64(tcg_resl, 0);
     }
-    if (is_tblx && is_q) {
-        read_vec_element(s, tcg_resh, rd, 1, MO_64);
-    } else {
-        tcg_gen_movi_i64(tcg_resh, 0);
+
+    if (is_q) {
+        tcg_resh = tcg_temp_new_i64();
+        if (is_tblx) {
+            read_vec_element(s, tcg_resh, rd, 1, MO_64);
+        } else {
+            tcg_gen_movi_i64(tcg_resh, 0);
+        }
     }
 
     tcg_idx = tcg_temp_new_i64();
@@ -7081,9 +7088,12 @@ static void disas_simd_tb(DisasContext *s, uint32_t insn)
 
     write_vec_element(s, tcg_resl, rd, 0, MO_64);
     tcg_temp_free_i64(tcg_resl);
-    write_vec_element(s, tcg_resh, rd, 1, MO_64);
-    tcg_temp_free_i64(tcg_resh);
-    clear_vec_high(s, true, rd);
+
+    if (is_q) {
+        write_vec_element(s, tcg_resh, rd, 1, MO_64);
+        tcg_temp_free_i64(tcg_resh);
+    }
+    clear_vec_high(s, is_q, rd);
 }
 
 /* ZIP/UZP/TRN
@@ -7120,7 +7130,7 @@ static void disas_simd_zip_trn(DisasContext *s, uint32_t insn)
     }
 
     tcg_resl = tcg_const_i64(0);
-    tcg_resh = tcg_const_i64(0);
+    tcg_resh = is_q ? tcg_const_i64(0) : NULL;
     tcg_res = tcg_temp_new_i64();
 
     for (i = 0; i < elements; i++) {
@@ -7171,9 +7181,12 @@ static void disas_simd_zip_trn(DisasContext *s, uint32_t insn)
 
     write_vec_element(s, tcg_resl, rd, 0, MO_64);
     tcg_temp_free_i64(tcg_resl);
-    write_vec_element(s, tcg_resh, rd, 1, MO_64);
-    tcg_temp_free_i64(tcg_resh);
-    clear_vec_high(s, true, rd);
+
+    if (is_q) {
+        write_vec_element(s, tcg_resh, rd, 1, MO_64);
+        tcg_temp_free_i64(tcg_resh);
+    }
+    clear_vec_high(s, is_q, rd);
 }
 
 /*
-- 
2.20.1


