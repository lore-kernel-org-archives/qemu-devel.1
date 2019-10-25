Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B1ECA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:41:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D4BF20663
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O5G0nWpj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D4BF20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNuEO-00049p-VQ
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtWc-0003Un-GS
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtWb-0007mM-CT
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:42 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:41132)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtWb-0007lr-6c
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:41 -0400
Received: by mail-wr1-x42e.google.com with SMTP id p4so953268wrm.8
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zsxj+Te98ElygZXLVw1dEmLIe6iHMU9Zd9rL8Doapxo=;
 b=O5G0nWpjZR6s8YZg/7unvZdkCQNFgRBttQc8gGuTZyDWSFEzPI5D2ls0A1zNJLFUUb
 bQpEcnsmyCiUs0E+NHd90vvW/ZvpMncSxX+yfRvpv31WuZw6wCee5zXjQ8taPh62Ufe2
 z2aFu8Vp7j007jy4TA1dRj3DgFr7HcKYUDG85zZriK0LUuhYdyYiSdc2cENH4MiJ0UcZ
 geJS6ZPFi79+ZYB23jkE3/RPZ0HG9Z4g8JYP/SlwPiWKRDToddZeAu5pa208KdAtr+k1
 vYXZNj6Uu4NoyE+GKv2ICTWgnkMPCvazeeE/mYY2aiTRQKqfqxDXd7CmE6Xss2VEGgwU
 Aeow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zsxj+Te98ElygZXLVw1dEmLIe6iHMU9Zd9rL8Doapxo=;
 b=PP1lvrrWUyG/c1qa5PqRgpFWPX+Tyujp98/uVv3XL4xgaVd6qDiqM0sJnapdh8rA1C
 cs06dobIwo5r9P0WiDqyccVNzro50A2lH/uSoOrakG3YmoLlbGl5SSHwGNXsA/Q7Jk2y
 UYyfcFZ/Gb8eiCNvimgTVojiP1PrJkUKpYtTPGmeK9+ki33/NgAgn9TyFI6u1zP6xfq3
 lo1vQkQX4Mwl6P1TnOcj1QDdzGXoSbb7ha+6oRyH35A77uHDhzyU6cFj8tXbyXDluQjR
 AOeriag8HzuHbsQvc3CRcdNGlhpghgS4Bwt/igVq1GqyRBzUXkncpZz8YbhmBmZRBajt
 SiUg==
X-Gm-Message-State: APjAAAX68QOkkBAwsscQN5PFbhtrPrt9S58tkL/8VDO/K38OtXVtBIQ6
 cAcme76yLEfIlcl2luDkkc4rdA==
X-Google-Smtp-Source: APXvYqwUSfcaGu8f4pgyiXTLDRtMgPUmzU7KbFQx3NfcnNvBg4v9LVY8zBREv6+wYBAex2bjBOc4lw==
X-Received: by 2002:adf:ee03:: with SMTP id y3mr1343060wrn.116.1571986600154; 
 Thu, 24 Oct 2019 23:56:40 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g14sm1238663wro.33.2019.10.24.23.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:56:36 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 43C571FFC8;
 Fri, 25 Oct 2019 07:37:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 48/73] target/sparc: fetch code with translator_ld
Date: Fri, 25 Oct 2019 07:36:48 +0100
Message-Id: <20191025063713.23374-49-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index c68bf4a2e41..edc23a7c403 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5884,7 +5884,7 @@ static void sparc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     CPUSPARCState *env = cs->env_ptr;
     unsigned int insn;
 
-    insn = cpu_ldl_code(env, dc->pc);
+    insn = translator_ldl(env, dc->pc);
     dc->base.pc_next += 4;
     disas_sparc_insn(dc, insn);
 
-- 
2.20.1


