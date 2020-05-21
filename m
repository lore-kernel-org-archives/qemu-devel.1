Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F561C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:19:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E10720759
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPbShwKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E10720759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboqc-00013h-AL
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jboQT-0003ug-Ea
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:52:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59462
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jboQR-0008KJ-Gn
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590079925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ec4RLZmFUi/ZWVXLoJtBmMk7Zv9vYqbGpEU/jXVQFhk=;
 b=RPbShwKxtbAp/CmfagqPOaAHrBswHjJ8kXirolamqKrtW2YCzrcpc+mmMq1n32av5nL7oA
 QJD4lD19xEiP7dBtxK8z1OxaXR+HjXop4ycaVPoYrZn9OHghMt4v970zO6+0FhpYbawZLF
 Qn+gq3t0BBtpyvNvahO9T025Fe/tmy8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-j9GGX-QjN6WQ4Tsnx_xs6A-1; Thu, 21 May 2020 12:52:03 -0400
X-MC-Unique: j9GGX-QjN6WQ4Tsnx_xs6A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E23EE157D8;
 Thu, 21 May 2020 16:51:43 +0000 (UTC)
Received: from work-vm (ovpn-113-115.ams2.redhat.com [10.36.113.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53D631801D;
 Thu, 21 May 2020 16:51:02 +0000 (UTC)
Date: Thu, 21 May 2020 17:50:59 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH QEMU v23 14/18] vfio: Add function to start and stop
 dirty pages tracking
Message-ID: <20200521165059.GK2752@work-vm>
References: <1589999088-31477-1-git-send-email-kwankhede@nvidia.com>
 <1589999088-31477-15-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <1589999088-31477-15-git-send-email-kwankhede@nvidia.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
> Call VFIO_IOMMU_DIRTY_PAGES ioctl to start and stop dirty pages tracking
> for VFIO devices.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>

This does seem to match my reading of your 4/8 ioctl sefinition patch,
so:

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

I must admit I don't see why 'argsz' is needed.

Dave

> ---
>  hw/vfio/migration.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index b9bbe38e539c..7729c90782bd 100644
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
> @@ -297,6 +298,32 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
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
> +            return -EINVAL;
> +        }
> +    } else {
> +            dirty.flags = VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP;
> +    }
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
> @@ -327,6 +354,11 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
>          return ret;
>      }
>  
> +    ret = vfio_start_dirty_page_tracking(vbasedev, true);
> +    if (ret) {
> +        return ret;
> +    }
> +
>      qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>  
>      ret = qemu_file_get_error(f);
> @@ -342,6 +374,8 @@ static void vfio_save_cleanup(void *opaque)
>      VFIODevice *vbasedev = opaque;
>      VFIOMigration *migration = vbasedev->migration;
>  
> +    vfio_start_dirty_page_tracking(vbasedev, false);
> +
>      if (migration->region.mmaps) {
>          vfio_region_unmap(&migration->region);
>      }
> @@ -676,6 +710,8 @@ static void vfio_migration_state_notifier(Notifier *notifier, void *data)
>          if (ret) {
>              error_report("%s: Failed to set state RUNNING", vbasedev->name);
>          }
> +
> +        vfio_start_dirty_page_tracking(vbasedev, false);
>      }
>  }
>  
> -- 
> 2.7.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


