Received: from eggs.gnu.org ([2001:4830:134:3::10]:50798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1ct5ki-0006ZF-98
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 01:02:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1ct5kf-0005OL-80
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 01:02:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1ct5ke-0005NO-Vz
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 01:02:33 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2T4wuja013577
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 01:02:30 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29fsf82k7p-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 01:02:30 -0400
Received: from localhost
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Wed, 29 Mar 2017 15:02:27 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Wed, 29 Mar 2017 16:01:28 +1100
In-Reply-To: <cover.1490763676.git.sam.bobroff@au1.ibm.com>
References: <cover.1490763676.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1490763676.git.sam.bobroff@au1.ibm.com>
References: <cover.1490763676.git.sam.bobroff@au1.ibm.com>
Message-Id: <fe96334e261ed8da1c03202ea88a139b479c0c23.1490763676.git.sam.bobroff@au1.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] target/ppc: Improve accuracy of guest HTM
 availability on P8s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, thuth@redhat.com

On Power8 hosts it is currently theoretically possible for QEMU/KVM-HV guests
to receive a ibm,pa-features property indicating that HTM support is available
when it is not.  The situation would occur if the platform firmware of
a Power8 host cleared the HTM bit of the ibm,pa-features property.
QEMU would query KVM for the availability of HTM, which will return no
support, but workaround code in kvm_arch_init_vcpu() would then
re-enable it because KVM_HV is in use and the processor is P8.

This patch adjusts the workaround in kvm_arch_init_vcpu() so that it does not
enable HTM (in the above case) unless the host kernel indicates to the QEMU
process, via the auxiliary vector, that userspace can use HTM (via the HWCAP2
bit KVM_FEATURE2_HTM).

The reason to use the value from the auxiliary vector is that it is
set based only on what the host kernel found in the ibm,pa-features
HTM bit at boot time.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 target/ppc/kvm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 9f1f132cef..8a54709ae4 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -49,6 +49,7 @@
 #if defined(TARGET_PPC64)
 #include "hw/ppc/spapr_cpu_core.h"
 #endif
+#include "elf.h"
 
 //#define DEBUG_KVM
 
@@ -509,8 +510,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
     case POWERPC_MMU_2_07:
         if (!cap_htm && !kvmppc_is_pr(cs->kvm_state)) {
             /* KVM-HV has transactional memory on POWER8 also without the
-             * KVM_CAP_PPC_HTM extension, so enable it here instead. */
-            cap_htm = true;
+             * KVM_CAP_PPC_HTM extension, so enable it here instead as
+             * long as it's availble to userspace on the host. */
+            if (qemu_getauxval(AT_HWCAP2) & PPC_FEATURE2_HAS_HTM) {
+                cap_htm = true;
+            }
         }
         break;
     default:
-- 
2.12.1.382.gc0f9c7058
