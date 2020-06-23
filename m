Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989B8C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:02:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 646F620768
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JiWms+b4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646F620768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnghH-00021L-Gd
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jnggV-0001bl-Gk
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:01:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59412
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jnggS-000584-Lr
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592910102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o2ucEhjbnW7/mjPRQZF/oV3WPodjkmV8zQLFM2Ll2wQ=;
 b=JiWms+b4l/zsPUTvAbpQAqCpHYb3rjIQEKFieKOIiQho6aWw4uO+Irn/hLj3yTOnNMfat7
 N0eiT58NDpy/MKsKXvB//23bc5/b571OKg4D3c1XIMco9cjBUMPk/X8TVuJr3fbDOE6r1F
 swNA6M4Tkm4u9o8nmTPKw1zob0d5UZg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-yfilmfI2MmeEHIkaSkWBQw-1; Tue, 23 Jun 2020 07:01:41 -0400
X-MC-Unique: yfilmfI2MmeEHIkaSkWBQw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDA048005AD;
 Tue, 23 Jun 2020 11:01:38 +0000 (UTC)
Received: from work-vm (ovpn-115-91.ams2.redhat.com [10.36.115.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69A305BACB;
 Tue, 23 Jun 2020 11:01:28 +0000 (UTC)
Date: Tue, 23 Jun 2020 12:01:25 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH QEMU v25 12/17] vfio: Add function to start and stop
 dirty pages tracking
Message-ID: <20200623110125.GD3328@work-vm>
References: <1592684486-18511-1-git-send-email-kwankhede@nvidia.com>
 <1592684486-18511-13-git-send-email-kwankhede@nvidia.com>
 <20200623123216.17eefe2e.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200623123216.17eefe2e.cohuck@redhat.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
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
Cc: cjia@nvidia.com, aik@ozlabs.ru, Zhengxiao.zx@alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, peterx@redhat.com,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, yi.l.liu@intel.com,
 quintela@redhat.com, ziye.yang@intel.com, armbru@redhat.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, felipe@nutanix.com,
 zhi.a.wang@intel.com, kevin.tian@intel.com, yan.y.zhao@intel.com,
 alex.williamson@redhat.com, changpeng.liu@intel.com, eskultet@redhat.com,
 Ken.Xue@amd.com, jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Cornelia Huck (cohuck@redhat.com) wrote:
> On Sun, 21 Jun 2020 01:51:21 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
> > Call VFIO_IOMMU_DIRTY_PAGES ioctl to start and stop dirty pages tracking
> > for VFIO devices.
> > 
> > Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  hw/vfio/migration.c | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> > 
> > diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> > index faacea5327cb..e0fbb3a01855 100644
> > --- a/hw/vfio/migration.c
> > +++ b/hw/vfio/migration.c
> > @@ -11,6 +11,7 @@
> >  #include "qemu/main-loop.h"
> >  #include "qemu/cutils.h"
> >  #include <linux/vfio.h>
> > +#include <sys/ioctl.h>
> >  
> >  #include "sysemu/runstate.h"
> >  #include "hw/vfio/vfio-common.h"
> > @@ -329,6 +330,32 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
> >      return qemu_file_get_error(f);
> >  }
> >  
> > +static int vfio_start_dirty_page_tracking(VFIODevice *vbasedev, bool start)
> 
> I find 'start' functions that may also stop something a bit confusing.
> Maybe vfio_toggle_dirty_page_tracking()?

I don't think toggle is any better; I always think of toggle as flipping
the state to the other state.
vfio_set_dirty_page_tracking maybe?

Dave


> > +{
> > +    int ret;
> > +    VFIOContainer *container = vbasedev->group->container;
> > +    struct vfio_iommu_type1_dirty_bitmap dirty = {
> > +        .argsz = sizeof(dirty),
> > +    };
> > +
> > +    if (start) {
> > +        if (vbasedev->device_state & VFIO_DEVICE_STATE_SAVING) {
> > +            dirty.flags = VFIO_IOMMU_DIRTY_PAGES_FLAG_START;
> > +        } else {
> > +            return -EINVAL;
> > +        }
> > +    } else {
> > +            dirty.flags = VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP;
> > +    }
> > +
> > +    ret = ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, &dirty);
> > +    if (ret) {
> > +        error_report("Failed to set dirty tracking flag 0x%x errno: %d",
> > +                     dirty.flags, errno);
> > +    }
> > +    return ret;
> > +}
> > +
> >  /* ---------------------------------------------------------------------- */
> >  
> >  static int vfio_save_setup(QEMUFile *f, void *opaque)
> > @@ -360,6 +387,11 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
> >          return ret;
> >      }
> >  
> > +    ret = vfio_start_dirty_page_tracking(vbasedev, true);
> > +    if (ret) {
> > +        return ret;
> > +    }
> > +
> >      qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> >  
> >      ret = qemu_file_get_error(f);
> > @@ -375,6 +407,8 @@ static void vfio_save_cleanup(void *opaque)
> >      VFIODevice *vbasedev = opaque;
> >      VFIOMigration *migration = vbasedev->migration;
> >  
> > +    vfio_start_dirty_page_tracking(vbasedev, false);
> 
> I suppose we can't do anything useful if stopping dirty page tracking
> fails?
> 
> > +
> >      if (migration->region.mmaps) {
> >          vfio_region_unmap(&migration->region);
> >      }
> > @@ -706,6 +740,8 @@ static void vfio_migration_state_notifier(Notifier *notifier, void *data)
> >          if (ret) {
> >              error_report("%s: Failed to set state RUNNING", vbasedev->name);
> >          }
> > +
> > +        vfio_start_dirty_page_tracking(vbasedev, false);
> >      }
> >  }
> >  
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


