Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F30C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:06:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B87B205C9
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="izg8ODTX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B87B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWhA5-0000Ay-DH
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 10:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWh9O-0007za-As
 for qemu-devel@nongnu.org; Thu, 07 May 2020 10:05:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42264
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWh9M-0008OG-Qh
 for qemu-devel@nongnu.org; Thu, 07 May 2020 10:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588860317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b59iUWJbks2dylm134wxBZq0YxxcUthxFy2F8Y96t7U=;
 b=izg8ODTXAVntXiCO5reBf84gVXoZGfvcoz6yREixmErVHKccokX0aj6FQnVNyTrppZ9ku4
 gSKnYZ+k5iYq/9gK+l5mKK+5hKiVPL+GRgAN55sH5q7JNshSIpCATgRILrqMOcCmcxnzxI
 4M4CItO/rr7DKilJllk8zEF1sdBkcVs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-bQQHCeZ3Mi6bAoIIWYoScA-1; Thu, 07 May 2020 10:05:14 -0400
X-MC-Unique: bQQHCeZ3Mi6bAoIIWYoScA-1
Received: by mail-wr1-f70.google.com with SMTP id o6so3519006wrn.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 07:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IXSptPTJgekBed36uaCjcVr22NsG3Xl6S8n0nVF8di4=;
 b=b5nOcc+7rXPOEG8/5hDlitCmNdCjkZCLSN/9eUtymlbZbajZkgzW7kAzyuW16Z/EQl
 0Ay2nvc0roF75NIp730XKbAwB4/d29WUKUxEhKh1muMvhJ9/UQ/bPXU5b8hgJIY9sGDM
 yM+Ujve/VRD/qk8v9o8DTZBkmftHDyFc3Exp0EjkpTevvimd8PzCACTevU3wp0puWSD2
 2rJFDuA+5nWxtd//HH0t/VYsU344lLApu1QvzyvOsRKx3UIlpglkpNFX8DmlGhiVZ8f7
 Z0CkyZvBdFuoZWn4dSWZLjlzgyT4nEFsAjfJjo5by7SRg+N8KQFovBs/ftjNAKjRf2tS
 FFrw==
X-Gm-Message-State: AGi0PubXZBmWyn6ePceTrlPq949fphKkb7pcT7qVu09RoQp+Ytf6mssL
 PTA82wz/5O8CDiYO0nBbPzvtk1DIqQ+XlBB6ALuZDwHlh8wt64oMrFa50e1uEvkKAdYSclpU8bf
 Y1LiiUTZbaGJy5n4=
X-Received: by 2002:adf:e910:: with SMTP id f16mr15179392wrm.176.1588860313531; 
 Thu, 07 May 2020 07:05:13 -0700 (PDT)
X-Google-Smtp-Source: APiQypKZWpxoz/LDskCGoKIor9llV8ZwCX4toVDtHmWm6GfDhBG9TkQQb8G8qTrj6POGyS7PuhwhJQ==
X-Received: by 2002:adf:e910:: with SMTP id f16mr15179358wrm.176.1588860313195; 
 Thu, 07 May 2020 07:05:13 -0700 (PDT)
Received: from [192.168.1.39] (248.red-88-21-203.staticip.rima-tde.net.
 [88.21.203.248])
 by smtp.gmail.com with ESMTPSA id u127sm8321638wme.8.2020.05.07.07.05.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2020 07:05:12 -0700 (PDT)
Subject: Re: [PATCH v5 08/15] acpi: move aml builder code for floppy device
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200507131640.14041-1-kraxel@redhat.com>
 <20200507131640.14041-9-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2f7a76fe-9c38-1441-70cf-919dce82e4fe@redhat.com>
Date: Thu, 7 May 2020 16:05:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200507131640.14041-9-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:56:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Herv=C3=A9

On 5/7/20 3:16 PM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   hw/block/fdc.c       | 83 ++++++++++++++++++++++++++++++++++++++++++++
>   hw/i386/acpi-build.c | 83 --------------------------------------------
>   stubs/cmos.c         |  7 ++++
>   stubs/Makefile.objs  |  1 +
>   4 files changed, 91 insertions(+), 83 deletions(-)
>   create mode 100644 stubs/cmos.c
>=20
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index 9628cc171ef8..40faa088b5f7 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -32,6 +32,8 @@
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
>   #include "qemu/timer.h"
> +#include "hw/i386/pc.h"

I'd rather not see this target-specific header used in the generic=20
device model... The culprit seems cmos_get_fd_drive_type(). Is the value=20
really PC specific?

Herv=C3=A9, do you know if such info & RTC nvram layout is used in other ar=
ch?

> +#include "hw/acpi/aml-build.h"
>   #include "hw/irq.h"
>   #include "hw/isa/isa.h"
>   #include "hw/qdev-properties.h"
> @@ -2765,6 +2767,85 @@ void isa_fdc_get_drive_max_chs(FloppyDriveType typ=
e,
>       (*maxc)--;
>   }
>  =20
> +static Aml *build_fdinfo_aml(int idx, FloppyDriveType type)
> +{
> +    Aml *dev, *fdi;
> +    uint8_t maxc, maxh, maxs;
> +
> +    isa_fdc_get_drive_max_chs(type, &maxc, &maxh, &maxs);
> +
> +    dev =3D aml_device("FLP%c", 'A' + idx);
> +
> +    aml_append(dev, aml_name_decl("_ADR", aml_int(idx)));
> +
> +    fdi =3D aml_package(16);
> +    aml_append(fdi, aml_int(idx));  /* Drive Number */
> +    aml_append(fdi,
> +        aml_int(cmos_get_fd_drive_type(type)));  /* Device Type */
> +    /*
> +     * the values below are the limits of the drive, and are thus indepe=
ndent
> +     * of the inserted media
> +     */
> +    aml_append(fdi, aml_int(maxc));  /* Maximum Cylinder Number */
> +    aml_append(fdi, aml_int(maxs));  /* Maximum Sector Number */
> +    aml_append(fdi, aml_int(maxh));  /* Maximum Head Number */
> +    /*
> +     * SeaBIOS returns the below values for int 0x13 func 0x08 regardles=
s of
> +     * the drive type, so shall we
> +     */
> +    aml_append(fdi, aml_int(0xAF));  /* disk_specify_1 */
> +    aml_append(fdi, aml_int(0x02));  /* disk_specify_2 */
> +    aml_append(fdi, aml_int(0x25));  /* disk_motor_wait */
> +    aml_append(fdi, aml_int(0x02));  /* disk_sector_siz */
> +    aml_append(fdi, aml_int(0x12));  /* disk_eot */
> +    aml_append(fdi, aml_int(0x1B));  /* disk_rw_gap */
> +    aml_append(fdi, aml_int(0xFF));  /* disk_dtl */
> +    aml_append(fdi, aml_int(0x6C));  /* disk_formt_gap */
> +    aml_append(fdi, aml_int(0xF6));  /* disk_fill */
> +    aml_append(fdi, aml_int(0x0F));  /* disk_head_sttl */
> +    aml_append(fdi, aml_int(0x08));  /* disk_motor_strt */
> +
> +    aml_append(dev, aml_name_decl("_FDI", fdi));
> +    return dev;
> +}
> +
> +static void fdc_isa_build_aml(ISADevice *isadev, Aml *scope)
> +{
> +    Aml *dev;
> +    Aml *crs;
> +    int i;
> +
> +#define ACPI_FDE_MAX_FD 4
> +    uint32_t fde_buf[5] =3D {
> +        0, 0, 0, 0,     /* presence of floppy drives #0 - #3 */
> +        cpu_to_le32(2)  /* tape presence (2 =3D=3D never present) */
> +    };
> +
> +    crs =3D aml_resource_template();
> +    aml_append(crs, aml_io(AML_DECODE16, 0x03F2, 0x03F2, 0x00, 0x04));
> +    aml_append(crs, aml_io(AML_DECODE16, 0x03F7, 0x03F7, 0x00, 0x01));
> +    aml_append(crs, aml_irq_no_flags(6));
> +    aml_append(crs,
> +        aml_dma(AML_COMPATIBILITY, AML_NOTBUSMASTER, AML_TRANSFER8, 2));
> +
> +    dev =3D aml_device("FDC0");
> +    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0700")));
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +
> +    for (i =3D 0; i < MIN(MAX_FD, ACPI_FDE_MAX_FD); i++) {
> +        FloppyDriveType type =3D isa_fdc_get_drive_type(isadev, i);
> +
> +        if (type < FLOPPY_DRIVE_TYPE_NONE) {
> +            fde_buf[i] =3D cpu_to_le32(1);  /* drive present */
> +            aml_append(dev, build_fdinfo_aml(i, type));
> +        }
> +    }
> +    aml_append(dev, aml_name_decl("_FDE",
> +               aml_buffer(sizeof(fde_buf), (uint8_t *)fde_buf)));
> +
> +    aml_append(scope, dev);
> +}
> +
>   static const VMStateDescription vmstate_isa_fdc =3D{
>       .name =3D "fdc",
>       .version_id =3D 2,
> @@ -2798,11 +2879,13 @@ static Property isa_fdc_properties[] =3D {
>   static void isabus_fdc_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    ISADeviceClass *isa =3D ISA_DEVICE_CLASS(klass);
>  =20
>       dc->realize =3D isabus_fdc_realize;
>       dc->fw_name =3D "fdc";
>       dc->reset =3D fdctrl_external_reset_isa;
>       dc->vmsd =3D &vmstate_isa_fdc;
> +    isa->build_aml =3D fdc_isa_build_aml;
>       device_class_set_props(dc, isa_fdc_properties);
>       set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>   }
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 443db94deb5b..775936e28b9a 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1058,85 +1058,6 @@ static void build_hpet_aml(Aml *table)
>       aml_append(table, scope);
>   }
>  =20
> -static Aml *build_fdinfo_aml(int idx, FloppyDriveType type)
> -{
> -    Aml *dev, *fdi;
> -    uint8_t maxc, maxh, maxs;
> -
> -    isa_fdc_get_drive_max_chs(type, &maxc, &maxh, &maxs);
> -
> -    dev =3D aml_device("FLP%c", 'A' + idx);
> -
> -    aml_append(dev, aml_name_decl("_ADR", aml_int(idx)));
> -
> -    fdi =3D aml_package(16);
> -    aml_append(fdi, aml_int(idx));  /* Drive Number */
> -    aml_append(fdi,
> -        aml_int(cmos_get_fd_drive_type(type)));  /* Device Type */
> -    /*
> -     * the values below are the limits of the drive, and are thus indepe=
ndent
> -     * of the inserted media
> -     */
> -    aml_append(fdi, aml_int(maxc));  /* Maximum Cylinder Number */
> -    aml_append(fdi, aml_int(maxs));  /* Maximum Sector Number */
> -    aml_append(fdi, aml_int(maxh));  /* Maximum Head Number */
> -    /*
> -     * SeaBIOS returns the below values for int 0x13 func 0x08 regardles=
s of
> -     * the drive type, so shall we
> -     */
> -    aml_append(fdi, aml_int(0xAF));  /* disk_specify_1 */
> -    aml_append(fdi, aml_int(0x02));  /* disk_specify_2 */
> -    aml_append(fdi, aml_int(0x25));  /* disk_motor_wait */
> -    aml_append(fdi, aml_int(0x02));  /* disk_sector_siz */
> -    aml_append(fdi, aml_int(0x12));  /* disk_eot */
> -    aml_append(fdi, aml_int(0x1B));  /* disk_rw_gap */
> -    aml_append(fdi, aml_int(0xFF));  /* disk_dtl */
> -    aml_append(fdi, aml_int(0x6C));  /* disk_formt_gap */
> -    aml_append(fdi, aml_int(0xF6));  /* disk_fill */
> -    aml_append(fdi, aml_int(0x0F));  /* disk_head_sttl */
> -    aml_append(fdi, aml_int(0x08));  /* disk_motor_strt */
> -
> -    aml_append(dev, aml_name_decl("_FDI", fdi));
> -    return dev;
> -}
> -
> -static Aml *build_fdc_device_aml(ISADevice *fdc)
> -{
> -    int i;
> -    Aml *dev;
> -    Aml *crs;
> -
> -#define ACPI_FDE_MAX_FD 4
> -    uint32_t fde_buf[5] =3D {
> -        0, 0, 0, 0,     /* presence of floppy drives #0 - #3 */
> -        cpu_to_le32(2)  /* tape presence (2 =3D=3D never present) */
> -    };
> -
> -    dev =3D aml_device("FDC0");
> -    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0700")));
> -
> -    crs =3D aml_resource_template();
> -    aml_append(crs, aml_io(AML_DECODE16, 0x03F2, 0x03F2, 0x00, 0x04));
> -    aml_append(crs, aml_io(AML_DECODE16, 0x03F7, 0x03F7, 0x00, 0x01));
> -    aml_append(crs, aml_irq_no_flags(6));
> -    aml_append(crs,
> -        aml_dma(AML_COMPATIBILITY, AML_NOTBUSMASTER, AML_TRANSFER8, 2));
> -    aml_append(dev, aml_name_decl("_CRS", crs));
> -
> -    for (i =3D 0; i < MIN(MAX_FD, ACPI_FDE_MAX_FD); i++) {
> -        FloppyDriveType type =3D isa_fdc_get_drive_type(fdc, i);
> -
> -        if (type < FLOPPY_DRIVE_TYPE_NONE) {
> -            fde_buf[i] =3D cpu_to_le32(1);  /* drive present */
> -            aml_append(dev, build_fdinfo_aml(i, type));
> -        }
> -    }
> -    aml_append(dev, aml_name_decl("_FDE",
> -               aml_buffer(sizeof(fde_buf), (uint8_t *)fde_buf)));
> -
> -    return dev;
> -}
> -
>   static Aml *build_kbd_device_aml(void)
>   {
>       Aml *dev;
> @@ -1175,7 +1096,6 @@ static Aml *build_mouse_device_aml(void)
>  =20
>   static void build_isa_devices_aml(Aml *table)
>   {
> -    ISADevice *fdc =3D pc_find_fdc0();
>       bool ambiguous;
>  =20
>       Aml *scope =3D aml_scope("_SB.PCI0.ISA");
> @@ -1183,9 +1103,6 @@ static void build_isa_devices_aml(Aml *table)
>  =20
>       aml_append(scope, build_kbd_device_aml());
>       aml_append(scope, build_mouse_device_aml());
> -    if (fdc) {
> -        aml_append(scope, build_fdc_device_aml(fdc));
> -    }
>  =20
>       if (ambiguous) {
>           error_report("Multiple ISA busses, unable to define IPMI ACPI d=
ata");
> diff --git a/stubs/cmos.c b/stubs/cmos.c
> new file mode 100644
> index 000000000000..416cbe4055ff
> --- /dev/null
> +++ b/stubs/cmos.c
> @@ -0,0 +1,7 @@
> +#include "qemu/osdep.h"
> +#include "hw/i386/pc.h"
> +
> +int cmos_get_fd_drive_type(FloppyDriveType fd0)
> +{
> +    return 0;
> +}
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index 45be5dc0ed78..3cbe472d1c6c 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -3,6 +3,7 @@ stub-obj-y +=3D bdrv-next-monitor-owned.o
>   stub-obj-y +=3D blk-commit-all.o
>   stub-obj-y +=3D blockdev-close-all-bdrv-states.o
>   stub-obj-y +=3D clock-warp.o
> +stub-obj-y +=3D cmos.o
>   stub-obj-y +=3D cpu-get-clock.o
>   stub-obj-y +=3D cpu-get-icount.o
>   stub-obj-y +=3D dump.o
>=20


