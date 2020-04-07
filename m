Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5181CC2BB55
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:34:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EE3C2072A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FUdKmwxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE3C2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLpJZ-0004s4-8w
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 10:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jLpIt-0004A9-T3
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jLpIs-0003aG-2l
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:34:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21183
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jLpIr-0003Zc-Uv
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586270053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G87QTEUQN/ZhiqAN34hjq5vWjWfmn5uz9Hp0Bk1AOag=;
 b=FUdKmwxuxcdO6f3ay/pmjZsJJaQWSC+2KNrerKdljC5RQiZWcNbbO3e9JO5X4rkYnwkPMw
 o4n+pXvlinvi4vKciC9cspQh0GKIO/ZKR5+EmUDWUUD5P9SYhfqJHQC5eqfDGHfs0MDU3S
 vsqiqWqTnqI7pAEcUDG4Am2MiKX286M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-QK7XvdGkNTaiBTfR6jmxlQ-1; Tue, 07 Apr 2020 10:34:09 -0400
X-MC-Unique: QK7XvdGkNTaiBTfR6jmxlQ-1
Received: by mail-wm1-f72.google.com with SMTP id s9so805162wmh.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 07:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=n2EkigPvD/rR/2AozXAt3nrhY0UGHS+mDCKzb5agLKw=;
 b=Wr3zfzAY18gj4nIVWPlOxQh6fHSxr1EEBFYoug/tP6kTF9nJoffnkLxvELEoKHKkNK
 gWefdcTsyZ1a4p6iosvzSWP45FPq/b9T/bmXmweDHGz6K3HTzbsaxZneBe6Ym5LkCka8
 6BlfqkOtgXca7CnxVzH8a9RUjWbHGXFrVg2sMCFSRCZwgB9JoM3V4VfeMRgyHIf+69GV
 SqbhcYMleijnDwowIbIfnVESmhqJq6fQDFY1jUwxhLQOpzUCNX/Viv86mKD9CJp5bcnt
 LmBqWZaqmRymTImxuG2w3DlVqO6/yPoOOq1FXj0pgshdkhVjgIo+4r1eOfeHmb49bDqm
 Kw1g==
X-Gm-Message-State: AGi0PuZ34sLE3GXy7qOvsEVBZD0TLWUWF0q8osdm/CdUYdK9vTtfItPK
 ZxPu6CMcrPJIFA7sE3cpd/jxry1e4FThovqB/cMy0gzpbnP2kKC/Bhi53p18duMy4LOQjm/OBak
 eDSaGcwDvy68dtCo=
X-Received: by 2002:a5d:6543:: with SMTP id z3mr353603wrv.396.1586270048575;
 Tue, 07 Apr 2020 07:34:08 -0700 (PDT)
X-Google-Smtp-Source: APiQypJlWrbwOdDArgFYlMSw1h65s918XbBUdHvM/wqRXhIbnQiEW31t0iKmYXSE3/s+ednkDFPVjg==
X-Received: by 2002:a5d:6543:: with SMTP id z3mr353499wrv.396.1586270047486;
 Tue, 07 Apr 2020 07:34:07 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
 by smtp.gmail.com with ESMTPSA id k9sm13541896wrn.89.2020.04.07.07.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2020 07:34:06 -0700 (PDT)
Date: Tue, 7 Apr 2020 10:34:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH for-5.0 v2 2/3] fw_cfg: Migrate ACPI table mr sizes
 separately
Message-ID: <20200407103340-mutt-send-email-mst@kernel.org>
References: <20200403101827.30664-1-shameerali.kolothum.thodi@huawei.com>
 <20200403101827.30664-3-shameerali.kolothum.thodi@huawei.com>
 <00b69974-4b63-0c7c-c6ad-ed0f2eb712b9@redhat.com>
MIME-Version: 1.0
In-Reply-To: <00b69974-4b63-0c7c-c6ad-ed0f2eb712b9@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com, david@redhat.com,
 shannon.zhaosl@gmail.com, linuxarm@huawei.com, qemu-devel@nongnu.org,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, dgilbert@redhat.com,
 eric.auger@redhat.com, qemu-arm@nongnu.org, xuwei5@hisilicon.com,
 imammedo@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 07, 2020 at 04:17:46PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 4/3/20 12:18 PM, Shameer Kolothum wrote:
> > Any sub-page size update to ACPI MRs will be lost during
> > migration, as we use aligned size in ram_load_precopy() ->
> > qemu_ram_resize() path. This will result in inconsistency in
> > FWCfgEntry sizes between source and destination. In order to avoid
> > this, save and restore them separately during migration.
> >=20
> > Up until now, this problem may not be that relevant for x86 as both
> > ACPI table and Linker MRs gets padded and aligned. Also at present,
> > qemu_ram_resize() doesn't invoke callback to update FWCfgEntry for
> > unaligned size changes. But since we are going to fix the
> > qemu_ram_resize() in the subsequent patch, the issue may become
> > more serious especially for RSDP MR case.
> >=20
> > Moreover, the issue will soon become prominent in arm/virt as well
> > where the MRs are not padded or aligned at all and eventually have
> > acpi table changes as part of future additions like NVDIMM hot-add
> > feature.
> >=20
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > ---
> > v1 --> v2
> >   - Changed *_mr_size from size_t to uint64_t to address portability.
> >   - post_copy only done if sizes are not aligned.
> >=20
> > Please find previous discussions here,
> > https://patchwork.kernel.org/patch/11339591/#23140343
> > ---
> >   hw/core/machine.c         |  1 +
> >   hw/nvram/fw_cfg.c         | 91 ++++++++++++++++++++++++++++++++++++++=
-
> >   include/hw/nvram/fw_cfg.h |  6 +++
> >   3 files changed, 97 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index de0c425605..c1a444cb75 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -39,6 +39,7 @@ GlobalProperty hw_compat_4_2[] =3D {
> >       { "usb-redir", "suppress-remote-wake", "off" },
> >       { "qxl", "revision", "4" },
> >       { "qxl-vga", "revision", "4" },
> > +    { "fw_cfg", "acpi-mr-restore", "false" },
> >   };
> >   const size_t hw_compat_4_2_len =3D G_N_ELEMENTS(hw_compat_4_2);
> > diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> > index 179b302f01..4be6c9d9fd 100644
> > --- a/hw/nvram/fw_cfg.c
> > +++ b/hw/nvram/fw_cfg.c
> > @@ -39,6 +39,7 @@
> >   #include "qemu/config-file.h"
> >   #include "qemu/cutils.h"
> >   #include "qapi/error.h"
> > +#include "hw/acpi/aml-build.h"
> >   #define FW_CFG_FILE_SLOTS_DFLT 0x20
> > @@ -610,6 +611,55 @@ bool fw_cfg_dma_enabled(void *opaque)
> >       return s->dma_enabled;
> >   }
> > +static bool fw_cfg_acpi_mr_restore(void *opaque)
> > +{
> > +    FWCfgState *s =3D opaque;
> > +    bool mr_aligned;
> > +
> > +    mr_aligned =3D QEMU_IS_ALIGNED(s->table_mr_size, qemu_real_host_pa=
ge_size) &&
> > +                 QEMU_IS_ALIGNED(s->linker_mr_size, qemu_real_host_pag=
e_size) &&
> > +                 QEMU_IS_ALIGNED(s->rsdp_mr_size, qemu_real_host_page_=
size);
> > +    return s->acpi_mr_restore && !mr_aligned;
>=20
> This code is hard to review.
>=20
> Is this equivalent?
>=20
>     if (!s->acpi_mr_restore) {
>         return false;
>     }
>     if (!QEMU_IS_ALIGNED(s->table_mr_size, qemu_real_host_page_size)) {
>         return false;
>     }
>     if (!QEMU_IS_ALIGNED(s->linker_mr_size, qemu_real_host_page_size)) {
>         return false;
>     }
>     if (!QEMU_IS_ALIGNED(s->rsdp_mr_size, qemu_real_host_page_size)) {
>         return false;
>     }
>     return true;

I think I prefer the original version though. Matter of taste?

> > +}
> > +
> > +static void fw_cfg_update_mr(FWCfgState *s, uint16_t key, size_t size)
> > +{
> > +    MemoryRegion *mr;
> > +    ram_addr_t offset;
> > +    int arch =3D !!(key & FW_CFG_ARCH_LOCAL);
> > +    void *ptr;
> > +
> > +    key &=3D FW_CFG_ENTRY_MASK;
> > +    assert(key < fw_cfg_max_entry(s));
> > +
> > +    ptr =3D s->entries[arch][key].data;
> > +    mr =3D memory_region_from_host(ptr, &offset);
> > +
> > +    memory_region_ram_resize(mr, size, &error_abort);
> > +}
> > +
> > +static int fw_cfg_acpi_mr_restore_post_load(void *opaque, int version_=
id)
> > +{
> > +    FWCfgState *s =3D opaque;
> > +    int i, index;
> > +
> > +    assert(s->files);
> > +
> > +    index =3D be32_to_cpu(s->files->count);
> > +
> > +    for (i =3D 0; i < index; i++) {
> > +        if (!strcmp(s->files->f[i].name, ACPI_BUILD_TABLE_FILE)) {
> > +            fw_cfg_update_mr(s, FW_CFG_FILE_FIRST + i, s->table_mr_siz=
e);
> > +        } else if (!strcmp(s->files->f[i].name, ACPI_BUILD_LOADER_FILE=
)) {
> > +            fw_cfg_update_mr(s, FW_CFG_FILE_FIRST + i, s->linker_mr_si=
ze);
> > +        } else if (!strcmp(s->files->f[i].name, ACPI_BUILD_RSDP_FILE))=
 {
> > +            fw_cfg_update_mr(s, FW_CFG_FILE_FIRST + i, s->rsdp_mr_size=
);
> > +        }
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> >   static const VMStateDescription vmstate_fw_cfg_dma =3D {
> >       .name =3D "fw_cfg/dma",
> >       .needed =3D fw_cfg_dma_enabled,
> > @@ -619,6 +669,20 @@ static const VMStateDescription vmstate_fw_cfg_dma=
 =3D {
> >       },
> >   };
> > +static const VMStateDescription vmstate_fw_cfg_acpi_mr =3D {
> > +    .name =3D "fw_cfg/acpi_mr",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .needed =3D fw_cfg_acpi_mr_restore,
> > +    .post_load =3D fw_cfg_acpi_mr_restore_post_load,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_UINT64(table_mr_size, FWCfgState),
> > +        VMSTATE_UINT64(linker_mr_size, FWCfgState),
> > +        VMSTATE_UINT64(rsdp_mr_size, FWCfgState),
> > +        VMSTATE_END_OF_LIST()
> > +    },
> > +};
> > +
> >   static const VMStateDescription vmstate_fw_cfg =3D {
> >       .name =3D "fw_cfg",
> >       .version_id =3D 2,
> > @@ -631,6 +695,7 @@ static const VMStateDescription vmstate_fw_cfg =3D =
{
> >       },
> >       .subsections =3D (const VMStateDescription*[]) {
> >           &vmstate_fw_cfg_dma,
> > +        &vmstate_fw_cfg_acpi_mr,
> >           NULL,
> >       }
> >   };
> > @@ -815,6 +880,23 @@ static struct {
> >   #define FW_CFG_ORDER_OVERRIDE_LAST 200
> >   };
> > +/*
> > + * Any sub-page size update to these table MRs will be lost during mig=
ration,
> > + * as we use aligned size in ram_load_precopy() -> qemu_ram_resize() p=
ath.
> > + * In order to avoid the inconsistency in sizes save them seperately a=
nd
> > + * migrate over in vmstate post_load().
> > + */
> > +static void fw_cfg_acpi_mr_save(FWCfgState *s, const char *filename, s=
ize_t len)
> > +{
> > +    if (!strcmp(filename, ACPI_BUILD_TABLE_FILE)) {
> > +        s->table_mr_size =3D len;
> > +    } else if (!strcmp(filename, ACPI_BUILD_LOADER_FILE)) {
> > +        s->linker_mr_size =3D len;
> > +    } else if (!strcmp(filename, ACPI_BUILD_RSDP_FILE)) {
> > +        s->rsdp_mr_size =3D len;
> > +    }
> > +}
> > +
> >   static int get_fw_cfg_order(FWCfgState *s, const char *name)
> >   {
> >       int i;
> > @@ -914,6 +996,7 @@ void fw_cfg_add_file_callback(FWCfgState *s,  const=
 char *filename,
> >       trace_fw_cfg_add_file(s, index, s->files->f[index].name, len);
> >       s->files->count =3D cpu_to_be32(count+1);
> > +    fw_cfg_acpi_mr_save(s, filename, len);
> >   }
> >   void fw_cfg_add_file(FWCfgState *s,  const char *filename,
> > @@ -937,6 +1020,7 @@ void *fw_cfg_modify_file(FWCfgState *s, const char=
 *filename,
> >               ptr =3D fw_cfg_modify_bytes_read(s, FW_CFG_FILE_FIRST + i=
,
> >                                              data, len);
> >               s->files->f[i].size   =3D cpu_to_be32(len);
> > +            fw_cfg_acpi_mr_save(s, filename, len);
> >               return ptr;
> >           }
> >       }
> > @@ -973,7 +1057,10 @@ static void fw_cfg_machine_ready(struct Notifier =
*n, void *data)
> >       qemu_register_reset(fw_cfg_machine_reset, s);
> >   }
> > -
> > +static Property fw_cfg_properties[] =3D {
> > +    DEFINE_PROP_BOOL("acpi-mr-restore", FWCfgState, acpi_mr_restore, t=
rue),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> >   static void fw_cfg_common_realize(DeviceState *dev, Error **errp)
> >   {
> > @@ -1097,6 +1184,8 @@ static void fw_cfg_class_init(ObjectClass *klass,=
 void *data)
> >       dc->reset =3D fw_cfg_reset;
> >       dc->vmsd =3D &vmstate_fw_cfg;
> > +
> > +    device_class_set_props(dc, fw_cfg_properties);
> >   }
> >   static const TypeInfo fw_cfg_info =3D {
> > diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> > index b5291eefad..25d9307018 100644
> > --- a/include/hw/nvram/fw_cfg.h
> > +++ b/include/hw/nvram/fw_cfg.h
> > @@ -53,6 +53,12 @@ struct FWCfgState {
> >       dma_addr_t dma_addr;
> >       AddressSpace *dma_as;
> >       MemoryRegion dma_iomem;
> > +
> > +    /* restore during migration */
> > +    bool acpi_mr_restore;
> > +    uint64_t table_mr_size;
> > +    uint64_t linker_mr_size;
> > +    uint64_t rsdp_mr_size;
> >   };
> >   struct FWCfgIoState {
> >=20


