Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D5AC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CE98216F4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFpLkMNy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE98216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VSq-0000Q5-V7
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URq-0001hk-Cg
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URo-0008Pd-KJ
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:02 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:45840)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URm-0008IX-FP
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:00 -0400
Received: by mail-yw1-xc41.google.com with SMTP id n69so1222696ywd.12
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=370BzNA3AWFdFiLriyDposG4pv4fhHrQn56gCrkrpxY=;
 b=pFpLkMNyI1VYI/vFtpMRMpnmJ5ZTpBekdQOyDFoa7472a2/6uQSuXI2sgwCfsxKtVf
 9VrnjWRWak8SRI/Q1wjrUI5D6DNk3/SM0AdHEicdmEmUeaRg/RwXKCv55ciBS5ZYU3XQ
 9Y9c6KSHWVDRDquKJWWczQXM0X/xXA0lZZAsAb5xmKcYtS8TTfiqZWFE27fd/dcxguvT
 ZzG0yCQ7P3XnFsUEanXZJz9+fipChJkTHzMbg/hgM8DfPgiMiF0li6i9mKISSn0N+iC/
 4HCSkL8hk2vsUu7jFquKrhlug5eTwBHYnRUL5QEepYD7hEHTwfMwP4q8WzWio/WqhAnP
 VLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=370BzNA3AWFdFiLriyDposG4pv4fhHrQn56gCrkrpxY=;
 b=ZnWBKk9D/8sambM3y0yHz1ZUwx3H1qb0O2xw6Pp7Cy3aI1fH0Wqzq0W3D8qq/aI19y
 T4G+CGqPhWUZ1duVbrCYYHdxIKjscp4vPR4a720hO/ejVSzDF5/KHuwm2fXvqE8RaX/K
 S5jq0gGQP7y86ilms3h2MQ3PUeLsadioRO+GKBf9rOU8WHrXPi7V5Xyfezs4fzX5/uAf
 Z6ZkfutXjVW9+Vspbo9FFlb3qMbreeRIStEMEnul9ve6nf/ifEzCWk6kuEcPpT9f8ajQ
 5FTVgZ41Z1RFqKlOjJOxy9pmkFw20qKWavPZn9xKo1ZYgaenY3Ta5OoqSyvGpKnWql/1
 UGtA==
X-Gm-Message-State: APjAAAW6RJkeQi+Veoj49sAYiZ3tXZFBF9SF3JLWLzvXyDE8lZUj08Yl
 2JtfLnyCCTDHS2vB30D3tRGq42/L
X-Google-Smtp-Source: APXvYqwGhdkUhlePZ5QcPXe/Zkq+op0PQ7FQEiIe5FEUDql/LC9njXsjjyCfUiyocl526ruJ6lp0fQ==
X-Received: by 2002:a81:ad4c:: with SMTP id l12mr24371223ywk.300.1566408656192; 
 Wed, 21 Aug 2019 10:30:56 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:55 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:35 -0400
Message-Id: <20190821172951.15333-60-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
Subject: [Qemu-devel] [RFC PATCH v4 59/75] target/i386: introduce AVX
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

Use the translator macros to define translators required by AVX
instructions.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 48 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 14117c2993..9b9f0d4ed1 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -6708,10 +6708,12 @@ DEF_TRANSLATE_INSN2(Eq, Pq)
 DEF_TRANSLATE_INSN2(Eq, Vdq)
 DEF_TRANSLATE_INSN2(Gd, Nq)
 DEF_TRANSLATE_INSN2(Gd, Udq)
+DEF_TRANSLATE_INSN2(Gd, Uqq)
 DEF_TRANSLATE_INSN2(Gd, Wd)
 DEF_TRANSLATE_INSN2(Gd, Wq)
 DEF_TRANSLATE_INSN2(Gq, Nq)
 DEF_TRANSLATE_INSN2(Gq, Udq)
+DEF_TRANSLATE_INSN2(Gq, Uqq)
 DEF_TRANSLATE_INSN2(Gq, Wd)
 DEF_TRANSLATE_INSN2(Gq, Wq)
 DEF_TRANSLATE_INSN2(Md, Gd)
@@ -6720,6 +6722,7 @@ DEF_TRANSLATE_INSN2(Mq, Gq)
 DEF_TRANSLATE_INSN2(Mq, Pq)
 DEF_TRANSLATE_INSN2(Mq, Vdq)
 DEF_TRANSLATE_INSN2(Mq, Vq)
+DEF_TRANSLATE_INSN2(Mqq, Vqq)
 DEF_TRANSLATE_INSN2(Pq, Ed)
 DEF_TRANSLATE_INSN2(Pq, Eq)
 DEF_TRANSLATE_INSN2(Pq, Nq)
@@ -6735,6 +6738,7 @@ DEF_TRANSLATE_INSN2(Vd, Wd)
 DEF_TRANSLATE_INSN2(Vd, Wq)
 DEF_TRANSLATE_INSN2(Vdq, Ed)
 DEF_TRANSLATE_INSN2(Vdq, Eq)
+DEF_TRANSLATE_INSN2(Vdq, Md)
 DEF_TRANSLATE_INSN2(Vdq, Mdq)
 DEF_TRANSLATE_INSN2(Vdq, Nq)
 DEF_TRANSLATE_INSN2(Vdq, Qq)
@@ -6742,14 +6746,22 @@ DEF_TRANSLATE_INSN2(Vdq, Udq)
 DEF_TRANSLATE_INSN2(Vdq, Wd)
 DEF_TRANSLATE_INSN2(Vdq, Wdq)
 DEF_TRANSLATE_INSN2(Vdq, Wq)
+DEF_TRANSLATE_INSN2(Vdq, Wqq)
 DEF_TRANSLATE_INSN2(Vdq, Ww)
 DEF_TRANSLATE_INSN2(Vq, Ed)
 DEF_TRANSLATE_INSN2(Vq, Eq)
 DEF_TRANSLATE_INSN2(Vq, Wd)
 DEF_TRANSLATE_INSN2(Vq, Wq)
+DEF_TRANSLATE_INSN2(Vqq, Md)
+DEF_TRANSLATE_INSN2(Vqq, Mdq)
+DEF_TRANSLATE_INSN2(Vqq, Mq)
+DEF_TRANSLATE_INSN2(Vqq, Mqq)
+DEF_TRANSLATE_INSN2(Vqq, Wdq)
+DEF_TRANSLATE_INSN2(Vqq, Wqq)
 DEF_TRANSLATE_INSN2(Wd, Vd)
 DEF_TRANSLATE_INSN2(Wdq, Vdq)
 DEF_TRANSLATE_INSN2(Wq, Vq)
+DEF_TRANSLATE_INSN2(Wqq, Vqq)
 DEF_TRANSLATE_INSN2(modrm_mod, modrm)
 
 #define DEF_TRANSLATE_INSN3(opT1, opT2, opT3)                           \
@@ -6796,6 +6808,9 @@ DEF_TRANSLATE_INSN3(Gd, Nq, Ib)
 DEF_TRANSLATE_INSN3(Gd, Udq, Ib)
 DEF_TRANSLATE_INSN3(Gq, Nq, Ib)
 DEF_TRANSLATE_INSN3(Gq, Udq, Ib)
+DEF_TRANSLATE_INSN3(Hdq, Udq, Ib)
+DEF_TRANSLATE_INSN3(Mdq, Hdq, Vdq)
+DEF_TRANSLATE_INSN3(Mqq, Hqq, Vqq)
 DEF_TRANSLATE_INSN3(Nq, Nq, Ib)
 DEF_TRANSLATE_INSN3(Pq, Pq, Qd)
 DEF_TRANSLATE_INSN3(Pq, Pq, Qq)
@@ -6803,17 +6818,34 @@ DEF_TRANSLATE_INSN3(Pq, Qq, Ib)
 DEF_TRANSLATE_INSN3(RdMb, Vdq, Ib)
 DEF_TRANSLATE_INSN3(RdMw, Vdq, Ib)
 DEF_TRANSLATE_INSN3(Udq, Udq, Ib)
+DEF_TRANSLATE_INSN3(Vd, Hd, Ed)
+DEF_TRANSLATE_INSN3(Vd, Hd, Eq)
+DEF_TRANSLATE_INSN3(Vd, Hd, Wd)
+DEF_TRANSLATE_INSN3(Vd, Hd, Wq)
 DEF_TRANSLATE_INSN3(Vd, Vd, Wd)
 DEF_TRANSLATE_INSN3(Vd, Wd, Ib)
+DEF_TRANSLATE_INSN3(Vdq, Hdq, Mdq)
+DEF_TRANSLATE_INSN3(Vdq, Hdq, Mq)
+DEF_TRANSLATE_INSN3(Vdq, Hdq, UdqMhq)
 DEF_TRANSLATE_INSN3(Vdq, Hdq, Wdq)
+DEF_TRANSLATE_INSN3(Vdq, Hq, Mq)
+DEF_TRANSLATE_INSN3(Vdq, Hq, Wq)
 DEF_TRANSLATE_INSN3(Vdq, Vdq, Mq)
 DEF_TRANSLATE_INSN3(Vdq, Vdq, UdqMhq)
 DEF_TRANSLATE_INSN3(Vdq, Vdq, Wdq)
 DEF_TRANSLATE_INSN3(Vdq, Vq, Mq)
 DEF_TRANSLATE_INSN3(Vdq, Vq, Wq)
 DEF_TRANSLATE_INSN3(Vdq, Wdq, Ib)
+DEF_TRANSLATE_INSN3(Vq, Hq, Ed)
+DEF_TRANSLATE_INSN3(Vq, Hq, Eq)
+DEF_TRANSLATE_INSN3(Vq, Hq, Wd)
+DEF_TRANSLATE_INSN3(Vq, Hq, Wq)
 DEF_TRANSLATE_INSN3(Vq, Vq, Wq)
 DEF_TRANSLATE_INSN3(Vq, Wq, Ib)
+DEF_TRANSLATE_INSN3(Vqq, Hqq, Mqq)
+DEF_TRANSLATE_INSN3(Vqq, Hqq, Wqq)
+DEF_TRANSLATE_INSN3(Vqq, Wqq, Ib)
+DEF_TRANSLATE_INSN3(Wdq, Vqq, Ib)
 
 #define DEF_TRANSLATE_INSN4(opT1, opT2, opT3, opT4)                     \
     static void translate_insn4(opT1, opT2, opT3, opT4)(                \
@@ -6861,8 +6893,15 @@ DEF_TRANSLATE_INSN3(Vq, Wq, Ib)
 
 DEF_TRANSLATE_INSN4(Pq, Pq, Qq, Ib)
 DEF_TRANSLATE_INSN4(Pq, Pq, RdMw, Ib)
+DEF_TRANSLATE_INSN4(Vd, Hd, Wd, Ib)
 DEF_TRANSLATE_INSN4(Vd, Vd, Wd, Ib)
+DEF_TRANSLATE_INSN4(Vdq, Hdq, Ed, Ib)
+DEF_TRANSLATE_INSN4(Vdq, Hdq, Eq, Ib)
+DEF_TRANSLATE_INSN4(Vdq, Hdq, RdMb, Ib)
+DEF_TRANSLATE_INSN4(Vdq, Hdq, RdMw, Ib)
+DEF_TRANSLATE_INSN4(Vdq, Hdq, Wd, Ib)
 DEF_TRANSLATE_INSN4(Vdq, Hdq, Wdq, Ib)
+DEF_TRANSLATE_INSN4(Vdq, Hdq, Wdq, Ldq)
 DEF_TRANSLATE_INSN4(Vdq, Vdq, Ed, Ib)
 DEF_TRANSLATE_INSN4(Vdq, Vdq, Eq, Ib)
 DEF_TRANSLATE_INSN4(Vdq, Vdq, RdMb, Ib)
@@ -6871,7 +6910,11 @@ DEF_TRANSLATE_INSN4(Vdq, Vdq, Wd, Ib)
 DEF_TRANSLATE_INSN4(Vdq, Vdq, Wd, modrm_mod)
 DEF_TRANSLATE_INSN4(Vdq, Vdq, Wdq, Ib)
 DEF_TRANSLATE_INSN4(Vdq, Vdq, Wq, modrm_mod)
+DEF_TRANSLATE_INSN4(Vq, Hq, Wq, Ib)
 DEF_TRANSLATE_INSN4(Vq, Vq, Wq, Ib)
+DEF_TRANSLATE_INSN4(Vqq, Hqq, Wdq, Ib)
+DEF_TRANSLATE_INSN4(Vqq, Hqq, Wqq, Ib)
+DEF_TRANSLATE_INSN4(Vqq, Hqq, Wqq, Lqq)
 
 #define DEF_TRANSLATE_INSN5(opT1, opT2, opT3, opT4, opT5)               \
     static void translate_insn5(opT1, opT2, opT3, opT4, opT5)(          \
@@ -6924,6 +6967,11 @@ DEF_TRANSLATE_INSN4(Vq, Vq, Wq, Ib)
         }                                                               \
     }
 
+DEF_TRANSLATE_INSN5(Vdq, Hdq, Wd, modrm_mod, vex_v)
+DEF_TRANSLATE_INSN5(Vdq, Hdq, Wq, modrm_mod, vex_v)
+DEF_TRANSLATE_INSN5(Wdq, Hdq, Vd, modrm_mod, vex_v)
+DEF_TRANSLATE_INSN5(Wdq, Hdq, Vq, modrm_mod, vex_v)
+
 #define OPCODE_GRP_BEGIN(grpname)                                       \
     static void translate_group(grpname)(                               \
         CPUX86State *env, DisasContext *s, int modrm)                   \
-- 
2.20.1


