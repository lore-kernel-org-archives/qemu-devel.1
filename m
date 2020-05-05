Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F15C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:55:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 630F9206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hauF3g6e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 630F9206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVy2u-0003ft-Hj
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVxuB-0006NX-Vr
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:46:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28264
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVxuB-0006Qd-4w
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588686398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NRdUDTUqrv/FakJyQyPpWnykUjnXB3VV5e1sK88fLjU=;
 b=hauF3g6eTC6ZIvqNirAwxpTvEpsJHPuiOgQVwPsDgihoJxXEhK1DB3i5QmFwyyhrrpT6nf
 x0KutOngcup/6vexWBjeV+iJxkgTtK12TpigqpXimoE9Tvjt+bim5a0Eqn2Ldssu9mZjZf
 VA9tQzRCSx6P7xFBjQzzfV1byM93XD4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-7oU-l9egMsKUTEEDzU5u0g-1; Tue, 05 May 2020 09:46:35 -0400
X-MC-Unique: 7oU-l9egMsKUTEEDzU5u0g-1
Received: by mail-wm1-f72.google.com with SMTP id h184so1064298wmf.5
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 06:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NRdUDTUqrv/FakJyQyPpWnykUjnXB3VV5e1sK88fLjU=;
 b=EwC5t7yC1T6Y2pBcSMzObX8ZWZu4Xk8GsRGcpoWiRa3PvcI3xEtiepgMEDw+/Z5uu2
 gt2sVeDIJ/GgUNFHnX2s3VUIDfX66kqHJNIgq18Agi82qs7QjLjztcwMCoYUBQ2kWt4U
 pEkB2jso7tEiD7iMUF24zAEEJqk2/JpflNjg4hwDHcws5Wqj8DHkh3vAqw7feIog9GQy
 mx0mzafOB2iGGrdHNxJaeBnFPMNwyzlXqe7U0gctKtibGfrd/AHkOod9fTdtgvLhJcOh
 4DAjHEX+xMgYE9/Xp5MlQodZIE5tSrlVe/lD8U6ex2LyXCoXrgZ2L4GezUlWzfSUGsIT
 NXrA==
X-Gm-Message-State: AGi0PubUHIT4Rm4KkmzdHYrf3e6GNtlOaknCuKfodDQ5HtKvtoRJIEB6
 MGUzBZvREAC29rerfHc4U7FxNYIVubKmV2WhzrUDey9ZVO7IrJHKhe9NdZKF6bfTmAdMW4H9GTx
 uIeAWJVr5U62R1as=
X-Received: by 2002:a05:600c:258:: with SMTP id
 24mr3375797wmj.73.1588686394404; 
 Tue, 05 May 2020 06:46:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypKviItduxIXtx2oMmY+E6/mZ0owqXYoO2vOnuOtJGW0EqcsVlWSpbLcs60Rb4k1IqI4vqIs0w==
X-Received: by 2002:a05:600c:258:: with SMTP id
 24mr3375769wmj.73.1588686394177; 
 Tue, 05 May 2020 06:46:34 -0700 (PDT)
Received: from [192.168.1.38] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id z11sm3339818wro.48.2020.05.05.06.46.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 06:46:33 -0700 (PDT)
Subject: Re: [PATCH v4 05/13] acpi: move aml builder code for serial device
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200505113843.22012-1-kraxel@redhat.com>
 <20200505113843.22012-6-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0ce5e3f6-1560-9506-b51c-ca3bc038efb1@redhat.com>
Date: Tue, 5 May 2020 15:46:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200505113843.22012-6-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 03:48:16
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
 Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/5/20 1:38 PM, Gerd Hoffmann wrote:
> The code uses the isa_serial_io array to figure what the device uid is.
> Side effect is that acpi antries are not limited to port 1+2 any more,
> we'll also get entries for ports 3+4.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   hw/char/serial-isa.c | 32 ++++++++++++++++++++++++++++++++
>   hw/i386/acpi-build.c | 32 --------------------------------
>   2 files changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
> index f9b6eed7833d..f7c19a398ced 100644
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
> @@ -81,6 +82,35 @@ static void serial_isa_realizefn(DeviceState *dev, Error **errp)
>       isa_register_ioport(isadev, &s->io, isa->iobase);
>   }
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

Similarly to the parallel device patch, I'd use "uid = isa->index + 1" 
instead.

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
>   static const VMStateDescription vmstate_isa_serial = {
>       .name = "serial",
>       .version_id = 3,
> @@ -103,9 +133,11 @@ static Property serial_isa_properties[] = {
>   static void serial_isa_class_initfn(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> +    ISADeviceClass *isa = ISA_DEVICE_CLASS(klass);
>   
>       dc->realize = serial_isa_realizefn;
>       dc->vmsd = &vmstate_isa_serial;
> +    isa->build_aml = serial_isa_build_aml;
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
>   static void build_isa_devices_aml(Aml *table)
>   {
>       ISADevice *fdc = pc_find_fdc0();
> @@ -1252,8 +1222,6 @@ static void build_isa_devices_aml(Aml *table)
>           aml_append(scope, build_fdc_device_aml(fdc));
>       }
>       aml_append(scope, build_lpt_device_aml());
> -    build_com_device_aml(scope, 1);
> -    build_com_device_aml(scope, 2);
>   
>       if (ambiguous) {
>           error_report("Multiple ISA busses, unable to define IPMI ACPI data");
> 


