Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9409C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:31:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97EB12177E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qQR8ak4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97EB12177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54114 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbqzB-0008NN-Qq
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 14:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34272)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbq0c-0007IW-54
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:29:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbq0U-0004K1-RU
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:56 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36525)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbq0R-0003w3-2w
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:52 -0400
Received: by mail-wm1-x343.google.com with SMTP id u8so3100558wmm.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=y+34OeiOJi4hTXE8brxuKPyvEg2ag444W2pbsGyLziY=;
 b=qQR8ak4o/T0VsAOYgzhfoD323bq7ELePZfhYzGL1qTVJK2Dwk3cZDi7bWJZFYg/fCf
 jebf/RaGnMzR18mcyasIPnv03a56+LOT+ikoPmZuor3BqrKM9zbmvDDXg4Kf6VjPSXjH
 hJ4gDReGpyoBFv9GyCHPR1aTNgOBQUL12QSNqiMZr/V9evQs/dBXqz3vemdfuv8LKPkI
 OoLR8uWQA/6pzBG7XrlEUIgptqltS6IDMQk78jE+4QAS+D6J0FxQrh0MrdJ8ejZutqzq
 830a9V3Mgyx4FXI7n54ORixTQdhMlahCS7HrKHnKxNorOpPMzWHocpcYaGbpd0RH/vr/
 hMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y+34OeiOJi4hTXE8brxuKPyvEg2ag444W2pbsGyLziY=;
 b=ESW1XGTk2BmkMMy9itSn7+wVCU+U/bBygK88N5Mwo42WU9mgzToeo6RkT+nFF7P/nh
 fSs7a4CEKjOk157byGAbrReKol8DIN3A402TfUBigHNxZhabTLwH2EgDDhgqhpx4zjHD
 RZuwhvxJWU0stbumx1EgXcNcXFAVwJBgKqFhxTlWQhdsIMILtXJspFX8v+UOmIqWcIKv
 /qle4GUZroM6mroKTGpZOsVbznns1qAgKS9xFeALTm/Jh3GZyoLdjOFabPvaZWA/ClpT
 i2aqH8sC1uNEBDX39lyqWZWlTAbqRBnidT28AxCdi2+/1Wq9tsbaP5b2HNeCXJ9VojeO
 Xb0A==
X-Gm-Message-State: APjAAAUSazTUEjJs3GWWwpt75rQ+7sHRjyVFQeK/VSAI+lHAZMd0oy2P
 fDtFojVLqO8LXUVbfKXWr3bliA==
X-Google-Smtp-Source: APXvYqzIWddpxQxn5iSaxqlDYzs2Bf139Pb6u1FWGZIHq1LEifCmiAToHYtQbZ0FGYuVz4bFKb6LYw==
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr9399028wmc.151.1560533317329; 
 Fri, 14 Jun 2019 10:28:37 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id c11sm2083776wrs.97.2019.06.14.10.28.31
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:28:36 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E3E951FFB1;
 Fri, 14 Jun 2019 18:12:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:37 +0100
Message-Id: <20190614171200.21078-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v3 27/50] target/ppc: fetch code with
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
Cc: "Emilio G. Cota" <cota@braap.org>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/ppc/translate.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 4a5de28036..a27b5659f4 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7864,11 +7864,9 @@ static void ppc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
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


