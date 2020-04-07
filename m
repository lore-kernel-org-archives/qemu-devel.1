Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C61C2BABC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 03:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9314F20769
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 03:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gAq/qhl+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9314F20769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLed4-0008Rz-Ps
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 23:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jLecR-000817-R8
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 23:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jLecQ-0004c4-LC
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 23:09:43 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:39225)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jLecQ-0004bi-8m
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 23:09:42 -0400
Received: by mail-pj1-x1043.google.com with SMTP id z3so142528pjr.4
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 20:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LakYsRpuc1K+QmwTzrK1RSwHEgveYhtnWJd32kJKiSE=;
 b=gAq/qhl+PZSn4AAyncMbSyF6w/m24VL41gc1BbdEPuBxDhPmTOwCrNCxcsPIQHiXHc
 gcAffrnjFo8HAsmxMp3fzQ3IuFL/bXefzf1qgw9ttaoNXtQgF1Wdtj1pDUX0NjAJj7uT
 NEBYG6wIa+AgG77cGkuq8aWa7a3i/C2kO6MuVa+hTT/DdLRnpRatTb5yZmRoDc+m9Vn4
 jx53BhLHQMYcUj6FDbK0og1dOTcIYozUInD5ABc3d3a0MM9sFHZXEQoVfZ8HazI+/+kG
 5xfqqdX8kSNQZX2HSWXcQP1ZX14N+pnMCDqdE6qaUcsl4ow12HoGcBKjWfFYjwiPjPXC
 Y4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LakYsRpuc1K+QmwTzrK1RSwHEgveYhtnWJd32kJKiSE=;
 b=qoovzpPsITUJhKnxcIHNjImqySXEDy4qK4H6QLODQ6CST8oYMbcsYvE1uUfr3XS+ax
 po55r0hIjp2VFb7bMtd6TMZXnu1euJaAmRYq2BHOtkM1olnKMI30XSj9nLWwZMRMcwrR
 YVZP2gnRpowgYzGpQ9CrPCcDpkWJmmIct2izJbdK1opwCQ9eUBDug2dnTTCLVXAdT++9
 ioE7BP8qN6fZ2MNAqO/4YAV9cILYI05sFxVg/kXi84pBxier15Ikk3ia7xQLanFn30fx
 XliyLmo1+EdooJJG3AgVPDiCo4bzpqzMHgdbhdonY3w2pMtpYOJ3PESTYdIlz4rdYTcr
 mTeA==
X-Gm-Message-State: AGi0PuZU6iBvSPDMMSPQstyTPSCLUyXUxTrWIaEFJ0Vf7DWxt0xrARgG
 fB/GKSI/zUQXA0jX95l9t7i+IFHY2P4=
X-Google-Smtp-Source: APiQypJ8IAKGn0TuYpYnHyO9GCf+E/n7wvzzoBEH8f8zjogcT3ZcPxQZj8U3oug6IorM2dmQa6uPRg==
X-Received: by 2002:a17:90a:de0e:: with SMTP id
 m14mr156780pjv.54.1586228980544; 
 Mon, 06 Apr 2020 20:09:40 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id i24sm11984059pgb.57.2020.04.06.20.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 20:09:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0?] target/xtensa: Statically allocate xtensa_insnbufs
Date: Mon,  6 Apr 2020 20:09:38 -0700
Message-Id: <20200407030938.26537-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rather than dynamically allocate, and risk failing to free
when we longjmp out of the translator, allocate the maximum
buffer size from any of the supported cpus, which is 8:

core-dc232b/xtensa-modules.inc.c:  3 /* insn_size */, 0,
core-dc233c/xtensa-modules.inc.c:  3 /* insn_size */, 0,
core-de212/xtensa-modules.inc.c:  3 /* insn_size */, 0,
core-fsf/xtensa-modules.inc.c:  3 /* insn_size */, 0,
core-sample_controller/xtensa-modules.inc.c:  3 /* insn_size */, 0,
core-test_kc705_be/xtensa-modules.inc.c:  8 /* insn_size */, 0,
core-test_mmuhifi_c3/xtensa-modules.inc.c:  8 /* insn_size */, 0,

Cc: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/translate.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 37f65b1f03..86369aa623 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -72,8 +72,10 @@ struct DisasContext {
     unsigned cpenable;
 
     uint32_t op_flags;
-    xtensa_insnbuf insnbuf;
-    xtensa_insnbuf slotbuf;
+
+    /* The maximum of all supported cpus is 8. */
+    xtensa_insnbuf_word insnbuf[8];
+    xtensa_insnbuf_word slotbuf[8];
 };
 
 static TCGv_i32 cpu_pc;
@@ -1174,14 +1176,11 @@ static void xtensa_tr_init_disas_context(DisasContextBase *dcbase,
     dc->callinc = ((tb_flags & XTENSA_TBFLAG_CALLINC_MASK) >>
                    XTENSA_TBFLAG_CALLINC_SHIFT);
 
-    /*
-     * FIXME: This will leak when a failed instruction load or similar
-     * event causes us to longjump out of the translation loop and
-     * hence not clean-up in xtensa_tr_tb_stop
-     */
     if (dc->config->isa) {
-        dc->insnbuf = xtensa_insnbuf_alloc(dc->config->isa);
-        dc->slotbuf = xtensa_insnbuf_alloc(dc->config->isa);
+        size_t size = (xtensa_insnbuf_size(dc->config->isa) *
+                       sizeof(xtensa_insnbuf_word));
+        assert(sizeof(dc->insnbuf) >= size);
+        assert(sizeof(dc->slotbuf) >= size);
     }
     init_sar_tracker(dc);
 }
@@ -1272,10 +1271,6 @@ static void xtensa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
     reset_sar_tracker(dc);
-    if (dc->config->isa) {
-        xtensa_insnbuf_free(dc->config->isa, dc->insnbuf);
-        xtensa_insnbuf_free(dc->config->isa, dc->slotbuf);
-    }
     if (dc->icount) {
         tcg_temp_free(dc->next_icount);
     }
-- 
2.20.1


