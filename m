Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FFFC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:10:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD10214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RsDh0VI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD10214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzprP-00036B-Lg
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 18:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMi-0002Uq-FJ
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMf-0006fX-An
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:00 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43337)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpMd-0006c2-7z
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:57 -0400
Received: by mail-pf1-x444.google.com with SMTP id v12so1937428pfn.10
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=UChj47Tk8bdejdFnV6vdPORz5eDZg2iYcmHyUtBCb38=;
 b=RsDh0VI+3TDvB/NdPYoknfGk7dHH7mMgWZnrlQx6TlORcBl3SNwSFk9BBsiMp3M2GY
 Om2LJwKbLJt6cGvBZqChMgSAkn4kgKJHXGCerSPLw+Ml9quHO85AQtNyN0+s8TMaO0q/
 OHYq6FCGbgU/VsejmXBUQn9gzzTEdQp8A1rlbVNV1W9k1VwKI8X7CImNe3L4KKgh8Gnb
 2W4hRZMli+w2g/u0Fh9hn9JqFdaQ+/J2LZeYVDish/5S8POpFBotfRnp60YxnTfjSuSH
 SBH1Jr615WL2ZnfToOhjoiGoDURu71TsHPT/M4NPcV78fXXxb7n8JJOnDaUCjtKuAdhJ
 80dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=UChj47Tk8bdejdFnV6vdPORz5eDZg2iYcmHyUtBCb38=;
 b=mqaWX0Y+jhDODGMFnJGj3mMekzWThSEQQtostw4+QPNBUgSCjzVXXZfIFc0V0mYllF
 TSDmY+V/tn79IElMV2A4t5IPXyYnKNsD4HFCLJ4DWthiFHTG2MpREOXYFLxJLaqTCDgp
 cAwiVvbAY03uM26eGNhyFhH63OoXC2wQIFvMt1OAfiOVoKSVMvWDQpZ19afhrcx+gIEj
 3riLa5CEkhlSAwkOVg8LQcwhtdRV5kF/2mViy4QrNn6X8fmynEqlvebwEQz6XfNghMNI
 BSzFk0AXv37QTuMvDbDRJwszYIUKFz5S1G0AfwWCdJ3thxYVf2Azt5qNQ88JCWzkHkVC
 CVtA==
X-Gm-Message-State: APjAAAWMh4XAHqMBUOq46HruWw74iTld/8H86QV+oylS6DCWj1QVpSNb
 7Y1oTCqVJNefJGYwU+Rdd4hWcS6rbNo=
X-Google-Smtp-Source: APXvYqwAAxbLt4Hjv4vRMSvL07mQ4M1xXXF7xYkc3bpCImti4Lg1S3AMdAOPngh+hgFNWpAtvgShuA==
X-Received: by 2002:a62:5250:: with SMTP id g77mr26780026pfb.158.1566250733306; 
 Mon, 19 Aug 2019 14:38:53 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:38:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:33 -0700
Message-Id: <20190819213755.26175-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v2 46/68] target/arm: Convert T16 load/store
 (register offset)
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 51 ++----------------------------------------
 target/arm/t16.decode  | 15 +++++++++++++
 2 files changed, 17 insertions(+), 49 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7c5769bd42..e19961fb6c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10745,55 +10745,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         goto illegal_op;
 
     case 5:
-        /* load/store register offset.  */
-        rd = insn & 7;
-        rn = (insn >> 3) & 7;
-        rm = (insn >> 6) & 7;
-        op = (insn >> 9) & 7;
-        addr = load_reg(s, rn);
-        tmp = load_reg(s, rm);
-        tcg_gen_add_i32(addr, addr, tmp);
-        tcg_temp_free_i32(tmp);
-
-        if (op < 3) { /* store */
-            tmp = load_reg(s, rd);
-        } else {
-            tmp = tcg_temp_new_i32();
-        }
-
-        switch (op) {
-        case 0: /* str */
-            gen_aa32_st32_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
-            break;
-        case 1: /* strh */
-            gen_aa32_st16_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
-            break;
-        case 2: /* strb */
-            gen_aa32_st8_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
-            break;
-        case 3: /* ldrsb */
-            gen_aa32_ld8s_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
-            break;
-        case 4: /* ldr */
-            gen_aa32_ld32u_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
-            break;
-        case 5: /* ldrh */
-            gen_aa32_ld16u_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
-            break;
-        case 6: /* ldrb */
-            gen_aa32_ld8u_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
-            break;
-        case 7: /* ldrsh */
-            gen_aa32_ld16s_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
-            break;
-        }
-        if (op >= 3) { /* load */
-            store_reg(s, rd, tmp);
-        } else {
-            tcg_temp_free_i32(tmp);
-        }
-        tcg_temp_free_i32(addr);
-        break;
+        /* load/store register offset, in decodetree */
+        goto illegal_op;
 
     case 6:
         /* load/store word immediate offset */
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 44e7250c55..83fe4363c7 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -23,6 +23,7 @@
 &s_rrr_shr       !extern s rn rd rm rs shty
 &s_rri_rot       !extern s rn rd imm rot
 &s_rrrr          !extern s rd rn rm ra
+&ldst_rr         !extern p w u rn rt rm shimm shtype
 
 # Set S if the instruction is outside of an IT block.
 %s               !function=t16_setflags
@@ -54,3 +55,17 @@ ORR_rrri         010000 1100 ... ...            @lll_noshr
 MUL              010000 1101 rn:3 rd:3          &s_rrrr %s rm=%reg_0 ra=0
 BIC_rrri         010000 1110 ... ...            @lll_noshr
 MVN_rxri         010000 1111 ... ...            @lll_noshr
+
+# Load/store (register offset)
+
+@ldst_rr         ....... rm:3 rn:3 rt:3 \
+                 &ldst_rr p=1 w=0 u=1 shimm=0 shtype=0
+
+STR_rr           0101 000 ... ... ...           @ldst_rr
+STRH_rr          0101 001 ... ... ...           @ldst_rr
+STRB_rr          0101 010 ... ... ...           @ldst_rr
+LDRSB_rr         0101 011 ... ... ...           @ldst_rr
+LDR_rr           0101 100 ... ... ...           @ldst_rr
+LDRH_rr          0101 101 ... ... ...           @ldst_rr
+LDRB_rr          0101 110 ... ... ...           @ldst_rr
+LDRSH_rr         0101 111 ... ... ...           @ldst_rr
-- 
2.17.1


