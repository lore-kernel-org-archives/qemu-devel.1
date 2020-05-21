Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8316AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 11:20:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 371382072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 11:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXxrGnKC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371382072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbjFM-0000R6-C1
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 07:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jbjEb-0007y5-Ow
 for qemu-devel@nongnu.org; Thu, 21 May 2020 07:19:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37859
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jbjEa-0004yu-Nf
 for qemu-devel@nongnu.org; Thu, 21 May 2020 07:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590059971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SnN5RkZqCjFf+yXOWWTC9O58O1JQDt5utNcwOfChlN8=;
 b=OXxrGnKClev3GsPfby72BIHbTO5TrNcBSb5sWahaTKMgWKXHNimrsPOPQCakZ/GU2k7F6n
 HUze3Zle2P961eh1ZHBGcc/5jxYfIhetjymzunAwsGhrdbjkCjfFoO6KZQNwFAmU/F6PIP
 Sj/cr3y0Ocl8OsSfKBLYbDrSt9OX1p0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-lPmvtMNGMEme5AkPoIcGZg-1; Thu, 21 May 2020 07:19:29 -0400
X-MC-Unique: lPmvtMNGMEme5AkPoIcGZg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D699A1005510;
 Thu, 21 May 2020 11:19:26 +0000 (UTC)
Received: from work-vm (ovpn-113-115.ams2.redhat.com [10.36.113.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 56C0682EEF;
 Thu, 21 May 2020 11:19:15 +0000 (UTC)
Date: Thu, 21 May 2020 12:19:07 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH QEMU v23 06/18] vfio: Add VM state change handler to know
 state of VM
Message-ID: <20200521111907.GD2752@work-vm>
References: <1589999088-31477-1-git-send-email-kwankhede@nvidia.com>
 <1589999088-31477-7-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <1589999088-31477-7-git-send-email-kwankhede@nvidia.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:44:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, kevin.tian@intel.com,
 yan.y.zhao@intel.com, alex.williamson@redhat.com, changpeng.liu@intel.com,
 eskultet@redhat.com, Ken.Xue@amd.com, jonathan.davies@nutanix.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Kirti Wankhede (kwankhede@nvidia.com) wrote:
> VM state change handler gets called on change in VM's state. This is used to set
> VFIO device state to _RUNNING.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hw/vfio/migration.c           | 87 +++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/trace-events          |  2 +
>  include/hw/vfio/vfio-common.h |  4 ++
>  3 files changed, 93 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index bf9384907ec0..e79b34003079 100644
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
> @@ -90,6 +170,9 @@ static int vfio_migration_init(VFIODevice *vbasedev,
>          return ret;
>      }
>  
> +    vbasedev->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
> +                                                          vbasedev);
> +
>      return 0;
>  }
>  
> @@ -128,6 +211,10 @@ add_blocker:
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
> -- 
> 2.7.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


