Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBC2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9661B2072E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8mpo6hQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9661B2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jngFK-000478-ML
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 06:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jngEf-0003i2-LV
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:33:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52620
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jngEd-0006D4-AG
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592908377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ziD0L0hZHZL8tLyJLC7l33/0/1hiRRRKgpyGZPQBpBk=;
 b=e8mpo6hQsY7tY89PFBiHP2v+VCXrjatd5ZEkbIloKOrezDttpbODlVmyjQe8/woP+tYshd
 EmsZSOmU5OffBtfplSSESOkZNZ6cwiNsccI0YPJQp1l1SG1vmDm4/ceY1ClQroLpx4Iz2c
 Q1AAyt0zTXqVqiPlM3FUR8mHCg2fOJ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-qkiVX0WWN8uuWV68Wu3dHA-1; Tue, 23 Jun 2020 06:32:55 -0400
X-MC-Unique: qkiVX0WWN8uuWV68Wu3dHA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E751BFC0;
 Tue, 23 Jun 2020 10:32:53 +0000 (UTC)
Received: from gondolin (ovpn-112-222.ams2.redhat.com [10.36.112.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 231BE100EBD2;
 Tue, 23 Jun 2020 10:32:18 +0000 (UTC)
Date: Tue, 23 Jun 2020 12:32:16 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH QEMU v25 12/17] vfio: Add function to start and stop
 dirty pages tracking
Message-ID: <20200623123216.17eefe2e.cohuck@redhat.com>
In-Reply-To: <1592684486-18511-13-git-send-email-kwankhede@nvidia.com>
References: <1592684486-18511-1-git-send-email-kwankhede@nvidia.com>
 <1592684486-18511-13-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:55:08
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
Cc: cjia@nvidia.com, aik@ozlabs.ru, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, peterx@redhat.com,
 eauger@redhat.com, yi.l.liu@intel.com, quintela@redhat.com,
 ziye.yang@intel.com, armbru@redhat.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, felipe@nutanix.com, zhi.a.wang@intel.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, changpeng.liu@intel.com, eskultet@redhat.com,
 Ken.Xue@amd.com, jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 21 Jun 2020 01:51:21 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> Call VFIO_IOMMU_DIRTY_PAGES ioctl to start and stop dirty pages tracking
> for VFIO devices.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/vfio/migration.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index faacea5327cb..e0fbb3a01855 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -11,6 +11,7 @@
>  #include "qemu/main-loop.h"
>  #include "qemu/cutils.h"
>  #include <linux/vfio.h>
> +#include <sys/ioctl.h>
>  
>  #include "sysemu/runstate.h"
>  #include "hw/vfio/vfio-common.h"
> @@ -329,6 +330,32 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
>      return qemu_file_get_error(f);
>  }
>  
> +static int vfio_start_dirty_page_tracking(VFIODevice *vbasedev, bool start)

I find 'start' functions that may also stop something a bit confusing.
Maybe vfio_toggle_dirty_page_tracking()?

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
> @@ -360,6 +387,11 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
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
> @@ -375,6 +407,8 @@ static void vfio_save_cleanup(void *opaque)
>      VFIODevice *vbasedev = opaque;
>      VFIOMigration *migration = vbasedev->migration;
>  
> +    vfio_start_dirty_page_tracking(vbasedev, false);

I suppose we can't do anything useful if stopping dirty page tracking
fails?

> +
>      if (migration->region.mmaps) {
>          vfio_region_unmap(&migration->region);
>      }
> @@ -706,6 +740,8 @@ static void vfio_migration_state_notifier(Notifier *notifier, void *data)
>          if (ret) {
>              error_report("%s: Failed to set state RUNNING", vbasedev->name);
>          }
> +
> +        vfio_start_dirty_page_tracking(vbasedev, false);
>      }
>  }
>  


