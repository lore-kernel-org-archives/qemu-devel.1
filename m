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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29730C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:17:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED11E22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rvh8ifjn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED11E22D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VAr-0004ci-Qr
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URk-0001gH-MK
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URi-0008E3-Jw
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:56 -0400
Received: from mail-yw1-xc36.google.com ([2607:f8b0:4864:20::c36]:44920)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URg-00088w-Kz
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:52 -0400
Received: by mail-yw1-xc36.google.com with SMTP id l79so1226438ywe.11
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7u+giNyM0KxCv4hol+VuiD6f2ETDBJss3uZycjWTu2I=;
 b=Rvh8ifjnHREp9bn7e07pxyoCCP/UfwFqb+FpekhZmWfvisv9YYIb9dpAt64Q6DlVP7
 X1TviOIqAljCRGcRCEVEd1JG+VSiHRJAM0KhPs7KUTw8j13QZijS9g+L/0AUnyg79Fot
 uVgFicxTW7a9Vh9cD5awJvOlUsiOAvQL6mu3MomwisuBfccRCpQ+GRzPZCNj+vwZzWap
 /MLA/w9eEIf5uV3X/aY/eKi7pgMzmq5b/lbBxczK8EEz5FoM61prIqYgxgBvJbrsytK0
 fAKB+OcBmN64W6n9p9SWXfbCpaOHzj0EY02Y2Jr9Fcgv3m44+y8QeVd90anuLs4GVw8e
 fZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7u+giNyM0KxCv4hol+VuiD6f2ETDBJss3uZycjWTu2I=;
 b=g28FiZrfPw8UZ1cOA26Ksq6HHM4L0bRhsfdUe1AZKs3Oz5EuP0TtjhAfSzwNJn2k8L
 8Jd5wM8xHeF4LojR1RXmgODZaeaBDrs9DP/gSqQA1Gfgm3MZ9hmPw8lX8jwJAjnKZgnl
 nNfBhgaUOo9RnnslO4PSZmaguCr5m4hJU4+mZkb5F83l9DYcphUg1ZRBHx4ffkwq0gGj
 L4xzgJvx6EOgSWMwuDJsJmR0851lPnQWlYG9cY2c6g+neEuluXl7jBsOnNKqXujuwMz2
 YOd4i09vBLg13gZbtSXGd76oR6rJJnDQUuDg1qdW0URoqrS5B52xoiFXUOuBNajEOn5P
 pGnw==
X-Gm-Message-State: APjAAAWG+8+xBSZDepmL5IvFHTs5D49WrI9lP6IZRRFPEhax+Mh6JpOl
 JABPmhRcPDM2lf/DivgNXL4x+0Bm
X-Google-Smtp-Source: APXvYqw5slZbbq0VwpoYhcihE1t2SOJziv0/2sHK8pzGkOEhZHYHHZzaPLFsYEW6K81d3DPBTGIu0g==
X-Received: by 2002:a81:33c1:: with SMTP id
 z184mr25181651ywz.422.1566408651460; 
 Wed, 21 Aug 2019 10:30:51 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:51 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:30 -0400
Message-Id: <20190821172951.15333-55-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c36
Subject: [Qemu-devel] [RFC PATCH v4 54/75] target/i386: introduce SSE4.2
 code generators
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

Introduce code generators required by SSE4.2 instructions.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 3ff063b701..f3b047c0df 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -6017,6 +6017,12 @@ DEF_GEN_INSN3_GVEC(pcmpgtw, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_16, TCG_COND
 DEF_GEN_INSN3_GVEC(pcmpgtw, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_16, TCG_COND_GT)
 DEF_GEN_INSN3_GVEC(pcmpgtd, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_32, TCG_COND_GT)
 DEF_GEN_INSN3_GVEC(pcmpgtd, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_32, TCG_COND_GT)
+DEF_GEN_INSN3_GVEC(pcmpgtq, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_64, TCG_COND_GT)
+
+DEF_GEN_INSN3_HELPER_EPPI(pcmpestrm, pcmpestrm_xmm, Vdq, Wdq, Ib)
+DEF_GEN_INSN3_HELPER_EPPI(pcmpestri, pcmpestri_xmm, Vdq, Wdq, Ib)
+DEF_GEN_INSN3_HELPER_EPPI(pcmpistrm, pcmpistrm_xmm, Vdq, Wdq, Ib)
+DEF_GEN_INSN3_HELPER_EPPI(pcmpistri, pcmpistri_xmm, Vdq, Wdq, Ib)
 
 DEF_GEN_INSN2_HELPER_EPP(ptest, ptest_xmm, Vdq, Wdq)
 
-- 
2.20.1


