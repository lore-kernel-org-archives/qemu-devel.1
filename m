Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD190C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 00:55:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5060520838
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 00:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yk89YWsz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5060520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYIhS-0003oC-8O
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 20:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYIbm-00048N-OV
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:49:36 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46115)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYIbg-0001pF-IM
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:49:34 -0400
Received: by mail-pg1-x543.google.com with SMTP id n16so3736055pgv.13
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 17:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8pLkiqkIjZ/7Qr8Zv4gVi8ZhnT5Yj9+J9ATOQP2/qhI=;
 b=Yk89YWszf5JD6Ic7xaLk6bhhr8ojInWKf7wBno+yhJ2sLbAeWHSP9a5IxjG0UbKzJQ
 +FYpnteOkJFzxSZ+eo6UnId4bxdmO2We8M4+5BYqSfrlAXpn78xbjl2EHkX8vMk94sxQ
 otuwwyej9/bxrnkp3p4aDmgAdBkIIlvgqbHzXtbSWf7vJpNHdhCsD5yvC+MGCvGRCWZj
 oMEioEbc7M43mGSRePzalcgzWEGWSII4w4D4ZxPwhKXew+BEtwE+3oaAcYSavuTV1srS
 Th1GhONSVjqP9XCILvQ+iK1CmbELbPyTa8UOFJhqf/8dItWP73+bATT15Tj8lEZQnW0D
 oZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8pLkiqkIjZ/7Qr8Zv4gVi8ZhnT5Yj9+J9ATOQP2/qhI=;
 b=MEeHI+8MCoLQX4SMZ8e0pBcwKw/eAnSQ8feJgARKTCdKG85hwxtukKC+F9Gxdfq6AV
 6pp3gGz5Zo6YANUER98U3XX/fPTHgtwaP5tq5APcKQtAuYYdIRYIxe4w5YmqOLkPWolA
 hyvfDiyJP4P2vJEnqs8NkXDc3N25CMQuqqQ59pWA3ikBZ97ztLrFqIM51MzUUbzZgeka
 Ry6OOVv/aHOsWAVDXLgBRotUFMaTmIHMBSmBGPmmgeZjpt0T6Jy+uheGTy61/n628YiV
 MNmise4saT+DFYzdYOFFNoDld/Fno6bCbDZh195Lk5m+xTBgyeXz/m5ov1T+58YSFqPA
 b4PA==
X-Gm-Message-State: AOAM5310YP9ghVJBB6Uh7usGbmRh3sHLRiNvphvZVr7W7M9jALNDa6uW
 c+4sP3KyqQmGREVhuFIXMxKt3FPIA6DQaA==
X-Google-Smtp-Source: ABdhPJwEI8f80BYXNQS4p5IlkC+4Mdt/XvKMiEeCNXsa28tZS8mONk2q2mie4Z/TRVnC2MPW4srz3A==
X-Received: by 2002:a63:134d:: with SMTP id 13mr6282120pgt.370.1604018966204; 
 Thu, 29 Oct 2020 17:49:26 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b6sm3557264pgq.58.2020.10.29.17.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 17:49:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/19] tcg: Move tcg prologue pointer out of TCGContext
Date: Thu, 29 Oct 2020 17:49:04 -0700
Message-Id: <20201030004921.721096-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030004921.721096-1-richard.henderson@linaro.org>
References: <20201030004921.721096-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: pbonzini@redhat.com, j@getutm.app, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This value is constant across all thread-local copies of TCGContext,
so we might as well move it out of thread-local storage.

Use the correct function pointer type, and name the variable
tcg_qemu_tb_exec, which means that we are able to remove the
macro that does the casting.

Replace HAVE_TCG_QEMU_TB_EXEC with CONFIG_TCG_INTERPRETER,
as this is somewhat clearer in intent.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h    | 9 ++++-----
 tcg/tci/tcg-target.h | 2 --
 tcg/tcg.c            | 9 ++++++++-
 tcg/tci.c            | 3 ++-
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 8804a8c4a2..5ff5bf2a73 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -621,7 +621,6 @@ struct TCGContext {
        here, because there's too much arithmetic throughout that relies
        on addition and subtraction working on bytes.  Rely on the GCC
        extension that allows arithmetic on void*.  */
-    void *code_gen_prologue;
     void *code_gen_epilogue;
     void *code_gen_buffer;
     size_t code_gen_buffer_size;
@@ -1220,11 +1219,11 @@ static inline unsigned get_mmuidx(TCGMemOpIdx oi)
 #define TB_EXIT_IDXMAX    1
 #define TB_EXIT_REQUESTED 3
 
-#ifdef HAVE_TCG_QEMU_TB_EXEC
-uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr);
+#ifdef CONFIG_TCG_INTERPRETER
+uintptr_t tcg_qemu_tb_exec(CPUArchState *env, void *tb_ptr);
 #else
-# define tcg_qemu_tb_exec(env, tb_ptr) \
-    ((uintptr_t (*)(void *, void *))tcg_ctx->code_gen_prologue)(env, tb_ptr)
+typedef uintptr_t tcg_prologue_fn(CPUArchState *env, void *tb_ptr);
+extern tcg_prologue_fn *tcg_qemu_tb_exec;
 #endif
 
 void tcg_register_jit(void *buf, size_t buf_size);
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 6460449719..49f3291f8a 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -189,8 +189,6 @@ typedef enum {
 
 void tci_disas(uint8_t opc);
 
-#define HAVE_TCG_QEMU_TB_EXEC
-
 /* Flush the dcache at RW, and the icache at RX, as necessary. */
 static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
 {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 3bf36e0cfe..8d63c714fb 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -161,6 +161,10 @@ static TCGContext **tcg_ctxs;
 static unsigned int n_tcg_ctxs;
 TCGv_env cpu_env = 0;
 
+#ifndef CONFIG_TCG_INTERPRETER
+tcg_prologue_fn *tcg_qemu_tb_exec;
+#endif
+
 struct tcg_region_tree {
     QemuMutex lock;
     GTree *tree;
@@ -1053,7 +1057,10 @@ void tcg_prologue_init(TCGContext *s)
     s->code_ptr = buf0;
     s->code_buf = buf0;
     s->data_gen_ptr = NULL;
-    s->code_gen_prologue = buf0;
+
+#ifndef CONFIG_TCG_INTERPRETER
+    tcg_qemu_tb_exec = (tcg_prologue_fn *)buf0;
+#endif
 
     /* Compute a high-water mark, at which we voluntarily flush the buffer
        and start over.  The size here is arbitrary, significantly larger
diff --git a/tcg/tci.c b/tcg/tci.c
index 82039fd163..d996eb7cf8 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -475,8 +475,9 @@ static bool tci_compare64(uint64_t u0, uint64_t u1, TCGCond condition)
 #endif
 
 /* Interpret pseudo code in tb. */
-uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
+uintptr_t tcg_qemu_tb_exec(CPUArchState *env, void *v_tb_ptr)
 {
+    uint8_t *tb_ptr = v_tb_ptr;
     tcg_target_ulong regs[TCG_TARGET_NB_REGS];
     long tcg_temps[CPU_TEMP_BUF_NLONGS];
     uintptr_t sp_value = (uintptr_t)(tcg_temps + CPU_TEMP_BUF_NLONGS);
-- 
2.25.1


