Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52959FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:03:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19CAD2054F
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J/r2yhe1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19CAD2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6Mq-00058X-NI
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5mY-0002MV-73
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5mX-0001J1-0h
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:33 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46324)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5mW-0001Ij-P4
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:32 -0400
Received: by mail-wr1-x441.google.com with SMTP id o18so2319663wrv.13
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZiZ/jjbBIoVwkmOcALd/5dVI1/K7ovHMSAFhO/Jn2Ls=;
 b=J/r2yhe1NAF0kK5CYJb4JTNNzVIi6nwMJlflK9D2edIuP9dfFnMOdb1UDD1lZrlYwm
 MRxyCoFan6HIhI16slX497ISWRnEkhYQ08wNmL+m6UkP6eNGLr7UMVTfBp2shVUMI/Vn
 FkWCiwWxTBDO2sbAH8bGnZZ0yFE4fTkqdosA3+nzdBhagB0jtf5UwwI0FDpIMr8WhsLe
 KGpETvE8yhRyYoxvoNiWkT4D0yp4uGmrbnzJjsPReba/m+UFDukSGaqla26f1Z6dRWHm
 fbCIuoDHUZG90kzRWlO7Qf6NLTle0sy24307ofr4NzEN+imU5GrMIPQvigTTV/BytOmy
 pfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZiZ/jjbBIoVwkmOcALd/5dVI1/K7ovHMSAFhO/Jn2Ls=;
 b=Qjvmfa80q/48QBoHG0/QhSiHo6W3rKnWdCWhhYhxFGQsiyGVAgosI4LUF7qnQouuKs
 uoH9WHSwZI6UHykfMA85oDvWkUo9H/ePNiYSZFr5bCok35EtqiHYjoqVPAf7L6Ai1P/R
 Se3l1mtAkCxXsvA/CyIRxTuFJ1caCapNKxP7u74oZOpVpcpTi044Z5D7Q6CrytzwbEmU
 jtM2QPZgdgYOwCGxeW8vSscXD88mwSk0RFuIvmnR/RzPVe0Twr06V3hwD35M2XdjJunC
 L8hOzWm4pVqscITTS82iHY8AGRiz6ECuLWWT7i7OJxvlylZou+gT6EOXj2LOe2Y9PY1C
 y0ng==
X-Gm-Message-State: APjAAAXVbpzLHHNU8KUWFZJvesiJ7836w91PqkimFXHVb+2krsXLaEz6
 LPKG2aR+ZBkNJsTH8rXAXAwSWbsGF8I=
X-Google-Smtp-Source: APXvYqykTEEipQWT9xQ9KVBtM+aiBi8PoOqF1yKU5Iiqas7G+y6TTV5S8jjvJPZDNlcPXzRxBXQMzg==
X-Received: by 2002:adf:ef4f:: with SMTP id c15mr3120155wrp.296.1571318731706; 
 Thu, 17 Oct 2019 06:25:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r2sm2203218wrm.3.2019.10.17.06.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:25:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 008D61FFB8;
 Thu, 17 Oct 2019 14:16:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 33/54] target/openrisc: fetch code with translator_ld
Date: Thu, 17 Oct 2019 14:15:54 +0100
Message-Id: <20191017131615.19660-34-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
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


