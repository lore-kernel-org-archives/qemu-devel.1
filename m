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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8816C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3E5E21655
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjar5h6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E5E21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VGw-0006zJ-B3
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URi-0001f6-MD
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URg-00089Q-MR
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:54 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:39004)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URe-00085R-MV
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:52 -0400
Received: by mail-yw1-xc41.google.com with SMTP id x74so1237736ywx.6
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uOPaFPjPDvChBnik70h2TWTBMB5d+sd6THHXJhiI/U4=;
 b=cjar5h6v8W2TJNu49XScOdgEKNZ0XIKwHU7gpACm51uJDWHQVA3/5Ds/VUyGNnqk20
 kufrViJrrQXsAVubroK0cbcGize9hn1QQAl3pEoKUpEXRp0BI0CbGdvI30ltmHumIcow
 thZ3meLVGDbQu0AfSVwIiVzw3YphuYqHoMvjaIWpfEtZKNVBrPI/Wlb57/8lSTTp9qVs
 KOrnAjh6Lw0e/6lQDia2UHet3dt6fgaPMA5sTHfG96q3WsrB4mpRAOBzfO0MFcZn0EZn
 WNThQR3UbJK9wnAmBehOerQGgyfxmEmdnexoxLX9JPWz1G/XiXbYsvfH59PrrfR/vM3k
 m/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uOPaFPjPDvChBnik70h2TWTBMB5d+sd6THHXJhiI/U4=;
 b=sroI6GznGOLsPyBMyZDZU3nLTg6ygMsNZTGH4D6fPHomLMDydRTUyXltx627wZQhXK
 3OhbaTkzHPCxPQAedS+3XqE8hv5EexZpBMS8BDSk/cZ4SZNezq6X/YVIz7oXgdqAoKM9
 VtbZNgG6mRThB/6vlCIHxHjMXt82sPutqPZobsi1g+6RQxS0YB1DqTOOVt14uc2Ezl+d
 5tpDJOq/5lvV7THk05AJ6o4IYkAYxaEL5m7yuY0gF2xJH4iLG+VRwHQ2pSeHRUwrJTMr
 Z7lpzBGRpTtrkQu8GRt+KWhqigcNZyyF9NjN5blniG6T5Uk7kI+Z3RNQzBM1c1uk/FLp
 Bieg==
X-Gm-Message-State: APjAAAWxwKPhzv1Dxjwj6wU4czWF9XLN2SVtvSdTEoRo9d/ROD2QlDbc
 h0JmIYNKOEruxCsR3Ptc41NYUw+t
X-Google-Smtp-Source: APXvYqzKH6aJXucIywZAY3hcMXNTph6JUTPBHZIIqaOrtuAB6sSCjeonHms5MiiIHcJinrcxCbQ1Ig==
X-Received: by 2002:a81:2d83:: with SMTP id
 t125mr25778407ywt.421.1566408647734; 
 Wed, 21 Aug 2019 10:30:47 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:47 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:25 -0400
Message-Id: <20190821172951.15333-50-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
Subject: [Qemu-devel] [RFC PATCH v4 49/75] target/i386: introduce SSSE3 code
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

Introduce code generators required by SSSE3 instructions.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 25d3b969b1..f43e9b1ba4 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5876,6 +5876,12 @@ DEF_GEN_INSN3_HELPER_EPP(addps, addps, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(addpd, addpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(addss, addss, Vd, Vd, Wd)
 DEF_GEN_INSN3_HELPER_EPP(addsd, addsd, Vq, Vq, Wq)
+DEF_GEN_INSN3_HELPER_EPP(phaddw, phaddw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(phaddw, phaddw_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(phaddd, phaddd_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(phaddd, phaddd_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(phaddsw, phaddsw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(phaddsw, phaddsw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(haddps, haddps, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(haddpd, haddpd, Vdq, Vdq, Wdq)
 
@@ -5899,6 +5905,12 @@ DEF_GEN_INSN3_HELPER_EPP(subps, subps, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(subpd, subpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(subss, subss, Vd, Vd, Wd)
 DEF_GEN_INSN3_HELPER_EPP(subsd, subsd, Vq, Vq, Wq)
+DEF_GEN_INSN3_HELPER_EPP(phsubw, phsubw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(phsubw, phsubw_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(phsubd, phsubd_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(phsubd, phsubd_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(phsubsw, phsubsw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(phsubsw, phsubsw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(hsubps, hsubps, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(hsubpd, hsubpd, Vdq, Vdq, Wdq)
 
@@ -5913,12 +5925,16 @@ DEF_GEN_INSN3_HELPER_EPP(pmulhuw, pmulhuw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pmulhuw, pmulhuw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(pmuludq, pmuludq_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pmuludq, pmuludq_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(pmulhrsw, pmulhrsw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(pmulhrsw, pmulhrsw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(mulps, mulps, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(mulpd, mulpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(mulss, mulss, Vd, Vd, Wd)
 DEF_GEN_INSN3_HELPER_EPP(mulsd, mulsd, Vq, Vq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(pmaddwd, pmaddwd_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pmaddwd, pmaddwd_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(pmaddubsw, pmaddubsw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(pmaddubsw, pmaddubsw_xmm, Vdq, Vdq, Wdq)
 
 DEF_GEN_INSN3_HELPER_EPP(divps, divps, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(divpd, divpd, Vdq, Vdq, Wdq)
@@ -5956,6 +5972,18 @@ DEF_GEN_INSN3_HELPER_EPP(pavgw, pavgw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pavgw, pavgw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psadbw, psadbw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(psadbw, psadbw_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(pabsb, pabsb_mmx, Pq, Qq)
+DEF_GEN_INSN2_HELPER_EPP(pabsb, pabsb_xmm, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(pabsw, pabsw_mmx, Pq, Qq)
+DEF_GEN_INSN2_HELPER_EPP(pabsw, pabsw_xmm, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(pabsd, pabsd_mmx, Pq, Qq)
+DEF_GEN_INSN2_HELPER_EPP(pabsd, pabsd_xmm, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(psignb, psignb_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(psignb, psignb_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(psignw, psignw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(psignw, psignw_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(psignd, psignd_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(psignd, psignd_xmm, Vdq, Vdq, Wdq)
 
 DEF_GEN_INSN3_GVEC(pcmpeqb, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_8, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(pcmpeqb, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_8, TCG_COND_EQ)
@@ -6216,6 +6244,9 @@ DEF_GEN_PSHIFT_IMM_XMM(psraw, Udq, Udq)
 DEF_GEN_PSHIFT_IMM_MM(psrad, Nq, Nq)
 DEF_GEN_PSHIFT_IMM_XMM(psrad, Udq, Udq)
 
+DEF_GEN_INSN4_HELPER_EPPI(palignr, palignr_mmx, Pq, Pq, Qq, Ib)
+DEF_GEN_INSN4_HELPER_EPPI(palignr, palignr_xmm, Vdq, Vdq, Wdq, Ib)
+
 DEF_GEN_INSN3_HELPER_EPP(packsswb, packsswb_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(packsswb, packsswb_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(packssdw, packssdw_mmx, Pq, Pq, Qq)
@@ -6242,6 +6273,8 @@ DEF_GEN_INSN3_HELPER_EPP(unpcklpd, punpcklqdq_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(unpckhps, punpckhdq_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(unpckhpd, punpckhqdq_xmm, Vdq, Vdq, Wdq)
 
+DEF_GEN_INSN3_HELPER_EPP(pshufb, pshufb_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(pshufb, pshufb_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_PPI(pshufw, pshufw_mmx, Pq, Qq, Ib)
 DEF_GEN_INSN3_HELPER_PPI(pshuflw, pshuflw_xmm, Vdq, Wdq, Ib)
 DEF_GEN_INSN3_HELPER_PPI(pshufhw, pshufhw_xmm, Vdq, Wdq, Ib)
-- 
2.20.1


