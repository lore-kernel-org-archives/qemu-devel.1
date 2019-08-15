Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18037C433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:49:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D508D208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTnVhDO2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D508D208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5pT-0004DW-RD
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Dj-0006Rg-24
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Dh-0000M4-TN
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:30 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:42194)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5Dh-0000Ld-P8
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:29 -0400
Received: by mail-yw1-xc41.google.com with SMTP id z63so290718ywz.9
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9ByOCS1+RWax/taJl2xODCxhRZxqK7h/xkPuJIbOPZk=;
 b=RTnVhDO2ah82TU9DTI8Doui9a9G1JMdd5hyvootyi+Rp64YKhc2dkafiXmaRoGqdsO
 SY7D3PuOhvpOwMdTnMjaPHoFSOpVbaOf9LX8NellnoTcUIza+fcL2IMRTvaALy3ZaXRO
 5DUL8ULUt2Whx4EW7SDTaN7Lq+r2b68OKej4u9XY50Gf6IPDw9jHEfonkF4rJsMNb7nu
 THg2a8L8/QPFDDdoYTY39CWGUmqRE5BlAhhA2wCBnkkBQOvdR8nCIwWxjABBbKcW2uWT
 rHFVbX/TrB1SupcdTHdqJQzcthe3LrmE7vasN/DVjRUp/UxsVCfce6L6PbSt0xLfgR+5
 rsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9ByOCS1+RWax/taJl2xODCxhRZxqK7h/xkPuJIbOPZk=;
 b=FNcEa1E62ihnryesnrSpAgWBCimCnSY1KXi1W7K8JD/oEuXv233drJL5Ga0NZ8pKy0
 boKB9oJBK26SBimK2nHI1xqrMIdTF6R44ilxtwtbU5DiHwDxSnAYxTEmzy/GAMiooR4J
 1XXXM1rlCdErKV2GeUplD9Ml5yTKJVvn5G37beLg1b/XTTASOMtrniRPP8ZqPTSAKNiC
 5YU+kBSxlcl7B5FPeCp77FWGgI+QizFt/JI/kjgOkp5BYKhVlsFX/28wIa4PTdlDY44S
 G/r3lXJ+gVdjS2BS59Umj4oGsWY2AytoVB6plQR0XKCHaVgJRkYugN2CYtIbE0kGBQvC
 Z8/A==
X-Gm-Message-State: APjAAAUTTKAKNRpUf4ey8NdacTtYkC7HUvn43kapErNqUrfj4jGF8DMt
 RElriDhNvrSnQDxJ/6mqfJXmfLJF
X-Google-Smtp-Source: APXvYqy1Vl+zcz8cGA/1w4W/nlwUYRIj2IaWPsaZQwu0h3oTn/4fY59RK0xIJslW+1QfWaR6ShUAGA==
X-Received: by 2002:a0d:ddcb:: with SMTP id g194mr1577316ywe.110.1565835029174; 
 Wed, 14 Aug 2019 19:10:29 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:28 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:09:20 -0400
Message-Id: <20190815020928.9679-39-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
Subject: [Qemu-devel] [RFC PATCH v3 38/46] target/i386: introduce SSE
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
 target/i386/translate.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index a02e9cd0d2..ef64fe606f 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5533,6 +5533,9 @@ static void translate_insn0()(
         }                                                               \
     }
 
+DEF_TRANSLATE_INSN1(Mb)
+DEF_TRANSLATE_INSN1(Md)
+
 #define DEF_TRANSLATE_INSN2(opT1, opT2)                                 \
     static void translate_insn2(opT1, opT2)(                            \
         CPUX86State *env, DisasContext *s, int modrm,                   \
@@ -5571,11 +5574,29 @@ static void translate_insn0()(
 DEF_TRANSLATE_INSN2(Ed, Pq)
 DEF_TRANSLATE_INSN2(Eq, Pq)
 DEF_TRANSLATE_INSN2(Gd, Nq)
+DEF_TRANSLATE_INSN2(Gd, Udq)
+DEF_TRANSLATE_INSN2(Gd, Wd)
 DEF_TRANSLATE_INSN2(Gq, Nq)
+DEF_TRANSLATE_INSN2(Gq, Udq)
+DEF_TRANSLATE_INSN2(Gq, Wd)
+DEF_TRANSLATE_INSN2(Mdq, Vdq)
+DEF_TRANSLATE_INSN2(Mq, Pq)
+DEF_TRANSLATE_INSN2(Mq, Vdq)
+DEF_TRANSLATE_INSN2(Mq, Vq)
 DEF_TRANSLATE_INSN2(Pq, Ed)
 DEF_TRANSLATE_INSN2(Pq, Eq)
+DEF_TRANSLATE_INSN2(Pq, Nq)
 DEF_TRANSLATE_INSN2(Pq, Qq)
+DEF_TRANSLATE_INSN2(Pq, Wq)
 DEF_TRANSLATE_INSN2(Qq, Pq)
+DEF_TRANSLATE_INSN2(Vd, Ed)
+DEF_TRANSLATE_INSN2(Vd, Eq)
+DEF_TRANSLATE_INSN2(Vd, Wd)
+DEF_TRANSLATE_INSN2(Vdq, Qq)
+DEF_TRANSLATE_INSN2(Vdq, Wdq)
+DEF_TRANSLATE_INSN2(Vq, UdqMhq)
+DEF_TRANSLATE_INSN2(Wd, Vd)
+DEF_TRANSLATE_INSN2(Wdq, Vdq)
 
 #define DEF_TRANSLATE_INSN3(opT1, opT2, opT3)                           \
     static void translate_insn3(opT1, opT2, opT3)(                      \
@@ -5627,6 +5648,9 @@ DEF_TRANSLATE_INSN3(Nq, Nq, Ib)
 DEF_TRANSLATE_INSN3(Pq, Pq, Qd)
 DEF_TRANSLATE_INSN3(Pq, Pq, Qq)
 DEF_TRANSLATE_INSN3(Pq, Qq, Ib)
+DEF_TRANSLATE_INSN3(Vd, Vd, Wd)
+DEF_TRANSLATE_INSN3(Vdq, Vdq, Wdq)
+DEF_TRANSLATE_INSN3(Vdq, Vq, Wq)
 
 #define DEF_TRANSLATE_INSN4(opT1, opT2, opT3, opT4)                     \
     static void translate_insn4(opT1, opT2, opT3, opT4)(                \
@@ -5680,6 +5704,11 @@ DEF_TRANSLATE_INSN3(Pq, Qq, Ib)
         }                                                               \
     }
 
+DEF_TRANSLATE_INSN4(Pq, Pq, RdMw, Ib)
+DEF_TRANSLATE_INSN4(Vd, Vd, Wd, Ib)
+DEF_TRANSLATE_INSN4(Vdq, Vdq, Wd, modrm_mod)
+DEF_TRANSLATE_INSN4(Vdq, Vdq, Wdq, Ib)
+
 #define OPCODE_GRP_BEGIN(grpname)                                       \
     static void translate_group(grpname)(                               \
         CPUX86State *env, DisasContext *s, int modrm)                   \
-- 
2.20.1


