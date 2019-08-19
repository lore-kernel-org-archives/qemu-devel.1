Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA65C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:31:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09E6A22CE8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bHPuMY7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E6A22CE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzqBQ-0007v3-3z
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 18:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60207)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpN3-00038b-Kj
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpN2-00071E-A0
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:21 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:43243)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpN2-0006zq-4J
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:20 -0400
Received: by mail-pg1-x52a.google.com with SMTP id k3so1922701pgb.10
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=CE2MOpYeaURMh2McMQcADxkv9nuiol4iRofGvabxWa4=;
 b=bHPuMY7AdYlyafexynlB/HZikO0mKlbdgJFNk15y7TjKMMC1G3aISNOKnFA0wi0nIx
 tmysV2g7ohX3GwfAYUJ3cjEBxifX7GVN/OQsfYcVW31Arh4bTxOisGwDaN9A/DVlpI4g
 wog512+IqdFpBhkT6qDB9n7y/sl6eFXqtYKghc429RFBY/7FRR+gF2QmBuJ1Bo5D3S3a
 sH/nOtI9FYsbRS+RqRTpqNKpC8dW060TwaaQSkCp9P3Q0zobi/cdkcHQC2nsolGVGH8w
 e5rQKR7u2JnzpGRLk8QdNQUF6vz+PWGYLQeHbw+Yaz88AQJYvdMd5jSkfI6XRwAd8hj0
 BOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=CE2MOpYeaURMh2McMQcADxkv9nuiol4iRofGvabxWa4=;
 b=NBeEgXNiC0Jj7/oLJ0/DE6H11lUMydq6qzcHZ8/wZVXuZVcfnL0JrCF3DPgQzDf6Md
 35IBKOvj6NWc2HIOryUtlFpfl8NRKLLmlXI3Vcq/w4xRy/dZK15A9vLEo1w1jHeQmgWp
 Fs4tOvVvXebyP+Rb6HZoWquukOveVqB5keMXVXBH8+fMku0Y0DJTjuMbjKtV6OqoKoOf
 KFXP+ecAQUwssQvgjJrB9YunvjB7M5ZKqnnliyRxgldeVByuDNFb8J+yR6PucBCS4Ysm
 lDoJCTKKVtXAT14FqmFYmeRIr4gccjnJJhJo1QrRCa5eSj9DSdn8n981XQl2PQcVKLsV
 GYbA==
X-Gm-Message-State: APjAAAV8L3/pekr7yro5H08UxlfVE6YK/JPWAjCtflbaEKWE/Kud3EIV
 ZIxY6YDwl1vnT7QMGbyrjS4eRHllnHI=
X-Google-Smtp-Source: APXvYqygFXL1x6wvHNEU/vjUqOE6QqlQKoR43l5eXOnrYJzSg9bmfC4YIxj827+4Ckvxqjid5N6g7Q==
X-Received: by 2002:a17:90a:3465:: with SMTP id
 o92mr22412655pjb.20.1566250758891; 
 Mon, 19 Aug 2019 14:39:18 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:39:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:53 -0700
Message-Id: <20190819213755.26175-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52a
Subject: [Qemu-devel] [PATCH v2 66/68] target/arm: Convert T16, long branches
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
 target/arm/translate.c | 89 +++++++++++++++++++-----------------------
 target/arm/t16.decode  |  3 ++
 2 files changed, 43 insertions(+), 49 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 51b14d409f..f8997a8424 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10025,6 +10025,44 @@ static bool trans_BLX_i(DisasContext *s, arg_BLX_i *a)
     return true;
 }
 
+static bool trans_BL_BLX_prefix(DisasContext *s, arg_BL_BLX_prefix *a)
+{
+    /*
+     * thumb_insn_is_16bit() ensures we can't get here for
+     * a Thumb2 CPU, so this must be a thumb1 split BL/BLX.
+     */
+    assert(!arm_dc_feature(s, ARM_FEATURE_THUMB2));
+    tcg_gen_movi_i32(cpu_R[14], read_pc(s) + (a->imm << 12));
+    return true;
+}
+
+static bool trans_BL_suffix(DisasContext *s, arg_BL_suffix *a)
+{
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
+    assert(!arm_dc_feature(s, ARM_FEATURE_THUMB2));
+    tcg_gen_addi_i32(tmp, cpu_R[14], (a->imm << 1) | 1);
+    tcg_gen_movi_i32(cpu_R[14], s->base.pc_next | 1);
+    gen_bx(s, tmp);
+    return true;
+}
+
+static bool trans_BLX_suffix(DisasContext *s, arg_BLX_suffix *a)
+{
+    TCGv_i32 tmp;
+
+    assert(!arm_dc_feature(s, ARM_FEATURE_THUMB2));
+    if (!ENABLE_ARCH_5) {
+        return false;
+    }
+    tmp = tcg_temp_new_i32();
+    tcg_gen_addi_i32(tmp, cpu_R[14], a->imm << 1);
+    tcg_gen_andi_i32(tmp, tmp, -4);
+    tcg_gen_movi_i32(cpu_R[14], s->base.pc_next | 1);
+    gen_bx(s, tmp);
+    return true;
+}
+
 static bool op_tbranch(DisasContext *s, arg_tbranch *a, bool half)
 {
     TCGv_i32 addr, tmp;
@@ -10612,10 +10650,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
-    int32_t offset;
-    TCGv_i32 tmp;
-    TCGv_i32 tmp2;
-
     if (disas_t16(s, insn)) {
         return;
     }
@@ -10634,53 +10668,10 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
     case 11: /* misc, in decodetree */
     case 12: /* load/store multiple, in decodetree */
     case 13: /* conditional branch or swi, in decodetree */
-        goto illegal_op;
-
     case 14:
-        if (insn & (1 << 11)) {
-            /* thumb_insn_is_16bit() ensures we can't get here for
-             * a Thumb2 CPU, so this must be a thumb1 split BL/BLX:
-             * 0b1110_1xxx_xxxx_xxxx : BLX suffix (or UNDEF)
-             */
-            assert(!arm_dc_feature(s, ARM_FEATURE_THUMB2));
-            ARCH(5);
-            offset = ((insn & 0x7ff) << 1);
-            tmp = load_reg(s, 14);
-            tcg_gen_addi_i32(tmp, tmp, offset);
-            tcg_gen_andi_i32(tmp, tmp, 0xfffffffc);
-
-            tmp2 = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp2, s->base.pc_next | 1);
-            store_reg(s, 14, tmp2);
-            gen_bx(s, tmp);
-            break;
-        }
-        /* unconditional branch, in decodetree */
-        goto illegal_op;
-
     case 15:
-        /* thumb_insn_is_16bit() ensures we can't get here for
-         * a Thumb2 CPU, so this must be a thumb1 split BL/BLX.
-         */
-        assert(!arm_dc_feature(s, ARM_FEATURE_THUMB2));
-
-        if (insn & (1 << 11)) {
-            /* 0b1111_1xxx_xxxx_xxxx : BL suffix */
-            offset = ((insn & 0x7ff) << 1) | 1;
-            tmp = load_reg(s, 14);
-            tcg_gen_addi_i32(tmp, tmp, offset);
-
-            tmp2 = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp2, s->base.pc_next | 1);
-            store_reg(s, 14, tmp2);
-            gen_bx(s, tmp);
-        } else {
-            /* 0b1111_0xxx_xxxx_xxxx : BL/BLX prefix */
-            uint32_t uoffset = ((int32_t)insn << 21) >> 9;
-
-            tcg_gen_movi_i32(cpu_R[14], read_pc(s) + uoffset);
-        }
-        break;
+        /* branches, in decodetree */
+        goto illegal_op;
     }
     return;
 illegal_op:
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 35a5b03118..5ee8457efb 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -274,3 +274,6 @@ LDM_t16         1011 110 ......... \
 %imm11_0x2      0:s11 !function=times_2
 
 B               11100 ...........               &i imm=%imm11_0x2
+BLX_suffix      11101 imm:11                    &i
+BL_BLX_prefix   11110 imm:s11                   &i
+BL_suffix       11111 imm:11                    &i
-- 
2.17.1


