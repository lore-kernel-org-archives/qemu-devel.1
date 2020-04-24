Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A33C54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 17:40:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3DDF206B9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 17:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j3ivlIzM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3DDF206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS2JN-00073t-LH
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 13:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jS2IT-0006Ox-RU
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 13:39:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jS2IS-00063w-Jj
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 13:39:29 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jS2IS-0005xl-5z
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 13:39:28 -0400
Received: by mail-wr1-x444.google.com with SMTP id j2so11899857wrs.9
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 10:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UYYv1cklqi3lKfo2WFxkU8h/TgF0pb3Dq/qwxKtV6C4=;
 b=j3ivlIzMwDtxULJmUnH0RYPeUPbLlVvrW7SUUzhUxUB+1yWUYdgiz5zkXHO+/YExqM
 urXhfuk3khuh5p3hIeXiUmHOPUcOL1mqGJQnn4jOMs9eEmC1zqjI4SwBagpKPzJjTl/w
 HfSsLFQ6ihkkExHNYPu6vj69FNp9yBE/d0CUJ7E/MI+eblRSWbOiypZpEsbVoymRADxK
 7H2E+InYUlDILXxgRUF5XhOkzzDUMkYrNju0OXKIpcCMU+wS8gNzxOhmnJcNczLzpUYw
 cVYb+t5m0h2ViqUHOSsc1Osqx8BIqgI4fgKBVaj2vFsJJ8O0JkfleTSBAGhNmNONNxSb
 pSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UYYv1cklqi3lKfo2WFxkU8h/TgF0pb3Dq/qwxKtV6C4=;
 b=Z9iR1rmYTbvm0UZHQqpA22eG/lj2G56Cb+qr/a+Kv3Yh4//F8o7TSmc62gJMqDbF5I
 XarNO15tSxI7J7SF969zvrsHa8sNMbu1Bw67myAx6zXOt2J+QnU4DFGzI6/JiNukLk5Z
 mTQ4LcHbGSoDk0lYfBRMCa0baagBsoBjDqezOS+xU5ucAmPXdYV1HtVmGfSp4DprUta0
 DOGR38qp35Muwka+1U/cr9zN5OmbvdgqIKIu24r8bt8Es3ydOs+B04Sx6fZ4zd+V0EAY
 nvXDVevnMiOihYKc5P59NPNplxXElapzaXUrPXpWfVcX2LodJDZmrILGQBIHMnIbEOP7
 iZTg==
X-Gm-Message-State: AGi0Puaqayw/7/y9A3e8BmVz5zCQ3M8XOG20SVNRHYq0NYKPiWGcKs32
 yJ1LIjo2LvghEPcsYgg2+/ONow==
X-Google-Smtp-Source: APiQypJ/GVNCyK1gsBIxnaGRe4vkTH/l8V9gJD9S4MIkGu3xK+Ifw3KHahfPHBcdQRB2yWfmBu3d1A==
X-Received: by 2002:adf:e5c8:: with SMTP id a8mr13402753wrn.56.1587749965861; 
 Fri, 24 Apr 2020 10:39:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y5sm9713493wru.15.2020.04.24.10.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 10:39:24 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C74841FF7E;
 Fri, 24 Apr 2020 18:39:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] translate-all: include guest address in out_asm output
Date: Fri, 24 Apr 2020 18:39:14 +0100
Message-Id: <20200424173914.2957-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::444
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, richard.henderson@linaro.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a slightly hackish Friday afternoon attempt to include the
guest address in our out_asm output in an effort to make it a little
easier to see what is generating what final assembly.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/translate-all.c | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 9924e66d1f..31711de938 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1789,14 +1789,42 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     if (qemu_loglevel_mask(CPU_LOG_TB_OUT_ASM) &&
         qemu_log_in_addr_range(tb->pc)) {
         FILE *logfile = qemu_log_lock();
+        size_t code_size, data_size = 0;
+        size_t insn_start;
+        int insn = 0;
         qemu_log("OUT: [size=%d]\n", gen_code_size);
         if (tcg_ctx->data_gen_ptr) {
-            size_t code_size = tcg_ctx->data_gen_ptr - tb->tc.ptr;
-            size_t data_size = gen_code_size - code_size;
-            size_t i;
+            code_size = tcg_ctx->data_gen_ptr - tb->tc.ptr;
+            data_size = gen_code_size - code_size;
+        } else {
+            code_size = gen_code_size;
+        }
+
+        /* first dump prologue */
+        insn_start = tcg_ctx->gen_insn_end_off[0];
+        if (insn_start > 0) {
+            qemu_log("  prologue: [size=%ld]\n", insn_start);
+            log_disas(tb->tc.ptr, insn_start);
+        }
+
+        do {
+            size_t insn_end;
+            if (insn < (tb->icount - 1)) {
+                insn_end = tcg_ctx->gen_insn_end_off[insn + 1];
+            } else {
+                insn_end = code_size;
+            }
+            qemu_log("  for guest addr: " TARGET_FMT_lx ":\n",
+                     tcg_ctx->gen_insn_data[insn][0]);
+
+            log_disas(tb->tc.ptr + insn_start, insn_end - insn_start);
 
-            log_disas(tb->tc.ptr, code_size);
+            insn_start = insn_end;
+        } while (++insn < tb->icount && insn_start < code_size);
 
+        if (data_size) {
+            int i;
+            qemu_log("  data: [size=%ld]\n", data_size);
             for (i = 0; i < data_size; i += sizeof(tcg_target_ulong)) {
                 if (sizeof(tcg_target_ulong) == 8) {
                     qemu_log("0x%08" PRIxPTR ":  .quad  0x%016" PRIx64 "\n",
@@ -1808,8 +1836,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
                              *(uint32_t *)(tcg_ctx->data_gen_ptr + i));
                 }
             }
-        } else {
-            log_disas(tb->tc.ptr, gen_code_size);
         }
         qemu_log("\n");
         qemu_log_flush();
-- 
2.20.1


