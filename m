Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E883C34031
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 01:04:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5984924655
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 01:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="p58SB0+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5984924655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4DmX-0005k7-HJ
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 20:04:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37727)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j4DdF-00017G-P1
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 19:54:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j4DdE-0001Ir-9g
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 19:54:29 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:56125 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j4DdD-0001Ev-Tx; Tue, 18 Feb 2020 19:54:28 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48MfPV5vDXz9sSX; Wed, 19 Feb 2020 11:54:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582073662;
 bh=+jNmPKQFwt6qcFTEPaXoxgeQZgx5X3I9Q0aV8FzdT9Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=p58SB0+yXgCDBD/TflqfiWMbkZ8wQv87uiQtkn1ELXxUIZsYDGjObu+xaAlFE+Qwy
 2El8U3lglyJK975Sn4MfCD06aQmvqz6fMBmDVvNICsAUjDPJUIn0hYOa7GpXqrglFd
 or9XsYtKOTjnTpH3Us4INVuaFo6Db1+Wsqov2a3M=
From: David Gibson <david@gibson.dropbear.id.au>
To: groug@kaod.org,
	philmd@redhat.com,
	qemu-devel@nongnu.org,
	clg@kaod.org
Subject: [PATCH v3 11/12] target/ppc: Streamline construction of VRMA SLB entry
Date: Wed, 19 Feb 2020 11:54:13 +1100
Message-Id: <20200219005414.15635-12-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219005414.15635-1-david@gibson.dropbear.id.au>
References: <20200219005414.15635-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, aik@ozlabs.ru,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, paulus@samba.org,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When in VRMA mode (i.e. a guest thinks it has the MMU off, but the
hypervisor is still applying translation) we use a special SLB entry,
rather than looking up an SLBE by address as we do when guest translation
is on.

We build that special entry in ppc_hash64_update_vrma() along with some
logic for handling some non-VRMA cases.  Split the actual build of the
VRMA SLBE into a separate helper and streamline it a bit.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu-hash64.c | 79 ++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 41 deletions(-)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 170a78bd2e..06cfff9860 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -789,6 +789,39 @@ static target_ulong rmls_limit(PowerPCCPU *cpu)
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
+    /*
+     * Make one up. Mostly ignore the ESID which will not be needed
+     * for translation
+     */
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
@@ -1044,53 +1077,17 @@ void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu, t=
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
     if (ppc_hash64_use_vrma(env)) {
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
+        if (build_vrma_slbe(cpu, slb) =3D=3D 0)
+            return;
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
--=20
2.24.1


