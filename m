Received: from eggs.gnu.org ([2001:4830:134:3::10]:53449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d2xzd-0000C2-U5
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:46:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d2xzZ-00017V-NA
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:46:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43393
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d2xzZ-00017F-GR
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:46:45 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3PAcpi5122078
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 06:46:44 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a1msa3ncp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 06:46:44 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 25 Apr 2017 11:46:42 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue, 25 Apr 2017 12:46:25 +0200
In-Reply-To: <20170425104633.6130-1-cornelia.huck@de.ibm.com>
References: <20170425104633.6130-1-cornelia.huck@de.ibm.com>
Message-Id: <20170425104633.6130-4-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 03/11] hw/s390x/sclp: update LOADPARM in SCP
 Info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, Farhan Ali <alifm@linux.vnet.ibm.com>, Eugene Dvurechenski <jno@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Farhan Ali <alifm@linux.vnet.ibm.com>

LOADPARM has two copies:
1. in SCP Information Block
2. in IPL Information Parameter Block

So, update SCLP intrinsics now. We always store LOADPARM in SCP
information block even if we don't have a valid IPL Information
Parameter Block.

Initial patch from Eugene (jno) Dvurechenski.

Signed-off-by: Eugene (jno) Dvurechenski <jno@linux.vnet.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/sclp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index e741da1141..b4f6dd58dd 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -23,6 +23,7 @@
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/event-facility.h"
 #include "hw/s390x/s390-pci-bus.h"
+#include "hw/s390x/ipl.h"
 
 static inline SCLPDevice *get_sclp_device(void)
 {
@@ -57,6 +58,7 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     int cpu_count = 0;
     int rnsize, rnmax;
     int slots = MIN(machine->ram_slots, s390_get_memslot_count(kvm_state));
+    IplParameterBlock *ipib = s390_ipl_get_iplb();
 
     CPU_FOREACH(cpu) {
         cpu_count++;
@@ -129,6 +131,13 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
         read_info->rnmax2 = cpu_to_be64(rnmax);
     }
 
+    if (ipib && ipib->flags & DIAG308_FLAGS_LP_VALID) {
+        memcpy(&read_info->loadparm, &ipib->loadparm,
+               sizeof(read_info->loadparm));
+    } else {
+        s390_ipl_set_loadparm(read_info->loadparm);
+    }
+
     sccb->h.response_code = cpu_to_be16(SCLP_RC_NORMAL_READ_COMPLETION);
 }
 
-- 
2.11.0
