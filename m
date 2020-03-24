Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C1CC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 05:18:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2314520714
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 05:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="FdfhqH4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2314520714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGbx3-0000LI-9M
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 01:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jGbu8-0004a5-4E
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 01:15:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jGbu6-0001dR-HR
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 01:15:08 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:56749)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jGbu6-0001Zl-6Y; Tue, 24 Mar 2020 01:15:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48mfZW4pxNz9sSM; Tue, 24 Mar 2020 16:14:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585026899;
 bh=UFKrhz8pB3NAj66yovnBqPp3W24n/Nc9FYZ0v/RFw60=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FdfhqH4DIf1+bzA5NYaCd3oyotdPuAWDgcWVrAdciHKm7EGAaCeIdgGMf9JLcj8ws
 85Kbcd6WKTJCF4lYfLNT6MGfUysnnSzDw3zdUUYB8AqAVMwD+N6IdetGN6IIVErxK9
 JGAY2bSOyIwhaO9R/THYMs4dsCAvPrSef7Q04N08=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 3/7] target/ppc: Fix ISA v3.0 (POWER9) slbia implementation
Date: Tue, 24 Mar 2020 16:14:52 +1100
Message-Id: <20200324051456.256116-4-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324051456.256116-1-david@gibson.dropbear.id.au>
References: <20200324051456.256116-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nicholas Piggin <npiggin@gmail.com>

The new ISA v3.0 slbia variants have not been implemented for TCG,
which can lead to crashing when a POWER9 machine boots Linux using
the hash MMU, for example ("disable_radix" kernel command line).

Add them.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20200319064439.1020571-1-npiggin@gmail.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
[dwg: Fixed compile error for USER_ONLY builds]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/helper.h     |  2 +-
 target/ppc/mmu-hash64.c | 56 +++++++++++++++++++++++++++++++++++------
 target/ppc/translate.c  |  5 +++-
 3 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index cfb4c07085..a95c010391 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -614,7 +614,7 @@ DEF_HELPER_FLAGS_3(store_slb, TCG_CALL_NO_RWG, void, =
env, tl, tl)
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
=20
-void helper_slbia(CPUPPCState *env)
+void helper_slbia(CPUPPCState *env, uint32_t ih)
 {
     PowerPCCPU *cpu =3D env_archcpu(env);
+    int starting_entry;
     int n;
=20
     /*
@@ -111,18 +112,59 @@ void helper_slbia(CPUPPCState *env)
      * expected that slbmte is more common than slbia, and slbia is usua=
lly
      * going to evict valid SLB entries, so that tradeoff is unlikely to=
 be a
      * good one.
+     *
+     * ISA v2.05 introduced IH field with values 0,1,2,6. These all inva=
lidate
+     * the same SLB entries (everything but entry 0), but differ in what
+     * "lookaside information" is invalidated. TCG can ignore this and f=
lush
+     * everything.
+     *
+     * ISA v3.0 introduced additional values 3,4,7, which change what SL=
Bs are
+     * invalidated.
      */
=20
-    /* XXX: Warning: slbia never invalidates the first segment */
-    for (n =3D 1; n < cpu->hash64_opts->slb_size; n++) {
-        ppc_slb_t *slb =3D &env->slb[n];
+    env->tlb_need_flush |=3D TLB_NEED_LOCAL_FLUSH;
+
+    starting_entry =3D 1; /* default for IH=3D0,1,2,6 */
+
+    if (env->mmu_model =3D=3D POWERPC_MMU_3_00) {
+        switch (ih) {
+        case 0x7:
+            /* invalidate no SLBs, but all lookaside information */
+            return;
=20
-        if (slb->esid & SLB_ESID_V) {
-            slb->esid &=3D ~SLB_ESID_V;
+        case 0x3:
+        case 0x4:
+            /* also considers SLB entry 0 */
+            starting_entry =3D 0;
+            break;
+
+        case 0x5:
+            /* treat undefined values as ih=3D=3D0, and warn */
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "slbia undefined IH field %u.\n", ih);
+            break;
+
+        default:
+            /* 0,1,2,6 */
+            break;
         }
     }
=20
-    env->tlb_need_flush |=3D TLB_NEED_LOCAL_FLUSH;
+    for (n =3D starting_entry; n < cpu->hash64_opts->slb_size; n++) {
+        ppc_slb_t *slb =3D &env->slb[n];
+
+        if (!(slb->esid & SLB_ESID_V)) {
+            continue;
+        }
+        if (env->mmu_model =3D=3D POWERPC_MMU_3_00) {
+            if (ih =3D=3D 0x3 && (slb->vsid & SLB_VSID_C) =3D=3D 0) {
+                /* preserves entries with a class value of 0 */
+                continue;
+            }
+        }
+
+        slb->esid &=3D ~SLB_ESID_V;
+    }
 }
=20
 static void __helper_slbie(CPUPPCState *env, target_ulong addr,
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 127c82a24e..b207fb5386 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4997,9 +4997,12 @@ static void gen_slbia(DisasContext *ctx)
 #if defined(CONFIG_USER_ONLY)
     GEN_PRIV;
 #else
+    uint32_t ih =3D (ctx->opcode >> 21) & 0x7;
+    TCGv_i32 t0 =3D tcg_const_i32(ih);
+
     CHK_SV;
=20
-    gen_helper_slbia(cpu_env);
+    gen_helper_slbia(cpu_env, t0);
 #endif /* defined(CONFIG_USER_ONLY) */
 }
=20
--=20
2.25.1


