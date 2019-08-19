Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BADC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD3A7214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Drn5lIP0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD3A7214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzplQ-0001eR-Oc
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 18:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59474)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMX-0002Nn-AD
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMU-0006Vw-UP
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:49 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:37319)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpMU-0006V9-Ok
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:46 -0400
Received: by mail-pl1-x62c.google.com with SMTP id bj8so1586758plb.4
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4oWyeRO7VGSUxbfq5SQ/Ttd5DuqgQfk+9PyV2J/44KI=;
 b=Drn5lIP0XEn3UHgMzXP+UrnGrtO4PcM2S5eHx1MB/XvLft3S26wpbgY6YWxiEZU47P
 j/WsmtsegP82//AY+U5OjxHLXJumJCU4BAXOTWV3/vApTXI1xg/wVX+wFcGmbsAnBIRj
 qT+wdPJuEI+AX6lRr4H/Gz15yOZqTHWjqYw+bI3hvd/u6CBFCbd5ovtlXJwcff6tZp8c
 eUWd+ZBUUn+YcmG/pXqjM7BaBb5c4/HhFIeOY1RqOrgWyLkQNxKOWXS0mvY06Bg7/pte
 ToYvZmioZHUtDvQnAcvnnpq7i4zLdj8CQ/QnLts8YfDV68V1PwmuuI36/fl+Jh8cEybQ
 AZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4oWyeRO7VGSUxbfq5SQ/Ttd5DuqgQfk+9PyV2J/44KI=;
 b=gVICezs2t3grFKSX2rX517ZRO9hTB2bA3lVXEG3Ab1zoVfgr7KJgg/022t4IDa5ahR
 O8djM/0dey6/+YWiP2vk0J5G5b5n44fG8lyfMHFVCH/y/R5s4AHzq1B0T59OfjzM3jc7
 Y16YnxDTfpYdm+ReC60uywf1fdcxTon0+FnTRJhrIPibCq6cmIkS4kDo6c/9Sg4gAKwA
 VVSPSFSNHBKL3zAbtyKdBnmxfO/k3/PX1110VCeFJcPBot4QJUw8eh/kfOG51OyYGE0v
 BVu7q77ZYGh/LhCeo32GQFwvGmuCqBTO3KqqiwxeiLhw2Grkq0R8fa6atbvUgEceBRUB
 7FKg==
X-Gm-Message-State: APjAAAXITkjlQvocOFEIPcia6OMIPG0H9OHQc6I3QqMhb7d3DHdvFS/I
 ot3QKIHjWSd4EX1+aZw+ZPJeBjA0iBU=
X-Google-Smtp-Source: APXvYqzhQ5lc4sK26xKWmjjBsfg6TzQm4j8SbcXfsesl62K1WL2xZgdGYwtxI71xs6mixmj66WbG+Q==
X-Received: by 2002:a17:902:a509:: with SMTP id
 s9mr25303891plq.310.1566250725114; 
 Mon, 19 Aug 2019 14:38:45 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:38:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:26 -0700
Message-Id: <20190819213755.26175-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62c
Subject: [Qemu-devel] [PATCH v2 39/68] target/arm: Convert Table Branch
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
 target/arm/translate.c | 57 +++++++++++++++++++++++++-----------------
 target/arm/t32.decode  |  8 +++++-
 2 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 9ec6b25c03..7c05e7006e 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9968,6 +9968,37 @@ static bool trans_BLX_i(DisasContext *s, arg_BLX_i *a)
     return true;
 }
 
+static bool op_tbranch(DisasContext *s, arg_tbranch *a, bool half)
+{
+    TCGv_i32 addr, tmp;
+
+    tmp = load_reg(s, a->rm);
+    if (half) {
+        tcg_gen_add_i32(tmp, tmp, tmp);
+    }
+    addr = load_reg(s, a->rn);
+    tcg_gen_add_i32(addr, addr, tmp);
+
+    gen_aa32_ld_i32(s, tmp, addr, get_mem_index(s),
+                    half ? MO_UW | s->be_data : MO_UB);
+    tcg_temp_free_i32(addr);
+
+    tcg_gen_add_i32(tmp, tmp, tmp);
+    tcg_gen_addi_i32(tmp, tmp, read_pc(s));
+    store_reg(s, 15, tmp);
+    return true;
+}
+
+static bool trans_TBB(DisasContext *s, arg_tbranch *a)
+{
+    return op_tbranch(s, a, false);
+}
+
+static bool trans_TBH(DisasContext *s, arg_tbranch *a)
+{
+    return op_tbranch(s, a, true);
+}
+
 /*
  * Supervisor call
  */
@@ -10350,9 +10381,7 @@ static bool thumb_insn_is_16bit(DisasContext *s, uint32_t pc, uint32_t insn)
 /* Translate a 32-bit thumb instruction. */
 static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t rd, rn, rm, rs;
-    TCGv_i32 tmp;
-    TCGv_i32 addr;
+    uint32_t rd, rn, rs;
     int op;
 
     /*
@@ -10398,7 +10427,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
     rn = (insn >> 16) & 0xf;
     rs = (insn >> 12) & 0xf;
     rd = (insn >> 8) & 0xf;
-    rm = insn & 0xf;
     switch ((insn >> 25) & 0xf) {
     case 0: case 1: case 2: case 3:
         /* 16-bit instructions.  Should never happen.  */
@@ -10471,25 +10499,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 /* Load/store exclusive, in decodetree */
                 goto illegal_op;
             } else if ((insn & (7 << 5)) == 0) {
-                /* Table Branch.  */
-                addr = load_reg(s, rn);
-                tmp = load_reg(s, rm);
-                tcg_gen_add_i32(addr, addr, tmp);
-                if (insn & (1 << 4)) {
-                    /* tbh */
-                    tcg_gen_add_i32(addr, addr, tmp);
-                    tcg_temp_free_i32(tmp);
-                    tmp = tcg_temp_new_i32();
-                    gen_aa32_ld16u(s, tmp, addr, get_mem_index(s));
-                } else { /* tbb */
-                    tcg_temp_free_i32(tmp);
-                    tmp = tcg_temp_new_i32();
-                    gen_aa32_ld8u(s, tmp, addr, get_mem_index(s));
-                }
-                tcg_temp_free_i32(addr);
-                tcg_gen_shli_i32(tmp, tmp, 1);
-                tcg_gen_addi_i32(tmp, tmp, read_pc(s));
-                store_reg(s, 15, tmp);
+                /* Table Branch, in decodetree */
+                goto illegal_op;
             } else {
                 /* Load/store exclusive, load-acq/store-rel, in decodetree */
                 goto illegal_op;
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 354ad77fe6..0cc0808c05 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -487,7 +487,7 @@ LDRD_ri_t32      1110 1001 .101 .... .... .... ........    @ldstd_ri8 w=0 p=1
 STRD_ri_t32      1110 1001 .110 .... .... .... ........    @ldstd_ri8 w=1 p=1
 LDRD_ri_t32      1110 1001 .111 .... .... .... ........    @ldstd_ri8 w=1 p=1
 
-# Load/Store Exclusive and Load-Acquire/Store-Release
+# Load/Store Exclusive, Load-Acquire/Store-Release, and Table Branch
 
 @strex_i         .... .... .... rn:4 rt:4 rd:4 .... .... \
                  &strex rt2=15 imm=%imm8x4
@@ -531,6 +531,12 @@ LDA              1110 1000 1101 .... .... 1111 1010 1111      @ldrex_0
 LDAB             1110 1000 1101 .... .... 1111 1000 1111      @ldrex_0
 LDAH             1110 1000 1101 .... .... 1111 1001 1111      @ldrex_0
 
+&tbranch         rn rm
+@tbranch         .... .... .... rn:4 .... .... .... rm:4      &tbranch
+
+TBB              1110 1000 1101 .... 1111 0000 0000 ....      @tbranch
+TBH              1110 1000 1101 .... 1111 0000 0001 ....      @tbranch
+
 # Parallel addition and subtraction
 
 SADD8            1111 1010 1000 .... 1111 .... 0000 ....      @rndm
-- 
2.17.1


