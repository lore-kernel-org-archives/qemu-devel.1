Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596B3C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 01:02:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2456121D56
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 01:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DOHQl+JO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2456121D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8vx6-00038f-As
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 20:02:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkk-0002GG-MY
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkj-0004Qb-MK
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:42 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036]:35662)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j8vkj-0004QR-GT
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:41 -0500
Received: by mail-pj1-x1036.google.com with SMTP id s8so550363pjq.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 16:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=HbGfUPv0cd7o7bP476lAqHrxUZfWuNH/ffddHd7fEos=;
 b=DOHQl+JOUZUliOK+7WLqmFiyd3DpxYgoGCw0tqjRJV3G83Xhl2Cgv/Dks6rQlMnRki
 teZIaoP1vr8yHes8Tc74kWdw3CryhJplC5zREOA/f7bFWn8Gh/m4kVnn9hEyI7ADzPti
 Eh7l7Pf5+0dEovihMu5Nc2K+DIivoSPq3oWAf9JVUZzeZzF5V6UMu8v0ZITbjgd9bnVz
 h04Dw485DjfpRAmGaslfz9V3ICklk68MtR2ITaEhbDD+L5S2mLzjV+/AsGHu2LRS9Jnx
 HfIbk3A4QFB7tGiFX8R5dfnXDzfaIOZ9BKerOi2Mi5b22achDJqF0xIPfIFSjomy0DYu
 AEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=HbGfUPv0cd7o7bP476lAqHrxUZfWuNH/ffddHd7fEos=;
 b=Pi7PK29lz0Dii2PwljkHwC8pbNvZqp9u+hT3xYzZ9X6K6FUWIyMACps2SavHCNSL1g
 Ov3goAbagGqwmG54g7zU0edL51KsrKisodeuh8/dDIw4vVykeWa6iqjrCK7q3uimRx7T
 ithoBunYnrKWM7puHLGkM0kV0NG40CM1qJquOlIGjl7tdovyTTpGcM0g51PgOVDcPJyl
 OMbGhyZhYQ3N1RHLTwhgoD5vgVbJndiF9mtYGwcNAx8ETurdXOrC5H0XoXT+iR/GqvRG
 TkyiDYMjzC/2hgRqQ9MNXH4D94NPsVCcKkVeS93ZMEHxfbpqKw8c8Mu39aZezHFW/pqG
 wiTA==
X-Gm-Message-State: ANhLgQ1EXMO1j1pMymTTO+Qnbi/wzcMvGeBuIX5I+sTVF1QRO95esG+U
 b2eSYqm/aG6VsdObTqbS3uXmu4ax65OFpw==
X-Google-Smtp-Source: ADFU+vt8FQmcxf5ZJYv2NcYU5ZuBI+/79Ajeg7uSmXRJhFLosymtvVcYfVLC5w/42sFDSSJU6MIgNA==
X-Received: by 2002:a17:90a:9409:: with SMTP id
 r9mr1221904pjo.39.1583196580433; 
 Mon, 02 Mar 2020 16:49:40 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id d6sm97750pjv.38.2020.03.02.16.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 16:49:39 -0800 (PST)
Subject: [PULL 24/38] target/riscv: Remove the hret instruction
Date: Mon,  2 Mar 2020 16:48:34 -0800
Message-Id: <20200303004848.136788-25-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200303004848.136788-1-palmerdabbelt@google.com>
References: <20200303004848.136788-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-riscv@nongnu.org,          qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1036
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

The hret instruction does not exist in the new spec versions, so remove
it from QEMU.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/insn32.decode                     | 1 -
 target/riscv/insn_trans/trans_privileged.inc.c | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index cfd9ca6d2b..b883672e63 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -75,7 +75,6 @@ ecall       000000000000     00000 000 00000 1110011
 ebreak      000000000001     00000 000 00000 1110011
 uret        0000000    00010 00000 000 00000 1110011
 sret        0001000    00010 00000 000 00000 1110011
-hret        0010000    00010 00000 000 00000 1110011
 mret        0011000    00010 00000 000 00000 1110011
 wfi         0001000    00101 00000 000 00000 1110011
 hfence_gvma 0110001    ..... ..... 000 00000 1110011 @hfence_gvma
diff --git a/target/riscv/insn_trans/trans_privileged.inc.c b/target/riscv/insn_trans/trans_privileged.inc.c
index b9b5a89b52..76c2fad71c 100644
--- a/target/riscv/insn_trans/trans_privileged.inc.c
+++ b/target/riscv/insn_trans/trans_privileged.inc.c
@@ -58,11 +58,6 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
 #endif
 }
 
-static bool trans_hret(DisasContext *ctx, arg_hret *a)
-{
-    return false;
-}
-
 static bool trans_mret(DisasContext *ctx, arg_mret *a)
 {
 #ifndef CONFIG_USER_ONLY
-- 
2.25.0.265.gbab2e86ba0-goog


