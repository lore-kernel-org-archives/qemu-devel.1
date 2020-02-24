Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F517C35DE6
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 23:42:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A1A22084E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 23:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KvxtTJp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1A22084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6NMt-0007hk-Du
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 18:42:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j6NIP-0006XY-Sp
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 18:37:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j6NIO-00089D-7x
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 18:37:53 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:55899)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j6NIN-00083r-Sv; Mon, 24 Feb 2020 18:37:52 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48RJQ408xTz9sRs; Tue, 25 Feb 2020 10:37:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582587452;
 bh=rDAFrF+FxXEkKz5RpQvXoCfUKYeii7iNDX8QMBQkUKc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KvxtTJp4pIBgYh28xOKD0DmLkC61gu9kwamex26hyBp67GPT6creCkYg1L4b9R7fL
 CsZOTtrpRgfpo0pgtsGcwcUnoBTqWKoLdehHJQLygYh5zmZWC6tO3FflFaWkb/mx6b
 pndx4O/JsrzYVe9T8HErfoRLWBQrUAXxczRu/gcs=
From: David Gibson <david@gibson.dropbear.id.au>
To: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
Subject: [PATCH v6 11/18] target/ppc: Only calculate RMLS derived RMA limit on
 demand
Date: Tue, 25 Feb 2020 10:37:17 +1100
Message-Id: <20200224233724.46415-12-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200224233724.46415-1-david@gibson.dropbear.id.au>
References: <20200224233724.46415-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, aik@ozlabs.ru, farosas@linux.ibm.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Igor Mammedov <imammedo@redhat.com>, paulus@samba.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the LPCR is written, we update the env->rmls field with the RMA limi=
t
it implies.  Simplify things by just calculating the value directly from
the LPCR value when we need it.

It's possible this is a little slower, but it's unlikely to be significan=
t,
since this is only for real mode accesses in a translation configuration
that's not used very often, and the whole thing is behind the qemu TLB
anyway.  Therefore, keeping the number of state variables down and not
having to worry about making sure it's always in sync seems the better
option.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/cpu.h        |  1 -
 target/ppc/mmu-hash64.c | 84 ++++++++++++++++++++---------------------
 2 files changed, 40 insertions(+), 45 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 8077fdb068..f9871b1233 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1046,7 +1046,6 @@ struct CPUPPCState {
     uint64_t insns_flags2;
 #if defined(TARGET_PPC64)
     ppc_slb_t vrma_slb;
-    target_ulong rmls;
 #endif
=20
     int error_code;
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index dd0df6fd01..ac21c14f68 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -791,6 +791,35 @@ static target_ulong rmls_limit(PowerPCCPU *cpu)
     }
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
@@ -844,8 +873,10 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vad=
dr eaddr,
=20
             goto skip_slb_search;
         } else {
+            target_ulong limit =3D rmls_limit(cpu);
+
             /* Emulated old-style RMO mode, bounds check against RMLS */
-            if (raddr >=3D env->rmls) {
+            if (raddr >=3D limit) {
                 if (rwx =3D=3D 2) {
                     ppc_hash64_set_isi(cs, SRR1_PROTFAULT);
                 } else {
@@ -1007,8 +1038,9 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *c=
pu, target_ulong addr)
                 return -1;
             }
         } else {
+            target_ulong limit =3D rmls_limit(cpu);
             /* Emulated old-style RMO mode, bounds check against RMLS */
-            if (raddr >=3D env->rmls) {
+            if (raddr >=3D limit) {
                 return -1;
             }
             return raddr | env->spr[SPR_RMOR];
@@ -1043,53 +1075,18 @@ void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu, t=
arget_ulong ptex,
 static void ppc_hash64_update_vrma(PowerPCCPU *cpu)
 {
     CPUPPCState *env =3D &cpu->env;
-    const PPCHash64SegmentPageSizes *sps =3D NULL;
-    target_ulong esid, vsid, lpcr;
     ppc_slb_t *slb =3D &env->vrma_slb;
-    uint32_t vrmasd;
-    int i;
-
-    /* First clear it */
-    slb->esid =3D slb->vsid =3D 0;
-    slb->sps =3D NULL;
=20
     /* Is VRMA enabled ? */
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
+    if (ppc_hash64_use_vrma(env)) {
+        if (build_vrma_slbe(cpu, slb) =3D=3D 0) {
+            return;
         }
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
     }
=20
-    slb->vsid =3D vsid;
-    slb->esid =3D esid;
-    slb->sps =3D sps;
+    /* Otherwise, clear it to indicate error */
+    slb->esid =3D slb->vsid =3D 0;
+    slb->sps =3D NULL;
 }
=20
 void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val)
@@ -1098,7 +1095,6 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong v=
al)
     CPUPPCState *env =3D &cpu->env;
=20
     env->spr[SPR_LPCR] =3D val & pcc->lpcr_mask;
-    env->rmls =3D rmls_limit(cpu);
     ppc_hash64_update_vrma(cpu);
 }
=20
--=20
2.24.1


