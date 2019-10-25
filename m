Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55780CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21FE421D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O0cbxHjU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FE421D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNuHQ-0004v3-Sr
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtq0-0004iv-VS
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtpz-0007F7-HC
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:44 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:38952)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtpz-0007EC-A7
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:43 -0400
Received: by mail-wm1-x32b.google.com with SMTP id r141so854747wme.4
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 00:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e6OWosr3vkKtYZuEhZpOOVQK50EP38/6kxdAzEYGV48=;
 b=O0cbxHjU7L9AvD0g3dMSk5Ee9wETctht8caLB2opxTRjFKTAxvHwpKurLzQnpyHCZ9
 eEfJOJnz8cBghbdYpU5B2Xuox9MIkISKsX7N3FXiZkAW7rEVw1Ge7rEaHQJQwCT/l36o
 uPT/vNe4YMPWgV5h2GVAWa0iTLc1HGnWJU2dbKaDUAq5gKKT9eaTKv2fBQEK2EOPX11H
 o8uqZFjaTWFktYY9rO5TbMCxEHj7N/pEtbFUmTBYgOoCt3mXkpAJGh3o3jQNQLDmGvp7
 1cBG4yGE/RcODDOWrqAp3ytUgKZIXkcXtQV7xoZsytXThw2QQ3x5cav8k0/dC34W550K
 TA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e6OWosr3vkKtYZuEhZpOOVQK50EP38/6kxdAzEYGV48=;
 b=WlS57LlKKRqAKpMFFhHzJn4udGbp7xN64s21RLjpNuULTTnKPhuy93URKwQrsxK9I8
 Nu0mnRRrTyyodQypcg9VxsylR2Xb5I+msTI8jBug+iYNMPkQZdLj3EBmJWB3R5IVJkPF
 cEWnEJseCXjzZ9XZGCDA69A9j4+FxIVBqXqsrrNxnsnou2HiQA7VvPqiOI188qF3ToGm
 nXOTKizdmogzPkRd8SB9hIR0x9W+BAYHFTRL/C6vNtcCs4Pt74xSeU11pyTsTtCtK6lA
 XCM9GQK4cCzL8LReD+P3h2D4S1JfC/68XaN/KhgEJ52ab+3lbf8BAkih9HTXF13hbQop
 DP4w==
X-Gm-Message-State: APjAAAW4wjpLR/AY69sxeyDuEa41hTYkWXDr7HCftbeeZPjRvoCggLAZ
 iB9TF/O1wHgYhnM4GjEggnuEW2x1rRs=
X-Google-Smtp-Source: APXvYqyzDslGrfRHk9Jqdp8fh8HWCByD71g69sMTX9Va0f7CvNLETFTxXnF4epA9/DovNnpy5XyoFg==
X-Received: by 2002:a1c:7e10:: with SMTP id z16mr1906939wmc.11.1571987802066; 
 Fri, 25 Oct 2019 00:16:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a17sm1176786wmb.8.2019.10.25.00.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 00:16:40 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2F5E91FFC7;
 Fri, 25 Oct 2019 07:37:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 47/73] target/riscv: fetch code with translator_ld
Date: Fri, 25 Oct 2019 07:36:47 +0100
Message-Id: <20191025063713.23374-48-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
 Palmer Dabbelt <palmer@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Emilio G. Cota" <cota@braap.org>, Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Acked-by: Palmer Dabbelt <palmer@sifive.com>

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index adeddb85f67..b26533d4fd7 100644
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


