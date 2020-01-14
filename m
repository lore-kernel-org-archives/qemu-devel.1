Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D961FC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:16:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7F1E20678
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IZFq9X7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F1E20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irJEu-0007Xm-MC
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 05:16:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shihpo.hung@sifive.com>) id 1irJDr-0006UT-Ux
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:14:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shihpo.hung@sifive.com>) id 1irJDq-0003jY-W3
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:14:55 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:38352)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shihpo.hung@sifive.com>)
 id 1irJDq-0003j8-QZ
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:14:54 -0500
Received: by mail-pf1-x42b.google.com with SMTP id x185so6366717pfc.5
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 02:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=oSnMNRdByfNLX4llxI4HRMZBCtaBWjFtoTF0fHO6R4M=;
 b=IZFq9X7OD5bpxjOV7Nqp5qqmnYJPHfUj02WeqbBF6LibhcvwkDWWlMOGHnvN4K+Yj2
 tI6wqWoT5dCf8ekcDChZFs0dF3ef3C0/rkZxnfXcdaRYhTyzYkcQvLR32saT9T50ovSZ
 3aPJiM90DANL++9QWrvVGQP8tzLl3eQ7pPCavM8YqcirYBDi+TC+/clnQUhLli8nLErZ
 j+Z7/KzS1owo91U2H0SPhCk8PtSAtriP0LdESIERFPv2zisML1jDVsdIWuuWxOtd2pmJ
 W+QKjquvzzb0YtafDpSlgza2yt0zlSzADCyCTMOIWwXelVBewDIlQvNtzAriTrUAELPs
 MYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=oSnMNRdByfNLX4llxI4HRMZBCtaBWjFtoTF0fHO6R4M=;
 b=RH5lpZ3Kdnbq4aNNcFNZEChgR+X4fasjNdGK6ZAc/cv7GKIBO+USeVw5hM7Gznsyjg
 wYoiPjiK/jnlu/Dw33Y+s0qB9i5AhLfIq4H9/2Y0ObkoFc+TvQnWlSAX40eSyWCdtGDK
 0gX7E9Ji+InM/gk59enRlG3Nz2/0xjiEMWYcFbUGoUU/g0jUcW3njI0SKniFGFj5amAj
 ObaMp99fWsqMz+XwssumYL1hg0+Q8/ZDWRSJzkfpyVbfVCnS1wvzFfK+ObWggl6NU9Jx
 49dx9lOSUVjsACmsTSw3hgnbsG12hmHCPTD4S1em5SndUv0Q81pV7b4pLnlgKNPOhR5C
 8Wnw==
X-Gm-Message-State: APjAAAXhex1tvDH2EId4dc6C/X2HJGvW5oc9K/fK3i5ERBCf87kDvsBb
 6yRwqOHdLNfov9cXhpSH953Aow==
X-Google-Smtp-Source: APXvYqw8BP5ZBzLouB/pbeoYuQsaYAeoGGY5WQle6UYjKIryEVF9IG6exO4sZiSiuGbVGHNKHBXNiQ==
X-Received: by 2002:a63:d358:: with SMTP id u24mr26298356pgi.218.1578996893802; 
 Tue, 14 Jan 2020 02:14:53 -0800 (PST)
Received: from gamma04.internal.sifive.com ([64.62.193.194])
 by smtp.gmail.com with ESMTPSA id k23sm16158583pgg.7.2020.01.14.02.14.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 14 Jan 2020 02:14:53 -0800 (PST)
From: shihpo.hung@sifive.com
To: qemu-riscv@nongnu.org
Subject: [PATCH v2 2/3] target/riscv: fsd/fsw doesn't dirty FP state
Date: Tue, 14 Jan 2020 02:13:59 -0800
Message-Id: <1578996840-14863-2-git-send-email-shihpo.hung@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578996840-14863-1-git-send-email-shihpo.hung@sifive.com>
References: <1578996840-14863-1-git-send-email-shihpo.hung@sifive.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42b
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, ShihPo Hung <shihpo.hung@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: ShihPo Hung <shihpo.hung@sifive.com>
---
 target/riscv/insn_trans/trans_rvd.inc.c | 1 -
 target/riscv/insn_trans/trans_rvf.inc.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvd.inc.c b/target/riscv/insn_trans/trans_rvd.inc.c
index 393fa02..ea1044f 100644
--- a/target/riscv/insn_trans/trans_rvd.inc.c
+++ b/target/riscv/insn_trans/trans_rvd.inc.c
@@ -43,7 +43,6 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
 
     tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], t0, ctx->mem_idx, MO_TEQ);
 
-    mark_fs_dirty(ctx);
     tcg_temp_free(t0);
     return true;
 }
diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
index 172dbfa..e23cd63 100644
--- a/target/riscv/insn_trans/trans_rvf.inc.c
+++ b/target/riscv/insn_trans/trans_rvf.inc.c
@@ -52,7 +52,6 @@ static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
     tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], t0, ctx->mem_idx, MO_TEUL);
 
     tcg_temp_free(t0);
-    mark_fs_dirty(ctx);
     return true;
 }
 
-- 
2.7.4


