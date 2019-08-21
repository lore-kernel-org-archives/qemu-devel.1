Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C10C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:28:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF39216F4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbG4w56K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF39216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VLS-0005Xa-PZ
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URb-0001aZ-Cd
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URZ-0007z6-W1
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:47 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:38906)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URZ-0007yk-S7
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:45 -0400
Received: by mail-yb1-xb41.google.com with SMTP id j199so1342913ybg.5
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a0oLr3XUNUYycYpp9Snrt/anxTMoMxsixsmZcVdJyo0=;
 b=MbG4w56Kr1WHZUkdmMySnt0G3oJU4x7OZOz4qanJRL//OvHCyCP5deHX19I8XCRVQc
 QA+hmrYJCX3ZO28SQf2b+Ob+eBqMXpVDtARmkuINrZ9LsRZtHWMW0RDYgf/vZFd9m3bi
 OnF0H//vQCa+P9L7xhqPcDSKGi++OVaVOh2sshr6wwtWjlT/LdIH9aZ/3gHArjdNA/iH
 fjYnj386m/RDeRHrH+ljOz/ERRjS/nz4PQNZXkaZxDKxuss0194EaqN3lcoT66PNjvf6
 1GuiE9tWKxuEN+To6SIyl/kq2Npslnfrz8dcFw9cgmiUgGqhm+RYCkd+QmgYG7SllGXx
 nNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a0oLr3XUNUYycYpp9Snrt/anxTMoMxsixsmZcVdJyo0=;
 b=NXpWa7N9I/1EOP+zFT57cCGUCgZdm9PZ6eCWN5104O4sppfGR9iBoxMkWTMiVZ2TPY
 nXoyWbY+Ohm285P/YKP2qE/K6VxtOjpWBa2aX8Vgw8xJWwtSiXv7FYVoy+1HQdPaKBlm
 mdC63SNFarBqN+2MLcBuVGe/n7sTk64Vo3/9WvMe5H+urTiZm7RuDj7Ha/gNh1ID76Mp
 jy2Tjo0EhOKScw7vflBstQFSRYjY2g2IpP9shuDmOVWNUGNsXlTmfmkjr7FB/OGwn+Bi
 yVIp/uFkgv1mJEBg9Cgp7Ff6733OGdv4rYqeu88925GEcHCbA8GxxemIT47ToNhBfzoW
 lJPA==
X-Gm-Message-State: APjAAAW9mda22QfEkw1xta07TS2uXiFw5v1IpVfBjBk+Z24GLAGP6ggs
 hCJj5KI4ZgbpwLQIVLXLLC2T2am9
X-Google-Smtp-Source: APXvYqyAE3jpJRud7euQ+JIYGwIwOGchXosaNnS7Wo1JWtmiS+tnh9Y4Kg+D56WXTlxx9SSMZVF6Bw==
X-Received: by 2002:a25:bd4e:: with SMTP id p14mr24100080ybm.148.1566408645259; 
 Wed, 21 Aug 2019 10:30:45 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:44 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:22 -0400
Message-Id: <20190821172951.15333-47-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
Subject: [Qemu-devel] [RFC PATCH v4 46/75] target/i386: introduce SSE3 code
 generators
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce code generators required by SSE3 instructions.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 61 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index a478f73c17..d449a64464 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5802,6 +5802,60 @@ GEN_INSN2(movmskpd, Gq, Udq)
     tcg_temp_free_i32(arg1_r32);
 }
 
+GEN_INSN2(lddqu, Vdq, Mdq)
+{
+    insnop_ldst(xmm, Mdq)(env, s, 0, arg1, arg2);
+}
+
+GEN_INSN2(movshdup, Vdq, Wdq)
+{
+    const TCGv_i32 r32 = tcg_temp_new_i32();
+
+    tcg_gen_ld_i32(r32, cpu_env, arg2 + offsetof(ZMMReg, ZMM_L(1)));
+    tcg_gen_st_i32(r32, cpu_env, arg1 + offsetof(ZMMReg, ZMM_L(0)));
+    if (arg1 != arg2) {
+        tcg_gen_st_i32(r32, cpu_env, arg1 + offsetof(ZMMReg, ZMM_L(1)));
+    }
+
+    tcg_gen_ld_i32(r32, cpu_env, arg2 + offsetof(ZMMReg, ZMM_L(3)));
+    tcg_gen_st_i32(r32, cpu_env, arg1 + offsetof(ZMMReg, ZMM_L(2)));
+    if (arg1 != arg2) {
+        tcg_gen_st_i32(r32, cpu_env, arg1 + offsetof(ZMMReg, ZMM_L(3)));
+    }
+
+    tcg_temp_free_i32(r32);
+}
+GEN_INSN2(movsldup, Vdq, Wdq)
+{
+    const TCGv_i32 r32 = tcg_temp_new_i32();
+
+    tcg_gen_ld_i32(r32, cpu_env, arg2 + offsetof(ZMMReg, ZMM_L(0)));
+    if (arg1 != arg2) {
+        tcg_gen_st_i32(r32, cpu_env, arg1 + offsetof(ZMMReg, ZMM_L(0)));
+    }
+    tcg_gen_st_i32(r32, cpu_env, arg1 + offsetof(ZMMReg, ZMM_L(1)));
+
+    tcg_gen_ld_i32(r32, cpu_env, arg2 + offsetof(ZMMReg, ZMM_L(2)));
+    if (arg1 != arg2) {
+        tcg_gen_st_i32(r32, cpu_env, arg1 + offsetof(ZMMReg, ZMM_L(2)));
+    }
+    tcg_gen_st_i32(r32, cpu_env, arg1 + offsetof(ZMMReg, ZMM_L(3)));
+
+    tcg_temp_free_i32(r32);
+}
+GEN_INSN2(movddup, Vdq, Wq)
+{
+    const TCGv_i64 r64 = tcg_temp_new_i64();
+
+    tcg_gen_ld_i64(r64, cpu_env, arg2 + offsetof(ZMMReg, ZMM_Q(0)));
+    if (arg1 != arg2) {
+        tcg_gen_st_i64(r64, cpu_env, arg1 + offsetof(ZMMReg, ZMM_Q(0)));
+    }
+    tcg_gen_st_i64(r64, cpu_env, arg1 + offsetof(ZMMReg, ZMM_Q(1)));
+
+    tcg_temp_free_i64(r64);
+}
+
 DEF_GEN_INSN3_GVEC(paddb, Pq, Pq, Qq, add, MM_OPRSZ, MM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(paddb, Vdq, Vdq, Wdq, add, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(paddw, Pq, Pq, Qq, add, MM_OPRSZ, MM_MAXSZ, MO_16)
@@ -5822,6 +5876,8 @@ DEF_GEN_INSN3_HELPER_EPP(addps, addps, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(addpd, addpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(addss, addss, Vd, Vd, Wd)
 DEF_GEN_INSN3_HELPER_EPP(addsd, addsd, Vq, Vq, Wq)
+DEF_GEN_INSN3_HELPER_EPP(haddps, haddps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(haddpd, haddpd, Vdq, Vdq, Wdq)
 
 DEF_GEN_INSN3_GVEC(psubb, Pq, Pq, Qq, sub, MM_OPRSZ, MM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(psubb, Vdq, Vdq, Wdq, sub, XMM_OPRSZ, XMM_MAXSZ, MO_8)
@@ -5843,6 +5899,11 @@ DEF_GEN_INSN3_HELPER_EPP(subps, subps, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(subpd, subpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(subss, subss, Vd, Vd, Wd)
 DEF_GEN_INSN3_HELPER_EPP(subsd, subsd, Vq, Vq, Wq)
+DEF_GEN_INSN3_HELPER_EPP(hsubps, hsubps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(hsubpd, hsubpd, Vdq, Vdq, Wdq)
+
+DEF_GEN_INSN3_HELPER_EPP(addsubps, addsubps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(addsubpd, addsubpd, Vdq, Vdq, Wdq)
 
 DEF_GEN_INSN3_HELPER_EPP(pmullw, pmullw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pmullw, pmullw_xmm, Vdq, Vdq, Wdq)
-- 
2.20.1


