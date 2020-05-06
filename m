Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4F8C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 20:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A7D2063A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 20:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATA8q05D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A7D2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWQaQ-0002oB-54
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 16:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jWQZZ-0001K9-5k
 for qemu-devel@nongnu.org; Wed, 06 May 2020 16:23:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37809
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jWQZY-0000nW-38
 for qemu-devel@nongnu.org; Wed, 06 May 2020 16:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588796595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hnvoAf3OpVpFFAdM0L9+0BfzTkDuj1unNTaXGCuldsw=;
 b=ATA8q05D6xFtZjXuCQahZqa2h/n269qb9MbseZmDCCD6o6nTZNdWKr6UaNKlj17lsUaj9/
 tg8TA4YJs3fkewJbKc6/1jKXUe2V75SK3lYK5UYA2qOwOfXZimHa1NB0cixKiX4dvPWe7P
 QESA24z9yXV7Ih3dTHW7vunAZ71moPY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-eghbTU30N3GvjeNkuB_aRA-1; Wed, 06 May 2020 16:23:11 -0400
X-MC-Unique: eghbTU30N3GvjeNkuB_aRA-1
Received: by mail-wr1-f69.google.com with SMTP id f2so1921808wrm.9
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 13:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=p7xZNZC8Ssyf0SVCF5n0DEWEmiE42mwIr6yKi7/p/fU=;
 b=doKbJJEzGKSpqMYgu7ihATlS3nGA73skVNaWrwsjnjb1pjTXQr3XugG/pLNGwVe8t3
 QjQyw7Md3xmGJy4dUv4ib/SqKfKMtZb2gBc51HQiSuBCcUJCtEUFo5/17sbxwtAOoaVd
 0eARjb9wLGgTfGLfNza+HmIroSmKvs/JsQJWhy7GJQtVpJZLe+5N41+oj+XbFIxIJ63D
 HbRrr8UuC/c3yWQnOvM4BbeEuQsi0x98RdVNB2GYhpPJGrFhjQhQxg0uHh+nBLrTaltH
 KX7VXfchrTTOCYTMgGkGn48FHRavQhQAn4Cic9o66mKlqgh0baqCmm9DLti2wiS3S1ww
 Cl8A==
X-Gm-Message-State: AGi0PubirVrnm+Q5LOesHxY41v+pGp5XVWpRF3xmbYbns5St8tZsiBTt
 67OIdaJhy3x67Nyfa7WZL+7CLaWPXymUKhBzUee0nWnveyOiWRsKj29vk9o11dd5jbqx19QCqxN
 6vrcxiI6mzCnXJxc=
X-Received: by 2002:a5d:6904:: with SMTP id t4mr6593857wru.234.1588796590124; 
 Wed, 06 May 2020 13:23:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypIBaS9/Q8c05kQ/m+ela0vsU1Rquq1jgYRsTQqOYtLJXA8kLzzULCYbo5df0rcGs8/gta9dMQ==
X-Received: by 2002:a5d:6904:: with SMTP id t4mr6593832wru.234.1588796589831; 
 Wed, 06 May 2020 13:23:09 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 c83sm4831275wmd.23.2020.05.06.13.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 13:23:09 -0700 (PDT)
Date: Wed, 6 May 2020 16:23:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Subject: Re: [PATCH v25 06/10] ACPI: Record the Generic Error Status Block
 address
Message-ID: <20200506162301-mutt-send-email-mst@kernel.org>
References: <20200410114639.32844-1-gengdongjiu@huawei.com>
 <20200410114639.32844-7-gengdongjiu@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200410114639.32844-7-gengdongjiu@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 16:23:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: fam@euphon.net, peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com,
 kvm@vger.kernel.org, mtosatti@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com, linuxarm@huawei.com, shannon.zhaosl@gmail.com,
 zhengxiang9@huawei.com, qemu-arm@nongnu.org, Jonathan.Cameron@huawei.com,
 pbonzini@redhat.com, imammedo@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 10, 2020 at 07:46:35PM +0800, Dongjiu Geng wrote:
> Record the GHEB address via fw_cfg file, when recording
> a error to CPER, it will use this address to find out
> Generic Error Data Entries and write the error.
>=20
> In order to avoid migration failure, make hardware
> error table address to a part of GED device instead
> of global variable, then this address will be migrated
> to target QEMU.
>=20
> Acked-by: Xiang Zheng <zhengxiang9@huawei.com>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> change since v24:
> 1. Use s->ghes_state.ghes_addr_le to check in ghes_needed()
> 2. Using hardware_error->len instead of request_block_size to calculate i=
n acpi_ghes_add_fw_cfg()
> 3. Remove assert(vms->acpi_dev) be build APEI table
> 4. Directly use ACPI_GED(vms->acpi_dev) instead of ACPI_GED(vms->acpi_dev=
)
> ---
>  hw/acpi/generic_event_device.c         | 19 +++++++++++++++++++
>  hw/acpi/ghes.c                         | 14 ++++++++++++++
>  hw/arm/virt-acpi-build.c               |  8 ++++++++
>  include/hw/acpi/generic_event_device.h |  2 ++
>  include/hw/acpi/ghes.h                 |  6 ++++++
>  5 files changed, 49 insertions(+)
>=20
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_devic=
e.c
> index 021ed2b..1491291 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -234,6 +234,24 @@ static const VMStateDescription vmstate_ged_state =
=3D {
>      }
>  };
> =20
> +static bool ghes_needed(void *opaque)
> +{
> +    AcpiGedState *s =3D opaque;
> +    return s->ghes_state.ghes_addr_le;
> +}
> +
> +static const VMStateDescription vmstate_ghes_state =3D {
> +    .name =3D "acpi-ged/ghes",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D ghes_needed,
> +    .fields      =3D (VMStateField[]) {
> +        VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,
> +                       vmstate_ghes_state, AcpiGhesState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_acpi_ged =3D {
>      .name =3D "acpi-ged",
>      .version_id =3D 1,
> @@ -244,6 +262,7 @@ static const VMStateDescription vmstate_acpi_ged =3D =
{
>      },
>      .subsections =3D (const VMStateDescription * []) {
>          &vmstate_memhp_state,
> +        &vmstate_ghes_state,
>          NULL
>      }
>  };
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 091fd87..e74af23 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -24,6 +24,8 @@
>  #include "hw/acpi/ghes.h"
>  #include "hw/acpi/aml-build.h"
>  #include "qemu/error-report.h"
> +#include "hw/acpi/generic_event_device.h"
> +#include "hw/nvram/fw_cfg.h"
> =20
>  #define ACPI_GHES_ERRORS_FW_CFG_FILE        "etc/hardware_errors"
>  #define ACPI_GHES_DATA_ADDR_FW_CFG_FILE     "etc/hardware_errors_addr"
> @@ -213,3 +215,15 @@ void acpi_build_hest(GArray *table_data, BIOSLinker =
*linker)
>      build_header(linker, table_data, (void *)(table_data->data + hest_st=
art),
>          "HEST", table_data->len - hest_start, 1, NULL, NULL);
>  }
> +
> +void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> +                          GArray *hardware_error)
> +{
> +    /* Create a read-only fw_cfg file for GHES */
> +    fw_cfg_add_file(s, ACPI_GHES_ERRORS_FW_CFG_FILE, hardware_error->dat=
a,
> +                    hardware_error->len);
> +
> +    /* Create a read-write fw_cfg file for Address */
> +    fw_cfg_add_file_callback(s, ACPI_GHES_DATA_ADDR_FW_CFG_FILE, NULL, N=
ULL,
> +        NULL, &(ags->ghes_addr_le), sizeof(ags->ghes_addr_le), false);
> +}
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index f611bce..2726aac 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -911,6 +911,7 @@ void virt_acpi_setup(VirtMachineState *vms)
>  {
>      AcpiBuildTables tables;
>      AcpiBuildState *build_state;
> +    AcpiGedState *acpi_ged_state;
> =20
>      if (!vms->fw_cfg) {
>          trace_virt_acpi_setup();
> @@ -941,6 +942,13 @@ void virt_acpi_setup(VirtMachineState *vms)
>      fw_cfg_add_file(vms->fw_cfg, ACPI_BUILD_TPMLOG_FILE, tables.tcpalog-=
>data,
>                      acpi_data_len(tables.tcpalog));
> =20
> +    if (vms->ras) {
> +        assert(vms->acpi_dev);
> +        acpi_ged_state =3D ACPI_GED(vms->acpi_dev);
> +        acpi_ghes_add_fw_cfg(&acpi_ged_state->ghes_state,
> +                             vms->fw_cfg, tables.hardware_errors);
> +    }
> +
>      build_state->rsdp_mr =3D acpi_add_rom_blob(virt_acpi_build_update,
>                                               build_state, tables.rsdp,
>                                               ACPI_BUILD_RSDP_FILE, 0);
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/gen=
eric_event_device.h
> index d157eac..037d2b5 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -61,6 +61,7 @@
> =20
>  #include "hw/sysbus.h"
>  #include "hw/acpi/memory_hotplug.h"
> +#include "hw/acpi/ghes.h"
> =20
>  #define ACPI_POWER_BUTTON_DEVICE "PWRB"
> =20
> @@ -95,6 +96,7 @@ typedef struct AcpiGedState {
>      GEDState ged_state;
>      uint32_t ged_event_bitmap;
>      qemu_irq irq;
> +    AcpiGhesState ghes_state;
>  } AcpiGedState;
> =20
>  void build_ged_aml(Aml *table, const char* name, HotplugHandler *hotplug=
_dev,
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 18debd8..a3420fc 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -62,6 +62,12 @@ enum {
>      ACPI_HEST_SRC_ID_RESERVED,
>  };
> =20
> +typedef struct AcpiGhesState {
> +    uint64_t ghes_addr_le;
> +} AcpiGhesState;
> +
>  void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)=
;
>  void acpi_build_hest(GArray *table_data, BIOSLinker *linker);
> +void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
> +                          GArray *hardware_errors);
>  #endif
> --=20
> 1.8.3.1


