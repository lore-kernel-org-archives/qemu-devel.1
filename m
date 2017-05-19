Received: from eggs.gnu.org ([2001:4830:134:3::10]:35164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dBbXK-0005tG-MC
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:37:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dBbXG-00027y-8i
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:37:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dBbXF-00027f-Vk
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:37:14 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4J6YQNI034119
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 02:37:12 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ahp1bma40-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 02:37:12 -0400
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Fri, 19 May 2017 16:37:08 +1000
Date: Fri, 19 May 2017 12:06:14 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1495172439-1504-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1495172439-1504-5-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1495172439-1504-5-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <20170519063614.GG3446@in.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 4/4] spapr: Fix migration of Radix
 guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com

On Fri, May 19, 2017 at 11:10:39AM +0530, Bharata B Rao wrote:
> Fix migration of radix guests by ensuring that we issue
> KVM_PPC_CONFIGURE_V3_MMU for radix case post migration.
> 
> Reported-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index daf335c..8f20f14 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1400,6 +1400,18 @@ static int spapr_post_load(void *opaque, int version_id)
>          err = spapr_rtc_import_offset(&spapr->rtc, spapr->rtc_offset);
>      }
> 
> +    if (spapr->patb_entry) {
> +        PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
> +        if (kvmppc_has_cap_mmu_radix() && kvm_enabled()) {
> +            err = kvmppc_configure_v3_mmu(cpu, SPAPR_PROC_TABLE_RADIX,
> +                ((cpu->env.spr[SPR_LPCR] & LPCR_GTSE) ? SPAPR_PROC_TABLE_GTSE :
> +                0), spapr->patb_entry);

Better to use explicit 'true' and 'false' in the above call. Here is
the updated patch:

>From 937c51cac73b4211ef153c1f5940215960383494 Mon Sep 17 00:00:00 2001
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Tue, 16 May 2017 12:19:54 +0530
Subject: [RFC PATCH v2.1 4/4] spapr: Fix migration of Radix guests

Fix migration of radix guests by ensuring that we issue
KVM_PPC_CONFIGURE_V3_MMU for radix case post migration.

Reported-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index daf335c..69e184b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1400,6 +1400,18 @@ static int spapr_post_load(void *opaque, int version_id)
         err = spapr_rtc_import_offset(&spapr->rtc, spapr->rtc_offset);
     }
 
+    if (spapr->patb_entry) {
+        PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
+        if (kvmppc_has_cap_mmu_radix() && kvm_enabled()) {
+            err = kvmppc_configure_v3_mmu(cpu, true,
+                ((cpu->env.spr[SPR_LPCR] & LPCR_GTSE) ? true : false),
+                spapr->patb_entry);
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
