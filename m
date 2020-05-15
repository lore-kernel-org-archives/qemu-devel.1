Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133CBC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:50:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D563B20787
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w685uZIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D563B20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZbfS-000332-2Y
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 10:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZbZU-0002Qk-9P
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:44:22 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:46002)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZbZT-0000zD-0p
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:44:20 -0400
Received: by mail-wr1-x434.google.com with SMTP id v12so3800570wrp.12
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 07:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nJshK4Gmxn9NtKVYQkApWjq7ip9+eMHY3X093/AxgHA=;
 b=w685uZIuhvpWnqw5ymPY9UXQaJCskyBrSZhLrhHbDYBNOAo/gt9I6kxVROzPe7co8I
 Zq9ES3UJAyu3phgtUqQwwXkdDUp1dXCGiFPf6DbN2tAtGsbLr//J0iPJVe/fDZ1Wl6xK
 9EcHJ6LOwwHmL+mgI7i9Kp5GMYqW/08yn7FKKyeUqPkfpMQIYqoGRbv6xi+4ScGDOOcF
 fbH2GA43WVelP/rS0XpvVgso4jjqO6VUBCPA/QoUcXeOHXnsvOM8cXrs2kpB3cvfURNU
 gZHIF5jbBCZOeiQWiQYlHDo4Chu5PVWikXAICZ1e4uvxgNEUrIlgi6OzV322tfroSt7B
 5jVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nJshK4Gmxn9NtKVYQkApWjq7ip9+eMHY3X093/AxgHA=;
 b=VIRuHmhZDgKAgLK1dIThKhI8ceOYX7pUn2xJP0sXFSQJYRx5NGEKk2fxCVwXB7svPS
 uQv5NWvRj6bbt4w+byILmXoMXZsmTgNVRkJU7d85aTUH2cVFLL5SNLAnvOiXzlMGUREI
 /4ZiWFoKJOKDcSAZQ+LE5Fejyv7LJpptsyWgT4BrjH+PDdOOg+W2Iyy4E7R9iKe43Cex
 qP6099vYAwcuH+0pGfZPOCQsmjQIO0helSSy1IcmN+2omiB72GPaw/4Ozb88USOstP/0
 rLZB7QI3IjcH/feU9/ORyTGh9vspWDJY6u8AggSvXotVu3cRON0HB3gDdcRfjU8xdnV+
 y2pA==
X-Gm-Message-State: AOAM530qciOB1C7K3N3oqE5q0pu1RZ1OrV8HgOgbOTh7nfk1aTAZ4JgU
 cnWA4ay5jKOoB1gI+onX0c8hClJ7wU8=
X-Google-Smtp-Source: ABdhPJxUWqe+IwaPKJnMLWJyLO9dhlRmWo+es3/SrO6AFoz7RGfzIiKaHEHUOtFmEj5Lo5b8OMupAQ==
X-Received: by 2002:adf:d089:: with SMTP id y9mr4592371wrh.26.1589553857656;
 Fri, 15 May 2020 07:44:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x17sm3872693wrp.71.2020.05.15.07.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 07:44:12 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E696F1FF96;
 Fri, 15 May 2020 15:44:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 08/13] disas: add optional note support to cap_disas
Date: Fri, 15 May 2020 15:44:00 +0100
Message-Id: <20200515144405.20580-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515144405.20580-1-alex.bennee@linaro.org>
References: <20200515144405.20580-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Include support for outputting a note at the top of a chunk of
disassembly to capstone as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Message-Id: <20200513175134.19619-10-alex.bennee@linaro.org>

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


