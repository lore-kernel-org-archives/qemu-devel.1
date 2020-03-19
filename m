Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6844CC4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 06:47:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EBD02072C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 06:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvqLZp0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EBD02072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEoxy-0007Lz-9u
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 02:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jEox9-0006pY-IA
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 02:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jEox8-0002iE-4v
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 02:46:51 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:39137)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jEox4-0002Xq-QR; Thu, 19 Mar 2020 02:46:46 -0400
Received: by mail-pf1-x443.google.com with SMTP id d25so896152pfn.6;
 Wed, 18 Mar 2020 23:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8filGja/D7ZIQr1WPGOj7qYDnkJMWa9pZJoeTe/6C6M=;
 b=OvqLZp0cWmemAdS/kBxpoRqrGDPoOaCPIsMR01WggqQymc4+87ueAkOddMJOWPZB43
 askFTsoESDA0YQDqm9u4ijC3Gx0rhW73UTtcWPtOIIknyQhH0swv7Y151Ia6LgIswXgz
 8FUu8p5XRDYpkOYfa/TUFKL/npkLP2padWXi61n6tKHk/wSep32+wwdnRp3zJ3GJnJ85
 vOWN5NrB5Mf6iPsDaGs9oXl65/GAmXupYg7yfjexqxbALeL/dH3jGTSS9pouDqrd2IUd
 C2+fH/vjL+thC84YwokfEzuFER7BdwZQdsAVBYuvoSld6aGdt9i3lojeihCOE99cQ7Q8
 6uEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8filGja/D7ZIQr1WPGOj7qYDnkJMWa9pZJoeTe/6C6M=;
 b=kGDjmvBz4079zkWEDkGsZGPE8ArzfNXVst2M4LiGyIaUmbsesqOtl54qsuraFMPl1j
 Rf4ooopLIHcoxgnwrVnKj0j3agW/SwVkJsOXUuYxhYuXaIMihhU1mWOYk9fC5RKEeBcf
 slTDNpSnOFu1EobSm/0ZkoZTjXQA5JkYrHoAmbKzMsWGkJzePETIjAS3lPQTx5aXZFlK
 Lfmt+yDM5IYFFd/c7PBAjVGmxh73n3zZ7ZkVv3PV4eRAYj2vI3/QzbXX1heqHQze/TkD
 WI3biN5eLnB6TF85f+YZVrpz/5wnbkgtZL9dlhFZY8b8y3PZ6+rU3wVspdFlWWLEGakQ
 CAIg==
X-Gm-Message-State: ANhLgQ3wFRoV7mrK7USlhJtmIbs+fxoOrgF9w0lpHVNssOG018zoXajT
 QNgAN8VuJuWlaaShPuMmHu9cMHIG
X-Google-Smtp-Source: ADFU+vuYFpdk0ouGFeRwMww4aaCqURWB9mhOgk3rUDMtY8JC8hY+OdBDJcWOegZrApNfnNEfHzWfpA==
X-Received: by 2002:a62:7c15:: with SMTP id x21mr2525859pfc.132.1584600404666; 
 Wed, 18 Mar 2020 23:46:44 -0700 (PDT)
Received: from bobo.ibm.com (14-202-190-183.tpgi.com.au. [14.202.190.183])
 by smtp.gmail.com with ESMTPSA id z17sm1088360pff.12.2020.03.18.23.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2020 23:46:44 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v2] target/ppc: Fix ISA v3.0 (POWER9) slbia implementation
Date: Thu, 19 Mar 2020 16:44:39 +1000
Message-Id: <20200319064439.1020571-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The new ISA v3.0 slbia variants have not been implemented for TCG,
which can lead to crashing when a POWER9 machine boots Linux using
the hash MMU, for example ("disable_radix" kernel command line).

Add them.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Changes in v2:
- Rewrite changelog.
- Remove stray slbie hunk that crept in

I don't think the slbie invalidation is necessary, as explained on the
list.

 target/ppc/helper.h     |  2 +-
 target/ppc/mmu-hash64.c | 56 +++++++++++++++++++++++++++++++++++------
 target/ppc/translate.c  |  5 +++-
 3 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index ee1498050d..2dfa1c6942 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -615,7 +615,7 @@ DEF_HELPER_FLAGS_3(store_slb, TCG_CALL_NO_RWG, void, env, tl, tl)
 DEF_HELPER_2(load_slb_esid, tl, env, tl)
 DEF_HELPER_2(load_slb_vsid, tl, env, tl)
 DEF_HELPER_2(find_slb_vsid, tl, env, tl)
-DEF_HELPER_FLAGS_1(slbia, TCG_CALL_NO_RWG, void, env)
+DEF_HELPER_FLAGS_2(slbia, TCG_CALL_NO_RWG, void, env, i32)
 DEF_HELPER_FLAGS_2(slbie, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_2(slbieg, TCG_CALL_NO_RWG, void, env, tl)
 #endif
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 373d44de74..e5baabf0e1 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -95,9 +95,10 @@ void dump_slb(PowerPCCPU *cpu)
     }
 }
 
-void helper_slbia(CPUPPCState *env)
+void helper_slbia(CPUPPCState *env, uint32_t ih)
 {
     PowerPCCPU *cpu = env_archcpu(env);
+    int starting_entry;
     int n;
 
     /*
@@ -111,18 +112,59 @@ void helper_slbia(CPUPPCState *env)
      * expected that slbmte is more common than slbia, and slbia is usually
      * going to evict valid SLB entries, so that tradeoff is unlikely to be a
      * good one.
+     *
+     * ISA v2.05 introduced IH field with values 0,1,2,6. These all invalidate
+     * the same SLB entries (everything but entry 0), but differ in what
+     * "lookaside information" is invalidated. TCG can ignore this and flush
+     * everything.
+     *
+     * ISA v3.0 introduced additional values 3,4,7, which change what SLBs are
+     * invalidated.
      */
 
-    /* XXX: Warning: slbia never invalidates the first segment */
-    for (n = 1; n < cpu->hash64_opts->slb_size; n++) {
-        ppc_slb_t *slb = &env->slb[n];
+    env->tlb_need_flush |= TLB_NEED_LOCAL_FLUSH;
+
+    starting_entry = 1; /* default for IH=0,1,2,6 */
+
+    if (env->mmu_model == POWERPC_MMU_3_00) {
+        switch (ih) {
+        case 0x7:
+            /* invalidate no SLBs, but all lookaside information */
+            return;
 
-        if (slb->esid & SLB_ESID_V) {
-            slb->esid &= ~SLB_ESID_V;
+        case 0x3:
+        case 0x4:
+            /* also considers SLB entry 0 */
+            starting_entry = 0;
+            break;
+
+        case 0x5:
+            /* treat undefined values as ih==0, and warn */
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "slbia undefined IH field %u.\n", ih);
+            break;
+
+        default:
+            /* 0,1,2,6 */
+            break;
         }
     }
 
-    env->tlb_need_flush |= TLB_NEED_LOCAL_FLUSH;
+    for (n = starting_entry; n < cpu->hash64_opts->slb_size; n++) {
+        ppc_slb_t *slb = &env->slb[n];
+
+        if (!(slb->esid & SLB_ESID_V)) {
+            continue;
+        }
+        if (env->mmu_model == POWERPC_MMU_3_00) {
+            if (ih == 0x3 && (slb->vsid & SLB_VSID_C) == 0) {
+                /* preserves entries with a class value of 0 */
+                continue;
+            }
+        }
+
+        slb->esid &= ~SLB_ESID_V;
+    }
 }
 
 static void __helper_slbie(CPUPPCState *env, target_ulong addr,
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index eb0ddba850..e514732a09 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -5027,12 +5027,15 @@ static void gen_tlbsync(DisasContext *ctx)
 /* slbia */
 static void gen_slbia(DisasContext *ctx)
 {
+    uint32_t ih = (ctx->opcode >> 21) & 0x7;
+    TCGv_i32 t0 = tcg_const_i32(ih);
+
 #if defined(CONFIG_USER_ONLY)
     GEN_PRIV;
 #else
     CHK_SV;
 
-    gen_helper_slbia(cpu_env);
+    gen_helper_slbia(cpu_env, t0);
 #endif /* defined(CONFIG_USER_ONLY) */
 }
 
-- 
2.23.0


