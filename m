Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F220C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3B4320719
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="it6gFr26"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B4320719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmlI-0003Yo-2o
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmLO-0006gw-Bb
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:42 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:55319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmLM-0006Ai-1q
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:41 -0400
Received: by mail-pj1-x1042.google.com with SMTP id 2so21717pjx.5
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qD9TO6jGFspxgEuw853gVRm0hcTBzuluIXG7+nD8HAE=;
 b=it6gFr26EkQ4zo09ApJAmMqAT8cdh8Z8KCxVnMKlTHx0FF9qPpTxFlqaTEM4gC4jB/
 Wmy9yt47pENq5WxxWMhT4kJZFJ+iX6cMsELMCBVV3MD3lNYHdhbtdHAbJXkRSHRlzfff
 QeFaKcUPpKKCv4IUJnZ+0cwmVwLvcnQ+fimHzzn0MKA6gRyqi+WMh1ed14ZTat2145YV
 NkjHv4FfGA9LsnA03e+66IKfMR5ZbPk+R8IHjOBuhnAUpKaGe5GYEkJO3QdNEYicFS+A
 dIU7KFrJ2gyondW02IOLFNloMQMCiuziILKBZaG5SnsIW5Tx+iyIkSPrvvEqt9OV/J4t
 HEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qD9TO6jGFspxgEuw853gVRm0hcTBzuluIXG7+nD8HAE=;
 b=P3nOBBntVHDTYXdPObk0dhQmiSS113jE+WaoiwUA8UbaroNJQddQYvD7zFAzYzDdvh
 oDkdTmJ1Fzn6+TTNwBo3hn14b/8xKSitNgFxYuwT3UW++tZixyYPKyB1Ks1XTcD+PX5A
 U6W+EmRRjmAQeUlSlMHS8bD7iKBP/dFKCj7aC6EoyEEPUim0LYHLH6zs3UhyqBbUzxg5
 5n82CXrGWKFk9dWcTKP8Zeq/5mzjnlpGMjBxzPUimMv1E9YfkvcA+nfkI/8H6+8MzjJd
 WxcOkDzb6MYyEXkK0BWEIDzb+vK4H/Khqp+Ao1eM62QCUa3rTUfBTYw4sToNPOEHPcAl
 Lcww==
X-Gm-Message-State: AOAM531LbSKPa6bswsnNOsSkwfo1dIvKTCTuhtig1uFQvuRluFyIo4Yh
 /JJlViykVc91QofI+chZAcHg617MO9GZ6g==
X-Google-Smtp-Source: ABdhPJyrwMu1p78EmpJJLxe3yoWFxhh9H6yCyeoZmSyLMls9BFx5kBJOvWx1bPNwwnKHnHb7OrkkfA==
X-Received: by 2002:a17:90a:bc8c:: with SMTP id
 x12mr97622pjr.106.1598890058276; 
 Mon, 31 Aug 2020 09:07:38 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:07:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 70/76] target/microblaze: Convert msrclr, msrset to decodetree
Date: Mon, 31 Aug 2020 09:05:55 -0700
Message-Id: <20200831160601.833692-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Split this out of dec_msr.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/insns.decode |  6 +++
 target/microblaze/translate.c  | 85 +++++++++++++++++++---------------
 2 files changed, 54 insertions(+), 37 deletions(-)

diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
index 8906058a29..ed3312982f 100644
--- a/target/microblaze/insns.decode
+++ b/target/microblaze/insns.decode
@@ -24,6 +24,7 @@
 &typeb          rd ra imm
 &typeb_br       rd imm
 &typeb_bc       ra imm
+&type_msr       rd imm
 
 # Include any IMM prefix in the value reported.
 %extimm         0:s16 !function=typeb_imm
@@ -55,6 +56,8 @@
 %ieimm          6:5 0:5
 @typeb_ie       ...... rd:5 ra:5 ..... ..... . .....    &typeb imm=%ieimm
 
+@type_msr       ...... rd:5 ...... imm:15               &type_msr
+
 ###
 
 {
@@ -179,6 +182,9 @@ lwi             111010 ..... ..... ................     @typeb
 
 mbar            101110 imm:5 00010 0000 0000 0000 0100
 
+msrclr          100101 ..... 100010 ...............     @type_msr
+msrset          100101 ..... 100000 ...............     @type_msr
+
 mul             010000 ..... ..... ..... 000 0000 0000  @typea
 mulh            010000 ..... ..... ..... 000 0000 0001  @typea
 mulhu           010000 ..... ..... ..... 000 0000 0011  @typea
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 0872795038..9479dbc103 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1311,16 +1311,61 @@ static void msr_write(DisasContext *dc, TCGv_i32 v)
     tcg_gen_andi_i32(cpu_msr, v, ~(MSR_C | MSR_CC | MSR_PVR));
 }
 
+static bool do_msrclrset(DisasContext *dc, arg_type_msr *arg, bool set)
+{
+    uint32_t imm = arg->imm;
+
+    if (trap_userspace(dc, imm != MSR_C)) {
+        return true;
+    }
+
+    if (arg->rd) {
+        msr_read(dc, cpu_R[arg->rd]);
+    }
+
+    /*
+     * Handle the carry bit separately.
+     * This is the only bit that userspace can modify.
+     */
+    if (imm & MSR_C) {
+        tcg_gen_movi_i32(cpu_msr_c, set);
+    }
+
+    /*
+     * MSR_C and MSR_CC set above.
+     * MSR_PVR is not writable, and is always clear.
+     */
+    imm &= ~(MSR_C | MSR_CC | MSR_PVR);
+
+    if (imm != 0) {
+        if (set) {
+            tcg_gen_ori_i32(cpu_msr, cpu_msr, imm);
+        } else {
+            tcg_gen_andi_i32(cpu_msr, cpu_msr, ~imm);
+        }
+        dc->cpustate_changed = 1;
+    }
+    return true;
+}
+
+static bool trans_msrclr(DisasContext *dc, arg_type_msr *arg)
+{
+    return do_msrclrset(dc, arg, false);
+}
+
+static bool trans_msrset(DisasContext *dc, arg_type_msr *arg)
+{
+    return do_msrclrset(dc, arg, true);
+}
+
 static void dec_msr(DisasContext *dc)
 {
     CPUState *cs = CPU(dc->cpu);
-    TCGv_i32 t0, t1;
     unsigned int sr, rn;
-    bool to, clrset, extended = false;
+    bool to, extended = false;
 
     sr = extract32(dc->imm, 0, 14);
     to = extract32(dc->imm, 14, 1);
-    clrset = extract32(dc->imm, 15, 1) == 0;
     dc->type_b = 1;
     if (to) {
         dc->cpustate_changed = 1;
@@ -1334,40 +1379,6 @@ static void dec_msr(DisasContext *dc)
         extended = extract32(dc->imm, e_bit[to], 1);
     }
 
-    /* msrclr and msrset.  */
-    if (clrset) {
-        bool clr = extract32(dc->ir, 16, 1);
-
-        if (!dc->cpu->cfg.use_msr_instr) {
-            /* nop??? */
-            return;
-        }
-
-        if (trap_userspace(dc, dc->imm != 4 && dc->imm != 0)) {
-            return;
-        }
-
-        if (dc->rd)
-            msr_read(dc, cpu_R[dc->rd]);
-
-        t0 = tcg_temp_new_i32();
-        t1 = tcg_temp_new_i32();
-        msr_read(dc, t0);
-        tcg_gen_mov_i32(t1, *(dec_alu_op_b(dc)));
-
-        if (clr) {
-            tcg_gen_not_i32(t1, t1);
-            tcg_gen_and_i32(t0, t0, t1);
-        } else
-            tcg_gen_or_i32(t0, t0, t1);
-        msr_write(dc, t0);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-        tcg_gen_movi_i32(cpu_pc, dc->base.pc_next + 4);
-        dc->base.is_jmp = DISAS_UPDATE;
-        return;
-    }
-
     if (trap_userspace(dc, to)) {
         return;
     }
-- 
2.25.1


