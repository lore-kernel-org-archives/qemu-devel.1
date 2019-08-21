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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1353EC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:31:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D12D6216F4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyuNXgJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12D6216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VO6-0001fD-D6
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URc-0001cu-On
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URb-00083C-KJ
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:48 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:44231)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URb-00082o-GX
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:47 -0400
Received: by mail-yb1-xb44.google.com with SMTP id y21so1329763ybi.11
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gosbLDgNdgsc0Fx9UmfEmWrg5QYj+ch3TSiaoisHlvk=;
 b=RyuNXgJx6gKNWlDqrXrIIICrHFlnOJ3FtCZCKUhgQWb0WHlD0dUuXKc+jubI78aCuT
 Kklz9uM9y2yd2VBgkyc5aioY9p0CZ62Qee/tA9qMEC4C8vxU2wFSuJVmmswBdjtLeJA7
 CoB2AacqINJVOEq3xihc1fsJQ9YIe1ycEzrlT/X+rpDtQ9v/3I7YyJOQJIra43g4jlCe
 8UxuTNlCXkBBBnzXfJOVJ+vtJxQaKkak0omFh9E2XgRnyI95qJl7IWDWLg/de1IlpeDN
 2Tge+ww78NGDnqjgwrTzuZU+JG8o4h8zBuHQlJz5psjao1Db2a+MOlOELZ54cgbL0Ggf
 OUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gosbLDgNdgsc0Fx9UmfEmWrg5QYj+ch3TSiaoisHlvk=;
 b=GkcY6iFNP5pLHFFn0Yk/770qEniYqWMJ9xEog/jDKADtrn5pgz3OdUQA+CG8Hm9ith
 5uwYF9KPpynYOLUufE9R9Qplb2pxVaiNaENIg8Rsy9kVrETQWhibfOuhx+HG1tw/ghQU
 9qfmeTDnuKarANUxWoolcvuC8eDYt5esdPni4onwSGebJpnzsoHfW7ikGzlXXFoMuo5w
 K/qDgknl9xIcccWrh0EfJzXma3o5ZO9deX55WBcAba0QQgyR0gp832JbD/xlFsvEh78P
 rp/X/LN/76V+uT9/BKWHdHEhBe0S6U69cDwYUrVqDIltGcNjqmhLpAebszCIhs0OTPz5
 ZEfA==
X-Gm-Message-State: APjAAAV3VHs7bjuknTY0cSoBVbPyts8EDvB1pEH3aKfODSr/oEsey5Wb
 VXDmhTh0AA30ypQ3leGGhHUmgVO+
X-Google-Smtp-Source: APXvYqy98RMveNdh48LGIf0dAstGEJu7RtLeHOXxnnGFsWlLZChdWfKLBZ4c12BbTpxzH6Sa15lsdw==
X-Received: by 2002:a25:cb81:: with SMTP id
 b123mr22789393ybg.233.1566408646900; 
 Wed, 21 Aug 2019 10:30:46 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:46 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:24 -0400
Message-Id: <20190821172951.15333-49-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: [Qemu-devel] [RFC PATCH v4 48/75] target/i386: introduce SSSE3
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

Use the translator macros to define translators required by SSSE3
instructions.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index d449a64464..25d3b969b1 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -6695,6 +6695,7 @@ DEF_TRANSLATE_INSN3(Vq, Vq, Wq)
         }                                                               \
     }
 
+DEF_TRANSLATE_INSN4(Pq, Pq, Qq, Ib)
 DEF_TRANSLATE_INSN4(Pq, Pq, RdMw, Ib)
 DEF_TRANSLATE_INSN4(Vd, Vd, Wd, Ib)
 DEF_TRANSLATE_INSN4(Vdq, Vdq, RdMw, Ib)
-- 
2.20.1


