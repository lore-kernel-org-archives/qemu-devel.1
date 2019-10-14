Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59626ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:36:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2307020854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vBeicO2H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2307020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJydz-0007J0-8P
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJyBk-0007h1-Mm
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJyBj-0007Bs-HR
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:06:56 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40379)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJyBj-0007AL-BY
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:06:55 -0400
Received: by mail-wr1-x441.google.com with SMTP id h4so19227380wrv.7
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 04:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZiZ/jjbBIoVwkmOcALd/5dVI1/K7ovHMSAFhO/Jn2Ls=;
 b=vBeicO2HOdNu2/iT9QsLjmbnAvfBHkrpDoaaAxu/31tuneH0ono5KWCMuq4qx50R/z
 nkTgcUQK+b9+x9nVHJoXSUoXfY7bfBhNMOTVj4/kZBq0d2YHPgeZ7Pe5VnXd4bEhM9Zd
 NMeP1cHHNThFvtBk/UnTD+rpqCcvUDDNbYVygYbF051z4ccE2mLBdR+ZBkgHZFoV2i5r
 YRVDcadHIVE/+oBKaX9OMDEAH4NYazO+GVpVpUV1q5hBhVSKHh3v7oeVVn5APhGCdhzp
 vdEdVoOh+pZ2Bo0uk9dJV0/j780PAdsP4+x6+AoxvdI0hfOtbFiSv5HsYZYWjGL3BWDB
 M5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZiZ/jjbBIoVwkmOcALd/5dVI1/K7ovHMSAFhO/Jn2Ls=;
 b=YKL0sNyJWF7kVahu5ReJD4HIDSkzFDaLvVUWMnxWRbIEd0SKx4vjJOLuSarT7W/4ze
 XmnO/wc5ZQpWNax26MGTsu7PgmeDU12gNYcsHfj3tggnA1XgOCoYl6nyUYHRG19IOION
 6dPYYNSSlqElq2J+MHESQ0RcTlJjTF+ueZ9eikQLETaky5wMLB+SqENKNjMwGWq5m9EO
 3tTdyhmCqU1wxjCDyu0DHSWBudrgs42C+wt81d2QC+QrQCOr0vcb0/fDTWXkgNVAHULI
 RGwFNGNkWGtXbY8K5TDFAFKYCPwAyLFmJ7boOWYnsJgPrt7lCHXyHWicwy/hd5+Gj4nL
 h5nQ==
X-Gm-Message-State: APjAAAVa3yIsjagdgjl30ulZg/pUOq1azogSiCTzMeWtzNgBqK1PR1+4
 odswjZuv5t0bUGNe20jaRpsppw==
X-Google-Smtp-Source: APXvYqwyGN21oO1I7skQ98Q9RbI5qTxdln36JPgU8rU2IOoZ7pQ+6wDQ+LoZcMzxBRnVjJ2alTFKGw==
X-Received: by 2002:adf:f90f:: with SMTP id b15mr25344553wrr.76.1571051214031; 
 Mon, 14 Oct 2019 04:06:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p5sm24188293wmi.4.2019.10.14.04.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 04:06:52 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B105D1FFBF;
 Mon, 14 Oct 2019 11:49:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 34/55] target/openrisc: fetch code with translator_ld
Date: Mon, 14 Oct 2019 11:49:27 +0100
Message-Id: <20191014104948.4291-35-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
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
index 6addbac8d6..8dd28d6cf1 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1645,7 +1645,7 @@ static void openrisc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
-    uint32_t insn = cpu_ldl_code(&cpu->env, dc->base.pc_next);
+    uint32_t insn = translator_ldl(&cpu->env, dc->base.pc_next);
 
     if (!decode(dc, insn)) {
         gen_illegal_exception(dc);
-- 
2.20.1


