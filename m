Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87333C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 16:37:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85B492463F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 16:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TF4YEB7X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B492463F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVdaQ-0008Td-AX
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 12:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kVdZ0-0007JX-LT
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 12:35:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41392)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kVdYx-000668-Ll
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 12:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603384538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wrM29EfuxpzF02lkmLOJe3u/5i9GajO3Vs7g8xVzHd4=;
 b=TF4YEB7XB0SB8r7S2uByWSC8R07pws61bVpflHWwKpam9oD5APG/7ahr0MOLFP4tUi6AJU
 B41l/OLvMBfqbQF5Id5cxxfvzk6HGcBzDBw9246GRE4NckRg12a9uqTE1xJ8dmk6apOzg4
 XvW9Nm15+seizViE3lf+ot2ym+Su9IE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-3wTfVSwLNnuPj95k6NUGKw-1; Thu, 22 Oct 2020 12:35:34 -0400
X-MC-Unique: 3wTfVSwLNnuPj95k6NUGKw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A8371084D7C;
 Thu, 22 Oct 2020 16:35:31 +0000 (UTC)
Received: from w520.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 590E95C1D7;
 Thu, 22 Oct 2020 16:35:25 +0000 (UTC)
Date: Thu, 22 Oct 2020 10:35:24 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v27 05/17] vfio: Add VM state change handler to know
 state of VM
Message-ID: <20201022103524.1e567cb2@w520.home>
In-Reply-To: <1603365127-14202-6-git-send-email-kwankhede@nvidia.com>
References: <1603365127-14202-1-git-send-email-kwankhede@nvidia.com>
 <1603365127-14202-6-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:09:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: cohuck@redhat.com, cjia@nvidia.com, zhi.wang.linux@gmail.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, mcrossley@nvidia.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com, dgilbert@redhat.com,
 changpeng.liu@intel.com, eskultet@redhat.com, Ken.Xue@amd.com,
 jonathan.davies@nutanix.com, pbonzini@redhat.com, dnigam@nvidia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 22 Oct 2020 16:41:55 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> VM state change handler is called on change in VM's state. Based on
> VM state, VFIO device state should be changed.
> Added read/write helper functions for migration region.
> Added function to set device_state.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/vfio/migration.c           | 158 ++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/trace-events          |   2 +
>  include/hw/vfio/vfio-common.h |   4 ++
>  3 files changed, 164 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 5f74a3ad1d72..34f39c7e2e28 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -10,6 +10,7 @@
>  #include "qemu/osdep.h"
>  #include <linux/vfio.h>
>  
> +#include "sysemu/runstate.h"
>  #include "hw/vfio/vfio-common.h"
>  #include "cpu.h"
>  #include "migration/migration.h"
> @@ -22,6 +23,157 @@
>  #include "exec/ram_addr.h"
>  #include "pci.h"
>  #include "trace.h"
> +#include "hw/hw.h"
> +
> +static inline int vfio_mig_access(VFIODevice *vbasedev, void *val, int count,
> +                                  off_t off, bool iswrite)
> +{
> +    int ret;
> +
> +    ret = iswrite ? pwrite(vbasedev->fd, val, count, off) :
> +                    pread(vbasedev->fd, val, count, off);
> +    if (ret < count) {
> +        error_report("vfio_mig_%s %d byte %s: failed at offset 0x%lx, err: %s",
> +                     iswrite ? "write" : "read", count,
> +                     vbasedev->name, off, strerror(errno));
> +        return (ret < 0) ? ret : -EINVAL;
> +    }
> +    return 0;
> +}
> +
> +static int vfio_mig_rw(VFIODevice *vbasedev, __u8 *buf, size_t count,
> +                       off_t off, bool iswrite)
> +{
> +    int ret, done = 0;
> +    __u8 *tbuf = buf;
> +
> +    while (count) {
> +        int bytes = 0;
> +
> +        if (count >= 8 && !(off % 8)) {
> +            bytes = 8;
> +        } else if (count >= 4 && !(off % 4)) {
> +            bytes = 4;
> +        } else if (count >= 2 && !(off % 2)) {
> +            bytes = 2;
> +        } else {
> +            bytes = 1;
> +        }
> +
> +        ret = vfio_mig_access(vbasedev, tbuf, bytes, off, iswrite);
> +        if (ret) {
> +            return ret;
> +        }
> +
> +        count -= bytes;
> +        done += bytes;
> +        off += bytes;
> +        tbuf += bytes;
> +    }
> +    return done;
> +}
> +
> +#define vfio_mig_read(f, v, c, o)       vfio_mig_rw(f, (__u8 *)v, c, o, false)
> +#define vfio_mig_write(f, v, c, o)      vfio_mig_rw(f, (__u8 *)v, c, o, true)
> +
> +#define VFIO_MIG_STRUCT_OFFSET(f)       \
> +                                 offsetof(struct vfio_device_migration_info, f)
> +/*
> + * Change the device_state register for device @vbasedev. Bits set in @mask
> + * are preserved, bits set in @value are set, and bits not set in either @mask
> + * or @value are cleared in device_state. If the register cannot be accessed,
> + * the resulting state would be invalid, or the device enters an error state,
> + * an error is returned.
> + */
> +
> +static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t mask,
> +                                    uint32_t value)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIORegion *region = &migration->region;
> +    off_t dev_state_off = region->fd_offset +
> +                          VFIO_MIG_STRUCT_OFFSET(device_state);
> +    uint32_t device_state;
> +    int ret;
> +
> +    ret = vfio_mig_read(vbasedev, &device_state, sizeof(device_state),
> +                        dev_state_off);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    device_state = (device_state & mask) | value;
> +
> +    if (!VFIO_DEVICE_STATE_VALID(device_state)) {
> +        return -EINVAL;
> +    }
> +
> +    ret = vfio_mig_write(vbasedev, &device_state, sizeof(device_state),
> +                         dev_state_off);
> +    if (ret < 0) {
> +        int rret;
> +
> +        rret = vfio_mig_read(vbasedev, &device_state, sizeof(device_state),
> +                             dev_state_off);
> +
> +        if ((rret < 0) || (VFIO_DEVICE_STATE_IS_ERROR(device_state))) {
> +            hw_error("%s: Device in error state 0x%x", vbasedev->name,
> +                     device_state);
> +            return rret ? rret : -EIO;
> +        }
> +        return ret;
> +    }
> +
> +    migration->device_state = device_state;
> +    trace_vfio_migration_set_state(vbasedev->name, device_state);
> +    return 0;
> +}
> +
> +static void vfio_vmstate_change(void *opaque, int running, RunState state)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    uint32_t value, mask;
> +    int ret;
> +
> +    if ((vbasedev->migration->vm_running == running)) {
> +        return;
> +    }
> +
> +    if (running) {
> +        /*
> +         * Here device state can have one of _SAVING, _RESUMING or _STOP bit.
> +         * Transition from _SAVING to _RUNNING can happen if there is migration
> +         * failure, in that case clear _SAVING bit.
> +         * Transition from _RESUMING to _RUNNING occurs during resuming
> +         * phase, in that case clear _RESUMING bit.
> +         * In both the above cases, set _RUNNING bit.
> +         */
> +        mask = ~VFIO_DEVICE_STATE_MASK;
> +        value = VFIO_DEVICE_STATE_RUNNING;
> +    } else {
> +        /*
> +         * Here device state could be either _RUNNING or _SAVING|_RUNNING. Reset
> +         * _RUNNING bit
> +         */
> +        mask = ~VFIO_DEVICE_STATE_RUNNING;
> +        value = 0;
> +    }
> +
> +    ret = vfio_migration_set_state(vbasedev, mask, value);
> +    if (ret) {
> +        /*
> +         * Migration should be aborted in this case, but vm_state_notify()
> +         * currently does not support reporting failures.
> +         */
> +        error_report("%s: Failed to set device state 0x%x", vbasedev->name,
> +                     (migration->device_state & mask) | value);
> +        qemu_file_set_error(migrate_get_current()->to_dst_file, ret);
> +    }
> +    vbasedev->migration->vm_running = running;
> +    trace_vfio_vmstate_change(vbasedev->name, running, RunState_str(state),
> +            (migration->device_state & mask) | value);
> +}
>  
>  static void vfio_migration_region_exit(VFIODevice *vbasedev)
>  {
> @@ -71,6 +223,8 @@ static int vfio_migration_init(VFIODevice *vbasedev,
>      }
>  
>      vbasedev->migration = migration;
> +    migration->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
> +                                                          vbasedev);
>      return 0;
>  
>  err:
> @@ -118,6 +272,10 @@ add_blocker:
>  
>  void vfio_migration_finalize(VFIODevice *vbasedev)
>  {
> +    if (vbasedev->migration->vm_state) {
> +        qemu_del_vm_change_state_handler(vbasedev->migration->vm_state);
> +    }


This looks like a segfault, vfio_migration_teardown() is eventually
called unconditionally.  The next patch modifies this function further,
but never checks that vbasedev->migration is non-NULL.  Thanks,

Alex


> +
>      if (vbasedev->migration_blocker) {
>          migrate_del_blocker(vbasedev->migration_blocker);
>          error_free(vbasedev->migration_blocker);
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 9ced5ec6277c..41de81f12f60 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -148,3 +148,5 @@ vfio_display_edid_write_error(void) ""
>  
>  # migration.c
>  vfio_migration_probe(const char *name, uint32_t index) " (%s) Region %d"
> +vfio_migration_set_state(const char *name, uint32_t state) " (%s) state %d"
> +vfio_vmstate_change(const char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 8275c4c68f45..9a571f1fb552 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -29,6 +29,7 @@
>  #ifdef CONFIG_LINUX
>  #include <linux/vfio.h>
>  #endif
> +#include "sysemu/sysemu.h"
>  
>  #define VFIO_MSG_PREFIX "vfio %s: "
>  
> @@ -58,7 +59,10 @@ typedef struct VFIORegion {
>  } VFIORegion;
>  
>  typedef struct VFIOMigration {
> +    VMChangeStateEntry *vm_state;
>      VFIORegion region;
> +    uint32_t device_state;
> +    int vm_running;
>  } VFIOMigration;
>  
>  typedef struct VFIOAddressSpace {


