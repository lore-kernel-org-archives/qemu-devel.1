Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336FDC32751
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:19:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2C6F2085A
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahsESW22"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C6F2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwIqp-0002Rm-4W
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 00:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34768)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIkt-0005eZ-Jb
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIks-0004Lq-Fd
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:23 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42320)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hwIks-0004La-Ao
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:22 -0400
Received: by mail-ot1-x341.google.com with SMTP id l15so140514210otn.9
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 21:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZHK0e9XvID8Cei/Jt59+/qv7qtS8MQ3X4OU+8rhkUPE=;
 b=ahsESW22KAjIWNotNXHxKR0VkHaaRXzx8cLpmbMyXWLQIULdRN2W3hVpU1soGVw7sO
 7OjyfxH7ACbUBzopeND900CMDvTlsE24JzoEi5PBDhhTa6N/Pxt8M8gwntUMG25SA9lL
 8xI8Y5OAbY56kvovR1cZgg8v6ZfnlA56w/VEAuRRVyWKeEubohR+0kxhfaABBuncogz/
 cAG8TtDZwJ/C8hJ5vrWYnqZQO4DfiKtOGw6j26r5+XHe1+wpYrCua2cTbCVt7mSxVUVl
 7l/1VD/1qAyvdf/VHqMBD9aIxrP8/N8XQKo60DLenskp7Q8TKO2gxckuHGyeu0t8A1YC
 jZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZHK0e9XvID8Cei/Jt59+/qv7qtS8MQ3X4OU+8rhkUPE=;
 b=NiULbeEiDaiIDMr1p3mrlmAPLU4cRImpKlHieJD96b5yek3w9W9vAGYnafuStE9Ais
 SJ0G3vSdcjhGCN1ZKlswC8ytJIA67wn03caYQI4Fba8LNgOe8S7BUbT/M9s93zxQJDqk
 06mcwDAU30GyFeLIj81Hjsrfby3GjewRTQjDvF6gkGQ6f8Ziquxa8CbHw9v4ZThrcpR8
 ePULVLhwZgo/1c2KMAWilhDSb5iiNU3dW9L6Gw+ZF/+ext/r4ZSFad0ozsLfOBxmVe9d
 dYlbtkpgRjgZOPWEGsBjug5zqUPMlV4vP2HgkPFoa9w66F284hACh8j9LOGxv69BEJEN
 JAQA==
X-Gm-Message-State: APjAAAUR3oz+TubZ8sVqp8vwMYp604VuKfQzDUwYF2iVxQSHBYJwZcUK
 dn1IAieJeGQs52iZ9x5fRYBGmN8O
X-Google-Smtp-Source: APXvYqz2dsZGnx97vx1eckCs3GgLSgcOiFAq2evuyXwn8di1MQJf3G4X1N6hxIE3+JeB4rLtKxdSgw==
X-Received: by 2002:a9d:17e6:: with SMTP id j93mr21134723otj.275.1565410401658; 
 Fri, 09 Aug 2019 21:13:21 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id f84sm33383540oig.43.2019.08.09.21.13.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 21:13:21 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 10 Aug 2019 00:12:31 -0400
Message-Id: <20190810041255.6820-16-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190810041255.6820-1-jan.bobek@gmail.com>
References: <20190810041255.6820-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: [Qemu-devel] [RFC PATCH v2 15/39] target/i386: introduce function
 ck_cpuid
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

Introduce a helper function to take care of instruction CPUID checks.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 45 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 03b49411e5..508d584584 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4500,6 +4500,51 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b)
 #define tcg_gen_gvec_cmpgt(vece, dofs, aofs, bofs, oprsz, maxsz)        \
     tcg_gen_gvec_cmp(TCG_COND_GT, vece, dofs, aofs, bofs, oprsz, maxsz)
 
+enum {
+    CK_CPUID_MMX = 1,
+    CK_CPUID_3DNOW,
+    CK_CPUID_SSE,
+    CK_CPUID_SSE2,
+    CK_CPUID_SSE3,
+    CK_CPUID_SSSE3,
+    CK_CPUID_SSE4_1,
+    CK_CPUID_SSE4_2,
+    CK_CPUID_SSE4A,
+    CK_CPUID_AVX,
+    CK_CPUID_AVX2,
+};
+
+static int ck_cpuid(CPUX86State *env, DisasContext *s, int ck_cpuid_feat)
+{
+    switch (ck_cpuid_feat) {
+    case CK_CPUID_MMX:
+        return !(s->cpuid_features & CPUID_MMX)
+            || !(s->cpuid_ext2_features & CPUID_EXT2_MMX);
+    case CK_CPUID_3DNOW:
+        return !(s->cpuid_ext2_features & CPUID_EXT2_3DNOW);
+    case CK_CPUID_SSE:
+        return !(s->cpuid_features & CPUID_SSE);
+    case CK_CPUID_SSE2:
+        return !(s->cpuid_features & CPUID_SSE2);
+    case CK_CPUID_SSE3:
+        return !(s->cpuid_ext_features & CPUID_EXT_SSE3);
+    case CK_CPUID_SSSE3:
+        return !(s->cpuid_ext_features & CPUID_EXT_SSSE3);
+    case CK_CPUID_SSE4_1:
+        return !(s->cpuid_ext_features & CPUID_EXT_SSE41);
+    case CK_CPUID_SSE4_2:
+        return !(s->cpuid_ext_features & CPUID_EXT_SSE42);
+    case CK_CPUID_SSE4A:
+        return !(s->cpuid_ext3_features & CPUID_EXT3_SSE4A);
+    case CK_CPUID_AVX:
+        return !(s->cpuid_ext_features & CPUID_EXT_AVX);
+    case CK_CPUID_AVX2:
+        return !(s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_AVX2);
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


