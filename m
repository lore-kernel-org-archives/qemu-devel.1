Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF18C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 23:38:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D92F2206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 23:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="G1NuYDLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92F2206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVkfX-00036V-VU
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 19:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jVkOu-0004kR-Um
 for qemu-devel@nongnu.org; Mon, 04 May 2020 19:21:28 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5656)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jVkOq-000253-Pn
 for qemu-devel@nongnu.org; Mon, 04 May 2020 19:21:27 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5eb0a3620000>; Mon, 04 May 2020 16:21:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 04 May 2020 16:21:19 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 04 May 2020 16:21:19 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 May
 2020 23:21:19 +0000
Received: from [10.40.101.152] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 May 2020
 23:21:10 +0000
Subject: Re: [PATCH v16 QEMU 13/16] vfio: Add function to start and stop dirty
 pages tracking
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
 <1585084154-29461-14-git-send-email-kwankhede@nvidia.com>
 <20200401190356.GJ52559@work-vm>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <dce5851f-6a76-efcb-af5c-169efc4ffae3@nvidia.com>
Date: Tue, 5 May 2020 04:51:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200401190356.GJ52559@work-vm>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1588634467; bh=ACvpkwsUy7b9DgKwRcIPbWPMFDcGgbD8LAey9qtqf40=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=G1NuYDLzCn/Lj+DvnXqRi5Z1D1hVj0NxD5/+oDs/2f/w+eeafS38aMZdO2cgbRrr6
 fmcKiBjFwmSGIqWff+enSBi+ILCGBink8hs1Ki73DajNf2PvxiBcY+dLWi2eRUjr3Z
 ZQS41xDEm4ekr+Y3LZx92EXw17asGX5yUYNXe7T8rbsQB/FRtvZPAYgqkqDjFDml90
 0auoirn+3KJ8rTLJd9Jd21H6zv71qJPrtzd6QtwF38fe1VUTUYRtkxh1zFaMY+aa2Z
 nnbNO+n+fAIIb3jHSWdQiQIRYNcUcuYP4nP/Q2UxH78sPUvZ8+xKbG+rOavoNPcOB0
 z+JFhbJQIiHjg==
Received-SPF: pass client-ip=216.228.121.65; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate26.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 19:18:18
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



On 4/2/2020 12:33 AM, Dr. David Alan Gilbert wrote:
> * Kirti Wankhede (kwankhede@nvidia.com) wrote:
>> Call VFIO_IOMMU_DIRTY_PAGES ioctl to start and stop dirty pages tracking
>> for VFIO devices.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> ---
>>   hw/vfio/migration.c | 36 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index ab295d25620e..1827b7cfb316 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -9,6 +9,7 @@
>>   
>>   #include "qemu/osdep.h"
>>   #include "qemu/main-loop.h"
>> +#include <sys/ioctl.h>
>>   #include <linux/vfio.h>
>>   
>>   #include "sysemu/runstate.h"
>> @@ -296,6 +297,32 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
>>       return qemu_file_get_error(f);
>>   }
>>   
>> +static int vfio_start_dirty_page_tracking(VFIODevice *vbasedev, bool start)
>> +{
>> +    int ret;
>> +    VFIOContainer *container = vbasedev->group->container;
>> +    struct vfio_iommu_type1_dirty_bitmap dirty = {
>> +        .argsz = sizeof(dirty),
>> +    };
>> +
>> +    if (start) {
>> +        if (vbasedev->device_state & VFIO_DEVICE_STATE_SAVING) {
>> +            dirty.flags = VFIO_IOMMU_DIRTY_PAGES_FLAG_START;
>> +        } else {
>> +            return 0;
>> +        }
>> +    } else {
>> +            dirty.flags = VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP;
>> +    }
>> +
>> +    ret = ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, &dirty);
>> +    if (ret) {
>> +        error_report("Failed to set dirty tracking flag 0x%x errno: %d",
>> +                     dirty.flags, errno);
>> +    }
>> +    return ret;
>> +}
>> +
>>   /* ---------------------------------------------------------------------- */
>>   
>>   static int vfio_save_setup(QEMUFile *f, void *opaque)
>> @@ -330,6 +357,11 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
>>        */
>>       qemu_put_be64(f, migration->region.size);
>>   
>> +    ret = vfio_start_dirty_page_tracking(vbasedev, true);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> +
>>       qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>>   
>>       ret = qemu_file_get_error(f);
>> @@ -346,6 +378,8 @@ static void vfio_save_cleanup(void *opaque)
>>       VFIODevice *vbasedev = opaque;
>>       VFIOMigration *migration = vbasedev->migration;
>>   
>> +    vfio_start_dirty_page_tracking(vbasedev, false);
> 
> Shouldn't you check the return value?
> 

Even if return value is checked, it will be ignored and this function 
returns void.

Thanks,
Kirti

>> +
>>       if (migration->region.mmaps) {
>>           vfio_region_unmap(&migration->region);
>>       }
>> @@ -669,6 +703,8 @@ static void vfio_migration_state_notifier(Notifier *notifier, void *data)
>>           if (ret) {
>>               error_report("%s: Failed to set state RUNNING", vbasedev->name);
>>           }
>> +
>> +        vfio_start_dirty_page_tracking(vbasedev, false);
>>       }
>>   }
>>   
>> -- 
>> 2.7.0
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

