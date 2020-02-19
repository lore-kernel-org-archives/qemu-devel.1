Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B9DC3404C
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 00:55:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7671D24655
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 00:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="l/aGQ+YF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7671D24655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4DeJ-0002tL-MA
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 19:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j4DdD-00016k-LN
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 19:54:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j4DdC-0001F1-8n
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 19:54:27 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:57369 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j4DdB-0001Ci-Ug; Tue, 18 Feb 2020 19:54:26 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48MfPT0qFfz9sRt; Wed, 19 Feb 2020 11:54:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582073661;
 bh=8MpdR9QOB+wpJchmvKQltUcpEnrUwRlC7qih1/K4psQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=l/aGQ+YF6vxQtH0wPAIwRFZHbL+TpT7PxROjFiKF2vqJuXsVhpV1sAz9LOG40QaqL
 f7eE5xWskLuKjXUfR8YTVaVUflUq/8xvjnMB0TV4X3yqZ+bTRLUNTYE9lwi1ZnStZD
 OVOXInFNW7u0awJuf6U+OmccmKweeDzHVujfkPQY=
From: David Gibson <david@gibson.dropbear.id.au>
To: groug@kaod.org,
	philmd@redhat.com,
	qemu-devel@nongnu.org,
	clg@kaod.org
Subject: [PATCH v3 03/12] target/ppc: Correct handling of real mode accesses
 with vhyp on hash MMU
Date: Wed, 19 Feb 2020 11:54:05 +1100
Message-Id: <20200219005414.15635-4-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219005414.15635-1-david@gibson.dropbear.id.au>
References: <20200219005414.15635-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, paulus@samba.org,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On ppc we have the concept of virtual hypervisor ("vhyp") mode, where we
only model the non-hypervisor-privileged parts of the cpu.  Essentially w=
e
model the hypervisor's behaviour from the point of view of a guest OS, bu=
t
we don't model the hypervisor's execution.

In particular, in this mode, qemu's notion of target physical address is
a guest physical address from the vcpu's point of view.  So accesses in
guest real mode don't require translation.  If we were modelling the
hypervisor mode, we'd need to translate the guest physical address into
a host physical address.

Currently, we handle this sloppily: we rely on setting up the virtual LPC=
R
and RMOR registers so that GPAs are simply HPAs plus an offset, which we
set to zero.  This is already conceptually dubious, since the LPCR and RM=
OR
registers don't exist in the non-hypervisor portion of the CPU.  It gets
worse with POWER9, where RMOR and LPCR[VPM0] no longer exist at all.

Clean this up by explicitly handling the vhyp case.  While we're there,
remove some unnecessary nesting of if statements that made the logic to
select the correct real mode behaviour a bit less clear than it could be.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/mmu-hash64.c | 60 ++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index a881876647..5fabd93c92 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -789,27 +789,30 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, va=
ddr eaddr,
          */
         raddr =3D eaddr & 0x0FFFFFFFFFFFFFFFULL;
=20
-        /* In HV mode, add HRMOR if top EA bit is clear */
-        if (msr_hv || !env->has_hv_mode) {
+        if (cpu->vhyp) {
+            /*
+             * In virtual hypervisor mode, there's nothing to do:
+             *   EA =3D=3D GPA =3D=3D qemu guest address
+             */
+        } else if (msr_hv || !env->has_hv_mode) {
+            /* In HV mode, add HRMOR if top EA bit is clear */
             if (!(eaddr >> 63)) {
                 raddr |=3D env->spr[SPR_HRMOR];
             }
-        } else {
-            /* Otherwise, check VPM for RMA vs VRMA */
-            if (env->spr[SPR_LPCR] & LPCR_VPM0) {
-                slb =3D &env->vrma_slb;
-                if (slb->sps) {
-                    goto skip_slb_search;
-                }
-                /* Not much else to do here */
+        } else if (env->spr[SPR_LPCR] & LPCR_VPM0) {
+            /* Emulated VRMA mode */
+            slb =3D &env->vrma_slb;
+            if (!slb->sps) {
+                /* Invalid VRMA setup, machine check */
                 cs->exception_index =3D POWERPC_EXCP_MCHECK;
                 env->error_code =3D 0;
                 return 1;
-            } else if (raddr < env->rmls) {
-                /* RMA. Check bounds in RMLS */
-                raddr |=3D env->spr[SPR_RMOR];
-            } else {
-                /* The access failed, generate the approriate interrupt =
*/
+            }
+
+            goto skip_slb_search;
+        } else {
+            /* Emulated old-style RMO mode, bounds check against RMLS */
+            if (raddr >=3D env->rmls) {
                 if (rwx =3D=3D 2) {
                     ppc_hash64_set_isi(cs, SRR1_PROTFAULT);
                 } else {
@@ -821,6 +824,8 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vadd=
r eaddr,
                 }
                 return 1;
             }
+
+            raddr |=3D env->spr[SPR_RMOR];
         }
         tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr & TARGET_PAGE_M=
ASK,
                      PAGE_READ | PAGE_WRITE | PAGE_EXEC, mmu_idx,
@@ -953,22 +958,27 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *c=
pu, target_ulong addr)
         /* In real mode the top 4 effective address bits are ignored */
         raddr =3D addr & 0x0FFFFFFFFFFFFFFFULL;
=20
-        /* In HV mode, add HRMOR if top EA bit is clear */
-        if ((msr_hv || !env->has_hv_mode) && !(addr >> 63)) {
+        if (cpu->vhyp) {
+            /*
+             * In virtual hypervisor mode, there's nothing to do:
+             *   EA =3D=3D GPA =3D=3D qemu guest address
+             */
+            return raddr;
+        } else if ((msr_hv || !env->has_hv_mode) && !(addr >> 63)) {
+            /* In HV mode, add HRMOR if top EA bit is clear */
             return raddr | env->spr[SPR_HRMOR];
-        }
-
-        /* Otherwise, check VPM for RMA vs VRMA */
-        if (env->spr[SPR_LPCR] & LPCR_VPM0) {
+        } else if (env->spr[SPR_LPCR] & LPCR_VPM0) {
+            /* Emulated VRMA mode */
             slb =3D &env->vrma_slb;
             if (!slb->sps) {
                 return -1;
             }
-        } else if (raddr < env->rmls) {
-            /* RMA. Check bounds in RMLS */
-            return raddr | env->spr[SPR_RMOR];
         } else {
-            return -1;
+            /* Emulated old-style RMO mode, bounds check against RMLS */
+            if (raddr >=3D env->rmls) {
+                return -1;
+            }
+            return raddr | env->spr[SPR_RMOR];
         }
     } else {
         slb =3D slb_lookup(cpu, addr);
--=20
2.24.1


