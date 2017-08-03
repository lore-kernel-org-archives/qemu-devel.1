Received: from eggs.gnu.org ([2001:4830:134:3::10]:48347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1dd9ck-000593-9g
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 02:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1dd9ch-0007BX-5V
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 02:28:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54722
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1dd9ch-0007Ao-0V
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 02:28:43 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v736SeAf122171
	for <qemu-devel@nongnu.org>; Thu, 3 Aug 2017 02:28:42 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2c3q2em5y5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 02:28:42 -0400
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Thu, 3 Aug 2017 16:28:31 +1000
Date: Thu, 3 Aug 2017 16:28:27 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
References: <cover.1501740002.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1501740002.git.sam.bobroff@au1.ibm.com>
Message-Id: <4646e612ef5efb4f17f07eaec18e940f7ae93382.1501740002.git.sam.bobroff@au1.ibm.com>
Subject: [Qemu-devel] [PATCH 1/4] spapr: Fix bug in h_signal_sys_reset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de

The unicast case in h_signal_sys_reset() seems to be broken:
rather than selecting the target CPU, it looks like it will pick
either the first CPU or fail to find one at all.

Fix it by using the search function rather than open coding the
search.

This was found by inspection; the code appears to be unused because
the Linux kernel only uses the broadcast target.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 hw/ppc/spapr_hcall.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 72ea5a8247..07b3da8dc4 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1431,11 +1431,10 @@ static target_ulong h_signal_sys_reset(PowerPCCPU *cpu,
 
     } else {
         /* Unicast */
-        CPU_FOREACH(cs) {
-            if (cpu->cpu_dt_id == target) {
-                run_on_cpu(cs, spapr_do_system_reset_on_cpu, RUN_ON_CPU_NULL);
-                return H_SUCCESS;
-            }
+        cs = CPU(ppc_get_vcpu_by_dt_id(target));
+        if (cs) {
+            run_on_cpu(cs, spapr_do_system_reset_on_cpu, RUN_ON_CPU_NULL);
+            return H_SUCCESS;
         }
         return H_PARAMETER;
     }
-- 
2.12.1.382.gc0f9c7058
