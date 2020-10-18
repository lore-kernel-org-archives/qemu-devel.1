Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F54C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 20:49:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68EEB22277
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 20:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="S4VoKGlB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68EEB22277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUFcT-0002S2-I0
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 16:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kUFb9-0001hg-Mf
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 16:48:13 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13472)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kUFb5-0002pF-In
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 16:48:11 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f8ca9a60000>; Sun, 18 Oct 2020 13:46:30 -0700
Received: from [10.40.101.194] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 18 Oct
 2020 20:47:47 +0000
Subject: Re: [PATCH v26 09/17] vfio: Add load state functions to SaveVMHandlers
To: Cornelia Huck <cohuck@redhat.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-10-git-send-email-kwankhede@nvidia.com>
 <20201001120730.36eb76dd.cohuck@redhat.com>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <5ca09cd6-efd6-ed8d-277f-5a1b42b5835c@nvidia.com>
Date: Mon, 19 Oct 2020 02:17:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201001120730.36eb76dd.cohuck@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603053990; bh=65x+WHUc0A5RjNIqH0riiXibGgqEQT8QKoAcW2S37G0=;
 h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
 b=S4VoKGlBftc5/y2HPOD82URhVpoE8NvYY+58xo/eFBglGvVUxQ7Ouih+iRYIkqeoR
 6J1gsLk/YOtFRfsY+p9AXa1bq6eg423pA7cj82qDSC4qZ2QeQBwJoNFj2a5IwJ8KJd
 iMqGSkNgJFEAFurp/uZRgYpRif4aWGCfyiu44NMrB+FabrgDl9jf5cmAohls7E04vX
 EdOIrgmHdmvqYG0fKfo/6uPcS5oeqOtgFFq5sWQesWtlNXb5n3bAHQdb9Iz6xJK+7m
 XHRCi0cVZlk18jAhgwUbmVSXuk8NzKil4URlFOp1KzkQTtOCCzIutAQYlgtB1eyHF6
 jzwKlS41b4MXw==
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
Cc: cjia@nvidia.com, aik@ozlabs.ru, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, peterx@redhat.com,
 eauger@redhat.com, yi.l.liu@intel.com, quintela@redhat.com,
 ziye.yang@intel.com, armbru@redhat.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, felipe@nutanix.com, zhi.a.wang@intel.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, changpeng.liu@intel.com, eskultet@redhat.com,
 Ken.Xue@amd.com, jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/1/2020 3:37 PM, Cornelia Huck wrote:
> On Wed, 23 Sep 2020 04:54:11 +0530
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
>>   hw/vfio/migration.c  | 170 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   hw/vfio/trace-events |   3 +
>>   2 files changed, 173 insertions(+)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 4611bb972228..ffd70282dd0e 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -328,6 +328,33 @@ static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
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
> 
> I'm confused here: If we don't have a vfio_load_config callback, or if
> that callback did not read everything, we also might end up with a
> value that's not END_OF_STATE... in that case, the problem is not with
> the stream, but rather with the consumer?

Right, hence "end flag incorrect" is reported.

> 
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
>> @@ -502,12 +529,155 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
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
>> +            error_report("%s: Falling back to slow path", vbasedev->name);
>> +        }
>> +    }
>> +
>> +    ret = vfio_migration_set_state(vbasedev, ~VFIO_DEVICE_STATE_MASK,
>> +                                   VFIO_DEVICE_STATE_RESUMING);
>> +    if (ret) {
>> +        error_report("%s: Failed to set state RESUMING", vbasedev->name);
>> +    }
>> +    return ret;
> 
> If I follow the code correctly, the cleanup callback will not be
> invoked if you return != 0 here... should you clean up possible
> mappings on error here?
> 

Makes sense, adding region ummap on error.

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
>> +            }
>> +            break;
>> +        }
>> +        case VFIO_MIG_FLAG_DEV_DATA_STATE:
>> +        {
>> +            VFIORegion *region = &migration->region;
>> +            uint64_t data_offset = 0, size;
> 
> I think this function would benefit from splitting this off into a
> function handling DEV_DATA_STATE. It is quite hard to follow through
> all the checks and find out when we continue, and when we break off.
> 

Each switch case has a break, we break off on success cases, where as we 
return error if we encounter any case where (ret < 0)


> Some documentation about the markers would also be really helpful.

Sure adding it in patch 07, where these are defined.

> The logic seems to be:
> - DEV_CONFIG_STATE has config data and must be ended by END_OF_STATE
Right

> - DEV_SETUP_STATE has only END_OF_STATE, no data
Right now there is no data, but this is provision to add data if 
required in future.

> - DEV_DATA_STATE has... data; if there's any END_OF_STATE, it's buried
>    far down in the called functions
>

This is not correct, END_OF_STATE is after data. Moved data buffer 
loading logic to function vfio_load_buffer(), so DEV_DATA_STATE looks 
simplified as below. Hope this helps.

         case VFIO_MIG_FLAG_DEV_DATA_STATE:
         {
             uint64_t data_size;

             data_size = qemu_get_be64(f);
             if (data_size == 0) {
                 break;
             }

             ret = vfio_load_buffer(f, vbasedev, data_size);
             if (ret < 0) {
                 return ret;
             }
             break;
         }

Also handling the case if data_size is greater than the data section of 
migration region at destination in vfio_load_buffer()in my next version.

Thanks,
Kirti

> 
>> +
>> +            data_size = size = qemu_get_be64(f);
>> +            if (data_size == 0) {
>> +                break;
>> +            }
>> +
>> +            ret = vfio_mig_read(vbasedev, &data_offset, sizeof(data_offset),
>> +                                region->fd_offset +
>> +                                offsetof(struct vfio_device_migration_info,
>> +                                         data_offset));
>> +            if (ret < 0) {
>> +                return ret;
>> +            }
>> +
>> +            trace_vfio_load_state_device_data(vbasedev->name, data_offset,
>> +                                              data_size);
>> +
>> +            while (size) {
>> +                void *buf = NULL;
>> +                uint64_t sec_size;
>> +                bool buf_alloc = false;
>> +
>> +                buf = get_data_section_size(region, data_offset, size,
>> +                                            &sec_size);
>> +
>> +                if (!buf) {
>> +                    buf = g_try_malloc(sec_size);
>> +                    if (!buf) {
>> +                        error_report("%s: Error allocating buffer ", __func__);
>> +                        return -ENOMEM;
>> +                    }
>> +                    buf_alloc = true;
>> +                }
>> +
>> +                qemu_get_buffer(f, buf, sec_size);
>> +
>> +                if (buf_alloc) {
>> +                    ret = vfio_mig_write(vbasedev, buf, sec_size,
>> +                                         region->fd_offset + data_offset);
>> +                    g_free(buf);
>> +
>> +                    if (ret < 0) {
>> +                        return ret;
>> +                    }
>> +                }
>> +                size -= sec_size;
>> +                data_offset += sec_size;
>> +            }
>> +
>> +            ret = vfio_mig_write(vbasedev, &data_size, sizeof(data_size),
>> +                                 region->fd_offset +
>> +                       offsetof(struct vfio_device_migration_info, data_size));
>> +            if (ret < 0) {
>> +                return ret;
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
> 
> Unrelated to this patch: It's a bit odd that load_cleanup() (unlike
> save_cleanup()) has a return code (that seems unused).
> 
>> +    .load_state = vfio_load_state,
>>   };
>>   
>>   /* ---------------------------------------------------------------------- */
> 

