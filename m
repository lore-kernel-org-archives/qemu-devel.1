Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4300EC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:45:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3BD721A49
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="AmUXOGr/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3BD721A49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUaER-0001LN-S0
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 12:45:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1iUa8c-0002H4-2p
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:39:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1iUa8a-0005ql-Bv
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:39:33 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8086)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1iUa8a-0005qS-1k
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:39:32 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5dcaecee0000>; Tue, 12 Nov 2019 09:33:34 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 12 Nov 2019 09:34:30 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 12 Nov 2019 09:34:30 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Nov
 2019 17:34:29 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 12 Nov 2019 17:34:23 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v9 QEMU 01/15] vfio: KABI for migration interface for device
 state
Date: Tue, 12 Nov 2019 22:35:10 +0530
Message-ID: <1573578324-8389-2-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1573578324-8389-1-git-send-email-kwankhede@nvidia.com>
References: <1573578324-8389-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1573580014; bh=3VqfVTnx3RDYaeQU+8rRBAmTeFVDajVU/9YtrINlanQ=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=AmUXOGr/oLhRmMAvZeZR4rq9m6h1DXpGog9hPT6TYKg7wMa/tYy51JmLWt9xISEJF
 PNS+XcY2ZpI+M5biDcIA+YiSx0UUoQ6fxBoqfA8mUk91kFelqr1HzzIPFxa5ihx6Mj
 4rTX3nsWh5vlRxpeS+nrHfFYcGQVG0M9Ogsap/Os0SLkz/N5WqrMQTQdc2A2MUK/I0
 n8DceQZUNWH38BDv4LPo39YFhb5qRCuVKgTL2ZmpytTiFxGQ2Ur8cmIb8flAhUd1Z2
 Q2DrDGK8wtlp6eMGEFkjU9zUCTZB+KOVkJqpbguga5AgExFd7glwY+5Lm6PF3MF/iw
 NimK/Nri1siqA==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 216.228.121.65
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
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yan.y.zhao@intel.com, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, Kirti Wankhede <kwankhede@nvidia.com>,
 eauger@redhat.com, felipe@nutanix.com, jonathan.davies@nutanix.com,
 changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

- Defined MIGRATION region type and sub-type.
- Used 3 bits to define VFIO device states.
  Bit 0 => _RUNNING
  Bit 1 => _SAVING
  Bit 2 => _RESUMING
  Combination of these bits defines VFIO device's state during migration
  _RUNNING => Normal VFIO device running state. When its reset, it
              indicates _STOPPED state. when device is changed to
              _STOPPED, driver should stop device before write()
              returns.
  _SAVING | _RUNNING => vCPUs are running, VFIO device is running but
                        start saving state of device i.e. pre-copy state
  _SAVING  => vCPUs are stopped, VFIO device should be stopped, and
              save device state,i.e. stop-n-copy state
  _RESUMING => VFIO device resuming state.
  _SAVING | _RESUMING and _RUNNING | _RESUMING => Invalid states
  Bits 3 - 31 are reserved for future use. User should perform
  read-modify-write operation on this field.
- Defined vfio_device_migration_info structure which will be placed at 0th
  offset of migration region to get/set VFIO device related information.
  Defined members of structure and usage on read/write access:
* device_state: (read/write)
    To convey VFIO device state to be transitioned to. Only 3 bits are
    used as of now, Bits 3 - 31 are reserved for future use.
* pending bytes: (read only)
    To get pending bytes yet to be migrated for VFIO device.
* data_offset: (read only)
    To get data offset in migration region from where data exist
    during _SAVING and from where data should be written by user space
    application during _RESUMING state.
* data_size: (read/write)
    To get and set size in bytes of data copied in migration region
    during _SAVING and _RESUMING state.

    Migration region looks like:
     ------------------------------------------------------------------
    |vfio_device_migration_info|    data section                      |
    |                          |     ///////////////////////////////  |
     ------------------------------------------------------------------
     ^                              ^
     offset 0-trapped part        data_offset

Structure vfio_device_migration_info is always followed by data section
in the region, so data_offset will always be non-0. Offset from where data
to be copied is decided by kernel driver, data section can be trapped or
mapped depending on how kernel driver defines data section.
Data section partition can be defined as mapped by sparse mmap capability.
If mmapped, then data_offset should be page aligned, where as initial
section which contain vfio_device_migration_info structure might not end
at offset which is page aligned.
Vendor driver should decide whether to partition data section and how to
partition the data section. Vendor driver should return data_offset
accordingly.

For user application, data is opaque. User should write data in the same
order as received.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 linux-headers/linux/vfio.h | 108 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index fb10370d2928..597b3d4bf45e 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -305,6 +305,7 @@ struct vfio_region_info_cap_type {
 #define VFIO_REGION_TYPE_PCI_VENDOR_MASK	(0xffff)
 #define VFIO_REGION_TYPE_GFX                    (1)
 #define VFIO_REGION_TYPE_CCW			(2)
+#define VFIO_REGION_TYPE_MIGRATION              (3)
 
 /* sub-types for VFIO_REGION_TYPE_PCI_* */
 
@@ -379,6 +380,113 @@ struct vfio_region_gfx_edid {
 /* sub-types for VFIO_REGION_TYPE_CCW */
 #define VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD	(1)
 
+/* sub-types for VFIO_REGION_TYPE_MIGRATION */
+#define VFIO_REGION_SUBTYPE_MIGRATION           (1)
+
+/*
+ * Structure vfio_device_migration_info is placed at 0th offset of
+ * VFIO_REGION_SUBTYPE_MIGRATION region to get/set VFIO device related migration
+ * information. Field accesses from this structure are only supported at their
+ * native width and alignment, otherwise the result is undefined and vendor
+ * drivers should return an error.
+ *
+ * device_state: (read/write)
+ *      To indicate vendor driver the state VFIO device should be transitioned
+ *      to. If device state transition fails, write on this field return error.
+ *      It consists of 3 bits:
+ *      - If bit 0 set, indicates _RUNNING state. When its reset, that indicates
+ *        _STOPPED state. When device is changed to _STOPPED, driver should stop
+ *        device before write() returns.
+ *      - If bit 1 set, indicates _SAVING state. When set, that indicates driver
+ *        should start gathering device state information which will be provided
+ *        to VFIO user space application to save device's state.
+ *      - If bit 2 set, indicates _RESUMING state. When set, that indicates
+ *        prepare to resume device, data provided through migration region
+ *        should be used to resume device.
+ *      Bits 3 - 31 are reserved for future use. User should perform
+ *      read-modify-write operation on this field.
+ *      _SAVING and _RESUMING bits set at the same time is invalid state.
+ *	Similarly _RUNNING and _RESUMING bits set is invalid state.
+ *
+ * pending bytes: (read only)
+ *      Number of pending bytes yet to be migrated from vendor driver
+ *
+ * data_offset: (read only)
+ *      User application should read data_offset in migration region from where
+ *      user application should read device data during _SAVING state or write
+ *      device data during _RESUMING state. See below for detail of sequence to
+ *      be followed.
+ *
+ * data_size: (read/write)
+ *      User application should read data_size to get size of data copied in
+ *      bytes in migration region during _SAVING state and write size of data
+ *      copied in bytes in migration region during _RESUMING state.
+ *
+ * Migration region looks like:
+ *  ------------------------------------------------------------------
+ * |vfio_device_migration_info|    data section                      |
+ * |                          |     ///////////////////////////////  |
+ * ------------------------------------------------------------------
+ *   ^                              ^
+ *  offset 0-trapped part        data_offset
+ *
+ * Structure vfio_device_migration_info is always followed by data section in
+ * the region, so data_offset will always be non-0. Offset from where data is
+ * copied is decided by kernel driver, data section can be trapped or mapped
+ * or partitioned, depending on how kernel driver defines data section.
+ * Data section partition can be defined as mapped by sparse mmap capability.
+ * If mmapped, then data_offset should be page aligned, where as initial section
+ * which contain vfio_device_migration_info structure might not end at offset
+ * which is page aligned.
+ * Vendor driver should decide whether to partition data section and how to
+ * partition the data section. Vendor driver should return data_offset
+ * accordingly.
+ *
+ * Sequence to be followed for _SAVING|_RUNNING device state or pre-copy phase
+ * and for _SAVING device state or stop-and-copy phase:
+ * a. read pending_bytes. If pending_bytes > 0, go through below steps.
+ * b. read data_offset, indicates kernel driver to write data to staging buffer.
+ *    Kernel driver should return this read operation only after writing data to
+ *    staging buffer is done.
+ * c. read data_size, amount of data in bytes written by vendor driver in
+ *    migration region.
+ * d. read data_size bytes of data from data_offset in the migration region.
+ * e. process data.
+ * f. Loop through a to e. Next read on pending_bytes indicates that read data
+ *    operation from migration region for previous iteration is done.
+ *
+ * Sequence to be followed while _RESUMING device state:
+ * While data for this device is available, repeat below steps:
+ * a. read data_offset from where user application should write data.
+ * b. write data of data_size to migration region from data_offset.
+ * c. write data_size which indicates vendor driver that data is written in
+ *    staging buffer. Vendor driver should read this data from migration
+ *    region and resume device's state.
+ *
+ * For user application, data is opaque. User should write data in the same
+ * order as received.
+ */
+
+struct vfio_device_migration_info {
+	__u32 device_state;         /* VFIO device state */
+#define VFIO_DEVICE_STATE_RUNNING   (1 << 0)
+#define VFIO_DEVICE_STATE_SAVING    (1 << 1)
+#define VFIO_DEVICE_STATE_RESUMING  (1 << 2)
+#define VFIO_DEVICE_STATE_MASK      (VFIO_DEVICE_STATE_RUNNING | \
+				     VFIO_DEVICE_STATE_SAVING |  \
+				     VFIO_DEVICE_STATE_RESUMING)
+
+#define VFIO_DEVICE_STATE_INVALID_CASE1    (VFIO_DEVICE_STATE_SAVING | \
+					    VFIO_DEVICE_STATE_RESUMING)
+
+#define VFIO_DEVICE_STATE_INVALID_CASE2    (VFIO_DEVICE_STATE_RUNNING | \
+					    VFIO_DEVICE_STATE_RESUMING)
+	__u32 reserved;
+	__u64 pending_bytes;
+	__u64 data_offset;
+	__u64 data_size;
+} __attribute__((packed));
+
 /*
  * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
  * which allows direct access to non-MSIX registers which happened to be within
-- 
2.7.0


