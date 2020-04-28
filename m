Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FUZZY_XPILL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD12C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 19:58:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C21802137B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 19:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbAr0bAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C21802137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTWNb-0003ip-U6
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 15:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTWLy-0002Co-SV
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:57:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTWLx-00072e-Ph
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:57:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31344
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jTWLx-00072X-9A
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588103832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qJdgYwFSlwdHUNaoVehjCz9GoCi7XawCN5I1LzlAX2w=;
 b=hbAr0bAWkxj0SRu0z/lBLt3F0WNxPg/EkzvNitjl16wVAchSTDLhr5Ehw0kWr11CPSRsjZ
 odxyAIqc/9s7n0ia+sFf35y+NSgZl3pOSOyJ603jq+Pn/ZCuTKSy3nn7oEtu5v7hGcDnX0
 TTXvuO14CZKRN9S971j6LtkKOb4rjoY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-BGbm1iD1MO-KFfWp09h4ZQ-1; Tue, 28 Apr 2020 15:57:10 -0400
X-MC-Unique: BGbm1iD1MO-KFfWp09h4ZQ-1
Received: by mail-qk1-f197.google.com with SMTP id i2so24624821qkl.5
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 12:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZTDlqQGMB0hy/E/6KeQt4WBQ59Rjf/nY/tOzvJqacz0=;
 b=dv3At8b+F4NqBDr0qhTCiLStt3MEECtSAVGe69tyrZao8sPhh0qd8JjluIttUTPYEu
 4vMHfYFJEnmilGPC4hD8ViM6Zd8Kp3a5JtLk3png8wIi3YLn95AG8NKRyVN0fRCNrx7Y
 u1BbCVvaH9NSgPFtqXwXiBaDXEwh6VRW4t2Umoo32s44CxAJ0My2wPyQ87u1O2L9MuvS
 MPw3qbnT9mJeDkXL+DC6Wgufn3yG9884PDzDAEGjpQD8Rfzt4rSKyCGntm97YAHoYQgc
 lD9NVfDzJ3qlCzxcBK0haNZGIHNFz9ER8cTpGK/5G10vYR1lK8fbgeE/Zvr941wv+UH0
 xaiQ==
X-Gm-Message-State: AGi0PuZCcMjOLHXsAfyN27eXOYBaIVZVXSAtr7iHP/nog9tY41Ge02uw
 WSlHsibe5Qw0gczWNDHViamavgpIltYQpc0zDa46qMOvQbcllXHlV8ilyKrRcu1GJwp196iML9g
 8fKv9P4Z6EO5sa78=
X-Received: by 2002:a37:a090:: with SMTP id
 j138mr30009614qke.168.1588103829228; 
 Tue, 28 Apr 2020 12:57:09 -0700 (PDT)
X-Google-Smtp-Source: APiQypLyZKyg+Db+bdxaGQLXMFG+Dr2ul6n4LdaGhORnFGFqEjq0QdpGM4q1TmnJZu7SFNPhfr1g2A==
X-Received: by 2002:a37:a090:: with SMTP id
 j138mr30009586qke.168.1588103828678; 
 Tue, 28 Apr 2020 12:57:08 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id s50sm14745776qtj.1.2020.04.28.12.57.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 12:57:07 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v2 2/9] linux-headers: Update
Date: Tue, 28 Apr 2020 15:57:00 -0400
Message-Id: <20200428195707.11980-3-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200428195707.11980-1-peterx@redhat.com>
References: <20200428195707.11980-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:11:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/standard-headers/linux/ethtool.h      |  10 +-
 .../linux/input-event-codes.h                 |   5 +-
 include/standard-headers/linux/pci_regs.h     |   2 +
 .../standard-headers/linux/virtio_balloon.h   |   1 +
 include/standard-headers/linux/virtio_ids.h   |   1 +
 linux-headers/COPYING                         |   2 +
 linux-headers/asm-x86/kvm.h                   |   2 +
 linux-headers/asm-x86/unistd_32.h             |   1 +
 linux-headers/asm-x86/unistd_64.h             |   1 +
 linux-headers/asm-x86/unistd_x32.h            |   1 +
 linux-headers/linux/kvm.h                     | 100 +++++++++++++++++-
 linux-headers/linux/mman.h                    |   5 +-
 linux-headers/linux/userfaultfd.h             |  40 +++++--
 linux-headers/linux/vfio.h                    |  37 +++++++
 14 files changed, 195 insertions(+), 13 deletions(-)

diff --git a/include/standard-headers/linux/ethtool.h b/include/standard-he=
aders/linux/ethtool.h
index 8adf3b018b..1200890c86 100644
--- a/include/standard-headers/linux/ethtool.h
+++ b/include/standard-headers/linux/ethtool.h
@@ -596,6 +596,9 @@ struct ethtool_pauseparam {
  * @ETH_SS_LINK_MODES: link mode names
  * @ETH_SS_MSG_CLASSES: debug message class names
  * @ETH_SS_WOL_MODES: wake-on-lan modes
+ * @ETH_SS_SOF_TIMESTAMPING: SOF_TIMESTAMPING_* flags
+ * @ETH_SS_TS_TX_TYPES: timestamping Tx types
+ * @ETH_SS_TS_RX_FILTERS: timestamping Rx filters
  */
 enum ethtool_stringset {
 =09ETH_SS_TEST=09=09=3D 0,
@@ -610,6 +613,9 @@ enum ethtool_stringset {
 =09ETH_SS_LINK_MODES,
 =09ETH_SS_MSG_CLASSES,
 =09ETH_SS_WOL_MODES,
+=09ETH_SS_SOF_TIMESTAMPING,
+=09ETH_SS_TS_TX_TYPES,
+=09ETH_SS_TS_RX_FILTERS,
=20
 =09/* add new constants above here */
 =09ETH_SS_COUNT
@@ -1330,6 +1336,7 @@ enum ethtool_fec_config_bits {
 =09ETHTOOL_FEC_OFF_BIT,
 =09ETHTOOL_FEC_RS_BIT,
 =09ETHTOOL_FEC_BASER_BIT,
+=09ETHTOOL_FEC_LLRS_BIT,
 };
=20
 #define ETHTOOL_FEC_NONE=09=09(1 << ETHTOOL_FEC_NONE_BIT)
@@ -1337,6 +1344,7 @@ enum ethtool_fec_config_bits {
 #define ETHTOOL_FEC_OFF=09=09=09(1 << ETHTOOL_FEC_OFF_BIT)
 #define ETHTOOL_FEC_RS=09=09=09(1 << ETHTOOL_FEC_RS_BIT)
 #define ETHTOOL_FEC_BASER=09=09(1 << ETHTOOL_FEC_BASER_BIT)
+#define ETHTOOL_FEC_LLRS=09=09(1 << ETHTOOL_FEC_LLRS_BIT)
=20
 /* CMDs currently supported */
 #define ETHTOOL_GSET=09=090x00000001 /* DEPRECATED, Get settings.
@@ -1521,7 +1529,7 @@ enum ethtool_link_mode_bit_indices {
 =09ETHTOOL_LINK_MODE_400000baseLR8_ER8_FR8_Full_BIT =3D 71,
 =09ETHTOOL_LINK_MODE_400000baseDR8_Full_BIT=09 =3D 72,
 =09ETHTOOL_LINK_MODE_400000baseCR8_Full_BIT=09 =3D 73,
-
+=09ETHTOOL_LINK_MODE_FEC_LLRS_BIT=09=09=09 =3D 74,
 =09/* must be last entry */
 =09__ETHTOOL_LINK_MODE_MASK_NBITS
 };
diff --git a/include/standard-headers/linux/input-event-codes.h b/include/s=
tandard-headers/linux/input-event-codes.h
index b484c25289..ebf72c1031 100644
--- a/include/standard-headers/linux/input-event-codes.h
+++ b/include/standard-headers/linux/input-event-codes.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
 /*
  * Input event codes
  *
@@ -652,6 +652,9 @@
 /* Electronic privacy screen control */
 #define KEY_PRIVACY_SCREEN_TOGGLE=090x279
=20
+/* Select an area of screen to be copied */
+#define KEY_SELECTIVE_SCREENSHOT=090x27a
+
 /*
  * Some keyboards have keys which do not have a defined meaning, these key=
s
  * are intended to be programmed / bound to macros by the user. For most
diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-h=
eaders/linux/pci_regs.h
index 5437690483..f9701410d3 100644
--- a/include/standard-headers/linux/pci_regs.h
+++ b/include/standard-headers/linux/pci_regs.h
@@ -605,6 +605,7 @@
 #define  PCI_EXP_SLTCTL_PWR_OFF        0x0400 /* Power Off */
 #define  PCI_EXP_SLTCTL_EIC=090x0800=09/* Electromechanical Interlock Cont=
rol */
 #define  PCI_EXP_SLTCTL_DLLSCE=090x1000=09/* Data Link Layer State Changed=
 Enable */
+#define  PCI_EXP_SLTCTL_IBPD_DISABLE=090x4000 /* In-band PD disable */
 #define PCI_EXP_SLTSTA=09=0926=09/* Slot Status */
 #define  PCI_EXP_SLTSTA_ABP=090x0001=09/* Attention Button Pressed */
 #define  PCI_EXP_SLTSTA_PFD=090x0002=09/* Power Fault Detected */
@@ -680,6 +681,7 @@
 #define PCI_EXP_LNKSTA2=09=0950=09/* Link Status 2 */
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2=0952=09/* v2 endpoints with link en=
d here */
 #define PCI_EXP_SLTCAP2=09=0952=09/* Slot Capabilities 2 */
+#define  PCI_EXP_SLTCAP2_IBPD=090x00000001 /* In-band PD Disable Supported=
 */
 #define PCI_EXP_SLTCTL2=09=0956=09/* Slot Control 2 */
 #define PCI_EXP_SLTSTA2=09=0958=09/* Slot Status 2 */
=20
diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/stan=
dard-headers/linux/virtio_balloon.h
index 9375ca2a70..1c5f6d6f2d 100644
--- a/include/standard-headers/linux/virtio_balloon.h
+++ b/include/standard-headers/linux/virtio_balloon.h
@@ -36,6 +36,7 @@
 #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM=092 /* Deflate balloon on OOM */
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT=093 /* VQ to report free pages */
 #define VIRTIO_BALLOON_F_PAGE_POISON=094 /* Guest is using page poisoning =
*/
+#define VIRTIO_BALLOON_F_REPORTING=095 /* Page reporting virtqueue */
=20
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard=
-headers/linux/virtio_ids.h
index 585e07b273..ecc27a1740 100644
--- a/include/standard-headers/linux/virtio_ids.h
+++ b/include/standard-headers/linux/virtio_ids.h
@@ -46,5 +46,6 @@
 #define VIRTIO_ID_IOMMU        23 /* virtio IOMMU */
 #define VIRTIO_ID_FS           26 /* virtio filesystem */
 #define VIRTIO_ID_PMEM         27 /* virtio pmem */
+#define VIRTIO_ID_MAC80211_HWSIM 29 /* virtio mac80211-hwsim */
=20
 #endif /* _LINUX_VIRTIO_IDS_H */
diff --git a/linux-headers/COPYING b/linux-headers/COPYING
index da4cb28feb..a635a38ef9 100644
--- a/linux-headers/COPYING
+++ b/linux-headers/COPYING
@@ -16,3 +16,5 @@ In addition, other licenses may also apply. Please see:
 =09Documentation/process/license-rules.rst
=20
 for more details.
+
+All contributions to the Linux Kernel are subject to this COPYING file.
diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index 503d3f42da..99b15ce39e 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -12,6 +12,7 @@
=20
 #define KVM_PIO_PAGE_OFFSET 1
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 2
+#define KVM_DIRTY_LOG_PAGE_OFFSET 64
=20
 #define DE_VECTOR 0
 #define DB_VECTOR 1
@@ -390,6 +391,7 @@ struct kvm_sync_regs {
 #define KVM_STATE_NESTED_GUEST_MODE=090x00000001
 #define KVM_STATE_NESTED_RUN_PENDING=090x00000002
 #define KVM_STATE_NESTED_EVMCS=09=090x00000004
+#define KVM_STATE_NESTED_MTF_PENDING=090x00000008
=20
 #define KVM_STATE_NESTED_SMM_GUEST_MODE=090x00000001
 #define KVM_STATE_NESTED_SMM_VMXON=090x00000002
diff --git a/linux-headers/asm-x86/unistd_32.h b/linux-headers/asm-x86/unis=
td_32.h
index f6e06fcfbd..1e6c1a5867 100644
--- a/linux-headers/asm-x86/unistd_32.h
+++ b/linux-headers/asm-x86/unistd_32.h
@@ -429,4 +429,5 @@
 #define __NR_openat2 437
 #define __NR_pidfd_getfd 438
=20
+
 #endif /* _ASM_X86_UNISTD_32_H */
diff --git a/linux-headers/asm-x86/unistd_64.h b/linux-headers/asm-x86/unis=
td_64.h
index 924f826d2d..6daf0aecb2 100644
--- a/linux-headers/asm-x86/unistd_64.h
+++ b/linux-headers/asm-x86/unistd_64.h
@@ -351,4 +351,5 @@
 #define __NR_openat2 437
 #define __NR_pidfd_getfd 438
=20
+
 #endif /* _ASM_X86_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/unistd_x32.h b/linux-headers/asm-x86/uni=
std_x32.h
index 010307757b..e3f17ef370 100644
--- a/linux-headers/asm-x86/unistd_x32.h
+++ b/linux-headers/asm-x86/unistd_x32.h
@@ -340,4 +340,5 @@
 #define __NR_preadv2 (__X32_SYSCALL_BIT + 546)
 #define __NR_pwritev2 (__X32_SYSCALL_BIT + 547)
=20
+
 #endif /* _ASM_X86_UNISTD_X32_H */
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 265099100e..f0f3cecce1 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -236,6 +236,7 @@ struct kvm_hyperv_exit {
 #define KVM_EXIT_IOAPIC_EOI       26
 #define KVM_EXIT_HYPERV           27
 #define KVM_EXIT_ARM_NISV         28
+#define KVM_EXIT_DIRTY_RING_FULL  29
=20
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -474,12 +475,17 @@ struct kvm_s390_mem_op {
 =09__u32 size;=09=09/* amount of bytes */
 =09__u32 op;=09=09/* type of operation */
 =09__u64 buf;=09=09/* buffer in userspace */
-=09__u8 ar;=09=09/* the access register number */
-=09__u8 reserved[31];=09/* should be set to 0 */
+=09union {
+=09=09__u8 ar;=09/* the access register number */
+=09=09__u32 sida_offset; /* offset into the sida */
+=09=09__u8 reserved[32]; /* should be set to 0 */
+=09};
 };
 /* types for kvm_s390_mem_op->op */
 #define KVM_S390_MEMOP_LOGICAL_READ=090
 #define KVM_S390_MEMOP_LOGICAL_WRITE=091
+#define KVM_S390_MEMOP_SIDA_READ=092
+#define KVM_S390_MEMOP_SIDA_WRITE=093
 /* flags for kvm_s390_mem_op->flags */
 #define KVM_S390_MEMOP_F_CHECK_ONLY=09=09(1ULL << 0)
 #define KVM_S390_MEMOP_F_INJECT_EXCEPTION=09(1ULL << 1)
@@ -1010,6 +1016,9 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ARM_NISV_TO_USER 177
 #define KVM_CAP_ARM_INJECT_EXT_DABT 178
 #define KVM_CAP_S390_VCPU_RESETS 179
+#define KVM_CAP_S390_PROTECTED 180
+#define KVM_CAP_PPC_SECURE_GUEST 181
+#define KVM_CAP_DIRTY_LOG_RING 182
=20
 #ifdef KVM_CAP_IRQ_ROUTING
=20
@@ -1478,6 +1487,42 @@ struct kvm_enc_region {
 #define KVM_S390_NORMAL_RESET=09_IO(KVMIO,   0xc3)
 #define KVM_S390_CLEAR_RESET=09_IO(KVMIO,   0xc4)
=20
+struct kvm_s390_pv_sec_parm {
+=09__u64 origin;
+=09__u64 length;
+};
+
+struct kvm_s390_pv_unp {
+=09__u64 addr;
+=09__u64 size;
+=09__u64 tweak;
+};
+
+enum pv_cmd_id {
+=09KVM_PV_ENABLE,
+=09KVM_PV_DISABLE,
+=09KVM_PV_SET_SEC_PARMS,
+=09KVM_PV_UNPACK,
+=09KVM_PV_VERIFY,
+=09KVM_PV_PREP_RESET,
+=09KVM_PV_UNSHARE_ALL,
+};
+
+struct kvm_pv_cmd {
+=09__u32 cmd;=09/* Command to be executed */
+=09__u16 rc;=09/* Ultravisor return code */
+=09__u16 rrc;=09/* Ultravisor return reason code */
+=09__u64 data;=09/* Data or address */
+=09__u32 flags;    /* flags for future extensions. Must be 0 for now */
+=09__u32 reserved[3];
+};
+
+/* Available with KVM_CAP_S390_PROTECTED */
+#define KVM_S390_PV_COMMAND=09=09_IOWR(KVMIO, 0xc5, struct kvm_pv_cmd)
+
+/* Available with KVM_CAP_DIRTY_LOG_RING */
+#define KVM_RESET_DIRTY_RINGS=09=09_IO(KVMIO, 0xc6)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 =09/* Guest initialization commands */
@@ -1628,4 +1673,55 @@ struct kvm_hyperv_eventfd {
 #define KVM_HYPERV_CONN_ID_MASK=09=090x00ffffff
 #define KVM_HYPERV_EVENTFD_DEASSIGN=09(1 << 0)
=20
+#define KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE    (1 << 0)
+#define KVM_DIRTY_LOG_INITIALLY_SET            (1 << 1)
+
+/*
+ * Arch needs to define the macro after implementing the dirty ring
+ * feature.  KVM_DIRTY_LOG_PAGE_OFFSET should be defined as the
+ * starting page offset of the dirty ring structures.
+ */
+#ifndef KVM_DIRTY_LOG_PAGE_OFFSET
+#define KVM_DIRTY_LOG_PAGE_OFFSET 0
+#endif
+
+/*
+ * KVM dirty GFN flags, defined as:
+ *
+ * |---------------+---------------+--------------|
+ * | bit 1 (reset) | bit 0 (dirty) | Status       |
+ * |---------------+---------------+--------------|
+ * |             0 |             0 | Invalid GFN  |
+ * |             0 |             1 | Dirty GFN    |
+ * |             1 |             X | GFN to reset |
+ * |---------------+---------------+--------------|
+ *
+ * Lifecycle of a dirty GFN goes like:
+ *
+ *      dirtied         collected        reset
+ * 00 -----------> 01 -------------> 1X -------+
+ *  ^                                          |
+ *  |                                          |
+ *  +------------------------------------------+
+ *
+ * The userspace program is only responsible for the 01->1X state
+ * conversion (to collect dirty bits).  Also, it must not skip any
+ * dirty bits so that dirty bits are always collected in sequence.
+ */
+#define KVM_DIRTY_GFN_F_DIRTY           BIT(0)
+#define KVM_DIRTY_GFN_F_RESET           BIT(1)
+#define KVM_DIRTY_GFN_F_MASK            0x3
+
+/*
+ * KVM dirty rings should be mapped at KVM_DIRTY_LOG_PAGE_OFFSET of
+ * per-vcpu mmaped regions as an array of struct kvm_dirty_gfn.  The
+ * size of the gfn buffer is decided by the first argument when
+ * enabling KVM_CAP_DIRTY_LOG_RING.
+ */
+struct kvm_dirty_gfn {
+=09__u32 flags;
+=09__u32 slot;
+=09__u64 offset;
+};
+
 #endif /* __LINUX_KVM_H */
diff --git a/linux-headers/linux/mman.h b/linux-headers/linux/mman.h
index 1f6e2cd89c..51ea363759 100644
--- a/linux-headers/linux/mman.h
+++ b/linux-headers/linux/mman.h
@@ -5,8 +5,9 @@
 #include <asm/mman.h>
 #include <asm-generic/hugetlb_encode.h>
=20
-#define MREMAP_MAYMOVE=091
-#define MREMAP_FIXED=092
+#define MREMAP_MAYMOVE=09=091
+#define MREMAP_FIXED=09=092
+#define MREMAP_DONTUNMAP=094
=20
 #define OVERCOMMIT_GUESS=09=090
 #define OVERCOMMIT_ALWAYS=09=091
diff --git a/linux-headers/linux/userfaultfd.h b/linux-headers/linux/userfa=
ultfd.h
index ce78878d12..8d3996eb82 100644
--- a/linux-headers/linux/userfaultfd.h
+++ b/linux-headers/linux/userfaultfd.h
@@ -19,7 +19,8 @@
  * means the userland is reading).
  */
 #define UFFD_API ((__u64)0xAA)
-#define UFFD_API_FEATURES (UFFD_FEATURE_EVENT_FORK |=09=09\
+#define UFFD_API_FEATURES (UFFD_FEATURE_PAGEFAULT_FLAG_WP |=09\
+=09=09=09   UFFD_FEATURE_EVENT_FORK |=09=09\
 =09=09=09   UFFD_FEATURE_EVENT_REMAP |=09=09\
 =09=09=09   UFFD_FEATURE_EVENT_REMOVE |=09\
 =09=09=09   UFFD_FEATURE_EVENT_UNMAP |=09=09\
@@ -34,7 +35,8 @@
 #define UFFD_API_RANGE_IOCTLS=09=09=09\
 =09((__u64)1 << _UFFDIO_WAKE |=09=09\
 =09 (__u64)1 << _UFFDIO_COPY |=09=09\
-=09 (__u64)1 << _UFFDIO_ZEROPAGE)
+=09 (__u64)1 << _UFFDIO_ZEROPAGE |=09=09\
+=09 (__u64)1 << _UFFDIO_WRITEPROTECT)
 #define UFFD_API_RANGE_IOCTLS_BASIC=09=09\
 =09((__u64)1 << _UFFDIO_WAKE |=09=09\
 =09 (__u64)1 << _UFFDIO_COPY)
@@ -52,6 +54,7 @@
 #define _UFFDIO_WAKE=09=09=09(0x02)
 #define _UFFDIO_COPY=09=09=09(0x03)
 #define _UFFDIO_ZEROPAGE=09=09(0x04)
+#define _UFFDIO_WRITEPROTECT=09=09(0x06)
 #define _UFFDIO_API=09=09=09(0x3F)
=20
 /* userfaultfd ioctl ids */
@@ -68,6 +71,8 @@
 =09=09=09=09      struct uffdio_copy)
 #define UFFDIO_ZEROPAGE=09=09_IOWR(UFFDIO, _UFFDIO_ZEROPAGE,=09\
 =09=09=09=09      struct uffdio_zeropage)
+#define UFFDIO_WRITEPROTECT=09_IOWR(UFFDIO, _UFFDIO_WRITEPROTECT, \
+=09=09=09=09      struct uffdio_writeprotect)
=20
 /* read() structure */
 struct uffd_msg {
@@ -203,13 +208,14 @@ struct uffdio_copy {
 =09__u64 dst;
 =09__u64 src;
 =09__u64 len;
+#define UFFDIO_COPY_MODE_DONTWAKE=09=09((__u64)1<<0)
 =09/*
-=09 * There will be a wrprotection flag later that allows to map
-=09 * pages wrprotected on the fly. And such a flag will be
-=09 * available if the wrprotection ioctl are implemented for the
-=09 * range according to the uffdio_register.ioctls.
+=09 * UFFDIO_COPY_MODE_WP will map the page write protected on
+=09 * the fly.  UFFDIO_COPY_MODE_WP is available only if the
+=09 * write protected ioctl is implemented for the range
+=09 * according to the uffdio_register.ioctls.
 =09 */
-#define UFFDIO_COPY_MODE_DONTWAKE=09=09((__u64)1<<0)
+#define UFFDIO_COPY_MODE_WP=09=09=09((__u64)1<<1)
 =09__u64 mode;
=20
 =09/*
@@ -231,4 +237,24 @@ struct uffdio_zeropage {
 =09__s64 zeropage;
 };
=20
+struct uffdio_writeprotect {
+=09struct uffdio_range range;
+/*
+ * UFFDIO_WRITEPROTECT_MODE_WP: set the flag to write protect a range,
+ * unset the flag to undo protection of a range which was previously
+ * write protected.
+ *
+ * UFFDIO_WRITEPROTECT_MODE_DONTWAKE: set the flag to avoid waking up
+ * any wait thread after the operation succeeds.
+ *
+ * NOTE: Write protecting a region (WP=3D1) is unrelated to page faults,
+ * therefore DONTWAKE flag is meaningless with WP=3D1.  Removing write
+ * protection (WP=3D0) in response to a page fault wakes the faulting
+ * task unless DONTWAKE is set.
+ */
+#define UFFDIO_WRITEPROTECT_MODE_WP=09=09((__u64)1<<0)
+#define UFFDIO_WRITEPROTECT_MODE_DONTWAKE=09((__u64)1<<1)
+=09__u64 mode;
+};
+
 #endif /* _LINUX_USERFAULTFD_H */
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index fb10370d29..a41c452865 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -707,6 +707,43 @@ struct vfio_device_ioeventfd {
=20
 #define VFIO_DEVICE_IOEVENTFD=09=09_IO(VFIO_TYPE, VFIO_BASE + 16)
=20
+/**
+ * VFIO_DEVICE_FEATURE - _IORW(VFIO_TYPE, VFIO_BASE + 17,
+ *=09=09=09       struct vfio_device_feature)
+ *
+ * Get, set, or probe feature data of the device.  The feature is selected
+ * using the FEATURE_MASK portion of the flags field.  Support for a featu=
re
+ * can be probed by setting both the FEATURE_MASK and PROBE bits.  A probe
+ * may optionally include the GET and/or SET bits to determine read vs wri=
te
+ * access of the feature respectively.  Probing a feature will return succ=
ess
+ * if the feature is supported and all of the optionally indicated GET/SET
+ * methods are supported.  The format of the data portion of the structure=
 is
+ * specific to the given feature.  The data portion is not required for
+ * probing.  GET and SET are mutually exclusive, except for use with PROBE=
.
+ *
+ * Return 0 on success, -errno on failure.
+ */
+struct vfio_device_feature {
+=09__u32=09argsz;
+=09__u32=09flags;
+#define VFIO_DEVICE_FEATURE_MASK=09(0xffff) /* 16-bit feature index */
+#define VFIO_DEVICE_FEATURE_GET=09=09(1 << 16) /* Get feature into data[] =
*/
+#define VFIO_DEVICE_FEATURE_SET=09=09(1 << 17) /* Set feature from data[] =
*/
+#define VFIO_DEVICE_FEATURE_PROBE=09(1 << 18) /* Probe feature support */
+=09__u8=09data[];
+};
+
+#define VFIO_DEVICE_FEATURE=09=09_IO(VFIO_TYPE, VFIO_BASE + 17)
+
+/*
+ * Provide support for setting a PCI VF Token, which is used as a shared
+ * secret between PF and VF drivers.  This feature may only be set on a
+ * PCI SR-IOV PF when SR-IOV is enabled on the PF and there are no existin=
g
+ * open VFs.  Data provided when setting this feature is a 16-byte array
+ * (__u8 b[16]), representing a UUID.
+ */
+#define VFIO_DEVICE_FEATURE_PCI_VF_TOKEN=09(0)
+
 /* -------- API for Type1 VFIO IOMMU -------- */
=20
 /**
--=20
2.24.1


