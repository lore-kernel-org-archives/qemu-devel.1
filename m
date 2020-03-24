Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9D8C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 05:19:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00C0820714
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 05:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oHnXJ7ZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C0820714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGbyP-0001xn-6n
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 01:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jGbu8-0004Zv-09
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 01:15:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jGbu6-0001dg-TG
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 01:15:07 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:48355)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jGbu6-0001Zi-IS; Tue, 24 Mar 2020 01:15:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48mfZW486Sz9sSL; Tue, 24 Mar 2020 16:14:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585026899;
 bh=fyHM/yk1VNQZCJUEsX1UnGiM8agi4dpqL7KxP+y+WHE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oHnXJ7ZWgcyMDuaxgHK09TOJ0YBUUf+pbiE5qC631GsHWqi8gGHpWDrvrgNYLDLXR
 GlwiqFhnk7wdIDlzW4+sZQt70F2xHX5a3SqZUi6Nl8Wl7i/mhLGUPxzuluwWWYmgL9
 xj8MpXZi2zMLr8cJ3kZbfvZTrTMlCjdPWaPCvijA=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 2/7] target/ppc: Fix slbia TLB invalidation gap
Date: Tue, 24 Mar 2020 16:14:51 +1100
Message-Id: <20200324051456.256116-3-david@gibson.dropbear.id.au>
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

slbia must invalidate TLBs even if it does not remove a valid SLB
entry, because slbmte can overwrite valid entries without removing
their TLBs.

As the architecture says, slbia invalidates all lookaside information,
not conditionally based on if it removed valid entries.

It does not seem possible for POWER8 or earlier Linux kernels to hit
this bug because it never changes its kernel SLB translations, and it
should always have valid entries if any accesses are made to userspace
regions. However other operating systems which may modify SLB entry 0
or do more fancy things with segments might be affected.

When POWER9 slbia support is added in the next patch, this becomes a
real problem because some new slbia variants don't invalidate all
non-zero entries.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20200318044135.851716-1-npiggin@gmail.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu-hash64.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 34f6009b1e..373d44de74 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -100,20 +100,29 @@ void helper_slbia(CPUPPCState *env)
     PowerPCCPU *cpu =3D env_archcpu(env);
     int n;
=20
+    /*
+     * slbia must always flush all TLB (which is equivalent to ERAT in p=
pc
+     * architecture). Matching on SLB_ESID_V is not good enough, because=
 slbmte
+     * can overwrite a valid SLB without flushing its lookaside informat=
ion.
+     *
+     * It would be possible to keep the TLB in synch with the SLB by flu=
shing
+     * when a valid entry is overwritten by slbmte, and therefore slbia =
would
+     * not have to flush unless it evicts a valid SLB entry. However it =
is
+     * expected that slbmte is more common than slbia, and slbia is usua=
lly
+     * going to evict valid SLB entries, so that tradeoff is unlikely to=
 be a
+     * good one.
+     */
+
     /* XXX: Warning: slbia never invalidates the first segment */
     for (n =3D 1; n < cpu->hash64_opts->slb_size; n++) {
         ppc_slb_t *slb =3D &env->slb[n];
=20
         if (slb->esid & SLB_ESID_V) {
             slb->esid &=3D ~SLB_ESID_V;
-            /*
-             * XXX: given the fact that segment size is 256 MB or 1TB,
-             *      and we still don't have a tlb_flush_mask(env, n, mas=
k)
-             *      in QEMU, we just invalidate all TLBs
-             */
-            env->tlb_need_flush |=3D TLB_NEED_LOCAL_FLUSH;
         }
     }
+
+    env->tlb_need_flush |=3D TLB_NEED_LOCAL_FLUSH;
 }
=20
 static void __helper_slbie(CPUPPCState *env, target_ulong addr,
--=20
2.25.1


