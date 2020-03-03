Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F9AC3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 01:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CD282465E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 01:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LsXMuYCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD282465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8w1G-0002Uj-8u
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 20:06:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vl2-0002rP-H2
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:50:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vl0-0004cD-Ut
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:50:00 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034]:53537)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j8vl0-0004bI-Ie
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:58 -0500
Received: by mail-pj1-x1034.google.com with SMTP id cx7so551256pjb.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 16:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=xTc+vPkMfohLZfVyEMM5rQlCBaxWcGBV4IgrxO2Qhx8=;
 b=LsXMuYCzMyTQTHPlFrwbuTvpvZakc7vO1yjFBQ42C8uKnJEDUpgeYI/BkJNNpDCBn+
 sJIH0CAzD1X60HerZI4p1QVRlnRmjRJzKBgxuo4huDAeMWQts4gpYAc4bv+sUMbvdnmT
 EsnxIYFqyza1v1pxVMs1n1Y7K8BkNeuPo06OrSB9yfXNGgecsrxTVBKxkGSnx3aXdrb5
 pasVlRhmy0Fc3YLWUBRqJYM1fcxhvvtljmf0D4to2F4ctjZxC3134LjJJKOCHAHR4vtk
 uDDd3LEMtr0g0XxQt+EqDu08boGCv+GmVKTR0i+Qx7rBynlOEjSgZvZ6eb06dWeuGAPp
 cnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=xTc+vPkMfohLZfVyEMM5rQlCBaxWcGBV4IgrxO2Qhx8=;
 b=bsmyKUdsj92UP40BR3vqoGyPJzdKflXDOqm3sWGXA5oVvWfoSaDWIDmE8VJZCzfIDL
 LXeJ1zqxCZ1k/aO9b8jYpaQq1F41ZqBJ5s/bKPxnLvQ6AgXLXN1YeOdokunbBsFgE/IG
 fx0ep0/QFQneRf+PYitY+k5kg7EXgEnF2pMEGwIPsbjdZjhB8pzG/bNGTo+73wLBYhNM
 WIPd6ONcPGmcUidmtZNhBheYoKZF3URhceBBa4jzmtqb+XMOxotSvNkqH7oK51g9/k+0
 emjhEnAey2qnPmh0gIBYqbEAmbYCf+qIFQ5isBvtd/Tx1AMqvYnjCpEzKOzvYwYpWuIg
 Qz7A==
X-Gm-Message-State: ANhLgQ1dsKIvuYsnLGIJptvmYWe56cpFCSxoCFBpQ/OWBxi3Pq7MLTD1
 T310wbvKG2X5oSdi6LX5a7eAKQ==
X-Google-Smtp-Source: ADFU+vvtiPtMtogZiBGbE3rZUkUtlZF+3JGCrYw2LglTfI24TmZnr550vsdDfG1OLM4xIchTzWufdA==
X-Received: by 2002:a17:90b:8ce:: with SMTP id
 ds14mr1253412pjb.70.1583196597076; 
 Mon, 02 Mar 2020 16:49:57 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id k67sm22159878pga.91.2020.03.02.16.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 16:49:56 -0800 (PST)
Subject: [PULL 34/38] target/riscv: Add the MSTATUS_MPV_ISSET helper macro
Date: Mon,  2 Mar 2020 16:48:44 -0800
Message-Id: <20200303004848.136788-35-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200303004848.136788-1-palmerdabbelt@google.com>
References: <20200303004848.136788-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-riscv@nongnu.org,          qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1034
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

Add a helper macro MSTATUS_MPV_ISSET() which will determine if the
MSTATUS_MPV bit is set for both 32-bit and 64-bit RISC-V.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/cpu_bits.h   | 11 +++++++++++
 target/riscv/cpu_helper.c |  4 ++--
 target/riscv/op_helper.c  |  2 +-
 target/riscv/translate.c  |  2 +-
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 049032f2ae..7f64ee1174 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -363,8 +363,19 @@
 #define MSTATUS_TVM         0x00100000 /* since: priv-1.10 */
 #define MSTATUS_TW          0x20000000 /* since: priv-1.10 */
 #define MSTATUS_TSR         0x40000000 /* since: priv-1.10 */
+#if defined(TARGET_RISCV64)
 #define MSTATUS_MTL         0x4000000000ULL
 #define MSTATUS_MPV         0x8000000000ULL
+#elif defined(TARGET_RISCV32)
+#define MSTATUS_MTL         0x00000040
+#define MSTATUS_MPV         0x00000080
+#endif
+
+#ifdef TARGET_RISCV32
+# define MSTATUS_MPV_ISSET(env)  get_field(env->mstatush, MSTATUS_MPV)
+#else
+# define MSTATUS_MPV_ISSET(env)  get_field(env->mstatus, MSTATUS_MPV)
+#endif
 
 #define MSTATUS64_UXL       0x0000000300000000ULL
 #define MSTATUS64_SXL       0x0000000C00000000ULL
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 10f246ddf8..29a1b37d88 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -322,7 +322,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
             mode = get_field(env->mstatus, MSTATUS_MPP);
 
             if (riscv_has_ext(env, RVH) &&
-                get_field(env->mstatus, MSTATUS_MPV)) {
+                MSTATUS_MPV_ISSET(env)) {
                 use_background = true;
             }
         }
@@ -722,7 +722,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         m_mode_two_stage = env->priv == PRV_M &&
                            access_type != MMU_INST_FETCH &&
                            get_field(env->mstatus, MSTATUS_MPRV) &&
-                           get_field(env->mstatus, MSTATUS_MPV);
+                           MSTATUS_MPV_ISSET(env);
 
         hs_mode_two_stage = env->priv == PRV_S &&
                             !riscv_cpu_virt_enabled(env) &&
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index dca68fa96e..8736f689c2 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -146,7 +146,7 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
 
     target_ulong mstatus = env->mstatus;
     target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
-    target_ulong prev_virt = get_field(mstatus, MSTATUS_MPV);
+    target_ulong prev_virt = MSTATUS_MPV_ISSET(env);
     mstatus = set_field(mstatus,
         env->priv_ver >= PRIV_VERSION_1_10_0 ?
         MSTATUS_MIE : MSTATUS_UIE << prev_priv,
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index b51ab92068..43bf7e39a6 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -755,7 +755,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
         ctx->virt_enabled = riscv_cpu_virt_enabled(env);
         if (env->priv_ver == PRV_M &&
             get_field(env->mstatus, MSTATUS_MPRV) &&
-            get_field(env->mstatus, MSTATUS_MPV)) {
+            MSTATUS_MPV_ISSET(env)) {
             ctx->virt_enabled = true;
         } else if (env->priv == PRV_S &&
                    !riscv_cpu_virt_enabled(env) &&
-- 
2.25.0.265.gbab2e86ba0-goog


