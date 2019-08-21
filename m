Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8505DC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:45:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BDDD2339F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="azlSd8yr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BDDD2339F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0LJ5-0002G4-QN
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 03:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0R-0004Zy-R8
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0Q-000853-8B
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:07 -0400
Received: from ozlabs.org ([203.11.71.1]:44371)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i0L0N-0007zp-QY; Wed, 21 Aug 2019 03:26:04 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46CzjB1GyDz9sQn; Wed, 21 Aug 2019 17:25:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566372350;
 bh=+ll5cKS8GpOsg1khTBTggYL8D2mfNQnbIIz1+Y1r/oc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=azlSd8yrrBNnQcLtQ/iPF/8qkBll2P8rZUH5mD+8UVayCCFCplNMTJ6+GP8SXcE2k
 B8Ds2FvN+wOLCMvVwFb9SPQ+iwshZ4TzoRzoJUwZGcNP7bb+RRJ8ljaX04BT7a29Vq
 zubuzSg18TBzVJ6pHNFTSdhFAK2C4ySK8fkwNj6g=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 21 Aug 2019 17:25:16 +1000
Message-Id: <20190821072542.23090-17-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821072542.23090-1-david@gibson.dropbear.id.au>
References: <20190821072542.23090-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 16/42] spapr: Implement H_PROD
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, groug@kaod.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nicholas Piggin <npiggin@gmail.com>

H_PROD is added, and H_CEDE is modified to test the prod bit
according to PAPR.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20190718034214.14948-3-npiggin@gmail.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c                  |  1 +
 hw/ppc/spapr_hcall.c            | 32 ++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr_cpu_core.h |  1 +
 3 files changed, 34 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 08cc7c2bd6..0890c2840f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4312,6 +4312,7 @@ static void spapr_cpu_exec_enter(PPCVirtualHypervis=
or *vhyp, PowerPCCPU *cpu)
=20
     /* These are only called by TCG, KVM maintains dispatch state */
=20
+    spapr_cpu->prod =3D false;
     if (spapr_cpu->vpa_addr) {
         CPUState *cs =3D CPU(cpu);
         uint32_t dispatch;
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 4c5ea17250..dd584da1ce 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1051,14 +1051,44 @@ static target_ulong h_cede(PowerPCCPU *cpu, Spapr=
MachineState *spapr,
 {
     CPUPPCState *env =3D &cpu->env;
     CPUState *cs =3D CPU(cpu);
+    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
=20
     env->msr |=3D (1ULL << MSR_EE);
     hreg_compute_hflags(env);
+
+    if (spapr_cpu->prod) {
+        spapr_cpu->prod =3D false;
+        return H_SUCCESS;
+    }
+
     if (!cpu_has_work(cs)) {
         cs->halted =3D 1;
         cs->exception_index =3D EXCP_HLT;
         cs->exit_request =3D 1;
     }
+
+    return H_SUCCESS;
+}
+
+static target_ulong h_prod(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                           target_ulong opcode, target_ulong *args)
+{
+    target_long target =3D args[0];
+    PowerPCCPU *tcpu;
+    CPUState *cs;
+    SpaprCpuState *spapr_cpu;
+
+    tcpu =3D spapr_find_cpu(target);
+    cs =3D CPU(tcpu);
+    if (!cs) {
+        return H_PARAMETER;
+    }
+
+    spapr_cpu =3D spapr_cpu_state(tcpu);
+    spapr_cpu->prod =3D true;
+    cs->halted =3D 0;
+    qemu_cpu_kick(cs);
+
     return H_SUCCESS;
 }
=20
@@ -1885,6 +1915,8 @@ static void hypercall_register_types(void)
     /* hcall-splpar */
     spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
     spapr_register_hypercall(H_CEDE, h_cede);
+    spapr_register_hypercall(H_PROD, h_prod);
+
     spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);
=20
     /* processor register resource access h-calls */
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_c=
ore.h
index 35e0a7eead..1c4cc6559c 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -46,6 +46,7 @@ typedef struct SpaprCpuState {
     uint64_t vpa_addr;
     uint64_t slb_shadow_addr, slb_shadow_size;
     uint64_t dtl_addr, dtl_size;
+    bool prod; /* not migrated, only used to improve dispatch latencies =
*/
     struct ICPState *icp;
     struct XiveTCTX *tctx;
 } SpaprCpuState;
--=20
2.21.0


