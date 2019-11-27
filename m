Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B22C43215
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:13:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBB572070B
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EX1XSn6p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB572070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia1od-0003Wu-UR
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 13:13:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ia1Va-00028V-7h
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:53:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ia1VY-0006Xm-7n
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:53:45 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:45983)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ia1VX-0006VY-UC
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:53:44 -0500
Received: by mail-wr1-x430.google.com with SMTP id j42so1888572wrj.12
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 09:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EpgphVvUKA12c93smk0IgAgfJ9d+b4ymZLRm0eM50e4=;
 b=EX1XSn6pTF8q08lzceIZVE0jx/jYtwSdpsUyA4dqIbDFC9OExY7GKjk9owAH1mWYxV
 ZkGvrFBXUJi9JR/6HmPtGwxPuI0RhbhYIF4Fe/fe3DD58LZG3+VeoySGssKM7wa2uu1v
 E2zyhGYJcaAwxnueCgFyqZxD3yP8S5+WcFist0hIpcXtCCRLuLhXmky6FpT1gctdiO6c
 h5cSPbFdxDk5eH3Zjh/3TuWmlNSs3CXIYMrUw7ZCR72XIW7e5/ZAatCDvgk50SNa/9iL
 NCSv0MZYDp/Z3pycddEEjo3ZWLDgv/9USeWojlgEsjM5BlT20D4GnaJNjroHHd2kM+BM
 XmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EpgphVvUKA12c93smk0IgAgfJ9d+b4ymZLRm0eM50e4=;
 b=GhO4BGeg0/vJxDex0w6rB332PBF2TBNpmbSO+88WPIc5d6Ec+N2uLVWmrzUgb3J3z/
 0wfqYV+blrJ4h/cmubgYQ0zej9yZFPLRErY1pBVkS4Rts7u45x/a8vzDAWNKYhdybfj7
 9S+K+f3hDA6wOJhJDrwFc6LZEDtcQTctudCnntgisfiVLCEN8Rc/hwIoxuJhalYYfvsd
 bzi6UOoNzo04BvLV/mWxeNuP4ZBnlzFR4Z/5cjKbyXPrkWksZuqmZ1i+fZelqffOPCt4
 K91YAkByXaH+CvMQOAxUxGxYVbBKTy/g+hocvuqkS3SSm+waukyGQ9NoZ59fu5/MXeIo
 T3FA==
X-Gm-Message-State: APjAAAUb7La5FJDsSYZOJ7U/e2oF6ZP489uwGyef/1l4LyE6kv1hgP0s
 eb65iyaSWicoboGA0srrMBlLqETMZN0Geijf
X-Google-Smtp-Source: APXvYqy2OouNZDtzjuK+YohPR0L6ikZx0w9uGTrzBPDJmcPmQnWiGXC/ddZq8hoenLAk5UdeNQbv9A==
X-Received: by 2002:a5d:46ce:: with SMTP id g14mr6525548wrs.98.1574877220380; 
 Wed, 27 Nov 2019 09:53:40 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-178-2-87.red.bezeqint.net. [79.178.2.87])
 by smtp.gmail.com with ESMTPSA id b2sm20238295wrr.76.2019.11.27.09.53.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 27 Nov 2019 09:53:39 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v37 04/17] target/avr: Add instruction translation - Registers
 definition
Date: Wed, 27 Nov 2019 19:52:44 +0200
Message-Id: <20191127175257.23480-5-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191127175257.23480-1-mrolnik@gmail.com>
References: <20191127175257.23480-1-mrolnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
 me@xcancerberox.com.ar, richard.henderson@linaro.org, dovgaluk@ispras.ru,
 imammedo@redhat.com, philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 target/avr/translate.c | 145 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)
 create mode 100644 target/avr/translate.c

diff --git a/target/avr/translate.c b/target/avr/translate.c
new file mode 100644
index 0000000000..fad074b88a
--- /dev/null
+++ b/target/avr/translate.c
@@ -0,0 +1,145 @@
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
+static TCGv cpu_r[NUMBER_OF_CPU_REGISTERS];
+static TCGv cpu_eind;
+static TCGv cpu_sp;
+
+static TCGv cpu_skip;
+
+static const char reg_names[NUMBER_OF_CPU_REGISTERS][8] = {
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
+static int to_regs_16_31_by_one(DisasContext *ctx, int indx)
+{
+    return 16 + (indx % 16);
+}
+
+static int to_regs_16_23_by_one(DisasContext *ctx, int indx)
+{
+    return 16 + (indx % 8);
+}
+static int to_regs_24_30_by_two(DisasContext *ctx, int indx)
+{
+    return 24 + (indx % 4) * 2;
+}
+static int to_regs_00_30_by_two(DisasContext *ctx, int indx)
+{
+    return (indx % 16) * 2;
+}
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


