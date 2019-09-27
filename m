Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFABC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:45:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B63020863
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bARj/F15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B63020863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDwBF-0000bi-83
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 15:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw5W-000391-LO
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw5V-0006BL-8G
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:34 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:39940)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDw5V-0006Ay-2C
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:33 -0400
Received: by mail-pg1-x52a.google.com with SMTP id w10so4002787pgj.7
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 12:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=w2Q9PJQfueojRR+QKppS6QU37PaRJeAezOuF/SJtJSk=;
 b=bARj/F152KNyjvJ9HpAQMsNuD8coka1Aqez1QksdNMkKVM9LEVJJjQ0fgdP3uRQ0WO
 zJ1f4Ksi7g+R9rnzz8J8NAvRfFzMZxkUw4Gl4BwfgMsCt9aaa7pHdOZplD8mJUnxzW5o
 4TqLfHpPT0L+JEB+km5PgSl80Pix278710A16a8XswxyAT/a8rfB/LyZVolFeX3F7VR1
 GqZ7zthy17FAgRlPEpUNvsbPpqlOD1uMuclzwZSgEDNyufx8IhtacCCAXpBPzK+tQRqQ
 /NM26OhND6/vUjByRvN/OFU68a4Dspef2GWORmlwMYMGbKrfF85vIO2up+6XOTqgmQ0i
 /40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=w2Q9PJQfueojRR+QKppS6QU37PaRJeAezOuF/SJtJSk=;
 b=n8yhx9WTLxQJ9+8ojyHCWRqCka5ss+JOwxRnbtAOHXekm2PQS2GplhNEBPl5P8anhI
 x7duNe9GkXo1TTQd7CtcKuXSglvbFKf25SMRGAUuJYadDWBKxlAH3KmciXLsDSK9Mdxm
 5f4ZDFInMIayv5gd95xGsahji/B0CvEw1QHgANH+WjTX2vou9v/PpaEZelzQMKrM8N0C
 jSj82ai18VRt8+FZLHNxpWDEGZWdoKclFR5/garFZhAwovAK58gkSBW1aMKIK7jZZfRk
 pMx9zmreHaru+Oli9gT8kI9ZEIU2Iik9Al/yqZQTALqmgWhlecRLmrtroMy3PlqSibom
 hdiQ==
X-Gm-Message-State: APjAAAXIkwMaMviI4adVZU3kerul0JnBlRMqjIpLAXgRMIy5mX/eSsuB
 ER/izDK82KEGEsMP21DcAQpuQOOHQ1s=
X-Google-Smtp-Source: APXvYqypAM5/JCXubU4AD1mP6sCaptS5ItHMD29GAn3PlqOjr+01s5KNTIv+WCENQeyouSEhCnCkwA==
X-Received: by 2002:a62:64ca:: with SMTP id y193mr6380720pfb.164.1569613171657; 
 Fri, 27 Sep 2019 12:39:31 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.62])
 by smtp.gmail.com with ESMTPSA id 192sm3676403pfb.110.2019.09.27.12.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2019 12:39:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 01/18] target/s390x: Add ilen to unwind data
Date: Fri, 27 Sep 2019 12:39:08 -0700
Message-Id: <20190927193925.23567-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927193925.23567-1-richard.henderson@linaro.org>
References: <20190927193925.23567-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52a
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

Use ILEN_UNWIND to signal that we have in fact that cpu_restore_state
will have been called by the time we arrive in do_program_interrupt.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/cpu.h       |  4 +++-
 target/s390x/interrupt.c |  5 ++++-
 target/s390x/translate.c | 20 +++++++++++++++++---
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 1996f44baa..b7d408bf81 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -30,7 +30,7 @@
 /* The z/Architecture has a strong memory model with some store-after-load re-ordering */
 #define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
 
-#define TARGET_INSN_START_EXTRA_WORDS 1
+#define TARGET_INSN_START_EXTRA_WORDS 2
 
 #define MMU_MODE0_SUFFIX _primary
 #define MMU_MODE1_SUFFIX _secondary
@@ -803,6 +803,8 @@ int cpu_s390x_signal_handler(int host_signum, void *pinfo, void *puc);
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
index a3e43ff9ec..151dfa91fb 100644
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
@@ -6463,9 +6466,6 @@ static void s390x_tr_tb_start(DisasContextBase *db, CPUState *cs)
 
 static void s390x_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 {
-    DisasContext *dc = container_of(dcbase, DisasContext, base);
-
-    tcg_gen_insn_start(dc->base.pc_next, dc->cc_op);
 }
 
 static bool s390x_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
@@ -6473,6 +6473,14 @@ static bool s390x_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
+    /*
+     * Emit an insn_start to accompany the breakpoint exception.
+     * The ILEN value is a dummy, since this does not result in
+     * an s390x exception, but an internal qemu exception which
+     * brings us back to interact with the gdbstub.
+     */
+    tcg_gen_insn_start(dc->base.pc_next, dc->cc_op, 2);
+
     dc->base.is_jmp = DISAS_PC_STALE;
     dc->do_debug = true;
     /* The address covered by the breakpoint must be included in
@@ -6567,8 +6575,14 @@ void restore_state_to_opc(CPUS390XState *env, TranslationBlock *tb,
                           target_ulong *data)
 {
     int cc_op = data[1];
+
     env->psw.addr = data[0];
+
+    /* Update the CC opcode if it is not already up-to-date.  */
     if ((cc_op != CC_OP_DYNAMIC) && (cc_op != CC_OP_STATIC)) {
         env->cc_op = cc_op;
     }
+
+    /* Record ILEN.  */
+    env->int_pgm_ilen = data[2];
 }
-- 
2.17.1


