Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EBEC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:12:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCFF520719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="is4wy9IZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCFF520719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHXvr-00087r-0c
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55781)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1jHXv3-0007hY-ID
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1jHXv1-0002gS-Mm
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:11:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:49268)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1jHXv1-0002fo-Fx
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585249914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iDU7Er/GzkmlWiwj7LLBPMAlKJgKpRv6KHXsq1guPn0=;
 b=is4wy9IZInhfx5Ugo/Bi+PEcdDTidQ3oPi0zRy53t0XgjyyUUx65UGygOgncxx7jnjtBz9
 oXaFptYnvz45T6NV2PToXm/J5clLMN8Y/N93DVFPUQCH/W4JDnav+GkRPlKWOtpkREXJTX
 aAlwwhRKUT2DTfDAk3si2WfP+3K5JiI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-XKCSfvq5PhmPV5AhnDdFcA-1; Thu, 26 Mar 2020 15:10:25 -0400
X-MC-Unique: XKCSfvq5PhmPV5AhnDdFcA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67E72801E53;
 Thu, 26 Mar 2020 19:10:22 +0000 (UTC)
Received: from x1.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3BF0660BF3;
 Thu, 26 Mar 2020 19:10:20 +0000 (UTC)
Date: Thu, 26 Mar 2020 13:10:19 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v16 QEMU 13/16] vfio: Add function to start and stop
 dirty pages tracking
Message-ID: <20200326131019.5bd29bbb@x1.home>
In-Reply-To: <1585084154-29461-14-git-send-email-kwankhede@nvidia.com>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
 <1585084154-29461-14-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Mar 2020 02:39:11 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> Call VFIO_IOMMU_DIRTY_PAGES ioctl to start and stop dirty pages tracking
> for VFIO devices.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> ---
>  hw/vfio/migration.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index ab295d25620e..1827b7cfb316 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -9,6 +9,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/main-loop.h"
> +#include <sys/ioctl.h>
>  #include <linux/vfio.h>
>  
>  #include "sysemu/runstate.h"
> @@ -296,6 +297,32 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
>      return qemu_file_get_error(f);
>  }
>  
> +static int vfio_start_dirty_page_tracking(VFIODevice *vbasedev, bool start)
> +{
> +    int ret;
> +    VFIOContainer *container = vbasedev->group->container;
> +    struct vfio_iommu_type1_dirty_bitmap dirty = {
> +        .argsz = sizeof(dirty),
> +    };
> +
> +    if (start) {
> +        if (vbasedev->device_state & VFIO_DEVICE_STATE_SAVING) {
> +            dirty.flags = VFIO_IOMMU_DIRTY_PAGES_FLAG_START;
> +        } else {
> +            return 0;
> +        }
> +    } else {
> +            dirty.flags = VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP;
> +    }

Dirty logging and device saving are logically separate, why do we link
them here?

Why do we return success when we want to start logging if we haven't
started logging?

> +
> +    ret = ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, &dirty);
> +    if (ret) {
> +        error_report("Failed to set dirty tracking flag 0x%x errno: %d",
> +                     dirty.flags, errno);
> +    }
> +    return ret;
> +}
> +
>  /* ---------------------------------------------------------------------- */
>  
>  static int vfio_save_setup(QEMUFile *f, void *opaque)
> @@ -330,6 +357,11 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
>       */
>      qemu_put_be64(f, migration->region.size);
>  
> +    ret = vfio_start_dirty_page_tracking(vbasedev, true);
> +    if (ret) {
> +        return ret;
> +    }
> +

Haven't we corrupted the migration stream by exiting here?  Maybe this
implies the entire migration fails, therefore we don't need to add the
end marker?  Thanks,

Alex

>      qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>  
>      ret = qemu_file_get_error(f);
> @@ -346,6 +378,8 @@ static void vfio_save_cleanup(void *opaque)
>      VFIODevice *vbasedev = opaque;
>      VFIOMigration *migration = vbasedev->migration;
>  
> +    vfio_start_dirty_page_tracking(vbasedev, false);
> +
>      if (migration->region.mmaps) {
>          vfio_region_unmap(&migration->region);
>      }
> @@ -669,6 +703,8 @@ static void vfio_migration_state_notifier(Notifier *notifier, void *data)
>          if (ret) {
>              error_report("%s: Failed to set state RUNNING", vbasedev->name);
>          }
> +
> +        vfio_start_dirty_page_tracking(vbasedev, false);
>      }
>  }
>  


