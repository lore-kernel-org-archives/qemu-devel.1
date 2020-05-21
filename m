Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0655AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 10:01:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2FCE204EC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 10:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UW5rLmJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2FCE204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbi0p-0002jU-TP
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 06:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jbhzm-0001TZ-IN
 for qemu-devel@nongnu.org; Thu, 21 May 2020 06:00:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48881
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jbhzk-0006Fc-J2
 for qemu-devel@nongnu.org; Thu, 21 May 2020 06:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590055207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rQ81zNywt4/Oct2UArgv0Iee/ZzmhtMaUc/e+OXg5ZE=;
 b=UW5rLmJqBlGbIEiQUX/PaMFym3mFsw8TEde/PCMwa0zJ/lkZBJie0Dmirryd+1krV1cL6x
 3EdAatk+TbUI4AGhAt8FHVXpYF2wWpThKI4JBCQ36fpekS2espy0CQZF1/I0Jl073NLkq0
 +PsqzSlU4LeCatlXkHB8YXLgHKIJaR8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-6lez57f5Op6GVguaGG7_hA-1; Thu, 21 May 2020 06:00:03 -0400
X-MC-Unique: 6lez57f5Op6GVguaGG7_hA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 158318014D4;
 Thu, 21 May 2020 10:00:01 +0000 (UTC)
Received: from work-vm (ovpn-113-115.ams2.redhat.com [10.36.113.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E0B5912A4D;
 Thu, 21 May 2020 09:59:50 +0000 (UTC)
Date: Thu, 21 May 2020 10:59:48 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH QEMU v23 05/18] vfio: Add migration region initialization
 and finalize function
Message-ID: <20200521095948.GC2752@work-vm>
References: <1589999088-31477-1-git-send-email-kwankhede@nvidia.com>
 <1589999088-31477-6-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <1589999088-31477-6-git-send-email-kwankhede@nvidia.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
> - Migration functions are implemented for VFIO_DEVICE_TYPE_PCI device in this
>   patch series.
> - VFIO device supports migration or not is decided based of migration region
>   query. If migration region query is successful and migration region
>   initialization is successful then migration is supported else migration is
>   blocked.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>

For migration:


Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hw/vfio/Makefile.objs         |   2 +-
>  hw/vfio/migration.c           | 138 ++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/trace-events          |   3 +
>  include/hw/vfio/vfio-common.h |   9 +++
>  4 files changed, 151 insertions(+), 1 deletion(-)
>  create mode 100644 hw/vfio/migration.c
> 
> diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
> index 9bb1c09e8477..8b296c889ed9 100644
> --- a/hw/vfio/Makefile.objs
> +++ b/hw/vfio/Makefile.objs
> @@ -1,4 +1,4 @@
> -obj-y += common.o spapr.o
> +obj-y += common.o spapr.o migration.o
>  obj-$(CONFIG_VFIO_PCI) += pci.o pci-quirks.o display.o
>  obj-$(CONFIG_VFIO_CCW) += ccw.o
>  obj-$(CONFIG_VFIO_PLATFORM) += platform.o
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> new file mode 100644
> index 000000000000..bf9384907ec0
> --- /dev/null
> +++ b/hw/vfio/migration.c
> @@ -0,0 +1,138 @@
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
> +    int ret = -EINVAL;
> +
> +    if (!vbasedev->ops->vfio_get_object) {
> +        return ret;
> +    }
> +
> +    obj = vbasedev->ops->vfio_get_object(vbasedev);
> +    if (!obj) {
> +        return ret;
> +    }
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
> +    vbasedev->migration = g_new0(VFIOMigration, 1);
> +
> +    ret = vfio_migration_region_init(vbasedev, info->index);
> +    if (ret) {
> +        error_report("%s: Failed to initialise migration region",
> +                     vbasedev->name);
> +        g_free(vbasedev->migration);
> +        vbasedev->migration = NULL;
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
> +/* ---------------------------------------------------------------------- */
> +
> +int vfio_migration_probe(VFIODevice *vbasedev, Error **errp)
> +{
> +    struct vfio_region_info *info;
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
> +    trace_vfio_migration_probe(vbasedev->name, info->index);
> +    return 0;
> +
> +add_blocker:
> +    error_setg(&vbasedev->migration_blocker,
> +               "VFIO device doesn't support migration");
> +    ret = migrate_add_blocker(vbasedev->migration_blocker, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        error_free(vbasedev->migration_blocker);
> +    }
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
> +}
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 8cdc27946cb8..fd034ac53684 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -143,3 +143,6 @@ vfio_display_edid_link_up(void) ""
>  vfio_display_edid_link_down(void) ""
>  vfio_display_edid_update(uint32_t prefx, uint32_t prefy) "%ux%u"
>  vfio_display_edid_write_error(void) ""
> +
> +# migration.c
> +vfio_migration_probe(const char *name, uint32_t index) " (%s) Region %d"
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index d69a7f3ae31e..d4b268641173 100644
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
> -- 
> 2.7.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


