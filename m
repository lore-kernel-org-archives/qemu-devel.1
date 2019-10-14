Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5D8ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:13:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66AEB2084B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ib8GIKxG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66AEB2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyI1-0006Pi-D8
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvT-0007UN-3L
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvR-0006Ea-M3
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:06 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38546)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJxvR-0006DR-E1
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:05 -0400
Received: by mail-wr1-x443.google.com with SMTP id y18so9677410wrn.5
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wkKvV4m59QNrxbn2cShYQVtK2L5V4Z2RfTcq3RzCI+A=;
 b=ib8GIKxGCj/S/SDhI+albNwezZ2VxDgbviecKDonjK3TkO1GR/t65pLI9WNFa3n7aO
 /0N+ZK24IsVFGDYLo3EXrkeTCygZVlW3bLbkIOu2nzCGs+U06mErsezjOIByskWrCyMq
 FgRbU0pWgesd7nxf+kTNuAlKuI8dE8+qG5HXcoWn7ubrrEym0NI5vVT5EMVc+KbJzMn1
 ab+f+uO/cYlP+TH/YWL5OLwhgRF8hPzZvceGLU1+78O5CnNZULH1o+R1BCpmaRbtvuAX
 8WxE8ttrQINMRWjOgeFUY5TFm1Pp0+Jvocgbq5YZ0XySOObe97ntalfAhiN36lEU4A1T
 U/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wkKvV4m59QNrxbn2cShYQVtK2L5V4Z2RfTcq3RzCI+A=;
 b=j0M91AYWHN2vl7GYZa6MWeA1pdQ8QllxTkN8So86VK8fxz3g+ZjZlfCdJoH1TprVAQ
 VNXI1yChHsgeOydE0Z6O8bhNif6cjTVG6VW+aaZoC+EgoJhyREqiKgZmISDW0uJu9n39
 zzEu+4x8cZhMV1ZDFW0Cg2l+F1HahohKFLuSFNLFg+lcW9C0a/m6ueBaN5p1mdBcpGxi
 XqRRiPJc9X8vPLv9htb4pznmqdxRfTA156PNYlcdaCkC4qf1s23mwYscURrrKJsU5/hQ
 DjBd+meWv/uje2Sa3UxaqcskzDM5stnxtqXuHKL57nLghWNKx7YqC2UKhrrdXBmJ5kLU
 pMLQ==
X-Gm-Message-State: APjAAAWTmgAf0GoIZwl9Lzrsj8I0nMI9TMEsxTtiJIyB/6h+Cyae5993
 zkgSBH1ZZAWS0LEi6V8cFFqGcQ==
X-Google-Smtp-Source: APXvYqwIEn/JXkY8vnoSMTzOTt5/DN6WbchrHU5v+yXYfCqmbdJeJZ6hbFnzD/s0E9/DTS+ZiILl/A==
X-Received: by 2002:adf:f547:: with SMTP id j7mr26755221wrp.26.1571050204391; 
 Mon, 14 Oct 2019 03:50:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f9sm21372680wre.74.2019.10.14.03.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:50:00 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1A73E1FFAE;
 Mon, 14 Oct 2019 11:49:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 25/55] target/ppc: fetch code with translator_ld
Date: Mon, 14 Oct 2019 11:49:18 +0100
Message-Id: <20191014104948.4291-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/ppc/translate.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index adb8fd516f..f5fe5d0611 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7853,11 +7853,9 @@ static void ppc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     LOG_DISAS("nip=" TARGET_FMT_lx " super=%d ir=%d\n",
               ctx->base.pc_next, ctx->mem_idx, (int)msr_ir);
 
-    if (unlikely(need_byteswap(ctx))) {
-        ctx->opcode = bswap32(cpu_ldl_code(env, ctx->base.pc_next));
-    } else {
-        ctx->opcode = cpu_ldl_code(env, ctx->base.pc_next);
-    }
+    ctx->opcode = translator_ldl_swap(env, ctx->base.pc_next,
+                                      need_byteswap(ctx));
+
     LOG_DISAS("translate opcode %08x (%02x %02x %02x %02x) (%s)\n",
               ctx->opcode, opc1(ctx->opcode), opc2(ctx->opcode),
               opc3(ctx->opcode), opc4(ctx->opcode),
-- 
2.20.1


