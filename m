Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCE3C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 23:45:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B1FA217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 23:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g5jzp4VE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1FA217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu3Cp-0006Ty-0q
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 18:45:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1iu39J-0001f4-3A
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 18:41:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1iu39H-0004rw-7Z
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 18:41:32 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:39358)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1iu39F-0004qL-NA
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 18:41:30 -0500
Received: by mail-pl1-x62a.google.com with SMTP id g6so2046412plp.6
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 15:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:mime-version:content-transfer-encoding:cc
 :from:to:in-reply-to:references;
 bh=Eswd/iZsVKMQNZDhJhB6RGXioT8oGHLH2OtVyxEhoVI=;
 b=g5jzp4VEzZtEYjyB2n+UMYhAJVojVzgtSlGuSgaIGVI3Xz9DZs6es54aY49CvGBcr0
 uPEX7/6LOY8042zKWOvTCeffJ092IixvFbkrSvbsrvrepJKjgnVQHTmjFR0fxx0VuCK/
 rFNgQ0/y8zPagTCpREDtT6wtOLnk60kP36/gvpj3Is0Dn9MiK0uO+XC1yYDmWqBdLq82
 eddUZB4Q+toID6CE3QtGNRZ7upxBNhYJQAebKkaYzlknhkBeBZkKZQJGCrawhUiZXAOU
 PE2cRqzz4h7JKgt4n77ZYb9KJ92pYB54fNpe6aUHG+jP11TPMmXQHiiwTKxCiPaITWAZ
 Ej3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:mime-version
 :content-transfer-encoding:cc:from:to:in-reply-to:references;
 bh=Eswd/iZsVKMQNZDhJhB6RGXioT8oGHLH2OtVyxEhoVI=;
 b=VmiAigKZ0nexPtfb6CNwBQ+F479Qj0ZexptCn+NZzlQsCwrPBFYZhd/tUjaZBxDPfs
 P22TInZv+NijtvzKteXoV5KPt6lCuSnyNL3RneT2VPtrd1jD18H8LVKTi6z6o8V8R+gK
 0fN1TZQrknZiOqPE/tkEcPw5lwxWqUjk0KcAFFl04OhAb35EPDsHdfKN7qHtRso9YBs9
 i+QF0cKqorbtlu8/ejx9nEguCxAg0ZsYqjrHRV8z/Y/jkNSRlSGHl0PjSimyIYHaDKaS
 b3tkU5Y9ryDogOkui4X3ZcsYxzri1fOTVB6ZUeOHkV6PH0N5FpvmL2GCv1ppuwJ08FiL
 o8hA==
X-Gm-Message-State: APjAAAVuG2wMLK4Rq8vPLxenGS5rWmgRaJT1Iz4Tc3z0ediDDAjtGURJ
 dnU+CxvWmCXSbZ3fJ8MI0SkSy818SZ8=
X-Google-Smtp-Source: APXvYqyapoWzSwZDcjb0Z6XQ1Sm7nP8kOBmwfpPwwxspCOGCABxo2x5O63fDZI54cl5hLP8uF06cjA==
X-Received: by 2002:a17:902:124:: with SMTP id
 33mr7798768plb.115.1579650088186; 
 Tue, 21 Jan 2020 15:41:28 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
 by smtp.gmail.com with ESMTPSA id m14sm555650pjf.3.2020.01.21.15.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 15:41:27 -0800 (PST)
Subject: [PULL 4/5] target/riscv: fsd/fsw doesn't dirty FP state
Date: Tue, 21 Jan 2020 14:57:01 -0800
Message-Id: <20200121225703.148465-5-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-devel@nongnu.org,       qemu-riscv@nongnu.org,
 ShihPo Hung <shihpo.hung@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
In-Reply-To: <20200121225703.148465-1-palmerdabbelt@google.com>
References: <20200121225703.148465-1-palmerdabbelt@google.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62a
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

From: ShihPo Hung <shihpo.hung@sifive.com>

Signed-off-by: ShihPo Hung <shihpo.hung@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/insn_trans/trans_rvd.inc.c | 1 -
 target/riscv/insn_trans/trans_rvf.inc.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvd.inc.c b/target/riscv/insn_trans/trans_rvd.inc.c
index 393fa0248c..ea1044f13b 100644
--- a/target/riscv/insn_trans/trans_rvd.inc.c
+++ b/target/riscv/insn_trans/trans_rvd.inc.c
@@ -43,7 +43,6 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
 
     tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], t0, ctx->mem_idx, MO_TEQ);
 
-    mark_fs_dirty(ctx);
     tcg_temp_free(t0);
     return true;
 }
diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
index 172dbfa919..e23cd639a6 100644
--- a/target/riscv/insn_trans/trans_rvf.inc.c
+++ b/target/riscv/insn_trans/trans_rvf.inc.c
@@ -52,7 +52,6 @@ static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
     tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], t0, ctx->mem_idx, MO_TEUL);
 
     tcg_temp_free(t0);
-    mark_fs_dirty(ctx);
     return true;
 }
 
-- 
2.25.0.341.g760bfbb309-goog


