Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBE7CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 21:31:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B215B20578
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 21:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYsQRt39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B215B20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPZ5q-00053J-3O
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 17:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36612)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iPYzh-0002E6-OX
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 17:25:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iPYzg-0008Cg-8z
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 17:25:37 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:50794)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iPYzf-00089y-Mb
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 17:25:35 -0400
Received: by mail-wm1-x330.google.com with SMTP id 11so4205146wmk.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 14:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sXgUfb/k+VBdpZH8pPaVua4ZrgGvG7BUVKKWHWPW/NE=;
 b=oYsQRt39M+RHIB6/SjdCQ2ZtVehhACpzCMmxpC9MZr1oosdEW6sKB+qPuN7BbXIr/C
 25aOtTZTpKXr1JcC/QnIy9rb/3HPStXuuvt2SVPpNSuzg3hchIf5KQvDSgq1hhiu3r2r
 Yh7rSIYGWThqvegeh+0PVS4Ahv2Z4zErCgWthh7JVAzpg0d8Fy83RqNgxqXQO8dWZp4o
 NaJEQMzEkmT6zOt7ssBhbh+pUrHjoVjFYG2MvuhLizvdSq0Zf22wIU9GHmkNAAuXJzsP
 jhfS9i1cKJ6SAhHhGac793+ihRh5vPZx8I5CGhaZtAxLlo0sn9BnjzEMQm7s3aHAUViX
 lijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sXgUfb/k+VBdpZH8pPaVua4ZrgGvG7BUVKKWHWPW/NE=;
 b=L6tapNfSp0CadyMjnyF2UuHhmR8svOLDDDAEchsE4j5AbawESCCPl0gVumnRdPANt+
 jRB+j+4Qf8xg1RBxSUF6tG66CjAybOE4N8J9sgfsbgELNhY6aTSMblF7YSGSMeU6mp3m
 /3GxK+hV/Uh5wqtpH9V4bHXjhj2BAxXGMjCQJWeaLUazRn/ba6AmS8Xw46omdmYlQiZw
 Ku2yxdy4jhKSohJRA31sbF8ZbdupclO6DdZGRm0rGE5pOmfpTTflQ+wCmG28vOXWSUzx
 sGttwgZCjtLG7fppbgUSAyjvxn1vzVlvaMrn7Bm1aRnxglpNz0LQvEoHLzp5pQ224zjn
 MX2A==
X-Gm-Message-State: APjAAAU0JOkQCaXUieUcm0zGND76Rerb4ywMxeEr73hDq9DFImbWCRDV
 1Jrok05z6vG2KYJnFDy9yH+2rVist2yrIw==
X-Google-Smtp-Source: APXvYqzOzW84uVx0worMZX/s4MJvv4TndDyFsWjdu5TTnVyp9QYbINDQ7jDX9eYRfelXrQIZ2AlLzA==
X-Received: by 2002:a1c:f302:: with SMTP id q2mr6164583wmq.142.1572384333957; 
 Tue, 29 Oct 2019 14:25:33 -0700 (PDT)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-178-97-184.red.bezeqint.net. [79.178.97.184])
 by smtp.gmail.com with ESMTPSA id 200sm4924730wme.32.2019.10.29.14.25.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 29 Oct 2019 14:25:33 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v35 04/13] target/avr: Add instruction translation - Registers
 definition
Date: Tue, 29 Oct 2019 23:24:21 +0200
Message-Id: <20191029212430.20617-5-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191029212430.20617-1-mrolnik@gmail.com>
References: <20191029212430.20617-1-mrolnik@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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
Cc: thuth@redhat.com, Michael Rolnik <mrolnik@gmail.com>,
 richard.henderson@linaro.org, dovgaluk@ispras.ru, imammedo@redhat.com,
 philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
---
 target/avr/translate.c | 132 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100644 target/avr/translate.c

diff --git a/target/avr/translate.c b/target/avr/translate.c
new file mode 100644
index 0000000000..53c9892a60
--- /dev/null
+++ b/target/avr/translate.c
@@ -0,0 +1,132 @@
+/*
+ * QEMU AVR CPU
+ *
+ * Copyright (c) 2019 Michael Rolnik
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * <http://www.gnu.org/licenses/lgpl-2.1.html>
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/qemu-print.h"
+#include "tcg/tcg.h"
+#include "cpu.h"
+#include "exec/exec-all.h"
+#include "disas/disas.h"
+#include "tcg-op.h"
+#include "exec/cpu_ldst.h"
+#include "exec/helper-proto.h"
+#include "exec/helper-gen.h"
+#include "exec/log.h"
+#include "exec/gdbstub.h"
+#include "exec/translator.h"
+#include "exec/gen-icount.h"
+
+/*
+ *  Define if you want a BREAK instruction translated to a breakpoint
+ *  Active debugging connection is assumed
+ *  This is for
+ *  https://github.com/seharris/qemu-avr-tests/tree/master/instruction-tests
+ *  tests
+ */
+#undef BREAKPOINT_ON_BREAK
+
+static TCGv cpu_pc;
+
+static TCGv cpu_Cf;
+static TCGv cpu_Zf;
+static TCGv cpu_Nf;
+static TCGv cpu_Vf;
+static TCGv cpu_Sf;
+static TCGv cpu_Hf;
+static TCGv cpu_Tf;
+static TCGv cpu_If;
+
+static TCGv cpu_rampD;
+static TCGv cpu_rampX;
+static TCGv cpu_rampY;
+static TCGv cpu_rampZ;
+
+static TCGv cpu_r[NO_CPU_REGISTERS];
+static TCGv cpu_eind;
+static TCGv cpu_sp;
+
+static TCGv cpu_skip;
+
+static const char reg_names[NO_CPU_REGISTERS][8] = {
+    "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
+    "r8",  "r9",  "r10", "r11", "r12", "r13", "r14", "r15",
+    "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
+    "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
+};
+#define REG(x) (cpu_r[x])
+
+enum {
+    DISAS_EXIT   = DISAS_TARGET_0,  /* We want return to the cpu main loop.  */
+    DISAS_LOOKUP = DISAS_TARGET_1,  /* We have a variable condition exit.  */
+    DISAS_CHAIN  = DISAS_TARGET_2,  /* We have a single condition exit.  */
+};
+
+typedef struct DisasContext DisasContext;
+
+/* This is the state at translation time. */
+struct DisasContext {
+    TranslationBlock *tb;
+
+    CPUAVRState *env;
+    CPUState *cs;
+
+    target_long npc;
+    uint32_t opcode;
+
+    /* Routine used to access memory */
+    int memidx;
+    int bstate;
+    int singlestep;
+
+    TCGv skip_var0;
+    TCGv skip_var1;
+    TCGCond skip_cond;
+    bool free_skip_var0;
+};
+
+static int to_A(DisasContext *ctx, int indx) { return 16 + (indx % 16); }
+static int to_B(DisasContext *ctx, int indx) { return 16 + (indx % 8); }
+static int to_C(DisasContext *ctx, int indx) { return 24 + (indx % 4) * 2; }
+static int to_D(DisasContext *ctx, int indx) { return (indx % 16) * 2; }
+
+static uint16_t next_word(DisasContext *ctx)
+{
+    return cpu_lduw_code(ctx->env, ctx->npc++ * 2);
+}
+
+static int append_16(DisasContext *ctx, int x)
+{
+    return x << 16 | next_word(ctx);
+}
+
+
+static bool avr_have_feature(DisasContext *ctx, int feature)
+{
+    if (!avr_feature(ctx->env, feature)) {
+        gen_helper_unsupported(cpu_env);
+        ctx->bstate = DISAS_NORETURN;
+        return false;
+    }
+    return true;
+}
+
+static bool decode_insn(DisasContext *ctx, uint16_t insn);
+#include "decode_insn.inc.c"
+
-- 
2.17.2 (Apple Git-113)


