Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDC0C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:04:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0908221842
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NzxCzQPw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0908221842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4Zd-0004hX-HR
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 14:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59738)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Nv-0007X2-Ot
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Nt-0001OU-Ri
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:03 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:46825)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4Nt-00014l-Ge
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:01 -0400
Received: by mail-pf1-x429.google.com with SMTP id c3so1720839pfa.13
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=C70Yg+46c/XVZyXVh4QRHDyUG/TqYDz7LEEkFesYi6Q=;
 b=NzxCzQPwDL2RHpSKettJLJJ3w8c0BDGTVv1D2coZzWHKoMplL/ZnUe4nh5V15XPe6O
 2wvHwYgFDvS5rWbFipEQDZqV3L/elqF1/YwK94JB3inJTWRaic+RNfKB6FtMaGYBh+LY
 7ddtzIuW02hHgXU+WObCHgWmrEqaFhWP1/vn+vZ6AoDhdBmcIpwu0YwksdtzqVcjd+ih
 IxICgFMB4AidU6+tIdQBC5GXSekfcHFMhtegGtvcdsnelu0WW6RYGHkGdWpLxRL11MgW
 J6xLpCfeMpwGfP/KNsXqU6iaA2poW4fHJR1JRQVrwIQ3DXvx32rxQj6xCrplH0avJlxB
 Acrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=C70Yg+46c/XVZyXVh4QRHDyUG/TqYDz7LEEkFesYi6Q=;
 b=AmrI8spPKH3QnbnW+7MQxpZtLc7mTYqg6s3f7SpkkcmgEE92xEG5a0d9WLKe9UI8mk
 vII89VozCnZmExbnKyVpLFVxEV7sr31GKyouBdqxShBdJu3KE3Z0HlO9KpIdoG0SOFz2
 IcZJme0sC12My/XAXFMFvFBhccjp4OnYeZGinIexEa/QKJ/F95g1NRNnHf2o/eNH6y9y
 hz9RmLQCMSMxWwTc2bJ3OO++k3J671X4v2p9rmnW366oGl2HHz4ZdClS0m4BCq4AJ15J
 afp5wG6TYrBPeTOevOy8Zd0ZMEabDnnQbSGevWEki72D1KRL8OoF9iwN/gCPGjkMtT4o
 evnw==
X-Gm-Message-State: APjAAAV/PTinB7D7coR/M8HsTBLGa80nlXxtZgn4kokW0kU4TbWadg6e
 QKpAQAUc5RIiyEBHLSMpAuROS4MkF6I=
X-Google-Smtp-Source: APXvYqyF8ot09O5wbGNYiUf4yRBDWlRiRaMvIm9JFcBGgwFl0aZMR7EOT42ArkN8s+NqKuvGWqKv1g==
X-Received: by 2002:a63:ee08:: with SMTP id e8mr38601581pgi.70.1564163503573; 
 Fri, 26 Jul 2019 10:51:43 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.42
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:50:23 -0700
Message-Id: <20190726175032.6769-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::429
Subject: [Qemu-devel] [PATCH 58/67] target/arm: Convert T16, push and pop
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 83 ++++++------------------------------------
 target/arm/t16.decode  | 10 +++++
 2 files changed, 22 insertions(+), 71 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 55404414a2..5d0d0779c8 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7593,6 +7593,16 @@ static int t16_setflags(DisasContext *s, int x)
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
  * Note that the T32 decoder reuses some of the trans_* functions
@@ -10618,7 +10628,6 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
     uint32_t val, op, rm, rd, shift, cond;
     int32_t offset;
-    int i;
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
     TCGv_i32 addr;
@@ -10691,76 +10700,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
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
index 90a4b71a45..10cdca1fbb 100644
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
+LDM             1011 110 ......... \
+                &ldst_block i=1 b=0 u=0 w=1 rn=13 list=%pop_list
-- 
2.17.1


