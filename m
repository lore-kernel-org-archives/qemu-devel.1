Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14964C35DE6
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 23:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D08772084E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 23:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MVskP6Sr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08772084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6NMm-0007Rk-Ub
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 18:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j6NIM-0006OE-H8
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 18:37:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j6NIL-00087B-0u
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 18:37:50 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:56073)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j6NIK-00083U-Lt; Mon, 24 Feb 2020 18:37:48 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48RJQ33F76z9sRQ; Tue, 25 Feb 2020 10:37:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582587451;
 bh=B3GfUzNMF7M6BEFyZO4sQHrqKaHlMmcM0FyDc/XxpkM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MVskP6SrV4+sUGY/ikbBsI2GSoEriO6ZLHsUozr9wmfjvbQtVweWeBWWGx70YUdVa
 yK9GnAttoeCRwEpkkRlUq4N00D+9ocYzMs7AqPuCT0b6ZLd9qRL5OPysdoUm766qJ9
 JcF6aS/qsKTS96k5hFUgWZvJqgCNNW7lG68NBWlY=
From: David Gibson <david@gibson.dropbear.id.au>
To: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
Subject: [PATCH v6 08/18] target/ppc: Use class fields to simplify LPCR masking
Date: Tue, 25 Feb 2020 10:37:14 +1100
Message-Id: <20200224233724.46415-9-david@gibson.dropbear.id.au>
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

When we store the Logical Partitioning Control Register (LPCR) we have a
big switch statement to work out which are valid bits for the cpu model
we're emulating.

As well as being ugly, this isn't really conceptually correct, since it i=
s
based on the mmu_model variable, whereas the LPCR isn't (only) about the
MMU, so mmu_model is basically just acting as a proxy for the cpu model.

Handle this in a simpler way, by adding a suitable lpcr_mask to the QOM
class.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/cpu-qom.h            |  1 +
 target/ppc/mmu-hash64.c         | 36 ++-------------------------------
 target/ppc/translate_init.inc.c | 27 +++++++++++++++++++++----
 3 files changed, 26 insertions(+), 38 deletions(-)

diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index e499575dc8..15d6b54a7d 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -177,6 +177,7 @@ typedef struct PowerPCCPUClass {
     uint64_t insns_flags;
     uint64_t insns_flags2;
     uint64_t msr_mask;
+    uint64_t lpcr_mask;         /* Available bits in the LPCR */
     uint64_t lpcr_pm;           /* Power-saving mode Exit Cause Enable b=
its */
     powerpc_mmu_t   mmu_model;
     powerpc_excp_t  excp_model;
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index caf47ad6fc..0ef330a614 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -1095,42 +1095,10 @@ static void ppc_hash64_update_vrma(PowerPCCPU *cp=
u)
=20
 void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val)
 {
+    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
     CPUPPCState *env =3D &cpu->env;
-    uint64_t lpcr =3D 0;
=20
-    /* Filter out bits */
-    switch (env->mmu_model) {
-    case POWERPC_MMU_2_03: /* P5p */
-        lpcr =3D val & (LPCR_RMLS | LPCR_ILE |
-                      LPCR_LPES0 | LPCR_LPES1 |
-                      LPCR_RMI | LPCR_HDICE);
-        break;
-    case POWERPC_MMU_2_06: /* P7 */
-        lpcr =3D val & (LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_DPFD |
-                      LPCR_VRMASD | LPCR_RMLS | LPCR_ILE |
-                      LPCR_P7_PECE0 | LPCR_P7_PECE1 | LPCR_P7_PECE2 |
-                      LPCR_MER | LPCR_TC |
-                      LPCR_LPES0 | LPCR_LPES1 | LPCR_HDICE);
-        break;
-    case POWERPC_MMU_2_07: /* P8 */
-        lpcr =3D val & (LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_KBV |
-                      LPCR_DPFD | LPCR_VRMASD | LPCR_RMLS | LPCR_ILE |
-                      LPCR_AIL | LPCR_ONL | LPCR_P8_PECE0 | LPCR_P8_PECE=
1 |
-                      LPCR_P8_PECE2 | LPCR_P8_PECE3 | LPCR_P8_PECE4 |
-                      LPCR_MER | LPCR_TC | LPCR_LPES0 | LPCR_HDICE);
-        break;
-    case POWERPC_MMU_3_00: /* P9 */
-        lpcr =3D val & (LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |
-                      (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR_A=
IL |
-                      LPCR_UPRT | LPCR_EVIRT | LPCR_ONL | LPCR_HR | LPCR=
_LD |
-                      (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE | LPCR_=
EEE |
-                      LPCR_DEE | LPCR_OEE)) | LPCR_MER | LPCR_GTSE | LPC=
R_TC |
-                      LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDICE);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-    env->spr[SPR_LPCR] =3D lpcr;
+    env->spr[SPR_LPCR] =3D val & pcc->lpcr_mask;
     ppc_hash64_update_rmls(cpu);
     ppc_hash64_update_vrma(cpu);
 }
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index 925bc31ca5..5b7a5226e1 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8476,6 +8476,8 @@ POWERPC_FAMILY(POWER5P)(ObjectClass *oc, void *data=
)
                     (1ull << MSR_DR) |
                     (1ull << MSR_PMM) |
                     (1ull << MSR_RI);
+    pcc->lpcr_mask =3D LPCR_RMLS | LPCR_ILE | LPCR_LPES0 | LPCR_LPES1 |
+        LPCR_RMI | LPCR_HDICE;
     pcc->mmu_model =3D POWERPC_MMU_2_03;
 #if defined(CONFIG_SOFTMMU)
     pcc->handle_mmu_fault =3D ppc_hash64_handle_mmu_fault;
@@ -8653,6 +8655,12 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *data=
)
                     (1ull << MSR_PMM) |
                     (1ull << MSR_RI) |
                     (1ull << MSR_LE);
+    pcc->lpcr_mask =3D LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_DPFD |
+        LPCR_VRMASD | LPCR_RMLS | LPCR_ILE |
+        LPCR_P7_PECE0 | LPCR_P7_PECE1 | LPCR_P7_PECE2 |
+        LPCR_MER | LPCR_TC |
+        LPCR_LPES0 | LPCR_LPES1 | LPCR_HDICE;
+    pcc->lpcr_pm =3D LPCR_P7_PECE0 | LPCR_P7_PECE1 | LPCR_P7_PECE2;
     pcc->mmu_model =3D POWERPC_MMU_2_06;
 #if defined(CONFIG_SOFTMMU)
     pcc->handle_mmu_fault =3D ppc_hash64_handle_mmu_fault;
@@ -8669,7 +8677,6 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *data)
     pcc->l1_dcache_size =3D 0x8000;
     pcc->l1_icache_size =3D 0x8000;
     pcc->interrupts_big_endian =3D ppc_cpu_interrupts_big_endian_lpcr;
-    pcc->lpcr_pm =3D LPCR_P7_PECE0 | LPCR_P7_PECE1 | LPCR_P7_PECE2;
 }
=20
 static void init_proc_POWER8(CPUPPCState *env)
@@ -8825,6 +8832,13 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data=
)
                     (1ull << MSR_TS0) |
                     (1ull << MSR_TS1) |
                     (1ull << MSR_LE);
+    pcc->lpcr_mask =3D LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_KBV |
+        LPCR_DPFD | LPCR_VRMASD | LPCR_RMLS | LPCR_ILE |
+        LPCR_AIL | LPCR_ONL | LPCR_P8_PECE0 | LPCR_P8_PECE1 |
+        LPCR_P8_PECE2 | LPCR_P8_PECE3 | LPCR_P8_PECE4 |
+        LPCR_MER | LPCR_TC | LPCR_LPES0 | LPCR_HDICE;
+    pcc->lpcr_pm =3D LPCR_P8_PECE0 | LPCR_P8_PECE1 | LPCR_P8_PECE2 |
+                   LPCR_P8_PECE3 | LPCR_P8_PECE4;
     pcc->mmu_model =3D POWERPC_MMU_2_07;
 #if defined(CONFIG_SOFTMMU)
     pcc->handle_mmu_fault =3D ppc_hash64_handle_mmu_fault;
@@ -8842,8 +8856,6 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
     pcc->l1_dcache_size =3D 0x8000;
     pcc->l1_icache_size =3D 0x8000;
     pcc->interrupts_big_endian =3D ppc_cpu_interrupts_big_endian_lpcr;
-    pcc->lpcr_pm =3D LPCR_P8_PECE0 | LPCR_P8_PECE1 | LPCR_P8_PECE2 |
-                   LPCR_P8_PECE3 | LPCR_P8_PECE4;
 }
=20
 #ifdef CONFIG_SOFTMMU
@@ -9036,6 +9048,14 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data=
)
                     (1ull << MSR_PMM) |
                     (1ull << MSR_RI) |
                     (1ull << MSR_LE);
+    pcc->lpcr_mask =3D LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |
+        (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR_AIL |
+        LPCR_UPRT | LPCR_EVIRT | LPCR_ONL | LPCR_HR | LPCR_LD |
+        (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE | LPCR_EEE |
+                             LPCR_DEE | LPCR_OEE))
+        | LPCR_MER | LPCR_GTSE | LPCR_TC |
+        LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDICE;
+    pcc->lpcr_pm =3D LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPCR_=
OEE;
     pcc->mmu_model =3D POWERPC_MMU_3_00;
 #if defined(CONFIG_SOFTMMU)
     pcc->handle_mmu_fault =3D ppc64_v3_handle_mmu_fault;
@@ -9055,7 +9075,6 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
     pcc->l1_dcache_size =3D 0x8000;
     pcc->l1_icache_size =3D 0x8000;
     pcc->interrupts_big_endian =3D ppc_cpu_interrupts_big_endian_lpcr;
-    pcc->lpcr_pm =3D LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPCR_=
OEE;
 }
=20
 #ifdef CONFIG_SOFTMMU
--=20
2.24.1


