Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA227C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 23:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 624DA206D7
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 23:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="oH74gTRe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624DA206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVkk4-00008H-Dp
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 19:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jVkOm-0004ac-O3
 for qemu-devel@nongnu.org; Mon, 04 May 2020 19:21:20 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4541)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jVkOj-0001vi-Gk
 for qemu-devel@nongnu.org; Mon, 04 May 2020 19:21:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5eb0a2e50001>; Mon, 04 May 2020 16:19:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 04 May 2020 16:21:09 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 04 May 2020 16:21:09 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 May
 2020 23:21:09 +0000
Received: from [10.40.101.152] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 May 2020
 23:21:00 +0000
Subject: Re: [PATCH v16 QEMU 10/16] vfio: Add load state functions to
 SaveVMHandlers
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
 <1585084154-29461-11-git-send-email-kwankhede@nvidia.com>
 <20200401185829.GH52559@work-vm>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <da0e2f3e-2057-288e-0fb6-28cf9aa6b8b5@nvidia.com>
Date: Tue, 5 May 2020 04:50:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200401185829.GH52559@work-vm>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1588634342; bh=yRFNlgfF3mtpdAYKvf574WP9alUWkIcta7tpdw3BnCE=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=oH74gTReyCEKhcmcuoNJIrkV+YTPe8czVKm4HwCJAgNJzjXwA0p5do2sw4WDhB/bv
 jZVvIHTRs8S+lJhsHz2f+sALhcX2DYQzCDi7uqe0XcCMHPbLdhDVUwV9y47FlroiR8
 jf+BJrDrWKxX6aaCEtQ+XkanIZvLZ1ff1egrN3RfZks3Jfde7Shqyn/d/GisTjIRkp
 Zn/Ib2HMLkU4fNjVG4wrglMGD238tikm1YFpJDGc7WS4arpRqJQ+aJNIFLkpNmsIoj
 jH+bXC152dDpPsJ6arGIq2A1yMZUgr9128Ba3Ju1f/lP0yvIGKP2yRUc3ej+ybcTTZ
 FBAxFyxDE9W3g==
Received-SPF: pass client-ip=216.228.121.143;
 envelope-from=kwankhede@nvidia.com; helo=hqnvemgate24.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 19:18:10
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



On 4/2/2020 12:28 AM, Dr. David Alan Gilbert wrote:
> * Kirti Wankhede (kwankhede@nvidia.com) wrote:
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
>> ---
>>   hw/vfio/migration.c  | 179 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   hw/vfio/trace-events |   3 +
>>   2 files changed, 182 insertions(+)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index ecbeed5182c2..ab295d25620e 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -269,6 +269,33 @@ static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
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
>> @@ -434,12 +461,164 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
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
>> +        }
>> +    }
>> +
>> +    ret = vfio_migration_set_state(vbasedev, ~0, VFIO_DEVICE_STATE_RESUMING);
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
>> +            uint64_t region_size = qemu_get_be64(f);
>> +
>> +            if (migration->region.size < region_size) {
>> +                error_report("%s: SETUP STATE: migration region too small, "
>> +                             "0x%"PRIx64 " < 0x%"PRIx64, vbasedev->name,
>> +                             migration->region.size, region_size);
>> +                return -EINVAL;
>> +            }
>> +
>> +            data = qemu_get_be64(f);
>> +            if (data == VFIO_MIG_FLAG_END_OF_STATE) {
> 
> Can you explain why you're reading this here rather than letting it drop
> through to the read at the end of the loop?
> 

To make sure sequence is followed, otherwise throw error.

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
>> +            void *buf = NULL;
>> +            bool buffer_mmaped = false;
>> +            uint64_t data_offset = 0;
>> +
>> +            data_size = qemu_get_be64(f);
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
>> +            if (region->mmaps) {
>> +                buf = find_data_region(region, data_offset, data_size);
>> +            }
>> +
>> +            buffer_mmaped = (buf != NULL) ? true : false;
>> +
>> +            if (!buffer_mmaped) {
>> +                buf = g_try_malloc0(data_size);
> 
> data_size has been read off the wire at this point; can we sanity check
> it?
> 

I do added a check above (data_size == 0), but here sanity check with what?

Thanks,
Kirti

>> +                if (!buf) {
>> +                    error_report("%s: Error allocating buffer ", __func__);
>> +                    return -ENOMEM;
>> +                }
>> +            }
>> +
>> +            qemu_get_buffer(f, buf, data_size);
>> +
>> +            if (!buffer_mmaped) {
>> +                ret = pwrite(vbasedev->fd, buf, data_size,
>> +                             region->fd_offset + data_offset);
>> +                g_free(buf);
>> +
>> +                if (ret != data_size) {
>> +                    error_report("%s: Failed to set migration buffer %d",
>> +                                 vbasedev->name, ret);
>> +                    return -EINVAL;
>> +                }
>> +            }
>> +
>> +            ret = pwrite(vbasedev->fd, &data_size, sizeof(data_size),
>> +                         region->fd_offset +
>> +                       offsetof(struct vfio_device_migration_info, data_size));
>> +            if (ret != sizeof(data_size)) {
>> +                error_report("%s: Failed to set migration buffer data size %d",
>> +                             vbasedev->name, ret);
>> +                if (!buffer_mmaped) {
>> +                    g_free(buf);
>> +                }
>> +                return -EINVAL;
>> +            }
>> +
>> +            trace_vfio_load_state_device_data(vbasedev->name, data_offset,
>> +                                              data_size);
>> +            break;
>> +        }
> 
> I'd add here a default:  that complains about an unknown tag.
> 
>> +        }
>> +
>> +        ret = qemu_file_get_error(f);
>> +        if (ret) {
>> +            return ret;
>> +        }
>> +        data = qemu_get_be64(f);
> 
> I'd also check file_get_error again at this point; if you're unlucky you
> get junk in 'data' and things get more confusing.
> 
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
>> index bdf40ba368c7..ac065b559f4e 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -157,3 +157,6 @@ vfio_save_device_config_state(char *name) " (%s)"
>>   vfio_save_pending(char *name, uint64_t precopy, uint64_t postcopy, uint64_t compatible) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" compatible 0x%"PRIx64
>>   vfio_save_iterate(char *name, int data_size) " (%s) data_size %d"
>>   vfio_save_complete_precopy(char *name) " (%s)"
>> +vfio_load_device_config_state(char *name) " (%s)"
>> +vfio_load_state(char *name, uint64_t data) " (%s) data 0x%"PRIx64
> 
> Please use const char*'s in traces.
> 
>> +vfio_load_state_device_data(char *name, uint64_t data_offset, uint64_t data_size) " (%s) Offset 0x%"PRIx64" size 0x%"PRIx64
>> -- 
>> 2.7.0
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

