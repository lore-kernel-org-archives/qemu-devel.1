Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15595C47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:05:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D41AF20857
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hfv0ZDP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41AF20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUXEJ-00089L-Uu
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 11:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUX7R-0004sX-2N
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:59:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUX6T-00080k-7R
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:58:24 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53554)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jUX6S-0007xh-Pd
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:57:24 -0400
Received: by mail-wm1-x343.google.com with SMTP id k12so6174599wmj.3
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 07:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xecdaPhT+t7HsLMZz6EaOAdCJ68I6JHyMXHYh9SkvvA=;
 b=hfv0ZDP2pF0XXZdGhYatVBkMJgP0DtiFYkVi9IJniep4+Dijp3KvYNX5lr/Ia8aWrk
 eKxSc8rjuZkHzDhjSm1GVoFsXRmLtiaVz1+AKs8cQZHVBkjkmmuZ0Knp6U1a9szlUNyQ
 gxqhbITutMbBK6K75nQvv6knF6Q4yX3t7TwyDXT6au4j+lqBqqhty30rmhJQfCXIXGH0
 0InTgE9r8aKBy3D5lW/+kRSwXv99WVfEUbKAJl6QXPYbKLsYSU+/rK2Grn7yefPeoiZ/
 LYaWpcM8ORpbHvftXyI29IJNoAFG7zvQ9hvzHykoIoYa32/BbasEtNB6m1nDp/jeJzJw
 Tk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xecdaPhT+t7HsLMZz6EaOAdCJ68I6JHyMXHYh9SkvvA=;
 b=psGtl2U6IagTFwB+OR73RxkmXIcWsTY2jII4OPyJfPbztG+pMc+mIBb0lyrCdmJKLx
 ZfHxRXiPVx1xspjCeFTIdut3XSMdodIygrrs62xUt8AWuFmIrI+SaT2kURhj/xDVbAjc
 l/rlILjpfDo6C5IA0q+auB5WInkf8xD2F9gX4FGWIb7+h2sNqnkAQkB1RSo1ryP5KNlh
 /uaLpe3FyY1UKwZtPOdxdw6nynJKqyYzcTxxPGfBiW1mWjRwQto7PeB0JEpIPJGADFRc
 wvK/zGSRqkqCgwoTxKI149QMYTs5TdIi20HW+vtS1ZahhjBUmrlOFyJLre5N0c9zkq1Z
 IOqw==
X-Gm-Message-State: AGi0PuaB4mQI3eFXFoetBrlh6xSb7oPoprONT1rq0l4jk9+u9hqIrhr6
 CWXlRKae6xq1wIdWJcobTIZYgg==
X-Google-Smtp-Source: APiQypImY+Ih3VJovnPBgOV0U8w2d4nKmnjyFDcp+0s1G2bSWO/cV2k8SJFFRWr+fj/HdjAiadPgDA==
X-Received: by 2002:a05:600c:2112:: with SMTP id
 u18mr4592318wml.112.1588345043419; 
 Fri, 01 May 2020 07:57:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c83sm4754381wmd.23.2020.05.01.07.57.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2020 07:57:19 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B98861FF93;
 Fri,  1 May 2020 15:57:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 7/7] translate-all: include guest address in out_asm output
Date: Fri,  1 May 2020 15:57:12 +0100
Message-Id: <20200501145713.19822-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200501145713.19822-1-alex.bennee@linaro.org>
References: <20200501145713.19822-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::343
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
Cc: riku.voipio@iki.fi, richard.henderson@linaro.org, laurent@vivier.eu,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already have information about where each guest instructions
representation starts stored in the tcg_ctx->gen_insn_data so we can
rectify the PC for faults. We can re-use this information to annotate
the out_asm output with guest instruction address which makes it a bit
easier to work out where you are especially with longer blocks. A
minor wrinkle is that some instructions get optimised away so we have
to scan forward until we find some actual generated code.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v1
  - better logic for doing chunk at a time
  - use new "note" facility to tag address
  - rewrite the commit log
---
 accel/tcg/translate-all.c | 40 +++++++++++++++++++++++++++++++++------
 tcg/tcg.c                 |  1 +
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index cdf58bb420..92940ae9e3 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1794,14 +1794,44 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     if (qemu_loglevel_mask(CPU_LOG_TB_OUT_ASM) &&
         qemu_log_in_addr_range(tb->pc)) {
         FILE *logfile = qemu_log_lock();
+        int code_size, data_size = 0;
+        g_autoptr(GString) note = g_string_new("[tb header & initial instruction]");
+        size_t chunk_start = 0;
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
 
-            log_disas(tb->tc.ptr, code_size, NULL);
+        /* Dump header and the first instruction */
+        chunk_start = tcg_ctx->gen_insn_end_off[insn];
+        log_disas(tb->tc.ptr, chunk_start, note->str);
 
+        /*
+         * Dump each instruction chunk, wrapping up empty chunks into
+         * the next instruction. The whole array is offset so the
+         * first entry is the beginning of the 2nd instruction. The
+         * last offset is zeroed and indicates the remaining code.
+         */
+        while (insn <= tb->icount && chunk_start < code_size) {
+            size_t chunk_end = tcg_ctx->gen_insn_end_off[insn];
+            if (chunk_end > chunk_start) {
+                g_string_printf(note, "[guest addr: " TARGET_FMT_lx "]",
+                                tcg_ctx->gen_insn_data[insn][0]);
+                log_disas(tb->tc.ptr + chunk_start, chunk_end - chunk_start,
+                          note->str);
+                chunk_start = chunk_end;
+            }
+            insn++;
+        }
+
+        /* Finally dump any data we may have after the block */
+        if (data_size) {
+            int i;
+            qemu_log("  data: [size=%d]\n", data_size);
             for (i = 0; i < data_size; i += sizeof(tcg_target_ulong)) {
                 if (sizeof(tcg_target_ulong) == 8) {
                     qemu_log("0x%08" PRIxPTR ":  .quad  0x%016" PRIx64 "\n",
@@ -1813,8 +1843,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
                              *(uint32_t *)(tcg_ctx->data_gen_ptr + i));
                 }
             }
-        } else {
-            log_disas(tb->tc.ptr, gen_code_size, NULL);
         }
         qemu_log("\n");
         qemu_log_flush();
diff --git a/tcg/tcg.c b/tcg/tcg.c
index a2268d9db0..f5e4529df2 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -4211,6 +4211,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     }
     tcg_debug_assert(num_insns >= 0);
     s->gen_insn_end_off[num_insns] = tcg_current_code_size(s);
+    s->gen_insn_end_off[num_insns + 1] = 0;
 
     /* Generate TB finalization at the end of block */
 #ifdef TCG_TARGET_NEED_LDST_LABELS
-- 
2.20.1


