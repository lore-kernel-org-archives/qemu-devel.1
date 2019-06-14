Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40325C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9F1D2177E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ilfphwh7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F1D2177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51864 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbmtX-0007UQ-Ob
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 10:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50888)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vandersonmr2@gmail.com>) id 1hbmey-0003Dh-5X
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1hbmew-0007xm-LN
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:54:28 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:37539)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1hbmew-0007xI-HG
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:54:26 -0400
Received: by mail-qk1-x741.google.com with SMTP id d15so1703457qkl.4
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 06:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IkKggjJFmzSiJ4uZvBdZPk5OGuw0OM24o79Ww5vmA0s=;
 b=Ilfphwh7W0bSCbz3HEE5Ig/H+sPpb7x2Wg2TAKIKuPmF4xtXimH5yuMYHLi4u9cPF3
 ApIm3jpHXDxRUkizDFnpok/EVWoYmVAzpQaAu2zbxnt24KFHxfi9sHb5nC9cdGs3xfpN
 lstxiTcPG9wxI3WxrY5HXm671Sa50zGYySXvFhKQIBjz3YL/XDa5dTvFqUI+MsdGPnUU
 Lx4ithhhSznK/wT+VIOQ7T+45BKZESlWsw6x4/RfegBLA/64jW8A8Vqczhb2iF/fJ3wN
 Px1c1ICSYjSaE8Qgg/FGE+O0foCR6E+wNNG2mYLlj6Pp1r3mS/cSj/wMY/70AmWUSvw8
 GS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IkKggjJFmzSiJ4uZvBdZPk5OGuw0OM24o79Ww5vmA0s=;
 b=h9/qH8+2RAx55ClsMwZHeJuz/CFLxRgQZwvjBWTh7YTpJHkf7YCtDJF1welwOHO9e2
 pcAl0Gqh9T3U/dzgwoQ/xG2JPRlv8qcPOtD4wpUKM0gKv8FR1fMuRYVoRgyKaJuZaKIx
 ya+6IvJhvV1u6xYTZ8eqLoy1yX6HXr9N7RG2fTzUzl9GUHIv1iya1Hzt+1bR7LRKctSs
 0JtXNhDdZRdqMErwOoip5giYKjYIB5iv3bjHdoY/0M24QSO70b+l1xx57jlXn0yBu6Ty
 HbElqWyIXk4IQPflxJtO5J9o7KHQUNCIIPYQtYGc7U2vHqNsYnk8VrnKjKFMmkhYSr0K
 yKNw==
X-Gm-Message-State: APjAAAXkfA2AdWgVSc5mQhuF4H3dX48Zdrm6yXtctMkAhd0DlVngZVJZ
 VzjKYetcHdsOTZos7TbhOZiRreRvmWU=
X-Google-Smtp-Source: APXvYqyIYknesP7N2pux79oTWlaO0jCG3TpBqLi3gVCa1uVDxHqx/XVmN8zDqjeDFR9whNADYAuOeg==
X-Received: by 2002:a37:9c50:: with SMTP id f77mr76429450qke.6.1560520465756; 
 Fri, 14 Jun 2019 06:54:25 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f4:548c:f96b:4e5b:86ef:e7bc:c1a0])
 by smtp.googlemail.com with ESMTPSA id 77sm1747150qkd.59.2019.06.14.06.54.23
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 06:54:25 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 10:53:29 -0300
Message-Id: <20190614135332.12777-2-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190614135332.12777-1-vandersonmr2@gmail.com>
References: <20190614135332.12777-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
Subject: [Qemu-devel] [Qemu-Devel][PATCH 1/3] Adding an optional tb
 execution counter.
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 vandersonmr <vandersonmr2@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

An uint64_t counter was added in the TranslationBlock struct and
it is incremented every time that the TB is executed.

Signed-off-by: vandersonmr <vandersonmr2@gmail.com>
---
 accel/tcg/tcg-runtime.c   | 6 ++++++
 accel/tcg/tcg-runtime.h   | 2 ++
 include/exec/exec-all.h   | 1 +
 include/exec/gen-icount.h | 7 +++++++
 linux-user/main.c         | 1 +
 vl.c                      | 1 +
 6 files changed, 18 insertions(+)

diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 8a1e408e31..d1f4127d31 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -167,3 +167,9 @@ void HELPER(exit_atomic)(CPUArchState *env)
 {
     cpu_loop_exit_atomic(env_cpu(env), GETPC());
 }
+
+void HELPER(inc_exec_freq)(void *ptr)
+{
+    TranslationBlock* tb = (TranslationBlock*) ptr;
+    atomic_inc(&tb->exec_freq);
+}
diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 4fa61b49b4..bf0b75dbe8 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -28,6 +28,8 @@ DEF_HELPER_FLAGS_1(lookup_tb_ptr, TCG_CALL_NO_WG_SE, ptr, env)
 
 DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
 
+DEF_HELPER_FLAGS_1(inc_exec_freq, TCG_CALL_NO_RWG, void, ptr)
+
 #ifdef CONFIG_SOFTMMU
 
 DEF_HELPER_FLAGS_5(atomic_cmpxchgb, TCG_CALL_NO_WG,
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 16034ee651..a80407622e 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -342,6 +342,7 @@ struct TranslationBlock {
     uint32_t flags; /* flags defining in which context the code was generated */
     uint16_t size;      /* size of target code for this block (1 <=
                            size <= TARGET_PAGE_SIZE) */
+    uint64_t exec_freq;
     uint16_t icount;
     uint32_t cflags;    /* compile flags */
 #define CF_COUNT_MASK  0x00007fff
diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index f7669b6841..a540d12005 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -6,11 +6,18 @@
 /* Helpers for instruction counting code generation.  */
 
 static TCGOp *icount_start_insn;
+extern bool enable_freq_count;
 
 static inline void gen_tb_start(TranslationBlock *tb)
 {
     TCGv_i32 count, imm;
 
+    if (enable_freq_count) {
+        TCGv_ptr tb_ptr = tcg_temp_new_ptr();
+        tcg_gen_trunc_i64_ptr(tb_ptr, tcg_const_i64((int64_t) tb));
+        gen_helper_inc_exec_freq(tb_ptr);
+    }
+
     tcg_ctx->exitreq_label = gen_new_label();
     if (tb_cflags(tb) & CF_USE_ICOUNT) {
         count = tcg_temp_local_new_i32();
diff --git a/linux-user/main.c b/linux-user/main.c
index a59ae9439d..1bf7155670 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -58,6 +58,7 @@ static const char *seed_optarg;
 unsigned long mmap_min_addr;
 unsigned long guest_base;
 int have_guest_base;
+bool enable_freq_count = false;
 
 /*
  * When running 32-on-64 we should make sure we can fit all of the possible
diff --git a/vl.c b/vl.c
index 005468cbfb..cb6c0ad63d 100644
--- a/vl.c
+++ b/vl.c
@@ -190,6 +190,7 @@ bool boot_strict;
 uint8_t *boot_splash_filedata;
 int only_migratable; /* turn it off unless user states otherwise */
 bool wakeup_suspend_enabled;
+bool enable_freq_count = false;
 
 int icount_align_option;
 
-- 
2.22.0


