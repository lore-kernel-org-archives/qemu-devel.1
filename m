Received: from eggs.gnu.org ([2001:4830:134:3::10]:36799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dTSGz-0008LF-UB
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:22:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dTSGz-0005sp-2X
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:22:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dTSGy-0005sA-Pm
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:22:12 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  7 Jul 2017 14:21:57 +0200
Message-Id: <20170707122159.24714-6-cohuck@redhat.com>
In-Reply-To: <20170707122159.24714-1-cohuck@redhat.com>
References: <20170707122159.24714-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 5/7] s390x/pci: fence off instructions for
 non-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, Cornelia Huck <cohuck@redhat.com>

If a guest running on a non-pci build issues a pci instruction,
throw them an exception.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/kvm.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index a3d00196f4..c5c7c27a21 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1160,6 +1160,9 @@ static int kvm_clp_service_call(S390CPU *cpu, struct kvm_run *run)
 {
     uint8_t r2 = (run->s390_sieic.ipb & 0x000f0000) >> 16;
 
+#ifndef CONFIG_PCI
+    return -1;
+#endif
     return clp_service_call(cpu, r2);
 }
 
@@ -1168,6 +1171,9 @@ static int kvm_pcilg_service_call(S390CPU *cpu, struct kvm_run *run)
     uint8_t r1 = (run->s390_sieic.ipb & 0x00f00000) >> 20;
     uint8_t r2 = (run->s390_sieic.ipb & 0x000f0000) >> 16;
 
+#ifndef CONFIG_PCI
+    return -1;
+#endif
     return pcilg_service_call(cpu, r1, r2);
 }
 
@@ -1176,6 +1182,9 @@ static int kvm_pcistg_service_call(S390CPU *cpu, struct kvm_run *run)
     uint8_t r1 = (run->s390_sieic.ipb & 0x00f00000) >> 20;
     uint8_t r2 = (run->s390_sieic.ipb & 0x000f0000) >> 16;
 
+#ifndef CONFIG_PCI
+    return -1;
+#endif
     return pcistg_service_call(cpu, r1, r2);
 }
 
@@ -1188,11 +1197,17 @@ static int kvm_stpcifc_service_call(S390CPU *cpu, struct kvm_run *run)
     cpu_synchronize_state(CPU(cpu));
     fiba = get_base_disp_rxy(cpu, run, &ar);
 
+#ifndef CONFIG_PCI
+    return -1;
+#endif
     return stpcifc_service_call(cpu, r1, fiba, ar);
 }
 
 static int kvm_sic_service_call(S390CPU *cpu, struct kvm_run *run)
 {
+#ifndef CONFIG_PCI
+    return -1;
+#endif
     /* NOOP */
     return 0;
 }
@@ -1202,6 +1217,9 @@ static int kvm_rpcit_service_call(S390CPU *cpu, struct kvm_run *run)
     uint8_t r1 = (run->s390_sieic.ipb & 0x00f00000) >> 20;
     uint8_t r2 = (run->s390_sieic.ipb & 0x000f0000) >> 16;
 
+#ifndef CONFIG_PCI
+    return -1;
+#endif
     return rpcit_service_call(cpu, r1, r2);
 }
 
@@ -1212,6 +1230,9 @@ static int kvm_pcistb_service_call(S390CPU *cpu, struct kvm_run *run)
     uint64_t gaddr;
     uint8_t ar;
 
+#ifndef CONFIG_PCI
+    return -1;
+#endif
     cpu_synchronize_state(CPU(cpu));
     gaddr = get_base_disp_rsy(cpu, run, &ar);
 
@@ -1224,6 +1245,9 @@ static int kvm_mpcifc_service_call(S390CPU *cpu, struct kvm_run *run)
     uint64_t fiba;
     uint8_t ar;
 
+#ifndef CONFIG_PCI
+    return -1;
+#endif
     cpu_synchronize_state(CPU(cpu));
     fiba = get_base_disp_rxy(cpu, run, &ar);
 
-- 
2.13.0
