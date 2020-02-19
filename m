Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8E7C3404C
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 00:57:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A58F2173E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 00:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IuAHvI0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A58F2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Dfj-0005wD-Md
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 19:57:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j4DdF-00017F-OO
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 19:54:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j4DdE-0001Il-7D
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 19:54:29 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:45041 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j4DdD-0001Et-Rc; Tue, 18 Feb 2020 19:54:28 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48MfPV3qstz9sSR; Wed, 19 Feb 2020 11:54:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582073662;
 bh=HirC5LnAA2uH/j722kBhQYsc7XAq/CG4RjWXhAM+wiE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IuAHvI0sUnj0MVnGCGbqXWx7VQq+OlAQhcTrLfUgVf14v3J1uhByBG3JuPHUUoWJq
 kJRJz1I0dWarIH97w272e2/AtL8vzzfU1LdkEsUUGAyrLDXDIlRpnL3tzMNUyBcgkZ
 S3bO00SnwMKLuhtXb7l+YloLNiFygKZO96u6XR+8=
From: David Gibson <david@gibson.dropbear.id.au>
To: groug@kaod.org,
	philmd@redhat.com,
	qemu-devel@nongnu.org,
	clg@kaod.org
Subject: [PATCH v3 10/12] target/ppc: Only calculate RMLS derived RMA limit on
 demand
Date: Wed, 19 Feb 2020 11:54:12 +1100
Message-Id: <20200219005414.15635-11-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219005414.15635-1-david@gibson.dropbear.id.au>
References: <20200219005414.15635-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 target/ppc/cpu.h        | 1 -
 target/ppc/mmu-hash64.c | 8 +++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

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
index e6f24be93e..170a78bd2e 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -842,8 +842,10 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vad=
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
@@ -1005,8 +1007,9 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *c=
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
@@ -1096,7 +1099,6 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong v=
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


