Received: from eggs.gnu.org ([2001:4830:134:3::10]:51471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dDOJz-0001cm-C3
	for qemu-devel@nongnu.org; Wed, 24 May 2017 00:54:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dDOJx-0007DB-4K
	for qemu-devel@nongnu.org; Wed, 24 May 2017 00:54:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dDOJw-0007CO-Qx
	for qemu-devel@nongnu.org; Wed, 24 May 2017 00:54:53 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4O4rvfR094108
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 00:54:50 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2amvavduk9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 00:54:50 -0400
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Wed, 24 May 2017 14:54:48 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Wed, 24 May 2017 10:23:34 +0530
In-Reply-To: <1495601614-18586-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1495601614-18586-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <1495601614-18586-4-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 3/3] spapr: Fix migration of Radix guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com, sjitindarsingh@gmail.com, Bharata B Rao <bharata@linux.vnet.ibm.com>

Fix migration of radix guests by ensuring that we issue
KVM_PPC_CONFIGURE_V3_MMU for radix case post migration.

Reported-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index daf335c..ea14bed 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1400,6 +1400,18 @@ static int spapr_post_load(void *opaque, int version_id)
         err = spapr_rtc_import_offset(&spapr->rtc, spapr->rtc_offset);
     }
 
+    if (spapr->patb_entry) {
+        PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
+        bool radix = !!(spapr->patb_entry & PATBE1_GR);
+        bool gtse = !!(cpu->env.spr[SPR_LPCR] & LPCR_GTSE);
+
+        err = kvmppc_configure_v3_mmu(cpu, radix, gtse, spapr->patb_entry);
+        if (err) {
+            error_report("Process table config unsupported by the host");
+            return -EINVAL;
+        }
+    }
+
     return err;
 }
 
-- 
2.7.4
