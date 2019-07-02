Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B73EC06511
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 21:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1235218B8
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 21:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcNHb2w1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1235218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiPyO-00011a-4m
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 17:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44417)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vandersonmr2@gmail.com>) id 1hiPuL-0007Vz-68
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 17:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1hiPuE-0002zy-HG
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 17:01:44 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:38216)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1hiPuE-0002Xh-1r
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 17:01:38 -0400
Received: by mail-qk1-x743.google.com with SMTP id a27so15604569qkk.5
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 14:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wUVvSuAydlgvXJuQw+GCshpjlS1a2UQrLkK7/UPp+iI=;
 b=VcNHb2w1PEaMoirg3Bf2i99+L9Gu96RqmA76JTi4QX9tGEZ128tBRq/wqiiES7qVMl
 nZNSddhfLk0bIp6wGCCN0MdR3Gi+SDjt8YYtUZOZzYLbHTrwVxl8GLE01HTpxclAn2aA
 Q66XCXw7ViJfud5USV11y9K2+ZauJ1EPaAR0V+yF9vapQceg3pKc6/gPx+CDpJJ4L62a
 h1933yCghqjVEgtGuflB1NZ6qEj1N5HJkc/qn54vUaUcv7u2KyB+cFpa00P4Hyqs33jo
 uMLpyYMDChYIX4MaMxp4oIukBYrfbJ79MMMgh8/Up/VT51ihnMij8a9Bx02RBrrs2HCR
 tK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wUVvSuAydlgvXJuQw+GCshpjlS1a2UQrLkK7/UPp+iI=;
 b=idMj2Gs8bK1p8y1bTODxN2wN2bacO+A4rFXW8hWKC29KNwWdt5tTOquy735UsqUnc6
 Z6ClQKH8rU9F0tm+oD6y5LWb0XA1maQQOrXwy0GrGTbORzlWRpMlRajNQmvOoJ7uOznc
 NSufpl+JLQvNMiNR2DnqrX8rFm+fpjYCpOY0rrWwkfN9HFNcZlBCYcLB1rKtD+qWR9Ta
 VX38pn1G7RlreHsCr6AXKn0MfNFCIHIf2fLbVOPh86uujkr/BLJw9x9U1376jPEOOApl
 bLsjawOZ6pRa2haP6otUo8y4K5pD1tkl4fQCWRGiQPNODnr6Hx2IJb/f+HAiid6FNr/D
 Grhg==
X-Gm-Message-State: APjAAAUpep9STYapuwBWqqKP/4uCIbXhSRNjGxHXFAIPRQ3hq1v0dnQm
 IxG+TCzNGUh7Snw9WNFco2BXdG58
X-Google-Smtp-Source: APXvYqwtabvFHPhWgiqzMnEw1Zcnnt2coXH0YgCF4lePqH7WJxxBNYm7xcQ4ON2H6vcl1JEcVhG9cg==
X-Received: by 2002:a37:404b:: with SMTP id n72mr19051020qka.109.1562101249785; 
 Tue, 02 Jul 2019 14:00:49 -0700 (PDT)
Received: from vanderson-lmcad.HotSpot300 ([189.61.239.22])
 by smtp.googlemail.com with ESMTPSA id
 s127sm6770979qkd.107.2019.07.02.14.00.48
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 02 Jul 2019 14:00:49 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 18:00:13 -0300
Message-Id: <20190702210017.4275-2-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702210017.4275-1-vandersonmr2@gmail.com>
References: <20190702210017.4275-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
Subject: [Qemu-devel] [PATCH v3 2/6] accel/tcg: Adding an optional tb
 execution counter
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, vandersonmr <vandersonmr2@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We add the option to instrument each TB to
count the number of times it is executed and
store this in the its TBStatistics struct.

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
---
 accel/tcg/tcg-runtime.c   | 7 +++++++
 accel/tcg/tcg-runtime.h   | 2 ++
 accel/tcg/translator.c    | 1 +
 include/exec/gen-icount.h | 9 +++++++++
 4 files changed, 19 insertions(+)

diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 8a1e408e31..f332eae334 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -167,3 +167,10 @@ void HELPER(exit_atomic)(CPUArchState *env)
 {
     cpu_loop_exit_atomic(env_cpu(env), GETPC());
 }
+
+void HELPER(inc_exec_freq)(void *ptr)
+{
+    TBStatistics *stats = (TBStatistics *) ptr;
+    g_assert(stats);
+    atomic_inc(&stats->executions.total);
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
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 9226a348a3..cc06070e7e 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -54,6 +54,7 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
     gen_tb_start(db->tb);
     ops->tb_start(db, cpu);
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
+    gen_tb_exec_count(tb);
 
     while (true) {
         db->num_insns++;
diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index f7669b6841..6701ab70c0 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -7,6 +7,15 @@
 
 static TCGOp *icount_start_insn;
 
+static inline void gen_tb_exec_count(TranslationBlock *tb)
+{
+    if (qemu_loglevel_mask(CPU_LOG_HOT_TBS) && tb->tb_stats) {
+        TCGv_ptr ptr = tcg_const_ptr(tb->tb_stats);
+        gen_helper_inc_exec_freq(ptr);
+        tcg_temp_free_ptr(ptr);
+    }
+}
+
 static inline void gen_tb_start(TranslationBlock *tb)
 {
     TCGv_i32 count, imm;
-- 
2.22.0


