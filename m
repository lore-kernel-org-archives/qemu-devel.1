Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB84C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:57:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 216692189D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uKQHazug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216692189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i343x-0004mi-7i
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Gz-00041W-E7
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Gu-0000l2-Rm
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:23 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:39448)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33Gt-0000iv-Id
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:20 -0400
Received: by mail-pf1-x42a.google.com with SMTP id y200so390956pfb.6
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Zg8dzU0/CFYfa/kdfJbWaGoOPylTikiwN65K71SZiLc=;
 b=uKQHazugJxEVXAFBp+BiR4/sgmEW8QSorrKeZ3Yx2yLLK2xwROlnI+wVUtKN/TVEcp
 bnH4EhcPwQ3RixW0GhMFALQKMo5BN77kFGvP6M/igpGBDvIQAmb9k6DHWVlJyKKwrLU3
 Xs+jUFddsX3OTH16kbVnFS4vB002s/BZIm9mVwMis9Urie68HkNYUDCKS8rzB/rYK8pi
 Z02WsIG30NfYrlgyP6WLBrd6Vbun8dhMFnmR4CYCxUL1FuFynjo2UnaNQUv54v8Ajnzk
 zdgE8qAqTgs5rBIeOF/GjBVMGaW8vGRAPygFLWMOL8ZUkxA13GeKOok+SNhaGP6HgBYo
 RbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Zg8dzU0/CFYfa/kdfJbWaGoOPylTikiwN65K71SZiLc=;
 b=TK7ka90ep5P6YWjZO+3gXfVO6sqp1noQA4x1l8iAVTtoBfeoyMIOUdW84raUrVoAln
 6Qj5wL63oUBpLTkV7eH3TTov53tvqY5gMAOZhPx5xIprsOS1n5ez2dB1pyAidKhYLty2
 J2bHg6GprT8oo/hdogx/iP2ucgCqTQnogyOu+/tLTpKKTKWKaVZkv+EZKmpsC6zYPTQO
 lJpTT/PfOiKqAsBaCXEklAcnMs2Uukuv6YdcBS3ddhSXCPCGDCzVcCejiXW6aReff7zg
 yzEOUZpCjcjNa54uUQSGYE50z2Rd3bPtqMVhx0VkfTSXy1hHN9bcuHGBXlE5VbwxRuHg
 eolQ==
X-Gm-Message-State: APjAAAVkCROqPdfH+Sfnoy3CK/12pBXiCCxmMF5sE/TNgvGoOBYChQrj
 Wx4PofoJFq8Ghy9nHSLAbhYPLDMMk2E=
X-Google-Smtp-Source: APXvYqzWWT+x1KVF+KeBlpIAeF8AHxpkNBPFKPF2QIEAEywdaKurEwAhxLdPSY0WKFFY/G/3ydhVJQ==
X-Received: by 2002:a62:7996:: with SMTP id u144mr6564180pfc.228.1567019177273; 
 Wed, 28 Aug 2019 12:06:17 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:06:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:48 -0700
Message-Id: <20190828190456.30315-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42a
Subject: [Qemu-devel] [PATCH v3 61/69] target/arm: Convert T16, push and pop
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 83 ++++++------------------------------------
 target/arm/t16.decode  | 10 +++++
 2 files changed, 22 insertions(+), 71 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index c7d7834440..5ee4dfe3a2 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7490,6 +7490,16 @@ static int t16_setflags(DisasContext *s)
     return s->condexec_mask == 0;
 }
 
+static int t16_push_list(DisasContext *s, int x)
+{
+    return (x & 0xff) | (x & 0x100) << (14 - 8);
+}
+
+static int t16_pop_list(DisasContext *s, int x)
+{
+    return (x & 0xff) | (x & 0x100) << (15 - 8);
+}
+
 /*
  * Include the generated decoders.
  */
@@ -10690,7 +10700,6 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
     uint32_t val, op, rm, rd, shift, cond;
     int32_t offset;
-    int i;
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
     TCGv_i32 addr;
@@ -10763,76 +10772,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
             goto illegal_op;
 
         case 4: case 5: case 0xc: case 0xd:
-            /*
-             * 0b1011_x10x_xxxx_xxxx
-             *  - push/pop
-             */
-            addr = load_reg(s, 13);
-            if (insn & (1 << 8))
-                offset = 4;
-            else
-                offset = 0;
-            for (i = 0; i < 8; i++) {
-                if (insn & (1 << i))
-                    offset += 4;
-            }
-            if ((insn & (1 << 11)) == 0) {
-                tcg_gen_addi_i32(addr, addr, -offset);
-            }
-
-            if (s->v8m_stackcheck) {
-                /*
-                 * Here 'addr' is the lower of "old SP" and "new SP";
-                 * if this is a pop that starts below the limit and ends
-                 * above it, it is UNKNOWN whether the limit check triggers;
-                 * we choose to trigger.
-                 */
-                gen_helper_v8m_stackcheck(cpu_env, addr);
-            }
-
-            for (i = 0; i < 8; i++) {
-                if (insn & (1 << i)) {
-                    if (insn & (1 << 11)) {
-                        /* pop */
-                        tmp = tcg_temp_new_i32();
-                        gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
-                        store_reg(s, i, tmp);
-                    } else {
-                        /* push */
-                        tmp = load_reg(s, i);
-                        gen_aa32_st32(s, tmp, addr, get_mem_index(s));
-                        tcg_temp_free_i32(tmp);
-                    }
-                    /* advance to the next address.  */
-                    tcg_gen_addi_i32(addr, addr, 4);
-                }
-            }
-            tmp = NULL;
-            if (insn & (1 << 8)) {
-                if (insn & (1 << 11)) {
-                    /* pop pc */
-                    tmp = tcg_temp_new_i32();
-                    gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
-                    /* don't set the pc until the rest of the instruction
-                       has completed */
-                } else {
-                    /* push lr */
-                    tmp = load_reg(s, 14);
-                    gen_aa32_st32(s, tmp, addr, get_mem_index(s));
-                    tcg_temp_free_i32(tmp);
-                }
-                tcg_gen_addi_i32(addr, addr, 4);
-            }
-            if ((insn & (1 << 11)) == 0) {
-                tcg_gen_addi_i32(addr, addr, -offset);
-            }
-            /* write back the new stack pointer */
-            store_reg(s, 13, addr);
-            /* set the new PC value */
-            if ((insn & 0x0900) == 0x0900) {
-                store_reg_from_load(s, 15, tmp);
-            }
-            break;
+            /* push/pop, in decodetree */
+            goto illegal_op;
 
         case 1: case 3: case 9: case 11: /* czb */
             rm = insn & 7;
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 5829b9a58c..55fadce223 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -221,3 +221,13 @@ REVSH           1011 1010 11 ... ...            @rdm
   # rest of the space is a reserved hint, behaves as nop.
   NOP           1011 1111 ---- 0000
 }
+
+# Push and Pop
+
+%push_list      0:9 !function=t16_push_list
+%pop_list       0:9 !function=t16_pop_list
+
+STM             1011 010 ......... \
+                &ldst_block i=0 b=1 u=0 w=1 rn=13 list=%push_list
+LDM_t16         1011 110 ......... \
+                &ldst_block i=1 b=0 u=0 w=1 rn=13 list=%pop_list
-- 
2.17.1


