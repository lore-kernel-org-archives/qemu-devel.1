Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F93C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 14:33:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5935C22249
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 14:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FZa4+UqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5935C22249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVFB7-0004Vy-7v
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 10:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kVF91-0003KE-Tf
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 10:31:15 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:16082)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kVF8y-0004YZ-Pp
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 10:31:15 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f9045d00006>; Wed, 21 Oct 2020 07:29:36 -0700
Received: from [10.40.101.194] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Oct
 2020 14:30:52 +0000
Subject: Re: [PATCH v26 08/17] vfio: Add save state functions to SaveVMHandlers
To: "Wang, Zhi A" <zhi.a.wang@intel.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "cjia@nvidia.com" <cjia@nvidia.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-9-git-send-email-kwankhede@nvidia.com>
 <e0000720693f401d83159047101efcb4@intel.com>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <82b99c1c-9079-fcee-5ccf-011a3bb7fad7@nvidia.com>
Date: Wed, 21 Oct 2020 20:00:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <e0000720693f401d83159047101efcb4@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603290576; bh=tiu92XyCugX1ugSyPsr9Sen7128Fx7wuIyio559JpPo=;
 h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
 b=FZa4+UqC3wRZ7ww6ZnvpqGdaWjTMK4Enk7TotLNOrukOncNT7YCNf/t+f35rakp7X
 wfifNHYZmexPLA0clcgYnX8Vt0QwItT+FTLSedxFzTzfFXDPuSCHst/8e/TWnql+lC
 oWwHA9vfSUK1eAdB7oHl8WJZtUDVLGNCjpjA+njqWt8G64a1pEilwfXVCTL1vJ3BbN
 RZf5oCcaZKfUt97NQyP+76qhzsQH5MPFpoL8itWjmvrPhijJ8v7Qee6JX18kXrHgf1
 ncdQUstQh+JxCss4OnVIS/0MWqCGefAyWVxGCmUb2eUHiIiplL/pfO2KOmz1RvXopP
 Qx/LHWvvysUQw==
Received-SPF: pass client-ip=216.228.121.143;
 envelope-from=kwankhede@nvidia.com; helo=hqnvemgate24.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 10:31:10
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
Cc: "cohuck@redhat.com" <cohuck@redhat.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "eauger@redhat.com" <eauger@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "quintela@redhat.com" <quintela@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Zhao, 
 Yan Y" <yan.y.zhao@intel.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "Liu, Changpeng" <changpeng.liu@intel.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/23/2020 5:12 PM, Wang, Zhi A wrote:
> I met a problem when trying this patch. Mostly the problem happens if a device doesn't set any pending bytes in the iteration stage, which shows this device doesn't have a stage of iteration. 

I tried to reproduce this issue at my end and I didn't hit this case 
even if I do multiple iteration in pre-copy phase in live migration. In 
pre-copy phase, vendor driver receives read(pending_bytes) call back 
from .save_live_pending. If vendor driver don't have any data to send 
then return 0 as pending bytes.

But I could reproduce this issue with savevm/VM snapshot from 
qemu-monitor. Agree with your fix, pulling in my next iteration.

The QEMU in the destination machine will complain out-of-memory. After 
some investigation, it seems the vendor-specific bit stream is not 
complete and the QEMU in the destination machine will wrongly take a 
signature as the size of the section and failed to allocate the memory. 
Not sure if others meet the same problem.
> 
> I solved this problem by the following fix and the qemu version I am using is v5.0.0.0.
> 

Only this didn't fix the problem for me, have to reset pending_bytes 
from vfio_save_iterate() as .save_live_pending is not called during 
savevm/snapshot.

Thanks for testing.
Kirti

> commit 13a80adc2cdddd48d76acf6a5dd715bcbf42b577
> Author: Zhi Wang <zhi.wang.linux@gmail.com>
> Date:   Tue Sep 15 15:58:45 2020 +0300
> 
>      fix
>      
>      Signed-off-by: Zhi Wang <zhi.wang.linux@gmail.com>
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 09eec9c..e741319 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -453,10 +458,12 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
>               return ret;
>           }
>   
> -        if (migration->pending_bytes == 0) {
> -            /* indicates data finished, goto complete phase */
> -            return 1;
> -        }
> +	if (migration->pending_bytes == 0) {
> +		/* indicates data finished, goto complete phase */
> +		qemu_put_be64(f, 0);
> +		qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> +		return 1;
> +	}
>       }
>   
>       data_size = vfio_save_buffer(f, vbasedev);
> 
> -----Original Message-----
> From: Kirti Wankhede <kwankhede@nvidia.com>
> Sent: Wednesday, September 23, 2020 2:24 AM
> To: alex.williamson@redhat.com; cjia@nvidia.com
> Cc: Tian, Kevin <kevin.tian@intel.com>; Yang, Ziye <ziye.yang@intel.com>; Liu, Changpeng <changpeng.liu@intel.com>; Liu, Yi L <yi.l.liu@intel.com>; mlevitsk@redhat.com; eskultet@redhat.com; cohuck@redhat.com; dgilbert@redhat.com; jonathan.davies@nutanix.com; eauger@redhat.com; aik@ozlabs.ru; pasic@linux.ibm.com; felipe@nutanix.com; Zhengxiao.zx@Alibaba-inc.com; shuangtai.tst@alibaba-inc.com; Ken.Xue@amd.com; Wang, Zhi A <zhi.a.wang@intel.com>; Zhao, Yan Y <yan.y.zhao@intel.com>; pbonzini@redhat.com; quintela@redhat.com; eblake@redhat.com; armbru@redhat.com; peterx@redhat.com; qemu-devel@nongnu.org; Kirti Wankhede <kwankhede@nvidia.com>
> Subject: [PATCH v26 08/17] vfio: Add save state functions to SaveVMHandlers
> 
> Added .save_live_pending, .save_live_iterate and .save_live_complete_precopy functions. These functions handles pre-copy and stop-and-copy phase.
> 
> In _SAVING|_RUNNING device state or pre-copy phase:
> - read pending_bytes. If pending_bytes > 0, go through below steps.
> - read data_offset - indicates kernel driver to write data to staging
>    buffer.
> - read data_size - amount of data in bytes written by vendor driver in
>    migration region.
> - read data_size bytes of data from data_offset in the migration region.
> - Write data packet to file stream as below:
> {VFIO_MIG_FLAG_DEV_DATA_STATE, data_size, actual data, VFIO_MIG_FLAG_END_OF_STATE }
> 
> In _SAVING device state or stop-and-copy phase a. read config space of device and save to migration file stream. This
>     doesn't need to be from vendor driver. Any other special config state
>     from driver can be saved as data in following iteration.
> b. read pending_bytes. If pending_bytes > 0, go through below steps.
> c. read data_offset - indicates kernel driver to write data to staging
>     buffer.
> d. read data_size - amount of data in bytes written by vendor driver in
>     migration region.
> e. read data_size bytes of data from data_offset in the migration region.
> f. Write data packet as below:
>     {VFIO_MIG_FLAG_DEV_DATA_STATE, data_size, actual data} g. iterate through steps b to f while (pending_bytes > 0) h. Write {VFIO_MIG_FLAG_END_OF_STATE}
> 
> When data region is mapped, its user's responsibility to read data from data_offset of data_size before moving to next steps.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>   hw/vfio/migration.c           | 273 ++++++++++++++++++++++++++++++++++++++++++
>   hw/vfio/trace-events          |   6 +
>   include/hw/vfio/vfio-common.h |   1 +
>   3 files changed, 280 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c index 8e8adaa25779..4611bb972228 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -180,6 +180,154 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t mask,
>       return 0;
>   }
>   
> +static void *get_data_section_size(VFIORegion *region, uint64_t data_offset,
> +                                   uint64_t data_size, uint64_t *size)
> +{
> +    void *ptr = NULL;
> +    uint64_t limit = 0;
> +    int i;
> +
> +    if (!region->mmaps) {
> +        if (size) {
> +            *size = data_size;
> +        }
> +        return ptr;
> +    }
> +
> +    for (i = 0; i < region->nr_mmaps; i++) {
> +        VFIOMmap *map = region->mmaps + i;
> +
> +        if ((data_offset >= map->offset) &&
> +            (data_offset < map->offset + map->size)) {
> +
> +            /* check if data_offset is within sparse mmap areas */
> +            ptr = map->mmap + data_offset - map->offset;
> +            if (size) {
> +                *size = MIN(data_size, map->offset + map->size - data_offset);
> +            }
> +            break;
> +        } else if ((data_offset < map->offset) &&
> +                   (!limit || limit > map->offset)) {
> +            /*
> +             * data_offset is not within sparse mmap areas, find size of
> +             * non-mapped area. Check through all list since region->mmaps list
> +             * is not sorted.
> +             */
> +            limit = map->offset;
> +        }
> +    }
> +
> +    if (!ptr && size) {
> +        *size = limit ? limit - data_offset : data_size;
> +    }
> +    return ptr;
> +}
> +
> +static int vfio_save_buffer(QEMUFile *f, VFIODevice *vbasedev, uint64_t
> +*size) {
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIORegion *region = &migration->region;
> +    uint64_t data_offset = 0, data_size = 0, sz;
> +    int ret;
> +
> +    ret = vfio_mig_read(vbasedev, &data_offset, sizeof(data_offset),
> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
> +                                             data_offset));
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    ret = vfio_mig_read(vbasedev, &data_size, sizeof(data_size),
> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
> +                                             data_size));
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    trace_vfio_save_buffer(vbasedev->name, data_offset, data_size,
> +                           migration->pending_bytes);
> +
> +    qemu_put_be64(f, data_size);
> +    sz = data_size;
> +
> +    while (sz) {
> +        void *buf = NULL;
> +        uint64_t sec_size;
> +        bool buf_allocated = false;
> +
> +        buf = get_data_section_size(region, data_offset, sz,
> + &sec_size);
> +
> +        if (!buf) {
> +            buf = g_try_malloc(sec_size);
> +            if (!buf) {
> +                error_report("%s: Error allocating buffer ", __func__);
> +                return -ENOMEM;
> +            }
> +            buf_allocated = true;
> +
> +            ret = vfio_mig_read(vbasedev, buf, sec_size,
> +                                region->fd_offset + data_offset);
> +            if (ret < 0) {
> +                g_free(buf);
> +                return ret;
> +            }
> +        }
> +
> +        qemu_put_buffer(f, buf, sec_size);
> +
> +        if (buf_allocated) {
> +            g_free(buf);
> +        }
> +        sz -= sec_size;
> +        data_offset += sec_size;
> +    }
> +
> +    ret = qemu_file_get_error(f);
> +
> +    if (!ret && size) {
> +        *size = data_size;
> +    }
> +
> +    return ret;
> +}
> +
> +static int vfio_update_pending(VFIODevice *vbasedev) {
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIORegion *region = &migration->region;
> +    uint64_t pending_bytes = 0;
> +    int ret;
> +
> +    ret = vfio_mig_read(vbasedev, &pending_bytes, sizeof(pending_bytes),
> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
> +                                             pending_bytes));
> +    if (ret < 0) {
> +        migration->pending_bytes = 0;
> +        return ret;
> +    }
> +
> +    migration->pending_bytes = pending_bytes;
> +    trace_vfio_update_pending(vbasedev->name, pending_bytes);
> +    return 0;
> +}
> +
> +static int vfio_save_device_config_state(QEMUFile *f, void *opaque) {
> +    VFIODevice *vbasedev = opaque;
> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_CONFIG_STATE);
> +
> +    if (vbasedev->ops && vbasedev->ops->vfio_save_config) {
> +        vbasedev->ops->vfio_save_config(vbasedev, f);
> +    }
> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> +
> +    trace_vfio_save_device_config_state(vbasedev->name);
> +
> +    return qemu_file_get_error(f);
> +}
> +
>   /* ---------------------------------------------------------------------- */
>   
>   static int vfio_save_setup(QEMUFile *f, void *opaque) @@ -232,9 +380,134 @@ static void vfio_save_cleanup(void *opaque)
>       trace_vfio_save_cleanup(vbasedev->name);
>   }
>   
> +static void vfio_save_pending(QEMUFile *f, void *opaque,
> +                              uint64_t threshold_size,
> +                              uint64_t *res_precopy_only,
> +                              uint64_t *res_compatible,
> +                              uint64_t *res_postcopy_only) {
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    int ret;
> +
> +    ret = vfio_update_pending(vbasedev);
> +    if (ret) {
> +        return;
> +    }
> +
> +    *res_precopy_only += migration->pending_bytes;
> +
> +    trace_vfio_save_pending(vbasedev->name, *res_precopy_only,
> +                            *res_postcopy_only, *res_compatible); }
> +
> +static int vfio_save_iterate(QEMUFile *f, void *opaque) {
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    uint64_t data_size;
> +    int ret;
> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
> +
> +    if (migration->pending_bytes == 0) {
> +        ret = vfio_update_pending(vbasedev);
> +        if (ret) {
> +            return ret;
> +        }
> +
> +        if (migration->pending_bytes == 0) {
> +            /* indicates data finished, goto complete phase */
> +            return 1;
> +        }
> +    }
> +
> +    ret = vfio_save_buffer(f, vbasedev, &data_size);
> +
> +    if (ret) {
> +        error_report("%s: vfio_save_buffer failed %s", vbasedev->name,
> +                     strerror(errno));
> +        return ret;
> +    }
> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> +
> +    ret = qemu_file_get_error(f);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    trace_vfio_save_iterate(vbasedev->name, data_size);
> +
> +    return 0;
> +}
> +
> +static int vfio_save_complete_precopy(QEMUFile *f, void *opaque) {
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    uint64_t data_size;
> +    int ret;
> +
> +    ret = vfio_migration_set_state(vbasedev, ~VFIO_DEVICE_STATE_RUNNING,
> +                                   VFIO_DEVICE_STATE_SAVING);
> +    if (ret) {
> +        error_report("%s: Failed to set state STOP and SAVING",
> +                     vbasedev->name);
> +        return ret;
> +    }
> +
> +    ret = vfio_save_device_config_state(f, opaque);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    ret = vfio_update_pending(vbasedev);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    while (migration->pending_bytes > 0) {
> +        qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
> +        ret = vfio_save_buffer(f, vbasedev, &data_size);
> +        if (ret < 0) {
> +            error_report("%s: Failed to save buffer", vbasedev->name);
> +            return ret;
> +        }
> +
> +        if (data_size == 0) {
> +            break;
> +        }
> +
> +        ret = vfio_update_pending(vbasedev);
> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> +
> +    ret = qemu_file_get_error(f);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    ret = vfio_migration_set_state(vbasedev, ~VFIO_DEVICE_STATE_SAVING, 0);
> +    if (ret) {
> +        error_report("%s: Failed to set state STOPPED", vbasedev->name);
> +        return ret;
> +    }
> +
> +    trace_vfio_save_complete_precopy(vbasedev->name);
> +    return ret;
> +}
> +
>   static SaveVMHandlers savevm_vfio_handlers = {
>       .save_setup = vfio_save_setup,
>       .save_cleanup = vfio_save_cleanup,
> +    .save_live_pending = vfio_save_pending,
> +    .save_live_iterate = vfio_save_iterate,
> +    .save_live_complete_precopy = vfio_save_complete_precopy,
>   };
>   
>   /* ---------------------------------------------------------------------- */ diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events index 982d8dccb219..118b5547c921 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -154,3 +154,9 @@ vfio_vmstate_change(const char *name, int running, const char *reason, uint32_t  vfio_migration_state_notifier(const char *name, const char *state) " (%s) state %s"
>   vfio_save_setup(const char *name) " (%s)"
>   vfio_save_cleanup(const char *name) " (%s)"
> +vfio_save_buffer(const char *name, uint64_t data_offset, uint64_t
> +data_size, uint64_t pending) " (%s) Offset 0x%"PRIx64" size 0x%"PRIx64"
> +pending 0x%"PRIx64 vfio_update_pending(const char *name, uint64_t pending) " (%s) pending 0x%"PRIx64 vfio_save_device_config_state(const char *name) " (%s)"
> +vfio_save_pending(const char *name, uint64_t precopy, uint64_t
> +postcopy, uint64_t compatible) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" compatible 0x%"PRIx64 vfio_save_iterate(const char *name, int data_size) " (%s) data_size %d"
> +vfio_save_complete_precopy(const char *name) " (%s)"
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h index 49c7c7a0e29a..471e444a364c 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -60,6 +60,7 @@ typedef struct VFIORegion {
>   
>   typedef struct VFIOMigration {
>       VFIORegion region;
> +    uint64_t pending_bytes;
>   } VFIOMigration;
>   
>   typedef struct VFIOAddressSpace {
> --
> 2.7.0
> 

