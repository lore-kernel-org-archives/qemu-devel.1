Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E2FC33CB3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 06:18:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B27A624671
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 06:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Iy6Wlf8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27A624671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irc0z-0007Nr-ON
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 01:18:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shihpo.hung@sifive.com>) id 1irbzx-00063z-03
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 01:17:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shihpo.hung@sifive.com>) id 1irbzv-0003XG-SU
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 01:17:48 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:33049)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shihpo.hung@sifive.com>)
 id 1irbzv-0003Wt-NV
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 01:17:47 -0500
Received: by mail-pj1-x1042.google.com with SMTP id u63so1700797pjb.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 22:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=Jx3r2seKwSeUadPVhjH4OOR8DMwWWFpbD6d3Ui5d1O8=;
 b=Iy6Wlf8FywDmtcjxTWf0Q1wvPc/Miuzbi2uWt3BzSrgtQWcGESmCLvGAglCiN2qN98
 9/ZWl02NeLoRXGURZ9ysiTXOyj/NYq4EuePi6qF4leEOtMi8rwErIrpz390+3WPhvoje
 bEoqdvJ2Xux1CBZrBw1DnQXFJ6OiZtWc29Krn8RyAPTUa6axQowYWqcLty+btNPap4ad
 cTyFdHkwRGcwIIzbDvSH/XXY/1U6P5OfLM40FOloJm3+PMDzVM4sxs4k1s86Qx2jIdGf
 oRMnykzfLQRdl16aFOnXe1s243fujiCPU6nkG4AlF/qIsNuLzzVLhUjCaFrpkh79xPnq
 jCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Jx3r2seKwSeUadPVhjH4OOR8DMwWWFpbD6d3Ui5d1O8=;
 b=JPOIi1/pUmGiNKxAbYZOVXENmtQn8JZfiEm5EukwzybMdiNufu7iVrlH29ByiouSHJ
 EBEADjuuGSDIKkE+cmhLptf/5JuzfW2t+G4vd3tu5X0+LFYB/R53DnrNWSyiHIiQupDd
 Y4imZzBzYpVuuAivMzN0HJfBM8ul4BpJB0PPutj5H2x/CVXSv86EhoqLazB6LyU0gPDd
 qBB+USMeUEfkVVXVwjJBJdB09h36rNDi95HY6Dkr+lYJtj7WruCVv7qVkAC1CDly1oKF
 HDtiLQQUh+N+v4yKRDdSDK5m3OFNXqV7r0I66MYdgTd76BTfiH+oNebk1Fje19Sk4/qV
 RW4A==
X-Gm-Message-State: APjAAAWXbLU/EF6Uxl7cgdB4gxbKEPS18R+r3f/DCrFGi+LZhaXMSNil
 gyTg1IsBXOfMA9AOgHhnRWo2yw==
X-Google-Smtp-Source: APXvYqzrCCLc5US08o/zjGzN1k1QnbEN+ADAX5uJfoWSEM5Y8AvoExONDVL82wqaP4iwY2Twitnmkw==
X-Received: by 2002:a17:90a:d995:: with SMTP id
 d21mr34127974pjv.118.1579069066564; 
 Tue, 14 Jan 2020 22:17:46 -0800 (PST)
Received: from gamma04.internal.sifive.com ([64.62.193.194])
 by smtp.gmail.com with ESMTPSA id w123sm20633601pfb.167.2020.01.14.22.17.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 14 Jan 2020 22:17:45 -0800 (PST)
From: shihpo.hung@sifive.com
To: qemu-riscv@nongnu.org
Subject: [PATCH v3 1/3] target/riscv: Fix tb->flags FS status
Date: Tue, 14 Jan 2020 22:17:31 -0800
Message-Id: <1579069053-22190-1-git-send-email-shihpo.hung@sifive.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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

It was found that running libquantum on riscv-linux qemu produced an
incorrect result. After investigation, FP registers are not saved
during context switch due to incorrect mstatus.FS.

In current implementation tb->flags merges all non-disabled state to
dirty. This means the code in mark_fs_dirty in translate.c that
handles initial and clean states is unreachable.

This patch fixes it and is successfully tested with:
  libquantum

Thanks to Richard for pointing out the actual bug.

v3: remove the redundant condition
v2: root cause FS problem

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: ShihPo Hung <shihpo.hung@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index e59343e..de0a8d8 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -293,10 +293,7 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
 #ifdef CONFIG_USER_ONLY
     *flags = TB_FLAGS_MSTATUS_FS;
 #else
-    *flags = cpu_mmu_index(env, 0);
-    if (riscv_cpu_fp_enabled(env)) {
-        *flags |= TB_FLAGS_MSTATUS_FS;
-    }
+    *flags = cpu_mmu_index(env, 0) | (env->mstatus & MSTATUS_FS);
 #endif
 }
 
-- 
2.7.4


