Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6681C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:23:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CF05205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="qInBKg/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF05205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9Nv-0002hy-Op
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jE95u-0001NW-KF
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jE95r-0003un-5k
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:06 -0400
Received: from ozlabs.org ([203.11.71.1]:53971)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jE95q-0003ar-OO; Tue, 17 Mar 2020 06:05:03 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hTKz6Bwbz9sTN; Tue, 17 Mar 2020 21:04:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584439479;
 bh=FaXtE4aVP4kSFiv6Zc0QMgus3jnk/WUhyrbIvs+5kNs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qInBKg/lIeCK5dWDLkc9bQBu0Z8K0qJuHmIaHQdyNkBb2qHgWc2uHa/AUo7xzq4Jn
 F2dQCZYTUHFsXHgTzBUpLtbzhVNtUt28M/JUukhDPL2EO393dpCr56fGcaUxLYLfp5
 yCd++BEwcY2pzwCFuW7cdp7FrsrYHPrV4lKM9mCg=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 31/45] ppc/spapr: Move GPRs setup to one place
Date: Tue, 17 Mar 2020 21:04:09 +1100
Message-Id: <20200317100423.622643-32-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317100423.622643-1-david@gibson.dropbear.id.au>
References: <20200317100423.622643-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

At the moment "pseries" starts in SLOF which only expects the FDT blob
pointer in r3. As we are going to introduce a OpenFirmware support in
QEMU, we will be booting OF clients directly and these expect a stack
pointer in r1, Linux looks at r3/r4 for the initramdisk location
(although vmlinux can find this from the device tree but zImage from
distro kernels cannot).

This extends spapr_cpu_set_entry_state() to take more registers. This
should cause no behavioral change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20200310050733.29805-2-aik@ozlabs.ru>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c                  | 2 +-
 hw/ppc/spapr_cpu_core.c         | 6 +++++-
 hw/ppc/spapr_rtas.c             | 2 +-
 include/hw/ppc/spapr_cpu_core.h | 4 +++-
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1950fc303e..1038420c4a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1698,7 +1698,7 @@ static void spapr_machine_reset(MachineState *machi=
ne)
     spapr->fdt_blob =3D fdt;
=20
     /* Set up the entry state */
-    spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_addr=
);
+    spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, 0, fdt_a=
ddr, 0);
     first_ppc_cpu->env.gpr[5] =3D 0;
=20
     spapr->cas_reboot =3D false;
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 36ed3a2b66..ac1c109427 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -76,13 +76,17 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
     spapr_irq_cpu_intc_reset(spapr, cpu);
 }
=20
-void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target=
_ulong r3)
+void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip,
+                               target_ulong r1, target_ulong r3,
+                               target_ulong r4)
 {
     PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
     CPUPPCState *env =3D &cpu->env;
=20
     env->nip =3D nip;
+    env->gpr[1] =3D r1;
     env->gpr[3] =3D r3;
+    env->gpr[4] =3D r4;
     kvmppc_set_reg_ppc_online(cpu, 1);
     CPU(cpu)->halted =3D 0;
     /* Enable Power-saving mode Exit Cause exceptions */
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 656fdd2216..fe83b50c66 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -190,7 +190,7 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, Spapr=
MachineState *spapr,
      */
     newcpu->env.tb_env->tb_offset =3D callcpu->env.tb_env->tb_offset;
=20
-    spapr_cpu_set_entry_state(newcpu, start, r3);
+    spapr_cpu_set_entry_state(newcpu, start, 0, r3, 0);
=20
     qemu_cpu_kick(CPU(newcpu));
=20
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_c=
ore.h
index 1c4cc6559c..7aed8f555b 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -40,7 +40,9 @@ typedef struct SpaprCpuCoreClass {
 } SpaprCpuCoreClass;
=20
 const char *spapr_get_cpu_core_type(const char *cpu_type);
-void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target=
_ulong r3);
+void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip,
+                               target_ulong r1, target_ulong r3,
+                               target_ulong r4);
=20
 typedef struct SpaprCpuState {
     uint64_t vpa_addr;
--=20
2.24.1


