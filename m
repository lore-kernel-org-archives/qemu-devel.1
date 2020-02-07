Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20143C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 20:19:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D207920715
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 20:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ESZpDxNI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D207920715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0A6U-0002cE-2O
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 15:19:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1j0A3B-0005fW-T9
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 15:16:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1j0A3A-0006lU-1c
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 15:16:29 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:16217)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1j0A39-0006kG-Ro
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 15:16:28 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e3dc55c0001>; Fri, 07 Feb 2020 12:15:25 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 07 Feb 2020 12:16:24 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 07 Feb 2020 12:16:24 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Feb
 2020 20:16:24 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 7 Feb 2020 20:16:17 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v12 Kernel 1/7] vfio: KABI for migration interface for device
 state
Date: Sat, 8 Feb 2020 01:12:28 +0530
Message-ID: <1581104554-10704-2-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1581104554-10704-1-git-send-email-kwankhede@nvidia.com>
References: <1581104554-10704-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1581106525; bh=Wk/4vlleosW0ARxawGyH3dUipo434bU6vZVMB6qpW1Y=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=ESZpDxNI6FyuI9/di6HP09hWINSc4fqZKC/ppLb0GYCnjl9gNKyzOZAayjZ4DWPLM
 hdT2ZQo+ezYwU3VOI5vESbYJFZJURs60dq/lzSb5pFhB7p6DvUIMeiffOSh60gvfA/
 qGZPZYLXfCI0DZ5qkqcomEDndYUz0eZwelHoZBVu56DPbUGGeuUp14skB2NCtf7X5W
 oF74rgH1kkMTU10PAZdT4rGMVbEjNkegAaxzYK+w3Ur40ACP0rlQf8+DAzzOql2lCg
 t7mN6HZYK8dCpe3FvYtU6lSIYM2ASOvd/wIZrDmQYH4CnriQFDU/txEpjpxaoLtsaI
 MjGIj9UtsY5zg==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 216.228.121.143
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
 yan.y.zhao@intel.com, kvm@vger.kernel.org, eskultet@redhat.com,
 ziye.yang@intel.com, qemu-devel@nongnu.org, cohuck@redhat.com,
 shuangtai.tst@alibaba-inc.com, dgilbert@redhat.com, zhi.a.wang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

- Defined MIGRATION region type and sub-type.

- Defined vfio_device_migration_info structure which will be placed at 0th
  offset of migration region to get/set VFIO device related information.
  Defined members of structure and usage on read/write access.

- Defined device states and state transition details.

- Defined sequence to be followed while saving and resuming VFIO device.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 include/uapi/linux/vfio.h | 208 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 9e843a147ead..572242620ce9 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -305,6 +305,7 @@ struct vfio_region_info_cap_type {
 #define VFIO_REGION_TYPE_PCI_VENDOR_MASK	(0xffff)
 #define VFIO_REGION_TYPE_GFX                    (1)
 #define VFIO_REGION_TYPE_CCW			(2)
+#define VFIO_REGION_TYPE_MIGRATION              (3)
 
 /* sub-types for VFIO_REGION_TYPE_PCI_* */
 
@@ -379,6 +380,213 @@ struct vfio_region_gfx_edid {
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
+ *      - User application writes this field to inform vendor driver about the
+ *        device state to be transitioned to.
+ *      - Vendor driver should take necessary actions to change device state.
+ *        On successful transition to given state, vendor driver should return
+ *        success on write(device_state, state) system call. If device state
+ *        transition fails, vendor driver should return error, -EFAULT.
+ *      - On user application side, if device state transition fails, i.e. if
+ *        write(device_state, state) returns error, read device_state again to
+ *        determine the current state of the device from vendor driver.
+ *      - Vendor driver should return previous state of the device unless vendor
+ *        driver has encountered an internal error, in which case vendor driver
+ *        may report the device_state VFIO_DEVICE_STATE_ERROR.
+ *	- User application must use the device reset ioctl in order to recover
+ *	  the device from VFIO_DEVICE_STATE_ERROR state. If the device is
+ *	  indicated in a valid device state via reading device_state, the user
+ *	  application may decide attempt to transition the device to any valid
+ *	  state reachable from the current state or terminate itself.
+ *
+ *      device_state consists of 3 bits:
+ *      - If bit 0 set, indicates _RUNNING state. When it's clear, that
+ *	  indicates _STOP state. When device is changed to _STOP, driver should
+ *	  stop device before write() returns.
+ *      - If bit 1 set, indicates _SAVING state. When set, that indicates driver
+ *        should start gathering device state information which will be provided
+ *        to VFIO user application to save device's state.
+ *      - If bit 2 set, indicates _RESUMING state. When set, that indicates
+ *        prepare to resume device, data provided through migration region
+ *        should be used to resume device.
+ *      Bits 3 - 31 are reserved for future use. In order to preserve them,
+ *	user application should perform read-modify-write operation on this
+ *	field when modifying the specified bits.
+ *
+ *  +------- _RESUMING
+ *  |+------ _SAVING
+ *  ||+----- _RUNNING
+ *  |||
+ *  000b => Device Stopped, not saving or resuming
+ *  001b => Device running state, default state
+ *  010b => Stop Device & save device state, stop-and-copy state
+ *  011b => Device running and save device state, pre-copy state
+ *  100b => Device stopped and device state is resuming
+ *  101b => Invalid state
+ *  110b => Error state
+ *  111b => Invalid state
+ *
+ * State transitions:
+ *
+ *              _RESUMING  _RUNNING    Pre-copy    Stop-and-copy   _STOP
+ *                (100b)     (001b)     (011b)        (010b)       (000b)
+ * 0. Running or Default state
+ *                             |
+ *
+ * 1. Normal Shutdown (optional)
+ *                             |------------------------------------->|
+ *
+ * 2. Save state or Suspend
+ *                             |------------------------->|---------->|
+ *
+ * 3. Save state during live migration
+ *                             |----------->|------------>|---------->|
+ *
+ * 4. Resuming
+ *                  |<---------|
+ *
+ * 5. Resumed
+ *                  |--------->|
+ *
+ * 0. Default state of VFIO device is _RUNNNG when user application starts.
+ * 1. During normal user application shutdown, vfio device state changes
+ *    from _RUNNING to _STOP. This is optional, user application may or may not
+ *    perform this state transition and vendor driver may not need.
+ * 2. When user application save state or suspend application, device state
+ *    transitions from _RUNNING to stop-and-copy state and then to _STOP.
+ *    On state transition from _RUNNING to stop-and-copy, driver must
+ *    stop device, save device state and send it to application through
+ *    migration region. Sequence to be followed for such transition is given
+ *    below.
+ * 3. In user application live migration, state transitions from _RUNNING
+ *    to pre-copy to stop-and-copy to _STOP.
+ *    On state transition from _RUNNING to pre-copy, driver should start
+ *    gathering device state while application is still running and send device
+ *    state data to application through migration region.
+ *    On state transition from pre-copy to stop-and-copy, driver must stop
+ *    device, save device state and send it to user application through
+ *    migration region.
+ *    Sequence to be followed for above two transitions is given below.
+ * 4. To start resuming phase, device state should be transitioned from
+ *    _RUNNING to _RESUMING state.
+ *    In _RESUMING state, driver should use received device state data through
+ *    migration region to resume device.
+ * 5. On providing saved device data to driver, application should change state
+ *    from _RESUMING to _RUNNING.
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
+ * which is page aligned. The user is not required to access via mmap regardless
+ * of the region mmap capabilities.
+ * Vendor driver should decide whether to partition data section and how to
+ * partition the data section. Vendor driver should return data_offset
+ * accordingly.
+ *
+ * Sequence to be followed for _SAVING|_RUNNING device state or pre-copy phase
+ * and for _SAVING device state or stop-and-copy phase:
+ * a. read pending_bytes, indicates start of new iteration to get device data.
+ *    Repeatative read on pending_bytes at this stage should have no side
+ *    effect.
+ *    If pending_bytes == 0, user application should not iterate to get data
+ *    for that device.
+ *    If pending_bytes > 0, go through below steps.
+ * b. read data_offset, indicates vendor driver to make data available through
+ *    data section. Vendor driver should return this read operation only after
+ *    data is available from (region + data_offset) to (region + data_offset +
+ *    data_size).
+ * c. read data_size, amount of data in bytes available through migration
+ *    region.
+ *    Read on data_offset and data_size should return offset and size of current
+ *    buffer if user application reads those more than once here.
+ * d. read data of data_size bytes from (region + data_offset) from migration
+ *    region.
+ * e. process data.
+ * f. read pending_bytes, this read operation indicates data from previous
+ *    iteration had read. If pending_bytes > 0, goto step b.
+ *
+ * If there is any error during the above sequence, vendor driver can return
+ * error code for next read()/write() operation, that will terminate the loop
+ * and user should take next necessary action, for example, fail migration or
+ * terminate user application.
+ *
+ * User application can transition from _SAVING|_RUNNING (pre-copy state) to
+ * _SAVING (stop-and-copy) state regardless of pending bytes.
+ * User application should iterate in _SAVING (stop-and-copy) until
+ * pending_bytes is 0.
+ *
+ * Sequence to be followed while _RESUMING device state:
+ * While data for this device is available, repeat below steps:
+ * a. read data_offset from where user application should write data.
+ * b. write data of data_size to migration region from data_offset. Data size
+ *    should be data packet size at source during _SAVING.
+ * c. write data_size which indicates vendor driver that data is written in
+ *    migration region. Vendor driver should read this data from migration
+ *    region and resume device's state.
+ *
+ * For user application, data is opaque. User application should write data in
+ * the same order as received and should of same transaction size at source.
+ */
+
+struct vfio_device_migration_info {
+	__u32 device_state;         /* VFIO device state */
+#define VFIO_DEVICE_STATE_STOP      (0)
+#define VFIO_DEVICE_STATE_RUNNING   (1 << 0)
+#define VFIO_DEVICE_STATE_SAVING    (1 << 1)
+#define VFIO_DEVICE_STATE_RESUMING  (1 << 2)
+#define VFIO_DEVICE_STATE_MASK      (VFIO_DEVICE_STATE_RUNNING | \
+				     VFIO_DEVICE_STATE_SAVING |  \
+				     VFIO_DEVICE_STATE_RESUMING)
+
+#define VFIO_DEVICE_STATE_VALID(state) \
+	(state & VFIO_DEVICE_STATE_RESUMING ? \
+	(state & VFIO_DEVICE_STATE_MASK) == VFIO_DEVICE_STATE_RESUMING : 1)
+
+#define VFIO_DEVICE_STATE_ERROR			\
+		(VFIO_DEVICE_STATE_SAVING | VFIO_DEVICE_STATE_RESUMING)
+
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


