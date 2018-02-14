Received: from eggs.gnu.org ([2001:4830:134:3::10]:52346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1em2vb-0003gr-7y
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:41:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1em2vV-00036g-Cb
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:41:15 -0500
Received: from 2.mo179.mail-out.ovh.net ([178.33.250.45]:44638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1em2vV-00035q-5w
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:41:09 -0500
Received: from player168.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 80B8FA3FFA
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 20:41:07 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 14 Feb 2018 20:41:03 +0100
Message-ID: <151863726311.3003.8227524786940828598.stgit@bahia.lan>
In-Reply-To: <151863720814.3003.4939908778788942974.stgit@bahia.lan>
References: <151863720814.3003.4939908778788942974.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 5/5] spapr: drop DIV_ROUND_UP() from
 xics_max_server_number()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Sam Bobroff <sam.bobroff@au1.ibm.com>, Laurent Vivier <lvivier@redhat.com>

XICS needs to know the highest VCPU id that may be presented to the
guest plus 1. Commit f303f117fec3 "spapr: ensure we have at least one
XICS server" changed how the maximum is computed from:

        smp_cpus * kvmppc_smt_threads() / smp_threads

to:

        DIV_ROUND_UP(smp_cpus * kvmppc_smt_threads(), smp_threads)

This was done because at the time we could pass broken CPU topologies
to the -smp command line options, such as threads=9,cpus=1. On a POWER8
host this would give:

        1 * 8 / 9 == 0 servers

and cause QEMU to crash later during XICS setup.

The formulat evolved a bit to accomodate CPU hot-plug and VSMT, but
most important, stricter checks are performed on the CPU topology.

With -smp threads=9,cpus=1:

qemu-system-ppc64:
 cpu topology: sockets (1) * cores (1) * threads (9) > maxcpus (1)

With -smp threads=9,maxcpus=1:

qemu-system-ppc64: maxcpus must be equal to or greater than smp

More generally, machine types with hotplug support (2.7 and up), no
longer allow to set maxcpus or smp_cpus to a value that isnt't a
multiple of smp_threads.

With -smp threads=4,cpus=6:

qemu-system-ppc64: smp_cpus (6) must be multiple of threads (4)

With -smp threads=4,maxcpus=6:

qemu-system-ppc64: max_cpus (6) must be multiple of threads (4)

This means that the division is perfect and we don't need DIV_ROUND_UP(),
and we could do a regular division:

        max_cpus * spapr->vsmt / smp_threads

So this patch changes xics_max_server_number() to use the spapr_vcpu_id(),
which works too since max_cpus is a multiple of smp_threads:

    (max_cpus / smp_threads ) * spapr->vsmt + max_cpus % smp_threads

It breaks migration of pre-2.7 machine types with unusual CPU topologies,
but I guess this is an acceptable trade-off.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 800d3f001253..f1722214cc74 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -176,7 +176,7 @@ static void pre_2_10_vmstate_unregister_dummy_icp(int i)
 
 static int xics_max_server_number(sPAPRMachineState *spapr)
 {
-    return DIV_ROUND_UP(max_cpus * spapr->vsmt, smp_threads);
+    return spapr_vcpu_id(spapr, max_cpus)
 }
 
 static void xics_system_init(MachineState *machine, int nr_irqs, Error **errp)
