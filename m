Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BF7C2BA2B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:19:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AC032078A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9aBWhCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC032078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLp4v-0001zb-Mg
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 10:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jLp3T-00013V-3f
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:18:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jLp3J-0000JD-JY
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:18:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35604
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jLp3J-0000Im-EE
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586269088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mH2/PweDEHcCPYgGy500/c2+rMaBnZLtprDIhE/koRQ=;
 b=S9aBWhCGJZs2NvTgEiVj+9KmcOe2Ja/W4ClscBJU+ny/owxull7z7VvvjW4fjv1VXNxTVQ
 4GH8rwg+O+CKpl519zEVPGP3RqxQHuBlX4KwXAvLKF9xcaj02XiiWA0pRV5u9NXkZbnL81
 pbM1m1R4nkJrCdzCKTXklUmt/auHH50=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-4Bp4i0FCMBOsBh1Cft2eig-1; Tue, 07 Apr 2020 10:17:51 -0400
X-MC-Unique: 4Bp4i0FCMBOsBh1Cft2eig-1
Received: by mail-ed1-f69.google.com with SMTP id b9so3229131edj.10
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 07:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mH2/PweDEHcCPYgGy500/c2+rMaBnZLtprDIhE/koRQ=;
 b=L486BN7eZPFMcsjX8SoNP3vU2vfK/aK53mu+N4tPzucCXRlsKa2WwkEMBCXfPNicpF
 uqHhOgd1XApnaOCP2xTUEiPgaqN2ik/m8IQlzRlTIFqRMvxjp5fcxAgPjGvhRqZxG0g7
 9fKedcRLbxfS/Ta3Wtrn5YtL9Wy5NEJYcP5LpV7jALtF6dzNbRy41Vdfo5/fve+EHC4o
 7PxlJ+LTrKtr+hvbDaTvQYt2RxoRR0Fm0Zr6+ltCeAQhoUnz+iRH1Cjjewq1TiqDfKeA
 uJR33h+npe16el1wX99MV+LTlAcXo6LtFDoBjzBictObO0fx46jOMm83gZWrBoaxMQIF
 we+Q==
X-Gm-Message-State: AGi0PuZuN5TYtzFWHClnUTik9MhHlytXS0f+ajCRpcSTqg6H5989bpx0
 vdnVWbOu4gyVRCS3mE6veKGeMSzoupc35YN8IZdXInTzrZtLrRHL1C8xMxJaRx2NdjnbFTNMkvT
 dTsM7Xrbyv3jqt9M=
X-Received: by 2002:a17:906:4d4e:: with SMTP id
 b14mr2320512ejv.240.1586269070230; 
 Tue, 07 Apr 2020 07:17:50 -0700 (PDT)
X-Google-Smtp-Source: APiQypLsT2kTHYgkqg7qshNKRu95Az6sVcoxcpXMmMxR+qtD5Ax7sLfkgj9ZPfFg0652HhzDKucIpg==
X-Received: by 2002:a17:906:4d4e:: with SMTP id
 b14mr2320472ejv.240.1586269069855; 
 Tue, 07 Apr 2020 07:17:49 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id hh1sm50958ejb.46.2020.04.07.07.17.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2020 07:17:49 -0700 (PDT)
Subject: Re: [PATCH for-5.0 v2 2/3] fw_cfg: Migrate ACPI table mr sizes
 separately
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, eric.auger@redhat.com,
 imammedo@redhat.com
References: <20200403101827.30664-1-shameerali.kolothum.thodi@huawei.com>
 <20200403101827.30664-3-shameerali.kolothum.thodi@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <00b69974-4b63-0c7c-c6ad-ed0f2eb712b9@redhat.com>
Date: Tue, 7 Apr 2020 16:17:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200403101827.30664-3-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com, mst@redhat.com,
 david@redhat.com, dgilbert@redhat.com, xuwei5@hisilicon.com,
 linuxarm@huawei.com, shannon.zhaosl@gmail.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/3/20 12:18 PM, Shameer Kolothum wrote:
> Any sub-page size update to ACPI MRs will be lost during
> migration, as we use aligned size in ram_load_precopy() ->
> qemu_ram_resize() path. This will result in inconsistency in
> FWCfgEntry sizes between source and destination. In order to avoid
> this, save and restore them separately during migration.
> 
> Up until now, this problem may not be that relevant for x86 as both
> ACPI table and Linker MRs gets padded and aligned. Also at present,
> qemu_ram_resize() doesn't invoke callback to update FWCfgEntry for
> unaligned size changes. But since we are going to fix the
> qemu_ram_resize() in the subsequent patch, the issue may become
> more serious especially for RSDP MR case.
> 
> Moreover, the issue will soon become prominent in arm/virt as well
> where the MRs are not padded or aligned at all and eventually have
> acpi table changes as part of future additions like NVDIMM hot-add
> feature.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
> v1 --> v2
>   - Changed *_mr_size from size_t to uint64_t to address portability.
>   - post_copy only done if sizes are not aligned.
> 
> Please find previous discussions here,
> https://patchwork.kernel.org/patch/11339591/#23140343
> ---
>   hw/core/machine.c         |  1 +
>   hw/nvram/fw_cfg.c         | 91 ++++++++++++++++++++++++++++++++++++++-
>   include/hw/nvram/fw_cfg.h |  6 +++
>   3 files changed, 97 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index de0c425605..c1a444cb75 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -39,6 +39,7 @@ GlobalProperty hw_compat_4_2[] = {
>       { "usb-redir", "suppress-remote-wake", "off" },
>       { "qxl", "revision", "4" },
>       { "qxl-vga", "revision", "4" },
> +    { "fw_cfg", "acpi-mr-restore", "false" },
>   };
>   const size_t hw_compat_4_2_len = G_N_ELEMENTS(hw_compat_4_2);
>   
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 179b302f01..4be6c9d9fd 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -39,6 +39,7 @@
>   #include "qemu/config-file.h"
>   #include "qemu/cutils.h"
>   #include "qapi/error.h"
> +#include "hw/acpi/aml-build.h"
>   
>   #define FW_CFG_FILE_SLOTS_DFLT 0x20
>   
> @@ -610,6 +611,55 @@ bool fw_cfg_dma_enabled(void *opaque)
>       return s->dma_enabled;
>   }
>   
> +static bool fw_cfg_acpi_mr_restore(void *opaque)
> +{
> +    FWCfgState *s = opaque;
> +    bool mr_aligned;
> +
> +    mr_aligned = QEMU_IS_ALIGNED(s->table_mr_size, qemu_real_host_page_size) &&
> +                 QEMU_IS_ALIGNED(s->linker_mr_size, qemu_real_host_page_size) &&
> +                 QEMU_IS_ALIGNED(s->rsdp_mr_size, qemu_real_host_page_size);
> +    return s->acpi_mr_restore && !mr_aligned;

This code is hard to review.

Is this equivalent?

     if (!s->acpi_mr_restore) {
         return false;
     }
     if (!QEMU_IS_ALIGNED(s->table_mr_size, qemu_real_host_page_size)) {
         return false;
     }
     if (!QEMU_IS_ALIGNED(s->linker_mr_size, qemu_real_host_page_size)) {
         return false;
     }
     if (!QEMU_IS_ALIGNED(s->rsdp_mr_size, qemu_real_host_page_size)) {
         return false;
     }
     return true;

> +}
> +
> +static void fw_cfg_update_mr(FWCfgState *s, uint16_t key, size_t size)
> +{
> +    MemoryRegion *mr;
> +    ram_addr_t offset;
> +    int arch = !!(key & FW_CFG_ARCH_LOCAL);
> +    void *ptr;
> +
> +    key &= FW_CFG_ENTRY_MASK;
> +    assert(key < fw_cfg_max_entry(s));
> +
> +    ptr = s->entries[arch][key].data;
> +    mr = memory_region_from_host(ptr, &offset);
> +
> +    memory_region_ram_resize(mr, size, &error_abort);
> +}
> +
> +static int fw_cfg_acpi_mr_restore_post_load(void *opaque, int version_id)
> +{
> +    FWCfgState *s = opaque;
> +    int i, index;
> +
> +    assert(s->files);
> +
> +    index = be32_to_cpu(s->files->count);
> +
> +    for (i = 0; i < index; i++) {
> +        if (!strcmp(s->files->f[i].name, ACPI_BUILD_TABLE_FILE)) {
> +            fw_cfg_update_mr(s, FW_CFG_FILE_FIRST + i, s->table_mr_size);
> +        } else if (!strcmp(s->files->f[i].name, ACPI_BUILD_LOADER_FILE)) {
> +            fw_cfg_update_mr(s, FW_CFG_FILE_FIRST + i, s->linker_mr_size);
> +        } else if (!strcmp(s->files->f[i].name, ACPI_BUILD_RSDP_FILE)) {
> +            fw_cfg_update_mr(s, FW_CFG_FILE_FIRST + i, s->rsdp_mr_size);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>   static const VMStateDescription vmstate_fw_cfg_dma = {
>       .name = "fw_cfg/dma",
>       .needed = fw_cfg_dma_enabled,
> @@ -619,6 +669,20 @@ static const VMStateDescription vmstate_fw_cfg_dma = {
>       },
>   };
>   
> +static const VMStateDescription vmstate_fw_cfg_acpi_mr = {
> +    .name = "fw_cfg/acpi_mr",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = fw_cfg_acpi_mr_restore,
> +    .post_load = fw_cfg_acpi_mr_restore_post_load,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT64(table_mr_size, FWCfgState),
> +        VMSTATE_UINT64(linker_mr_size, FWCfgState),
> +        VMSTATE_UINT64(rsdp_mr_size, FWCfgState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>   static const VMStateDescription vmstate_fw_cfg = {
>       .name = "fw_cfg",
>       .version_id = 2,
> @@ -631,6 +695,7 @@ static const VMStateDescription vmstate_fw_cfg = {
>       },
>       .subsections = (const VMStateDescription*[]) {
>           &vmstate_fw_cfg_dma,
> +        &vmstate_fw_cfg_acpi_mr,
>           NULL,
>       }
>   };
> @@ -815,6 +880,23 @@ static struct {
>   #define FW_CFG_ORDER_OVERRIDE_LAST 200
>   };
>   
> +/*
> + * Any sub-page size update to these table MRs will be lost during migration,
> + * as we use aligned size in ram_load_precopy() -> qemu_ram_resize() path.
> + * In order to avoid the inconsistency in sizes save them seperately and
> + * migrate over in vmstate post_load().
> + */
> +static void fw_cfg_acpi_mr_save(FWCfgState *s, const char *filename, size_t len)
> +{
> +    if (!strcmp(filename, ACPI_BUILD_TABLE_FILE)) {
> +        s->table_mr_size = len;
> +    } else if (!strcmp(filename, ACPI_BUILD_LOADER_FILE)) {
> +        s->linker_mr_size = len;
> +    } else if (!strcmp(filename, ACPI_BUILD_RSDP_FILE)) {
> +        s->rsdp_mr_size = len;
> +    }
> +}
> +
>   static int get_fw_cfg_order(FWCfgState *s, const char *name)
>   {
>       int i;
> @@ -914,6 +996,7 @@ void fw_cfg_add_file_callback(FWCfgState *s,  const char *filename,
>       trace_fw_cfg_add_file(s, index, s->files->f[index].name, len);
>   
>       s->files->count = cpu_to_be32(count+1);
> +    fw_cfg_acpi_mr_save(s, filename, len);
>   }
>   
>   void fw_cfg_add_file(FWCfgState *s,  const char *filename,
> @@ -937,6 +1020,7 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
>               ptr = fw_cfg_modify_bytes_read(s, FW_CFG_FILE_FIRST + i,
>                                              data, len);
>               s->files->f[i].size   = cpu_to_be32(len);
> +            fw_cfg_acpi_mr_save(s, filename, len);
>               return ptr;
>           }
>       }
> @@ -973,7 +1057,10 @@ static void fw_cfg_machine_ready(struct Notifier *n, void *data)
>       qemu_register_reset(fw_cfg_machine_reset, s);
>   }
>   
> -
> +static Property fw_cfg_properties[] = {
> +    DEFINE_PROP_BOOL("acpi-mr-restore", FWCfgState, acpi_mr_restore, true),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
>   
>   static void fw_cfg_common_realize(DeviceState *dev, Error **errp)
>   {
> @@ -1097,6 +1184,8 @@ static void fw_cfg_class_init(ObjectClass *klass, void *data)
>   
>       dc->reset = fw_cfg_reset;
>       dc->vmsd = &vmstate_fw_cfg;
> +
> +    device_class_set_props(dc, fw_cfg_properties);
>   }
>   
>   static const TypeInfo fw_cfg_info = {
> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> index b5291eefad..25d9307018 100644
> --- a/include/hw/nvram/fw_cfg.h
> +++ b/include/hw/nvram/fw_cfg.h
> @@ -53,6 +53,12 @@ struct FWCfgState {
>       dma_addr_t dma_addr;
>       AddressSpace *dma_as;
>       MemoryRegion dma_iomem;
> +
> +    /* restore during migration */
> +    bool acpi_mr_restore;
> +    uint64_t table_mr_size;
> +    uint64_t linker_mr_size;
> +    uint64_t rsdp_mr_size;
>   };
>   
>   struct FWCfgIoState {
> 


