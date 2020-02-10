Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51448C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 17:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CEE920733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 17:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aDNN8GYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CEE920733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Cqp-00005G-9q
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 12:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57319)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1j1Cob-0006gl-RS
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 12:25:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1j1CoU-0003FW-J2
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 12:25:45 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28561
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1j1CoT-0003D6-1B
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 12:25:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581355536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pRlZJQ7fKWXyImFLCXXjz6iJK04yeaevv1AwRlQ1AxQ=;
 b=aDNN8GYQ5/uB5NLNYYxn5c4HO4F4dxkhwOD+JmOTewkPS5zpAQaGyza0H7UmZ5HwD4Ky3D
 kK8+SXhI3/S68ajTJNWSGjPbuFB2K6qadIxDjYgnv/B0XvtDzg4py3aGcr03hNEYVjQmeF
 mBkBQJ67rXhbDaPdfvF3g1mRWgKSGgw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-gWfc_CVmMvO4KTtxmKBzUA-1; Mon, 10 Feb 2020 12:25:21 -0500
X-MC-Unique: gWfc_CVmMvO4KTtxmKBzUA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EF1C8C1300;
 Mon, 10 Feb 2020 17:25:18 +0000 (UTC)
Received: from x1.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D340E8ED05;
 Mon, 10 Feb 2020 17:25:15 +0000 (UTC)
Date: Mon, 10 Feb 2020 10:25:15 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v12 Kernel 1/7] vfio: KABI for migration interface for
 device state
Message-ID: <20200210102515.0c85cc0a@x1.home>
In-Reply-To: <1581104554-10704-2-git-send-email-kwankhede@nvidia.com>
References: <1581104554-10704-1-git-send-email-kwankhede@nvidia.com>
 <1581104554-10704-2-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, kvm@vger.kernel.org, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 8 Feb 2020 01:12:28 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> - Defined MIGRATION region type and sub-type.
> 
> - Defined vfio_device_migration_info structure which will be placed at 0th
>   offset of migration region to get/set VFIO device related information.
>   Defined members of structure and usage on read/write access.
> 
> - Defined device states and state transition details.
> 
> - Defined sequence to be followed while saving and resuming VFIO device.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  include/uapi/linux/vfio.h | 208 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 208 insertions(+)
> 
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 9e843a147ead..572242620ce9 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -305,6 +305,7 @@ struct vfio_region_info_cap_type {
>  #define VFIO_REGION_TYPE_PCI_VENDOR_MASK	(0xffff)
>  #define VFIO_REGION_TYPE_GFX                    (1)
>  #define VFIO_REGION_TYPE_CCW			(2)
> +#define VFIO_REGION_TYPE_MIGRATION              (3)
>  
>  /* sub-types for VFIO_REGION_TYPE_PCI_* */
>  
> @@ -379,6 +380,213 @@ struct vfio_region_gfx_edid {
>  /* sub-types for VFIO_REGION_TYPE_CCW */
>  #define VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD	(1)
>  
> +/* sub-types for VFIO_REGION_TYPE_MIGRATION */
> +#define VFIO_REGION_SUBTYPE_MIGRATION           (1)
> +
> +/*
> + * Structure vfio_device_migration_info is placed at 0th offset of
> + * VFIO_REGION_SUBTYPE_MIGRATION region to get/set VFIO device related migration
> + * information. Field accesses from this structure are only supported at their
> + * native width and alignment, otherwise the result is undefined and vendor
> + * drivers should return an error.
> + *
> + * device_state: (read/write)
> + *      - User application writes this field to inform vendor driver about the
> + *        device state to be transitioned to.
> + *      - Vendor driver should take necessary actions to change device state.
> + *        On successful transition to given state, vendor driver should return
> + *        success on write(device_state, state) system call. If device state
> + *        transition fails, vendor driver should return error, -EFAULT.

s/error, -EFAULT/an appropriate -errno for the fault condition/

> + *      - On user application side, if device state transition fails, i.e. if
> + *        write(device_state, state) returns error, read device_state again to
> + *        determine the current state of the device from vendor driver.
> + *      - Vendor driver should return previous state of the device unless vendor
> + *        driver has encountered an internal error, in which case vendor driver
> + *        may report the device_state VFIO_DEVICE_STATE_ERROR.
> + *	- User application must use the device reset ioctl in order to recover
> + *	  the device from VFIO_DEVICE_STATE_ERROR state. If the device is
> + *	  indicated in a valid device state via reading device_state, the user
> + *	  application may decide attempt to transition the device to any valid
> + *	  state reachable from the current state or terminate itself.
> + *
> + *      device_state consists of 3 bits:
> + *      - If bit 0 set, indicates _RUNNING state. When it's clear, that
> + *	  indicates _STOP state. When device is changed to _STOP, driver should
> + *	  stop device before write() returns.
> + *      - If bit 1 set, indicates _SAVING state. When set, that indicates driver
> + *        should start gathering device state information which will be provided
> + *        to VFIO user application to save device's state.
> + *      - If bit 2 set, indicates _RESUMING state. When set, that indicates
> + *        prepare to resume device, data provided through migration region
> + *        should be used to resume device.
> + *      Bits 3 - 31 are reserved for future use. In order to preserve them,
> + *	user application should perform read-modify-write operation on this
> + *	field when modifying the specified bits.
> + *
> + *  +------- _RESUMING
> + *  |+------ _SAVING
> + *  ||+----- _RUNNING
> + *  |||
> + *  000b => Device Stopped, not saving or resuming
> + *  001b => Device running state, default state
> + *  010b => Stop Device & save device state, stop-and-copy state
> + *  011b => Device running and save device state, pre-copy state
> + *  100b => Device stopped and device state is resuming
> + *  101b => Invalid state
> + *  110b => Error state
> + *  111b => Invalid state
> + *
> + * State transitions:
> + *
> + *              _RESUMING  _RUNNING    Pre-copy    Stop-and-copy   _STOP
> + *                (100b)     (001b)     (011b)        (010b)       (000b)
> + * 0. Running or Default state
> + *                             |
> + *
> + * 1. Normal Shutdown (optional)
> + *                             |------------------------------------->|
> + *
> + * 2. Save state or Suspend
> + *                             |------------------------->|---------->|
> + *
> + * 3. Save state during live migration
> + *                             |----------->|------------>|---------->|
> + *
> + * 4. Resuming
> + *                  |<---------|
> + *
> + * 5. Resumed
> + *                  |--------->|
> + *
> + * 0. Default state of VFIO device is _RUNNNG when user application starts.
> + * 1. During normal user application shutdown, vfio device state changes
> + *    from _RUNNING to _STOP. This is optional, user application may or may not
> + *    perform this state transition and vendor driver may not need.

s/may not need/must not require, but must support this transition/

> + * 2. When user application save state or suspend application, device state
> + *    transitions from _RUNNING to stop-and-copy state and then to _STOP.
> + *    On state transition from _RUNNING to stop-and-copy, driver must
> + *    stop device, save device state and send it to application through
> + *    migration region. Sequence to be followed for such transition is given
> + *    below.
> + * 3. In user application live migration, state transitions from _RUNNING
> + *    to pre-copy to stop-and-copy to _STOP.
> + *    On state transition from _RUNNING to pre-copy, driver should start
> + *    gathering device state while application is still running and send device
> + *    state data to application through migration region.
> + *    On state transition from pre-copy to stop-and-copy, driver must stop
> + *    device, save device state and send it to user application through
> + *    migration region.
> + *    Sequence to be followed for above two transitions is given below.

Perhaps adding something like "Vendor drivers must support the pre-copy
state even for implementations where no data is provided to the user
until the stop-and-copy state.  The user must not be required to
consume all migration data prior to transitioning to a new state,
including the stop-and-copy state."

> + * 4. To start resuming phase, device state should be transitioned from
> + *    _RUNNING to _RESUMING state.
> + *    In _RESUMING state, driver should use received device state data through
> + *    migration region to resume device.
> + * 5. On providing saved device data to driver, application should change state
> + *    from _RESUMING to _RUNNING.
> + *
> + * pending bytes: (read only)
> + *      Number of pending bytes yet to be migrated from vendor driver
> + *
> + * data_offset: (read only)
> + *      User application should read data_offset in migration region from where
> + *      user application should read device data during _SAVING state or write
> + *      device data during _RESUMING state. See below for detail of sequence to
> + *      be followed.
> + *
> + * data_size: (read/write)
> + *      User application should read data_size to get size of data copied in
> + *      bytes in migration region during _SAVING state and write size of data
> + *      copied in bytes in migration region during _RESUMING state.
> + *
> + * Migration region looks like:
> + *  ------------------------------------------------------------------
> + * |vfio_device_migration_info|    data section                      |
> + * |                          |     ///////////////////////////////  |
> + * ------------------------------------------------------------------
> + *   ^                              ^
> + *  offset 0-trapped part        data_offset
> + *
> + * Structure vfio_device_migration_info is always followed by data section in
> + * the region, so data_offset will always be non-0. Offset from where data is
> + * copied is decided by kernel driver, data section can be trapped or mapped
> + * or partitioned, depending on how kernel driver defines data section.
> + * Data section partition can be defined as mapped by sparse mmap capability.
> + * If mmapped, then data_offset should be page aligned, where as initial section
> + * which contain vfio_device_migration_info structure might not end at offset
> + * which is page aligned. The user is not required to access via mmap regardless
> + * of the region mmap capabilities.
> + * Vendor driver should decide whether to partition data section and how to
> + * partition the data section. Vendor driver should return data_offset
> + * accordingly.
> + *
> + * Sequence to be followed for _SAVING|_RUNNING device state or pre-copy phase
> + * and for _SAVING device state or stop-and-copy phase:
> + * a. read pending_bytes, indicates start of new iteration to get device data.
> + *    Repeatative read on pending_bytes at this stage should have no side
> + *    effect.

s/Repeatative/Repeated/

> + *    If pending_bytes == 0, user application should not iterate to get data
> + *    for that device.
> + *    If pending_bytes > 0, go through below steps.
> + * b. read data_offset, indicates vendor driver to make data available through
> + *    data section. Vendor driver should return this read operation only after
> + *    data is available from (region + data_offset) to (region + data_offset +
> + *    data_size).
> + * c. read data_size, amount of data in bytes available through migration
> + *    region.
> + *    Read on data_offset and data_size should return offset and size of current
> + *    buffer if user application reads those more than once here.
> + * d. read data of data_size bytes from (region + data_offset) from migration
> + *    region.
> + * e. process data.
> + * f. read pending_bytes, this read operation indicates data from previous
> + *    iteration had read. If pending_bytes > 0, goto step b.
> + *
> + * If there is any error during the above sequence, vendor driver can return
> + * error code for next read()/write() operation, that will terminate the loop
> + * and user should take next necessary action, for example, fail migration or
> + * terminate user application.
> + *
> + * User application can transition from _SAVING|_RUNNING (pre-copy state) to
> + * _SAVING (stop-and-copy) state regardless of pending bytes.

Ok, you cover one of my concerns above here.  Maybe doesn't hurt to
mention in both places.

> + * User application should iterate in _SAVING (stop-and-copy) until
> + * pending_bytes is 0.
> + *
> + * Sequence to be followed while _RESUMING device state:
> + * While data for this device is available, repeat below steps:
> + * a. read data_offset from where user application should write data.
> + * b. write data of data_size to migration region from data_offset. Data size
> + *    should be data packet size at source during _SAVING.

I find the reference to data_size a bit confusing in this wording,
almost as if it's implied that the user reads data_size on the target.
What if we changed it a little:

 b. write migration data starting at migration region + data_offset for
 length determined by data_size from the migration source.

> + * c. write data_size which indicates vendor driver that data is written in
> + *    migration region. Vendor driver should read this data from migration
> + *    region and resume device's state.

Perhaps "Vendor driver should apply the user provided migration region
data towards the device resume state"?

> + *
> + * For user application, data is opaque. User application should write data in
> + * the same order as received and should of same transaction size at source.

Great!

> + */
> +
> +struct vfio_device_migration_info {
> +	__u32 device_state;         /* VFIO device state */
> +#define VFIO_DEVICE_STATE_STOP      (0)
> +#define VFIO_DEVICE_STATE_RUNNING   (1 << 0)
> +#define VFIO_DEVICE_STATE_SAVING    (1 << 1)
> +#define VFIO_DEVICE_STATE_RESUMING  (1 << 2)
> +#define VFIO_DEVICE_STATE_MASK      (VFIO_DEVICE_STATE_RUNNING | \
> +				     VFIO_DEVICE_STATE_SAVING |  \
> +				     VFIO_DEVICE_STATE_RESUMING)
> +
> +#define VFIO_DEVICE_STATE_VALID(state) \
> +	(state & VFIO_DEVICE_STATE_RESUMING ? \
> +	(state & VFIO_DEVICE_STATE_MASK) == VFIO_DEVICE_STATE_RESUMING : 1)
> +
> +#define VFIO_DEVICE_STATE_ERROR			\
> +		(VFIO_DEVICE_STATE_SAVING | VFIO_DEVICE_STATE_RESUMING)

It looks like this isn't used in this series, so I'm not sure the
intention of this macro, but I think we decided to only use 110b as the
"error" state.  So should this be something like

#define VFIO_DEVICE_STATE_IS_ERROR(state) \
	(state & VFIO_DEVICE_STATE_MASK == (VFIO_DEVICE_STATE_SAVING | \
					    VFIO_DEVICE_STATE_RESUMING))

Or if this was intended to be used in setting the device_state to
error, perhaps

#define VFIO_DEVICE_STATE_SET_ERROR(state) \
	((state & ~VFIO_DEVICE_STATE_MASK) | VFIO_DEVICE_SATE_SAVING | \
					     VFIO_DEVICE_STATE_RESUMING)
> +
> +	__u32 reserved;

Can we specify this reserved field as reads return zero, writes are
ignored so that we give ourselves the opportunity to re-purpose it
later?

> +	__u64 pending_bytes;
> +	__u64 data_offset;
> +	__u64 data_size;
> +} __attribute__((packed));
> +
>  /*
>   * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
>   * which allows direct access to non-MSIX registers which happened to be within

Thanks,
Alex


