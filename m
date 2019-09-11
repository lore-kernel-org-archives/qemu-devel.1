Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C282C4360D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 04:10:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E937020B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 04:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="E+eVjgv+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E937020B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7txi-0006Dv-LV
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 00:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i7tsS-0000TE-8T
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 00:05:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i7tsO-0002nq-89
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 00:05:06 -0400
Received: from ozlabs.org ([203.11.71.1]:44519)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i7tsK-0002gG-Gr; Wed, 11 Sep 2019 00:05:02 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46SpFg55LSz9sDB; Wed, 11 Sep 2019 14:04:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1568174695;
 bh=M/opkdlGyilRi9732MZlFGdJqgm95fZi8DV2n5tc3FM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=E+eVjgv+3RmcxIQtxnnylaWYQSPtu6tbYyY1nc/FPj1iE1sv5xaGAnKbeNxzzIxOj
 P7X5JVOUVJIFZVMpB5lDK2Fwz9nfSIbviTyb/weAmXRaVgNoVT0jkcI0gMl0MfU75a
 /H65ds1CAKKDJw8jfR4j2pa99Sd9FypXWjzViQFI=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Date: Wed, 11 Sep 2019 14:04:47 +1000
Message-Id: <20190911040452.8341-3-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190911040452.8341-1-david@gibson.dropbear.id.au>
References: <20190911040452.8341-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PATCH 2/7] spapr: Move handling of special NVLink
 numa node from reset to init
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, groug@kaod.org, clg@kaod.org,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The number of NUMA nodes in the system is fixed from the command line.
Therefore, there's no need to recalculate it at reset time, and we can
determine the special gpu_numa_id value used for NVLink2 devices at init
time.

This simplifies the reset path a bit which will make further improvements
easier.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c551001f86..e03e874d94 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1737,16 +1737,6 @@ static void spapr_machine_reset(MachineState *mach=
ine)
         spapr_setup_hpt_and_vrma(spapr);
     }
=20
-    /*
-     * NVLink2-connected GPU RAM needs to be placed on a separate NUMA n=
ode.
-     * We assign a new numa ID per GPU in spapr_pci_collect_nvgpu() whic=
h is
-     * called from vPHB reset handler so we initialize the counter here.
-     * If no NUMA is configured from the QEMU side, we start from 1 as G=
PU RAM
-     * must be equally distant from any other node.
-     * The final value of spapr->gpu_numa_id is going to be written to
-     * max-associativity-domains in spapr_build_fdt().
-     */
-    spapr->gpu_numa_id =3D MAX(1, machine->numa_state->num_nodes);
     qemu_devices_reset();
=20
     /*
@@ -2885,6 +2875,17 @@ static void spapr_machine_init(MachineState *machi=
ne)
=20
     }
=20
+    /*
+     * NVLink2-connected GPU RAM needs to be placed on a separate NUMA n=
ode.
+     * We assign a new numa ID per GPU in spapr_pci_collect_nvgpu() whic=
h is
+     * called from vPHB reset handler so we initialize the counter here.
+     * If no NUMA is configured from the QEMU side, we start from 1 as G=
PU RAM
+     * must be equally distant from any other node.
+     * The final value of spapr->gpu_numa_id is going to be written to
+     * max-associativity-domains in spapr_build_fdt().
+     */
+    spapr->gpu_numa_id =3D MAX(1, machine->numa_state->num_nodes);
+
     if ((!kvm_enabled() || kvmppc_has_cap_mmu_radix()) &&
         ppc_type_check_compat(machine->cpu_type, CPU_POWERPC_LOGICAL_3_0=
0, 0,
                               spapr->max_compat_pvr)) {
--=20
2.21.0


