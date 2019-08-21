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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A026AC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:27:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 679E3216F4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ac4hClXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679E3216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VK1-0003bS-04
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URq-0001hi-Cc
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URo-0008Oh-CK
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:02 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:38482)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URl-0008EH-KG
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:58 -0400
Received: by mail-yw1-xc42.google.com with SMTP id f187so1239207ywa.5
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UcQMIQ6Snz8KBsqYuuztiUpYqscBWVjLt4Fbmt6g/lo=;
 b=Ac4hClXp6WhNxIjcYTcbA/dPGADWZ8P5i7EzKtpLKnllESUBzQWN8DRogs9YN9L+cL
 B6ctRrihusn4F2rQtu6AP5FEWSdtiADFbo1CrjgiXAVevhxpSCarV4Kd8WCWNVuI1XEx
 d25a9F1jDkDvIU3XWiHGliy07sglpiiR8ivAGNFTGqxCSnAsw3d0iYwmahPnUaJUxnZW
 yzqVYi0HkQZgSIQXZxUweALBkhw79mh+rF40suJ8HFgAbRqge30NFfDUKjKex3jFXSIG
 tJFdc4/VIzr8qxsNqrYb7MUYyuApi1grb5uNfGL8Az/Mgtoq/ls9ksdVuzGZ+fyoMwEh
 HHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UcQMIQ6Snz8KBsqYuuztiUpYqscBWVjLt4Fbmt6g/lo=;
 b=o83/dZ21SL/ogAjFcBZN7rbhUAyOIyu786nNa0elUA3uVSHzmF6hkWOfslATBDGHX3
 EAkSlUGCx2TM1kppF2fM/Ybt2BhBeNq2JwmBXqxpvSujtYIRKnc7mpy/I0cVY3fZR5Mq
 7PfiaLteOv8mIb/ZYTICbF9/T8jCozKTsMwmAIfpqAFDztOwIM7IQ3fzXAp6pv7tPQR3
 Q3drsQBtNaO1LKaaj6rSSktPelttJRpTG3ETp5iAmxidId7FBpQYA2/bDC/KP58uDj2R
 rooyHE1X7XZuovZviuKWB6M4E6vip1yGsaPbMtynNze2X0z+N3VYLxGMhJAgrA6nNLv/
 Z77Q==
X-Gm-Message-State: APjAAAXjTMgGhUYN4dtlxB5s/B4RdiCTpt9QoJ1CPRlQJ5RAdfEDfNqY
 nRVKEOkHFV7sTYib7tyINLkiJrB/
X-Google-Smtp-Source: APXvYqwCFAP9m49rpGzKbcGNpttfSnxyJ73CBzymajkvCAaRl36/g9QxxS27pP6Fn/k2D+5LV0YUJQ==
X-Received: by 2002:a0d:ec14:: with SMTP id v20mr26146295ywe.24.1566408654192; 
 Wed, 21 Aug 2019 10:30:54 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:53 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:33 -0400
Message-Id: <20190821172951.15333-58-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
Subject: [Qemu-devel] [RFC PATCH v4 57/75] target/i386: introduce AES and
 PCLMULQDQ code generators
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

Introduce code generators required by AES and PCLMULQDQ instructions.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 75b0a818f2..14117c2993 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -6004,6 +6004,21 @@ DEF_GEN_INSN3_HELPER_EPPI(roundpd, roundpd_xmm, Vdq, Wdq, Ib)
 DEF_GEN_INSN3_HELPER_EPPI(roundss, roundss_xmm, Vd, Wd, Ib)
 DEF_GEN_INSN3_HELPER_EPPI(roundsd, roundsd_xmm, Vq, Wq, Ib)
 
+DEF_GEN_INSN3_HELPER_EPP(aesdec, aesdec_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vaesdec, aesdec_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(aesdeclast, aesdeclast_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vaesdeclast, aesdeclast_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(aesenc, aesenc_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vaesenc, aesenc_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(aesenclast, aesenclast_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vaesenclast, aesenclast_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(aesimc, aesimc_xmm, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vaesimc, aesimc_xmm, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPPI(aeskeygenassist, aeskeygenassist_xmm, Vdq, Wdq, Ib)
+DEF_GEN_INSN3_HELPER_EPPI(vaeskeygenassist, aeskeygenassist_xmm, Vdq, Wdq, Ib)
+DEF_GEN_INSN4_HELPER_EPPI(pclmulqdq, pclmulqdq_xmm, Vdq, Vdq, Wdq, Ib)
+DEF_GEN_INSN4_HELPER_EPPI(vpclmulqdq, pclmulqdq_xmm, Vdq, Hdq, Wdq, Ib)
+
 DEF_GEN_INSN3_GVEC(pcmpeqb, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_8, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(pcmpeqb, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_8, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(pcmpeqw, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_16, TCG_COND_EQ)
-- 
2.20.1


