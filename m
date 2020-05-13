Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948E2C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:57:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C8B9205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FHwfVDPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C8B9205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYvdT-0001n8-Kf
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 13:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvYA-0001bi-Cg
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:52:10 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34930)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvY9-00059x-By
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:52:10 -0400
Received: by mail-wr1-x443.google.com with SMTP id j5so559748wrq.2
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 10:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PX0EAKRt7eTMltMwvNNft+7Zaeu/0FTD7z/Hv6BbjkU=;
 b=FHwfVDPfDMJlknw5hlgqjPioiyNycoe2bNodJT+GZ6fmJ4xB4qw+BMt2o/9KLchfL3
 /51gA94o5vxTVrGGH0dAvwZHfiSWdxhZ790gTPB5qLPbebEO5JBGcwmDfviHNN/BDH3V
 m4JCRqmAfjlFYGO+lbxjqat9NYIcHb21UYbtIfeLP88n5lwGPI3EGnu7tlYmxk8zBTwn
 b/0e3M2NZITJRUhipqAB95cUptiOGqO/ii539m52nGP6w1Ozmllb5rAZC4Cy5gPc7izu
 6EyNvVeozFiT9r+qUkoBa4sDANgj0LtL4Pa8iaunjNKdoZgXfqrUGUVoXoamZnLqzmdB
 klkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PX0EAKRt7eTMltMwvNNft+7Zaeu/0FTD7z/Hv6BbjkU=;
 b=jQbgMzezD0A+lhQ3pDM3rh+z8W4tP8GFCcS/GOj9ZynHh6f+JDgTKpM1C2RUR7hZiZ
 nIpXHfYWgWSdfLSl2XEUdA9f464q/Ub+PU67Q/KtRU+Yqznk2A7i51EDsb/R0nL6pMiw
 Q4FBckAOcLdBu0IlD1BILl89s8fVQJSdLReCB5uv8BWR+0C/9J7D4mbefbkDIl2yykbD
 PnSRmqh6+lX5pQz/JeuxbNu5ZQxLz1Gl+PaA2EgSkrwm7N00B5PDZj1SFlmuY4YwH9JF
 5jOQbLkqN7YTHyvxOETQkvDacm3+PemzjrVpWxhSXZkGcxa8pZaG6THxsnTd2tfIe54N
 v7WA==
X-Gm-Message-State: AOAM532cCtkH3w2EOwOsE7odkZGXGSdvGssxJXPgu01q0vEYndzC+kPr
 xrrOgGzor3MRvfyQ0IQ+/IzlE1gyYAA=
X-Google-Smtp-Source: ABdhPJzAOwJN2toaZEGKJPxH3nGsOSgsYjsAtlHPM1N7lwoHJHCbRUpr+twuiPWwWhfVTh/UzADtNQ==
X-Received: by 2002:a5d:5607:: with SMTP id l7mr523518wrv.370.1589392306353;
 Wed, 13 May 2020 10:51:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q74sm30721232wme.14.2020.05.13.10.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 10:51:40 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9C5CA1FF96;
 Wed, 13 May 2020 18:51:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 08/10] disas: include an optional note for the start of
 disassembly
Date: Wed, 13 May 2020 18:51:32 +0100
Message-Id: <20200513175134.19619-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513175134.19619-1-alex.bennee@linaro.org>
References: <20200513175134.19619-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will become useful shortly for providing more information about
output assembly inline. While there fix up the indenting and code
formatting in disas().

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

---
v2
  - minor tweak to if(note){} fprintf(out,"\n") logig
---
 include/disas/disas.h     |  2 +-
 include/exec/log.h        |  4 ++--
 accel/tcg/translate-all.c |  4 ++--
 disas.c                   | 14 ++++++++++----
 tcg/tcg.c                 |  4 ++--
 5 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/include/disas/disas.h b/include/disas/disas.h
index 36c33f6f194..1b6e035e32d 100644
--- a/include/disas/disas.h
+++ b/include/disas/disas.h
@@ -7,7 +7,7 @@
 #include "cpu.h"
 
 /* Disassemble this for me please... (debugging). */
-void disas(FILE *out, void *code, unsigned long size);
+void disas(FILE *out, void *code, unsigned long size, const char *note);
 void target_disas(FILE *out, CPUState *cpu, target_ulong code,
                   target_ulong size);
 
diff --git a/include/exec/log.h b/include/exec/log.h
index fcc7b9e00ba..3ed797c1c8c 100644
--- a/include/exec/log.h
+++ b/include/exec/log.h
@@ -56,13 +56,13 @@ static inline void log_target_disas(CPUState *cpu, target_ulong start,
     rcu_read_unlock();
 }
 
-static inline void log_disas(void *code, unsigned long size)
+static inline void log_disas(void *code, unsigned long size, const char *note)
 {
     QemuLogFile *logfile;
     rcu_read_lock();
     logfile = atomic_rcu_read(&qemu_logfile);
     if (logfile) {
-        disas(logfile->fd, code, size);
+        disas(logfile->fd, code, size, note);
     }
     rcu_read_unlock();
 }
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index e4f703a7e6d..cdf58bb420e 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1800,7 +1800,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
             size_t data_size = gen_code_size - code_size;
             size_t i;
 
-            log_disas(tb->tc.ptr, code_size);
+            log_disas(tb->tc.ptr, code_size, NULL);
 
             for (i = 0; i < data_size; i += sizeof(tcg_target_ulong)) {
                 if (sizeof(tcg_target_ulong) == 8) {
@@ -1814,7 +1814,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
                 }
             }
         } else {
-            log_disas(tb->tc.ptr, gen_code_size);
+            log_disas(tb->tc.ptr, gen_code_size, NULL);
         }
         qemu_log("\n");
         qemu_log_flush();
diff --git a/disas.c b/disas.c
index 3937da61571..7e8692de301 100644
--- a/disas.c
+++ b/disas.c
@@ -586,7 +586,7 @@ char *plugin_disas(CPUState *cpu, uint64_t addr, size_t size)
 }
 
 /* Disassemble this for me please... (debugging). */
-void disas(FILE *out, void *code, unsigned long size)
+void disas(FILE *out, void *code, unsigned long size, const char *note)
 {
     uintptr_t pc;
     int count;
@@ -674,10 +674,16 @@ void disas(FILE *out, void *code, unsigned long size)
     for (pc = (uintptr_t)code; size > 0; pc += count, size -= count) {
         fprintf(out, "0x%08" PRIxPTR ":  ", pc);
         count = print_insn(pc, &s.info);
-	fprintf(out, "\n");
-	if (count < 0)
-	    break;
+        if (note) {
+            fprintf(out, "\t\t%s", note);
+            note = NULL;
+        }
+        fprintf(out, "\n");
+        if (count < 0) {
+            break;
+        }
     }
+
 }
 
 /* Look up symbol for debugging purpose.  Returns "" if unknown. */
diff --git a/tcg/tcg.c b/tcg/tcg.c
index dd4b3d76844..a2268d9db0a 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1092,7 +1092,7 @@ void tcg_prologue_init(TCGContext *s)
             size_t data_size = prologue_size - code_size;
             size_t i;
 
-            log_disas(buf0, code_size);
+            log_disas(buf0, code_size, NULL);
 
             for (i = 0; i < data_size; i += sizeof(tcg_target_ulong)) {
                 if (sizeof(tcg_target_ulong) == 8) {
@@ -1106,7 +1106,7 @@ void tcg_prologue_init(TCGContext *s)
                 }
             }
         } else {
-            log_disas(buf0, prologue_size);
+            log_disas(buf0, prologue_size, NULL);
         }
         qemu_log("\n");
         qemu_log_flush();
-- 
2.20.1


