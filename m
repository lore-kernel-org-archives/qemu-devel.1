Received: from eggs.gnu.org ([2001:4830:134:3::10]:51892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cavz6-0005Ou-6I
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:58:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cavz3-0002xr-5T
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:58:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1cavz2-0002x3-Sy
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:58:21 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v172s1iP111378
	for <qemu-devel@nongnu.org>; Mon, 6 Feb 2017 21:58:19 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28eups6s0e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 21:58:19 -0500
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Tue, 7 Feb 2017 12:58:17 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Tue,  7 Feb 2017 13:56:50 +1100
In-Reply-To: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
References: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
References: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
Message-Id: <2152049c2d1291babfe2c7af9df23961a9748a17.1486436186.git.sam.bobroff@au1.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 7/9] spapr: Set ISA 3.00 radix and hash
 bits in OV5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Set new option vector 5 bits to indicate KVM support for in-memory
radix or hash modes and related options. The existing logic will
propagate the results back to the guest in the device tree. This
allows guests to perform client architecture support negotiation on
the new radix and hash MMU modes and will cause ISA 3.00 guests to
start using h_register_process_table().

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 hw/ppc/spapr.c              | 8 ++++++++
 include/hw/ppc/spapr_ovec.h | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1411e470c0..c6a3a638cd 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1862,6 +1862,14 @@ static void ppc_spapr_init(MachineState *machine)
     }
 
     spapr_ovec_set(spapr->ov5, OV5_FORM1_AFFINITY);
+    if (kvmppc_has_cap_mmu_radix()) {
+        spapr_ovec_set(spapr->ov5, OV5_MMU_RADIX);
+    }
+    if (kvmppc_has_cap_mmu_hash()) {
+        spapr_ovec_set(spapr->ov5, OV5_MMU_HASH);
+    }
+    spapr_ovec_set(spapr->ov5, OV5_SEG_HCALL);
+    spapr_ovec_set(spapr->ov5, OV5_SHOOTDOWN);
 
     /* advertise support for dedicated HP event source to guests */
     if (spapr->use_hotplug_event_source) {
diff --git a/include/hw/ppc/spapr_ovec.h b/include/hw/ppc/spapr_ovec.h
index 0f14753ff8..0a77e2a14b 100644
--- a/include/hw/ppc/spapr_ovec.h
+++ b/include/hw/ppc/spapr_ovec.h
@@ -47,6 +47,12 @@ typedef struct sPAPROptionVector sPAPROptionVector;
 #define OV5_DRCONF_MEMORY       OV_BIT(2, 2)
 #define OV5_FORM1_AFFINITY      OV_BIT(5, 0)
 #define OV5_HP_EVT              OV_BIT(6, 5)
+#define OV5_INT_ARCH_LVL        OV_BIT(23, 7)
+#define OV5_MMU_RADIX           OV_BIT(24, 0)
+#define OV5_MMU_HASH            OV_BIT(24, 1)
+#define OV5_SEG_RADIX           OV_BIT(24, 2)
+#define OV5_SEG_HCALL           OV_BIT(24, 3)
+#define OV5_SHOOTDOWN           OV_BIT(24, 4)
 
 /* interfaces */
 sPAPROptionVector *spapr_ovec_new(void);
-- 
2.11.0
