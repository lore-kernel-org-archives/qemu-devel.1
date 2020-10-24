Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D363C4363A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 09:41:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D7E2226B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 09:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="a8HfZXEX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D7E2226B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWG2y-0004Cp-S2
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 05:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kWG1V-0003fF-4F
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 05:39:44 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5973)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kWG1S-0002ti-NW
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 05:39:40 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f93f63f0000>; Sat, 24 Oct 2020 02:39:11 -0700
Received: from [10.40.102.184] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 24 Oct
 2020 09:39:18 +0000
Subject: Re: [PATCH v28 04/17] vfio: Add migration region initialization and
 finalize function
To: Alex Williamson <alex.williamson@redhat.com>
References: <1603449643-12851-1-git-send-email-kwankhede@nvidia.com>
 <1603449643-12851-5-git-send-email-kwankhede@nvidia.com>
 <20201023105236.4e9ae566@w520.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <a91fee75-393b-d6ba-00d6-d6da58ec5f5f@nvidia.com>
Date: Sat, 24 Oct 2020 15:09:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201023105236.4e9ae566@w520.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603532351; bh=J5PByh9+6VyqZ6+HJAV228cqvGXejZ2p4dLgaKmHzO0=;
 h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
 b=a8HfZXEXH+Sw1iWJzxPavhFk4+h+uSmKqGx0ejx6Cc8RAyBC5yCtvcpbfLBUSS4tP
 JBmdSEiTMYGSbYntTWrRbZjqtJeQSqsLCfcv0NZBhOvWJgOQgrOw7U/lzm90tL+KAX
 PsNnuDXBmsWbD1b/Tr5Zr6D/SB0GorczS4rVIe3nYrEjew4lnQPbCzgqg4TAJ4MhCf
 sy1vqVH8hCkTz7UJsPET04afPQpZSLpPyuYh2rboj2ofAd64Sf+APf3gaG9jzkWfdm
 h7o8NuscfqVtX7zXrjJxW0jujlq7rBtNvwc9/CwhAcv12MigBeJ3PnVkNUSYljCefY
 GCOJOeBB7IM1A==
Received-SPF: pass client-ip=216.228.121.65; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate26.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 05:39:33
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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



On 10/23/2020 10:22 PM, Alex Williamson wrote:
> On Fri, 23 Oct 2020 16:10:30 +0530
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
>>   hw/vfio/migration.c           | 133 ++++++++++++++++++++++++++++++++++++++++++
>>   hw/vfio/trace-events          |   3 +
>>   include/hw/vfio/vfio-common.h |   9 +++
>>   4 files changed, 146 insertions(+)
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
>> index 000000000000..bbe6e0b7a6cc
>> --- /dev/null
>> +++ b/hw/vfio/migration.c
>> @@ -0,0 +1,133 @@
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
>> +    vfio_region_exit(&migration->region);
>> +    vfio_region_finalize(&migration->region);
> 
> I think it would make sense to also:
> 
> g_free(migration);
> vbasedev->migration = NULL;
> 
> here as well so the callers don't need to. 

No, vfio_migration_init() case, err case is also hit when 
vbasedev->migration is not yet set but local variable migration is not-NULL.

Thanks,
Kirti

> Not worth a re-spin itself,
> maybe a follow-up if there's no other reason for a re-spin.  Thanks,
> 
> Alex
> 
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
>> +    vbasedev->migration = migration;
>> +
>> +    if (!migration->region.size) {
>> +        error_report("%s: Invalid zero-sized of VFIO migration region %d",
>> +                     vbasedev->name, info->index);
>> +        ret = -EINVAL;
>> +        goto err;
>> +    }
>> +    return 0;
>> +
>> +err:
>> +    vfio_migration_region_exit(vbasedev);
>> +    g_free(migration);
>> +    vbasedev->migration = NULL;
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
>> +    VFIOMigration *migration = vbasedev->migration;
>> +
>> +    if (migration) {
>> +        vfio_migration_region_exit(vbasedev);
>> +        g_free(vbasedev->migration);
>> +        vbasedev->migration = NULL;
>> +    }
>> +
>> +    if (vbasedev->migration_blocker) {
>> +        migrate_del_blocker(vbasedev->migration_blocker);
>> +        error_free(vbasedev->migration_blocker);
>> +        vbasedev->migration_blocker = NULL;
>> +    }
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

