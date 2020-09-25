Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220F1C4727F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 21:59:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB5F62068D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 21:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CcbRU4DJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5F62068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLvko-00085P-Rl
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 17:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kLvh6-0004Mq-KU
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 17:55:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32439)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kLvh4-000642-Im
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 17:55:56 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601070954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fCeGO9qoACFPiErxbXKNsk1OATOOjNSFiE/WQEbSITY=;
 b=CcbRU4DJ4j/MvKvnLk7UC7eYhdPlY1W+oy+a4PGd61i4WkguK5bE193K6ZXcQrjqT78JXn
 CwbKcmosFdShgUXgSmx8xho7qMPkQsOdk3yHnUTf/FLTqyTrYIP6BbAkbyQLQP3lyqpddv
 u6+7+wDZceMngcs2MbqSRlAaaHcPK64=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-SO-dMWXxMz-ZpfwEEnhoKw-1; Fri, 25 Sep 2020 17:55:52 -0400
X-MC-Unique: SO-dMWXxMz-ZpfwEEnhoKw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC9A01084C96;
 Fri, 25 Sep 2020 21:55:49 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D9E25C1BB;
 Fri, 25 Sep 2020 21:55:48 +0000 (UTC)
Date: Fri, 25 Sep 2020 14:20:23 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v26 05/17] vfio: Add VM state change handler to know
 state of VM
Message-ID: <20200925142023.54e2c7c0@x1.home>
In-Reply-To: <1600817059-26721-6-git-send-email-kwankhede@nvidia.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-6-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: cohuck@redhat.com, cjia@nvidia.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, kevin.tian@intel.com,
 yan.y.zhao@intel.com, dgilbert@redhat.com, changpeng.liu@intel.com,
 eskultet@redhat.com, Ken.Xue@amd.com, jonathan.davies@nutanix.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 23 Sep 2020 04:54:07 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> VM state change handler gets called on change in VM's state. This is used to set
> VFIO device state to _RUNNING.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/vfio/migration.c           | 136 ++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/trace-events          |   3 +-
>  include/hw/vfio/vfio-common.h |   4 ++
>  3 files changed, 142 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 2f760f1f9c47..a30d628ba963 100644
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
> @@ -22,6 +23,58 @@
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
> +        error_report("vfio_mig_%s%d %s: failed at offset 0x%lx, err: %s",
> +                     iswrite ? "write" : "read", count * 8,
> +                     vbasedev->name, off, strerror(errno));

This would suggest from the log that there's, for example, a
vfio_mig_read8 function, which doesn't exist.

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
>  
>  static void vfio_migration_region_exit(VFIODevice *vbasedev)
>  {
> @@ -70,6 +123,82 @@ err:
>      return ret;
>  }
>  
> +static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t mask,
> +                                    uint32_t value)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIORegion *region = &migration->region;
> +    off_t dev_state_off = region->fd_offset +
> +                      offsetof(struct vfio_device_migration_info, device_state);
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

Agree with Connie that mask and value args are not immediately obvious
how they're used.  I don't have a naming convention that would be more
clear and the names do make some sense once they're understood, but a
comment to indicate mask bits are preserved, value bits are set,
remaining bits are cleared would probably help the reader.

> +
> +    if (!VFIO_DEVICE_STATE_VALID(device_state)) {
> +        return -EINVAL;
> +    }
> +
> +    ret = vfio_mig_write(vbasedev, &device_state, sizeof(device_state),
> +                         dev_state_off);
> +    if (ret < 0) {
> +        ret = vfio_mig_read(vbasedev, &device_state, sizeof(device_state),
> +                          dev_state_off);
> +        if (ret < 0) {
> +            return ret;

Seems like we're in pretty bad shape here, should this be combined with
below to trigger a hw_error?

> +        }
> +
> +        if (VFIO_DEVICE_STATE_IS_ERROR(device_state)) {
> +            hw_error("%s: Device is in error state 0x%x",
> +                     vbasedev->name, device_state);
> +            return -EFAULT;
> +        }
> +    }
> +
> +    vbasedev->device_state = device_state;
> +    trace_vfio_migration_set_state(vbasedev->name, device_state);
> +    return 0;

So we return success even if we failed to write the desired state as
long as we were able to read back any non-error state?
vbasedev->device_state remains correct, but it seems confusing form a
caller perspective that a set-state can succeed but it's then necessary
to check the state.

> +}
> +
> +static void vfio_vmstate_change(void *opaque, int running, RunState state)
> +{
> +    VFIODevice *vbasedev = opaque;
> +
> +    if ((vbasedev->vm_running != running)) {
> +        int ret;
> +        uint32_t value = 0, mask = 0;
> +
> +        if (running) {
> +            value = VFIO_DEVICE_STATE_RUNNING;
> +            if (vbasedev->device_state & VFIO_DEVICE_STATE_RESUMING) {
> +                mask = ~VFIO_DEVICE_STATE_RESUMING;
> +            }
> +        } else {
> +            mask = ~VFIO_DEVICE_STATE_RUNNING;
> +        }
> +
> +        ret = vfio_migration_set_state(vbasedev, mask, value);
> +        if (ret) {
> +            /*
> +             * vm_state_notify() doesn't support reporting failure. If such
> +             * error reporting support added in furure, migration should be
> +             * aborted.
> +             */
> +            error_report("%s: Failed to set device state 0x%x",
> +                         vbasedev->name, value & mask);
> +        }

Here for instance we assume that success means the device is now in the
desired state, but we'd actually need to evaluate
vbasedev->device_state to determine that.

> +        vbasedev->vm_running = running;
> +        trace_vfio_vmstate_change(vbasedev->name, running, RunState_str(state),
> +                                  value & mask);
> +    }
> +}
> +
>  static int vfio_migration_init(VFIODevice *vbasedev,
>                                 struct vfio_region_info *info)
>  {
> @@ -87,8 +216,11 @@ static int vfio_migration_init(VFIODevice *vbasedev,
>                       vbasedev->name);
>          g_free(vbasedev->migration);
>          vbasedev->migration = NULL;
> +        return ret;
>      }
>  
> +    vbasedev->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
> +                                                          vbasedev);
>      return ret;
>  }
>  
> @@ -131,6 +263,10 @@ add_blocker:
>  
>  void vfio_migration_finalize(VFIODevice *vbasedev)
>  {
> +    if (vbasedev->vm_state) {
> +        qemu_del_vm_change_state_handler(vbasedev->vm_state);
> +    }
> +
>      if (vbasedev->migration_blocker) {
>          migrate_del_blocker(vbasedev->migration_blocker);
>          error_free(vbasedev->migration_blocker);
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 8fe913175d85..6524734bf7b4 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -149,4 +149,5 @@ vfio_display_edid_write_error(void) ""
>  
>  # migration.c
>  vfio_migration_probe(const char *name, uint32_t index) " (%s) Region %d"
> -
> +vfio_migration_set_state(char *name, uint32_t state) " (%s) state %d"
> +vfio_vmstate_change(char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 8275c4c68f45..25e3b1a3b90a 100644
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
> @@ -119,6 +120,9 @@ typedef struct VFIODevice {
>      unsigned int flags;
>      VFIOMigration *migration;
>      Error *migration_blocker;
> +    VMChangeStateEntry *vm_state;
> +    uint32_t device_state;
> +    int vm_running;

Could these be placed in VFIOMigration?  Thanks,

Alex

>  } VFIODevice;
>  
>  struct VFIODeviceOps {


