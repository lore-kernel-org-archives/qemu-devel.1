Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAF9C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:32:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDEBE21726
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="awDsgTvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDEBE21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bwq-0000I2-V4
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0z-0005Zf-1R
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0u-0003Cx-ED
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:24 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:34491)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b0u-0003BL-0r
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:20 -0400
Received: by mail-pl1-x629.google.com with SMTP id d3so16962plr.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=dXwskgwxwGoHO9g80cjucHpMD4vJQ5Oi2of0il2UAv8=;
 b=awDsgTvBw3Jo2mOzDrNg6vw8t7K3zMt9+omHocXqlpvz1LDWzx+/hivJY7mraY0F+3
 aaTLno6CnSb8ZDrzozteHVYDdjmEF3mngBoSEnD5Y6sfZui3o57ptfByylfTNd6SNr18
 6MiExsuyY35uOc303YDN+Ck5x0h/ZheJhSNoyLBgL1gTyGQMY4/jIy7RqGPcDn0Szwrd
 6cMKS/w3Mi4iKwfkWOobSbus1RfTHKNIpqq/CXk55A9HGVbyy4S6bwliF1I5MTEl8Sdp
 oVV5ZGpbcymkXgMueLXMMznFDZWBU42n5W9R/ScgM1FnBHbn88Mm+clIKwl2c/XeI4Rg
 fvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=dXwskgwxwGoHO9g80cjucHpMD4vJQ5Oi2of0il2UAv8=;
 b=BbQQbHKalcr8ERZHErdIJyvvSWEPx7cQ8gtOZ9OuobPQHcflMR1TEp6JD+WQYyJ9ax
 dRLTqzmxJGGUedxTwZRLxpWgVW+6pGrPDP47Dg5cY3ESo9/QttA4Ni48ZBUIoLqVD+kO
 fVMMMGFcj59TprYjkyzPGNN4FcsM38D3vlJgzte+kGFNwAoaEYrz0J7Ut1C/+elluvvf
 OhTtrZAe1xppdYiJg7CmVfNH/l9qSZ0VdbT1ZoOtqGBfUBlbrXaj+8f0yyNLG3r2jB7Y
 bBwJN1BxmZh9ar00LnNKW6H3Tyh9pWTsYcYEU6K5Bdnhkr1we27L+P6XJVjJJ/mkRoP8
 VFtQ==
X-Gm-Message-State: APjAAAWL/E5pxJ/jST8OOdkK1/ahcMXHKzpBq1Xm31zmG+XQwr2wel5k
 ru7qRi8Ua8tYSiK1G7frOnYphLNWEMg=
X-Google-Smtp-Source: APXvYqwqJqRIXhoj1WZFQVgzVBLoVbWqC4QjvnEo9Zeq0y4WMdXqdY9fvTj0tCq/NTvuNBbdnN2PJg==
X-Received: by 2002:a17:902:5e1:: with SMTP id
 f88mr13079569plf.1.1567625538333; 
 Wed, 04 Sep 2019 12:32:18 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:32:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:51 -0700
Message-Id: <20190904193059.26202-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::629
Subject: [Qemu-devel] [PATCH v4 61/69] target/arm: Convert T16, push and pop
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
index d076c962ea..ed52018c17 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7516,6 +7516,16 @@ static int t16_setflags(DisasContext *s)
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
@@ -10713,7 +10723,6 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
     uint32_t val, op, rm, rd, shift, cond;
     int32_t offset;
-    int i;
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
     TCGv_i32 addr;
@@ -10786,76 +10795,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
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


