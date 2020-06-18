Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE6DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 20:08:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9626207E8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 20:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JtWKhddP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9626207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm0pU-0003XW-6Q
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 16:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jm0oi-0002hH-KZ
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 16:07:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27532
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jm0og-0000Zx-HZ
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 16:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592510837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QnDj69ofqgOt+NH3esMZpN2PpsFlNR2iaYLCvoqU7+c=;
 b=JtWKhddPn5IPYLTUtC3OzO5Jhbh/9Tj5zKd3waaeP3ggzEQDVkavfdMpMThDi2lxc0vG/m
 ApZ7qbp8kx7B+1xv0trLSWGMFLeQuBHcJuHyuHh5R3WZW2IrHPWAvJ0W9/7GW2LbXkhwN3
 zC8WUYmVaJoWJTHuMeCOjWD0H3HKKyg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-M7_5ALH3NkCbelSjWy8iiQ-1; Thu, 18 Jun 2020 16:07:16 -0400
X-MC-Unique: M7_5ALH3NkCbelSjWy8iiQ-1
Received: by mail-wr1-f71.google.com with SMTP id d6so3220978wrn.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 13:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QnDj69ofqgOt+NH3esMZpN2PpsFlNR2iaYLCvoqU7+c=;
 b=q2UNXTQPt3EMKpeajXxalUFRdIjOC1YahLIzJl8n3+C3ClkFKWT4ZBDIo+9QLklfzf
 SPiIce6B0owzH9VWkVvgampcAP6bN7s2aOl9Udh3AMnYchwzYyZTBUagxWwHD+k58iQs
 a7hcSps8ZFFqWYzZDGa4eFzTTlbvo++CVCRbKRGCIb4DEw3Anowkjf9giFY2/JkIhMhP
 n90GxvUFtYXBSNLFFxItBOxfURWYEBKK3dgxdgzm4n00R5ymC4MBMTe9bHgAx47zUoS8
 /G0/YjfaeXTjrq3C/5V54pAumqeFxVlh2z/EvGI5hPShsnbKPO3loffuAiZHx5OUWR40
 4+XA==
X-Gm-Message-State: AOAM533G4lCVX2S3PUbB7L9PTtL3lDiKTjUo3wv9qhFoF4VyjpuACtFP
 5wzX3AUm8gkGE/gcYTlHNwHec/Z4haOxMlT2LBI9oBiiPcesOVKZCedv3UX7c26CH2sM+mohj7a
 1dPH1xb6/ObOoHQc=
X-Received: by 2002:a5d:4d01:: with SMTP id z1mr194199wrt.29.1592510834701;
 Thu, 18 Jun 2020 13:07:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfEv1lkNULrVmc0sFCkunMseljbhz9vVk4RclgMXaeN+EkaMlhqp25TWM6o+4jQcO2MtM7Gw==
X-Received: by 2002:a5d:4d01:: with SMTP id z1mr194166wrt.29.1592510834333;
 Thu, 18 Jun 2020 13:07:14 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id b201sm4742087wmb.36.2020.06.18.13.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 13:07:13 -0700 (PDT)
Date: Thu, 18 Jun 2020 16:07:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v9 02/10] acpi: move aml builder code for floppy device
Message-ID: <20200618160642-mutt-send-email-mst@kernel.org>
References: <20200617071138.11159-1-kraxel@redhat.com>
 <20200617071138.11159-3-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200617071138.11159-3-kraxel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 15:08:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 17, 2020 at 09:11:30AM +0200, Gerd Hoffmann wrote:
> DSDT change: isa device order changes in case MI1 (ipmi) is present.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---

Pls follow process outlined at the top of tests/qtest/bios-tables-test.c
Don't change expected files with source.
Thanks!

>  hw/block/fdc.c                  |  83 ++++++++++++++++++++++++++++++++
>  hw/i386/acpi-build.c            |  83 --------------------------------
>  stubs/cmos.c                    |   7 +++
>  stubs/Makefile.objs             |   1 +
>  tests/data/acpi/pc/DSDT.ipmikcs | Bin 5086 -> 5086 bytes
>  5 files changed, 91 insertions(+), 83 deletions(-)
>  create mode 100644 stubs/cmos.c
> 
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index 8528b9a3c722..c92436772292 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -32,6 +32,8 @@
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "qemu/timer.h"
> +#include "hw/i386/pc.h"
> +#include "hw/acpi/aml-build.h"
>  #include "hw/irq.h"
>  #include "hw/isa/isa.h"
>  #include "hw/qdev-properties.h"
> @@ -2765,6 +2767,85 @@ void isa_fdc_get_drive_max_chs(FloppyDriveType type,
>      (*maxc)--;
>  }
>  
> +static Aml *build_fdinfo_aml(int idx, FloppyDriveType type)
> +{
> +    Aml *dev, *fdi;
> +    uint8_t maxc, maxh, maxs;
> +
> +    isa_fdc_get_drive_max_chs(type, &maxc, &maxh, &maxs);
> +
> +    dev = aml_device("FLP%c", 'A' + idx);
> +
> +    aml_append(dev, aml_name_decl("_ADR", aml_int(idx)));
> +
> +    fdi = aml_package(16);
> +    aml_append(fdi, aml_int(idx));  /* Drive Number */
> +    aml_append(fdi,
> +        aml_int(cmos_get_fd_drive_type(type)));  /* Device Type */
> +    /*
> +     * the values below are the limits of the drive, and are thus independent
> +     * of the inserted media
> +     */
> +    aml_append(fdi, aml_int(maxc));  /* Maximum Cylinder Number */
> +    aml_append(fdi, aml_int(maxs));  /* Maximum Sector Number */
> +    aml_append(fdi, aml_int(maxh));  /* Maximum Head Number */
> +    /*
> +     * SeaBIOS returns the below values for int 0x13 func 0x08 regardless of
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
> +    uint32_t fde_buf[5] = {
> +        0, 0, 0, 0,     /* presence of floppy drives #0 - #3 */
> +        cpu_to_le32(2)  /* tape presence (2 == never present) */
> +    };
> +
> +    crs = aml_resource_template();
> +    aml_append(crs, aml_io(AML_DECODE16, 0x03F2, 0x03F2, 0x00, 0x04));
> +    aml_append(crs, aml_io(AML_DECODE16, 0x03F7, 0x03F7, 0x00, 0x01));
> +    aml_append(crs, aml_irq_no_flags(6));
> +    aml_append(crs,
> +        aml_dma(AML_COMPATIBILITY, AML_NOTBUSMASTER, AML_TRANSFER8, 2));
> +
> +    dev = aml_device("FDC0");
> +    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0700")));
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +
> +    for (i = 0; i < MIN(MAX_FD, ACPI_FDE_MAX_FD); i++) {
> +        FloppyDriveType type = isa_fdc_get_drive_type(isadev, i);
> +
> +        if (type < FLOPPY_DRIVE_TYPE_NONE) {
> +            fde_buf[i] = cpu_to_le32(1);  /* drive present */
> +            aml_append(dev, build_fdinfo_aml(i, type));
> +        }
> +    }
> +    aml_append(dev, aml_name_decl("_FDE",
> +               aml_buffer(sizeof(fde_buf), (uint8_t *)fde_buf)));
> +
> +    aml_append(scope, dev);
> +}
> +
>  static const VMStateDescription vmstate_isa_fdc ={
>      .name = "fdc",
>      .version_id = 2,
> @@ -2798,11 +2879,13 @@ static Property isa_fdc_properties[] = {
>  static void isabus_fdc_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> +    ISADeviceClass *isa = ISA_DEVICE_CLASS(klass);
>  
>      dc->realize = isabus_fdc_realize;
>      dc->fw_name = "fdc";
>      dc->reset = fdctrl_external_reset_isa;
>      dc->vmsd = &vmstate_isa_fdc;
> +    isa->build_aml = fdc_isa_build_aml;
>      device_class_set_props(dc, isa_fdc_properties);
>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>  }
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 900f786d08de..45297d9a90e7 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -938,85 +938,6 @@ static void build_hpet_aml(Aml *table)
>      aml_append(table, scope);
>  }
>  
> -static Aml *build_fdinfo_aml(int idx, FloppyDriveType type)
> -{
> -    Aml *dev, *fdi;
> -    uint8_t maxc, maxh, maxs;
> -
> -    isa_fdc_get_drive_max_chs(type, &maxc, &maxh, &maxs);
> -
> -    dev = aml_device("FLP%c", 'A' + idx);
> -
> -    aml_append(dev, aml_name_decl("_ADR", aml_int(idx)));
> -
> -    fdi = aml_package(16);
> -    aml_append(fdi, aml_int(idx));  /* Drive Number */
> -    aml_append(fdi,
> -        aml_int(cmos_get_fd_drive_type(type)));  /* Device Type */
> -    /*
> -     * the values below are the limits of the drive, and are thus independent
> -     * of the inserted media
> -     */
> -    aml_append(fdi, aml_int(maxc));  /* Maximum Cylinder Number */
> -    aml_append(fdi, aml_int(maxs));  /* Maximum Sector Number */
> -    aml_append(fdi, aml_int(maxh));  /* Maximum Head Number */
> -    /*
> -     * SeaBIOS returns the below values for int 0x13 func 0x08 regardless of
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
> -    uint32_t fde_buf[5] = {
> -        0, 0, 0, 0,     /* presence of floppy drives #0 - #3 */
> -        cpu_to_le32(2)  /* tape presence (2 == never present) */
> -    };
> -
> -    dev = aml_device("FDC0");
> -    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0700")));
> -
> -    crs = aml_resource_template();
> -    aml_append(crs, aml_io(AML_DECODE16, 0x03F2, 0x03F2, 0x00, 0x04));
> -    aml_append(crs, aml_io(AML_DECODE16, 0x03F7, 0x03F7, 0x00, 0x01));
> -    aml_append(crs, aml_irq_no_flags(6));
> -    aml_append(crs,
> -        aml_dma(AML_COMPATIBILITY, AML_NOTBUSMASTER, AML_TRANSFER8, 2));
> -    aml_append(dev, aml_name_decl("_CRS", crs));
> -
> -    for (i = 0; i < MIN(MAX_FD, ACPI_FDE_MAX_FD); i++) {
> -        FloppyDriveType type = isa_fdc_get_drive_type(fdc, i);
> -
> -        if (type < FLOPPY_DRIVE_TYPE_NONE) {
> -            fde_buf[i] = cpu_to_le32(1);  /* drive present */
> -            aml_append(dev, build_fdinfo_aml(i, type));
> -        }
> -    }
> -    aml_append(dev, aml_name_decl("_FDE",
> -               aml_buffer(sizeof(fde_buf), (uint8_t *)fde_buf)));
> -
> -    return dev;
> -}
> -
>  static Aml *build_kbd_device_aml(void)
>  {
>      Aml *dev;
> @@ -1092,7 +1013,6 @@ static Aml *build_vmbus_device_aml(VMBusBridge *vmbus_bridge)
>  
>  static void build_isa_devices_aml(Aml *table)
>  {
> -    ISADevice *fdc = pc_find_fdc0();
>      VMBusBridge *vmbus_bridge = vmbus_bridge_find();
>      bool ambiguous;
>  
> @@ -1101,9 +1021,6 @@ static void build_isa_devices_aml(Aml *table)
>  
>      aml_append(scope, build_kbd_device_aml());
>      aml_append(scope, build_mouse_device_aml());
> -    if (fdc) {
> -        aml_append(scope, build_fdc_device_aml(fdc));
> -    }
>  
>      if (ambiguous) {
>          error_report("Multiple ISA busses, unable to define IPMI ACPI data");
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
> index 28e48171d1f3..f32b9e47a3d8 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -1,4 +1,5 @@
>  stub-obj-y += blk-commit-all.o
> +stub-obj-y += cmos.o
>  stub-obj-y += cpu-get-clock.o
>  stub-obj-y += cpu-get-icount.o
>  stub-obj-y += dump.o
> diff --git a/tests/data/acpi/pc/DSDT.ipmikcs b/tests/data/acpi/pc/DSDT.ipmikcs
> index 57b78358744a5bb13639ccddb887be2721240807..c285651131dc2ab8b0f32de750d7ac02a8b09936 100644
> GIT binary patch
> delta 20
> ccmcboeouV^E7Rl-CXdOiOwF4wF!2cj08$MG=l}o!
> 
> delta 20
> ccmcboeouV^E7N3Orsm14OdgvrF!2cj08ljstpET3
> 
> -- 
> 2.18.4


