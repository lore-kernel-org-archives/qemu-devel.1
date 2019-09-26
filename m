Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91309C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:46:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61389222C7
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XJB2g+VF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61389222C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDWu1-0004FU-0A
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 12:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41085)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWc2-0002Xe-Od
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWc0-0004dM-RW
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:26 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:41718)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDWc0-0004bL-Mi
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:24 -0400
Received: by mail-pl1-f178.google.com with SMTP id t10so1269113plr.8
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 09:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=X68WYJNDZTpdyZHdw4ksbcmmhr58PDv2+uW7j7e+gP8=;
 b=XJB2g+VF0rzzwBV2LXcfBXwIqKmcPwQDj1TYkOSySgHG0HHScrPBkJZ9awJpaNpPmG
 P/esdKL7Oe2YLGgG6cQkIiGtAYigJogPWTwvGg9fbYlctvjKsJfOtCR5Wpbxdo/0p6YM
 BmCHRbAN1tTrgj0AhHnZ1aplNInSoNz+DUQUrVmGrCyPAzoqIAFNpMTvu5/sPl5dS//M
 v/W8q19HgNQUhtGKY+Co7YqByBC7qMxhwwx4SV041bmh3Awv30hapFCpw+EpmSqpP4x6
 NF4edYJj7n7Vezq1ZJ8Abq4k3pzuUyIAG1M4TZIzreOsndouKFrgmdHs8h2dyy8wamUI
 nmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=X68WYJNDZTpdyZHdw4ksbcmmhr58PDv2+uW7j7e+gP8=;
 b=Uxifj8NtHZVrC0XbsVXGgqadznEY6ISrWBqusHoIVwLToUyKCGSzvZvDy1/5yuJxis
 HCU/pPHYX/CAmwFZCpqziyvmUnpVz99h/fQenxNMj+ekN4Dmhp3mGwjkLxMHl5JCJWV2
 gE5MbggFLJ52zrO325Jb6OT5nZAPYSV8gQdJIEzejCaVmesc2lqYHgZZblnDsKA+6ZB5
 zShwjTSby1uRe5sIQ2ogVZPiJmfrsgc2vgRDK+DFgr0DAYcP7MGhUxMkB8TgwkvwhFm2
 xHwvlSNCyh1fZfkMMsuKkmOszOgGddT+cakq7LYw/seoHIU396dg0musqShehrK9de8d
 cFLg==
X-Gm-Message-State: APjAAAXZ1S7JDQBv+Rzv9h7cpbu3rF64K/wBijO9aojY7cPzoqGT4b4l
 hWdc9iho475dbTtHRVV/8c7jgT971/E=
X-Google-Smtp-Source: APXvYqx9Aaozj1pNPm08+Oqab3ml+BOjUEJu0eOX65N/SBzMsypX7N/3sh8Ij/MQds9hN87b4tAsgg==
X-Received: by 2002:a17:902:690a:: with SMTP id
 j10mr1391112plk.155.1569515181415; 
 Thu, 26 Sep 2019 09:26:21 -0700 (PDT)
Received: from localhost.localdomain ([12.157.10.114])
 by smtp.gmail.com with ESMTPSA id 64sm4453169pfx.31.2019.09.26.09.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 09:26:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/18] target/s390x: Add ilen to unwind data
Date: Thu, 26 Sep 2019 09:25:59 -0700
Message-Id: <20190926162615.31168-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926162615.31168-1-richard.henderson@linaro.org>
References: <20190926162615.31168-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.178
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
Cc: qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <rth@twiddle.net>

Use ILEN_UNWIND to signal that we have in fact that
cpu_restore_state will have been called by the time
we arrive in do_program_interrupt.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/cpu.h       |  4 +++-
 target/s390x/interrupt.c |  5 ++++-
 target/s390x/translate.c | 21 ++++++++++++++++++---
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index ce20dafd23..080ebcd6bb 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -30,7 +30,7 @@
 /* The z/Architecture has a strong memory model with some store-after-load re-ordering */
 #define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
 
-#define TARGET_INSN_START_EXTRA_WORDS 1
+#define TARGET_INSN_START_EXTRA_WORDS 2
 
 #define MMU_MODE0_SUFFIX _primary
 #define MMU_MODE1_SUFFIX _secondary
@@ -814,6 +814,8 @@ int cpu_s390x_signal_handler(int host_signum, void *pinfo, void *puc);
 void s390_crw_mchk(void);
 void s390_io_interrupt(uint16_t subchannel_id, uint16_t subchannel_nr,
                        uint32_t io_int_parm, uint32_t io_int_word);
+/* instruction length set by unwind info */
+#define ILEN_UNWIND                 0
 /* automatically detect the instruction length */
 #define ILEN_AUTO                   0xff
 #define RA_IGNORED                  0
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index a841f7187d..30a9fb8852 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -28,7 +28,10 @@ void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen)
 
     cs->exception_index = EXCP_PGM;
     env->int_pgm_code = code;
-    env->int_pgm_ilen = ilen;
+    /* If ILEN_UNWIND, int_pgm_ilen already has the correct value.  */
+    if (ilen != ILEN_UNWIND) {
+        env->int_pgm_ilen = ilen;
+    }
 }
 
 void s390_program_interrupt(CPUS390XState *env, uint32_t code, int ilen,
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index e1c54ab03b..08f99454de 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -6309,6 +6309,9 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
     /* Search for the insn in the table.  */
     insn = extract_insn(env, s, &f);
 
+    /* Emit insn_start now that we know the ILEN.  */
+    tcg_gen_insn_start(s->base.pc_next, s->cc_op, s->ilen);
+
     /* Not found means unimplemented/illegal opcode.  */
     if (insn == NULL) {
         qemu_log_mask(LOG_UNIMP, "unimplemented opcode 0x%02x%02x\n",
@@ -6457,9 +6460,6 @@ static void s390x_tr_tb_start(DisasContextBase *db, CPUState *cs)
 
 static void s390x_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 {
-    DisasContext *dc = container_of(dcbase, DisasContext, base);
-
-    tcg_gen_insn_start(dc->base.pc_next, dc->cc_op);
 }
 
 static bool s390x_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
@@ -6467,6 +6467,12 @@ static bool s390x_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
+    /*
+     * Emit an insn_start to accompany the breakpoint exception.
+     * The ILEN value is a dummy, since we didn't actually read an insn.
+     */
+    tcg_gen_insn_start(dc->base.pc_next, dc->cc_op, 0);
+
     dc->base.is_jmp = DISAS_PC_STALE;
     dc->do_debug = true;
     /* The address covered by the breakpoint must be included in
@@ -6561,8 +6567,17 @@ void restore_state_to_opc(CPUS390XState *env, TranslationBlock *tb,
                           target_ulong *data)
 {
     int cc_op = data[1];
+    int ilen = data[2];
+
     env->psw.addr = data[0];
+
+    /* Update the CC opcode if it is not already up-to-date.  */
     if ((cc_op != CC_OP_DYNAMIC) && (cc_op != CC_OP_STATIC)) {
         env->cc_op = cc_op;
     }
+
+    /* Update ILEN, except for breakpoint, where we didn't load an insn.  */
+    if (ilen) {
+        env->int_pgm_ilen = ilen;
+    }
 }
-- 
2.17.1


