Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B779C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 19:05:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55978206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 19:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQP/HiUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55978206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJigK-0005My-Iz
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 15:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jJieu-0004Qy-2n
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 15:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jJies-00080t-O0
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 15:04:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50224
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jJies-0007zr-Gj
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 15:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585767852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ytEy5RAtBr97Twvq51ned4JCdEl6/zuea6KzjsLLX2Y=;
 b=gQP/HiUvoI2WZBKnOV0YHVgaODu5uM8gfz8xu+U67gwnGBqEZJRZJvQ45o77zeQqJ61lMT
 fbTnPE9PzLhP1jcw+TtZn8vZ24dg5eZKpgs7qhsOSC0tRa0YzP649ZpVW7LBJ+YrwF8BNg
 CgWL+ioTyERsZWtqnWnpQpP2dLCtuno=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-a8O7xapIPUKg7MXBnWFZYg-1; Wed, 01 Apr 2020 15:04:10 -0400
X-MC-Unique: a8O7xapIPUKg7MXBnWFZYg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C0EC13F6;
 Wed,  1 Apr 2020 19:04:06 +0000 (UTC)
Received: from work-vm (ovpn-115-201.ams2.redhat.com [10.36.115.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B41F60BEC;
 Wed,  1 Apr 2020 19:03:59 +0000 (UTC)
Date: Wed, 1 Apr 2020 20:03:56 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v16 QEMU 13/16] vfio: Add function to start and stop
 dirty pages tracking
Message-ID: <20200401190356.GJ52559@work-vm>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
 <1585084154-29461-14-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <1585084154-29461-14-git-send-email-kwankhede@nvidia.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Zhengxiao.zx@alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, eskultet@redhat.com, ziye.yang@intel.com, cohuck@redhat.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, zhi.a.wang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 alex.williamson@redhat.com, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Kirti Wankhede (kwankhede@nvidia.com) wrote:
> Call VFIO_IOMMU_DIRTY_PAGES ioctl to start and stop dirty pages tracking
> for VFIO devices.
>=20
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> ---
>  hw/vfio/migration.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>=20
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index ab295d25620e..1827b7cfb316 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -9,6 +9,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "qemu/main-loop.h"
> +#include <sys/ioctl.h>
>  #include <linux/vfio.h>
> =20
>  #include "sysemu/runstate.h"
> @@ -296,6 +297,32 @@ static int vfio_load_device_config_state(QEMUFile *f=
, void *opaque)
>      return qemu_file_get_error(f);
>  }
> =20
> +static int vfio_start_dirty_page_tracking(VFIODevice *vbasedev, bool sta=
rt)
> +{
> +    int ret;
> +    VFIOContainer *container =3D vbasedev->group->container;
> +    struct vfio_iommu_type1_dirty_bitmap dirty =3D {
> +        .argsz =3D sizeof(dirty),
> +    };
> +
> +    if (start) {
> +        if (vbasedev->device_state & VFIO_DEVICE_STATE_SAVING) {
> +            dirty.flags =3D VFIO_IOMMU_DIRTY_PAGES_FLAG_START;
> +        } else {
> +            return 0;
> +        }
> +    } else {
> +            dirty.flags =3D VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP;
> +    }
> +
> +    ret =3D ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, &dirty);
> +    if (ret) {
> +        error_report("Failed to set dirty tracking flag 0x%x errno: %d",
> +                     dirty.flags, errno);
> +    }
> +    return ret;
> +}
> +
>  /* ---------------------------------------------------------------------=
- */
> =20
>  static int vfio_save_setup(QEMUFile *f, void *opaque)
> @@ -330,6 +357,11 @@ static int vfio_save_setup(QEMUFile *f, void *opaque=
)
>       */
>      qemu_put_be64(f, migration->region.size);
> =20
> +    ret =3D vfio_start_dirty_page_tracking(vbasedev, true);
> +    if (ret) {
> +        return ret;
> +    }
> +
>      qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> =20
>      ret =3D qemu_file_get_error(f);
> @@ -346,6 +378,8 @@ static void vfio_save_cleanup(void *opaque)
>      VFIODevice *vbasedev =3D opaque;
>      VFIOMigration *migration =3D vbasedev->migration;
> =20
> +    vfio_start_dirty_page_tracking(vbasedev, false);

Shouldn't you check the return value?

> +
>      if (migration->region.mmaps) {
>          vfio_region_unmap(&migration->region);
>      }
> @@ -669,6 +703,8 @@ static void vfio_migration_state_notifier(Notifier *n=
otifier, void *data)
>          if (ret) {
>              error_report("%s: Failed to set state RUNNING", vbasedev->na=
me);
>          }
> +
> +        vfio_start_dirty_page_tracking(vbasedev, false);
>      }
>  }
> =20
> --=20
> 2.7.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


