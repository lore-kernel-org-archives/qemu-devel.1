Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F371DC3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 16:31:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C923623426
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 16:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C923623426
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3jo6-0006X8-Tl
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 12:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1i3jX9-0000rR-VY
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 12:13:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1i3jX6-0006PH-PL
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 12:13:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56036)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>)
 id 1i3jX6-0006LG-9U; Fri, 30 Aug 2019 12:13:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 798F76E77E;
 Fri, 30 Aug 2019 16:13:47 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-116-182.ams2.redhat.com
 [10.36.116.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 17A9F1001938;
 Fri, 30 Aug 2019 16:13:45 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 30 Aug 2019 18:13:45 +0200
Message-Id: <20190830161345.22436-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 30 Aug 2019 16:13:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] pseries: do not allow memory-less/cpu-less
 NUMA node
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 hw/ppc/spapr.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index baedadf20b8c..8be738901cf9 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2847,6 +2847,39 @@ static void spapr_machine_init(MachineState *machi=
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
+    if (nb_numa_nodes) {
+        for (i =3D 0; i < nb_numa_nodes; ++i) {
+            /* check for memory-less node */
+            if (numa_info[i].node_mem =3D=3D 0) {
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


