Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C6AC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:23:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53F2F2075E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ZWUbJgzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F2F2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY5bA-00051X-DZ
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 06:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jY5aR-0004OW-SC
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:23:03 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8386)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jY5aQ-00040N-0n
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:23:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5eb926fd0000>; Mon, 11 May 2020 03:20:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 11 May 2020 03:22:59 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 11 May 2020 03:22:59 -0700
Received: from [10.40.102.158] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 11 May
 2020 10:22:51 +0000
Subject: Re: [PATCH v16 QEMU 09/16] vfio: Add save state functions to
 SaveVMHandlers
To: Yan Zhao <yan.y.zhao@intel.com>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
 <1585084154-29461-10-git-send-email-kwankhede@nvidia.com>
 <20200509053131.GC26056@joy-OptiPlex-7040>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <7653e660-1360-7c2b-c4c7-3b53081f14e3@nvidia.com>
Date: Mon, 11 May 2020 15:52:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200509053131.GC26056@joy-OptiPlex-7040>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1589192445; bh=KDl+/o6qGwx0R5/kJO1avWPC7AlSJPIscAwgZtY6/cQ=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=ZWUbJgzEwuIx5OCTaxFNZzKgpJkyml1fDK5BB3QRyRldnaXVUq7Xc4BAugOVhxN+a
 VGGhbGH9ioUVmcB5KK9ar+4WqkkSNFjN85tm7lZgcwCovNdFvOa/pjE0sCgzU8H5La
 NqFZcNh3M5N3t29LTFLCIeBbdzPePXifv/7aDpIPYYaRGaDRSroNrXh2hQwWNhU3Sb
 torvt+tjXPQPpjWsj530UVOS/ID+TiyLfYjr3kchUFOCOGMttpaeUvuvwr6M34+8eu
 LjZO2eUCFWG7YLAO7BiCX2M/aSM2+9LvLzpeJCStfdgeqj5ofYv2remyR/exHcLrxK
 KvEVYqJJ9qWbg==
Received-SPF: pass client-ip=216.228.121.143;
 envelope-from=kwankhede@nvidia.com; helo=hqnvemgate24.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 05:53:50
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
Cc: "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "Wang, 
 Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/9/2020 11:01 AM, Yan Zhao wrote:
> On Wed, Mar 25, 2020 at 05:09:07AM +0800, Kirti Wankhede wrote:
>> Added .save_live_pending, .save_live_iterate and .save_live_complete_precopy
>> functions. These functions handles pre-copy and stop-and-copy phase.
>>
>> In _SAVING|_RUNNING device state or pre-copy phase:
>> - read pending_bytes. If pending_bytes > 0, go through below steps.
>> - read data_offset - indicates kernel driver to write data to staging
>>    buffer.
>> - read data_size - amount of data in bytes written by vendor driver in
>>    migration region.
> I think we should change the sequence of reading data_size and
> data_offset. see the next comment below.
> 
>> - read data_size bytes of data from data_offset in the migration region.
>> - Write data packet to file stream as below:
>> {VFIO_MIG_FLAG_DEV_DATA_STATE, data_size, actual data,
>> VFIO_MIG_FLAG_END_OF_STATE }
>>
>> In _SAVING device state or stop-and-copy phase
>> a. read config space of device and save to migration file stream. This
>>     doesn't need to be from vendor driver. Any other special config state
>>     from driver can be saved as data in following iteration.
>> b. read pending_bytes. If pending_bytes > 0, go through below steps.
>> c. read data_offset - indicates kernel driver to write data to staging
>>     buffer.
>> d. read data_size - amount of data in bytes written by vendor driver in
>>     migration region.
>> e. read data_size bytes of data from data_offset in the migration region.
>> f. Write data packet as below:
>>     {VFIO_MIG_FLAG_DEV_DATA_STATE, data_size, actual data}
>> g. iterate through steps b to f while (pending_bytes > 0)
>> h. Write {VFIO_MIG_FLAG_END_OF_STATE}
>>
>> When data region is mapped, its user's responsibility to read data from
>> data_offset of data_size before moving to next steps.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> ---
>>   hw/vfio/migration.c           | 245 +++++++++++++++++++++++++++++++++++++++++-
>>   hw/vfio/trace-events          |   6 ++
>>   include/hw/vfio/vfio-common.h |   1 +
>>   3 files changed, 251 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 033f76526e49..ecbeed5182c2 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -138,6 +138,137 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t mask,
>>       return 0;
>>   }
>>   
>> +static void *find_data_region(VFIORegion *region,
>> +                              uint64_t data_offset,
>> +                              uint64_t data_size)
>> +{
>> +    void *ptr = NULL;
>> +    int i;
>> +
>> +    for (i = 0; i < region->nr_mmaps; i++) {
>> +        if ((data_offset >= region->mmaps[i].offset) &&
>> +            (data_offset < region->mmaps[i].offset + region->mmaps[i].size) &&
>> +            (data_size <= region->mmaps[i].size)) {
>> +            ptr = region->mmaps[i].mmap + (data_offset -
>> +                                           region->mmaps[i].offset);
>> +            break;
>> +        }
>> +    }
>> +    return ptr;
>> +}
>> +
>> +static int vfio_save_buffer(QEMUFile *f, VFIODevice *vbasedev)
>> +{
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    VFIORegion *region = &migration->region;
>> +    uint64_t data_offset = 0, data_size = 0;
>> +    int ret;
>> +
>> +    ret = pread(vbasedev->fd, &data_offset, sizeof(data_offset),
>> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
>> +                                             data_offset));
>> +    if (ret != sizeof(data_offset)) {
>> +        error_report("%s: Failed to get migration buffer data offset %d",
>> +                     vbasedev->name, ret);
>> +        return -EINVAL;
>> +    }
>> +
>> +    ret = pread(vbasedev->fd, &data_size, sizeof(data_size),
>> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
>> +                                             data_size));
>> +    if (ret != sizeof(data_size)) {
>> +        error_report("%s: Failed to get migration buffer data size %d",
>> +                     vbasedev->name, ret);
>> +        return -EINVAL;
>> +    }
> data_size should be read first, and if it's 0, data_offset will not
> be read further.
> 
> the reasons are below:
> 1. if there's no data region provided by vendor driver, there's no
> reason to get a valid data_offset, so reading/writing of data_offset
> should fail. And this should not be treated as a migration error.
> 
> 2. even if pending_bytes is 0, vfio_save_iterate() is still possible to be
> called and therefore vfio_save_buffer() is called.
> 

As I mentioned in reply to Alex in:
https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg02476.html

With that, vfio_save_iterate() will read pending_bytes if its 0 and then 
if pending_bytes is not 0 then call vfio_save_buffer(). With that your 
above concerns should get resolved.

Thanks,
Kirti

