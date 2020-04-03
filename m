Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4ACFC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 10:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FA6320757
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 10:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWJGVutd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA6320757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKJIN-0006k0-LP
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 06:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34816)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jKJHe-0005tI-Nz
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:10:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jKJHd-0001r9-EJ
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:10:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28437
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jKJHd-0001qd-AE
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585908640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aTFcm2tkqLnu3edypMnCFLzZ2fPDmD6TkPeu8Zyy1Kw=;
 b=KWJGVutdhJwAxmF0jyr6SX3VEGCHOev0PP7UWYXt1ck/69Qbef5fG+7Nsp04va/YiDURfX
 TLDWyd1N+iNHDT5fP0DmmeSCo1wlkcgjSUtfvT4wH4TnArhJ9lQ1nbyyPrdIQCNfLK1XJi
 YxXU1ghCisPi4Cep4uY98KAceOW7xJw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1--Muycbj1PQGK4cUnNuD6Mw-1; Fri, 03 Apr 2020 06:10:38 -0400
X-MC-Unique: -Muycbj1PQGK4cUnNuD6Mw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71E3B800D5C;
 Fri,  3 Apr 2020 10:10:37 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 57AAB1147D7;
 Fri,  3 Apr 2020 10:10:25 +0000 (UTC)
Date: Fri, 3 Apr 2020 12:10:23 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 08/12] acpi: move aml builder code for serial device
Message-ID: <20200403121023.11aa023d@redhat.com>
In-Reply-To: <20200403080502.8154-9-kraxel@redhat.com>
References: <20200403080502.8154-1-kraxel@redhat.com>
 <20200403080502.8154-9-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFy?= =?UTF-8?B?Yy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri,  3 Apr 2020 10:04:58 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> The code uses the isa_serial_io array to figure what the device uid is.
> Side effect is that acpi antries are not limited to port 1+2 any more,
> we'll also get entries for ports 3+4.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/char/serial-isa.c | 32 ++++++++++++++++++++++++++++++++
>  hw/i386/acpi-build.c | 32 --------------------------------
>  2 files changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
> index f9b6eed7833d..f7c19a398ced 100644
> --- a/hw/char/serial-isa.c
> +++ b/hw/char/serial-isa.c
> @@ -27,6 +27,7 @@
>  #include "qapi/error.h"
>  #include "qemu/module.h"
>  #include "sysemu/sysemu.h"
> +#include "hw/acpi/aml-build.h"
>  #include "hw/char/serial.h"
>  #include "hw/isa/isa.h"
>  #include "hw/qdev-properties.h"
> @@ -81,6 +82,35 @@ static void serial_isa_realizefn(DeviceState *dev, Error **errp)
>      isa_register_ioport(isadev, &s->io, isa->iobase);
>  }
>  
> +static void serial_isa_build_aml(ISADevice *isadev, Aml *scope)
> +{
> +    ISASerialState *isa = ISA_SERIAL(isadev);
> +    int i, uid = 0;
> +    Aml *dev;
> +    Aml *crs;
> +
> +    for (i = 0; i < ARRAY_SIZE(isa_serial_io); i++) {
> +        if (isa->iobase == isa_serial_io[i]) {
> +            uid = i + 1;
> +        }
> +    }
> +    if (!uid) {
> +        return;
> +    }
> +
> +    crs = aml_resource_template();
> +    aml_append(crs, aml_io(AML_DECODE16, isa->iobase, isa->iobase, 0x00, 0x08));
> +    aml_append(crs, aml_irq_no_flags(isa->isairq));
> +
> +    dev = aml_device("COM%d", uid);
> +    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0501")));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
> +    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +
> +    aml_append(scope, dev);
> +}
> +
>  static const VMStateDescription vmstate_isa_serial = {
>      .name = "serial",
>      .version_id = 3,
> @@ -103,9 +133,11 @@ static Property serial_isa_properties[] = {
>  static void serial_isa_class_initfn(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> +    ISADeviceClass *isa = ISA_DEVICE_CLASS(klass);
>  
>      dc->realize = serial_isa_realizefn;
>      dc->vmsd = &vmstate_isa_serial;
> +    isa->build_aml = serial_isa_build_aml;
>      device_class_set_props(dc, serial_isa_properties);
>      set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>  }
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index a5bc7764e611..81805bf85f8d 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1189,36 +1189,6 @@ static void build_lpt_device_aml(Aml *scope)
>      aml_append(scope, dev);
>  }
>  
> -static void build_com_device_aml(Aml *scope, uint8_t uid)
> -{
> -    Aml *dev;
> -    Aml *crs;
> -    uint8_t irq = 4;
> -    uint16_t io_port = 0x03F8;
> -
> -    assert(uid == 1 || uid == 2);
> -    if (uid == 2) {
> -        irq = 3;
> -        io_port = 0x02F8;
> -    }
> -    if (!memory_region_present(get_system_io(), io_port)) {
> -        return;
> -    }
> -
> -    dev = aml_device("COM%d", uid);
> -    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0501")));
> -    aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
> -
> -    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
> -
> -    crs = aml_resource_template();
> -    aml_append(crs, aml_io(AML_DECODE16, io_port, io_port, 0x00, 0x08));
> -    aml_append(crs, aml_irq_no_flags(irq));
> -    aml_append(dev, aml_name_decl("_CRS", crs));
> -
> -    aml_append(scope, dev);
> -}
> -
>  static void build_isa_devices_aml(Aml *table)
>  {
>      ISADevice *fdc = pc_find_fdc0();
> @@ -1233,8 +1203,6 @@ static void build_isa_devices_aml(Aml *table)
>          aml_append(scope, build_fdc_device_aml(fdc));
>      }
>      build_lpt_device_aml(scope);
> -    build_com_device_aml(scope, 1);
> -    build_com_device_aml(scope, 2);
>  
>      if (ambiguous) {
>          error_report("Multiple ISA busses, unable to define IPMI ACPI data");


