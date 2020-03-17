Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5201C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:36:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0AEA206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="iIMZrzVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0AEA206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9aG-0005X7-SZ
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jE96W-0002Ph-MB
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jE96U-0008Td-Kv
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:44 -0400
Received: from ozlabs.org ([203.11.71.1]:41279)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jE96U-0008DY-79; Tue, 17 Mar 2020 06:05:42 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hTL34bSpz9sTd; Tue, 17 Mar 2020 21:04:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584439483;
 bh=K5aTTPyNTiXqeOFBunos2P9/ndyBJIQYmUSNYf41ZFc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iIMZrzVdNvmPhM6YjcW+ERmTHq82D/SPCh7tlGw1FUDJn+UeeRj63ht8HByWXD021
 T3e3EabJdXqFv68QOvZe8RgaOD+hzEN94x+9aqpQvqIXSgumFvshLV4PWwL61HXqEj
 DxpFRY0POwSZUwLYpEk+qqQ0eTj1Fks1fFpOfYWo=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 43/45] ppc/spapr: Implement FWNMI System Reset delivery
Date: Tue, 17 Mar 2020 21:04:21 +1100
Message-Id: <20200317100423.622643-44-david@gibson.dropbear.id.au>
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
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nicholas Piggin <npiggin@gmail.com>

PAPR requires that if "ibm,nmi-register" succeeds, then the hypervisor
delivers all system reset and machine check exceptions to the registered
addresses.

System Resets are delivered with registers set to the architected state,
and with no interlock.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20200316142613.121089-8-npiggin@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6d65c0797b..8fcd21ac7b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -951,7 +951,29 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, =
void *fdt)
     _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
                      maxdomains, sizeof(maxdomains)));
=20
-    _FDT(fdt_setprop_cell(fdt, rtas, "rtas-size", RTAS_SIZE));
+    /*
+     * FWNMI reserves RTAS_ERROR_LOG_MAX for the machine check error log=
,
+     * and 16 bytes per CPU for system reset error log plus an extra 8 b=
ytes.
+     *
+     * The system reset requirements are driven by existing Linux and Po=
werVM
+     * implementation which (contrary to PAPR) saves r3 in the error log
+     * structure like machine check, so Linux expects to find the saved =
r3
+     * value at the address in r3 upon FWNMI-enabled sreset interrupt (a=
nd
+     * does not look at the error value).
+     *
+     * System reset interrupts are not subject to interlock like machine
+     * check, so this memory area could be corrupted if the sreset is
+     * interrupted by a machine check (or vice versa) if it was shared. =
To
+     * prevent this, system reset uses per-CPU areas for the sreset save
+     * area. A system reset that interrupts a system reset handler could
+     * still overwrite this area, but Linux doesn't try to recover in th=
at
+     * case anyway.
+     *
+     * The extra 8 bytes is required because Linux's FWNMI error log che=
ck
+     * is off-by-one.
+     */
+    _FDT(fdt_setprop_cell(fdt, rtas, "rtas-size", RTAS_ERROR_LOG_MAX +
+			  ms->smp.max_cpus * sizeof(uint64_t)*2 + sizeof(uint64_t)));
     _FDT(fdt_setprop_cell(fdt, rtas, "rtas-error-log-max",
                           RTAS_ERROR_LOG_MAX));
     _FDT(fdt_setprop_cell(fdt, rtas, "rtas-event-scan-rate",
@@ -3384,8 +3406,28 @@ static void spapr_machine_finalizefn(Object *obj)
=20
 void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg)
 {
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
+
     cpu_synchronize_state(cs);
-    ppc_cpu_do_system_reset(cs, -1);
+    /* If FWNMI is inactive, addr will be -1, which will deliver to 0x10=
0 */
+    if (spapr->fwnmi_system_reset_addr !=3D -1) {
+        uint64_t rtas_addr, addr;
+        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+        CPUPPCState *env =3D &cpu->env;
+
+        /* get rtas addr from fdt */
+        rtas_addr =3D spapr_get_rtas_addr();
+        if (!rtas_addr) {
+            qemu_system_guest_panicked(NULL);
+            return;
+        }
+
+        addr =3D rtas_addr + RTAS_ERROR_LOG_MAX + cs->cpu_index * sizeof=
(uint64_t)*2;
+        stq_be_phys(&address_space_memory, addr, env->gpr[3]);
+        stq_be_phys(&address_space_memory, addr + sizeof(uint64_t), 0);
+        env->gpr[3] =3D addr;
+    }
+    ppc_cpu_do_system_reset(cs, spapr->fwnmi_system_reset_addr);
 }
=20
 static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)
--=20
2.24.1


