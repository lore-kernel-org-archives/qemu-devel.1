Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E444C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1901D205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="H7lSVszR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1901D205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9AT-00020N-74
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jE95b-0000ng-VR
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jE95a-0001qM-94
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:04:47 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:42981 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jE95Z-0001Fw-R4; Tue, 17 Mar 2020 06:04:46 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hTKw11Dcz9sSX; Tue, 17 Mar 2020 21:04:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584439476;
 bh=Z8m37V4lbrn1lOzpPF1CewIHsnj+ytGRNy9iMWzlxes=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=H7lSVszRv91OSQVLsbTLTSewksfan8JWbNzM7m5bbit2KB9DBDxa8St2qXyegDDcc
 yqBA+tMVfaVz36tyUczq9sMuPHxJVGtf9LF6XsXnNdI/9F977RXWC7jalZEcDxDwqU
 Kn5aCYOELZgEX/K1Bpz3dMgAdN0zyAy1L/hb8uH4=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 09/45] target/ppc: Introduce ppc_hash64_use_vrma() helper
Date: Tue, 17 Mar 2020 21:03:47 +1100
Message-Id: <20200317100423.622643-10-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, Fabiano Rosas <farosas@linux.ibm.com>, aik@ozlabs.ru,
 mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When running guests under a hypervisor, the hypervisor obviously needs to
be protected from guest accesses even if those are in what the guest
considers real mode (translation off).  The POWER hardware provides two
ways of doing that: The old way has guest real mode accesses simply offse=
t
and bounds checked into host addresses.  It works, but requires that a
significant chunk of the guest's memory - the RMA - be physically
contiguous in the host, which is pretty inconvenient.  The new way, known
as VRMA, has guest real mode accesses translated in roughly the normal wa=
y
but with some special parameters.

In POWER7 and POWER8 the LPCR[VPM0] bit selected between the two modes, b=
ut
in POWER9 only VRMA mode is supported and LPCR[VPM0] no longer exists.  W=
e
handle that difference in behaviour in ppc_hash64_set_isi().. but not in
other places that we blindly check LPCR[VPM0].

Correct those instances with a new helper to tell if we should be in VRMA
mode.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Fabiano Rosas <farosas@linux.ibm.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/ppc/mmu-hash64.c | 43 ++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 392f90e0ae..e372c42add 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -668,6 +668,21 @@ unsigned ppc_hash64_hpte_page_shift_noslb(PowerPCCPU=
 *cpu,
     return 0;
 }
=20
+static bool ppc_hash64_use_vrma(CPUPPCState *env)
+{
+    switch (env->mmu_model) {
+    case POWERPC_MMU_3_00:
+        /*
+         * ISAv3.0 (POWER9) always uses VRMA, the VPM0 field and RMOR
+         * register no longer exist
+         */
+        return true;
+
+    default:
+        return !!(env->spr[SPR_LPCR] & LPCR_VPM0);
+    }
+}
+
 static void ppc_hash64_set_isi(CPUState *cs, uint64_t error_code)
 {
     CPUPPCState *env =3D &POWERPC_CPU(cs)->env;
@@ -676,15 +691,7 @@ static void ppc_hash64_set_isi(CPUState *cs, uint64_=
t error_code)
     if (msr_ir) {
         vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM1);
     } else {
-        switch (env->mmu_model) {
-        case POWERPC_MMU_3_00:
-            /* Field deprecated in ISAv3.00 - interrupts always go to hy=
perv */
-            vpm =3D true;
-            break;
-        default:
-            vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM0);
-            break;
-        }
+        vpm =3D ppc_hash64_use_vrma(env);
     }
     if (vpm && !msr_hv) {
         cs->exception_index =3D POWERPC_EXCP_HISI;
@@ -702,15 +709,7 @@ static void ppc_hash64_set_dsi(CPUState *cs, uint64_=
t dar, uint64_t dsisr)
     if (msr_dr) {
         vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM1);
     } else {
-        switch (env->mmu_model) {
-        case POWERPC_MMU_3_00:
-            /* Field deprecated in ISAv3.00 - interrupts always go to hy=
perv */
-            vpm =3D true;
-            break;
-        default:
-            vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM0);
-            break;
-        }
+        vpm =3D ppc_hash64_use_vrma(env);
     }
     if (vpm && !msr_hv) {
         cs->exception_index =3D POWERPC_EXCP_HDSI;
@@ -799,7 +798,7 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vadd=
r eaddr,
             if (!(eaddr >> 63)) {
                 raddr |=3D env->spr[SPR_HRMOR];
             }
-        } else if (env->spr[SPR_LPCR] & LPCR_VPM0) {
+        } else if (ppc_hash64_use_vrma(env)) {
             /* Emulated VRMA mode */
             slb =3D &env->vrma_slb;
             if (!slb->sps) {
@@ -967,7 +966,7 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cpu=
, target_ulong addr)
         } else if ((msr_hv || !env->has_hv_mode) && !(addr >> 63)) {
             /* In HV mode, add HRMOR if top EA bit is clear */
             return raddr | env->spr[SPR_HRMOR];
-        } else if (env->spr[SPR_LPCR] & LPCR_VPM0) {
+        } else if (ppc_hash64_use_vrma(env)) {
             /* Emulated VRMA mode */
             slb =3D &env->vrma_slb;
             if (!slb->sps) {
@@ -1056,8 +1055,7 @@ static void ppc_hash64_update_vrma(PowerPCCPU *cpu)
     slb->sps =3D NULL;
=20
     /* Is VRMA enabled ? */
-    lpcr =3D env->spr[SPR_LPCR];
-    if (!(lpcr & LPCR_VPM0)) {
+    if (!ppc_hash64_use_vrma(env)) {
         return;
     }
=20
@@ -1065,6 +1063,7 @@ static void ppc_hash64_update_vrma(PowerPCCPU *cpu)
      * Make one up. Mostly ignore the ESID which will not be needed
      * for translation
      */
+    lpcr =3D env->spr[SPR_LPCR];
     vsid =3D SLB_VSID_VRMA;
     vrmasd =3D (lpcr & LPCR_VRMASD) >> LPCR_VRMASD_SHIFT;
     vsid |=3D (vrmasd << 4) & (SLB_VSID_L | SLB_VSID_LP);
--=20
2.24.1


