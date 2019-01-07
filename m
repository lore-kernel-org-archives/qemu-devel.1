Received: from eggs.gnu.org ([209.51.188.92]:43532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ggZp4-0002OL-E2
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:40:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ggZos-0002C1-5P
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:40:19 -0500
Received: from 12.mo1.mail-out.ovh.net ([87.98.162.229]:35813)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ggZoq-00026d-KP
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:40:13 -0500
Received: from player687.ha.ovh.net (unknown [10.109.143.109])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 1446314CE78
	for <qemu-devel@nongnu.org>; Mon,  7 Jan 2019 19:40:08 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  7 Jan 2019 19:39:34 +0100
Message-Id: <20190107183946.7230-2-clg@kaod.org>
In-Reply-To: <20190107183946.7230-1-clg@kaod.org>
References: <20190107183946.7230-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 01/13] linux-headers: update to 5.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

These changes provide the interface with the KVM device implementing
the XIVE native exploitation interrupt mode. Also used to retrieve the
state of the KVM device for the monitor usage and for migration.

Available from :

  https://github.com/legoater/linux/commits/xive-5.0

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 linux-headers/asm-powerpc/kvm.h | 46 +++++++++++++++++++++++++++++++++
 linux-headers/linux/kvm.h       |  9 +++++++
 2 files changed, 55 insertions(+)

diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/=
kvm.h
index 8c876c166ef2..10fe86c21e8f 100644
--- a/linux-headers/asm-powerpc/kvm.h
+++ b/linux-headers/asm-powerpc/kvm.h
@@ -480,6 +480,8 @@ struct kvm_ppc_cpu_char {
 #define  KVM_REG_PPC_ICP_PPRI_SHIFT	16	/* pending irq priority */
 #define  KVM_REG_PPC_ICP_PPRI_MASK	0xff
=20
+#define KVM_REG_PPC_NVT_STATE	(KVM_REG_PPC | KVM_REG_SIZE_U256 | 0x8d)
+
 /* Device control API: PPC-specific devices */
 #define KVM_DEV_MPIC_GRP_MISC		1
 #define   KVM_DEV_MPIC_BASE_ADDR	0	/* 64-bit */
@@ -675,4 +677,48 @@ struct kvm_ppc_cpu_char {
 #define  KVM_XICS_PRESENTED		(1ULL << 43)
 #define  KVM_XICS_QUEUED		(1ULL << 44)
=20
+/* POWER9 XIVE Native Interrupt Controller */
+#define KVM_DEV_XIVE_GRP_CTRL		1
+#define   KVM_DEV_XIVE_GET_ESB_FD	1
+#define   KVM_DEV_XIVE_GET_TIMA_FD	2
+#define   KVM_DEV_XIVE_VC_BASE		3
+#define   KVM_DEV_XIVE_SAVE_EQ_PAGES	4
+#define KVM_DEV_XIVE_GRP_SOURCES	2	/* 64-bit source attributes */
+#define KVM_DEV_XIVE_GRP_SYNC		3	/* 64-bit source attributes */
+#define KVM_DEV_XIVE_GRP_EAS		4	/* 64-bit eas attributes */
+#define KVM_DEV_XIVE_GRP_EQ		5	/* 64-bit eq attributes */
+
+/* Layout of 64-bit XIVE source attribute values */
+#define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
+#define KVM_XIVE_LEVEL_ASSERTED		(1ULL << 1)
+
+/* Layout of 64-bit eas attribute values */
+#define KVM_XIVE_EAS_PRIORITY_SHIFT	0
+#define KVM_XIVE_EAS_PRIORITY_MASK	0x7
+#define KVM_XIVE_EAS_SERVER_SHIFT	3
+#define KVM_XIVE_EAS_SERVER_MASK	0xfffffff8ULL
+#define KVM_XIVE_EAS_MASK_SHIFT		32
+#define KVM_XIVE_EAS_MASK_MASK		0x100000000ULL
+#define KVM_XIVE_EAS_EISN_SHIFT		33
+#define KVM_XIVE_EAS_EISN_MASK		0xfffffffe00000000ULL
+
+/* Layout of 64-bit eq attribute */
+#define KVM_XIVE_EQ_PRIORITY_SHIFT	0
+#define KVM_XIVE_EQ_PRIORITY_MASK	0x7
+#define KVM_XIVE_EQ_SERVER_SHIFT	3
+#define KVM_XIVE_EQ_SERVER_MASK		0xfffffff8ULL
+
+/* Layout of 64-bit eq attribute values */
+struct kvm_ppc_xive_eq {
+	__u32 flags;
+	__u32 qsize;
+	__u64 qpage;
+	__u32 qtoggle;
+	__u32 qindex;
+};
+
+#define KVM_XIVE_EQ_FLAG_ENABLED	0x00000001
+#define KVM_XIVE_EQ_FLAG_ALWAYS_NOTIFY	0x00000002
+#define KVM_XIVE_EQ_FLAG_ESCALATE	0x00000004
+
 #endif /* __LINUX_KVM_POWERPC_H */
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index f11a7eb49cfa..7f476ad5e4e8 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -1,3 +1,4 @@
+
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 #ifndef __LINUX_KVM_H
 #define __LINUX_KVM_H
@@ -965,6 +966,10 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_COALESCED_PIO 162
 #define KVM_CAP_HYPERV_ENLIGHTENED_VMCS 163
 #define KVM_CAP_EXCEPTION_PAYLOAD 164
+#define KVM_CAP_ARM_VM_IPA_SIZE 165
+#define KVM_CAP_MANUAL_DIRTY_LOG_PROTECT 166
+#define KVM_CAP_HYPERV_CPUID 167
+#define KVM_CAP_PPC_IRQ_XIVE 168
=20
 #ifdef KVM_CAP_IRQ_ROUTING
=20
@@ -1188,6 +1193,8 @@ enum kvm_device_type {
 #define KVM_DEV_TYPE_ARM_VGIC_V3	KVM_DEV_TYPE_ARM_VGIC_V3
 	KVM_DEV_TYPE_ARM_VGIC_ITS,
 #define KVM_DEV_TYPE_ARM_VGIC_ITS	KVM_DEV_TYPE_ARM_VGIC_ITS
+	KVM_DEV_TYPE_XIVE,
+#define KVM_DEV_TYPE_XIVE		KVM_DEV_TYPE_XIVE
 	KVM_DEV_TYPE_MAX,
 };
=20
@@ -1305,6 +1312,8 @@ struct kvm_s390_ucas_mapping {
 #define KVM_GET_DEVICE_ATTR	  _IOW(KVMIO,  0xe2, struct kvm_device_attr)
 #define KVM_HAS_DEVICE_ATTR	  _IOW(KVMIO,  0xe3, struct kvm_device_attr)
=20
+#define KVM_DESTROY_DEVICE	  _IOWR(KVMIO,  0xf0, struct kvm_create_devic=
e)
+
 /*
  * ioctls for vcpu fds
  */
--=20
2.20.1
