Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AB9C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B1CC20781
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5Kd1wu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1CC20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJIRd-0003MK-9K
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jJIQ5-0001BQ-Ss
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:03:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jJIQ4-00016p-4E
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:03:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22490
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jJIQ3-00016V-Vy
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585666991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FaJkiz10NQw9jlC+Kjcb9efmme9Mt48arhxpbww3o7w=;
 b=L5Kd1wu0RMnriEj+o17EoIPwreBIB2kNGead2pqpTz1/nqaWLQgOFeEYHFe6MeqR5j1BlL
 j4qAYNqo//G/Dw4Ns1hDFe5n3j6nY1ETDGGcXlBtNkYzKkRDNnj4YsWIMqZUkgMcUhSVYe
 1Bsw7Uxno6//p4t3cyjFIYssimYXW7k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-UKkID49EMLO_D3Ff1g76Qg-1; Tue, 31 Mar 2020 11:03:09 -0400
X-MC-Unique: UKkID49EMLO_D3Ff1g76Qg-1
Received: by mail-wr1-f70.google.com with SMTP id t25so10746396wrb.16
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 08:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ulje8nREHKWin46TswSOrg0IkBb6Q1QSROXfvQkX3Ms=;
 b=uUTaZPDwBqdC8LTTVO9J5ZESmf6AS6ZfobkudjGip83SR6FW3oyJ5tHnWxrZdS5H0h
 all9jrh9h2E37kVgcgudUWj88L4XN0RuWjYdQ2etsCLxt3ArnAcHqdQFXOPg05w9SB3Q
 VNpD6hCDRDUWRe8etHr2YP5b8izTsUmSqO41YfNmgcrwASpmrMUoJ6Djhi7ZOgf6Kc9h
 ldUvNs2Y0oXvVtubafXFXZnw27CgpgxTbOeRAd7Zi8DDgwbbLY81s1YHrPhnIlUt8YQ6
 S9cuDLKN3D8Av/86FrDxBL9HIysYVcfxdCXPxQRftgoeq0EReAsbLVYD8MgslZL05ZE0
 1hNA==
X-Gm-Message-State: ANhLgQ3RjxukCxJuz26aEIr/8arVsGtYZYbDBDqnrG2+zWzTPQQkCzlW
 TZJI0x2bBZsaKZ00GF6wRpjotMu4EanaFc/iHLUibxs77YyPnqoL5I/92B8/Cij3r0RaE+OAwOV
 momYBd1zDL6VN28w=
X-Received: by 2002:a1c:6745:: with SMTP id b66mr3925923wmc.30.1585666987596; 
 Tue, 31 Mar 2020 08:03:07 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs/XaY93pF2Ie30AbFEHDeXa7MWFgFRmosItCbcuk9ylRBLIQdx941/SBMaSJs7UPSBv6ChHQ==
X-Received: by 2002:a1c:6745:: with SMTP id b66mr3925889wmc.30.1585666987261; 
 Tue, 31 Mar 2020 08:03:07 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
 by smtp.gmail.com with ESMTPSA id f20sm3908445wmc.35.2020.03.31.08.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 08:03:05 -0700 (PDT)
Date: Tue, 31 Mar 2020 11:03:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH for-5.0 2/3] fw_cfg: Migrate ACPI table mr sizes separately
Message-ID: <20200331110223-mutt-send-email-mst@kernel.org>
References: <20200330164909.28324-1-shameerali.kolothum.thodi@huawei.com>
 <20200330164909.28324-3-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200330164909.28324-3-shameerali.kolothum.thodi@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com,
 shannon.zhaosl@gmail.com, david@redhat.com, qemu-devel@nongnu.org,
 xuwei5@hisilicon.com, linuxarm@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, imammedo@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 30, 2020 at 05:49:08PM +0100, Shameer Kolothum wrote:
> Any sub-page size update to ACPI MRs will be lost during
> migration, as we use aligned size in ram_load_precopy() ->
> qemu_ram_resize() path. This will result in inconsistency in
> FWCfgEntry sizes between source and destination. In order to avoid
> this, save and restore them separately during migration.
>=20
> Up until now, this problem may not be that relevant for x86 as both
> ACPI table and Linker MRs gets padded and aligned. Also at present,
> qemu_ram_resize() doesn't invoke callback to update FWCfgEntry for
> unaligned size changes. But since we are going to fix the
> qemu_ram_resize() in the subsequent patch, the issue may become
> more serious especially for RSDP MR case.
>=20
> Moreover, the issue will soon become prominent in arm/virt as well
> where the MRs are not padded or aligned at all and eventually have
> acpi table changes as part of future additions like NVDIMM hot-add
> feature.
>=20
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
> Please find previous discussions here,
> https://patchwork.kernel.org/patch/11339591/#23140343
> ---
>=20
>  hw/core/machine.c         |  1 +
>  hw/nvram/fw_cfg.c         | 86 ++++++++++++++++++++++++++++++++++++++-
>  include/hw/nvram/fw_cfg.h |  6 +++
>  3 files changed, 92 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index de0c425605..c1a444cb75 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -39,6 +39,7 @@ GlobalProperty hw_compat_4_2[] =3D {
>      { "usb-redir", "suppress-remote-wake", "off" },
>      { "qxl", "revision", "4" },
>      { "qxl-vga", "revision", "4" },
> +    { "fw_cfg", "acpi-mr-restore", "false" },
>  };
>  const size_t hw_compat_4_2_len =3D G_N_ELEMENTS(hw_compat_4_2);
> =20
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 179b302f01..36d1e32f83 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -39,6 +39,7 @@
>  #include "qemu/config-file.h"
>  #include "qemu/cutils.h"
>  #include "qapi/error.h"
> +#include "hw/acpi/aml-build.h"
> =20
>  #define FW_CFG_FILE_SLOTS_DFLT 0x20
> =20
> @@ -610,6 +611,50 @@ bool fw_cfg_dma_enabled(void *opaque)
>      return s->dma_enabled;
>  }
> =20
> +static bool fw_cfg_acpi_mr_restore(void *opaque)
> +{
> +    FWCfgState *s =3D opaque;
> +    return s->acpi_mr_restore;

How about we limit this to the case where the address is
unaligned?

> +}
> +
> +static void fw_cfg_update_mr(FWCfgState *s, uint16_t key, size_t size)
> +{
> +    MemoryRegion *mr;
> +    ram_addr_t offset;
> +    int arch =3D !!(key & FW_CFG_ARCH_LOCAL);
> +    void *ptr;
> +
> +    key &=3D FW_CFG_ENTRY_MASK;
> +    assert(key < fw_cfg_max_entry(s));
> +
> +    ptr =3D s->entries[arch][key].data;
> +    mr =3D memory_region_from_host(ptr, &offset);
> +
> +    memory_region_ram_resize(mr, size, &error_abort);
> +}
> +
> +static int fw_cfg_acpi_mr_restore_post_load(void *opaque, int version_id=
)
> +{
> +    FWCfgState *s =3D opaque;
> +    int i, index;
> +
> +    assert(s->files);
> +
> +    index =3D be32_to_cpu(s->files->count);
> +
> +    for (i =3D 0; i < index; i++) {
> +        if (!strcmp(s->files->f[i].name, ACPI_BUILD_TABLE_FILE)) {
> +            fw_cfg_update_mr(s, FW_CFG_FILE_FIRST + i, s->table_mr_size)=
;
> +        } else if (!strcmp(s->files->f[i].name, ACPI_BUILD_LOADER_FILE))=
 {
> +            fw_cfg_update_mr(s, FW_CFG_FILE_FIRST + i, s->linker_mr_size=
);
> +        } else if (!strcmp(s->files->f[i].name, ACPI_BUILD_RSDP_FILE)) {
> +            fw_cfg_update_mr(s, FW_CFG_FILE_FIRST + i, s->rsdp_mr_size);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>  static const VMStateDescription vmstate_fw_cfg_dma =3D {
>      .name =3D "fw_cfg/dma",
>      .needed =3D fw_cfg_dma_enabled,
> @@ -619,6 +664,20 @@ static const VMStateDescription vmstate_fw_cfg_dma =
=3D {
>      },
>  };
> =20
> +static const VMStateDescription vmstate_fw_cfg_acpi_mr =3D {
> +    .name =3D "fw_cfg/acpi_mr",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D fw_cfg_acpi_mr_restore,
> +    .post_load =3D fw_cfg_acpi_mr_restore_post_load,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT64(table_mr_size, FWCfgState),
> +        VMSTATE_UINT64(linker_mr_size, FWCfgState),
> +        VMSTATE_UINT64(rsdp_mr_size, FWCfgState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static const VMStateDescription vmstate_fw_cfg =3D {
>      .name =3D "fw_cfg",
>      .version_id =3D 2,
> @@ -631,6 +690,7 @@ static const VMStateDescription vmstate_fw_cfg =3D {
>      },
>      .subsections =3D (const VMStateDescription*[]) {
>          &vmstate_fw_cfg_dma,
> +        &vmstate_fw_cfg_acpi_mr,
>          NULL,
>      }
>  };
> @@ -815,6 +875,23 @@ static struct {
>  #define FW_CFG_ORDER_OVERRIDE_LAST 200
>  };
> =20
> +/*
> + * Any sub-page size update to these table MRs will be lost during migra=
tion,
> + * as we use aligned size in ram_load_precopy() -> qemu_ram_resize() pat=
h.
> + * In order to avoid the inconsistency in sizes save them seperately and
> + * migrate over in vmstate post_load().
> + */
> +static void fw_cfg_acpi_mr_save(FWCfgState *s, const char *filename, siz=
e_t len)
> +{
> +    if (!strcmp(filename, ACPI_BUILD_TABLE_FILE)) {
> +        s->table_mr_size =3D len;
> +    } else if (!strcmp(filename, ACPI_BUILD_LOADER_FILE)) {
> +        s->linker_mr_size =3D len;
> +    } else if (!strcmp(filename, ACPI_BUILD_RSDP_FILE)) {
> +        s->rsdp_mr_size =3D len;
> +    }
> +}
> +
>  static int get_fw_cfg_order(FWCfgState *s, const char *name)
>  {
>      int i;
> @@ -914,6 +991,7 @@ void fw_cfg_add_file_callback(FWCfgState *s,  const c=
har *filename,
>      trace_fw_cfg_add_file(s, index, s->files->f[index].name, len);
> =20
>      s->files->count =3D cpu_to_be32(count+1);
> +    fw_cfg_acpi_mr_save(s, filename, len);
>  }
> =20
>  void fw_cfg_add_file(FWCfgState *s,  const char *filename,
> @@ -937,6 +1015,7 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *=
filename,
>              ptr =3D fw_cfg_modify_bytes_read(s, FW_CFG_FILE_FIRST + i,
>                                             data, len);
>              s->files->f[i].size   =3D cpu_to_be32(len);
> +            fw_cfg_acpi_mr_save(s, filename, len);
>              return ptr;
>          }
>      }
> @@ -973,7 +1052,10 @@ static void fw_cfg_machine_ready(struct Notifier *n=
, void *data)
>      qemu_register_reset(fw_cfg_machine_reset, s);
>  }
> =20
> -
> +static Property fw_cfg_properties[] =3D {
> +    DEFINE_PROP_BOOL("acpi-mr-restore", FWCfgState, acpi_mr_restore, tru=
e),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> =20
>  static void fw_cfg_common_realize(DeviceState *dev, Error **errp)
>  {
> @@ -1097,6 +1179,8 @@ static void fw_cfg_class_init(ObjectClass *klass, v=
oid *data)
> =20
>      dc->reset =3D fw_cfg_reset;
>      dc->vmsd =3D &vmstate_fw_cfg;
> +
> +    device_class_set_props(dc, fw_cfg_properties);
>  }
> =20
>  static const TypeInfo fw_cfg_info =3D {
> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> index b5291eefad..457fee7425 100644
> --- a/include/hw/nvram/fw_cfg.h
> +++ b/include/hw/nvram/fw_cfg.h
> @@ -53,6 +53,12 @@ struct FWCfgState {
>      dma_addr_t dma_addr;
>      AddressSpace *dma_as;
>      MemoryRegion dma_iomem;
> +
> +    /* restore during migration */
> +    bool acpi_mr_restore;
> +    size_t table_mr_size;
> +    size_t linker_mr_size;
> +    size_t rsdp_mr_size;
>  };
> =20
>  struct FWCfgIoState {
> --=20
> 2.17.1
>=20


