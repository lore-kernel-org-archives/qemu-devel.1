Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396B2C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 20:18:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A71620714
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 20:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Z3fom0ZX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A71620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTsf7-00043y-Ld
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 16:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kTse3-0003dJ-Gx
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 16:17:39 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kTse1-0002fp-2j
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 16:17:39 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f8b51040000>; Sat, 17 Oct 2020 13:16:04 -0700
Received: from [10.40.101.194] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 17 Oct
 2020 20:17:21 +0000
Subject: Re: [PATCH v26 04/17] vfio: Add migration region initialization and
 finalize function
To: Alex Williamson <alex.williamson@redhat.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-5-git-send-email-kwankhede@nvidia.com>
 <20200925142006.2b62f856@x1.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <f6f3cae9-fd18-a263-81d5-4ffa9181279b@nvidia.com>
Date: Sun, 18 Oct 2020 01:47:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200925142006.2b62f856@x1.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1602965764; bh=ced22nkDPiKDa5lGJvDum7ipsxIpxXQn8WDZf7kttXM=;
 h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
 b=Z3fom0ZXm+RIpjSmFSYhw4kb1Mjq/+4AVqTuJhkamdE8L3OsPwZEAyXdJbpdZagnC
 Ut0L/kNmo+GSSKgLOFly5vPwm4EvCNp9LxMo2QaUyQFMUglBuDickO+9R9LyYbkrlX
 cWexHyOwkoovACVPAUpKvAOYG8hiQQ18Au9gajeZIegrB2TUV9usJJWzbU2WCL4SUR
 oZYQw4ersUQk0e+LJgZh7uu3jXqYC26LPPuFz1BHBTjvsy0TeGtQ1ZSuwgY28E0JTB
 aQ241Yz4ucGn3ZVFOxKLd8wipADScRjpSPiicfdp7awFvOvqUc1AaqBh2sETivNa0W
 dtqWx53hIB9cg==
Received-SPF: pass client-ip=216.228.121.143;
 envelope-from=kwankhede@nvidia.com; helo=hqnvemgate24.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 16:17:35
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.247, RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 9/26/2020 1:50 AM, Alex Williamson wrote:
> On Wed, 23 Sep 2020 04:54:06 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> Whether the VFIO device supports migration or not is decided based of
>> migration region query. If migration region query is successful and migration
>> region initialization is successful then migration is supported else
>> migration is blocked.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>>   hw/vfio/meson.build           |   1 +
>>   hw/vfio/migration.c           | 142 ++++++++++++++++++++++++++++++++++++++++++
>>   hw/vfio/trace-events          |   5 ++
>>   include/hw/vfio/vfio-common.h |   9 +++
>>   4 files changed, 157 insertions(+)
>>   create mode 100644 hw/vfio/migration.c
>>
>> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
>> index 37efa74018bc..da9af297a0c5 100644
>> --- a/hw/vfio/meson.build
>> +++ b/hw/vfio/meson.build
>> @@ -2,6 +2,7 @@ vfio_ss = ss.source_set()
>>   vfio_ss.add(files(
>>     'common.c',
>>     'spapr.c',
>> +  'migration.c',
>>   ))
>>   vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
>>     'display.c',
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> new file mode 100644
>> index 000000000000..2f760f1f9c47
>> --- /dev/null
>> +++ b/hw/vfio/migration.c
>> @@ -0,0 +1,142 @@
>> +/*
>> + * Migration support for VFIO devices
>> + *
>> + * Copyright NVIDIA, Inc. 2020
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2. See
>> + * the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include <linux/vfio.h>
>> +
>> +#include "hw/vfio/vfio-common.h"
>> +#include "cpu.h"
>> +#include "migration/migration.h"
>> +#include "migration/qemu-file.h"
>> +#include "migration/register.h"
>> +#include "migration/blocker.h"
>> +#include "migration/misc.h"
>> +#include "qapi/error.h"
>> +#include "exec/ramlist.h"
>> +#include "exec/ram_addr.h"
>> +#include "pci.h"
>> +#include "trace.h"
>> +
>> +static void vfio_migration_region_exit(VFIODevice *vbasedev)
>> +{
>> +    VFIOMigration *migration = vbasedev->migration;
>> +
>> +    if (!migration) {
>> +        return;
>> +    }
>> +
>> +    if (migration->region.size) {
>> +        vfio_region_exit(&migration->region);
>> +        vfio_region_finalize(&migration->region);
>> +    }
>> +}
>> +
>> +static int vfio_migration_region_init(VFIODevice *vbasedev, int index)
>> +{
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    Object *obj = NULL;
> 
> Unnecessary initialization.
> 
>> +    int ret = -EINVAL;
> 
> return -EINVAL below, this doesn't need to be initialized, use it for
> storing actual return values.
> 
>> +
>> +    obj = vbasedev->ops->vfio_get_object(vbasedev);
>> +    if (!obj) {
>> +        return ret;
>> +    }
> 
> vfio_migration_init() tests whether the vbasedev->ops supports
> vfio_get_object, then calls this, then calls vfio_get_object itself
> (added in a later patch, with a strange inconsistency in failure modes).
> Wouldn't it make more sense for vfio_migration_init() to pass the
> Object since that function also needs it (eventually) and actually does
> the existence test?
> 
>> +
>> +    ret = vfio_region_setup(obj, vbasedev, &migration->region, index,
>> +                            "migration");
>> +    if (ret) {
>> +        error_report("%s: Failed to setup VFIO migration region %d: %s",
>> +                     vbasedev->name, index, strerror(-ret));
>> +        goto err;
>> +    }
>> +
>> +    if (!migration->region.size) {
>> +        ret = -EINVAL;
>> +        error_report("%s: Invalid region size of VFIO migration region %d: %s",
>> +                     vbasedev->name, index, strerror(-ret));
>> +        goto err;
>> +    }
> 
> If the caller were to pass obj, this is nothing more than a wrapper for
> calling vfio_region_setup(), which suggests to me we might not even
> need this as a separate function outside of vfio_migration_init().
> 

Removed vfio_migration_region_init(), moving vfio_region_setup() to
vfio_migration_init()

Thanks,
Kirti

>> +
>> +    return 0;
>> +
>> +err:
>> +    vfio_migration_region_exit(vbasedev);
>> +    return ret;
>> +}
>> +
>> +static int vfio_migration_init(VFIODevice *vbasedev,
>> +                               struct vfio_region_info *info)
>> +{
>> +    int ret = -EINVAL;
>> +
>> +    if (!vbasedev->ops->vfio_get_object) {
>> +        return ret;
>> +    }
>> +
>> +    vbasedev->migration = g_new0(VFIOMigration, 1);
>> +
>> +    ret = vfio_migration_region_init(vbasedev, info->index);
>> +    if (ret) {
>> +        error_report("%s: Failed to initialise migration region",
>> +                     vbasedev->name);
>> +        g_free(vbasedev->migration);
>> +        vbasedev->migration = NULL;
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +/* ---------------------------------------------------------------------- */
>> +
>> +int vfio_migration_probe(VFIODevice *vbasedev, Error **errp)
>> +{
>> +    struct vfio_region_info *info = NULL;
> 
> Not sure this initialization is strictly necessary either, but it also
> seems to be a common convention for this function, so either way.
> 
> Connie, does vfio_ccw_get_region() leak this?  It appears to call
> vfio_get_dev_region_info() and vfio_get_region_info() several times with
> the same pointer without freeing it between uses.
> 
> Thanks,
> Alex
> 
>> +    Error *local_err = NULL;
>> +    int ret;
>> +
>> +    ret = vfio_get_dev_region_info(vbasedev, VFIO_REGION_TYPE_MIGRATION,
>> +                                   VFIO_REGION_SUBTYPE_MIGRATION, &info);
>> +    if (ret) {
>> +        goto add_blocker;
>> +    }
>> +
>> +    ret = vfio_migration_init(vbasedev, info);
>> +    if (ret) {
>> +        goto add_blocker;
>> +    }
>> +
>> +    g_free(info);
>> +    trace_vfio_migration_probe(vbasedev->name, info->index);
>> +    return 0;
>> +
>> +add_blocker:
>> +    error_setg(&vbasedev->migration_blocker,
>> +               "VFIO device doesn't support migration");
>> +    g_free(info);
>> +
>> +    ret = migrate_add_blocker(vbasedev->migration_blocker, &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        error_free(vbasedev->migration_blocker);
>> +        vbasedev->migration_blocker = NULL;
>> +    }
>> +    return ret;
>> +}
>> +
>> +void vfio_migration_finalize(VFIODevice *vbasedev)
>> +{
>> +    if (vbasedev->migration_blocker) {
>> +        migrate_del_blocker(vbasedev->migration_blocker);
>> +        error_free(vbasedev->migration_blocker);
>> +        vbasedev->migration_blocker = NULL;
>> +    }
>> +
>> +    vfio_migration_region_exit(vbasedev);
>> +    g_free(vbasedev->migration);
>> +}
>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index a0c7b49a2ebc..8fe913175d85 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -145,3 +145,8 @@ vfio_display_edid_link_up(void) ""
>>   vfio_display_edid_link_down(void) ""
>>   vfio_display_edid_update(uint32_t prefx, uint32_t prefy) "%ux%u"
>>   vfio_display_edid_write_error(void) ""
>> +
>> +
>> +# migration.c
>> +vfio_migration_probe(const char *name, uint32_t index) " (%s) Region %d"
>> +
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index ba6169cd926e..8275c4c68f45 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -57,6 +57,10 @@ typedef struct VFIORegion {
>>       uint8_t nr; /* cache the region number for debug */
>>   } VFIORegion;
>>   
>> +typedef struct VFIOMigration {
>> +    VFIORegion region;
>> +} VFIOMigration;
>> +
>>   typedef struct VFIOAddressSpace {
>>       AddressSpace *as;
>>       QLIST_HEAD(, VFIOContainer) containers;
>> @@ -113,6 +117,8 @@ typedef struct VFIODevice {
>>       unsigned int num_irqs;
>>       unsigned int num_regions;
>>       unsigned int flags;
>> +    VFIOMigration *migration;
>> +    Error *migration_blocker;
>>   } VFIODevice;
>>   
>>   struct VFIODeviceOps {
>> @@ -204,4 +210,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
>>   int vfio_spapr_remove_window(VFIOContainer *container,
>>                                hwaddr offset_within_address_space);
>>   
>> +int vfio_migration_probe(VFIODevice *vbasedev, Error **errp);
>> +void vfio_migration_finalize(VFIODevice *vbasedev);
>> +
>>   #endif /* HW_VFIO_VFIO_COMMON_H */
> 

