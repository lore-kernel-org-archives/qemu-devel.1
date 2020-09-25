Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAF3C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 20:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 886D52086A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 20:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGYCLhhA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886D52086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLuDG-0006TX-Ez
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 16:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kLuCc-000609-Mz
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 16:20:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kLuCY-0002x1-KQ
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 16:20:22 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601065217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rR8WIzGT9jpJ/OKoavzZDGnnClrNdG6fQCBNI6kIUaA=;
 b=DGYCLhhAV5h5EMzFO6INLOZfCFibftL8CL5QH1MTcEfnSzOPI2I3Lq2HLMFA4uQzSZN11s
 /thgc1/p8HwioWJQIYVQu8DcRPXz8908KRMpcvcw3QGfcjLq+kvoWh2uQ8h8RzztmQbKY9
 5kHQxjV11HgDSqQUboR0f7TJliKHC3w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-VSKOxM2iOY-HWuilGktaGQ-1; Fri, 25 Sep 2020 16:20:15 -0400
X-MC-Unique: VSKOxM2iOY-HWuilGktaGQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A87AD18CBC4C;
 Fri, 25 Sep 2020 20:20:12 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4375027CDD;
 Fri, 25 Sep 2020 20:20:07 +0000 (UTC)
Date: Fri, 25 Sep 2020 14:20:06 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v26 04/17] vfio: Add migration region initialization and
 finalize function
Message-ID: <20200925142006.2b62f856@x1.home>
In-Reply-To: <1600817059-26721-5-git-send-email-kwankhede@nvidia.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-5-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
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

On Wed, 23 Sep 2020 04:54:06 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> Whether the VFIO device supports migration or not is decided based of
> migration region query. If migration region query is successful and migration
> region initialization is successful then migration is supported else
> migration is blocked.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/vfio/meson.build           |   1 +
>  hw/vfio/migration.c           | 142 ++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/trace-events          |   5 ++
>  include/hw/vfio/vfio-common.h |   9 +++
>  4 files changed, 157 insertions(+)
>  create mode 100644 hw/vfio/migration.c
> 
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index 37efa74018bc..da9af297a0c5 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -2,6 +2,7 @@ vfio_ss = ss.source_set()
>  vfio_ss.add(files(
>    'common.c',
>    'spapr.c',
> +  'migration.c',
>  ))
>  vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
>    'display.c',
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> new file mode 100644
> index 000000000000..2f760f1f9c47
> --- /dev/null
> +++ b/hw/vfio/migration.c
> @@ -0,0 +1,142 @@
> +/*
> + * Migration support for VFIO devices
> + *
> + * Copyright NVIDIA, Inc. 2020
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
> +    VFIOMigration *migration = vbasedev->migration;
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
> +    VFIOMigration *migration = vbasedev->migration;
> +    Object *obj = NULL;

Unnecessary initialization.

> +    int ret = -EINVAL;

return -EINVAL below, this doesn't need to be initialized, use it for
storing actual return values.

> +
> +    obj = vbasedev->ops->vfio_get_object(vbasedev);
> +    if (!obj) {
> +        return ret;
> +    }

vfio_migration_init() tests whether the vbasedev->ops supports
vfio_get_object, then calls this, then calls vfio_get_object itself
(added in a later patch, with a strange inconsistency in failure modes).
Wouldn't it make more sense for vfio_migration_init() to pass the
Object since that function also needs it (eventually) and actually does
the existence test?

> +
> +    ret = vfio_region_setup(obj, vbasedev, &migration->region, index,
> +                            "migration");
> +    if (ret) {
> +        error_report("%s: Failed to setup VFIO migration region %d: %s",
> +                     vbasedev->name, index, strerror(-ret));
> +        goto err;
> +    }
> +
> +    if (!migration->region.size) {
> +        ret = -EINVAL;
> +        error_report("%s: Invalid region size of VFIO migration region %d: %s",
> +                     vbasedev->name, index, strerror(-ret));
> +        goto err;
> +    }

If the caller were to pass obj, this is nothing more than a wrapper for
calling vfio_region_setup(), which suggests to me we might not even
need this as a separate function outside of vfio_migration_init().

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
> +    int ret = -EINVAL;
> +
> +    if (!vbasedev->ops->vfio_get_object) {
> +        return ret;
> +    }
> +
> +    vbasedev->migration = g_new0(VFIOMigration, 1);
> +
> +    ret = vfio_migration_region_init(vbasedev, info->index);
> +    if (ret) {
> +        error_report("%s: Failed to initialise migration region",
> +                     vbasedev->name);
> +        g_free(vbasedev->migration);
> +        vbasedev->migration = NULL;
> +    }
> +
> +    return ret;
> +}
> +
> +/* ---------------------------------------------------------------------- */
> +
> +int vfio_migration_probe(VFIODevice *vbasedev, Error **errp)
> +{
> +    struct vfio_region_info *info = NULL;

Not sure this initialization is strictly necessary either, but it also
seems to be a common convention for this function, so either way.

Connie, does vfio_ccw_get_region() leak this?  It appears to call
vfio_get_dev_region_info() and vfio_get_region_info() several times with
the same pointer without freeing it between uses.

Thanks,
Alex

> +    Error *local_err = NULL;
> +    int ret;
> +
> +    ret = vfio_get_dev_region_info(vbasedev, VFIO_REGION_TYPE_MIGRATION,
> +                                   VFIO_REGION_SUBTYPE_MIGRATION, &info);
> +    if (ret) {
> +        goto add_blocker;
> +    }
> +
> +    ret = vfio_migration_init(vbasedev, info);
> +    if (ret) {
> +        goto add_blocker;
> +    }
> +
> +    g_free(info);
> +    trace_vfio_migration_probe(vbasedev->name, info->index);
> +    return 0;
> +
> +add_blocker:
> +    error_setg(&vbasedev->migration_blocker,
> +               "VFIO device doesn't support migration");
> +    g_free(info);
> +
> +    ret = migrate_add_blocker(vbasedev->migration_blocker, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        error_free(vbasedev->migration_blocker);
> +        vbasedev->migration_blocker = NULL;
> +    }
> +    return ret;
> +}
> +
> +void vfio_migration_finalize(VFIODevice *vbasedev)
> +{
> +    if (vbasedev->migration_blocker) {
> +        migrate_del_blocker(vbasedev->migration_blocker);
> +        error_free(vbasedev->migration_blocker);
> +        vbasedev->migration_blocker = NULL;
> +    }
> +
> +    vfio_migration_region_exit(vbasedev);
> +    g_free(vbasedev->migration);
> +}
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index a0c7b49a2ebc..8fe913175d85 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -145,3 +145,8 @@ vfio_display_edid_link_up(void) ""
>  vfio_display_edid_link_down(void) ""
>  vfio_display_edid_update(uint32_t prefx, uint32_t prefy) "%ux%u"
>  vfio_display_edid_write_error(void) ""
> +
> +
> +# migration.c
> +vfio_migration_probe(const char *name, uint32_t index) " (%s) Region %d"
> +
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index ba6169cd926e..8275c4c68f45 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -57,6 +57,10 @@ typedef struct VFIORegion {
>      uint8_t nr; /* cache the region number for debug */
>  } VFIORegion;
>  
> +typedef struct VFIOMigration {
> +    VFIORegion region;
> +} VFIOMigration;
> +
>  typedef struct VFIOAddressSpace {
>      AddressSpace *as;
>      QLIST_HEAD(, VFIOContainer) containers;
> @@ -113,6 +117,8 @@ typedef struct VFIODevice {
>      unsigned int num_irqs;
>      unsigned int num_regions;
>      unsigned int flags;
> +    VFIOMigration *migration;
> +    Error *migration_blocker;
>  } VFIODevice;
>  
>  struct VFIODeviceOps {
> @@ -204,4 +210,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
>  int vfio_spapr_remove_window(VFIOContainer *container,
>                               hwaddr offset_within_address_space);
>  
> +int vfio_migration_probe(VFIODevice *vbasedev, Error **errp);
> +void vfio_migration_finalize(VFIODevice *vbasedev);
> +
>  #endif /* HW_VFIO_VFIO_COMMON_H */


