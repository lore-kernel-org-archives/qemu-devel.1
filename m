Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB62DFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:24:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96BE52089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UvRjCgLv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96BE52089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6hm-0006Cu-Et
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5wF-00063M-5s
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5wB-0004TS-2h
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:34 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40011)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5w9-0004Rh-5D
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:30 -0400
Received: by mail-wm1-x344.google.com with SMTP id b24so2560743wmj.5
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zINIjrg5CEtICP7WAjfJ/LHNMUKajz/cR/8/N/SNqEo=;
 b=UvRjCgLv76Ez7h3mX1zaGutHoDWjvqpwZUin/S2MygvBlEUKForsqAfZ/f2RXEfO0w
 mF1Icgl9QQjLj6p9NNfs10lAwdah1+P3faAmRwldEKgvsvo0Rr6vKl3mpPA/NgzWtimQ
 926cudjLIrirkxuO6Eo/aHibeGUBGgLkEffjBsmzyOJtAm41MQ7ED7BVyQ7FuTRLvKIm
 t54YtM9D6VU7IuNX+wpK5cEJdSkvPX4NTbHn4JSemv3pqvly1Gw05wNc+nnjMk/dixa6
 1tvffZHcsNQlR6u6m7CTCz0V37ByUQq9Vy68kioZ1XDic+M7Q9Aa3xA6jZBiWvL1W4Ou
 XCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zINIjrg5CEtICP7WAjfJ/LHNMUKajz/cR/8/N/SNqEo=;
 b=kNwczLbmouZpA1rElFL7KsCwuY3igBZlzB5KH8Ll393FtjzGHSAS/5kux1KqvZiHLE
 wWQUzCxfuZZ+KOdkqQFoxvEDHdz/l+9METQ2kf6kSyzKGpwrPtZoJEAZ8QSLHyrCyq7N
 8WeZMtUmNnHfu+VM5BXxQOsV154UKcaK8VnJoYrwK7UYbbYOUKJEU0bNrr+vuumRfHyx
 wmABMPUu6qEqmFeZrlR5VJ+SvqjiN6dcwgt03G1Fmek14LUplFwtZeD+H8bokvmo6hoh
 tmycPi6Dx7kxjA8hMatb5uZFo55T5YMp+mvHR6tJ1hXtPGDNTFO6CCQ8WIpM29HV5KJB
 cDzg==
X-Gm-Message-State: APjAAAVJNvHRCyFmkEM71EaSDDQs+QdrQ+ZkSGavC8opjuYTvEJm7XbN
 EOO9yFpf/dB5x9w0fT+9u0H/Yg==
X-Google-Smtp-Source: APXvYqz3Yi8ec4OhaPCDeDa0Y3o7bPbClaInG4PhBnDTZClQxp9D9lAaQBtTHQ31EduWCApeuTWUHw==
X-Received: by 2002:a1c:740a:: with SMTP id p10mr3035756wmc.130.1571319326697; 
 Thu, 17 Oct 2019 06:35:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g17sm2215623wrq.58.2019.10.17.06.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:35:25 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B39581FFB4;
 Thu, 17 Oct 2019 14:16:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 30/54] target/riscv: fetch code with translator_ld
Date: Thu, 17 Oct 2019 14:15:51 +0100
Message-Id: <20191017131615.19660-31-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 robert.foley@futurewei.com, Palmer Dabbelt <palmer@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index adeddb85f6..b26533d4fd 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -779,7 +779,7 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPURISCVState *env = cpu->env_ptr;
 
-    ctx->opcode = cpu_ldl_code(env, ctx->base.pc_next);
+    ctx->opcode = translator_ldl(env, ctx->base.pc_next);
     decode_opc(ctx);
     ctx->base.pc_next = ctx->pc_succ_insn;
 
-- 
2.20.1


