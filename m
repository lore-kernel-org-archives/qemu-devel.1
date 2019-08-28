Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948A2C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:04:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A61F20828
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="werfGZE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A61F20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i34Ba-0003fv-My
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 16:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33H0-00041Y-E4
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Gw-0000lh-EC
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:24 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40936)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33Gu-0000js-JN
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:20 -0400
Received: by mail-pg1-x541.google.com with SMTP id w10so218118pgj.7
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0cedwX4DK0/sfFpeHztWA8eKQ1Bah4RqDcJrQgER7Gk=;
 b=werfGZE5VVd/hf8PnlMChhJrB29+q4Dg5aOW4EiOonfGluNy6bFFNS7oMN2twnNGGC
 /fhlUXOxoDdBVrUtXj1JCJ/ZVuIFsAFyqBU/mM6SkKyZnu624XBLqwwFb1fQPtKdgTOp
 jYNMHz5VWAfRtEfKxtrN4riKH9IyoOgbI4e/FXjlLJ4+07s0XRCD5K0C8F3j9u1Vb2st
 SVxpaEu44QU+BiQpBUYLOETZUGHUyRtlEEozAaqeatgz3/lqJibj4FRV5UsQ22bxxRy6
 gNligeP1d+8BQgWCCu+A0L7Vv2IIh9zq4ISsb+FGPruyL4JdS/oARqwhfX/IcrGJ1I24
 XJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=0cedwX4DK0/sfFpeHztWA8eKQ1Bah4RqDcJrQgER7Gk=;
 b=ovqqDp7aUm2sNS6OcCal6mySQVY6YTMzkuftzwlTeAj74TaMpuNex1kA/dB+5bFZ0o
 8U7B57ly5/rcfUtZg112+Yn0a+a3Q/5r28ouy7WIEdYSrG6zbG7uEcAwNvj0FijoSEvl
 U4CoxnHRZlLfX0CwMBDYGNSQ/X6fAznc9NdEgWz7mQ3rXdxt6B1wMN8GyCa9WK/+YHC9
 qWXzz/pjBR/IY/1WCe0dQo2NDpZcyTnEKR0PHHEPPyg5pj5f95eQHboM8CVSDjfDOeWf
 nCc+MNs4RPzYFzq82OF32XbgagoyGHE1U47DQnBPANipaOlUY1Mc/QutqSV2SiFflQ1r
 7Meg==
X-Gm-Message-State: APjAAAUlZ/72WviwzWb+NCJhnZUzTqD5h4e8KIzy9uDdPs23h+KEnWVf
 h6qNLYGW9o4ZFAeeKCVuN3OaoX2fBQM=
X-Google-Smtp-Source: APXvYqwlz4WhD9g0hENXUdxO+wpnna7i2g8DXaZbbAIvkeq8to1vAhHy6TTpt0bP+LDY/qfVoA8u6Q==
X-Received: by 2002:a63:f401:: with SMTP id g1mr4988782pgi.314.1567019178379; 
 Wed, 28 Aug 2019 12:06:18 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:06:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:49 -0700
Message-Id: <20190828190456.30315-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v3 62/69] target/arm: Convert T16,
 Conditional branches, Supervisor call
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
 target/arm/translate.c | 26 +++-----------------------
 target/arm/t16.decode  | 12 ++++++++++++
 2 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 5ee4dfe3a2..854c9fe10d 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10698,7 +10698,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t val, op, rm, rd, shift, cond;
+    uint32_t val, op, rm, rd, shift;
     int32_t offset;
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
@@ -10837,28 +10837,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         }
         break;
 
-    case 13:
-        /* conditional branch or swi */
-        cond = (insn >> 8) & 0xf;
-        if (cond == 0xe)
-            goto undef;
-
-        if (cond == 0xf) {
-            /* swi */
-            gen_set_pc_im(s, s->base.pc_next);
-            s->svc_imm = extract32(insn, 0, 8);
-            s->base.is_jmp = DISAS_SWI;
-            break;
-        }
-        /* generate a conditional jump to next instruction */
-        arm_skip_unless(s, cond);
-
-        /* jump to the offset */
-        val = read_pc(s);
-        offset = ((int32_t)insn << 24) >> 24;
-        val += offset << 1;
-        gen_jmp(s, val);
-        break;
+    case 13: /* conditional branch or swi, in decodetree */
+        goto illegal_op;
 
     case 14:
         if (insn & (1 << 11)) {
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 55fadce223..cbc64f4e48 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -28,11 +28,13 @@
 &rr              !extern rd rm
 &ri              !extern rd imm
 &r               !extern rm
+&i               !extern imm
 &ldst_rr         !extern p w u rn rt rm shimm shtype
 &ldst_ri         !extern p w u rn rt imm
 &ldst_block      !extern rn i b u w list
 &setend          !extern E
 &cps             !extern mode imod M A I F
+&ci              !extern cond imm
 
 # Set S if the instruction is outside of an IT block.
 %s               !function=t16_setflags
@@ -231,3 +233,13 @@ STM             1011 010 ......... \
                 &ldst_block i=0 b=1 u=0 w=1 rn=13 list=%push_list
 LDM_t16         1011 110 ......... \
                 &ldst_block i=1 b=0 u=0 w=1 rn=13 list=%pop_list
+
+# Conditional branches, Supervisor call
+
+%imm8_0x2       0:s8 !function=times_2
+
+{
+  UDF           1101 1110 ---- ----
+  SVC           1101 1111 imm:8                 &i
+  B_cond_thumb  1101 cond:4 ........            &ci imm=%imm8_0x2
+}
-- 
2.17.1


