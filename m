Return-Path: <SRS0=QAbx=Z6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A491C2D0BF
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 18:56:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A59C205F4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 18:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOXKZ8zG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A59C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ie1jd-0004Aw-RA
	for qemu-devel@archiver.kernel.org; Sun, 08 Dec 2019 13:56:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ie1TX-00027i-SQ
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ie1TU-0002yC-7R
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:10 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:37703)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ie1TS-0002uG-2z
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:06 -0500
Received: by mail-wm1-x334.google.com with SMTP id f129so12516397wmf.2
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2019 10:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7ACWPIiwb1OnjUxWJCNQY1YhmvZfMvPFy7qV6Dou5t8=;
 b=ZOXKZ8zGghLA8ob2q9aqf/NjqLba+u7ait3E8Wolo8bqudfIr/ll2DSn3jv+VvsNrJ
 6EOocrzaafSKi3GOBEp60DfWQigaL7ekTbFunfZ/mBfMWp9sBX3H2RvaEWtcwlLimtbk
 Gt4z6I3sWtbyt8Bc68SJc7R0nUoMH8XjdglzehZY3SMt1aE8x4T48CM8q6k1Tv16w5R2
 wrPVwK//JwFzhmMsA5+bqxo4sotsHwHkeZXJHVs5evRwAMTtH6a8aeTzSeSBD6PkXcsq
 aL9IYSOESGqVtGjXAmcycYLFS4BZ3Q7UQVbWwWXTdIMdBENA5vikDL2trwbo6aZRoBd7
 l/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7ACWPIiwb1OnjUxWJCNQY1YhmvZfMvPFy7qV6Dou5t8=;
 b=rY1JY1+lgYyTYYIV9lQ6mSW0028dahZk4CCJ9XLQFuHBLE1PRkTmQhYtxFFTJ4Sy6b
 BDj1o91wjVNkSyzhF1GFpQGXhS3gsNgExBgziynPDDxUBh7jCgGfSjuPqRckx2ljSGzU
 8+D3G2aYme4Azcj5q0mtesjgaSHRH2XLBgDvUytO7jBwsysL6S2GbI+WGBTipCI5Gyus
 DAHRJSFf4W3fyzkvdvrQkFHv1ZFeC4Fs59spVPEoz1RnM/l6uevrZJBk1BEanhUk9lYW
 8NKmttqitCD1hGnMiwGpW+MGGpFbL3SXErOisRGCsSL+RGZkJcn0kETI0DuFA1LwHJBA
 4Wvg==
X-Gm-Message-State: APjAAAXaK+7L4GP380dJzp5R6u5ljzLkgcZ0fCDmNjYToqhBwFwRCS/4
 87GshA+bhiSc+DH3A1eqRho0mRpepszYrydJ
X-Google-Smtp-Source: APXvYqzzTQSKfsfhbhRRlZYC/S+WJdl8HMc9orRA3BJDWK1JVwlBpX4kG+Dvb5wgaGGaWuwLlxHHWA==
X-Received: by 2002:a1c:109:: with SMTP id 9mr12723502wmb.10.1575830401999;
 Sun, 08 Dec 2019 10:40:01 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-180-52-3.red.bezeqint.net. [79.180.52.3])
 by smtp.gmail.com with ESMTPSA id h17sm25289717wrs.18.2019.12.08.10.40.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 08 Dec 2019 10:40:01 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v38 04/22] target/avr: Add instruction translation - Registers
 definition
Date: Sun,  8 Dec 2019 20:39:04 +0200
Message-Id: <20191208183922.13757-5-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191208183922.13757-1-mrolnik@gmail.com>
References: <20191208183922.13757-1-mrolnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
 target/avr/translate.c | 143 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100644 target/avr/translate.c

diff --git a/target/avr/translate.c b/target/avr/translate.c
new file mode 100644
index 0000000000..0139bcabb1
--- /dev/null
+++ b/target/avr/translate.c
@@ -0,0 +1,143 @@
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
+#include "tcg-op.h"
+#include "exec/cpu_ldst.h"
+#include "exec/helper-proto.h"
+#include "exec/helper-gen.h"
+#include "exec/log.h"
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


