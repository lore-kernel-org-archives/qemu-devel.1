Received: from eggs.gnu.org ([2001:4830:134:3::10]:56154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dBafi-0007iz-Vc
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:41:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dBaff-0005Zp-To
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:41:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dBaff-0005ZO-Jj
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:41:51 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4J5ehFC117131
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 01:41:50 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ahrwmm22f-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 01:41:50 -0400
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Fri, 19 May 2017 15:41:47 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Fri, 19 May 2017 11:10:39 +0530
In-Reply-To: <1495172439-1504-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1495172439-1504-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <1495172439-1504-5-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v2 4/4] spapr: Fix migration of Radix guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>

Fix migration of radix guests by ensuring that we issue
KVM_PPC_CONFIGURE_V3_MMU for radix case post migration.

Reported-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index daf335c..8f20f14 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1400,6 +1400,18 @@ static int spapr_post_load(void *opaque, int version_id)
         err = spapr_rtc_import_offset(&spapr->rtc, spapr->rtc_offset);
     }
 
+    if (spapr->patb_entry) {
+        PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
+        if (kvmppc_has_cap_mmu_radix() && kvm_enabled()) {
+            err = kvmppc_configure_v3_mmu(cpu, SPAPR_PROC_TABLE_RADIX,
+                ((cpu->env.spr[SPR_LPCR] & LPCR_GTSE) ? SPAPR_PROC_TABLE_GTSE :
+                0), spapr->patb_entry);
+        } else {
+            error_report("Radix guest is unsupported by the host");
+            return -EINVAL;
+        }
+    }
+
     return err;
 }
 
-- 
2.7.4
