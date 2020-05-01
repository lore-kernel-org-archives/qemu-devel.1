Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220C0C47258
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:02:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBAF820836
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eEb6ItxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBAF820836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUXAu-000098-RR
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 11:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUX7O-0004sA-Qe
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:59:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUX6R-0007uo-B8
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:58:22 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35963)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jUX6Q-0007t6-TT
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:57:22 -0400
Received: by mail-wr1-x443.google.com with SMTP id d15so11819924wrx.3
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 07:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=avj+urXq7iXuKPR7WdlISyEaRr0xyzjqnDBQFi5kr/A=;
 b=eEb6ItxXFXgxkidL4QFHPp6ifbbdrypqpVe6SuPj8qz8pNjIFbAIZbjwMcjpkt0biS
 dHb7LFcf5vQpXR6q31ZnZYgVPh6W9S/oABThXS3qFHuEq7qVuSX5ylRC9qGJgzHwbTZd
 tebDjQgx3eFY+swhhpUUdsgc52jBSFrJyYnfa7hpHf1ClMge5vJlnGL+XdxPjP4CPF2H
 Q0dUFUqF3PB6Zksb3Cg2oFeTESEJ3alK5XOGdgfvY8Q0vz7LJAoT7zlIutvwX3klWnTy
 Xv9wzQ0dSGgtL85ED8i7haF7ZLtoh6YvZMLnKyqf8LuzhpMiMguABVcUwkbXW0h3uN0q
 Boww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=avj+urXq7iXuKPR7WdlISyEaRr0xyzjqnDBQFi5kr/A=;
 b=n7pipj2SIbyNozzE1pmAz9cYgvnXxPEmAfSk8la04Df5rN36R3IXM+j/C0ONtpPqRg
 cB4R2ueV5bZR5diAvr43LPdrSSS/9VCNh78nWbcTJlNX45idcqC1Y1XVz3qvTlS5BbpW
 NdbKmVfQJXXnUQamSYhDXPpWL0Fwak69iZDMaYCH7tTdhWLKHLTHzaA20lJSJ80rauZC
 2ZD0i3irOAm4JXK2D7fpn0d1iPK+jInoNCsR0aOPVrp8bQgMI2PgtJnUv4edf5OUSiwl
 2zZN9Z0yYMboMTnAe8OoVMYjlZqe9Hr7BSXAuWnJHfmfI2JSyun4Ygt/1iO6hosvZey3
 ZCLg==
X-Gm-Message-State: AGi0PuaagQFHVAzt01anMgggHjjz33JuJ+2ZzXvfZonP1s0yyIhImXs2
 mVK7aw6E/SfQAQj5RqqVoA2oIA==
X-Google-Smtp-Source: APiQypJ17Ki4TllVDu4Z5jBrLHDl4v4fB5UAhlTkhMlubS3AJs/scMxHjx5ncwUu+QaTudaMuuVBuA==
X-Received: by 2002:a5d:498d:: with SMTP id r13mr4784588wrq.374.1588345041441; 
 Fri, 01 May 2020 07:57:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p16sm4515094wro.21.2020.05.01.07.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2020 07:57:19 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8A0FD1FF91;
 Fri,  1 May 2020 15:57:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 5/7] disas: include an optional note for the start of
 disassembly
Date: Fri,  1 May 2020 15:57:10 +0100
Message-Id: <20200501145713.19822-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200501145713.19822-1-alex.bennee@linaro.org>
References: <20200501145713.19822-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::443
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

This will become useful shortly for providing more information about
output assembly inline. While there fix up the indenting and code
formatting in disas().

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/disas/disas.h     |  2 +-
 include/exec/log.h        |  4 ++--
 accel/tcg/translate-all.c |  4 ++--
 disas.c                   | 15 +++++++++++----
 tcg/tcg.c                 |  4 ++--
 5 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/include/disas/disas.h b/include/disas/disas.h
index 36c33f6f19..1b6e035e32 100644
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
index fcc7b9e00b..3ed797c1c8 100644
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
index e4f703a7e6..cdf58bb420 100644
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
index 3937da6157..bb74650633 100644
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
@@ -674,10 +674,17 @@ void disas(FILE *out, void *code, unsigned long size)
     for (pc = (uintptr_t)code; size > 0; pc += count, size -= count) {
         fprintf(out, "0x%08" PRIxPTR ":  ", pc);
         count = print_insn(pc, &s.info);
-	fprintf(out, "\n");
-	if (count < 0)
-	    break;
+        if (note) {
+            fprintf(out, "\t\t%s\n", note);
+            note = NULL;
+        } else {
+            fprintf(out, "\n");
+        }
+        if (count < 0) {
+            break;
+        }
     }
+
 }
 
 /* Look up symbol for debugging purpose.  Returns "" if unknown. */
diff --git a/tcg/tcg.c b/tcg/tcg.c
index dd4b3d7684..a2268d9db0 100644
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


