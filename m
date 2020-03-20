Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FUZZY_XPILL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EF2C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:00:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B89520724
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gYirBsvw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B89520724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFL10-0004hv-Ba
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 13:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jFKzf-0002v5-JM
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:59:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jFKzc-00047Q-N9
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:59:35 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:26316)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jFKzc-00047A-HW
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584723572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jSUhphcEtDDgGsAu0m0vvkcIF22PBn6oRAx3FBpGqZI=;
 b=gYirBsvw4XijIj+doVYvlZgkw9sDKchoNnBPGeXuRVZ8093xXlNJb8e+kXCOuSwuGp3iIO
 ab8/u0h13hgHjqdLjCpdGWAmwzuPyiB2HC6wqOA2ZSJTHN3niOsY3FAOllp4h/5aHaB6iP
 opmRlskc8Xr27H618igk+IioE0ta0zU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-l_pOqHKKNKKogYEalf98_Q-1; Fri, 20 Mar 2020 12:59:30 -0400
X-MC-Unique: l_pOqHKKNKKogYEalf98_Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A460F13EA;
 Fri, 20 Mar 2020 16:59:28 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C91E719757;
 Fri, 20 Mar 2020 16:59:18 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
 yi.l.liu@intel.com
Subject: [RFC v6 02/24] header update against 5.6.0-rc3 and IOMMU/VFIO nested
 stage APIs
Date: Fri, 20 Mar 2020 17:58:18 +0100
Message-Id: <20200320165840.30057-3-eric.auger@redhat.com>
In-Reply-To: <20200320165840.30057-1-eric.auger@redhat.com>
References: <20200320165840.30057-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: jean-philippe@linaro.org, tnowicki@marvell.com, maz@kernel.org,
 zhangfei.gao@foxmail.com, peterx@redhat.com,
 shameerali.kolothum.thodi@huawei.com, zhangfei.gao@linaro.org,
 bbhushan2@marvell.com, will@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an update against
https://github.com/eauger/linux/tree/will-arm-smmu-updates-2stage-v10

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 linux-headers/COPYING       |   2 +
 linux-headers/asm-x86/kvm.h |   1 +
 linux-headers/linux/iommu.h | 375 ++++++++++++++++++++++++++++++++++++
 linux-headers/linux/vfio.h  | 109 ++++++++++-
 4 files changed, 486 insertions(+), 1 deletion(-)
 create mode 100644 linux-headers/linux/iommu.h

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
index 503d3f42da..3f3f780c8c 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -390,6 +390,7 @@ struct kvm_sync_regs {
 #define KVM_STATE_NESTED_GUEST_MODE=090x00000001
 #define KVM_STATE_NESTED_RUN_PENDING=090x00000002
 #define KVM_STATE_NESTED_EVMCS=09=090x00000004
+#define KVM_STATE_NESTED_MTF_PENDING=090x00000008
=20
 #define KVM_STATE_NESTED_SMM_GUEST_MODE=090x00000001
 #define KVM_STATE_NESTED_SMM_VMXON=090x00000002
diff --git a/linux-headers/linux/iommu.h b/linux-headers/linux/iommu.h
new file mode 100644
index 0000000000..1b3f6420bb
--- /dev/null
+++ b/linux-headers/linux/iommu.h
@@ -0,0 +1,375 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * IOMMU user API definitions
+ */
+
+#ifndef _IOMMU_H
+#define _IOMMU_H
+
+#include <linux/types.h>
+
+#define IOMMU_FAULT_PERM_READ=09(1 << 0) /* read */
+#define IOMMU_FAULT_PERM_WRITE=09(1 << 1) /* write */
+#define IOMMU_FAULT_PERM_EXEC=09(1 << 2) /* exec */
+#define IOMMU_FAULT_PERM_PRIV=09(1 << 3) /* privileged */
+
+/* Generic fault types, can be expanded IRQ remapping fault */
+enum iommu_fault_type {
+=09IOMMU_FAULT_DMA_UNRECOV =3D 1,=09/* unrecoverable fault */
+=09IOMMU_FAULT_PAGE_REQ,=09=09/* page request fault */
+};
+
+enum iommu_fault_reason {
+=09IOMMU_FAULT_REASON_UNKNOWN =3D 0,
+
+=09/* Could not access the PASID table (fetch caused external abort) */
+=09IOMMU_FAULT_REASON_PASID_FETCH,
+
+=09/* PASID entry is invalid or has configuration errors */
+=09IOMMU_FAULT_REASON_BAD_PASID_ENTRY,
+
+=09/*
+=09 * PASID is out of range (e.g. exceeds the maximum PASID
+=09 * supported by the IOMMU) or disabled.
+=09 */
+=09IOMMU_FAULT_REASON_PASID_INVALID,
+
+=09/*
+=09 * An external abort occurred fetching (or updating) a translation
+=09 * table descriptor
+=09 */
+=09IOMMU_FAULT_REASON_WALK_EABT,
+
+=09/*
+=09 * Could not access the page table entry (Bad address),
+=09 * actual translation fault
+=09 */
+=09IOMMU_FAULT_REASON_PTE_FETCH,
+
+=09/* Protection flag check failed */
+=09IOMMU_FAULT_REASON_PERMISSION,
+
+=09/* access flag check failed */
+=09IOMMU_FAULT_REASON_ACCESS,
+
+=09/* Output address of a translation stage caused Address Size fault */
+=09IOMMU_FAULT_REASON_OOR_ADDRESS,
+};
+
+/**
+ * struct iommu_fault_unrecoverable - Unrecoverable fault data
+ * @reason: reason of the fault, from &enum iommu_fault_reason
+ * @flags: parameters of this fault (IOMMU_FAULT_UNRECOV_* values)
+ * @pasid: Process Address Space ID
+ * @perm: requested permission access using by the incoming transaction
+ *        (IOMMU_FAULT_PERM_* values)
+ * @addr: offending page address
+ * @fetch_addr: address that caused a fetch abort, if any
+ */
+struct iommu_fault_unrecoverable {
+=09__u32=09reason;
+#define IOMMU_FAULT_UNRECOV_PASID_VALID=09=09(1 << 0)
+#define IOMMU_FAULT_UNRECOV_ADDR_VALID=09=09(1 << 1)
+#define IOMMU_FAULT_UNRECOV_FETCH_ADDR_VALID=09(1 << 2)
+=09__u32=09flags;
+=09__u32=09pasid;
+=09__u32=09perm;
+=09__u64=09addr;
+=09__u64=09fetch_addr;
+};
+
+/**
+ * struct iommu_fault_page_request - Page Request data
+ * @flags: encodes whether the corresponding fields are valid and whether =
this
+ *         is the last page in group (IOMMU_FAULT_PAGE_REQUEST_* values)
+ * @pasid: Process Address Space ID
+ * @grpid: Page Request Group Index
+ * @perm: requested page permissions (IOMMU_FAULT_PERM_* values)
+ * @addr: page address
+ * @private_data: device-specific private information
+ */
+struct iommu_fault_page_request {
+#define IOMMU_FAULT_PAGE_REQUEST_PASID_VALID=09(1 << 0)
+#define IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE=09(1 << 1)
+#define IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA=09(1 << 2)
+=09__u32=09flags;
+=09__u32=09pasid;
+=09__u32=09grpid;
+=09__u32=09perm;
+=09__u64=09addr;
+=09__u64=09private_data[2];
+};
+
+/**
+ * struct iommu_fault - Generic fault data
+ * @type: fault type from &enum iommu_fault_type
+ * @padding: reserved for future use (should be zero)
+ * @event: fault event, when @type is %IOMMU_FAULT_DMA_UNRECOV
+ * @prm: Page Request message, when @type is %IOMMU_FAULT_PAGE_REQ
+ * @padding2: sets the fault size to allow for future extensions
+ */
+struct iommu_fault {
+=09__u32=09type;
+=09__u32=09padding;
+=09union {
+=09=09struct iommu_fault_unrecoverable event;
+=09=09struct iommu_fault_page_request prm;
+=09=09__u8 padding2[56];
+=09};
+};
+
+/**
+ * enum iommu_page_response_code - Return status of fault handlers
+ * @IOMMU_PAGE_RESP_SUCCESS: Fault has been handled and the page tables
+ *=09populated, retry the access. This is "Success" in PCI PRI.
+ * @IOMMU_PAGE_RESP_FAILURE: General error. Drop all subsequent faults fro=
m
+ *=09this device if possible. This is "Response Failure" in PCI PRI.
+ * @IOMMU_PAGE_RESP_INVALID: Could not handle this fault, don't retry the
+ *=09access. This is "Invalid Request" in PCI PRI.
+ */
+enum iommu_page_response_code {
+=09IOMMU_PAGE_RESP_SUCCESS =3D 0,
+=09IOMMU_PAGE_RESP_INVALID,
+=09IOMMU_PAGE_RESP_FAILURE,
+};
+
+/**
+ * struct iommu_page_response - Generic page response information
+ * @version: API version of this structure
+ * @flags: encodes whether the corresponding fields are valid
+ *         (IOMMU_FAULT_PAGE_RESPONSE_* values)
+ * @pasid: Process Address Space ID
+ * @grpid: Page Request Group Index
+ * @code: response code from &enum iommu_page_response_code
+ */
+struct iommu_page_response {
+#define IOMMU_PAGE_RESP_VERSION_1=091
+=09__u32=09version;
+#define IOMMU_PAGE_RESP_PASID_VALID=09(1 << 0)
+=09__u32=09flags;
+=09__u32=09pasid;
+=09__u32=09grpid;
+=09__u32=09code;
+};
+
+/* defines the granularity of the invalidation */
+enum iommu_inv_granularity {
+=09IOMMU_INV_GRANU_DOMAIN,=09/* domain-selective invalidation */
+=09IOMMU_INV_GRANU_PASID,=09/* PASID-selective invalidation */
+=09IOMMU_INV_GRANU_ADDR,=09/* page-selective invalidation */
+=09IOMMU_INV_GRANU_NR,=09/* number of invalidation granularities */
+};
+
+/**
+ * struct iommu_inv_addr_info - Address Selective Invalidation Structure
+ *
+ * @flags: indicates the granularity of the address-selective invalidation
+ * - If the PASID bit is set, the @pasid field is populated and the invali=
dation
+ *   relates to cache entries tagged with this PASID and matching the addr=
ess
+ *   range.
+ * - If ARCHID bit is set, @archid is populated and the invalidation relat=
es
+ *   to cache entries tagged with this architecture specific ID and matchi=
ng
+ *   the address range.
+ * - Both PASID and ARCHID can be set as they may tag different caches.
+ * - If neither PASID or ARCHID is set, global addr invalidation applies.
+ * - The LEAF flag indicates whether only the leaf PTE caching needs to be
+ *   invalidated and other paging structure caches can be preserved.
+ * @pasid: process address space ID
+ * @archid: architecture-specific ID
+ * @addr: first stage/level input address
+ * @granule_size: page/block size of the mapping in bytes
+ * @nb_granules: number of contiguous granules to be invalidated
+ */
+struct iommu_inv_addr_info {
+#define IOMMU_INV_ADDR_FLAGS_PASID=09(1 << 0)
+#define IOMMU_INV_ADDR_FLAGS_ARCHID=09(1 << 1)
+#define IOMMU_INV_ADDR_FLAGS_LEAF=09(1 << 2)
+=09__u32=09flags;
+=09__u32=09archid;
+=09__u64=09pasid;
+=09__u64=09addr;
+=09__u64=09granule_size;
+=09__u64=09nb_granules;
+};
+
+/**
+ * struct iommu_inv_pasid_info - PASID Selective Invalidation Structure
+ *
+ * @flags: indicates the granularity of the PASID-selective invalidation
+ * - If the PASID bit is set, the @pasid field is populated and the invali=
dation
+ *   relates to cache entries tagged with this PASID and matching the addr=
ess
+ *   range.
+ * - If the ARCHID bit is set, the @archid is populated and the invalidati=
on
+ *   relates to cache entries tagged with this architecture specific ID an=
d
+ *   matching the address range.
+ * - Both PASID and ARCHID can be set as they may tag different caches.
+ * - At least one of PASID or ARCHID must be set.
+ * @pasid: process address space ID
+ * @archid: architecture-specific ID
+ */
+struct iommu_inv_pasid_info {
+#define IOMMU_INV_PASID_FLAGS_PASID=09(1 << 0)
+#define IOMMU_INV_PASID_FLAGS_ARCHID=09(1 << 1)
+=09__u32=09flags;
+=09__u32=09archid;
+=09__u64=09pasid;
+};
+
+/**
+ * struct iommu_cache_invalidate_info - First level/stage invalidation
+ *     information
+ * @version: API version of this structure
+ * @cache: bitfield that allows to select which caches to invalidate
+ * @granularity: defines the lowest granularity used for the invalidation:
+ *     domain > PASID > addr
+ * @padding: reserved for future use (should be zero)
+ * @pasid_info: invalidation data when @granularity is %IOMMU_INV_GRANU_PA=
SID
+ * @addr_info: invalidation data when @granularity is %IOMMU_INV_GRANU_ADD=
R
+ *
+ * Not all the combinations of cache/granularity are valid:
+ *
+ * +--------------+---------------+---------------+---------------+
+ * | type /       |   DEV_IOTLB   |     IOTLB     |      PASID    |
+ * | granularity  |               |               |      cache    |
+ * +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+ * | DOMAIN       |       N/A     |       Y       |       Y       |
+ * +--------------+---------------+---------------+---------------+
+ * | PASID        |       Y       |       Y       |       Y       |
+ * +--------------+---------------+---------------+---------------+
+ * | ADDR         |       Y       |       Y       |       N/A     |
+ * +--------------+---------------+---------------+---------------+
+ *
+ * Invalidations by %IOMMU_INV_GRANU_DOMAIN don't take any argument other =
than
+ * @version and @cache.
+ *
+ * If multiple cache types are invalidated simultaneously, they all
+ * must support the used granularity.
+ */
+struct iommu_cache_invalidate_info {
+#define IOMMU_CACHE_INVALIDATE_INFO_VERSION_1 1
+=09__u32=09version;
+/* IOMMU paging structure cache */
+#define IOMMU_CACHE_INV_TYPE_IOTLB=09(1 << 0) /* IOMMU IOTLB */
+#define IOMMU_CACHE_INV_TYPE_DEV_IOTLB=09(1 << 1) /* Device IOTLB */
+#define IOMMU_CACHE_INV_TYPE_PASID=09(1 << 2) /* PASID cache */
+#define IOMMU_CACHE_INV_TYPE_NR=09=09(3)
+=09__u8=09cache;
+=09__u8=09granularity;
+=09__u8=09padding[2];
+=09union {
+=09=09struct iommu_inv_pasid_info pasid_info;
+=09=09struct iommu_inv_addr_info addr_info;
+=09};
+};
+
+/**
+ * struct iommu_gpasid_bind_data_vtd - Intel VT-d specific data on device =
and guest
+ * SVA binding.
+ *
+ * @flags:=09VT-d PASID table entry attributes
+ * @pat:=09Page attribute table data to compute effective memory type
+ * @emt:=09Extended memory type
+ *
+ * Only guest vIOMMU selectable and effective options are passed down to
+ * the host IOMMU.
+ */
+struct iommu_gpasid_bind_data_vtd {
+#define IOMMU_SVA_VTD_GPASID_SRE=09(1 << 0) /* supervisor request */
+#define IOMMU_SVA_VTD_GPASID_EAFE=09(1 << 1) /* extended access enable */
+#define IOMMU_SVA_VTD_GPASID_PCD=09(1 << 2) /* page-level cache disable */
+#define IOMMU_SVA_VTD_GPASID_PWT=09(1 << 3) /* page-level write through */
+#define IOMMU_SVA_VTD_GPASID_EMTE=09(1 << 4) /* extended mem type enable *=
/
+#define IOMMU_SVA_VTD_GPASID_CD=09=09(1 << 5) /* PASID-level cache disable=
 */
+=09__u64 flags;
+=09__u32 pat;
+=09__u32 emt;
+};
+
+/**
+ * struct iommu_gpasid_bind_data - Information about device and guest PASI=
D binding
+ * @version:=09Version of this data structure
+ * @format:=09PASID table entry format
+ * @flags:=09Additional information on guest bind request
+ * @gpgd:=09Guest page directory base of the guest mm to bind
+ * @hpasid:=09Process address space ID used for the guest mm in host IOMMU
+ * @gpasid:=09Process address space ID used for the guest mm in guest IOMM=
U
+ * @addr_width:=09Guest virtual address width
+ * @padding:=09Reserved for future use (should be zero)
+ * @vtd:=09Intel VT-d specific data
+ *
+ * Guest to host PASID mapping can be an identity or non-identity, where g=
uest
+ * has its own PASID space. For non-identify mapping, guest to host PASID =
lookup
+ * is needed when VM programs guest PASID into an assigned device. VMM may
+ * trap such PASID programming then request host IOMMU driver to convert g=
uest
+ * PASID to host PASID based on this bind data.
+ */
+struct iommu_gpasid_bind_data {
+#define IOMMU_GPASID_BIND_VERSION_1=091
+=09__u32 version;
+#define IOMMU_PASID_FORMAT_INTEL_VTD=091
+=09__u32 format;
+#define IOMMU_SVA_GPASID_VAL=09(1 << 0) /* guest PASID valid */
+=09__u64 flags;
+=09__u64 gpgd;
+=09__u64 hpasid;
+=09__u64 gpasid;
+=09__u32 addr_width;
+=09__u8  padding[12];
+=09/* Vendor specific data */
+=09union {
+=09=09struct iommu_gpasid_bind_data_vtd vtd;
+=09};
+};
+
+/**
+ * struct iommu_pasid_smmuv3 - ARM SMMUv3 Stream Table Entry stage 1 relat=
ed
+ *     information
+ * @version: API version of this structure
+ * @s1fmt: STE s1fmt (format of the CD table: single CD, linear table
+ *         or 2-level table)
+ * @s1dss: STE s1dss (specifies the behavior when @pasid_bits !=3D 0
+ *         and no PASID is passed along with the incoming transaction)
+ * @padding: reserved for future use (should be zero)
+ *
+ * The PASID table is referred to as the Context Descriptor (CD) table on =
ARM
+ * SMMUv3. Please refer to the ARM SMMU 3.x spec (ARM IHI 0070A) for full
+ * details.
+ */
+struct iommu_pasid_smmuv3 {
+#define PASID_TABLE_SMMUV3_CFG_VERSION_1 1
+=09__u32=09version;
+=09__u8=09s1fmt;
+=09__u8=09s1dss;
+=09__u8=09padding[2];
+};
+
+/**
+ * struct iommu_pasid_table_config - PASID table data used to bind guest P=
ASID
+ *     table to the host IOMMU
+ * @version: API version to prepare for future extensions
+ * @format: format of the PASID table
+ * @base_ptr: guest physical address of the PASID table
+ * @pasid_bits: number of PASID bits used in the PASID table
+ * @config: indicates whether the guest translation stage must
+ *          be translated, bypassed or aborted.
+ * @padding: reserved for future use (should be zero)
+ * @smmuv3: table information when @format is %IOMMU_PASID_FORMAT_SMMUV3
+ */
+struct iommu_pasid_table_config {
+#define PASID_TABLE_CFG_VERSION_1 1
+=09__u32=09version;
+#define IOMMU_PASID_FORMAT_SMMUV3=091
+=09__u32=09format;
+=09__u64=09base_ptr;
+=09__u8=09pasid_bits;
+#define IOMMU_PASID_CONFIG_TRANSLATE=091
+#define IOMMU_PASID_CONFIG_BYPASS=092
+#define IOMMU_PASID_CONFIG_ABORT=093
+=09__u8=09config;
+=09__u8    padding[6];
+=09union {
+=09=09struct iommu_pasid_smmuv3 smmuv3;
+=09};
+};
+
+#endif /* _IOMMU_H */
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index fb10370d29..fc9adb8df1 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -14,6 +14,7 @@
=20
 #include <linux/types.h>
 #include <linux/ioctl.h>
+#include <linux/iommu.h>
=20
 #define VFIO_API_VERSION=090
=20
@@ -329,6 +330,9 @@ struct vfio_region_info_cap_type {
 /* sub-types for VFIO_REGION_TYPE_GFX */
 #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
=20
+#define VFIO_REGION_TYPE_NESTED=09=09=09(2)
+#define VFIO_REGION_SUBTYPE_NESTED_DMA_FAULT=09(1)
+
 /**
  * struct vfio_region_gfx_edid - EDID region layout.
  *
@@ -455,11 +459,30 @@ struct vfio_irq_info {
 #define VFIO_IRQ_INFO_MASKABLE=09=09(1 << 1)
 #define VFIO_IRQ_INFO_AUTOMASKED=09(1 << 2)
 #define VFIO_IRQ_INFO_NORESIZE=09=09(1 << 3)
+#define VFIO_IRQ_INFO_FLAG_CAPS=09=09(1 << 4) /* Info supports caps */
 =09__u32=09index;=09=09/* IRQ index */
 =09__u32=09count;=09=09/* Number of IRQs within this index */
+=09__u32=09cap_offset;=09/* Offset within info struct of first cap */
 };
 #define VFIO_DEVICE_GET_IRQ_INFO=09_IO(VFIO_TYPE, VFIO_BASE + 9)
=20
+/*
+ * The irq type capability allows IRQs unique to a specific device or
+ * class of devices to be exposed.
+ *
+ * The structures below define version 1 of this capability.
+ */
+#define VFIO_IRQ_INFO_CAP_TYPE      3
+
+struct vfio_irq_info_cap_type {
+=09struct vfio_info_cap_header header;
+=09__u32 type;     /* global per bus driver */
+=09__u32 subtype;  /* type specific */
+};
+
+#define VFIO_IRQ_TYPE_NESTED=09=09=09=09(1)
+#define VFIO_IRQ_SUBTYPE_DMA_FAULT=09=09=09(1)
+
 /**
  * VFIO_DEVICE_SET_IRQS - _IOW(VFIO_TYPE, VFIO_BASE + 10, struct vfio_irq_=
set)
  *
@@ -561,7 +584,8 @@ enum {
 =09VFIO_PCI_MSIX_IRQ_INDEX,
 =09VFIO_PCI_ERR_IRQ_INDEX,
 =09VFIO_PCI_REQ_IRQ_INDEX,
-=09VFIO_PCI_NUM_IRQS
+=09VFIO_PCI_NUM_IRQS =3D 5=09/* Fixed user ABI, IRQ indexes >=3D5 use   */
+=09=09=09=09/* device specific cap to define content */
 };
=20
 /*
@@ -707,6 +731,38 @@ struct vfio_device_ioeventfd {
=20
 #define VFIO_DEVICE_IOEVENTFD=09=09_IO(VFIO_TYPE, VFIO_BASE + 16)
=20
+
+/*
+ * Capability exposed by the DMA fault region
+ * @version: ABI version
+ */
+#define VFIO_REGION_INFO_CAP_DMA_FAULT=096
+
+struct vfio_region_info_cap_fault {
+=09struct vfio_info_cap_header header;
+=09__u32 version;
+};
+
+/*
+ * DMA Fault Region Layout
+ * @tail: index relative to the start of the ring buffer at which the
+ *        consumer finds the next item in the buffer
+ * @entry_size: fault ring buffer entry size in bytes
+ * @nb_entries: max capacity of the fault ring buffer
+ * @offset: ring buffer offset relative to the start of the region
+ * @head: index relative to the start of the ring buffer at which the
+ *        producer (kernel) inserts items into the buffers
+ */
+struct vfio_region_dma_fault {
+=09/* Write-Only */
+=09__u32   tail;
+=09/* Read-Only */
+=09__u32   entry_size;
+=09__u32=09nb_entries;
+=09__u32=09offset;
+=09__u32   head;
+};
+
 /* -------- API for Type1 VFIO IOMMU -------- */
=20
 /**
@@ -794,6 +850,57 @@ struct vfio_iommu_type1_dma_unmap {
 #define VFIO_IOMMU_ENABLE=09_IO(VFIO_TYPE, VFIO_BASE + 15)
 #define VFIO_IOMMU_DISABLE=09_IO(VFIO_TYPE, VFIO_BASE + 16)
=20
+/**
+ * VFIO_IOMMU_SET_PASID_TABLE - _IOWR(VFIO_TYPE, VFIO_BASE + 22,
+ *=09=09=09struct vfio_iommu_type1_set_pasid_table)
+ *
+ * The SET operation passes a PASID table to the host while the
+ * UNSET operation detaches the one currently programmed. Setting
+ * a table while another is already programmed replaces the old table.
+ */
+struct vfio_iommu_type1_set_pasid_table {
+=09__u32=09argsz;
+=09__u32=09flags;
+#define VFIO_PASID_TABLE_FLAG_SET=09(1 << 0)
+#define VFIO_PASID_TABLE_FLAG_UNSET=09(1 << 1)
+=09struct iommu_pasid_table_config config; /* used on SET */
+};
+
+#define VFIO_IOMMU_SET_PASID_TABLE=09_IO(VFIO_TYPE, VFIO_BASE + 22)
+
+/**
+ * VFIO_IOMMU_CACHE_INVALIDATE - _IOWR(VFIO_TYPE, VFIO_BASE + 23,
+ *=09=09=09struct vfio_iommu_type1_cache_invalidate)
+ *
+ * Propagate guest IOMMU cache invalidation to the host.
+ */
+struct vfio_iommu_type1_cache_invalidate {
+=09__u32   argsz;
+=09__u32   flags;
+=09struct iommu_cache_invalidate_info info;
+};
+#define VFIO_IOMMU_CACHE_INVALIDATE      _IO(VFIO_TYPE, VFIO_BASE + 23)
+
+/**
+ * VFIO_IOMMU_SET_MSI_BINDING - _IOWR(VFIO_TYPE, VFIO_BASE + 24,
+ *=09=09=09struct vfio_iommu_type1_set_msi_binding)
+ *
+ * Pass a stage 1 MSI doorbell mapping to the host so that this
+ * latter can build a nested stage2 mapping. Or conversely tear
+ * down a previously bound stage 1 MSI binding.
+ */
+struct vfio_iommu_type1_set_msi_binding {
+=09__u32   argsz;
+=09__u32   flags;
+#define VFIO_IOMMU_BIND_MSI=09(1 << 0)
+#define VFIO_IOMMU_UNBIND_MSI=09(1 << 1)
+=09__u64=09iova;=09/* MSI guest IOVA */
+=09/* Fields below are used on BIND */
+=09__u64=09gpa;=09/* MSI guest physical address */
+=09__u64=09size;=09/* size of stage1 mapping (bytes) */
+};
+#define VFIO_IOMMU_SET_MSI_BINDING      _IO(VFIO_TYPE, VFIO_BASE + 24)
+
 /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- *=
/
=20
 /*
--=20
2.20.1


