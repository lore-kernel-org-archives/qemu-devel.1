Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2008ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:21:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BD6520673
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tOsfDhQr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD6520673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyQB-0007qk-CC
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJy29-0006a7-Le
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJy28-00058d-7P
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:57:01 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34513)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJy28-00055D-1D
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:57:00 -0400
Received: by mail-wm1-x342.google.com with SMTP id y135so14227037wmc.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+MF52Dp1tIuy0gH0L5TXn68Hzokx6/nbmqPRJPtyksM=;
 b=tOsfDhQrvWGnrPVlnmK5f/TXut0hgwt19BVb3kVnHdg7JIntLwUKOuGk3Fex87sNFR
 ua29FaRJ944GmxxOQ//ypy/qqlukJYMb3mqxVyFDroPTMLD2u4depBlyruhBXYiQw2tF
 If+TmHeHP7dXxUZGmdTVVOkDbXJapok2RhVK7TXwF+N+eekRisc+jBBAfKI2m+O2yeXq
 Zs+VKBsLO07sGKafYHMMOqdG98VV6tT8/G8ABwQmlILJpT7IycWM7sxEoIRvemobI+TR
 JHriRBpULPNIr3vyWfS6UXitMRyfxj+l/NjwnbOqaf5GZgVOtqozjEHQn4n8mvVSCJB7
 BCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+MF52Dp1tIuy0gH0L5TXn68Hzokx6/nbmqPRJPtyksM=;
 b=BWDYqjjukhMUdkAQsmIKwO17aKW0maedFRfJtknrTmK6N3Ez6l13iQ5BzsIyoU8mtJ
 1wRuJPSg1KCVwdCh0spN0JodpXlifh8ZnH5B1ewUJKHKZ1MBSgHFKCPNOdh0c1vDUgI1
 zeGw8tY0ADvfN5btbvCZEHMbJxTkdVrM8/AHE0RRKixbEoZgN6587JRmidDxdO5VSAik
 5QwszCYsN5lgzVqrok3tXSpMPbSV2X/26jwEJOkhpF1PbDW4ELKCCGSCKXuyf4YhW9QN
 avaEziep76TYm8ufcMw9YCisivJnNh5xpup2QONCxLiutajegRTpD3/z7g/yrrTjecRN
 kCwg==
X-Gm-Message-State: APjAAAUCZmCgBLty2hd2wZyYkAIj0rpSL16uko05dSnj1O29CKG/h4jT
 rF8hUU+7f+pxvQ1ATfnHFakejifz4tU=
X-Google-Smtp-Source: APXvYqwdnroOs3N9SFTp/ThRxrZn8iyvA5atzSUAbk4eSCk8ccw4KTWL0AyTvjsSFp/gNDzgpECE+A==
X-Received: by 2002:a1c:41c1:: with SMTP id o184mr15324749wma.81.1571050617771; 
 Mon, 14 Oct 2019 03:56:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f13sm16009547wmj.17.2019.10.14.03.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:56:56 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 30E8C1FF8C;
 Mon, 14 Oct 2019 11:49:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 31/55] target/riscv: fetch code with translator_ld
Date: Mon, 14 Oct 2019 11:49:24 +0100
Message-Id: <20191014104948.4291-32-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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


