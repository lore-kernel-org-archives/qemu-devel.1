Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44848C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 13:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 102972073A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 13:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IH0vssel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102972073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWh0g-0006mw-3z
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 09:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWgxq-0001zN-OF
 for qemu-devel@nongnu.org; Thu, 07 May 2020 09:53:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43619
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWgxp-0003yM-VI
 for qemu-devel@nongnu.org; Thu, 07 May 2020 09:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588859604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e8gNxRdoO7T7Jh9XsKdugx/FZO/g8FJ3Zbk8I++SmJk=;
 b=IH0vsselSbmJJPy3SENeu6GwxStcGBjUGUJXRK6sx9+NBeUR6dick583iRMW2DSK/hTIcx
 IhnP+eJvIc8ftIm+3jO/TwIhji9z/OFP1rbwUhViGi7oUvRoghPJIU2P+G0SdX/Jjx/s/H
 PkWW6ar5adb48B0uPh5kxxlziSbaiNM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-zjbmNobfO7uA4lLtuVmx3Q-1; Thu, 07 May 2020 09:53:20 -0400
X-MC-Unique: zjbmNobfO7uA4lLtuVmx3Q-1
Received: by mail-wm1-f72.google.com with SMTP id a206so372067wmh.6
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 06:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oGhvpbKRRF12rPLBlUaWRAJu5Zn5LwTdeQhQdoMKA7Y=;
 b=T3rgjBYYEcSmhxaV4FR1txHPkJ9LuvPrtZgPYdmBvwV8mJlT1/d+hTDzieJTNgShDl
 bhKyCn43HBopfON2HM0fCL6F9d2XfUwoCTbBMCkOW7cOW8W4Lc60FuQd5+bOp9saPO+Y
 bg9NXY1F47bVS+Br2UYqaos6g9nxkFoq4VtOpDfOUuxMweCtxQpR7FKdSV56rBDzNfn4
 WFG+F16/pxgbjn3rBKg7kdSKmPdv3hm0T3G/t1OME/X56vvtWNy6eCY/DGEwUuWRzBxA
 4RZmLT9MActfV1CnjKOfEGc0imTqt9vnUvPQ17ulfguZDRK9sk3wKN/avRb+iat1W81s
 3DFA==
X-Gm-Message-State: AGi0PubeDFBxBl6OyfCUhzdSmFEF/npuoqXvHzMnOEky7PWHkZyr/w5K
 v21bh74z+AAjlJ6UfWrEN3YH9r8m/aiOy5PW3ayi8QV/vu3gYOnN/0Xy/u5O/Drv1l2SSR6VUVl
 RJQ2s/Il2NfAwu5U=
X-Received: by 2002:adf:e28c:: with SMTP id v12mr17561604wri.157.1588859598948; 
 Thu, 07 May 2020 06:53:18 -0700 (PDT)
X-Google-Smtp-Source: APiQypLs3UUgz62xquy70CAaGxyZ83eD6WbwuK2+WAQF6WyDB7dWt4n+ie9uEbm58tLZVZ4P6RM+7w==
X-Received: by 2002:adf:e28c:: with SMTP id v12mr17561568wri.157.1588859598691; 
 Thu, 07 May 2020 06:53:18 -0700 (PDT)
Received: from [192.168.1.39] (248.red-88-21-203.staticip.rima-tde.net.
 [88.21.203.248])
 by smtp.gmail.com with ESMTPSA id q74sm587281wme.14.2020.05.07.06.53.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2020 06:53:18 -0700 (PDT)
Subject: Re: [PATCH v5 05/15] acpi: move aml builder code for serial device
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200507131640.14041-1-kraxel@redhat.com>
 <20200507131640.14041-6-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9776cfdf-f3d2-57d6-69e0-ae16380d6fea@redhat.com>
Date: Thu, 7 May 2020 15:53:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200507131640.14041-6-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 00:55:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/20 3:16 PM, Gerd Hoffmann wrote:
> The code uses the isa_serial_io array to figure what the device uid is.
> Side effect is that acpi antries are not limited to port 1+2 any more,
> we'll also get entries for ports 3+4.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/char/serial-isa.c | 22 ++++++++++++++++++++++
>   hw/i386/acpi-build.c | 32 --------------------------------
>   2 files changed, 22 insertions(+), 32 deletions(-)
>=20
> diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
> index f9b6eed7833d..165e320e65f0 100644
> --- a/hw/char/serial-isa.c
> +++ b/hw/char/serial-isa.c
> @@ -27,6 +27,7 @@
>   #include "qapi/error.h"
>   #include "qemu/module.h"
>   #include "sysemu/sysemu.h"
> +#include "hw/acpi/aml-build.h"
>   #include "hw/char/serial.h"
>   #include "hw/isa/isa.h"
>   #include "hw/qdev-properties.h"
> @@ -81,6 +82,25 @@ static void serial_isa_realizefn(DeviceState *dev, Err=
or **errp)
>       isa_register_ioport(isadev, &s->io, isa->iobase);
>   }
>  =20
> +static void serial_isa_build_aml(ISADevice *isadev, Aml *scope)
> +{
> +    ISASerialState *isa =3D ISA_SERIAL(isadev);
> +    Aml *dev;
> +    Aml *crs;
> +
> +    crs =3D aml_resource_template();
> +    aml_append(crs, aml_io(AML_DECODE16, isa->iobase, isa->iobase, 0x00,=
 0x08));
> +    aml_append(crs, aml_irq_no_flags(isa->isairq));
> +
> +    dev =3D aml_device("COM%d", isa->index + 1);
> +    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0501")));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(isa->index + 1)));
> +    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +
> +    aml_append(scope, dev);
> +}
> +
>   static const VMStateDescription vmstate_isa_serial =3D {
>       .name =3D "serial",
>       .version_id =3D 3,
> @@ -103,9 +123,11 @@ static Property serial_isa_properties[] =3D {
>   static void serial_isa_class_initfn(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    ISADeviceClass *isa =3D ISA_DEVICE_CLASS(klass);
>  =20
>       dc->realize =3D serial_isa_realizefn;
>       dc->vmsd =3D &vmstate_isa_serial;
> +    isa->build_aml =3D serial_isa_build_aml;
>       device_class_set_props(dc, serial_isa_properties);
>       set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>   }
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 3a82730a0d19..0e6a5151f4c3 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1208,36 +1208,6 @@ static Aml *build_lpt_device_aml(void)
>       return dev;
>   }
>  =20
> -static void build_com_device_aml(Aml *scope, uint8_t uid)
> -{
> -    Aml *dev;
> -    Aml *crs;
> -    uint8_t irq =3D 4;
> -    uint16_t io_port =3D 0x03F8;
> -
> -    assert(uid =3D=3D 1 || uid =3D=3D 2);
> -    if (uid =3D=3D 2) {
> -        irq =3D 3;
> -        io_port =3D 0x02F8;
> -    }
> -    if (!memory_region_present(get_system_io(), io_port)) {
> -        return;
> -    }
> -
> -    dev =3D aml_device("COM%d", uid);
> -    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0501")));
> -    aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
> -
> -    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
> -
> -    crs =3D aml_resource_template();
> -    aml_append(crs, aml_io(AML_DECODE16, io_port, io_port, 0x00, 0x08));
> -    aml_append(crs, aml_irq_no_flags(irq));
> -    aml_append(dev, aml_name_decl("_CRS", crs));
> -
> -    aml_append(scope, dev);
> -}
> -
>   static void build_isa_devices_aml(Aml *table)
>   {
>       ISADevice *fdc =3D pc_find_fdc0();
> @@ -1252,8 +1222,6 @@ static void build_isa_devices_aml(Aml *table)
>           aml_append(scope, build_fdc_device_aml(fdc));
>       }
>       aml_append(scope, build_lpt_device_aml());
> -    build_com_device_aml(scope, 1);
> -    build_com_device_aml(scope, 2);
>  =20
>       if (ambiguous) {
>           error_report("Multiple ISA busses, unable to define IPMI ACPI d=
ata");
>=20


