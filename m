Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F7DC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:19:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C20CC206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="awe2Z7+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20CC206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrJr-0005DW-3K
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42328)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrG5-0005pP-OK
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrG3-00048O-Od
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:21 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36708)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsrG1-00046M-Mj
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:17 -0400
Received: by mail-wr1-x442.google.com with SMTP id n4so70412820wrs.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NeBjS48hgLPnN+/FAA6/R9TYKzQRsPV0AVfEZ4tlPs0=;
 b=awe2Z7+UteZ1OleIoymnp2TEcFmXxOeCtR8TTDIqq3AsphDj/P1onA61KvN9yMF7Sc
 qAsURm5ljRnRGJmUorKK3GksZ2rOSvkUFREGrg1G5a8hUDSyX7Hqu4MWJ3C/5vRifr1g
 vAN2X8rNbVYxGooWneSnVlR5d8YUNV0xq1qGRe9SdBm9r2CEgJNHbzl+DPkkGlvJvnA3
 Qw747TQcSDd+wp7rk25MdhzuYQqLArUaT0URpXn1LIebxTvasytbyL50Lxsu+CcYVLHq
 R5VLliTFFiuGsA84SVOcHX8ixhhjU8NSUneqfcHiVu1ldVnfpROHW2FQdhA2IipWTWn8
 EitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NeBjS48hgLPnN+/FAA6/R9TYKzQRsPV0AVfEZ4tlPs0=;
 b=gw/yo1bApCfMtQTDFWZXs8eINRKG/qBHsFqS7QL2ImGeRdwN52U2ovKmlKKISSIjKT
 2aOYrIHwBWagSHqBxpR+vTDedWZFHQTiyiWWFA5V35z2TAraIEuIWyDfEQxkSPt3Mjgl
 hWf5Rfj8S6YYUs7HIMPFvMb24aSX6m77aJOR006KnQ1O6j0+qiWHCe07mYYPTKyjpScK
 e6f8Gdnr5v7MxU9FmqkXyU2Bav/Dwr6sPLpVSk3v4TXEmNdIJhMv/Kx8sSvk9x9QESYu
 rwP8R5w6eI8UkKH1R+FsPnWsDRXMn+UGVGdQhUIuZan/K7eQx6NKG1px8wLJaZIICNnx
 H43Q==
X-Gm-Message-State: APjAAAUtTpSHElD0go5uMEitePTxy8GgPmn5GCPYosLFrZTuJWJz0Aw/
 bV2WVTPFlBhmscO76EX3dnBDug==
X-Google-Smtp-Source: APXvYqxEhzihtvLD7CSapmPIv8LnuLqDPPqlA+/iYYKcJM4As1ZlqIbhZw0Qf4ZxROfdFYtyhjlApw==
X-Received: by 2002:a5d:50d1:: with SMTP id f17mr4932906wrt.124.1564589715274; 
 Wed, 31 Jul 2019 09:15:15 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id x6sm71886710wrt.63.2019.07.31.09.15.12
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:15:13 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5D2141FFC0;
 Wed, 31 Jul 2019 17:07:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:07:07 +0100
Message-Id: <20190731160719.11396-43-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v4 42/54] translator: inject instrumentation
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
Cc: aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, bobby.prani@gmail.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v4
  - note we can't inject instrumentation if ! DISAS_NEXT
---
 accel/tcg/translator.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 9226a348a39..4e30772f8cb 100644
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
@@ -100,6 +108,14 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
             break;
         }
 
+        /*
+         * We can't instrument after instructions that change control
+         * flow although this only really affects post-load operations.
+         */
+        if (plugin_enabled) {
+            plugin_gen_insn_end();
+        }
+
         /* Stop translation if the output buffer is full,
            or we have executed all of the allowed instructions.  */
         if (tcg_op_buf_full() || db->num_insns >= db->max_insns) {
@@ -112,6 +128,10 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
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


