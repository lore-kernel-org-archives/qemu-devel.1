Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F71C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:31:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EDCD206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDvjE+Yf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EDCD206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxfY-00046n-Bu
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVxcM-0000WK-Nn
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:28:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31568
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVxcM-0005d1-0i
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588685293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ZABntie5fPYHSBV5sCtGXx4aKG/F9THu4VCuuHW894=;
 b=iDvjE+YfITEA4CLCYlmyFBE790g/bsBpFfdUMYR6YdrFeXK7kppYHtZu8q9+h809dOUZ3z
 gjIIuguRdI3GhlxzJuenVFGYDv93ty7eZPzPSM6SSQOE+6xYBiweE8oY3t2b7nt9JDi06u
 3/nefW1BWeYVyk1bptN6cAmS8iCv32c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-oOz43C_1MZqZ0YY2WbHKwA-1; Tue, 05 May 2020 09:28:08 -0400
X-MC-Unique: oOz43C_1MZqZ0YY2WbHKwA-1
Received: by mail-wm1-f71.google.com with SMTP id d134so1277212wmd.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 06:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uFrdUu06rlFrHLgVhsseDuNTnwUSftOe1glG4ISY3R4=;
 b=aD/rc0MkqidQXAgStrq8O2YbrHkelWI43uUgg9AE/QqbaOKqtlwyAUIqXoyA1eZKut
 2blMJ7RpPnV33yPWcLI2enZ1NoRPNuY0UcpiqtSnX8Nq94H0paJAM0HDt4JfIjOU6N/c
 Xwz8T8gQRiKVIJmOqgn1aIQOhSOGf/KU+do+wDT2CWDrQkkCIl0RWDBfNRkxwOaEN022
 /azNU0NGx2C872zsAxaf/lLDy9tqGYq2FR2hE5V2Jvflb53qf+hQJ5f7f6gBUJ99zSJh
 uUigxsM/igG0QT00V2pIWSAJ6JcKLdcwXDNDWp+H1Ok/1J/sZsmCMOnHXtTnfPI73hvN
 BiEw==
X-Gm-Message-State: AGi0PuYa0Sf3q/0fasZC3tMt/BUGTJ1tXOddoqqkeIE1AySQ8bVWc79J
 WmaBcUt5YPKCek7lY9MtGwKmbiuHkeX5EznTBGpTL8J56Qp7WvPYtZZJNwfnjRrYheq42Lz/0b1
 cUxaGgqPs6ABxOCU=
X-Received: by 2002:a5d:4991:: with SMTP id r17mr4067293wrq.150.1588685287248; 
 Tue, 05 May 2020 06:28:07 -0700 (PDT)
X-Google-Smtp-Source: APiQypK7CkYrDaOjkv69KnwHW/JPK4ZGPGHYnFdjU6hFfcWLUviyXe54xvrsdKJpzTEEzfj8+XSTfg==
X-Received: by 2002:a5d:4991:: with SMTP id r17mr4067269wrq.150.1588685287059; 
 Tue, 05 May 2020 06:28:07 -0700 (PDT)
Received: from [192.168.1.38] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id i1sm3189135wrx.22.2020.05.05.06.28.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 06:28:06 -0700 (PDT)
Subject: Re: [PATCH v4 02/13] acpi: move aml builder code for rtc device
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200505113843.22012-1-kraxel@redhat.com>
 <20200505113843.22012-3-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <603c6c19-363b-9341-f129-432f9b92c75b@redhat.com>
Date: Tue, 5 May 2020 15:28:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200505113843.22012-3-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:38
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
 Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/5/20 1:38 PM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/i386/acpi-build.c | 17 -----------------
>   hw/rtc/mc146818rtc.c | 22 ++++++++++++++++++++++
>   2 files changed, 22 insertions(+), 17 deletions(-)
>=20
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 2e15f6848e7e..0bfa2dd23fcc 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1137,22 +1137,6 @@ static Aml *build_fdc_device_aml(ISADevice *fdc)
>       return dev;
>   }
>  =20
> -static Aml *build_rtc_device_aml(void)
> -{
> -    Aml *dev;
> -    Aml *crs;
> -
> -    dev =3D aml_device("RTC");
> -    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0B00")));
> -    crs =3D aml_resource_template();
> -    aml_append(crs, aml_io(AML_DECODE16, 0x0070, 0x0070, 0x10, 0x02));
> -    aml_append(crs, aml_irq_no_flags(8));
> -    aml_append(crs, aml_io(AML_DECODE16, 0x0072, 0x0072, 0x02, 0x06));
> -    aml_append(dev, aml_name_decl("_CRS", crs));
> -
> -    return dev;
> -}
> -
>   static Aml *build_kbd_device_aml(void)
>   {
>       Aml *dev;
> @@ -1278,7 +1262,6 @@ static void build_isa_devices_aml(Aml *table)
>       Aml *scope =3D aml_scope("_SB.PCI0.ISA");
>       Object *obj =3D object_resolve_path_type("", TYPE_ISA_BUS, &ambiguo=
us);
>  =20
> -    aml_append(scope, build_rtc_device_aml());
>       aml_append(scope, build_kbd_device_aml());
>       aml_append(scope, build_mouse_device_aml());
>       if (fdc) {
> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
> index d18c09911be2..2104e0aa3b14 100644
> --- a/hw/rtc/mc146818rtc.c
> +++ b/hw/rtc/mc146818rtc.c
> @@ -27,6 +27,7 @@
>   #include "qemu/cutils.h"
>   #include "qemu/module.h"
>   #include "qemu/bcd.h"
> +#include "hw/acpi/aml-build.h"
>   #include "hw/irq.h"
>   #include "hw/qdev-properties.h"
>   #include "qemu/timer.h"
> @@ -1007,13 +1008,34 @@ static void rtc_resetdev(DeviceState *d)
>       }
>   }
>  =20
> +static void rtc_build_aml(ISADevice *isadev, Aml *scope)
> +{
> +    Aml *dev;
> +    Aml *crs;
> +
> +    crs =3D aml_resource_template();
> +    aml_append(crs, aml_io(AML_DECODE16, RTC_ISA_BASE, RTC_ISA_BASE,
> +                           0x10, 0x02));
> +    aml_append(crs, aml_irq_no_flags(RTC_ISA_IRQ));
> +    aml_append(crs, aml_io(AML_DECODE16, RTC_ISA_BASE + 2, RTC_ISA_BASE =
+ 2,
> +                           0x02, 0x06));
> +
> +    dev =3D aml_device("RTC");
> +    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0B00")));
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +
> +    aml_append(scope, dev);
> +}
> +
>   static void rtc_class_initfn(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    ISADeviceClass *isa =3D ISA_DEVICE_CLASS(klass);
>  =20
>       dc->realize =3D rtc_realizefn;
>       dc->reset =3D rtc_resetdev;
>       dc->vmsd =3D &vmstate_rtc;
> +    isa->build_aml =3D rtc_build_aml;
>       device_class_set_props(dc, mc146818rtc_properties);
>   }
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


