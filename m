Received: from eggs.gnu.org ([2001:4830:134:3::10]:49556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s1seetee@linux.vnet.ibm.com>) id 1eKnYA-00021x-1k
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:49:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s1seetee@linux.vnet.ibm.com>) id 1eKnXW-00012S-Gx
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:48:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46352
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s1seetee@linux.vnet.ibm.com>)
	id 1eKnXW-00011c-8m
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:47:46 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB1BOGse006258
	for <qemu-devel@nongnu.org>; Fri, 1 Dec 2017 06:24:20 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ek3vsej8a-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 01 Dec 2017 06:24:20 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <s1seetee@linux.vnet.ibm.com>;
	Fri, 1 Dec 2017 11:24:18 -0000
From: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Date: Fri,  1 Dec 2017 16:54:09 +0530
Message-Id: <1512127449-11114-1-git-send-email-s1seetee@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1] spapr.c: Update qemu's maxcpus for pseries
 machine.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: david@gibson.dropbear.id.au, agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: s1seetee@linux.vnet.ibm.com

Need to adjust the max cpus supported number from error message since
it was conflicting with KVM's.

Steps to Reproduce:
1.boot up with
"-smp 64,maxcpus=102464,cores=8,threads=1,sockets=8"

qemu-kvm: Number of SMP CPUs requested (102464) exceeds max CPUs
supported by machine 'pseries-rhel7.4.0alt' (1024)

2. On KVM machine it shows

boot up with
"-m 6G,maxmem=300G,slots=256 -smp 64,maxcpus=1024,cores=8,threads=1
,sockets=128"

Number of hotpluggable cpus requested (1024) exceeds the maximum cpus
 supported by KVM (240)

It seemed that 1024 was useless since KVM only support 240 so far.
Hence,we need to adjust it to an reasonable value 240.

Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9efddea..c753254 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3691,6 +3691,7 @@ static const TypeInfo spapr_machine_info = {
         if (latest) {                                                \
             mc->alias = "pseries";                                   \
             mc->is_default = 1;                                      \
+            mc->max_cpus = 240;                                      \
         }                                                            \
     }                                                                \
     static void spapr_machine_##suffix##_instance_init(Object *obj)  \
-- 
1.8.3.1
