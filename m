Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5081DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:35:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CA2B20836
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="K9ggAsks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA2B20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnpe0-0001Rv-C0
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 16:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jnpd5-0000Th-Sf
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 16:34:51 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jnpd3-0004K8-7n
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 16:34:51 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5ef2670b0000>; Tue, 23 Jun 2020 13:33:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 23 Jun 2020 13:34:47 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 23 Jun 2020 13:34:47 -0700
Received: from [10.40.100.157] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Jun
 2020 20:34:28 +0000
Subject: Re: [PATCH QEMU v25 08/17] vfio: Add save state functions to
 SaveVMHandlers
To: Alex Williamson <alex.williamson@redhat.com>
References: <1592684486-18511-1-git-send-email-kwankhede@nvidia.com>
 <1592684486-18511-9-git-send-email-kwankhede@nvidia.com>
 <20200622165038.2701e03c@x1.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <f9b1a2a6-fc63-113d-6eb9-c10681f32d02@nvidia.com>
Date: Wed, 24 Jun 2020 02:04:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200622165038.2701e03c@x1.home>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1592944395; bh=rrXnNsHoTPnlwfAlKx/YZdf5QgtqpY3tx0usnwzl+Z8=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=K9ggAsksau105QfGWJC+f1Bvw7UzMypsLIUU0Ke5N7MsEclyzzrdrNP3PyQeO0/y3
 YVU/cqtpzjuCykX/C0ZpRQGb7+GFLNw3kpG1EFHjfAcP0N05wQywqNRO92zJ2DiVla
 o0lIKfpimbzJb2T22AH9zB+VU3F/ADpg5stqLGaLOVsLkSCg+IEJs88qX0AxMolGTL
 0FdkHd70s7cq9CZl2S3tpNRk+Aek1FsEyqOhzH8ME8cGm0ReKMjRdQKAb0Y3luyRPU
 7OkK8McnjS6GxzHQ3iIWG+PGOR1j1gPgBdjQijo861LzVYfKCcxZ3LjwCfpWePxSh7
 KbLIxzMERf9ug==
Received-SPF: pass client-ip=216.228.121.143;
 envelope-from=kwankhede@nvidia.com; helo=hqnvemgate24.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 16:34:47
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -80
X-Spam_score: -8.1
X-Spam_bar: --------
X-Spam_report: (-8.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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



On 6/23/2020 4:20 AM, Alex Williamson wrote:
> On Sun, 21 Jun 2020 01:51:17 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> Added .save_live_pending, .save_live_iterate and .save_live_complete_precopy
>> functions. These functions handles pre-copy and stop-and-copy phase.
>>
>> In _SAVING|_RUNNING device state or pre-copy phase:
>> - read pending_bytes. If pending_bytes > 0, go through below steps.
>> - read data_offset - indicates kernel driver to write data to staging
>>    buffer.
>> - read data_size - amount of data in bytes written by vendor driver in
>>    migration region.
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
>>   hw/vfio/migration.c           | 283 ++++++++++++++++++++++++++++++++++++++++++
>>   hw/vfio/trace-events          |   6 +
>>   include/hw/vfio/vfio-common.h |   1 +
>>   3 files changed, 290 insertions(+)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 133bb5b1b3b2..ef1150c1ff02 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -140,6 +140,168 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t mask,
>>       return 0;
>>   }
>>   
>> +static void *get_data_section_size(VFIORegion *region, uint64_t data_offset,
>> +                                   uint64_t data_size, uint64_t *size)
>> +{
>> +    void *ptr = NULL;
>> +    int i;
>> +
>> +    if (!region->mmaps) {
>> +        *size = data_size;
>> +        return ptr;
>> +    }
>> +
>> +    /* check if data_offset in within sparse mmap areas */
>> +    for (i = 0; i < region->nr_mmaps; i++) {
>> +        VFIOMmap *map = region->mmaps + i;
>> +
>> +        if ((data_offset >= map->offset) &&
>> +            (data_offset < map->offset + map->size)) {
>> +            ptr = map->mmap + data_offset - map->offset;
>> +
>> +            if (data_offset + data_size <= map->offset + map->size) {
>> +                *size = data_size;
>> +            } else {
>> +                *size = map->offset + map->size - data_offset;
>> +            }
> 
> Ultimately we take whichever result is smaller, so we could just use:
> 
> *size = MIN(data_size, map->offset + map->size - data_offset);
> 
>> +            break;
>> +        }
>> +    }
>> +
>> +    if (!ptr) {
>> +        uint64_t limit = 0;
>> +
>> +        /*
>> +         * data_offset is not within sparse mmap areas, find size of non-mapped
>> +         * area. Check through all list since region->mmaps list is not sorted.
>> +         */
>> +        for (i = 0; i < region->nr_mmaps; i++) {
>> +            VFIOMmap *map = region->mmaps + i;
>> +
>> +            if ((data_offset < map->offset) &&
>> +                (!limit || limit > map->offset)) {
>> +                limit = map->offset;
>> +            }
> 
> We could have done this in an else branch of the previous loop to avoid
> walking the entries twice.
> 

Ok. updating with above 2 changes.

>> +        }
>> +
>> +        *size = limit ? limit - data_offset : data_size;
>> +    }
>> +    return ptr;
>> +}
>> +
>> +static int vfio_save_buffer(QEMUFile *f, VFIODevice *vbasedev)
>> +{
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    VFIORegion *region = &migration->region;
>> +    uint64_t data_offset = 0, data_size = 0, size;
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
>> +
>> +    trace_vfio_save_buffer(vbasedev->name, data_offset, data_size,
>> +                           migration->pending_bytes);
>> +
>> +    qemu_put_be64(f, data_size);
>> +    size = data_size;
>> +
>> +    while (size) {
>> +        void *buf = NULL;
>> +        bool buffer_mmaped;
>> +        uint64_t sec_size;
>> +
>> +        buf = get_data_section_size(region, data_offset, size, &sec_size);
>> +
>> +        buffer_mmaped = (buf != NULL);
>> +
>> +        if (!buffer_mmaped) {
>> +            buf = g_try_malloc(sec_size);
>> +            if (!buf) {
>> +                error_report("%s: Error allocating buffer ", __func__);
>> +                return -ENOMEM;
>> +            }
>> +
>> +            ret = pread(vbasedev->fd, buf, sec_size,
>> +                        region->fd_offset + data_offset);
> 
> Is the trade-off to allocate this buffer worth it?  I'd be tempted to
> iterate with a basic data type here to avoid what could potentially be
> a large memory allocation above.  It feels a little more robust, if not
> perhaps as fast, but I this will mostly be a fallback or only cover
> small ranges in normal operation.  Of course the data stream needs to
> be compatible either way we retrieve it.
> 

What should be basic data type here, u8, u16, u32, u64? We don't know at 
what granularity vendor driver is writing, then I thnk we have to go 
with smallest u8, right?


>> +            if (ret != sec_size) {
>> +                error_report("%s: Failed to get migration data %d",
>> +                             vbasedev->name, ret);
>> +                g_free(buf);
>> +                return -EINVAL;
>> +            }
>> +        }
>> +
>> +        qemu_put_buffer(f, buf, sec_size);
>> +
>> +        if (!buffer_mmaped) {
>> +            g_free(buf);
>> +        }
>> +        size -= sec_size;
>> +        data_offset += sec_size;
>> +    }
>> +
>> +    ret = qemu_file_get_error(f);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> +
>> +    return data_size;
> 
> This function returns int, data_size is uint64_t.  Thanks,
> 

Yes, returns for this function:
< 0 => error
==0 => no more data to save
data_size => amount of data saved in this function.

Thanks,
Kirti


