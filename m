Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F00C33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 09:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF2DD20721
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 09:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EFjv9OHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2DD20721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipqW1-0001YU-0E
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 04:23:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shihpo.hung@sifive.com>) id 1ipqFR-0004wX-33
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 04:06:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shihpo.hung@sifive.com>) id 1ipqFP-0006Ra-HL
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 04:06:29 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036]:55203)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shihpo.hung@sifive.com>)
 id 1ipqFP-0006MW-Al
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 04:06:27 -0500
Received: by mail-pj1-x1036.google.com with SMTP id kx11so700207pjb.4
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 01:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=WNQK8xx9OatJlEQCfvIXjtQBv2x8XXmBGEeoU6AnPS8=;
 b=EFjv9OHyELGhF5BYK6P212Lz3lrwN8WTQyhklTCR/UOxDKIed3KT4Jvjg0XTtuSOPC
 vIWZj2KKeW37Ed62auDdYVmP9G14xg/NKbV4csjczVZRDLxd/rUlanAAViDVqo5dsUg6
 fYs+T7Yvl+at+qxeia8/HmN+Vo7XupVJPPqFDjFVBA7KEj5pqi29ycSYLZHQWuGFIBEO
 Gf/GQQWBqdhpZK85oP+r5f93t0c+qNJsVDx0tPojXs/QGqTbiz1OvV2JlS7nt6fJLbVh
 ReVtISALg7gnYuUEo8qSm/wKR/HWY7bO28IaHONE1JjVVjy6V30xCAhmY/02q9q8nTC7
 StfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=WNQK8xx9OatJlEQCfvIXjtQBv2x8XXmBGEeoU6AnPS8=;
 b=GAO6m3MHb+loUqz1tuQJIj3IDCilEpeo8QsFPpukUNwypIH5oDjUwKXPRdpybMlvlx
 0j7qus+zDteG5PXuc3Ubl0L+FOyTZUO+J5Hr3F7RidzaqX4/OYq+wKP17FeRiptVnt2Y
 zyDHELevqE0AE/siAGYldkbQ6nunyYJ+Mv3pKWN8PEX9N+fi8oAlizY/woLjEgvxjSVS
 9dctuydiCSiThset28WQ9Ss4TfnzeggG2L0UCB+ZWvdWDK8j3JBto7YGeeoAYh8RC6zk
 Lne42zAwfpLOarAXCIcT0strwVG1htZXXh1Sxk8T2YFQ1A7fTcK6uJb9wOgyKDCYcZvS
 bKag==
X-Gm-Message-State: APjAAAXWc4K11TdbwWEoNLVXFM1IKeE4ebJKokVPuDf8sAqHUiMstKOF
 2Oy7d4qSj7aCAcOvUP3NYJiMbR7LnzFnD7wX
X-Google-Smtp-Source: APXvYqzDvfvy07yaQ1SP7kTpRz/RUZGOqz4fO5g1VM37G/Xg9lfewIi2rsya9s2pzVe6UycGl7EjGw==
X-Received: by 2002:a17:90a:ba07:: with SMTP id
 s7mr3399547pjr.75.1578647185671; 
 Fri, 10 Jan 2020 01:06:25 -0800 (PST)
Received: from gamma05.internal.sifive.com ([64.62.193.194])
 by smtp.gmail.com with ESMTPSA id h126sm2123220pfe.19.2020.01.10.01.06.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 10 Jan 2020 01:06:25 -0800 (PST)
From: shihpo.hung@sifive.com
To: qemu-devel@nongnu.org
Subject: [PATCH] target/riscv: Set mstatus.DS & FS correctly
Date: Fri, 10 Jan 2020 01:05:34 -0800
Message-Id: <1578647134-13216-1-git-send-email-shihpo.hung@sifive.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1036
X-Mailman-Approved-At: Fri, 10 Jan 2020 04:20:35 -0500
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
Cc: qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 ShihPo Hung <shihpo.hung@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It was found that running libquantum on riscv-linux qemu produced an
incorrect result. After investigation, FP registers are not saved
during context switch due to incorrect mstatus.FS.

Because ctx->mstatus_fs changes dynamically during runtime, we should
remove the mstatus_fs check at the translation stage.

Signed-off-by: ShihPo Hung <shihpo.hung@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: qemu-riscv@nongnu.org
---
 target/riscv/csr.c                      | 3 +--
 target/riscv/insn_trans/trans_rvd.inc.c | 1 -
 target/riscv/insn_trans/trans_rvf.inc.c | 1 -
 target/riscv/translate.c                | 6 +-----
 4 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index da02f9f..0e34c29 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -341,8 +341,7 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
 
     mstatus = (mstatus & ~mask) | (val & mask);
 
-    dirty = (riscv_cpu_fp_enabled(env) &&
-             ((mstatus & MSTATUS_FS) == MSTATUS_FS)) |
+    dirty = ((mstatus & MSTATUS_FS) == MSTATUS_FS) |
             ((mstatus & MSTATUS_XS) == MSTATUS_XS);
     mstatus = set_field(mstatus, MSTATUS_SD, dirty);
     env->mstatus = mstatus;
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
 
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index ab6a891..4ef7300 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -386,15 +386,11 @@ static void gen_store_c(DisasContext *ctx, uint32_t opc, int rs1, int rs2,
 static void mark_fs_dirty(DisasContext *ctx)
 {
     TCGv tmp;
-    if (ctx->mstatus_fs == MSTATUS_FS) {
-        return;
-    }
-    /* Remember the state change for the rest of the TB.  */
-    ctx->mstatus_fs = MSTATUS_FS;
 
     tmp = tcg_temp_new();
     tcg_gen_ld_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus));
     tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
+    tcg_gen_ori_tl(tmp, tmp, MSTATUS_SD);
     tcg_gen_st_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus));
     tcg_temp_free(tmp);
 }
-- 
2.7.4


