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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06081C433FF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:25:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C25EC217F4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kq8V/2+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25EC217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwIwr-0000dw-UL
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 00:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35007)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIlE-0006ly-Dz
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIlD-0004bl-EB
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:44 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36318)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hwIlD-0004bV-8l
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:43 -0400
Received: by mail-ot1-x344.google.com with SMTP id k18so8369897otr.3
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 21:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7IZOAFbdDxZqCQx0nxTk3ibCkcO074bt+QDT97kh5I8=;
 b=kq8V/2+0BKi26WiCXAEnFSuo3D8x+x0zWi8J5eeYDdzZxz4/BI5gn32GzfFY5Dpugn
 gdUVZTd8ZAf5x/PKT1Qn1jBI7kTzCEGEllLCyCUW+CYmxm8i1mys8925+khTzziJTyuS
 LSG6OX3Z6QZOgjsMduOooJf2reKtuHzjQZGRqOB/OoFw2YCw8/QDTpghGX0zSD9rk+yb
 4u2hw3Wk7symSWr3cPxUhaWGv0Wo4WJngMdMUtVeA8usAymE6A2N142W/ru3FCt2ShwA
 PbsMV1dva/lUS3cc1ElN7FTpO3xiuLuTdNEJjU2NYo3EWDS6egCBgwmadFY7euOD5kGX
 svMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7IZOAFbdDxZqCQx0nxTk3ibCkcO074bt+QDT97kh5I8=;
 b=PKjmpAPfmqGbO44M9QKGlnw2El6wHzbuw4/SlRkzOL3lC17gTwdiQVUxWphntbgX4N
 UXUVnF6EUHTXpt3mEUFNQ6vO2bpF7DdWTGTRVeN4C+/CAXJrlpKLdXTYSXPG75YZRkP2
 TMfihs992ybWtjX3V8nXdyEjdYGZyTsnbZCnci9fnc0RLekUuGMUdAfP2uepuj3jZtbC
 m+z40p3I2qIjxKMo9Jxr7NYN3KZlgTdLaM/OuIuVuxluksuA1K4TfBMHZl2mZtCxJdjL
 l+QkeFqORMqqWOwcxNBhqpB9TfndEBozJ6qbrBzxEdSPhxWspmWzJOmevLyKqaLR5pEo
 RlNA==
X-Gm-Message-State: APjAAAUMe1y8iBh1ueNwfxV0cDWtp3Gr+E2uQbl/aLyIBsv/gTRkDtF6
 pF6mE0Jl9osRWWHCW9qyFV872QrP
X-Google-Smtp-Source: APXvYqwTHF1z7AOF8/2Ysua6m9+QEXoYrS/qtZVwyv8hTfIbKEdtjKamfeGjpCQeJ11wAGxdTinl+Q==
X-Received: by 2002:a05:6830:4b:: with SMTP id
 d11mr7534813otp.106.1565410422554; 
 Fri, 09 Aug 2019 21:13:42 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id f84sm33383540oig.43.2019.08.09.21.13.41
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 21:13:42 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 10 Aug 2019 00:12:52 -0400
Message-Id: <20190810041255.6820-37-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190810041255.6820-1-jan.bobek@gmail.com>
References: <20190810041255.6820-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: [Qemu-devel] [RFC PATCH v2 36/39] target/i386: introduce SSE
 translators
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

Use the translator macros to define translators required by SSE
instructions.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 5802b324f0..12d2ac2eb5 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5110,6 +5110,9 @@ static void translate_insn(
         (*gen_insn_fp)(env, s, arg1);                                   \
     }
 
+TRANSLATE_INSN_R(Mb)
+TRANSLATE_INSN_R(Md)
+
 #define TRANSLATE_INSN_RR(opR1, opR2)                                   \
     static void translate_insn_rr(opR1, opR2)(                          \
         CPUX86State *env, DisasContext *s, int modrm, int ck_cpuid_feat, \
@@ -5131,6 +5134,13 @@ static void translate_insn(
         (*gen_insn_fp)(env, s, arg1, arg2);                             \
     }
 
+TRANSLATE_INSN_RR(Pq, Nq)
+TRANSLATE_INSN_RR(Mq, Pq)
+TRANSLATE_INSN_RR(Vd, Wd)
+TRANSLATE_INSN_RR(Mq, Vq)
+TRANSLATE_INSN_RR(Mq, Vdq)
+TRANSLATE_INSN_RR(Mdq, Vdq)
+
 #define TRANSLATE_INSN_W(opW1)                                          \
     static void translate_insn_w(opW1)(                                 \
         CPUX86State *env, DisasContext *s, int modrm, int ck_cpuid_feat, \
@@ -5178,6 +5188,20 @@ TRANSLATE_INSN_WR(Qq, Pq)
 TRANSLATE_INSN_WR(Gd, Nq)
 TRANSLATE_INSN_WR(Gq, Nq)
 
+TRANSLATE_INSN_WR(Vd, Wd)
+TRANSLATE_INSN_WR(Vdq, Wdq)
+TRANSLATE_INSN_WR(Vq, UdqMq)
+TRANSLATE_INSN_WR(Wd, Vd)
+TRANSLATE_INSN_WR(Wdq, Vdq)
+TRANSLATE_INSN_WR(Gd, Udq)
+TRANSLATE_INSN_WR(Gq, Udq)
+TRANSLATE_INSN_WR(Vdq, Qq)
+TRANSLATE_INSN_WR(Vd, Ed)
+TRANSLATE_INSN_WR(Vd, Eq)
+TRANSLATE_INSN_WR(Pq, Wq)
+TRANSLATE_INSN_WR(Gd, Wd)
+TRANSLATE_INSN_WR(Gq, Wd)
+
 #define TRANSLATE_INSN_WRR(opW1, opR1, opR2)                            \
     static void translate_insn_wrr(opW1, opR1, opR2)(                   \
         CPUX86State *env, DisasContext *s, int modrm, int ck_cpuid_feat, \
@@ -5209,6 +5233,11 @@ TRANSLATE_INSN_WRR(Gd, Nq, Ib)
 TRANSLATE_INSN_WRR(Gq, Nq, Ib)
 TRANSLATE_INSN_WRR(Nq, Nq, Ib)
 
+TRANSLATE_INSN_WRR(Vd, Vd, Wd)
+TRANSLATE_INSN_WRR(Vdq, Vdq, Wdq)
+TRANSLATE_INSN_WRR(Vdq, Vq, UqMq)
+TRANSLATE_INSN_WRR(Vdq, Vdq, UdMd)
+
 #define TRANSLATE_INSN_WRRR(opW1, opR1, opR2, opR3)                     \
     static void translate_insn_wrrr(opW1, opR1, opR2, opR3)(            \
         CPUX86State *env, DisasContext *s, int modrm, int ck_cpuid_feat, \
@@ -5236,6 +5265,10 @@ TRANSLATE_INSN_WRR(Nq, Nq, Ib)
         insnop_finalize(opW1)(env, s, modrm, &ret);                     \
     }
 
+TRANSLATE_INSN_WRRR(Vd, Vd, Wd, Ib)
+TRANSLATE_INSN_WRRR(Vdq, Vdq, Wdq, Ib)
+TRANSLATE_INSN_WRRR(Pq, Pq, RdMw, Ib)
+
 #define INSN_GRP_BEGIN(grpname)                                 \
     static void translate_group(grpname)(                       \
         CPUX86State *env, DisasContext *s, int modrm)           \
-- 
2.20.1


