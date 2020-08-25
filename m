Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC717C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:44:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90C4B206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f+bq5+bU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C4B206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgkF-0006Ra-TN
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg4G-0000Ua-JO
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:20 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38823)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg4E-000228-I5
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:20 -0400
Received: by mail-pf1-x443.google.com with SMTP id d22so8302791pfn.5
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4PiB9ZbjBaKjglLtNBxW9KhOjXdbTfOtuRsASAhW4TM=;
 b=f+bq5+bU5qJZgyq6pOlmgaDGL5Bj/lO10h+Sr2HJifNlLqLIWRY9WJoKPpTL3Or1Dd
 94Xv0tcLB6XirpqoJQrx6kSoanptlvxfTsnxnn4lhRVHDM5fdUV8F5LAtN1JKGTdq3KY
 cJuLSB4Gn71/78StJpBkItgyAOW5+nNAfPUruv3O6nc2iIM6rX17zkbdLKbUqPfqzhwP
 +Foi8/KrXKlXoZMduPrPlDeXZnFAuusKSwt3OgKi8ampV61e9kQ7E2+Z47fT6knYfIDL
 R2mgcWmjFATe1rYSIb0MtQnXBItu3NcvyFFZRTjXTf+8ZofAoCkO4+6UDAtgqT0Xg9ag
 ERyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4PiB9ZbjBaKjglLtNBxW9KhOjXdbTfOtuRsASAhW4TM=;
 b=kLxCq+wcZwVmndRKi8m5qRQx4qfSrDLtgQDX3I8dXdyOPKiN6ZGghMN3iRx0gadCiD
 gL61HrQCBdOin13RYcZMcIygKXTG9aocQsbjmHYCEb2Dq5A///dFT4wlfLQgPQLP9vEk
 80EdfBvZ0WhN/xP3wa+BS2RsJcO9cIWBR68tVaYSsIqBN6nRYQs9F5ofxeu93m8qZdp8
 iRqi88qp0s+fBoe8rRsKpkwmZcISqtZgt2l3eMOsuQ0jlKKn4t+rQKLO3Ui9i2M7D/cZ
 zkUd0/qQtI5WvlktjmUjXouxLkfOMGvq7Am3nKwghExDajPqRyvblVOk2m38u4gURQKH
 TPrw==
X-Gm-Message-State: AOAM530PkoQTT0hW5FRVTrL4dnYUGoimHlupIoqc1qI3YqxKlX6WdXf3
 0dTMsUzmmjYr5YHJJeL2glNnVMyUw2stxQ==
X-Google-Smtp-Source: ABdhPJyYv56oX0DI78meVCbnQ61kaz52TP0P4a9oOcchr444/VGgffcjZGqmGQsAeEXB+O7WatvUoA==
X-Received: by 2002:a17:902:8504:: with SMTP id
 bj4mr8926772plb.231.1598389276759; 
 Tue, 25 Aug 2020 14:01:16 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:01:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 64/77] target/microblaze: Convert mbar to decodetree
Date: Tue, 25 Aug 2020 13:59:37 -0700
Message-Id: <20200825205950.730499-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Split this out of the normal branch instructions, as it requires
special handling.  End the TB only for an instruction barrier.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/insns.decode |  2 +
 target/microblaze/translate.c  | 81 ++++++++++++++++++----------------
 2 files changed, 45 insertions(+), 38 deletions(-)

diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
index 53da2b75aa..77b073be9e 100644
--- a/target/microblaze/insns.decode
+++ b/target/microblaze/insns.decode
@@ -124,6 +124,8 @@ lwea            110010 ..... ..... ..... 0001 000 0000  @typea
 lwx             110010 ..... ..... ..... 1000 000 0000  @typea
 lwi             111010 ..... ..... ................     @typeb
 
+mbar            101110 imm:5 00010 0000 0000 0000 0100
+
 mul             010000 ..... ..... ..... 000 0000 0000  @typea
 mulh            010000 ..... ..... ..... 000 0000 0001  @typea
 mulhu           010000 ..... ..... ..... 000 0000 0011  @typea
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index fc1c661368..a391e80fb9 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1166,6 +1166,48 @@ static bool trans_brki(DisasContext *dc, arg_typeb_br *arg)
     return true;
 }
 
+static bool trans_mbar(DisasContext *dc, arg_mbar *arg)
+{
+    int mbar_imm = arg->imm;
+
+    /*
+     * Instruction access memory barrier.
+     * End the TB so that we recognize self-modified code immediately.
+     */
+    if (mbar_imm & 1) {
+        dc->cpustate_changed = 1;
+    }
+
+    /* Data access memory barrier.  */
+    if (mbar_imm & 2) {
+        tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
+    }
+
+    /* Sleep. */
+    if (mbar_imm & 16) {
+        TCGv_i32 tmp_1;
+
+        if (trap_userspace(dc, true)) {
+            /* Sleep is a privileged instruction.  */
+            return true;
+        }
+
+        t_sync_flags(dc);
+
+        tmp_1 = tcg_const_i32(1);
+        tcg_gen_st_i32(tmp_1, cpu_env,
+                       -offsetof(MicroBlazeCPU, env)
+                       +offsetof(CPUState, halted));
+        tcg_temp_free_i32(tmp_1);
+
+        tcg_gen_movi_i32(cpu_pc, dc->base.pc_next + 4);
+
+        gen_raise_exception(dc, EXCP_HLT);
+    }
+    return true;
+}
+
+
 static void msr_read(DisasContext *dc, TCGv_i32 d)
 {
     TCGv_i32 t;
@@ -1447,50 +1489,13 @@ static void dec_bcc(DisasContext *dc)
 
 static void dec_br(DisasContext *dc)
 {
-    unsigned int dslot, link, abs, mbar;
+    unsigned int dslot, link, abs;
     uint32_t add_pc;
 
     dslot = dc->ir & (1 << 20);
     abs = dc->ir & (1 << 19);
     link = dc->ir & (1 << 18);
 
-    /* Memory barrier.  */
-    mbar = (dc->ir >> 16) & 31;
-    if (mbar == 2 && dc->imm == 4) {
-        uint16_t mbar_imm = dc->rd;
-
-        /* Data access memory barrier.  */
-        if ((mbar_imm & 2) == 0) {
-            tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
-        }
-
-        /* mbar IMM & 16 decodes to sleep.  */
-        if (mbar_imm & 16) {
-            TCGv_i32 tmp_1;
-
-            if (trap_userspace(dc, true)) {
-                /* Sleep is a privileged instruction.  */
-                return;
-            }
-
-            t_sync_flags(dc);
-
-            tmp_1 = tcg_const_i32(1);
-            tcg_gen_st_i32(tmp_1, cpu_env,
-                           -offsetof(MicroBlazeCPU, env)
-                           +offsetof(CPUState, halted));
-            tcg_temp_free_i32(tmp_1);
-
-            tcg_gen_movi_i32(cpu_pc, dc->base.pc_next + 4);
-
-            gen_raise_exception(dc, EXCP_HLT);
-            return;
-        }
-        /* Break the TB.  */
-        dc->cpustate_changed = 1;
-        return;
-    }
-
     if (dslot && dec_setup_dslot(dc)) {
         return;
     }
-- 
2.25.1


