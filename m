Received: from eggs.gnu.org ([2001:4830:134:3::10]:59474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dIVp2-0002en-0c
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:56:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dIVp1-0001Mc-89
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:56:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52932
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dIVp1-0001MT-1v
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:56:07 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v577sVwc145687
	for <qemu-devel@nongnu.org>; Wed, 7 Jun 2017 03:56:06 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ax98fstyt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 03:56:05 -0400
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Wed, 7 Jun 2017 17:55:58 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Wed,  7 Jun 2017 13:24:53 +0530
In-Reply-To: <1496822093-5700-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1496822093-5700-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <1496822093-5700-3-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v5 2/2] spapr: Fix migration of Radix guests
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
Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index df27c5c..4a33c06 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1442,6 +1442,18 @@ static int spapr_post_load(void *opaque, int version_id)
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
