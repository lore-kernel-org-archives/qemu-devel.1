Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D64CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:39:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4C4420867
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NbHuFF+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C4420867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNuBx-0004M0-OF
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtpx-0004dJ-GL
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtpw-0007Cq-3L
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:41 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:39306)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtpv-0007C4-Sx
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:40 -0400
Received: by mail-wr1-x42b.google.com with SMTP id a11so1028015wra.6
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 00:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=avDcFa6vNjqfkFm9Eh7Mdg86NxTMA5t/4HoZgIMcBpg=;
 b=NbHuFF+ghhkCeBnDkW5o4yXAtJTkfu5Mz1Pi6zikfUp6Pq+XwIRNb7T39SbuUQOHi9
 W/I94CSKVORkaYaf2oJbKpJ3GHG2EwZzEm7TlxT2EElAfE10cvvHEOGFPGJuqyr/SGSJ
 +U/BYJPNrPBBGR2iO4MhfoqXbyoXjBGa215puULkSCchjWr53z74o0NG/IZfY8yEwjmF
 0hV/RVbRQc+nrDTaXnrk2QlzdDAJWlMaMED2S3qd67GdkdSB8z45bETLCbPduwge0i2W
 WPUVQ5e88jsRQTVWQhqsncOb/9E4w2JJjHr6qAHN/PmY9yA0OEt+wltjaGkNsospMK0x
 lvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=avDcFa6vNjqfkFm9Eh7Mdg86NxTMA5t/4HoZgIMcBpg=;
 b=AQiplSpzI7giXeQNdUn5e8UD/aYY+Xobw0gjONkc9kWCFQ7DbatS+WpVyE0CpLIull
 6rwVWF3CradWoIXbcXHA37s3WL31o1Kt1IAxYXRFa1b9/mAO1O6lm+Omm6OTbn0ataYO
 dkgHhOITFmQXDn6TzUh4zALShH1zCuCxTi5O8EnVQxiBkvIK3zVRkZZEt44hzcAFg0dV
 LOFCxODyWtmAZTJ7sqzNOtf4LOyMTvttQyEZptGcLxNXU2qUSBG3sLanEk7jjCuyfqvW
 XnUHCquZlJT4gw/FPRUpVbrwPQV1Q/pVmGPqd1uVggSshd/RT7z4TwcmhnX8hfCQl9P4
 yJCQ==
X-Gm-Message-State: APjAAAW5xhIQ4mHQMajem0YfZiwi/SoWNTKAr+apvq3/gaxD6Gn9m3c7
 /CHaVO2Lq7RsXz+8eRD3kc9irXagmlQ=
X-Google-Smtp-Source: APXvYqytigiKXb5j5Uq+JNc0EzODZVycZ0SEUw45hoAXW38NOiSg5uVh4g9COGvgOn+it3gXpmzMzQ==
X-Received: by 2002:a5d:69c8:: with SMTP id s8mr1414873wrw.167.1571987798667; 
 Fri, 25 Oct 2019 00:16:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r15sm1316713wro.20.2019.10.25.00.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 00:16:36 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7F5401FF90;
 Fri, 25 Oct 2019 07:37:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 51/73] translator: inject instrumentation from plugins
Date: Fri, 25 Oct 2019 07:36:51 +0100
Message-Id: <20191025063713.23374-52-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 70c66c538cf..f977682be79 100644
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
@@ -99,6 +107,14 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
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
@@ -111,6 +127,10 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
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


