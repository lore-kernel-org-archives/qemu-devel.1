Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C30FC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:16:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1231820714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="SGpfQXwg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1231820714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9Gl-00059e-63
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jE95k-00015i-RS
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:04:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jE95h-0002lh-N8
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:04:56 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:44645 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jE95h-0001uD-9b; Tue, 17 Mar 2020 06:04:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hTKw42JQz9sSm; Tue, 17 Mar 2020 21:04:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584439476;
 bh=MjjxC04elr5NVApj6H/3AhJX6J6nM8jDgUwU8I+pbxE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SGpfQXwgrcPcmagN9376g0T8+d/PP6Gr6dd0R9ed6wLKYpr0DgAz5lhu62yaZj8Aq
 jrv+TuCqgMlyV4ENBeq8FRRq2Icw3a7jeQsCbTwLIebQm0Us5ikZPp+7QCCYQFwAFC
 OG4tX3NrwBX8aKZ005LP8V9KqEeVNKhjoYTboTXo=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 16/45] target/ppc: Don't store VRMA SLBE persistently
Date: Tue, 17 Mar 2020 21:03:54 +1100
Message-Id: <20200317100423.622643-17-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317100423.622643-1-david@gibson.dropbear.id.au>
References: <20200317100423.622643-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, we construct the SLBE used for VRMA translations when the LPCR
is written (which controls some bits in the SLBE), then use it later for
translations.

This is a bit complex and confusing - simplify it by simply constructing
the SLBE directly from the LPCR when we need it.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/ppc/cpu.h        |  3 --
 target/ppc/mmu-hash64.c | 92 ++++++++++++++++-------------------------
 2 files changed, 35 insertions(+), 60 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index f9871b1233..5a55fb02bd 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1044,9 +1044,6 @@ struct CPUPPCState {
     uint32_t flags;
     uint64_t insns_flags;
     uint64_t insns_flags2;
-#if defined(TARGET_PPC64)
-    ppc_slb_t vrma_slb;
-#endif
=20
     int error_code;
     uint32_t pending_interrupts;
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 4fd7b7ee74..34f6009b1e 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -784,11 +784,41 @@ static target_ulong rmls_limit(PowerPCCPU *cpu)
     return rma_sizes[rmls];
 }
=20
+static int build_vrma_slbe(PowerPCCPU *cpu, ppc_slb_t *slb)
+{
+    CPUPPCState *env =3D &cpu->env;
+    target_ulong lpcr =3D env->spr[SPR_LPCR];
+    uint32_t vrmasd =3D (lpcr & LPCR_VRMASD) >> LPCR_VRMASD_SHIFT;
+    target_ulong vsid =3D SLB_VSID_VRMA | ((vrmasd << 4) & SLB_VSID_LLP_=
MASK);
+    int i;
+
+    for (i =3D 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
+        const PPCHash64SegmentPageSizes *sps =3D &cpu->hash64_opts->sps[=
i];
+
+        if (!sps->page_shift) {
+            break;
+        }
+
+        if ((vsid & SLB_VSID_LLP_MASK) =3D=3D sps->slb_enc) {
+            slb->esid =3D SLB_ESID_V;
+            slb->vsid =3D vsid;
+            slb->sps =3D sps;
+            return 0;
+        }
+    }
+
+    error_report("Bad page size encoding in LPCR[VRMASD]; LPCR=3D0x"
+                 TARGET_FMT_lx"\n", lpcr);
+
+    return -1;
+}
+
 int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr,
                                 int rwx, int mmu_idx)
 {
     CPUState *cs =3D CPU(cpu);
     CPUPPCState *env =3D &cpu->env;
+    ppc_slb_t vrma_slbe;
     ppc_slb_t *slb;
     unsigned apshift;
     hwaddr ptex;
@@ -827,8 +857,8 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vadd=
r eaddr,
             }
         } else if (ppc_hash64_use_vrma(env)) {
             /* Emulated VRMA mode */
-            slb =3D &env->vrma_slb;
-            if (!slb->sps) {
+            slb =3D &vrma_slbe;
+            if (build_vrma_slbe(cpu, slb) !=3D 0) {
                 /* Invalid VRMA setup, machine check */
                 cs->exception_index =3D POWERPC_EXCP_MCHECK;
                 env->error_code =3D 0;
@@ -976,6 +1006,7 @@ skip_slb_search:
 hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong addr=
)
 {
     CPUPPCState *env =3D &cpu->env;
+    ppc_slb_t vrma_slbe;
     ppc_slb_t *slb;
     hwaddr ptex, raddr;
     ppc_hash_pte64_t pte;
@@ -997,8 +1028,8 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cp=
u, target_ulong addr)
             return raddr | env->spr[SPR_HRMOR];
         } else if (ppc_hash64_use_vrma(env)) {
             /* Emulated VRMA mode */
-            slb =3D &env->vrma_slb;
-            if (!slb->sps) {
+            slb =3D &vrma_slbe;
+            if (build_vrma_slbe(cpu, slb) !=3D 0) {
                 return -1;
             }
         } else {
@@ -1037,65 +1068,12 @@ void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu, t=
arget_ulong ptex,
     cpu->env.tlb_need_flush =3D TLB_NEED_GLOBAL_FLUSH | TLB_NEED_LOCAL_F=
LUSH;
 }
=20
-static void ppc_hash64_update_vrma(PowerPCCPU *cpu)
-{
-    CPUPPCState *env =3D &cpu->env;
-    const PPCHash64SegmentPageSizes *sps =3D NULL;
-    target_ulong esid, vsid, lpcr;
-    ppc_slb_t *slb =3D &env->vrma_slb;
-    uint32_t vrmasd;
-    int i;
-
-    /* First clear it */
-    slb->esid =3D slb->vsid =3D 0;
-    slb->sps =3D NULL;
-
-    /* Is VRMA enabled ? */
-    if (!ppc_hash64_use_vrma(env)) {
-        return;
-    }
-
-    /*
-     * Make one up. Mostly ignore the ESID which will not be needed
-     * for translation
-     */
-    lpcr =3D env->spr[SPR_LPCR];
-    vsid =3D SLB_VSID_VRMA;
-    vrmasd =3D (lpcr & LPCR_VRMASD) >> LPCR_VRMASD_SHIFT;
-    vsid |=3D (vrmasd << 4) & (SLB_VSID_L | SLB_VSID_LP);
-    esid =3D SLB_ESID_V;
-
-    for (i =3D 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
-        const PPCHash64SegmentPageSizes *sps1 =3D &cpu->hash64_opts->sps=
[i];
-
-        if (!sps1->page_shift) {
-            break;
-        }
-
-        if ((vsid & SLB_VSID_LLP_MASK) =3D=3D sps1->slb_enc) {
-            sps =3D sps1;
-            break;
-        }
-    }
-
-    if (!sps) {
-        error_report("Bad page size encoding esid 0x"TARGET_FMT_lx
-                     " vsid 0x"TARGET_FMT_lx, esid, vsid);
-        return;
-    }
-
-    slb->vsid =3D vsid;
-    slb->esid =3D esid;
-    slb->sps =3D sps;
-}
-
 void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val)
 {
     PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
     CPUPPCState *env =3D &cpu->env;
=20
     env->spr[SPR_LPCR] =3D val & pcc->lpcr_mask;
-    ppc_hash64_update_vrma(cpu);
 }
=20
 void helper_store_lpcr(CPUPPCState *env, target_ulong val)
--=20
2.24.1


