Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76D2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:54:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B5C1205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="thfkpzSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5C1205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYvao-0005sJ-GO
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 13:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvXp-0000yU-QM
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:51:49 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34152)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvXo-0004yw-PL
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:51:49 -0400
Received: by mail-wr1-x443.google.com with SMTP id y3so568132wrt.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 10:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cOXxIq5n0K0tWjPWqLAjM36kY0q6yO5L0IxUaG95YzQ=;
 b=thfkpzSlQDTHelMG2nTVFPXtE91o86V0kBkQrcPTL+8IU98HP7Rzhrg9g0MgqI2TOK
 /sg+hsEAm4DPxIb2jxjYL1hYGADZuN16Mz+FLni7BaxK4WF8URCIKaOI031h/krCvV8b
 2GS4KAImkR3/7yUEwzH0wDtc20wUVumWSjNznS5NdTrfOO5zmG9TE3/0cljzxnR3FcPQ
 O4L0MTSb7lSp7OQ5CsE4Ee9R0SW5MNFRSZkWJVyLfidvVkvNoYA5iOAJvUeDu8pWRpqn
 Mo9jyCQEjevXDnfhUPpIJHrcM0aHZ+Dp7XctJWqjmv8+l8MnqfGK1hydSqJyDYHB65Ri
 L9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cOXxIq5n0K0tWjPWqLAjM36kY0q6yO5L0IxUaG95YzQ=;
 b=rYRrX2/mpxNPtPvyc2Wxp6W1iRCpZpj1AFpQcaNbQDFZpBK837g8SXrisIe3MKTaNW
 fwU87Be96uL6wE6uBEWXAtym9v0lvXq0uq6tAO1hrPafPWMfqZ/uOWbQAgC5vtt8QdkJ
 v9/8VKwQwmhSOgk1UNIk+/wLipNelL1C8pPgAIkJMDTKoxoKqAUobzKCyxzEneuYtWOs
 aHCCqjCLASxc7uCVmdZmmF/WDc9QgfPI8qkOhndKd+vQ7xScEe2igw0gm9TpaaKQqXKQ
 t6OtAqGOYQKFsxiZqUef7y/crewmyqVKyvAGQoa4nLv7/u6sWHv0mfWMFUBhpqi9v1r7
 mmwA==
X-Gm-Message-State: AOAM530LSnlviNlvcCTpN6nEiGsA+VZILTWFH1Iw+8KvEzZdbBcBbTjF
 R4K+ltEcV5Emd9q7YocLjuHK7w==
X-Google-Smtp-Source: ABdhPJyawqeHPDos494iyr9y1y/qKYVAQPvGDSU6EzD709bQ6FtUR+iGNMkBdDsssKB4GRWOIx5qxw==
X-Received: by 2002:adf:b301:: with SMTP id j1mr480997wrd.221.1589392307379;
 Wed, 13 May 2020 10:51:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g135sm19365401wme.22.2020.05.13.10.51.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 10:51:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B0DF61FF98;
 Wed, 13 May 2020 18:51:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 09/10] disas: add optional note support to cap_disas
Date: Wed, 13 May 2020 18:51:33 +0100
Message-Id: <20200513175134.19619-10-alex.bennee@linaro.org>
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Include support for outputting a note at the top of a chunk of
disassembly to capstone as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

---
v2
  - always pass note down to cap_dump_insn
---
 disas.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/disas.c b/disas.c
index 7e8692de301..45285d3f63f 100644
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
@@ -281,7 +282,11 @@ static void cap_dump_insn(disassemble_info *info, cs_insn *insn)
     }
 
     /* Print the actual instruction.  */
-    print(info->stream, "  %-8s %s\n", insn->mnemonic, insn->op_str);
+    print(info->stream, "  %-8s %s", insn->mnemonic, insn->op_str);
+    if (note) {
+        print(info->stream, "\t\t%s", note);
+    }
+    print(info->stream, "\n");
 
     /* Dump any remaining part of the insn on subsequent lines.  */
     for (i = split; i < n; i += split) {
@@ -313,7 +318,7 @@ static bool cap_disas_target(disassemble_info *info, uint64_t pc, size_t size)
         size -= tsize;
 
         while (cs_disasm_iter(handle, &cbuf, &csize, &pc, insn)) {
-           cap_dump_insn(info, insn);
+            cap_dump_insn(info, insn, NULL);
         }
 
         /* If the target memory is not consumed, go back for more... */
@@ -342,7 +347,8 @@ static bool cap_disas_target(disassemble_info *info, uint64_t pc, size_t size)
 }
 
 /* Disassemble SIZE bytes at CODE for the host.  */
-static bool cap_disas_host(disassemble_info *info, void *code, size_t size)
+static bool cap_disas_host(disassemble_info *info, void *code, size_t size,
+                           const char *note)
 {
     csh handle;
     const uint8_t *cbuf;
@@ -358,7 +364,8 @@ static bool cap_disas_host(disassemble_info *info, void *code, size_t size)
     pc = (uintptr_t)code;
 
     while (cs_disasm_iter(handle, &cbuf, &size, &pc, insn)) {
-       cap_dump_insn(info, insn);
+        cap_dump_insn(info, insn, note);
+        note = NULL;
     }
     if (size != 0) {
         (*info->fprintf_func)(info->stream,
@@ -402,7 +409,7 @@ static bool cap_disas_monitor(disassemble_info *info, uint64_t pc, int count)
         csize += tsize;
 
         if (cs_disasm_iter(handle, &cbuf, &csize, &pc, insn)) {
-            cap_dump_insn(info, insn);
+            cap_dump_insn(info, insn, NULL);
             if (--count <= 0) {
                 break;
             }
@@ -416,7 +423,7 @@ static bool cap_disas_monitor(disassemble_info *info, uint64_t pc, int count)
 #endif /* !CONFIG_USER_ONLY */
 #else
 # define cap_disas_target(i, p, s)  false
-# define cap_disas_host(i, p, s)  false
+# define cap_disas_host(i, p, s, n)  false
 # define cap_disas_monitor(i, p, c)  false
 # define cap_disas_plugin(i, p, c) false
 #endif /* CONFIG_CAPSTONE */
@@ -664,7 +671,7 @@ void disas(FILE *out, void *code, unsigned long size, const char *note)
     print_insn = print_insn_hppa;
 #endif
 
-    if (s.info.cap_arch >= 0 && cap_disas_host(&s.info, code, size)) {
+    if (s.info.cap_arch >= 0 && cap_disas_host(&s.info, code, size, note)) {
         return;
     }
 
-- 
2.20.1


