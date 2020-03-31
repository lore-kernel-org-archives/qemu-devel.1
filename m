Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739CFC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 04:01:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 419A22072D
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 04:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GCuLikD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419A22072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ85b-0007BD-Ef
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 00:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jJ7ze-0004qp-26
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:55:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jJ7zc-0008K6-Sv
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:55:13 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45782)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jJ7zc-0008IO-Ni
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:55:12 -0400
Received: by mail-pf1-x441.google.com with SMTP id r14so7210915pfl.12
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 20:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CDnFqJBoj0Xo8UAeGjSsmq+bEn4LCuvCKa5BZTVovPc=;
 b=GCuLikD0qFP9t1TFXC+XvTBy6C8TSQ2lrXGh/ivBOei7lS97JesH7lo1L+Hrdt2llg
 3yfGZiYfaOuLWF7lgFDPdATePRFQqvI/UoZ7CjPkDeubu3lpy3WO7t/ZLdcYVBRUG/xD
 Q9UM4SvDH8ulF9mgX9vvz/35pNMZn8qHUdxlNzBXKN1DwZML/hq5ZxHhWOMmoMYXfoiZ
 qsEqgbS0A+yvEQKoKGPy33yldE4hiHO++kQIS4QmY5IzwpX2k7Hy1HnZ9E71KcxS4XcV
 UCXWta41iUXU8purJ+ueWm+SU16mq6ngTOttyyGRTYr7JMX1Wi15JO5Ez+IoKR2nJLcj
 Rlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CDnFqJBoj0Xo8UAeGjSsmq+bEn4LCuvCKa5BZTVovPc=;
 b=EXWlCocBHA9TZjnlrQGiSuhWqDsEiKnQRG3FzCOCk9luCt6Wx4N6W4poBelD3XRhu/
 euEzohUEZ5XWGQUimtD7WK3wBTqNbHffUlPKdzwyh1OwRo9/2nJ3/leO9J9ZS/ZJE5Uj
 qzdGaKL8icvLJouDb5NEH9G0YmCMBK7uunzVmlhLNU58dSD8CZqTX7P893etgSrbdiaA
 N0h8jRfMoVJtZEZ8RL7/x05eM9mFZ2H8zztdZQlIZr92xoFNkmicVk+atnG2xgyA5mhC
 vJEG92ShtZ9DW/+G5Vt9wjh2z5dAtd/ROUE46pg3tTvHYPGsZpRdumC7FgwjlBA1HPxw
 RQHA==
X-Gm-Message-State: ANhLgQ1uA+trYNao48I3hlNneAnTDmBDwfvLKJFjj2Uuu5jGGvR9KFH8
 lEKAE/8OO/Na0Pxnf5bfQQLyDWI2xnw=
X-Google-Smtp-Source: ADFU+vs77722v4uTNsg/jHYncoyunKE1CFdntjXhejT7i2Zi2yGIhAAO86YaisZG87tIMRl7DtrM4A==
X-Received: by 2002:a63:dc11:: with SMTP id s17mr15567880pgg.285.1585626911455; 
 Mon, 30 Mar 2020 20:55:11 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id h11sm11386174pfq.56.2020.03.30.20.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 20:55:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.0 09/10] tcg/i386: Fix INDEX_op_dup2_vec
Date: Mon, 30 Mar 2020 20:54:55 -0700
Message-Id: <20200331035456.6494-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200331035456.6494-1-richard.henderson@linaro.org>
References: <20200331035456.6494-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: peter.maydell@linaro.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We were only constructing the 64-bit element, and not
replicating the 64-bit element across the rest of the vector.

Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 223dba9c8c..7f61eeedd0 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -2855,9 +2855,13 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         goto gen_simd;
 #if TCG_TARGET_REG_BITS == 32
     case INDEX_op_dup2_vec:
-        /* Constraints have already placed both 32-bit inputs in xmm regs.  */
-        insn = OPC_PUNPCKLDQ;
-        goto gen_simd;
+        /* First merge the two 32-bit inputs to a single 64-bit element. */
+        tcg_out_vex_modrm(s, OPC_PUNPCKLDQ, a0, a1, a2);
+        /* Then replicate the 64-bit elements across the rest of the vector. */
+        if (type != TCG_TYPE_V64) {
+            tcg_out_dup_vec(s, type, MO_64, a0, a0);
+        }
+        break;
 #endif
     case INDEX_op_abs_vec:
         insn = abs_insn[vece];
-- 
2.20.1


