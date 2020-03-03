Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A52C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 01:01:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F91020866
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 01:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bO27781t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F91020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8vvn-0008Jg-5F
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 20:01:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45338)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkr-0002Xu-9N
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkp-0004T1-Ii
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:48 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40644)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j8vkp-0004SY-6j
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:47 -0500
Received: by mail-pf1-x441.google.com with SMTP id l184so555216pfl.7
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 16:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=ti9yXoRVYSbU3lnCHfDJy3KSsIWSbEVNqPE18S19cuA=;
 b=bO27781trIx6Jb8P4cLS9o4ZLvW2fBdDuDDqaN7KAgLIgoe+WgnJasaqZH8+43Dqwg
 aQt1SjyXG1PW0kJYhQbcETU2l4jkCi+gPtDPWnPa1OdnOqa6/fMutSHyIwKlHY2aMHkz
 5c/8nykpstQaytMhtNIVCcEUX477pHGOrvNlx6wm4neE+4qn8THrvQzZiX6DADEVoHzN
 gLUSDUwqFEBkwSFlBgpFCbAkIU8zcLeJd+HKyy2qsHLoSZvA4OXlFqsKCIGy0KJc792e
 LYgkVHzo3+JYfE1L+6qC1tVvRiScRM3m7hwRMpe72qz8V3yjCukH01tJjDBWvcCD4bnN
 ILYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=ti9yXoRVYSbU3lnCHfDJy3KSsIWSbEVNqPE18S19cuA=;
 b=QLqnXo7NGul1xo1LvxSXDCfEuHHPPabnJIcs/bWRg2KfopHRhmfANyoEsbvQvsH/6X
 NLUFYP9sOFxpzGabtK+njlhyRjuePbvAhX1UJYVehWDFUBzbzutYCUTTAipKsMJrMjdA
 gLS14adxEgia7OPf9CEVbAIXzzuaaXCtNI65g4NYTuqN3v8bahpyuRLSB6koiiRXMBcZ
 5UkrKg1/aR6iz3vhZJJdxLXh9v7C03UpQI0Nry4VsmjTi9Og/uLKx3QSXTwQS9b2rufX
 Pk4t0pqa08rajw9O5H53e9NBzh68nMjnvLxjxIOYwRFfHvufNFMe6EW2vMa3VifHGtO4
 8nkg==
X-Gm-Message-State: ANhLgQ3JWb8v9egMji6jrrEBs8oA/3EAm8N5caRbDlcgHSzO6DdjoLBN
 Pz1SaZPzpbBieIbgRFqiYb/Vhg==
X-Google-Smtp-Source: ADFU+vsD7mexY3fuWO9RDMDsARNlpQPWv0gp7Nc1oiYnutmm1wMFoxjhEtag0y3u9dsrgjXXnHhhZw==
X-Received: by 2002:a05:6a00:2b7:: with SMTP id
 q23mr1555234pfs.43.1583196585979; 
 Mon, 02 Mar 2020 16:49:45 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id m16sm21984682pfh.60.2020.03.02.16.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 16:49:45 -0800 (PST)
Subject: [PULL 27/38] target/riscv: Mark both sstatus and msstatus_hs as dirty
Date: Mon,  2 Mar 2020 16:48:37 -0800
Message-Id: <20200303004848.136788-28-palmerdabbelt@google.com>
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
X-Received-From: 2607:f8b0:4864:20::441
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

Mark both sstatus and vsstatus as dirty (3).

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/translate.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index eff064dc44..3ce86adb89 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -44,6 +44,8 @@ typedef struct DisasContext {
     /* pc_succ_insn points to the instruction following base.pc_next */
     target_ulong pc_succ_insn;
     target_ulong priv_ver;
+    bool virt_enabled;
+    uint32_t opcode;
     uint32_t mstatus_fs;
     uint32_t misa;
     uint32_t mem_idx;
@@ -395,6 +397,12 @@ static void mark_fs_dirty(DisasContext *ctx)
     tcg_gen_ld_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus));
     tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS | MSTATUS_SD);
     tcg_gen_st_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus));
+
+    if (ctx->virt_enabled) {
+        tcg_gen_ld_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus_hs));
+        tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS | MSTATUS_SD);
+        tcg_gen_st_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus_hs));
+    }
     tcg_temp_free(tmp);
 }
 #else
@@ -742,6 +750,11 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->mem_idx = ctx->base.tb->flags & TB_FLAGS_MMU_MASK;
     ctx->mstatus_fs = ctx->base.tb->flags & TB_FLAGS_MSTATUS_FS;
     ctx->priv_ver = env->priv_ver;
+#if !defined(CONFIG_USER_ONLY)
+    ctx->virt_enabled = riscv_cpu_virt_enabled(env);
+#else
+    ctx->virt_enabled = false;
+#endif
     ctx->misa = env->misa;
     ctx->frm = -1;  /* unknown rounding mode */
     ctx->ext_ifencei = cpu->cfg.ext_ifencei;
-- 
2.25.0.265.gbab2e86ba0-goog


