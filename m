Received: from eggs.gnu.org ([2001:4830:134:3::10]:39314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxD4-00035A-R4
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:52:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxD0-0004N4-4K
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:52:22 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:32954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fQxCz-0004MD-RT
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:52:18 -0400
Received: from player169.ha.ovh.net (unknown [10.109.122.15])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 671C613BC16
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 17:52:16 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Jun 2018 17:49:57 +0200
Message-Id: <20180607155003.1580-23-clg@kaod.org>
In-Reply-To: <20180607155003.1580-1-clg@kaod.org>
References: <20180607155003.1580-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 22/28] target/ppc/kvm: add Linux KVM
 definitions for XIVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

These definitions add a new capability and a new KVM device for the
XIVE native exploitation interrupt mode. New ioctls are also
introduced to initialize the KVM device and to capture/restore the VM
state for migration.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 linux-headers/asm-powerpc/kvm.h | 23 +++++++++++++++++++++++
 linux-headers/linux/kvm.h       |  3 +++
 target/ppc/kvm_ppc.h            |  6 ++++++
 target/ppc/kvm.c                |  7 +++++++
 4 files changed, 39 insertions(+)

diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/=
kvm.h
index 833ed9a16adf..27f3dae65761 100644
--- a/linux-headers/asm-powerpc/kvm.h
+++ b/linux-headers/asm-powerpc/kvm.h
@@ -480,6 +480,16 @@ struct kvm_ppc_cpu_char {
 #define  KVM_REG_PPC_ICP_PPRI_SHIFT	16	/* pending irq priority */
 #define  KVM_REG_PPC_ICP_PPRI_MASK	0xff
=20
+#define KVM_REG_PPC_VP_STATE	(KVM_REG_PPC | KVM_REG_SIZE_U256 | 0x8d)
+#define KVM_REG_PPC_VP_EQ0	(KVM_REG_PPC | KVM_REG_SIZE_U256 | 0x8e)
+#define KVM_REG_PPC_VP_EQ1	(KVM_REG_PPC | KVM_REG_SIZE_U256 | 0x8f)
+#define KVM_REG_PPC_VP_EQ2	(KVM_REG_PPC | KVM_REG_SIZE_U256 | 0x90)
+#define KVM_REG_PPC_VP_EQ3	(KVM_REG_PPC | KVM_REG_SIZE_U256 | 0x91)
+#define KVM_REG_PPC_VP_EQ4	(KVM_REG_PPC | KVM_REG_SIZE_U256 | 0x92)
+#define KVM_REG_PPC_VP_EQ5	(KVM_REG_PPC | KVM_REG_SIZE_U256 | 0x93)
+#define KVM_REG_PPC_VP_EQ6	(KVM_REG_PPC | KVM_REG_SIZE_U256 | 0x94)
+#define KVM_REG_PPC_VP_EQ7	(KVM_REG_PPC | KVM_REG_SIZE_U256 | 0x95)
+
 /* Device control API: PPC-specific devices */
 #define KVM_DEV_MPIC_GRP_MISC		1
 #define   KVM_DEV_MPIC_BASE_ADDR	0	/* 64-bit */
@@ -673,4 +683,17 @@ struct kvm_ppc_cpu_char {
 #define  KVM_XICS_PRESENTED		(1ULL << 43)
 #define  KVM_XICS_QUEUED		(1ULL << 44)
=20
+/* POWER9 XIVE Interrupt Controller */
+#define KVM_DEV_XIVE_GRP_SOURCES	1	/* 64-bit source attributes */
+#define KVM_DEV_XIVE_GRP_CTRL		2
+#define   KVM_DEV_XIVE_GET_ESB_FD	1
+#define   KVM_DEV_XIVE_GET_TIMA_FD	2
+#define   KVM_DEV_XIVE_VC_BASE		3
+#define KVM_DEV_XIVE_GRP_IVE		3	/* 64-bit source attributes */
+#define KVM_DEV_XIVE_GRP_SYNC		4	/* 64-bit source attributes */
+
+/* Layout of 64-bit XIVE source attribute values */
+#define  KVM_XIVE_LEVEL_SENSITIVE       (1ULL << 0)
+#define  KVM_XIVE_LEVEL_ASSERTED        (1ULL << 1)
+
 #endif /* __LINUX_KVM_POWERPC_H */
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index cdb148e959eb..634a24e92b03 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -948,6 +948,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_BPB 152
 #define KVM_CAP_GET_MSR_FEATURES 153
 #define KVM_CAP_HYPERV_EVENTFD 154
+#define KVM_CAP_PPC_IRQ_XIVE 155
=20
 #ifdef KVM_CAP_IRQ_ROUTING
=20
@@ -1171,6 +1172,8 @@ enum kvm_device_type {
 #define KVM_DEV_TYPE_ARM_VGIC_V3	KVM_DEV_TYPE_ARM_VGIC_V3
 	KVM_DEV_TYPE_ARM_VGIC_ITS,
 #define KVM_DEV_TYPE_ARM_VGIC_ITS	KVM_DEV_TYPE_ARM_VGIC_ITS
+	KVM_DEV_TYPE_XIVE,
+#define KVM_DEV_TYPE_XIVE		KVM_DEV_TYPE_XIVE
 	KVM_DEV_TYPE_MAX,
 };
=20
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index e2840e1d33e8..52f25bfb03b9 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -59,6 +59,7 @@ bool kvmppc_has_cap_fixup_hcalls(void);
 bool kvmppc_has_cap_htm(void);
 bool kvmppc_has_cap_mmu_radix(void);
 bool kvmppc_has_cap_mmu_hash_v3(void);
+bool kvmppc_has_cap_xive(void);
 int kvmppc_get_cap_safe_cache(void);
 int kvmppc_get_cap_safe_bounds_check(void);
 int kvmppc_get_cap_safe_indirect_branch(void);
@@ -293,6 +294,11 @@ static inline bool kvmppc_has_cap_mmu_hash_v3(void)
     return false;
 }
=20
+static inline bool kvmppc_has_cap_xive(void)
+{
+    return false;
+}
+
 static inline int kvmppc_get_cap_safe_cache(void)
 {
     return 0;
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 2c0c34e125e4..09e4c1efdf79 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -86,6 +86,7 @@ static int cap_fixup_hcalls;
 static int cap_htm;             /* Hardware transactional memory support=
 */
 static int cap_mmu_radix;
 static int cap_mmu_hash_v3;
+static int cap_xive;
 static int cap_resize_hpt;
 static int cap_ppc_pvr_compat;
 static int cap_ppc_safe_cache;
@@ -148,6 +149,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_htm =3D kvm_vm_check_extension(s, KVM_CAP_PPC_HTM);
     cap_mmu_radix =3D kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_RADIX);
     cap_mmu_hash_v3 =3D kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_HASH_V=
3);
+    cap_xive =3D kvm_vm_check_extension(s, KVM_CAP_PPC_IRQ_XIVE);
     cap_resize_hpt =3D kvm_vm_check_extension(s, KVM_CAP_SPAPR_RESIZE_HP=
T);
     kvmppc_get_cpu_characteristics(s);
     /*
@@ -2447,6 +2449,11 @@ static int parse_cap_ppc_safe_indirect_branch(stru=
ct kvm_ppc_cpu_char c)
     return 0;
 }
=20
+bool kvmppc_has_cap_xive(void)
+{
+    return cap_xive;
+}
+
 static void kvmppc_get_cpu_characteristics(KVMState *s)
 {
     struct kvm_ppc_cpu_char c;
--=20
2.13.6
