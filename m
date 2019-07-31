Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8960CC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 551A0206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VDb83tAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 551A0206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrOp-0001XD-JW
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42515)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrGB-00069h-8X
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrGA-0004DS-3b
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:27 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43029)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsrG9-0004Cs-SH
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:26 -0400
Received: by mail-wr1-x442.google.com with SMTP id p13so70305874wru.10
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=t7tqVUjAD2PfWwfma6adF8tsYdFtgp6/4kEZrCKl67k=;
 b=VDb83tAnPSPUoNZ8WUGqv2g/foqveCWQxQOwIurq3poRKLQv5WtJhrbnwovRuAjd7N
 ysBBJlu79JPB/fcPjHEvsxXNRoY+F/mAmLSHOGI3PbX4ZEtwJN1bLXlvMIzBJr7had+Z
 Pd0mheFbqz+LKZnlZX9/2AEC116E8VzPBhGta4t4PDoDM7YiPORjjicYU1/o0Z779XL6
 Btnaa8/7nO+Y8/bkPf8YvsQRqZ0Ropu7zuJUp1wbCHhL+0NJwTNt84XeEH3+416WuyHw
 KH93OytR58v37uPJMMvvQcRxq5JdG7wr5KuqGXZrRZ9B9Ryd0JuMPaC8Tt5/DV/rbglL
 qLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t7tqVUjAD2PfWwfma6adF8tsYdFtgp6/4kEZrCKl67k=;
 b=JPOVxwbtFtnC4oMJNUYTjVywuU/JyDvStP+rNpJXQtvXkUAxzYWrvHCbtP4f7NFrNf
 G+FvAzNPaSp5Quxpi4dikohJ++i2aEoAAg7fKhlzwEEyN0ucZ2dAelpNIFcSEVBllu11
 jgvOtYPiqaYzq8rbkLG5a+ZmOBm+vDVlO+TGa2DnEeXoSc9Y/ToHD5/V8ac6FoHItzmL
 Q4P+GfW5YnYTAFXxYkIz7ODJZLnMM4DZaPwTTTJX0hGdxC1oX271R6FLj7kdclvXo3zm
 bOW4SccP29MP69ziGwNJzuxydGIPkpLJJb1X7HzbrIFQNL5+JFhaVg1z+nlb8DwRRFo4
 iraQ==
X-Gm-Message-State: APjAAAU6JlBgDZC1roX3JO35vb24lVOpd+B0823OHY4Y8UZEJKsgZF65
 K7R3hf6HhSq43JUWmEGS4juN4g==
X-Google-Smtp-Source: APXvYqwpi0Nf9un6FExiRZUuuZkcR6fGjpdRPdPmB0RzYel7ZPCJhWobKuqDTYLSTAC6mhDjJmq2hg==
X-Received: by 2002:adf:afe7:: with SMTP id
 y39mr131632998wrd.350.1564589724833; 
 Wed, 31 Jul 2019 09:15:24 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id g8sm68961022wmf.17.2019.07.31.09.15.17
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:15:22 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 48ACA1FFBF;
 Wed, 31 Jul 2019 17:07:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:07:06 +0100
Message-Id: <20190731160719.11396-42-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v4 41/54] target/openrisc: fetch code with
 translator_ld
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
 aaron@os.amperecomputing.com, cota@braap.org,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, bobby.prani@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/openrisc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 4360ce40452..7df4c68d158 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1305,7 +1305,7 @@ static void openrisc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
-    uint32_t insn = cpu_ldl_code(&cpu->env, dc->base.pc_next);
+    uint32_t insn = translator_ldl(&cpu->env, dc->base.pc_next);
 
     if (!decode(dc, insn)) {
         gen_illegal_exception(dc);
-- 
2.20.1


