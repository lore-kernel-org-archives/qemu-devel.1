Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E064C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 22:52:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1174620738
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 22:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjIuDFqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1174620738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnVIF-0002V7-AR
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 18:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jnVHA-0001sF-MR
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 18:50:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37326
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jnVH7-0002sG-TB
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 18:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592866248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8DdhSpXOYzz8Ej1fKEduogQeaFFIZPm2wFFTNivW5lc=;
 b=CjIuDFqvZM0itN4yEE19XAPnqRN2MdUyAvk6SmGQEYa76hqgv4KidTnQMup4OOHK21SHXm
 /hY6cshLVVkTAo5tZjs/xK0AjzzADk+zvbca18Hz16m98tNjp9wtsXXi1HKc60bEzFj0FT
 hAufO95RGcyWJy73uJCimaN68pMScoY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-_ahEcjB7Paq2PMgbOetM0A-1; Mon, 22 Jun 2020 18:50:46 -0400
X-MC-Unique: _ahEcjB7Paq2PMgbOetM0A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1996172F6F;
 Mon, 22 Jun 2020 22:50:44 +0000 (UTC)
Received: from x1.home (ovpn-112-156.phx2.redhat.com [10.3.112.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD7B178FD6;
 Mon, 22 Jun 2020 22:50:21 +0000 (UTC)
Date: Mon, 22 Jun 2020 16:50:19 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH QEMU v25 05/17] vfio: Add VM state change handler to
 know state of VM
Message-ID: <20200622165019.27b5f395@x1.home>
In-Reply-To: <1592684486-18511-6-git-send-email-kwankhede@nvidia.com>
References: <1592684486-18511-1-git-send-email-kwankhede@nvidia.com>
 <1592684486-18511-6-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:17:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On Sun, 21 Jun 2020 01:51:14 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> VM state change handler gets called on change in VM's state. This is used to set
> VFIO device state to _RUNNING.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/vfio/migration.c           | 87 +++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/trace-events          |  2 +
>  include/hw/vfio/vfio-common.h |  4 ++
>  3 files changed, 93 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 48ac385d80a7..fcecc0bb0874 100644
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
> @@ -74,6 +75,85 @@ err:
>      return ret;
>  }
>  
> +static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t mask,
> +                                    uint32_t value)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIORegion *region = &migration->region;
> +    uint32_t device_state;
> +    int ret;
> +
> +    ret = pread(vbasedev->fd, &device_state, sizeof(device_state),
> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
> +                                              device_state));
> +    if (ret < 0) {
> +        error_report("%s: Failed to read device state %d %s",
> +                     vbasedev->name, ret, strerror(errno));
> +        return ret;
> +    }
> +
> +    device_state = (device_state & mask) | value;
> +
> +    if (!VFIO_DEVICE_STATE_VALID(device_state)) {
> +        return -EINVAL;
> +    }
> +
> +    ret = pwrite(vbasedev->fd, &device_state, sizeof(device_state),
> +                 region->fd_offset + offsetof(struct vfio_device_migration_info,
> +                                              device_state));
> +    if (ret < 0) {
> +        error_report("%s: Failed to set device state %d %s",
> +                     vbasedev->name, ret, strerror(errno));
> +
> +        ret = pread(vbasedev->fd, &device_state, sizeof(device_state),
> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
> +                device_state));
> +        if (ret < 0) {
> +            error_report("%s: On failure, failed to read device state %d %s",
> +                    vbasedev->name, ret, strerror(errno));
> +            return ret;
> +        }
> +
> +        if (VFIO_DEVICE_STATE_IS_ERROR(device_state)) {
> +            error_report("%s: Device is in error state 0x%x",
> +                         vbasedev->name, device_state);
> +            return -EFAULT;
> +        }
> +    }
> +
> +    vbasedev->device_state = device_state;
> +    trace_vfio_migration_set_state(vbasedev->name, device_state);
> +    return 0;
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
> +            error_report("%s: Failed to set device state 0x%x",
> +                         vbasedev->name, value & mask);


Is there nothing more we should do here?  It seems like in either the
case of an outbound migration where we can't stop the device or an
inbound migration where we can't start the device, we'd want this to
trigger an abort of the migration.  Should there at least be a TODO
comment if the reason is that QEMU migration doesn't yet support failure
here?  Thanks,

Alex

> +        }
> +        vbasedev->vm_running = running;
> +        trace_vfio_vmstate_change(vbasedev->name, running, RunState_str(state),
> +                                  value & mask);
> +    }
> +}
> +
>  static int vfio_migration_init(VFIODevice *vbasedev,
>                                 struct vfio_region_info *info)
>  {
> @@ -87,8 +167,11 @@ static int vfio_migration_init(VFIODevice *vbasedev,
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
> @@ -131,6 +214,10 @@ add_blocker:
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
> index fd034ac53684..14b0a86c0035 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -146,3 +146,5 @@ vfio_display_edid_write_error(void) ""
>  
>  # migration.c
>  vfio_migration_probe(const char *name, uint32_t index) " (%s) Region %d"
> +vfio_migration_set_state(char *name, uint32_t state) " (%s) state %d"
> +vfio_vmstate_change(char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index d4b268641173..3d18eb146b33 100644
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
>  } VFIODevice;
>  
>  struct VFIODeviceOps {


