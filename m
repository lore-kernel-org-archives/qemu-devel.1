Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB534C34031
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 02:22:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F84D20801
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 02:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bhb8HjnY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F84D20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4F0K-00075r-KD
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 21:22:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j4Esd-0004C2-VF
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 21:14:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j4Esc-00019K-LA
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 21:14:27 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:53331)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j4Esa-00015X-QA; Tue, 18 Feb 2020 21:14:25 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48Mh9h1fMVz9sSv; Wed, 19 Feb 2020 13:14:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582078456;
 bh=Ga/yd5YiPuGaR+nEhKsKC9zV0x7hdJgrguEeiOYljZI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bhb8HjnYBL5JV2iP34Sal5oDcrQrfv4X2nBcydzFq7Q2mAZcP3vz0Hi680fcEcHeO
 +OSXvCVpW2Ri7IqmZR0UpI/zsfRKWnbRYqdfdKf7wOl50Mh2MmBtQJj+WFgb40k7Lo
 YICjskt3vveTurrpK9Bxq3iUiS7DnZsbxlnwpFmg=
From: David Gibson <david@gibson.dropbear.id.au>
To: groug@kaod.org,
	clg@kaod.org,
	philmd@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v4 12/12] target/ppc: Don't store VRMA SLBE persistently
Date: Wed, 19 Feb 2020 13:14:09 +1100
Message-Id: <20200219021409.21332-13-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219021409.21332-1-david@gibson.dropbear.id.au>
References: <20200219021409.21332-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, aik@ozlabs.ru,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, paulus@samba.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
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
---
 target/ppc/cpu.h        |  3 ---
 target/ppc/mmu-hash64.c | 28 ++++++----------------------
 2 files changed, 6 insertions(+), 25 deletions(-)

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
index 5ce7cc8359..7e6f4f62cb 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -829,6 +829,7 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vadd=
r eaddr,
 {
     CPUState *cs =3D CPU(cpu);
     CPUPPCState *env =3D &cpu->env;
+    ppc_slb_t vrma_slbe;
     ppc_slb_t *slb;
     unsigned apshift;
     hwaddr ptex;
@@ -867,8 +868,8 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vadd=
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
@@ -1016,6 +1017,7 @@ skip_slb_search:
 hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong addr=
)
 {
     CPUPPCState *env =3D &cpu->env;
+    ppc_slb_t vrma_slbe;
     ppc_slb_t *slb;
     hwaddr ptex, raddr;
     ppc_hash_pte64_t pte;
@@ -1037,8 +1039,8 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *c=
pu, target_ulong addr)
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
@@ -1076,30 +1078,12 @@ void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu, t=
arget_ulong ptex,
     cpu->env.tlb_need_flush =3D TLB_NEED_GLOBAL_FLUSH | TLB_NEED_LOCAL_F=
LUSH;
 }
=20
-static void ppc_hash64_update_vrma(PowerPCCPU *cpu)
-{
-    CPUPPCState *env =3D &cpu->env;
-    ppc_slb_t *slb =3D &env->vrma_slb;
-
-    /* Is VRMA enabled ? */
-    if (ppc_hash64_use_vrma(env)) {
-        if (build_vrma_slbe(cpu, slb) =3D=3D 0) {
-            return;
-        }
-    }
-
-    /* Otherwise, clear it to indicate error */
-    slb->esid =3D slb->vsid =3D 0;
-    slb->sps =3D NULL;
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


