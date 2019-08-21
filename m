Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE37C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:51:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76C6822D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k02dIzb9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C6822D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0UlQ-0003QO-9N
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40689)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0UQy-0000fT-MX
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0UQx-00070J-Hr
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:08 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:38903)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0UQx-0006zv-9M
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:07 -0400
Received: by mail-yb1-xb41.google.com with SMTP id j199so1342110ybg.5
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZYdh/Z3ecBgZtHTkBl32/Cm7PyOKZEPBtGwbEDdvb8Y=;
 b=k02dIzb9SvRf/8E6UwVLVT3c5BwFV0wqo0v/von+zbOmBfSjL3nADbQxWSPTP+IXMD
 qKBc5grjXGvhYlEPcfQw/oiCM6J/G56xQRIg//DzBV8xMTiW1NksFIHJnw02HLdGOejs
 8u+ypTIKXo22oYRjSgHdxJkgYv2Jc+bXOhS2oWU6CwZ0d8WRReep83/rASzaXMx2efCu
 zGe+6V9H3ImZ+0XWncrFXmLieL735cfDL7Nrpwun2N6EX1W61dSomx6L3D9jM1dfOJfp
 ft7Z68BySH/tpWJr+TEWL8rcvCKPViRxg1+RkdcRI6Dr+TqZ3HXRK51ViDNMK5jusv/M
 yNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZYdh/Z3ecBgZtHTkBl32/Cm7PyOKZEPBtGwbEDdvb8Y=;
 b=LCpX2/CTk//J5+TfZDycYmDgzvUazmXrKYZY+1PoIobIYMhN5obpllFDAAMqz0iUPs
 Dcsg3I1hoDkXqfdU2VytjoqQUTUxT7bAb39sVRQPufeiB8KddNvEdDxulR8iOkERnNbP
 sqsC0tFHl3eorETSJMjVZ+UZj4b9TT7DpVEIfMYrI8e4ftX34S5wDndTUlgw9ILh2dDy
 sehJlLLBtIsySHU8+a9U5nbb5yaAlQm2tHVSaBRFq52XZqpa6udt3491VHkFiGqCrLVg
 HpjVBHuNW8lO4ZucVxQYjQ2yvGS2dz9eds1/C01cvUXkMNP5NNMnUkqomMjLITN7EoMv
 jIfQ==
X-Gm-Message-State: APjAAAUmJwr7Ake5FCZm0u/su2eOdm9aq8/8ax1OSwczN+s+aYhGC508
 fUcTAoVuCFyVhJDehAFNxTJ8omJM
X-Google-Smtp-Source: APXvYqxoJ485tdppN+pbDF1aIrZbsgEW1+WIDonnOJkyFZvh/F+MUPNox3D8ENAwblUZ/QT4uQechg==
X-Received: by 2002:a25:ccd7:: with SMTP id
 l206mr24409392ybf.165.1566408606673; 
 Wed, 21 Aug 2019 10:30:06 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:06 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:28:41 -0400
Message-Id: <20190821172951.15333-6-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
Subject: [Qemu-devel] [RFC PATCH v4 05/75] target/i386: introduce
 disas_insn_prefix
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the code for decoding an instruction prefix into a separate
function.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 48 +++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 99a9097c49..410aa89c75 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4486,19 +4486,11 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
     }
 }
 
-/* convert one instruction. s->base.is_jmp is set if the translation must
-   be stopped. Return the next pc value */
-static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
+static int disas_insn_prefix(DisasContext *s, CPUX86State *env)
 {
-    CPUX86State *env = cpu->env_ptr;
     int b, prefixes;
-    int shift;
-    TCGMemOp ot, aflag, dflag;
-    int modrm, reg, rm, mod, op, opreg, val;
-    target_ulong next_eip, tval;
-    target_ulong pc_start = s->base.pc_next;
+    TCGMemOp aflag, dflag;
 
-    s->pc_start = s->pc = pc_start;
     s->override = -1;
 #ifdef TARGET_X86_64
     s->rex_x = 0;
@@ -4510,10 +4502,6 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     s->rip_offset = 0; /* for relative ip address */
     s->vex_l = 0;
     s->vex_v = 0;
-    if (sigsetjmp(s->jmpbuf, 0) != 0) {
-        gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
-        return s->pc;
-    }
 
     prefixes = 0;
 
@@ -4657,6 +4645,38 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     s->prefix = prefixes;
     s->aflag = aflag;
     s->dflag = dflag;
+    return b;
+illegal_op:
+    gen_illegal_opcode(s);
+    return -1;
+unknown_op:
+    gen_unknown_opcode(env, s);
+    return -1;
+}
+
+/*
+ * convert one instruction. s->base.is_jmp is set if the translation must
+ * be stopped. Return the next pc value.
+ */
+static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
+{
+    CPUX86State *env = cpu->env_ptr;
+    int b, shift;
+    TCGMemOp ot;
+    int modrm, reg, rm, mod, op, opreg, val;
+    target_ulong next_eip, tval;
+    target_ulong pc_start = s->base.pc_next;
+
+    s->pc_start = s->pc = pc_start;
+    if (sigsetjmp(s->jmpbuf, 0) != 0) {
+        gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+        return s->pc;
+    }
+
+    b = disas_insn_prefix(s, env);
+    if (b < 0) {
+        return s->pc;
+    }
 
     /* now check op code */
  reswitch:
-- 
2.20.1


