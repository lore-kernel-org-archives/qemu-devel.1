Received: from eggs.gnu.org ([209.51.188.92]:33365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gugr5-0001pi-MW
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:00:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gugr3-0005Oh-I1
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:00:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53548
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gugr1-0005HC-JC
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:00:47 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1FGxnUH144419
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 12:00:46 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qp0pp2jmq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 12:00:45 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Fri, 15 Feb 2019 17:00:44 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 15 Feb 2019 18:00:20 +0100
In-Reply-To: <20190215170029.15641-1-clg@kaod.org>
References: <20190215170029.15641-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190215170029.15641-4-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/12] target/ppc: Re-enable RMLS on POWER9 for
 virtual hypervisors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Historically the 64-bit server MMU supports two way of configuring the
guest "real mode" mapping:

 - The "RMA" with is a single chunk of physically contiguous
memory remapped as guest real, and controlled by the RMLS
field in the LPCR register and the RMOR register.

 - The "VRMA" which uses special PTEs inserted in the partition
hash table by the hypervisor.

POWER9 deprecates the former, which is reflected by the filtering
done in ppc_store_lpcr() which effectively prevents setting of
the RMLS field.

However, when using fully emulated SPAPR machines, our qemu code
currently only knows how to define the guest real mode memory using
RMLS.

Thus you cannot run a SPAPR machine anymore with a POWER9 CPU
model today.

This works around it with a quirk in ppc_store_lpcr() to continue
allowing the RMLS field to be set when using a virtual hypervisor.

Ultimately we will want to implement configuring a VRMA instead
which will also be necessary if we want to migrate a SPAPR guest
between TCG and KVM but this is a lot more work.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/mmu-hash64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index f1c7729332e6..1175b991d994 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -1088,6 +1088,14 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong =
val)
                       (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE | LPCR_=
EEE |
                       LPCR_DEE | LPCR_OEE)) | LPCR_MER | LPCR_GTSE | LPC=
R_TC |
                       LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDICE);
+        /*
+         * If we have a virtual hypervisor, we need to bring back RMLS. =
It
+         * doesn't exist on an actual P9 but that's all we know how to
+         * configure with softmmu at the moment
+         */
+        if (cpu->vhyp) {
+            lpcr |=3D (val & LPCR_RMLS);
+        }
         break;
     default:
         ;
--=20
2.20.1
