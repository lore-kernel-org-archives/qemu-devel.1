Received: from eggs.gnu.org ([2001:4830:134:3::10]:36337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkY0L-00067U-4J
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkY0H-00015o-Ot
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:55:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dkY0H-000156-F3
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:55:37 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 23 Aug 2017 17:54:57 +0200
Message-Id: <20170823155458.19601-9-cohuck@redhat.com>
In-Reply-To: <20170823155458.19601-1-cohuck@redhat.com>
References: <20170823155458.19601-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v5 8/9] s390x/pci: fence off instructions for
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
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, Cornelia Huck <cohuck@redhat.com>

If a guest running on a machine without zpci issues a pci instruction,
throw them an exception.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/kvm.c | 54 +++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index bc62bba5b7..9de165d8b1 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1191,7 +1191,11 @@ static int kvm_clp_service_call(S390CPU *cpu, struct kvm_run *run)
 {
     uint8_t r2 = (run->s390_sieic.ipb & 0x000f0000) >> 16;
 
-    return clp_service_call(cpu, r2);
+    if (s390_has_feat(S390_FEAT_ZPCI)) {
+        return clp_service_call(cpu, r2);
+    } else {
+        return -1;
+    }
 }
 
 static int kvm_pcilg_service_call(S390CPU *cpu, struct kvm_run *run)
@@ -1199,7 +1203,11 @@ static int kvm_pcilg_service_call(S390CPU *cpu, struct kvm_run *run)
     uint8_t r1 = (run->s390_sieic.ipb & 0x00f00000) >> 20;
     uint8_t r2 = (run->s390_sieic.ipb & 0x000f0000) >> 16;
 
-    return pcilg_service_call(cpu, r1, r2);
+    if (s390_has_feat(S390_FEAT_ZPCI)) {
+        return pcilg_service_call(cpu, r1, r2);
+    } else {
+        return -1;
+    }
 }
 
 static int kvm_pcistg_service_call(S390CPU *cpu, struct kvm_run *run)
@@ -1207,7 +1215,11 @@ static int kvm_pcistg_service_call(S390CPU *cpu, struct kvm_run *run)
     uint8_t r1 = (run->s390_sieic.ipb & 0x00f00000) >> 20;
     uint8_t r2 = (run->s390_sieic.ipb & 0x000f0000) >> 16;
 
-    return pcistg_service_call(cpu, r1, r2);
+    if (s390_has_feat(S390_FEAT_ZPCI)) {
+        return pcistg_service_call(cpu, r1, r2);
+    } else {
+        return -1;
+    }
 }
 
 static int kvm_stpcifc_service_call(S390CPU *cpu, struct kvm_run *run)
@@ -1216,10 +1228,14 @@ static int kvm_stpcifc_service_call(S390CPU *cpu, struct kvm_run *run)
     uint64_t fiba;
     uint8_t ar;
 
-    cpu_synchronize_state(CPU(cpu));
-    fiba = get_base_disp_rxy(cpu, run, &ar);
+    if (s390_has_feat(S390_FEAT_ZPCI)) {
+        cpu_synchronize_state(CPU(cpu));
+        fiba = get_base_disp_rxy(cpu, run, &ar);
 
-    return stpcifc_service_call(cpu, r1, fiba, ar);
+        return stpcifc_service_call(cpu, r1, fiba, ar);
+    } else {
+        return -1;
+    }
 }
 
 static int kvm_sic_service_call(S390CPU *cpu, struct kvm_run *run)
@@ -1247,7 +1263,11 @@ static int kvm_rpcit_service_call(S390CPU *cpu, struct kvm_run *run)
     uint8_t r1 = (run->s390_sieic.ipb & 0x00f00000) >> 20;
     uint8_t r2 = (run->s390_sieic.ipb & 0x000f0000) >> 16;
 
-    return rpcit_service_call(cpu, r1, r2);
+    if (s390_has_feat(S390_FEAT_ZPCI)) {
+        return rpcit_service_call(cpu, r1, r2);
+    } else {
+        return -1;
+    }
 }
 
 static int kvm_pcistb_service_call(S390CPU *cpu, struct kvm_run *run)
@@ -1257,10 +1277,14 @@ static int kvm_pcistb_service_call(S390CPU *cpu, struct kvm_run *run)
     uint64_t gaddr;
     uint8_t ar;
 
-    cpu_synchronize_state(CPU(cpu));
-    gaddr = get_base_disp_rsy(cpu, run, &ar);
+    if (s390_has_feat(S390_FEAT_ZPCI)) {
+        cpu_synchronize_state(CPU(cpu));
+        gaddr = get_base_disp_rsy(cpu, run, &ar);
 
-    return pcistb_service_call(cpu, r1, r3, gaddr, ar);
+        return pcistb_service_call(cpu, r1, r3, gaddr, ar);
+    } else {
+        return -1;
+    }
 }
 
 static int kvm_mpcifc_service_call(S390CPU *cpu, struct kvm_run *run)
@@ -1269,10 +1293,14 @@ static int kvm_mpcifc_service_call(S390CPU *cpu, struct kvm_run *run)
     uint64_t fiba;
     uint8_t ar;
 
-    cpu_synchronize_state(CPU(cpu));
-    fiba = get_base_disp_rxy(cpu, run, &ar);
+    if (s390_has_feat(S390_FEAT_ZPCI)) {
+        cpu_synchronize_state(CPU(cpu));
+        fiba = get_base_disp_rxy(cpu, run, &ar);
 
-    return mpcifc_service_call(cpu, r1, fiba, ar);
+        return mpcifc_service_call(cpu, r1, fiba, ar);
+    } else {
+        return -1;
+    }
 }
 
 static int handle_b9(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
-- 
2.13.5
