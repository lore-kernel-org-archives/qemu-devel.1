Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B600C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 23:36:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E968D206D7
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 23:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="DMaJHGg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E968D206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVkdd-0000DJ-1G
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 19:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jVkOO-00047Q-Ei
 for qemu-devel@nongnu.org; Mon, 04 May 2020 19:20:56 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19432)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jVkNh-00008v-Lr
 for qemu-devel@nongnu.org; Mon, 04 May 2020 19:20:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5eb0a2e10004>; Mon, 04 May 2020 16:18:57 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 04 May 2020 16:20:07 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 04 May 2020 16:20:07 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 May
 2020 23:20:07 +0000
Received: from [10.40.101.152] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 May 2020
 23:19:58 +0000
Subject: Re: [PATCH v16 QEMU 05/16] vfio: Add migration region initialization
 and finalize function
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
 <1585084154-29461-6-git-send-email-kwankhede@nvidia.com>
 <20200326175202.GH2713@work-vm>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <d0347049-59d9-87d5-acb1-e56b56acc6b9@nvidia.com>
Date: Tue, 5 May 2020 04:49:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200326175202.GH2713@work-vm>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1588634337; bh=iHFtNtbWw7MkD3Xe/3m6QvA8rMIRllCP/BvTR/i7YI4=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=DMaJHGg4+e2lSx5BUJRJ66W1BaDG1YWWxB47yKaIYLZQFAVjSdjC+ySGt8ZTM1Wgb
 e0Sk+4VAjTdSWWadSTGDLSZE73inBjp6wBKZUsY8E3MD9Dc66UbSJe6h/cC8Z8jVDO
 p/CdFeL+9CPjSG6xaAu0hBrPyR9FUajXn114PJ5xtcufFydh/38j2zxH8cu95lOOsn
 vaY8GbdSmPE/4FN9oouKCpPiiZqpKE26a1Bk3wtt4kjI/MpIKoUi6nc3Cu/Iso1WnZ
 fwYEvhiwHlkGC46FQ12Gsgp27NL5zw0m0lq5zHAgXI32ZkiTmNbwv72kpWdJez2JVC
 /BoOG2VnL7OXA==
Received-SPF: pass client-ip=216.228.121.64; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate25.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 19:18:33
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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



On 3/26/2020 11:22 PM, Dr. David Alan Gilbert wrote:
> * Kirti Wankhede (kwankhede@nvidia.com) wrote:
>> - Migration functions are implemented for VFIO_DEVICE_TYPE_PCI device in this
>>    patch series.
>> - VFIO device supports migration or not is decided based of migration region
>>    query. If migration region query is successful and migration region
>>    initialization is successful then migration is supported else migration is
>>    blocked.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> ---
>>   hw/vfio/Makefile.objs         |   2 +-
>>   hw/vfio/migration.c           | 138 ++++++++++++++++++++++++++++++++++++++++++
>>   hw/vfio/trace-events          |   3 +
>>   include/hw/vfio/vfio-common.h |   9 +++
>>   4 files changed, 151 insertions(+), 1 deletion(-)
>>   create mode 100644 hw/vfio/migration.c
>>
>> diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
>> index 9bb1c09e8477..8b296c889ed9 100644
>> --- a/hw/vfio/Makefile.objs
>> +++ b/hw/vfio/Makefile.objs
>> @@ -1,4 +1,4 @@
>> -obj-y += common.o spapr.o
>> +obj-y += common.o spapr.o migration.o
>>   obj-$(CONFIG_VFIO_PCI) += pci.o pci-quirks.o display.o
>>   obj-$(CONFIG_VFIO_CCW) += ccw.o
>>   obj-$(CONFIG_VFIO_PLATFORM) += platform.o
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> new file mode 100644
>> index 000000000000..a078dcf1dd8f
>> --- /dev/null
>> +++ b/hw/vfio/migration.c
>> @@ -0,0 +1,138 @@
>> +/*
>> + * Migration support for VFIO devices
>> + *
>> + * Copyright NVIDIA, Inc. 2019
> 
> Time flies by...
> 
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2. See
>> + * the COPYING file in the top-level directory.
> 
> Are you sure you want this to be V2 only? Most code added to qemu now is
> v2 or later.
> 

I kept it same as in files vfio-pci and hw/vfio/common.c

Should it be different? Can you give some reference what it should be?

Thanks,
Kirti

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
>> +    int ret = -EINVAL;
>> +
>> +    if (!vbasedev->ops->vfio_get_object) {
>> +        return ret;
>> +    }
>> +
>> +    obj = vbasedev->ops->vfio_get_object(vbasedev);
>> +    if (!obj) {
>> +        return ret;
>> +    }
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
>> +    int ret;
>> +
>> +    vbasedev->migration = g_new0(VFIOMigration, 1);
>> +
>> +    ret = vfio_migration_region_init(vbasedev, info->index);
>> +    if (ret) {
>> +        error_report("%s: Failed to initialise migration region",
>> +                     vbasedev->name);
>> +        g_free(vbasedev->migration);
>> +        vbasedev->migration = NULL;
>> +        return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +/* ---------------------------------------------------------------------- */
>> +
>> +int vfio_migration_probe(VFIODevice *vbasedev, Error **errp)
>> +{
>> +    struct vfio_region_info *info;
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
>> +    trace_vfio_migration_probe(vbasedev->name, info->index);
>> +    return 0;
>> +
>> +add_blocker:
>> +    error_setg(&vbasedev->migration_blocker,
>> +               "VFIO device doesn't support migration");
>> +    ret = migrate_add_blocker(vbasedev->migration_blocker, &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        error_free(vbasedev->migration_blocker);
>> +    }
>> +    return ret;
>> +}
>> +
>> +void vfio_migration_finalize(VFIODevice *vbasedev)
>> +{
>> +    if (vbasedev->migration_blocker) {
>> +        migrate_del_blocker(vbasedev->migration_blocker);
>> +        error_free(vbasedev->migration_blocker);
>> +    }
>> +
>> +    vfio_migration_region_exit(vbasedev);
>> +    g_free(vbasedev->migration);
>> +}
>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index 8cdc27946cb8..191a726a1312 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -143,3 +143,6 @@ vfio_display_edid_link_up(void) ""
>>   vfio_display_edid_link_down(void) ""
>>   vfio_display_edid_update(uint32_t prefx, uint32_t prefy) "%ux%u"
>>   vfio_display_edid_write_error(void) ""
>> +
>> +# migration.c
>> +vfio_migration_probe(char *name, uint32_t index) " (%s) Region %d"
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index d69a7f3ae31e..d4b268641173 100644
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
>> -- 
>> 2.7.0
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

