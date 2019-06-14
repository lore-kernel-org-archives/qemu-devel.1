Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B2EC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:16:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D31902177E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VwqLkXGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D31902177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54028 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbqk5-0007IO-0H
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 14:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34169)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbq0P-000799-S6
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbq0N-00049I-CX
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:48 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40095)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbq0L-0003t7-TX
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:46 -0400
Received: by mail-wr1-x444.google.com with SMTP id p11so3359786wre.7
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1Ghk3o46eKDRyTTJB5656nYsZZ0fzl1fP3AqjgtBmAI=;
 b=VwqLkXGRUWthSaVtjmb+jBib3TYQEhx3Q5ObYEZ1DabiVFTKIrjtG//tVzbxb7y3QZ
 2PVeAGWCFBZX2Er7RmvQ1wLpOOzB1oUkkeR5eaClhp6wllhEkBUrLn99hD6liUL406Iq
 hftSp4SmKu7ogJI+OEjsPvE7UzA2GANKkn1cGQt9XieD7V6JIgB/kK5NuzHKL0pU6zCy
 bzokDUlBi756iZHs4+Zw5Rrfnl72hqRkPK9Kw4AZDXLRWfG9COZwvzU0fALvEQLR1hRd
 AMHH100a9hMiFdOu2pcn3QM+C9upgoeWZrwbHWhbf8zvqm7UBxFbdN2N9bE9VH5cyeqn
 vrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1Ghk3o46eKDRyTTJB5656nYsZZ0fzl1fP3AqjgtBmAI=;
 b=leOyu1Ekro3Q+XT6lpHW69Oz+2muGY5p6RVvkkWYNZMR5NHstYijAvxYuw28L8xBFQ
 wkSmWa66RiuW7s6F4YPTQMR49SGZu7J2FoVxQTcD3EFXEW6fI2idjbMXYDZj1deg/7d6
 f25J8+CTnRV0JGgaH/OJ0DJeKNElONO/Hz93RG+gi2MbTM1mTx34aXKj9Yc5JbjqOnpM
 Ap0Hfc8yme4+LQ7D+AnfujIVGMoPzWOUIF0ehi2XLRLP2MY42dukarUkFH7BnfKjnqd9
 3r48oOf6svHrQbCH+RgcyaEBts/2Q/Q7YA3+A6Zsrm96uY6vrXtLSu/fblg/cXIH+QqH
 9RNg==
X-Gm-Message-State: APjAAAVYDkDR7jWpxyyGM1B/C55D0FBD/Y6JJ5/AOKXrLejumdArvdsl
 51p36Xjpl9Ka7409RSPq6RnRoA==
X-Google-Smtp-Source: APXvYqzzQ7cXCS4nXhvB5Qq3IMEDWXfcw67SDCbLhV4Ypg0poPRwTgouammHwcQ1KCHecq62LJaQ1w==
X-Received: by 2002:a5d:5283:: with SMTP id c3mr35035556wrv.268.1560533314954; 
 Fri, 14 Jun 2019 10:28:34 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id j7sm4655451wru.54.2019.06.14.10.28.29
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:28:30 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BB9AC1FFBC;
 Fri, 14 Jun 2019 18:12:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:47 +0100
Message-Id: <20190614171200.21078-38-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v3 37/50] translator: inject instrumentation
 from plugins
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/translator.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 9226a348a3..161b494a54 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -16,6 +16,7 @@
 #include "exec/gen-icount.h"
 #include "exec/log.h"
 #include "exec/translator.h"
+#include "exec/plugin-gen.h"
 
 /* Pairs with tcg_clear_temp_count.
    To be called by #TranslatorOps.{translate_insn,tb_stop} if
@@ -34,6 +35,7 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
                      CPUState *cpu, TranslationBlock *tb, int max_insns)
 {
     int bp_insn = 0;
+    bool plugin_enabled;
 
     /* Initialize DisasContext */
     db->tb = tb;
@@ -55,11 +57,17 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
     ops->tb_start(db, cpu);
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
+    plugin_enabled = plugin_gen_tb_start(cpu, tb);
+
     while (true) {
         db->num_insns++;
         ops->insn_start(db, cpu);
         tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
+        if (plugin_enabled) {
+            plugin_gen_insn_start(cpu, db);
+        }
+
         /* Pass breakpoint hits to target for further processing */
         if (!db->singlestep_enabled
             && unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
@@ -95,6 +103,10 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
             ops->translate_insn(db, cpu);
         }
 
+        if (plugin_enabled) {
+            plugin_gen_insn_end();
+        }
+
         /* Stop translation if translate_insn so indicated.  */
         if (db->is_jmp != DISAS_NEXT) {
             break;
@@ -112,6 +124,10 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
     ops->tb_stop(db, cpu);
     gen_tb_end(db->tb, db->num_insns - bp_insn);
 
+    if (plugin_enabled) {
+        plugin_gen_tb_end(cpu);
+    }
+
     /* The disas_log hook may use these values rather than recompute.  */
     db->tb->size = db->pc_next - db->pc_first;
     db->tb->icount = db->num_insns;
-- 
2.20.1


