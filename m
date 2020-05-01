Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F1FC4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E0E620857
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KsLLRDEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0E620857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUXF5-0001Iq-79
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 11:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUX7S-0004sq-3i
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:59:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUX6S-0007xs-44
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:58:25 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52751)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jUX6R-0007tp-MT
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:57:23 -0400
Received: by mail-wm1-x344.google.com with SMTP id 188so6182653wmc.2
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 07:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IZSa8c21TyIpcw6MDYTFEpVBqr4T0wU6Ux/08+8c4yw=;
 b=KsLLRDEki8wSguaUNhQfiOuCez9rFT1AcVtzsBPV8dTSLQbfaazbi+zHmxjoiUb4lv
 pI41gvWlfAykTYQLfBjEigwa9yCOX1LZk74pzA4J6Y+PsoX7tg1DuNgoy/Tw0C9WL2SI
 lKHNOxh5BE8yr3/VbzmlqsYk8pQDQc5FuGRZdiuuKTv2jAMgG76ihPZkUfsyJ7uyk0d/
 T8TudtYvE191+PDU557qIR+vuN5buB18Tp6q/HWxVwrElAahS+rFYcS+k4nLrGAdTkqw
 h+YqeDy8bdpbrYVEZKw3nQ+MPJJEM4EqHGGybLLpEQfBDKz1KezxP922fJ69yP2/19Jc
 tCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IZSa8c21TyIpcw6MDYTFEpVBqr4T0wU6Ux/08+8c4yw=;
 b=UieHzy4H/xoHsxNA9GMp4RqNaHEV5M5GKrYyYsam2gyDcl+wDbY6kyGqgVnBC4Exkd
 6lBA0QjzbV3taiQdTsoP/buHqH4pGchdheOaMQ4CkhgSjQJKRQb5Kd9QIrnmq9HMo7xR
 0sgYtGTHKH8kBIihNj6P3JUUlMM7qGnFc3lkEuKw/4zZAFz3h2Lersq0CZ516Ojq+At/
 tnd6mw/IeBfSTQ6U+j4lscGIJgZqRS3Y+RaSGiTapZv1DR2M9m9JZH3Rkyo58SPcMmgb
 B5ax/QQVulP9E1dxCk8rdUyIskGJSWHdfqpTqvbBbnBfCPi+4gWBKfr1eJx+TdrRbEWX
 WVww==
X-Gm-Message-State: AGi0Pub3oYFcb3YAjTL1hlGtCdRfYyfxaCATpSmemofNo+aZwlUSC6G+
 PM4whzOMd7V1WcZtMGBrwjIO5w==
X-Google-Smtp-Source: APiQypJhvV1M/4Wx7pa4RoU2HoqvM/DZhlUb21hrphI8btuIkxZx9Q0xAKzfhtWnbFISPz8uhtMg0g==
X-Received: by 2002:a1c:3b09:: with SMTP id i9mr4303423wma.19.1588345042237;
 Fri, 01 May 2020 07:57:22 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y11sm3292013wrh.59.2020.05.01.07.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2020 07:57:19 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A0E601FF92;
 Fri,  1 May 2020 15:57:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 6/7] disas: add optional note support to cap_disas
Date: Fri,  1 May 2020 15:57:11 +0100
Message-Id: <20200501145713.19822-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200501145713.19822-1-alex.bennee@linaro.org>
References: <20200501145713.19822-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::344
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, riku.voipio@iki.fi,
 richard.henderson@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Include support for outputting a note at the top of a chunk of
disassembly to capstone as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 disas.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/disas.c b/disas.c
index bb74650633..5e7eb65326 100644
--- a/disas.c
+++ b/disas.c
@@ -260,7 +260,8 @@ static void cap_dump_insn_units(disassemble_info *info, cs_insn *insn,
     }
 }
 
-static void cap_dump_insn(disassemble_info *info, cs_insn *insn)
+static void cap_dump_insn(disassemble_info *info, cs_insn *insn,
+                          const char *note)
 {
     fprintf_function print = info->fprintf_func;
     int i, n, split;
@@ -281,7 +282,8 @@ static void cap_dump_insn(disassemble_info *info, cs_insn *insn)
     }
 
     /* Print the actual instruction.  */
-    print(info->stream, "  %-8s %s\n", insn->mnemonic, insn->op_str);
+    print(info->stream, "  %-8s %s\t\t%s\n", insn->mnemonic, insn->op_str,
+          note ? note : "");
 
     /* Dump any remaining part of the insn on subsequent lines.  */
     for (i = split; i < n; i += split) {
@@ -313,7 +315,7 @@ static bool cap_disas_target(disassemble_info *info, uint64_t pc, size_t size)
         size -= tsize;
 
         while (cs_disasm_iter(handle, &cbuf, &csize, &pc, insn)) {
-           cap_dump_insn(info, insn);
+            cap_dump_insn(info, insn, NULL);
         }
 
         /* If the target memory is not consumed, go back for more... */
@@ -342,7 +344,8 @@ static bool cap_disas_target(disassemble_info *info, uint64_t pc, size_t size)
 }
 
 /* Disassemble SIZE bytes at CODE for the host.  */
-static bool cap_disas_host(disassemble_info *info, void *code, size_t size)
+static bool cap_disas_host(disassemble_info *info, void *code, size_t size,
+                           const char *note)
 {
     csh handle;
     const uint8_t *cbuf;
@@ -358,7 +361,8 @@ static bool cap_disas_host(disassemble_info *info, void *code, size_t size)
     pc = (uintptr_t)code;
 
     while (cs_disasm_iter(handle, &cbuf, &size, &pc, insn)) {
-       cap_dump_insn(info, insn);
+        cap_dump_insn(info, insn, note ? note : NULL);
+        note = NULL;
     }
     if (size != 0) {
         (*info->fprintf_func)(info->stream,
@@ -402,7 +406,7 @@ static bool cap_disas_monitor(disassemble_info *info, uint64_t pc, int count)
         csize += tsize;
 
         if (cs_disasm_iter(handle, &cbuf, &csize, &pc, insn)) {
-            cap_dump_insn(info, insn);
+            cap_dump_insn(info, insn, NULL);
             if (--count <= 0) {
                 break;
             }
@@ -416,7 +420,7 @@ static bool cap_disas_monitor(disassemble_info *info, uint64_t pc, int count)
 #endif /* !CONFIG_USER_ONLY */
 #else
 # define cap_disas_target(i, p, s)  false
-# define cap_disas_host(i, p, s)  false
+# define cap_disas_host(i, p, s, n)  false
 # define cap_disas_monitor(i, p, c)  false
 # define cap_disas_plugin(i, p, c) false
 #endif /* CONFIG_CAPSTONE */
@@ -664,7 +668,7 @@ void disas(FILE *out, void *code, unsigned long size, const char *note)
     print_insn = print_insn_hppa;
 #endif
 
-    if (s.info.cap_arch >= 0 && cap_disas_host(&s.info, code, size)) {
+    if (s.info.cap_arch >= 0 && cap_disas_host(&s.info, code, size, note)) {
         return;
     }
 
-- 
2.20.1


