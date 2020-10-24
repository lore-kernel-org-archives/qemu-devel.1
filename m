Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F64C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 14:23:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BA1821D41
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 14:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FxDKyfbR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA1821D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWKRp-000415-Vg
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 10:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kWKQ0-00035w-B8
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 10:21:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24797)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kWKPw-0003JA-6H
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 10:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603549270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mqYG3wPXi5NiB6CVzTDNiUCcfLAVyZzhOV3QzMO/7cg=;
 b=FxDKyfbRnAVNMmI+p+vcUfpq4SaMqODjS+aIxngquf+hx/T6IzAn1pf/K/ITBdwS/Woqt/
 qJB0HSnp4y/VplG8913PmZxa99TOoUPtaqeZa04S9cFrAheY3iteEJwVYVvQoDDStql03p
 sPopd1X7dYtlAKelgZu/YiGwlqf4HaU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-vLr8mmqqOjCBFlhQG99M5Q-1; Sat, 24 Oct 2020 10:21:08 -0400
X-MC-Unique: vLr8mmqqOjCBFlhQG99M5Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3BD2190A3E0;
 Sat, 24 Oct 2020 14:21:05 +0000 (UTC)
Received: from x1.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 833DA5B4AC;
 Sat, 24 Oct 2020 14:21:00 +0000 (UTC)
Date: Sat, 24 Oct 2020 08:21:00 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v28 04/17] vfio: Add migration region initialization and
 finalize function
Message-ID: <20201024082100.216d9c29@x1.home>
In-Reply-To: <a91fee75-393b-d6ba-00d6-d6da58ec5f5f@nvidia.com>
References: <1603449643-12851-1-git-send-email-kwankhede@nvidia.com>
 <1603449643-12851-5-git-send-email-kwankhede@nvidia.com>
 <20201023105236.4e9ae566@w520.home>
 <a91fee75-393b-d6ba-00d6-d6da58ec5f5f@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 08:04:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: cohuck@redhat.com, cjia@nvidia.com, zhi.wang.linux@gmail.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com, artemp@nvidia.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, mcrossley@nvidia.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com, dgilbert@redhat.com,
 changpeng.liu@intel.com, eskultet@redhat.com, Ken.Xue@amd.com,
 jonathan.davies@nutanix.com, pbonzini@redhat.com, dnigam@nvidia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 24 Oct 2020 15:09:14 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 10/23/2020 10:22 PM, Alex Williamson wrote:
> > On Fri, 23 Oct 2020 16:10:30 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
> >> Whether the VFIO device supports migration or not is decided based of
> >> migration region query. If migration region query is successful and migration
> >> region initialization is successful then migration is supported else
> >> migration is blocked.
> >>
> >> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> >> Reviewed-by: Neo Jia <cjia@nvidia.com>
> >> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >> ---
> >>   hw/vfio/meson.build           |   1 +
> >>   hw/vfio/migration.c           | 133 ++++++++++++++++++++++++++++++++++++++++++
> >>   hw/vfio/trace-events          |   3 +
> >>   include/hw/vfio/vfio-common.h |   9 +++
> >>   4 files changed, 146 insertions(+)
> >>   create mode 100644 hw/vfio/migration.c
> >>
> >> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> >> index 37efa74018bc..da9af297a0c5 100644
> >> --- a/hw/vfio/meson.build
> >> +++ b/hw/vfio/meson.build
> >> @@ -2,6 +2,7 @@ vfio_ss = ss.source_set()
> >>   vfio_ss.add(files(
> >>     'common.c',
> >>     'spapr.c',
> >> +  'migration.c',
> >>   ))
> >>   vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
> >>     'display.c',
> >> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> >> new file mode 100644
> >> index 000000000000..bbe6e0b7a6cc
> >> --- /dev/null
> >> +++ b/hw/vfio/migration.c
> >> @@ -0,0 +1,133 @@
> >> +/*
> >> + * Migration support for VFIO devices
> >> + *
> >> + * Copyright NVIDIA, Inc. 2020
> >> + *
> >> + * This work is licensed under the terms of the GNU GPL, version 2. See
> >> + * the COPYING file in the top-level directory.
> >> + */
> >> +
> >> +#include "qemu/osdep.h"
> >> +#include <linux/vfio.h>
> >> +
> >> +#include "hw/vfio/vfio-common.h"
> >> +#include "cpu.h"
> >> +#include "migration/migration.h"
> >> +#include "migration/qemu-file.h"
> >> +#include "migration/register.h"
> >> +#include "migration/blocker.h"
> >> +#include "migration/misc.h"
> >> +#include "qapi/error.h"
> >> +#include "exec/ramlist.h"
> >> +#include "exec/ram_addr.h"
> >> +#include "pci.h"
> >> +#include "trace.h"
> >> +
> >> +static void vfio_migration_region_exit(VFIODevice *vbasedev)
> >> +{
> >> +    VFIOMigration *migration = vbasedev->migration;
> >> +
> >> +    if (!migration) {
> >> +        return;
> >> +    }
> >> +
> >> +    vfio_region_exit(&migration->region);
> >> +    vfio_region_finalize(&migration->region);  
> > 
> > I think it would make sense to also:
> > 
> > g_free(migration);
> > vbasedev->migration = NULL;
> > 
> > here as well so the callers don't need to.   
> 
> No, vfio_migration_init() case, err case is also hit when 
> vbasedev->migration is not yet set but local variable migration is not-NULL.

So why do we even call vfio_migration_region_exit() for that error
case?  It seems that could just g_free(migration); return ret; rather
than goto err.  Thanks,

Alex

> > Not worth a re-spin itself,
> > maybe a follow-up if there's no other reason for a re-spin.  Thanks,
> > 
> > Alex
> >   
> >> +}
> >> +
> >> +static int vfio_migration_init(VFIODevice *vbasedev,
> >> +                               struct vfio_region_info *info)
> >> +{
> >> +    int ret;
> >> +    Object *obj;
> >> +    VFIOMigration *migration;
> >> +
> >> +    if (!vbasedev->ops->vfio_get_object) {
> >> +        return -EINVAL;
> >> +    }
> >> +
> >> +    obj = vbasedev->ops->vfio_get_object(vbasedev);
> >> +    if (!obj) {
> >> +        return -EINVAL;
> >> +    }
> >> +
> >> +    migration = g_new0(VFIOMigration, 1);
> >> +
> >> +    ret = vfio_region_setup(obj, vbasedev, &migration->region,
> >> +                            info->index, "migration");
> >> +    if (ret) {
> >> +        error_report("%s: Failed to setup VFIO migration region %d: %s",
> >> +                     vbasedev->name, info->index, strerror(-ret));
> >> +        goto err;
> >> +    }
> >> +
> >> +    vbasedev->migration = migration;
> >> +
> >> +    if (!migration->region.size) {
> >> +        error_report("%s: Invalid zero-sized of VFIO migration region %d",
> >> +                     vbasedev->name, info->index);
> >> +        ret = -EINVAL;
> >> +        goto err;
> >> +    }
> >> +    return 0;
> >> +
> >> +err:
> >> +    vfio_migration_region_exit(vbasedev);
> >> +    g_free(migration);
> >> +    vbasedev->migration = NULL;
> >> +    return ret;
> >> +}
> >> +
> >> +/* ---------------------------------------------------------------------- */
> >> +
> >> +int vfio_migration_probe(VFIODevice *vbasedev, Error **errp)
> >> +{
> >> +    struct vfio_region_info *info = NULL;
> >> +    Error *local_err = NULL;
> >> +    int ret;
> >> +
> >> +    ret = vfio_get_dev_region_info(vbasedev, VFIO_REGION_TYPE_MIGRATION,
> >> +                                   VFIO_REGION_SUBTYPE_MIGRATION, &info);
> >> +    if (ret) {
> >> +        goto add_blocker;
> >> +    }
> >> +
> >> +    ret = vfio_migration_init(vbasedev, info);
> >> +    if (ret) {
> >> +        goto add_blocker;
> >> +    }
> >> +
> >> +    g_free(info);
> >> +    trace_vfio_migration_probe(vbasedev->name, info->index);
> >> +    return 0;
> >> +
> >> +add_blocker:
> >> +    error_setg(&vbasedev->migration_blocker,
> >> +               "VFIO device doesn't support migration");
> >> +    g_free(info);
> >> +
> >> +    ret = migrate_add_blocker(vbasedev->migration_blocker, &local_err);
> >> +    if (local_err) {
> >> +        error_propagate(errp, local_err);
> >> +        error_free(vbasedev->migration_blocker);
> >> +        vbasedev->migration_blocker = NULL;
> >> +    }
> >> +    return ret;
> >> +}
> >> +
> >> +void vfio_migration_finalize(VFIODevice *vbasedev)
> >> +{
> >> +    VFIOMigration *migration = vbasedev->migration;
> >> +
> >> +    if (migration) {
> >> +        vfio_migration_region_exit(vbasedev);
> >> +        g_free(vbasedev->migration);
> >> +        vbasedev->migration = NULL;
> >> +    }
> >> +
> >> +    if (vbasedev->migration_blocker) {
> >> +        migrate_del_blocker(vbasedev->migration_blocker);
> >> +        error_free(vbasedev->migration_blocker);
> >> +        vbasedev->migration_blocker = NULL;
> >> +    }
> >> +}
> >> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> >> index a0c7b49a2ebc..9ced5ec6277c 100644
> >> --- a/hw/vfio/trace-events
> >> +++ b/hw/vfio/trace-events
> >> @@ -145,3 +145,6 @@ vfio_display_edid_link_up(void) ""
> >>   vfio_display_edid_link_down(void) ""
> >>   vfio_display_edid_update(uint32_t prefx, uint32_t prefy) "%ux%u"
> >>   vfio_display_edid_write_error(void) ""
> >> +
> >> +# migration.c
> >> +vfio_migration_probe(const char *name, uint32_t index) " (%s) Region %d"
> >> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> >> index ba6169cd926e..8275c4c68f45 100644
> >> --- a/include/hw/vfio/vfio-common.h
> >> +++ b/include/hw/vfio/vfio-common.h
> >> @@ -57,6 +57,10 @@ typedef struct VFIORegion {
> >>       uint8_t nr; /* cache the region number for debug */
> >>   } VFIORegion;
> >>   
> >> +typedef struct VFIOMigration {
> >> +    VFIORegion region;
> >> +} VFIOMigration;
> >> +
> >>   typedef struct VFIOAddressSpace {
> >>       AddressSpace *as;
> >>       QLIST_HEAD(, VFIOContainer) containers;
> >> @@ -113,6 +117,8 @@ typedef struct VFIODevice {
> >>       unsigned int num_irqs;
> >>       unsigned int num_regions;
> >>       unsigned int flags;
> >> +    VFIOMigration *migration;
> >> +    Error *migration_blocker;
> >>   } VFIODevice;
> >>   
> >>   struct VFIODeviceOps {
> >> @@ -204,4 +210,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
> >>   int vfio_spapr_remove_window(VFIOContainer *container,
> >>                                hwaddr offset_within_address_space);
> >>   
> >> +int vfio_migration_probe(VFIODevice *vbasedev, Error **errp);
> >> +void vfio_migration_finalize(VFIODevice *vbasedev);
> >> +
> >>   #endif /* HW_VFIO_VFIO_COMMON_H */  
> >   
> 


