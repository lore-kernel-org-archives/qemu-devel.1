Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AB2C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:17:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A0F820702
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lbRFodoK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0F820702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joSh2-0007qP-NW
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 10:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1joSgK-0007DG-Hz
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 10:16:48 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2375)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1joSgI-0000Aa-2d
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 10:16:47 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5ef4b19d0000>; Thu, 25 Jun 2020 07:15:57 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Thu, 25 Jun 2020 07:16:44 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Thu, 25 Jun 2020 07:16:44 -0700
Received: from [10.40.100.228] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 25 Jun
 2020 14:16:26 +0000
Subject: Re: [PATCH QEMU v25 09/17] vfio: Add load state functions to
 SaveVMHandlers
To: Alex Williamson <alex.williamson@redhat.com>
References: <1592684486-18511-1-git-send-email-kwankhede@nvidia.com>
 <1592684486-18511-10-git-send-email-kwankhede@nvidia.com>
 <20200624125437.664869ce@x1.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <1cb6dc9d-53b6-b978-9cb8-b4d7daaca400@nvidia.com>
Date: Thu, 25 Jun 2020 19:46:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200624125437.664869ce@x1.home>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1593094557; bh=vIPWIrTFvhOQVRomYCKQqHeEoH31aGbyzWhK9LxCb2o=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=lbRFodoKhcVoDHkUg+Nd4kciHkFDs09wbAbKOPSds5NDz9iusEezjRJ02DFpAwBwM
 1uwWUTnS3Zkfg+XAJRmC63wxiLXbphS06QLwo3tyyh/UHUrsCoiinZlNUEZaHdrJLw
 B0NAwhOu66jz3ZHarQmmVxU0/iuMbgUkQN8NXgt+3NezOLiInHsEaGLqSWCQEb9jW3
 em9K1L/6ZyETm177xsm4Fe0ddd+ziQtAnIeem27VlsEh1ItSIuCt5NwvY6qFmKKVC8
 Gu90/A5Qxc6HCFaz030aRAdY+MtcEONBfdtbCEnH+Ss8Jk2iRyidyBw5lvN8U54VEX
 9VkExuD+yWByA==
Received-SPF: pass client-ip=216.228.121.64; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate25.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 10:09:41
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



On 6/25/2020 12:24 AM, Alex Williamson wrote:
> On Sun, 21 Jun 2020 01:51:18 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> Sequence  during _RESUMING device state:
>> While data for this device is available, repeat below steps:
>> a. read data_offset from where user application should write data.
>> b. write data of data_size to migration region from data_offset.
>> c. write data_size which indicates vendor driver that data is written in
>>     staging buffer.
>>
>> For user, data is opaque. User should write data in the same order as
>> received.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>>   hw/vfio/migration.c  | 177 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   hw/vfio/trace-events |   3 +
>>   2 files changed, 180 insertions(+)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index ef1150c1ff02..faacea5327cb 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -302,6 +302,33 @@ static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
>>       return qemu_file_get_error(f);
>>   }
>>   
>> +static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    uint64_t data;
>> +
>> +    if (vbasedev->ops && vbasedev->ops->vfio_load_config) {
>> +        int ret;
>> +
>> +        ret = vbasedev->ops->vfio_load_config(vbasedev, f);
>> +        if (ret) {
>> +            error_report("%s: Failed to load device config space",
>> +                         vbasedev->name);
>> +            return ret;
>> +        }
>> +    }
>> +
>> +    data = qemu_get_be64(f);
>> +    if (data != VFIO_MIG_FLAG_END_OF_STATE) {
>> +        error_report("%s: Failed loading device config space, "
>> +                     "end flag incorrect 0x%"PRIx64, vbasedev->name, data);
>> +        return -EINVAL;
>> +    }
>> +
>> +    trace_vfio_load_device_config_state(vbasedev->name);
>> +    return qemu_file_get_error(f);
>> +}
>> +
>>   /* ---------------------------------------------------------------------- */
>>   
>>   static int vfio_save_setup(QEMUFile *f, void *opaque)
>> @@ -472,12 +499,162 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>>       return ret;
>>   }
>>   
>> +static int vfio_load_setup(QEMUFile *f, void *opaque)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    int ret = 0;
>> +
>> +    if (migration->region.mmaps) {
>> +        ret = vfio_region_mmap(&migration->region);
>> +        if (ret) {
>> +            error_report("%s: Failed to mmap VFIO migration region %d: %s",
>> +                         vbasedev->name, migration->region.nr,
>> +                         strerror(-ret));
>> +            return ret;
> 
> 
> Not fatal.
>

As discussed on 07/17 patch of this series, it should fall back to 
read/write, right?

> 
>> +        }
>> +    }
>> +
>> +    ret = vfio_migration_set_state(vbasedev, ~VFIO_DEVICE_STATE_MASK,
>> +                                   VFIO_DEVICE_STATE_RESUMING);
>> +    if (ret) {
>> +        error_report("%s: Failed to set state RESUMING", vbasedev->name);
>> +    }
>> +    return ret;
>> +}
>> +
>> +static int vfio_load_cleanup(void *opaque)
>> +{
>> +    vfio_save_cleanup(opaque);
>> +    return 0;
>> +}
>> +
>> +static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    int ret = 0;
>> +    uint64_t data, data_size;
>> +
>> +    data = qemu_get_be64(f);
>> +    while (data != VFIO_MIG_FLAG_END_OF_STATE) {
>> +
>> +        trace_vfio_load_state(vbasedev->name, data);
>> +
>> +        switch (data) {
>> +        case VFIO_MIG_FLAG_DEV_CONFIG_STATE:
>> +        {
>> +            ret = vfio_load_device_config_state(f, opaque);
>> +            if (ret) {
>> +                return ret;
>> +            }
>> +            break;
>> +        }
>> +        case VFIO_MIG_FLAG_DEV_SETUP_STATE:
>> +        {
>> +            data = qemu_get_be64(f);
>> +            if (data == VFIO_MIG_FLAG_END_OF_STATE) {
>> +                return ret;
>> +            } else {
>> +                error_report("%s: SETUP STATE: EOS not found 0x%"PRIx64,
>> +                             vbasedev->name, data);
>> +                return -EINVAL;
> 
> This is essentially just a compatibility failure, right?  For instance
> some future version of QEMU might include additional data between these
> markers that we don't understand and therefore we fail the migration.
> 

Yes.

Thanks,
Kirti

Thanks,
> 
> Alex
> 
>> +            }
>> +            break;
>> +        }
>> +        case VFIO_MIG_FLAG_DEV_DATA_STATE:
>> +        {
>> +            VFIORegion *region = &migration->region;
>> +            uint64_t data_offset = 0, size;
>> +
>> +            data_size = size = qemu_get_be64(f);
>> +            if (data_size == 0) {
>> +                break;
>> +            }
>> +
>> +            ret = pread(vbasedev->fd, &data_offset, sizeof(data_offset),
>> +                        region->fd_offset +
>> +                        offsetof(struct vfio_device_migration_info,
>> +                        data_offset));
>> +            if (ret != sizeof(data_offset)) {
>> +                error_report("%s:Failed to get migration buffer data offset %d",
>> +                             vbasedev->name, ret);
>> +                return -EINVAL;
>> +            }
>> +
>> +            trace_vfio_load_state_device_data(vbasedev->name, data_offset,
>> +                                              data_size);
>> +
>> +            while (size) {
>> +                void *buf = NULL;
>> +                uint64_t sec_size;
>> +                bool buffer_mmaped;
>> +
>> +                buf = get_data_section_size(region, data_offset, size,
>> +                                            &sec_size);
>> +
>> +                buffer_mmaped = (buf != NULL);
>> +
>> +                if (!buffer_mmaped) {
>> +                    buf = g_try_malloc(sec_size);
>> +                    if (!buf) {
>> +                        error_report("%s: Error allocating buffer ", __func__);
>> +                        return -ENOMEM;
>> +                    }
>> +                }
>> +
>> +                qemu_get_buffer(f, buf, sec_size);
>> +
>> +                if (!buffer_mmaped) {
>> +                    ret = pwrite(vbasedev->fd, buf, sec_size,
>> +                                 region->fd_offset + data_offset);
>> +                    g_free(buf);
>> +
>> +                    if (ret != sec_size) {
>> +                        error_report("%s: Failed to set migration buffer %d",
>> +                                vbasedev->name, ret);
>> +                        return -EINVAL;
>> +                    }
>> +                }
>> +                size -= sec_size;
>> +                data_offset += sec_size;
>> +            }
>> +
>> +            ret = pwrite(vbasedev->fd, &data_size, sizeof(data_size),
>> +                         region->fd_offset +
>> +                       offsetof(struct vfio_device_migration_info, data_size));
>> +            if (ret != sizeof(data_size)) {
>> +                error_report("%s: Failed to set migration buffer data size %d",
>> +                             vbasedev->name, ret);
>> +                return -EINVAL;
>> +            }
>> +            break;
>> +        }
>> +
>> +        default:
>> +            error_report("%s: Unknown tag 0x%"PRIx64, vbasedev->name, data);
>> +            return -EINVAL;
>> +        }
>> +
>> +        data = qemu_get_be64(f);
>> +        ret = qemu_file_get_error(f);
>> +        if (ret) {
>> +            return ret;
>> +        }
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>>   static SaveVMHandlers savevm_vfio_handlers = {
>>       .save_setup = vfio_save_setup,
>>       .save_cleanup = vfio_save_cleanup,
>>       .save_live_pending = vfio_save_pending,
>>       .save_live_iterate = vfio_save_iterate,
>>       .save_live_complete_precopy = vfio_save_complete_precopy,
>> +    .load_setup = vfio_load_setup,
>> +    .load_cleanup = vfio_load_cleanup,
>> +    .load_state = vfio_load_state,
>>   };
>>   
>>   /* ---------------------------------------------------------------------- */
>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index 9a1c5e17d97f..4a4bd3ba9a2a 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -157,3 +157,6 @@ vfio_save_device_config_state(const char *name) " (%s)"
>>   vfio_save_pending(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t compatible) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" compatible 0x%"PRIx64
>>   vfio_save_iterate(const char *name, int data_size) " (%s) data_size %d"
>>   vfio_save_complete_precopy(const char *name) " (%s)"
>> +vfio_load_device_config_state(const char *name) " (%s)"
>> +vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
>> +vfio_load_state_device_data(const char *name, uint64_t data_offset, uint64_t data_size) " (%s) Offset 0x%"PRIx64" size 0x%"PRIx64
> 

