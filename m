Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7B4C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9132F2087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l6E8rkRC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9132F2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzq3b-0004hY-J5
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 18:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMj-0002Vr-26
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMh-0006h2-Cc
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:00 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46045)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpMf-0006cQ-7A
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:59 -0400
Received: by mail-pg1-x543.google.com with SMTP id o13so1921286pgp.12
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=VFBU7xB1tZeQF9Ur7x5GUr3vG1VIlCf7jhvfNaK9tC0=;
 b=l6E8rkRCcCq9NjGdgmdCaOfUp1hUCk8OnzveXy+ovospNVBusw/ZuE+U6GsDHVqN6/
 OLvheKhhduzX8D9Vc7rE05wC5yDgFDmtW/prE85Kt+Ol8YWCuMlweacUfbk93gmdARES
 k/fiVLxdDn6zqswtTVtrEzfo7A/TgiOyD9Qj4zGdGLSIbnrBnGImCbkpShNEehNpmyYO
 x6+fU07BTW2Azevcoo6ufxAhxEdEdNcMrCbFY/0PxGHW+jaNPq6hZJuRmLcT5HWWhN/Z
 b4KNKJDjg4CuawJjv6ANQLaWuIWhQ5FGa2997h8R4iBwgwI3k2mLx1e/l6ni+iOh8v63
 PyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=VFBU7xB1tZeQF9Ur7x5GUr3vG1VIlCf7jhvfNaK9tC0=;
 b=dQW30+9m8UrHLvH6Dk8zABntFHGqcjXs2TixqNK/CecQdvKX3qRkOSSXHg1ngx+0xf
 uF3KPEGD0CHDKammU7ZBwOKOcmts5qK1mJ7k4xgfb3Cr/R7KNgsmpzdyQIMWuyBoVdxC
 FRGLu3jouBRzwhlZkwcK/sf7610CD93YC9IE3WIWniSN4YSddjzxdPVa6yKJkYBQd8IO
 pkhCGFWHpTU0Pd2hRJt15jKgI3KoMv+C2toFKEV176ieQEhwWqS01VM0yYX26tcqTK/i
 f0jiqdd7vs97CJ146Ycnuks3lcudR5MVbbOkpYl4yTbbSYOOxOXgpuFSdrm1AyNLPyd7
 5Hnw==
X-Gm-Message-State: APjAAAVHalKhwSfb6vW8PoBXuL8c6UrpH4pV2tXRWS5hdIqWM3IqmFM8
 HhYBBylammoe2FUcJ0V1uLK0aQwGbcg=
X-Google-Smtp-Source: APXvYqzBFkjYhsJ3+06HVnFoKbDVQh/Y+XC98FdQcjajdgM+7Hyf1QRez2vD2lI31hWt4rs8vEWmpQ==
X-Received: by 2002:a62:584:: with SMTP id 126mr26624406pff.73.1566250734445; 
 Mon, 19 Aug 2019 14:38:54 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:38:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:34 -0700
Message-Id: <20190819213755.26175-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v2 47/68] target/arm: Convert T16 load/store
 (immediate offset)
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
 target/arm/translate.c | 94 +++---------------------------------------
 target/arm/t16.decode  | 33 +++++++++++++++
 2 files changed, 38 insertions(+), 89 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index e19961fb6c..24537fc107 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10744,97 +10744,13 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
          */
         goto illegal_op;
 
-    case 5:
-        /* load/store register offset, in decodetree */
+    case 5: /* load/store register offset, in decodetree */
+    case 6: /* load/store word immediate offset, in decodetree */
+    case 7: /* load/store byte immediate offset, in decodetree */
+    case 8: /* load/store halfword immediate offset, in decodetree */
+    case 9: /* load/store from stack, in decodetree */
         goto illegal_op;
 
-    case 6:
-        /* load/store word immediate offset */
-        rd = insn & 7;
-        rn = (insn >> 3) & 7;
-        addr = load_reg(s, rn);
-        val = (insn >> 4) & 0x7c;
-        tcg_gen_addi_i32(addr, addr, val);
-
-        if (insn & (1 << 11)) {
-            /* load */
-            tmp = tcg_temp_new_i32();
-            gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
-            store_reg(s, rd, tmp);
-        } else {
-            /* store */
-            tmp = load_reg(s, rd);
-            gen_aa32_st32(s, tmp, addr, get_mem_index(s));
-            tcg_temp_free_i32(tmp);
-        }
-        tcg_temp_free_i32(addr);
-        break;
-
-    case 7:
-        /* load/store byte immediate offset */
-        rd = insn & 7;
-        rn = (insn >> 3) & 7;
-        addr = load_reg(s, rn);
-        val = (insn >> 6) & 0x1f;
-        tcg_gen_addi_i32(addr, addr, val);
-
-        if (insn & (1 << 11)) {
-            /* load */
-            tmp = tcg_temp_new_i32();
-            gen_aa32_ld8u_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
-            store_reg(s, rd, tmp);
-        } else {
-            /* store */
-            tmp = load_reg(s, rd);
-            gen_aa32_st8_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
-            tcg_temp_free_i32(tmp);
-        }
-        tcg_temp_free_i32(addr);
-        break;
-
-    case 8:
-        /* load/store halfword immediate offset */
-        rd = insn & 7;
-        rn = (insn >> 3) & 7;
-        addr = load_reg(s, rn);
-        val = (insn >> 5) & 0x3e;
-        tcg_gen_addi_i32(addr, addr, val);
-
-        if (insn & (1 << 11)) {
-            /* load */
-            tmp = tcg_temp_new_i32();
-            gen_aa32_ld16u_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
-            store_reg(s, rd, tmp);
-        } else {
-            /* store */
-            tmp = load_reg(s, rd);
-            gen_aa32_st16_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
-            tcg_temp_free_i32(tmp);
-        }
-        tcg_temp_free_i32(addr);
-        break;
-
-    case 9:
-        /* load/store from stack */
-        rd = (insn >> 8) & 7;
-        addr = load_reg(s, 13);
-        val = (insn & 0xff) * 4;
-        tcg_gen_addi_i32(addr, addr, val);
-
-        if (insn & (1 << 11)) {
-            /* load */
-            tmp = tcg_temp_new_i32();
-            gen_aa32_ld32u_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
-            store_reg(s, rd, tmp);
-        } else {
-            /* store */
-            tmp = load_reg(s, rd);
-            gen_aa32_st32_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
-            tcg_temp_free_i32(tmp);
-        }
-        tcg_temp_free_i32(addr);
-        break;
-
     case 10:
         /*
          * 0b1010_xxxx_xxxx_xxxx
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 83fe4363c7..1cf79789ac 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -24,6 +24,7 @@
 &s_rri_rot       !extern s rn rd imm rot
 &s_rrrr          !extern s rd rn rm ra
 &ldst_rr         !extern p w u rn rt rm shimm shtype
+&ldst_ri         !extern p w u rn rt imm
 
 # Set S if the instruction is outside of an IT block.
 %s               !function=t16_setflags
@@ -69,3 +70,35 @@ LDR_rr           0101 100 ... ... ...           @ldst_rr
 LDRH_rr          0101 101 ... ... ...           @ldst_rr
 LDRB_rr          0101 110 ... ... ...           @ldst_rr
 LDRSH_rr         0101 111 ... ... ...           @ldst_rr
+
+# Load/store word/byte (immediate offset)
+
+%imm5_6x4       6:5 !function=times_4
+
+@ldst_ri_1      ..... imm:5 rn:3 rt:3 \
+                &ldst_ri p=1 w=0 u=1
+@ldst_ri_4      ..... ..... rn:3 rt:3 \
+                &ldst_ri p=1 w=0 u=1 imm=%imm5_6x4
+
+STR_ri          01100 ..... ... ...             @ldst_ri_4
+LDR_ri          01101 ..... ... ...             @ldst_ri_4
+STRB_ri         01110 ..... ... ...             @ldst_ri_1
+LDRB_ri         01111 ..... ... ...             @ldst_ri_1
+
+# Load/store halfword (immediate offset)
+
+%imm5_6x2       6:5 !function=times_2
+@ldst_ri_2      ..... ..... rn:3 rt:3 \
+                &ldst_ri p=1 w=0 u=1 imm=%imm5_6x2
+
+STRH_ri         10000 ..... ... ...             @ldst_ri_2
+LDRH_ri         10001 ..... ... ...             @ldst_ri_2
+
+# Load/store (SP-relative)
+
+%imm8_0x4       0:8 !function=times_4
+@ldst_spec_i    ..... rt:3 ........ \
+                &ldst_ri p=1 w=0 u=1 imm=%imm8_0x4
+
+STR_ri          10010 ... ........              @ldst_spec_i rn=13
+LDR_ri          10011 ... ........              @ldst_spec_i rn=13
-- 
2.17.1


