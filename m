Received: from eggs.gnu.org ([2001:4830:134:3::10]:43121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCD-0004Bu-9l
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKC9-0001Xi-Uw
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45011
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKC9-0001X7-MD
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:49 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hacR135908
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:49 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bdm3s155-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:48 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 19:46:48 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:43:58 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1481762701-4587-5-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 04/67] ppc: Check the availability of
 transactional memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

KVM-PR currently does not support transactional memory, and the
implementation in TCG is just a fake. We should not announce TM
support in the ibm,pa-features property when running on such a
system, so disable it by default and only enable it if the KVM
implementation supports it (i.e. recent versions of KVM-HV).
These changes are based on some earlier work from Anton Blanchard
(thanks!).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
(cherry picked from commit bac3bf287ab60e264b636f5f00c116a19b655762)
---
 hw/ppc/spapr.c       | 5 ++++-
 target-ppc/kvm.c     | 7 +++++++
 target-ppc/kvm_ppc.h | 6 ++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9f0d99b..82723d1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -603,7 +603,7 @@ static void spapr_populate_pa_features(CPUPPCState *e=
nv, void *fdt, int offset)
         0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0,
         0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
         0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
-        0x80, 0x00, 0x80, 0x00, 0x80, 0x00 };
+        0x80, 0x00, 0x80, 0x00, 0x00, 0x00 };
     uint8_t *pa_features;
     size_t pa_size;
=20
@@ -632,6 +632,9 @@ static void spapr_populate_pa_features(CPUPPCState *e=
nv, void *fdt, int offset)
          */
         pa_features[3] |=3D 0x20;
     }
+    if (kvmppc_has_cap_htm() && pa_size > 24) {
+        pa_features[24] |=3D 0x80;    /* Transactional memory support */
+    }
=20
     _FDT((fdt_setprop(fdt, offset, "ibm,pa-features", pa_features, pa_si=
ze)));
 }
diff --git a/target-ppc/kvm.c b/target-ppc/kvm.c
index dcb68b9..f26a141 100644
--- a/target-ppc/kvm.c
+++ b/target-ppc/kvm.c
@@ -79,6 +79,7 @@ static int cap_ppc_watchdog;
 static int cap_papr;
 static int cap_htab_fd;
 static int cap_fixup_hcalls;
+static int cap_htm;             /* Hardware transactional memory support=
 */
=20
 static uint32_t debug_inst_opcode;
=20
@@ -121,6 +122,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
      * only activated after this by kvmppc_set_papr() */
     cap_htab_fd =3D kvm_check_extension(s, KVM_CAP_PPC_HTAB_FD);
     cap_fixup_hcalls =3D kvm_check_extension(s, KVM_CAP_PPC_FIXUP_HCALL)=
;
+    cap_htm =3D kvm_vm_check_extension(s, KVM_CAP_PPC_HTM);
=20
     if (!cap_interrupt_level) {
         fprintf(stderr, "KVM: Couldn't find level irq capability. Expect=
 the "
@@ -2339,6 +2341,11 @@ bool kvmppc_has_cap_fixup_hcalls(void)
     return cap_fixup_hcalls;
 }
=20
+bool kvmppc_has_cap_htm(void)
+{
+    return cap_htm;
+}
+
 static PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc)
 {
     ObjectClass *oc =3D OBJECT_CLASS(pcc);
diff --git a/target-ppc/kvm_ppc.h b/target-ppc/kvm_ppc.h
index 5461d10..e45c815 100644
--- a/target-ppc/kvm_ppc.h
+++ b/target-ppc/kvm_ppc.h
@@ -54,6 +54,7 @@ void kvmppc_hash64_free_pteg(uint64_t token);
 void kvmppc_hash64_write_pte(CPUPPCState *env, target_ulong pte_index,
                              target_ulong pte0, target_ulong pte1);
 bool kvmppc_has_cap_fixup_hcalls(void);
+bool kvmppc_has_cap_htm(void);
 int kvmppc_enable_hwrng(void);
 int kvmppc_put_books_sregs(PowerPCCPU *cpu);
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
@@ -244,6 +245,11 @@ static inline bool kvmppc_has_cap_fixup_hcalls(void)
     abort();
 }
=20
+static inline bool kvmppc_has_cap_htm(void)
+{
+    return false;
+}
+
 static inline int kvmppc_enable_hwrng(void)
 {
     return -1;
--=20
1.9.1
