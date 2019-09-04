Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1525DC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:35:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D214B21726
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PleWZl9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D214B21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5c0H-0003tS-NM
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0z-0005Zh-0F
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0v-0003Dv-GN
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:24 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:38494)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b0u-0003Co-V2
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:21 -0400
Received: by mail-pg1-x543.google.com with SMTP id d10so7223853pgo.5
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=852c/awIgTh3C7GCCijbpsvu4SQYTMvdpB+Gb73lAXI=;
 b=PleWZl9qI/5fL2wLcpKqsJ8ESef2Xs/+UqLlIYlBv486L85cjw0mwEhgUe5LivT+kB
 fzqBmsfz+wd9FNF0sOFv7nEB9TT4wfoNJu5W+18J5bQuD/Z6FuyUUde7BoalePU1pePs
 u4EOBOevVKvmam3MZc0W1Z4yg9sdGrwKwW9F7GZqc76AivWZDZsZP4skAcZDP8XXi3yS
 gZKqUQCifRb0usqtCeQvZOfYvvUXk3aqJS7UacBKUYFQ1CuPWMLUlhlHDgpBPd5MJSZu
 PO7kMYKoFOC8TpFoum7iRm4OAAQ/9aN1fscqP2SyfpuY6FPmpvc4dMW4AFBtw0UTTqUO
 OnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=852c/awIgTh3C7GCCijbpsvu4SQYTMvdpB+Gb73lAXI=;
 b=n5h3n68LSOgr+3Y1xm703PbabUJpoyGG0O+1T+OUXZQFrOLto20hQYCTQ2Pa+/gldy
 KJn+g/9x8EYSgFbbh4gk/5jf84R7W1hHq1p8Pc2ZLlHX6p/UpYK0CnJ28vd5mCnZFf7R
 8k/cz1Bas5mCLp+X/skA9zzzpR9bR4lGJx2n/K12LcMeldczqjtFvgOpI5V9PbmfH8CC
 wOyvga3VoadSiQRXi9xDsBNPKoK7jGmX+3iKUaRWeV75RmheeJUItdkBYSQ+ZK96nvxA
 q4N5O5Pkn4957UeGZpU0OfgmIYz45um+tlcWw5ZrSb7LhCOfHP8gDg5t6hroyq9ukpki
 VO0A==
X-Gm-Message-State: APjAAAU6zssiV42tqjL7FgxANcgtuq9juuLwJolWjwkNahOkGMlTmUyE
 jAsQr6d3/3DGqbA5b+oZkUMjrjqkSfI=
X-Google-Smtp-Source: APXvYqwXT6zoPw0imc6lPNQBN5k07CAss7RvCBb1HDn2SsF+x3mbSYDmpsEDCmCHwZz+XIptRQvhyg==
X-Received: by 2002:aa7:9508:: with SMTP id b8mr31575939pfp.36.1567625539480; 
 Wed, 04 Sep 2019 12:32:19 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:32:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:52 -0700
Message-Id: <20190904193059.26202-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v4 62/69] target/arm: Convert T16,
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
index ed52018c17..a4844992d5 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10721,7 +10721,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t val, op, rm, rd, shift, cond;
+    uint32_t val, op, rm, rd, shift;
     int32_t offset;
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
@@ -10860,28 +10860,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
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


