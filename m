Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448B4C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:48:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BE0E207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="M0TgmIqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE0E207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGKCC-0006hx-Oj
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 05:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2C-0004ox-KF
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2B-0004yz-8P
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:00 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:40407)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iGK2A-0004vb-Ik; Fri, 04 Oct 2019 05:37:59 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46l4YF2cj7z9sQr; Fri,  4 Oct 2019 19:37:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570181873;
 bh=/oZDVF21q5ldi/LJUcKXo3PwQOCZ89OvT9/Euvjhszs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=M0TgmIqo+BMR1/3IzqiB7yx1GpgN2i9VmRvG/BCEqkrsppFJfAS8oXZhoDU+bLawD
 ed86Cvfr+YaA91NfAzI1gz8pDhrfA3znwS740S9LxJd68w3ANi/qPiSfkK0yZFvBqf
 9U9VB9Uu6C0UJ+fmDACNcO20IOvJpjIXxo/rXyT0=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 01/53] pseries: do not allow memory-less/cpu-less NUMA node
Date: Fri,  4 Oct 2019 19:36:55 +1000
Message-Id: <20191004093747.31350-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191004093747.31350-1-david@gibson.dropbear.id.au>
References: <20191004093747.31350-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <lvivier@redhat.com>

When we hotplug a CPU on memory-less/cpu-less node, the linux kernel
crashes.

This happens because linux kernel needs to know the NUMA topology at
start to be able to initialize the distance lookup table.

On pseries, the topology is provided by the firmware via the existing
CPUs and memory information. Thus a node without memory and CPU cannot be
discovered by the kernel.

To avoid the kernel crash, do not allow to start pseries with empty
nodes.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20190830161345.22436-1-lvivier@redhat.com>
[dwg: Rework to cope with movement of numa state from globals to MachineS=
tate]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 08a2a5a770..f976d76eca 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2854,6 +2854,39 @@ static void spapr_machine_init(MachineState *machi=
ne)
     /* init CPUs */
     spapr_init_cpus(spapr);
=20
+    /*
+     * check we don't have a memory-less/cpu-less NUMA node
+     * Firmware relies on the existing memory/cpu topology to provide th=
e
+     * NUMA topology to the kernel.
+     * And the linux kernel needs to know the NUMA topology at start
+     * to be able to hotplug CPUs later.
+     */
+    if (machine->numa_state->num_nodes) {
+        for (i =3D 0; i < machine->numa_state->num_nodes; ++i) {
+            /* check for memory-less node */
+            if (machine->numa_state->nodes[i].node_mem =3D=3D 0) {
+                CPUState *cs;
+                int found =3D 0;
+                /* check for cpu-less node */
+                CPU_FOREACH(cs) {
+                    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+                    if (cpu->node_id =3D=3D i) {
+                        found =3D 1;
+                        break;
+                    }
+                }
+                /* memory-less and cpu-less node */
+                if (!found) {
+                    error_report(
+                       "Memory-less/cpu-less nodes are not supported (no=
de %d)",
+                                 i);
+                    exit(1);
+                }
+            }
+        }
+
+    }
+
     if ((!kvm_enabled() || kvmppc_has_cap_mmu_radix()) &&
         ppc_type_check_compat(machine->cpu_type, CPU_POWERPC_LOGICAL_3_0=
0, 0,
                               spapr->max_compat_pvr)) {
--=20
2.21.0


