Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08A0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A04772076A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmtL+Ctu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04772076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZbhL-0005w5-RP
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 10:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZbca-0007zW-B5
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:47:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33471
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZbcZ-0001Yc-8I
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589554050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d3Qv84ZWmqRvwTBDXZ7C35cLjZDqrtNRUlv0KJPkTFw=;
 b=PmtL+CtuTtdm7WKVRrChxck0o61QdPoZKpjfEPJYS8vz+JVZB9XFtnr8XHHNLO18sXbevz
 kJQjijuU5R/bMKYzfxqJLYvrv5NAX3compta+VZeBL+ixnI7ufjxNUAKOddwaqfv+7e6Dy
 7C6TnU1bEPF/8LMvj7MFgATk/orR38g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-wuCw1eoRNkey7QYD2HKkSA-1; Fri, 15 May 2020 10:47:26 -0400
X-MC-Unique: wuCw1eoRNkey7QYD2HKkSA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F41FDC26;
 Fri, 15 May 2020 14:47:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-145.ams2.redhat.com
 [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46D755C6BD;
 Fri, 15 May 2020 14:47:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 85A2B9D54; Fri, 15 May 2020 16:47:18 +0200 (CEST)
Date: Fri, 15 May 2020 16:47:18 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v5 08/15] acpi: move aml builder code for floppy device
Message-ID: <20200515144718.3m3b4onutdazpaah@sirius.home.kraxel.org>
References: <20200507131640.14041-1-kraxel@redhat.com>
 <20200507131640.14041-9-kraxel@redhat.com>
 <2f7a76fe-9c38-1441-70cf-919dce82e4fe@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2f7a76fe-9c38-1441-70cf-919dce82e4fe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > +#include "hw/i386/pc.h"
> 
> I'd rather not see this target-specific header used in the generic device
> model... The culprit seems cmos_get_fd_drive_type(). Is the value really PC
> specific?

Given that the same value is used in acpi tables probably not really.
cmos_get_fd_drive_type() hasn't any dependency on pc or cmos btw, we
can simply move over the function to floppy.

> 
> Hervé, do you know if such info & RTC nvram layout is used in other arch?
> 
> > +#include "hw/acpi/aml-build.h"
> >   #include "hw/irq.h"
> >   #include "hw/isa/isa.h"
> >   #include "hw/qdev-properties.h"
> > @@ -2765,6 +2767,85 @@ void isa_fdc_get_drive_max_chs(FloppyDriveType type,
> >       (*maxc)--;
> >   }
> > +static Aml *build_fdinfo_aml(int idx, FloppyDriveType type)
> > +{
> > +    Aml *dev, *fdi;
> > +    uint8_t maxc, maxh, maxs;
> > +
> > +    isa_fdc_get_drive_max_chs(type, &maxc, &maxh, &maxs);
> > +
> > +    dev = aml_device("FLP%c", 'A' + idx);
> > +
> > +    aml_append(dev, aml_name_decl("_ADR", aml_int(idx)));
> > +
> > +    fdi = aml_package(16);
> > +    aml_append(fdi, aml_int(idx));  /* Drive Number */
> > +    aml_append(fdi,
> > +        aml_int(cmos_get_fd_drive_type(type)));  /* Device Type */
> > +    /*
> > +     * the values below are the limits of the drive, and are thus independent
> > +     * of the inserted media
> > +     */
> > +    aml_append(fdi, aml_int(maxc));  /* Maximum Cylinder Number */
> > +    aml_append(fdi, aml_int(maxs));  /* Maximum Sector Number */
> > +    aml_append(fdi, aml_int(maxh));  /* Maximum Head Number */
> > +    /*
> > +     * SeaBIOS returns the below values for int 0x13 func 0x08 regardless of
> > +     * the drive type, so shall we
> > +     */
> > +    aml_append(fdi, aml_int(0xAF));  /* disk_specify_1 */
> > +    aml_append(fdi, aml_int(0x02));  /* disk_specify_2 */
> > +    aml_append(fdi, aml_int(0x25));  /* disk_motor_wait */
> > +    aml_append(fdi, aml_int(0x02));  /* disk_sector_siz */
> > +    aml_append(fdi, aml_int(0x12));  /* disk_eot */
> > +    aml_append(fdi, aml_int(0x1B));  /* disk_rw_gap */
> > +    aml_append(fdi, aml_int(0xFF));  /* disk_dtl */
> > +    aml_append(fdi, aml_int(0x6C));  /* disk_formt_gap */
> > +    aml_append(fdi, aml_int(0xF6));  /* disk_fill */
> > +    aml_append(fdi, aml_int(0x0F));  /* disk_head_sttl */
> > +    aml_append(fdi, aml_int(0x08));  /* disk_motor_strt */
> > +
> > +    aml_append(dev, aml_name_decl("_FDI", fdi));
> > +    return dev;
> > +}
> > +
> > +static void fdc_isa_build_aml(ISADevice *isadev, Aml *scope)
> > +{
> > +    Aml *dev;
> > +    Aml *crs;
> > +    int i;
> > +
> > +#define ACPI_FDE_MAX_FD 4
> > +    uint32_t fde_buf[5] = {
> > +        0, 0, 0, 0,     /* presence of floppy drives #0 - #3 */
> > +        cpu_to_le32(2)  /* tape presence (2 == never present) */
> > +    };
> > +
> > +    crs = aml_resource_template();
> > +    aml_append(crs, aml_io(AML_DECODE16, 0x03F2, 0x03F2, 0x00, 0x04));
> > +    aml_append(crs, aml_io(AML_DECODE16, 0x03F7, 0x03F7, 0x00, 0x01));
> > +    aml_append(crs, aml_irq_no_flags(6));
> > +    aml_append(crs,
> > +        aml_dma(AML_COMPATIBILITY, AML_NOTBUSMASTER, AML_TRANSFER8, 2));
> > +
> > +    dev = aml_device("FDC0");
> > +    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0700")));
> > +    aml_append(dev, aml_name_decl("_CRS", crs));
> > +
> > +    for (i = 0; i < MIN(MAX_FD, ACPI_FDE_MAX_FD); i++) {
> > +        FloppyDriveType type = isa_fdc_get_drive_type(isadev, i);
> > +
> > +        if (type < FLOPPY_DRIVE_TYPE_NONE) {
> > +            fde_buf[i] = cpu_to_le32(1);  /* drive present */
> > +            aml_append(dev, build_fdinfo_aml(i, type));
> > +        }
> > +    }
> > +    aml_append(dev, aml_name_decl("_FDE",
> > +               aml_buffer(sizeof(fde_buf), (uint8_t *)fde_buf)));
> > +
> > +    aml_append(scope, dev);
> > +}
> > +
> >   static const VMStateDescription vmstate_isa_fdc ={
> >       .name = "fdc",
> >       .version_id = 2,
> > @@ -2798,11 +2879,13 @@ static Property isa_fdc_properties[] = {
> >   static void isabus_fdc_class_init(ObjectClass *klass, void *data)
> >   {
> >       DeviceClass *dc = DEVICE_CLASS(klass);
> > +    ISADeviceClass *isa = ISA_DEVICE_CLASS(klass);
> >       dc->realize = isabus_fdc_realize;
> >       dc->fw_name = "fdc";
> >       dc->reset = fdctrl_external_reset_isa;
> >       dc->vmsd = &vmstate_isa_fdc;
> > +    isa->build_aml = fdc_isa_build_aml;
> >       device_class_set_props(dc, isa_fdc_properties);
> >       set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> >   }
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index 443db94deb5b..775936e28b9a 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -1058,85 +1058,6 @@ static void build_hpet_aml(Aml *table)
> >       aml_append(table, scope);
> >   }
> > -static Aml *build_fdinfo_aml(int idx, FloppyDriveType type)
> > -{
> > -    Aml *dev, *fdi;
> > -    uint8_t maxc, maxh, maxs;
> > -
> > -    isa_fdc_get_drive_max_chs(type, &maxc, &maxh, &maxs);
> > -
> > -    dev = aml_device("FLP%c", 'A' + idx);
> > -
> > -    aml_append(dev, aml_name_decl("_ADR", aml_int(idx)));
> > -
> > -    fdi = aml_package(16);
> > -    aml_append(fdi, aml_int(idx));  /* Drive Number */
> > -    aml_append(fdi,
> > -        aml_int(cmos_get_fd_drive_type(type)));  /* Device Type */
> > -    /*
> > -     * the values below are the limits of the drive, and are thus independent
> > -     * of the inserted media
> > -     */
> > -    aml_append(fdi, aml_int(maxc));  /* Maximum Cylinder Number */
> > -    aml_append(fdi, aml_int(maxs));  /* Maximum Sector Number */
> > -    aml_append(fdi, aml_int(maxh));  /* Maximum Head Number */
> > -    /*
> > -     * SeaBIOS returns the below values for int 0x13 func 0x08 regardless of
> > -     * the drive type, so shall we
> > -     */
> > -    aml_append(fdi, aml_int(0xAF));  /* disk_specify_1 */
> > -    aml_append(fdi, aml_int(0x02));  /* disk_specify_2 */
> > -    aml_append(fdi, aml_int(0x25));  /* disk_motor_wait */
> > -    aml_append(fdi, aml_int(0x02));  /* disk_sector_siz */
> > -    aml_append(fdi, aml_int(0x12));  /* disk_eot */
> > -    aml_append(fdi, aml_int(0x1B));  /* disk_rw_gap */
> > -    aml_append(fdi, aml_int(0xFF));  /* disk_dtl */
> > -    aml_append(fdi, aml_int(0x6C));  /* disk_formt_gap */
> > -    aml_append(fdi, aml_int(0xF6));  /* disk_fill */
> > -    aml_append(fdi, aml_int(0x0F));  /* disk_head_sttl */
> > -    aml_append(fdi, aml_int(0x08));  /* disk_motor_strt */
> > -
> > -    aml_append(dev, aml_name_decl("_FDI", fdi));
> > -    return dev;
> > -}
> > -
> > -static Aml *build_fdc_device_aml(ISADevice *fdc)
> > -{
> > -    int i;
> > -    Aml *dev;
> > -    Aml *crs;
> > -
> > -#define ACPI_FDE_MAX_FD 4
> > -    uint32_t fde_buf[5] = {
> > -        0, 0, 0, 0,     /* presence of floppy drives #0 - #3 */
> > -        cpu_to_le32(2)  /* tape presence (2 == never present) */
> > -    };
> > -
> > -    dev = aml_device("FDC0");
> > -    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0700")));
> > -
> > -    crs = aml_resource_template();
> > -    aml_append(crs, aml_io(AML_DECODE16, 0x03F2, 0x03F2, 0x00, 0x04));
> > -    aml_append(crs, aml_io(AML_DECODE16, 0x03F7, 0x03F7, 0x00, 0x01));
> > -    aml_append(crs, aml_irq_no_flags(6));
> > -    aml_append(crs,
> > -        aml_dma(AML_COMPATIBILITY, AML_NOTBUSMASTER, AML_TRANSFER8, 2));
> > -    aml_append(dev, aml_name_decl("_CRS", crs));
> > -
> > -    for (i = 0; i < MIN(MAX_FD, ACPI_FDE_MAX_FD); i++) {
> > -        FloppyDriveType type = isa_fdc_get_drive_type(fdc, i);
> > -
> > -        if (type < FLOPPY_DRIVE_TYPE_NONE) {
> > -            fde_buf[i] = cpu_to_le32(1);  /* drive present */
> > -            aml_append(dev, build_fdinfo_aml(i, type));
> > -        }
> > -    }
> > -    aml_append(dev, aml_name_decl("_FDE",
> > -               aml_buffer(sizeof(fde_buf), (uint8_t *)fde_buf)));
> > -
> > -    return dev;
> > -}
> > -
> >   static Aml *build_kbd_device_aml(void)
> >   {
> >       Aml *dev;
> > @@ -1175,7 +1096,6 @@ static Aml *build_mouse_device_aml(void)
> >   static void build_isa_devices_aml(Aml *table)
> >   {
> > -    ISADevice *fdc = pc_find_fdc0();
> >       bool ambiguous;
> >       Aml *scope = aml_scope("_SB.PCI0.ISA");
> > @@ -1183,9 +1103,6 @@ static void build_isa_devices_aml(Aml *table)
> >       aml_append(scope, build_kbd_device_aml());
> >       aml_append(scope, build_mouse_device_aml());
> > -    if (fdc) {
> > -        aml_append(scope, build_fdc_device_aml(fdc));
> > -    }
> >       if (ambiguous) {
> >           error_report("Multiple ISA busses, unable to define IPMI ACPI data");
> > diff --git a/stubs/cmos.c b/stubs/cmos.c
> > new file mode 100644
> > index 000000000000..416cbe4055ff
> > --- /dev/null
> > +++ b/stubs/cmos.c
> > @@ -0,0 +1,7 @@
> > +#include "qemu/osdep.h"
> > +#include "hw/i386/pc.h"
> > +
> > +int cmos_get_fd_drive_type(FloppyDriveType fd0)
> > +{
> > +    return 0;
> > +}
> > diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> > index 45be5dc0ed78..3cbe472d1c6c 100644
> > --- a/stubs/Makefile.objs
> > +++ b/stubs/Makefile.objs
> > @@ -3,6 +3,7 @@ stub-obj-y += bdrv-next-monitor-owned.o
> >   stub-obj-y += blk-commit-all.o
> >   stub-obj-y += blockdev-close-all-bdrv-states.o
> >   stub-obj-y += clock-warp.o
> > +stub-obj-y += cmos.o
> >   stub-obj-y += cpu-get-clock.o
> >   stub-obj-y += cpu-get-icount.o
> >   stub-obj-y += dump.o
> > 
> 


