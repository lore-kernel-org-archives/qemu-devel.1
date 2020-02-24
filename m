Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B50C35DEA
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 23:43:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F13962084E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 23:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="WG6vednr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13962084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6NO4-0001wR-3d
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 18:43:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j6NIQ-0006Yd-7X
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 18:37:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j6NIO-00089S-D4
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 18:37:54 -0500
Received: from ozlabs.org ([203.11.71.1]:39877)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j6NIO-00083u-0s; Mon, 24 Feb 2020 18:37:52 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48RJQ34nRMz9sRp; Tue, 25 Feb 2020 10:37:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582587451;
 bh=byjkajhVcCgIMe86g8VOYlz/YD67HxIZQoRkU7kw4HA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WG6vednrmdV7C8PICKPzvmGD5K5/CfmI588psqCJeyfD922x+JJ0JU29gk3KTvCMP
 CNi2FpgBu77PMT1TSadBZji/MxAGU1p+eHqYkvEuy2yxzV3Au0v5uxFXpXW5MByTno
 xzmr/JOBBOaH/KADXP157WfOPwmIEsVN+3Zl00kA=
From: David Gibson <david@gibson.dropbear.id.au>
To: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
Subject: [PATCH v6 09/18] target/ppc: Streamline calculation of RMA limit from
 LPCR[RMLS]
Date: Tue, 25 Feb 2020 10:37:15 +1100
Message-Id: <20200224233724.46415-10-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200224233724.46415-1-david@gibson.dropbear.id.au>
References: <20200224233724.46415-1-david@gibson.dropbear.id.au>
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

Currently we use a big switch statement in ppc_hash64_update_rmls() to wo=
rk
out what the right RMA limit is based on the LPCR[RMLS] field.  There's n=
o
formula for this - it's just an arbitrary mapping defined by the existing
CPU implementations - but we can make it a bit more readable by using a
lookup table rather than a switch.  In addition we can use the MiB/GiB
symbols to make it a bit clearer.

While there we add a bit of clarity and rationale to the comment about
what happens if the LPCR[RMLS] doesn't contain a valid value.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/mmu-hash64.c | 71 ++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 36 deletions(-)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 0ef330a614..4f082d775d 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -18,6 +18,7 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
@@ -757,6 +758,39 @@ static void ppc_hash64_set_c(PowerPCCPU *cpu, hwaddr=
 ptex, uint64_t pte1)
     stb_phys(CPU(cpu)->as, base + offset, (pte1 & 0xff) | 0x80);
 }
=20
+static target_ulong rmls_limit(PowerPCCPU *cpu)
+{
+    CPUPPCState *env =3D &cpu->env;
+    /*
+     * This is the full 4 bits encoding of POWER8. Previous
+     * CPUs only support a subset of these but the filtering
+     * is done when writing LPCR
+     */
+    const target_ulong rma_sizes[] =3D {
+        [0] =3D 0,
+        [1] =3D 16 * GiB,
+        [2] =3D 1 * GiB,
+        [3] =3D 64 * MiB,
+        [4] =3D 256 * MiB,
+        [5] =3D 0,
+        [6] =3D 0,
+        [7] =3D 128 * MiB,
+        [8] =3D 32 * MiB,
+    };
+    target_ulong rmls =3D (env->spr[SPR_LPCR] & LPCR_RMLS) >> LPCR_RMLS_=
SHIFT;
+
+    if (rmls < ARRAY_SIZE(rma_sizes)) {
+        return rma_sizes[rmls];
+    } else {
+        /*
+         * Bad value, so the OS has shot itself in the foot.  Return a
+         * 0-sized RMA which we expect to trigger an immediate DSI or
+         * ISI
+         */
+        return 0;
+    }
+}
+
 int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr,
                                 int rwx, int mmu_idx)
 {
@@ -1006,41 +1040,6 @@ void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu, ta=
rget_ulong ptex,
     cpu->env.tlb_need_flush =3D TLB_NEED_GLOBAL_FLUSH | TLB_NEED_LOCAL_F=
LUSH;
 }
=20
-static void ppc_hash64_update_rmls(PowerPCCPU *cpu)
-{
-    CPUPPCState *env =3D &cpu->env;
-    uint64_t lpcr =3D env->spr[SPR_LPCR];
-
-    /*
-     * This is the full 4 bits encoding of POWER8. Previous
-     * CPUs only support a subset of these but the filtering
-     * is done when writing LPCR
-     */
-    switch ((lpcr & LPCR_RMLS) >> LPCR_RMLS_SHIFT) {
-    case 0x8: /* 32MB */
-        env->rmls =3D 0x2000000ull;
-        break;
-    case 0x3: /* 64MB */
-        env->rmls =3D 0x4000000ull;
-        break;
-    case 0x7: /* 128MB */
-        env->rmls =3D 0x8000000ull;
-        break;
-    case 0x4: /* 256MB */
-        env->rmls =3D 0x10000000ull;
-        break;
-    case 0x2: /* 1GB */
-        env->rmls =3D 0x40000000ull;
-        break;
-    case 0x1: /* 16GB */
-        env->rmls =3D 0x400000000ull;
-        break;
-    default:
-        /* What to do here ??? */
-        env->rmls =3D 0;
-    }
-}
-
 static void ppc_hash64_update_vrma(PowerPCCPU *cpu)
 {
     CPUPPCState *env =3D &cpu->env;
@@ -1099,7 +1098,7 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong v=
al)
     CPUPPCState *env =3D &cpu->env;
=20
     env->spr[SPR_LPCR] =3D val & pcc->lpcr_mask;
-    ppc_hash64_update_rmls(cpu);
+    env->rmls =3D rmls_limit(cpu);
     ppc_hash64_update_vrma(cpu);
 }
=20
--=20
2.24.1


