Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969BAC388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 16:18:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3A5F208B6
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 16:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="EWn41Yj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A5F208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVdIb-0004rz-PP
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 12:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kVdGu-0003Xr-Jw
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 12:17:02 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5455)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kVdGr-0003L2-SK
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 12:17:00 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f91b0190000>; Thu, 22 Oct 2020 09:15:21 -0700
Received: from [10.40.101.194] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 22 Oct
 2020 16:16:39 +0000
Subject: Re: [PATCH v27 04/17] vfio: Add migration region initialization and
 finalize function
To: Alex Williamson <alex.williamson@redhat.com>
References: <1603365127-14202-1-git-send-email-kwankhede@nvidia.com>
 <1603365127-14202-5-git-send-email-kwankhede@nvidia.com>
 <20201022082250.63eb9547@w520.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <5d0b2485-a812-4fdd-782a-efa5a19bfa79@nvidia.com>
Date: Thu, 22 Oct 2020 21:46:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201022082250.63eb9547@w520.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603383321; bh=TUT/j3+qbtgU9Z7ODQXtYqDzHCZePR+jOH99Wp2k+MM=;
 h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
 b=EWn41Yj4DmLSUrF/TkbuBoC+8o/4rCP1tDQIQpWw7l+PmpDb+3Rn/ANTq+M5+SZoR
 RXv6VPgoBRyxwgLK2Yzd8AUDEN+LYx+iyDeYPnd6g5BdYUYmBM76RewJwB8+zIPU16
 n7QszRbY0AmOAwAXaQZUQiIz7lqcdgHOBpOaUS9pR5Nwea1h/BJ4Coe86PqW+xfxtz
 0NP3UDnwumD6i1emltwb/ZE8fALMbO6xtn3imIiK0+4CoRc1R7uDid/rvMO67O1/W5
 lbZonzy1bP1YyUdNGkuJMP+qx/uuGBWpgHVKF/J6IymL1gXY9hqvEC8CHdT8S50Rq8
 K8L6gvyjwAf8g==
Received-SPF: pass client-ip=216.228.121.143;
 envelope-from=kwankhede@nvidia.com; helo=hqnvemgate24.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 12:16:56
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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
Cc: cohuck@redhat.com, cjia@nvidia.com, zhi.wang.linux@gmail.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, mcrossley@nvidia.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com, dgilbert@redhat.com,
 changpeng.liu@intel.com, eskultet@redhat.com, Ken.Xue@amd.com,
 jonathan.davies@nutanix.com, pbonzini@redhat.com, dnigam@nvidia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/22/2020 7:52 PM, Alex Williamson wrote:
> On Thu, 22 Oct 2020 16:41:54 +0530
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
>>   hw/vfio/migration.c           | 129 ++++++++++++++++++++++++++++++++++++++++++
>>   hw/vfio/trace-events          |   3 +
>>   include/hw/vfio/vfio-common.h |   9 +++
>>   4 files changed, 142 insertions(+)
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
>> index 000000000000..5f74a3ad1d72
>> --- /dev/null
>> +++ b/hw/vfio/migration.c
>> @@ -0,0 +1,129 @@
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
>> +static int vfio_migration_init(VFIODevice *vbasedev,
>> +                               struct vfio_region_info *info)
>> +{
>> +    int ret;
>> +    Object *obj;
>> +    VFIOMigration *migration;
>> +
>> +    if (!vbasedev->ops->vfio_get_object) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    obj = vbasedev->ops->vfio_get_object(vbasedev);
>> +    if (!obj) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    migration = g_new0(VFIOMigration, 1);
>> +
>> +    ret = vfio_region_setup(obj, vbasedev, &migration->region,
>> +                            info->index, "migration");
>> +    if (ret) {
>> +        error_report("%s: Failed to setup VFIO migration region %d: %s",
>> +                     vbasedev->name, info->index, strerror(-ret));
>> +        goto err;
>> +    }
>> +
>> +    if (!migration->region.size) {
>> +        error_report("%s: Invalid zero-sized of VFIO migration region %d",
>> +                     vbasedev->name, info->index);
>> +        ret = -EINVAL;
>> +        goto err;
>> +    }
>> +
>> +    vbasedev->migration = migration;
>> +    return 0;
>> +
>> +err:
>> +    vfio_migration_region_exit(vbasedev);
> 
> We can't get here with vbasedev->migration set, did you intend to set
> vbasedev->migration before testing region.size?  Thanks,
> 
Oh yes, I missed to address this when I moved migration variable to 
VFIODevice. Moving vbasedev->migration before region.size check.

Also removing region.size check vfio_migration_region_exit() for 
vfio_region_exit() and vfio_region_finalize().

Thanks,
Kirti

> Alex
> 
> 
> 
>> +    g_free(migration);
>> +    return ret;
>> +}
>> +
>> +/* ---------------------------------------------------------------------- */
>> +
>> +int vfio_migration_probe(VFIODevice *vbasedev, Error **errp)
>> +{
>> +    struct vfio_region_info *info = NULL;
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
>> index a0c7b49a2ebc..9ced5ec6277c 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -145,3 +145,6 @@ vfio_display_edid_link_up(void) ""
>>   vfio_display_edid_link_down(void) ""
>>   vfio_display_edid_update(uint32_t prefx, uint32_t prefy) "%ux%u"
>>   vfio_display_edid_write_error(void) ""
>> +
>> +# migration.c
>> +vfio_migration_probe(const char *name, uint32_t index) " (%s) Region %d"
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

