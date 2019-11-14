Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24D3C43215
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 05:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D10FE206EC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 05:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iqhe66ag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10FE206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV7I8-00055n-Qo
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 00:03:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iV7Gg-0003pD-4P
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 00:02:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iV7Gc-0000y3-72
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 00:02:04 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40487
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iV7Ga-0000v2-5j
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 00:02:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573707718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VShQW+zALQXIFnRLNjixGCOOm63WLxLXx+p8o1EESqA=;
 b=Iqhe66agenvSa5lj1DmjX8fbv3Xbt8Vr7jee665wCcKKjOGbeS+lI4lzrz6czQPOq6Ns1t
 ueIK9pb/UbJmhPv6+mXRukrKPxcmGsLCCUgdx61Q+GJbfJyiuXCbRPc6McLHK0eDxxg98G
 2ggSLa4Ara6mOD1tAyjH9acvuvnCoyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-EGjIq5sWPZu0d7jkdZ63pQ-1; Thu, 14 Nov 2019 00:01:55 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B36DDB20;
 Thu, 14 Nov 2019 05:01:53 +0000 (UTC)
Received: from x1.home (ovpn-116-138.phx2.redhat.com [10.3.116.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE28010C850A;
 Thu, 14 Nov 2019 05:01:51 +0000 (UTC)
Date: Wed, 13 Nov 2019 22:01:51 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v9 QEMU 07/15] vfio: Add migration region initialization
 and finalize function
Message-ID: <20191113220151.53bd303c@x1.home>
In-Reply-To: <1573578324-8389-8-git-send-email-kwankhede@nvidia.com>
References: <1573578324-8389-1-git-send-email-kwankhede@nvidia.com>
 <1573578324-8389-8-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: EGjIq5sWPZu0d7jkdZ63pQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

On Tue, 12 Nov 2019 22:35:16 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> - Migration functions are implemented for VFIO_DEVICE_TYPE_PCI device in =
this
>   patch series.
> - VFIO device supports migration or not is decided based of migration reg=
ion
>   query. If migration region query is successful and migration region
>   initialization is successful then migration is supported else migration=
 is
>   blocked.
>=20
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/Makefile.objs         |   2 +-
>  hw/vfio/migration.c           | 137 ++++++++++++++++++++++++++++++++++++=
++++++
>  hw/vfio/trace-events          |   3 +
>  include/hw/vfio/vfio-common.h |  10 +++
>  4 files changed, 151 insertions(+), 1 deletion(-)
>  create mode 100644 hw/vfio/migration.c
>=20
> diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
> index abad8b818c9b..36033d1437c5 100644
> --- a/hw/vfio/Makefile.objs
> +++ b/hw/vfio/Makefile.objs
> @@ -1,4 +1,4 @@
> -obj-y +=3D common.o spapr.o
> +obj-y +=3D common.o spapr.o migration.o
>  obj-$(CONFIG_VFIO_PCI) +=3D pci.o pci-quirks.o display.o
>  obj-$(CONFIG_VFIO_CCW) +=3D ccw.o
>  obj-$(CONFIG_VFIO_PLATFORM) +=3D platform.o
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> new file mode 100644
> index 000000000000..c17bd1b0b934
> --- /dev/null
> +++ b/hw/vfio/migration.c
> @@ -0,0 +1,137 @@
> +/*
> + * Migration support for VFIO devices
> + *
> + * Copyright NVIDIA, Inc. 2019
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2. See
> + * the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include <linux/vfio.h>
> +
> +#include "hw/vfio/vfio-common.h"
> +#include "cpu.h"
> +#include "migration/migration.h"
> +#include "migration/qemu-file.h"
> +#include "migration/register.h"
> +#include "migration/blocker.h"
> +#include "migration/misc.h"
> +#include "qapi/error.h"
> +#include "exec/ramlist.h"
> +#include "exec/ram_addr.h"
> +#include "pci.h"
> +#include "trace.h"
> +
> +static void vfio_migration_region_exit(VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration =3D vbasedev->migration;
> +
> +    if (!migration) {
> +        return;
> +    }
> +
> +    if (migration->region.size) {
> +        vfio_region_exit(&migration->region);
> +        vfio_region_finalize(&migration->region);
> +    }
> +}
> +
> +static int vfio_migration_region_init(VFIODevice *vbasedev, int index)
> +{
> +    VFIOMigration *migration =3D vbasedev->migration;
> +    Object *obj =3D NULL;
> +    int ret =3D -EINVAL;
> +
> +    if (!vbasedev->ops || !vbasedev->ops->vfio_get_object) {

Is it possible not to have vbasedev->ops?

> +        return ret;
> +    }
> +
> +    obj =3D vbasedev->ops->vfio_get_object(vbasedev);
> +    if (!obj) {
> +        return ret;
> +    }
> +
> +    ret =3D vfio_region_setup(obj, vbasedev, &migration->region, index,
> +                            "migration");
> +    if (ret) {
> +        error_report("%s: Failed to setup VFIO migration region %d: %s",
> +                     vbasedev->name, index, strerror(-ret));
> +        goto err;
> +    }
> +
> +    if (!migration->region.size) {
> +        ret =3D -EINVAL;
> +        error_report("%s: Invalid region size of VFIO migration region %=
d: %s",
> +                     vbasedev->name, index, strerror(-ret));
> +        goto err;
> +    }
> +
> +    return 0;
> +
> +err:
> +    vfio_migration_region_exit(vbasedev);
> +    return ret;
> +}
> +
> +static int vfio_migration_init(VFIODevice *vbasedev,
> +                               struct vfio_region_info *info)
> +{
> +    int ret;
> +
> +    vbasedev->migration =3D g_new0(VFIOMigration, 1);
> +
> +    ret =3D vfio_migration_region_init(vbasedev, info->index);
> +    if (ret) {
> +        error_report("%s: Failed to initialise migration region",
> +                     vbasedev->name);
> +        g_free(vbasedev->migration);

Note that vbasedev->migration is not NULL, so calling
vfio_migration_region_exit() at this point will be a use-after-free
error.

> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
> +/* ---------------------------------------------------------------------=
- */
> +
> +int vfio_migration_probe(VFIODevice *vbasedev, Error **errp)
> +{
> +    struct vfio_region_info *info;
> +    Error *local_err =3D NULL;
> +    int ret;
> +
> +    ret =3D vfio_get_dev_region_info(vbasedev, VFIO_REGION_TYPE_MIGRATIO=
N,
> +                                   VFIO_REGION_SUBTYPE_MIGRATION, &info)=
;
> +    if (ret) {
> +        goto add_blocker;
> +    }
> +
> +    ret =3D vfio_migration_init(vbasedev, info);
> +    if (ret) {
> +        goto add_blocker;
> +    }
> +
> +    trace_vfio_migration_probe(vbasedev->name, info->index);
> +    return 0;
> +
> +add_blocker:
> +    error_setg(&vbasedev->migration_blocker,
> +               "VFIO device doesn't support migration");
> +    ret =3D migrate_add_blocker(vbasedev->migration_blocker, &local_err)=
;
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        error_free(vbasedev->migration_blocker);
> +    }

This won't get along well with the failover code that's in QEMU master.

> +    return ret;
> +}
> +
> +void vfio_migration_finalize(VFIODevice *vbasedev)
> +{
> +    if (vbasedev->migration_blocker) {
> +        migrate_del_blocker(vbasedev->migration_blocker);
> +        error_free(vbasedev->migration_blocker);
> +    }
> +
> +    vfio_migration_region_exit(vbasedev);
> +    g_free(vbasedev->migration);

This will do bad things if vfio_migration_init() failed as indicated
above.

> +}
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 8cdc27946cb8..191a726a1312 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -143,3 +143,6 @@ vfio_display_edid_link_up(void) ""
>  vfio_display_edid_link_down(void) ""
>  vfio_display_edid_update(uint32_t prefx, uint32_t prefy) "%ux%u"
>  vfio_display_edid_write_error(void) ""
> +
> +# migration.c
> +vfio_migration_probe(char *name, uint32_t index) " (%s) Region %d"
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.=
h
> index d69a7f3ae31e..927511897a44 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -57,6 +57,11 @@ typedef struct VFIORegion {
>      uint8_t nr; /* cache the region number for debug */
>  } VFIORegion;
> =20
> +typedef struct VFIOMigration {
> +    VFIORegion region;
> +    uint64_t pending_bytes;

pending_bytes is not used here, let's add it when it's needed.

> +} VFIOMigration;
> +
>  typedef struct VFIOAddressSpace {
>      AddressSpace *as;
>      QLIST_HEAD(, VFIOContainer) containers;
> @@ -113,6 +118,8 @@ typedef struct VFIODevice {
>      unsigned int num_irqs;
>      unsigned int num_regions;
>      unsigned int flags;
> +    VFIOMigration *migration;
> +    Error *migration_blocker;

See:

f045a0104c8c ("vfio: unplug failover primary device before migration")

Edit: I see once I got to the last patch how you managed this.

>  } VFIODevice;
> =20
>  struct VFIODeviceOps {
> @@ -204,4 +211,7 @@ int vfio_spapr_create_window(VFIOContainer *container=
,
>  int vfio_spapr_remove_window(VFIOContainer *container,
>                               hwaddr offset_within_address_space);
> =20
> +int vfio_migration_probe(VFIODevice *vbasedev, Error **errp);
> +void vfio_migration_finalize(VFIODevice *vbasedev);
> +
>  #endif /* HW_VFIO_VFIO_COMMON_H */


