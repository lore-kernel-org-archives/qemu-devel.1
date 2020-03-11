Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD9BC0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 20:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB4BC20737
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 20:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jz4V6wYJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB4BC20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC8EH-0000ue-Re
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 16:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jC8Cg-0007ux-6r
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 16:43:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jC8Ce-0002zV-9n
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 16:43:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30598
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jC8Ce-0002y8-5G
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 16:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583959423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KvyPYC6RTWIxPlAxFL9WVL1yjh2TAQIk68hyV5Ym96s=;
 b=Jz4V6wYJvMRAsOTcGvaxrCkqGHgccbfOo9ChPt3kY+5KRzyyjjnKUzjmNWv2A1fxI7bFof
 B64KkBSfzEo716ZiYMMA6nZkEHmAyCIMVCj1CpBvU0bnh9LOKNr5MbuFY6BN58EwFpl8DW
 63ybM54lHGvP6EDHmXaR9xBbCa6OrMU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-WAkmJxnDPBWsSWws0iN8Vg-1; Wed, 11 Mar 2020 16:43:30 -0400
X-MC-Unique: WAkmJxnDPBWsSWws0iN8Vg-1
Received: by mail-qt1-f200.google.com with SMTP id y11so2067945qtn.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 13:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rfCYZvfadlkE9Bn3gi/zClaJZsk+4S/LfZk1CRc4GbY=;
 b=OJBl55ZNnG8l14sVphGOw11gQTMZrXzXd/ifj7uXiRODN2bNsioPViDNpnuzKW/phj
 uFSYDV4uQd5MjLKg4YxFRaHGWKg1mN1goxav4rngh6SelbbHdk+pY6nzYtm1jzZ6h0ew
 igT7MjEsB8ykzEBLlQ0/XrCWcu96bBr06woQ5CbGcP3S1GrVn0rgkRRomj0ILJ0KKmZ+
 ACMzGSUB+QEP6qzB66s+pOJJP/rWd3wlG5QipQ8Rx9FAatOdFM6LWrWBCLI5HZdLhIhx
 5QvUHxrJxHgsDX+1Mp9ibBZhsaBmW95jDpKYfeRyYHUk4cU9rRjQlbRxnD2J31lUycbM
 g/Dg==
X-Gm-Message-State: ANhLgQ2QN5zBaRwQpCQogQlZPPBmnRnPyM88o9WKgGVHzdGCBUzVIvaX
 uVJxclRR0W1XW0IRR4DoTmtLhAdKsSHDYkZJyuUr30caJetnTuKeTY0pAo2GYKGm4ZvpDPEDNVE
 Fxu0twwyXVf6kgIY=
X-Received: by 2002:ac8:4e4a:: with SMTP id e10mr1051635qtw.80.1583959408318; 
 Wed, 11 Mar 2020 13:43:28 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtyMDCG6tFpYr6DZhx7d7IeydUqy9cdzL8qkf9LyIBa4N7ar30zDmCY/xg7CgI2kf9196UWsQ==
X-Received: by 2002:ac8:4e4a:: with SMTP id e10mr1051611qtw.80.1583959407987; 
 Wed, 11 Mar 2020 13:43:27 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id w30sm1643684qtw.21.2020.03.11.13.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 13:43:27 -0700 (PDT)
Date: Wed, 11 Mar 2020 16:43:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v3 02/10] fw_cfg: Migrate ACPI table mr sizes separately
Message-ID: <20200311164306-mutt-send-email-mst@kernel.org>
References: <20200311172014.33052-1-shameerali.kolothum.thodi@huawei.com>
 <20200311172014.33052-3-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200311172014.33052-3-shameerali.kolothum.thodi@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com,
 shannon.zhaosl@gmail.com, david@redhat.com, qemu-devel@nongnu.org,
 xuwei5@hisilicon.com, linuxarm@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, imammedo@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 11, 2020 at 05:20:06PM +0000, Shameer Kolothum wrote:
> Any sub-page size update to ACPI table MRs will be lost during
> migration, as we use aligned size in ram_load_precopy() ->
> qemu_ram_resize() path. This will result in inconsistency in sizes
> between source and destination. In order to avoid this, save and
> restore them separately during migration.
>=20
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Is there a reason this is part of nvdimm patchset?

> ---
> Please find the discussion here,
> https://patchwork.kernel.org/patch/11339591/
> ---
>  hw/core/machine.c         |  1 +
>  hw/nvram/fw_cfg.c         | 86 ++++++++++++++++++++++++++++++++++++++-
>  include/hw/nvram/fw_cfg.h |  6 +++
>  3 files changed, 92 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 9e8c06036f..6d960bd47f 100644
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


