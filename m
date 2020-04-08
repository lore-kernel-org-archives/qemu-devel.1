Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDE2C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 15:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13E0C206F7
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 15:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="egOm0rpP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E0C206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMCjm-0002P9-3P
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 11:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jMCfS-0005tP-JR
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 11:31:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jMCfR-0008Bx-CP
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 11:31:06 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:43014)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jMCfR-0008Bg-6Z
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 11:31:05 -0400
Received: by mail-pg1-x541.google.com with SMTP id s4so3452974pgk.10
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2020 08:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZGk61WNrpGDP6QSZdndDZCbGnp9yVuwh0dhPIo77VUo=;
 b=egOm0rpPsfA+JcFU+ZAumseK3G1qt5+0guBCINOwVNfjwirppjZe6B4/VGErtNeCGg
 lAXICa7zfO7Yrw3WmnepaFPzNObE2fnDSZeKBnZUGR36yMrwYfbRlU1yOLq/p5eBHSCH
 wGPAe3ydiFDK+zr2fofm3bvuorDLAmLM1AnEH3wYubDvtrZq3J93R13zYJaOERTdrAtB
 6sCPXWLI76GtEpf530z9PSDHv3wInPPPfyMMayUR9llCRKferSAqMRvoc6fe49PRn25i
 oeZ2lJTUH3vnL3vq1ZkjBOUkwr1IRNk69n0Sn4NbQ3DcggoRh9YEcVxfT2sX2gexffQX
 lZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZGk61WNrpGDP6QSZdndDZCbGnp9yVuwh0dhPIo77VUo=;
 b=Yi0YJTOXE2VsnjJ/dKPZ7fmpapzOXteXdPkDfwyBXmjfg3DOaB6qLOMWNalDWLA7ZS
 Zz9sVLxJ7pCYmqaewbGyDmuCBZJGjal9HqxZLXSvAXeswjNizZocAjHq+pM24itRTpOd
 XZ0NI/SnFgPFlEPVI5Kok+/gD1sZ5rGBl68PlFri9ehO9OBZALobacJxYrJJ/UnvYJ2E
 z7V0YbH9kA8eDkOfP8aDd0fM8yRIjgc67wW6FW6e2RMbOPPpS1eOH2lfTQ6j/yIyLdH1
 Yyxcdb9p0MhuJypNBPyT+iq0dpFkf/MSPnS7wRO6kIp/wketDL+ALehQ7LerNuf0GS3S
 7R2w==
X-Gm-Message-State: AGi0PuYMf/HxQNNexc/cY8o1t/3MeIY/Dwt/dzjNGp1gdt3xJXHPWml2
 3rV95gCqCKYdl6euyIeBuwGaFUIJXsw=
X-Google-Smtp-Source: APiQypKOJgM92Uw1ND36UJS72RidY5r+kP1+opVVKY97BHay+RlAdp/JqIfIrhfyzndwZvxLUPlUqA==
X-Received: by 2002:a65:670e:: with SMTP id u14mr7723317pgf.264.1586359863191; 
 Wed, 08 Apr 2020 08:31:03 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id t4sm16920454pfb.156.2020.04.08.08.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2020 08:31:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0? v2] target/xtensa: Statically allocate
 xtensa_insnbufs in DisasContext
Date: Wed,  8 Apr 2020 08:30:57 -0700
Message-Id: <20200408153057.31794-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200408153057.31794-1-richard.henderson@linaro.org>
References: <20200408153057.31794-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: peter.maydell@linaro.org, Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Filippov <jcmvbkbc@gmail.com>

Rather than dynamically allocate, and risk failing to free
when we longjmp out of the translator, allocate the maximum
buffer size from any of the supported cpus.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
[rth: Merged the fixup in Max's reply to his original]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/cpu.h       |  3 +++
 target/xtensa/helper.c    |  1 +
 target/xtensa/translate.c | 18 ++----------------
 3 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index c0d69fad96..7a46dccbe1 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -213,6 +213,9 @@ enum {
 #define MEMCTL_IL0EN 0x1
 
 #define MAX_INSN_LENGTH 64
+#define MAX_INSNBUF_LENGTH \
+    ((MAX_INSN_LENGTH + sizeof(xtensa_insnbuf_word) - 1) / \
+     sizeof(xtensa_insnbuf_word))
 #define MAX_INSN_SLOTS 32
 #define MAX_OPCODE_ARGS 16
 #define MAX_NAREG 64
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 376a61f339..7073381f03 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -96,6 +96,7 @@ static void init_libisa(XtensaConfig *config)
 
     config->isa = xtensa_isa_init(config->isa_internal, NULL, NULL);
     assert(xtensa_isa_maxlength(config->isa) <= MAX_INSN_LENGTH);
+    assert(xtensa_insnbuf_size(config->isa) <= MAX_INSNBUF_LENGTH);
     opcodes = xtensa_isa_num_opcodes(config->isa);
     formats = xtensa_isa_num_formats(config->isa);
     regfiles = xtensa_isa_num_regfiles(config->isa);
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 37f65b1f03..b898ee2261 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -72,8 +72,8 @@ struct DisasContext {
     unsigned cpenable;
 
     uint32_t op_flags;
-    xtensa_insnbuf insnbuf;
-    xtensa_insnbuf slotbuf;
+    xtensa_insnbuf_word insnbuf[MAX_INSNBUF_LENGTH];
+    xtensa_insnbuf_word slotbuf[MAX_INSNBUF_LENGTH];
 };
 
 static TCGv_i32 cpu_pc;
@@ -1173,16 +1173,6 @@ static void xtensa_tr_init_disas_context(DisasContextBase *dcbase,
     dc->cwoe = tb_flags & XTENSA_TBFLAG_CWOE;
     dc->callinc = ((tb_flags & XTENSA_TBFLAG_CALLINC_MASK) >>
                    XTENSA_TBFLAG_CALLINC_SHIFT);
-
-    /*
-     * FIXME: This will leak when a failed instruction load or similar
-     * event causes us to longjump out of the translation loop and
-     * hence not clean-up in xtensa_tr_tb_stop
-     */
-    if (dc->config->isa) {
-        dc->insnbuf = xtensa_insnbuf_alloc(dc->config->isa);
-        dc->slotbuf = xtensa_insnbuf_alloc(dc->config->isa);
-    }
     init_sar_tracker(dc);
 }
 
@@ -1272,10 +1262,6 @@ static void xtensa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
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


