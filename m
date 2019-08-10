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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71D5C433FF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:18:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 869C5217F5
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqCKaaV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869C5217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwIq7-00011o-QM
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 00:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34801)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIkw-0005of-Fs
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIkv-0004Mu-BQ
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:26 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37155)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hwIkv-0004Mj-7D
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:25 -0400
Received: by mail-ot1-x341.google.com with SMTP id f17so5089193otq.4
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 21:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tSn61jr3E0eccd5dUu+yzc0P1TL3PTMW/+yDPp+cvf8=;
 b=KqCKaaV7/38wjZlNBqNcubY1258iiuc0QHQ81A224k92q5fVIpZcT8EY1ZYy/Eldc9
 rior9IE8vOegdK82p2R70rVglh8GHIHj5wF2hyTxJDZmcQzN+vF7G+mFBV/kAWfdp58I
 llvvCJx8xkCUvmsJscYv7+GvsdotyHoMo7TgeS5tou3OGqXqbGlwmfhv/TDklUxCl8YU
 PmWUgLmp0tCs6PIxryLR1YlB28cn0z7vor78nWkzKiCydXSgpiaIf8nu5taHoav0c9qZ
 opKrC+u1r6vA40GzHMmRMZYeFFkEeQ1BSgmqgrX1lJMl9RGbxLXauigjler+WZKq3sax
 eFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tSn61jr3E0eccd5dUu+yzc0P1TL3PTMW/+yDPp+cvf8=;
 b=MocrB/SZe/kdOZ1tYVgKgVonIzcctQUSP4Y116KFr9JUUI0BVUyrijUuRm01HEDeUV
 61l4JEVE5x3HjTv1QKeuj9QkjG/XGg6AtfG1jnZnlm5nEbnFCqhUY3VrLjcjvks857fo
 qBk6qoFUsTh7cxF+QBy3JGre0yYR/b0IOExQ9EZev3g7jRCx9iGSitE0Rn4AgjfUkYMm
 IDRAiz2lhpUVmAJpWLkGdO+JsPjBvVCYJSDdruPsVrBOJp05Fv8t8MxGD7sIiaTQAzU6
 48YYf1mQ2AVQfpr3pxSPSKG3bsOvr3QMSXyaINEFktYOEXtHvXKbmIlbS4YsoWwdec/g
 4DUw==
X-Gm-Message-State: APjAAAWIwI9ogU9ahUlC2IxTRJlJjP7RnNUBJKPtNDBc84peNLYjsZe7
 6ys6hyQfpF4qVXN/rP2H13x+Z1aD
X-Google-Smtp-Source: APXvYqyi8gxyLPBivNSp6TZja/vQ+rwToIcDNi57U//6BljhGjweO3vY7ise+UyYDucxNNZWSPt5Qw==
X-Received: by 2002:a9d:67cf:: with SMTP id c15mr19033922otn.326.1565410404532; 
 Fri, 09 Aug 2019 21:13:24 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id f84sm33383540oig.43.2019.08.09.21.13.23
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 21:13:24 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 10 Aug 2019 00:12:34 -0400
Message-Id: <20190810041255.6820-19-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190810041255.6820-1-jan.bobek@gmail.com>
References: <20190810041255.6820-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: [Qemu-devel] [RFC PATCH v2 18/39] target/i386: introduce modifier
 for direct-only operand decoding
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

Many operands can only decode successfully if the ModR/M byte has the
direct form (i.e. MOD=3). Capture this common aspect by introducing a
special operand-initialization statement wrapper.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 4a2dae6238..0bee7288e6 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4601,6 +4601,15 @@ static int ck_cpuid(CPUX86State *env, DisasContext *s, int ck_cpuid_feat)
 #define INSNOP_FINALIZE_NOOP    /* no-op */
 #define INSNOP_FINALIZE_INVALID g_assert_not_reached()
 
+#define INSNOP_INIT_DIRECT_ONLY(init_stmt)              \
+    do {                                                \
+        if (decode_modrm_mod(env, s, modrm) == 3) {     \
+            init_stmt;                                  \
+        } else {                                        \
+            INSNOP_INIT_FAIL;                           \
+        }                                               \
+    } while (0)
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


