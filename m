Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6710C38A2A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:08:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94D9820736
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qa0KaZfF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D9820736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWIrA-0004GJ-Ns
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 08:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWIo5-0006DO-1C
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:05:45 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:52246)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWIo4-0000hT-21
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:05:44 -0400
Received: by mail-wm1-x32d.google.com with SMTP id 188so2308924wmc.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 05:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iv5aExKuZFmBZpEOYjyI0CnqRcGLI8UlOxisphwDQLk=;
 b=Qa0KaZfFFnqCAdKJx1tyhgNKiK/Y/N610jkiWqKQSaa/M+WlqoyWOo5rPTJgGM5qnD
 m/HgE8rJCL4KmbabY/OeFiFVT1F3sclG3qUQWg/fTYo1SxH6G4H1FU93DkARRPI2RAsf
 r1HC7YfJMRs9GH/8ECobuG9f3WfHIQiDznKbSRJLpb8pzdo0ZmhRyUNPG3uRFowEAHz5
 FS/TdJu8daJVRGtmkLI5FUgZdvo4WKl2xZzi8JhnNY8OB7ZCSWOl9uwqUGiU/1fZ9Ada
 2+cNdSLlruI7IIS21vkgYkwH38B0Gh1qWwmc9nOTqkuKlkp7C5uPvvr7oz+x9Rbsw5sV
 Gujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iv5aExKuZFmBZpEOYjyI0CnqRcGLI8UlOxisphwDQLk=;
 b=qBTm9UnW8nNDt3rMjv6J1lwwEY+Cqj+fcFimLDueMZTmjSaa5gjY+6CEIs5RzpFNkt
 DkkSGBFuCUdSR/ia2COsbqcvg8lSrx2XYYUbOs0C+KUA3cf/mtBr0DdDm0TAVMWv3gj0
 lcRfWGj6H6RyM3geJQ948WYPrvnJY3TAMAjUgtKqzJN4Tjw46JnogtKvwZu6qyNf4Gue
 BzTtxzRUhT+z/qSIRw84X6YFnt2bqD6GxJHH2DuappDQKY9BWNZj3wLp+yTFJHxtEmnN
 WKK6hw0G0IJdBg3rWluDWQJYuT/5udZnayZDVyD2rf8sBr47VQc6x+jb06gDqFbzpyGF
 lCmw==
X-Gm-Message-State: AGi0PuayQpb1jM3v0MTrt+lBNxivBNYcubcszJAC6WUiU9azm8fKZspm
 xZTg6UMm2lOO+4MZ2halEIR4XQ==
X-Google-Smtp-Source: APiQypLcfFDTyaEQx+c459MAvXa0iTcf/jpM3BgnhmLEzy04kEC5BRXXXOFDkctvWmc0HpL1nxJsCw==
X-Received: by 2002:a1c:f312:: with SMTP id q18mr3967871wmq.175.1588766742586; 
 Wed, 06 May 2020 05:05:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l5sm2610859wmi.22.2020.05.06.05.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 05:05:37 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 513D41FF93;
 Wed,  6 May 2020 13:05:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 07/14] gdbstub: Introduce gdb_get_float64() to get 64-bit float
 registers
Date: Wed,  6 May 2020 13:05:22 +0100
Message-Id: <20200506120529.18974-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506120529.18974-1-alex.bennee@linaro.org>
References: <20200506120529.18974-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

When converted to use GByteArray in commits 462474d760c and
a010bdbe719, the call to stfq_p() was removed. This call
serialize a float.
Since we now use a GByteArray, we can not use stfq_p() directly.
Introduce the gdb_get_float64() helper to load a float64 register.

Fixes: 462474d760c ("target/m68k: use gdb_get_reg helpers")
Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200414163853.12164-3-philmd@redhat.com>
Message-Id: <20200430190122.4592-3-alex.bennee@linaro.org>

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 20e10726929..4a2b8e30893 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -134,6 +134,17 @@ static inline int gdb_get_float32(GByteArray *array, float32 val)
 
     return sizeof(buf);
 }
+
+static inline int gdb_get_float64(GByteArray *array, float64 val)
+{
+    uint8_t buf[sizeof(CPU_DoubleU)];
+
+    stfq_p(buf, val);
+    g_byte_array_append(array, buf, sizeof(buf));
+
+    return sizeof(buf);
+}
+
 static inline int gdb_get_zeroes(GByteArray *array, size_t len)
 {
     guint oldlen = array->len;
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index cad40838956..79b0b10ea9b 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -72,7 +72,8 @@ static int cf_fpu_gdb_get_reg(CPUM68KState *env, GByteArray *mem_buf, int n)
 {
     if (n < 8) {
         float_status s;
-        return gdb_get_reg64(mem_buf, floatx80_to_float64(env->fregs[n].d, &s));
+        return gdb_get_float64(mem_buf,
+                               floatx80_to_float64(env->fregs[n].d, &s));
     }
     switch (n) {
     case 8: /* fpcontrol */
diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index eb362dd9aec..5c11c88b2a8 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -130,7 +130,7 @@ int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
         gdb_get_regl(buf, env->gpr[n]);
     } else if (n < 64) {
         /* fprs */
-        gdb_get_reg64(buf, *cpu_fpr_ptr(env, n - 32));
+        gdb_get_float64(buf, *cpu_fpr_ptr(env, n - 32));
     } else {
         switch (n) {
         case 64:
@@ -184,7 +184,7 @@ int ppc_cpu_gdb_read_register_apple(CPUState *cs, GByteArray *buf, int n)
         gdb_get_reg64(buf, env->gpr[n]);
     } else if (n < 64) {
         /* fprs */
-        gdb_get_reg64(buf, *cpu_fpr_ptr(env, n - 32));
+        gdb_get_float64(buf, *cpu_fpr_ptr(env, n - 32));
     } else if (n < 96) {
         /* Altivec */
         gdb_get_reg64(buf, n - 64);
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index fd763e588ec..2b6e832c4c3 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -9881,7 +9881,7 @@ static int gdb_get_float_reg(CPUPPCState *env, GByteArray *buf, int n)
 {
     uint8_t *mem_buf;
     if (n < 32) {
-        gdb_get_reg64(buf, *cpu_fpr_ptr(env, n));
+        gdb_get_float64(buf, *cpu_fpr_ptr(env, n));
         mem_buf = gdb_get_reg_ptr(buf, 8);
         ppc_maybe_bswap_register(env, mem_buf, 8);
         return 8;
-- 
2.20.1


