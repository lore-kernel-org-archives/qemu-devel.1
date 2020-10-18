Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453A6C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 20:54:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CFDE22277
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 20:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RVcNWRSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CFDE22277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUFgn-00045o-Dh
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 16:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kUFfa-0003A0-3d
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 16:52:46 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kUFfX-0003I4-Dg
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 16:52:45 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f8caabe0000>; Sun, 18 Oct 2020 13:51:10 -0700
Received: from [10.40.101.194] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 18 Oct
 2020 20:52:25 +0000
Subject: Re: [PATCH v26 12/17] vfio: Add function to start and stop dirty
 pages tracking
To: Alex Williamson <alex.williamson@redhat.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-13-git-send-email-kwankhede@nvidia.com>
 <20200925155528.73cdfe09@x1.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <2d920355-5fc0-9697-727d-678a036581e6@nvidia.com>
Date: Mon, 19 Oct 2020 02:22:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200925155528.73cdfe09@x1.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603054270; bh=NEU9hFhkxIccFQl/Mqp6fqVfzhGXbcCJyvOKHdroMcw=;
 h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
 b=RVcNWRSpmQX7fYDJryJ1Rtu7n4FOH7sGKSBypEN8k3UQZSdZdO1xiwuoSvLa2I8u0
 AogiWmG9lmy6aiIwL5qcA2QuxVjsf7H5C58oSs1yPJPYdv1JCfRc90agCA2fPPmdOv
 ILCraRmY7HLRHPDdLp2kEazNvEmCZoQ3Z+oR7mJmvNBbEBKUWg9rrIY2UETclPfs9P
 2sKsGys83KkjFDVRV5qT8OErEisOVKYWI22GqiDxyeEoytLNMPJUM3dYHG4LIg85Mk
 3zrSG7WywR7WfFLPlMUG1HhJwEEWClCeLD9TnvccaPWo/FD0kVTK9C5ZGBW4pH56ex
 1QXMx6vbA+eAw==
Received-SPF: pass client-ip=216.228.121.143;
 envelope-from=kwankhede@nvidia.com; helo=hqnvemgate24.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/18 16:48:02
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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



On 9/26/2020 3:25 AM, Alex Williamson wrote:
> On Wed, 23 Sep 2020 04:54:14 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> Call VFIO_IOMMU_DIRTY_PAGES ioctl to start and stop dirty pages tracking
>> for VFIO devices.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>>   hw/vfio/migration.c | 36 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 4306f6316417..822b68b4e015 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -11,6 +11,7 @@
>>   #include "qemu/main-loop.h"
>>   #include "qemu/cutils.h"
>>   #include <linux/vfio.h>
>> +#include <sys/ioctl.h>
>>   
>>   #include "sysemu/runstate.h"
>>   #include "hw/vfio/vfio-common.h"
>> @@ -355,6 +356,32 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
>>       return qemu_file_get_error(f);
>>   }
>>   
>> +static int vfio_set_dirty_page_tracking(VFIODevice *vbasedev, bool start)
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
>> +            return -EINVAL;
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
> 
> Maybe doesn't matter in the long run, but do you want to use -errno for
> the return rather than -1 from the ioctl on error?  Thanks,
> 

Makes sense. Changing it.

Thanks,
Kirti

> Alex
> 
>> +    return ret;
>> +}
>> +
>>   /* ---------------------------------------------------------------------- */
>>   
>>   static int vfio_save_setup(QEMUFile *f, void *opaque)
>> @@ -386,6 +413,11 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
>>           return ret;
>>       }
>>   
>> +    ret = vfio_set_dirty_page_tracking(vbasedev, true);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> +
>>       qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>>   
>>       ret = qemu_file_get_error(f);
>> @@ -401,6 +433,8 @@ static void vfio_save_cleanup(void *opaque)
>>       VFIODevice *vbasedev = opaque;
>>       VFIOMigration *migration = vbasedev->migration;
>>   
>> +    vfio_set_dirty_page_tracking(vbasedev, false);
>> +
>>       if (migration->region.mmaps) {
>>           vfio_region_unmap(&migration->region);
>>       }
>> @@ -734,6 +768,8 @@ static void vfio_migration_state_notifier(Notifier *notifier, void *data)
>>           if (ret) {
>>               error_report("%s: Failed to set state RUNNING", vbasedev->name);
>>           }
>> +
>> +        vfio_set_dirty_page_tracking(vbasedev, false);
>>       }
>>   }
>>   
> 

