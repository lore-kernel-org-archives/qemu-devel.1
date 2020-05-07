Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF01BC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:01:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8628205C9
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJ/Y6oQc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8628205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWh66-0004wd-NU
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 10:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWgz1-0003vB-47
 for qemu-devel@nongnu.org; Thu, 07 May 2020 09:54:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56981
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWgz0-00051Q-14
 for qemu-devel@nongnu.org; Thu, 07 May 2020 09:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588859677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IWJqm7AeSrumR0NFP0Q9AOU+urFm769Olp4p/TcT8jc=;
 b=iJ/Y6oQc20MadkT2c6AJ3uoMwMEQPrKfqymm5VmQspbw3U/b2YrW/tyNdzayz0sIoV6XDN
 d0UiGzLF4lIRateZMsnIhheB96g4v3kuTyATp3JxL1FG46x7TD+yCevL8NPVGA+73Xk1Il
 gAp3yuJV7a5c1Cmmd+MKal8aFm1jM7E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-MT51m39lMTuq3t9dash4rg-1; Thu, 07 May 2020 09:54:35 -0400
X-MC-Unique: MT51m39lMTuq3t9dash4rg-1
Received: by mail-wr1-f72.google.com with SMTP id s11so3476738wru.6
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 06:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wPvnNpZ8zu16THqn7uXwsHeuL5LMTbS2ojF9/lmPLTY=;
 b=TyxM2GQqmAXEMKDhM8tBkTGadazwuILoKGPzQ0MryjtZY3MqWWb33DI2ssjZiO3MCe
 PfbAUVneInP2x5/+hjGJcrdXH2o9LcBr4/HreXFKdVG2RJuxILUxcw4JQs3S9KUSEAzW
 XlwjsvyY9eNYsQpYFzgv+urHhokBclE/a5yUa+/bUUbMBXc4p7QJ/+NDtjdPwEg8V726
 MARYJGVSo1H1vbq9hCjkHG3e58n0UW1ORUhPbzhkUJWQyos8f/NoX883ajIQ/BXyYsFD
 dEwf1DBOY5yNLQiKwILXxRvG6vBBmqx0/o+U2yHPJdjvX+7M9E98rJQ+WlNE2IhT8fVN
 9gyg==
X-Gm-Message-State: AGi0PuapafzfnTs54zKqsIenhsDT1oSYSmyD5SrbZ7YtugG20DOD1xgd
 JftJ7lQjjOFYuwUG7pEcshaEk+1c4v//JbqDOigROca/QfbvGkcsf89aSdXVMVs5li3+i1tO4TD
 d6nHF8WnaXsc8N/E=
X-Received: by 2002:a1c:dc0a:: with SMTP id t10mr10106422wmg.113.1588859674596; 
 Thu, 07 May 2020 06:54:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypIeJhqEe9mTBTd2dE3NK1SilYa1aCPzqAIZEsnne69Ia85OTfHaqxHEgr+2ZELYH1+xq5MkLA==
X-Received: by 2002:a1c:dc0a:: with SMTP id t10mr10106381wmg.113.1588859674271; 
 Thu, 07 May 2020 06:54:34 -0700 (PDT)
Received: from [192.168.1.39] (248.red-88-21-203.staticip.rima-tde.net.
 [88.21.203.248])
 by smtp.gmail.com with ESMTPSA id c128sm8193452wma.42.2020.05.07.06.54.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2020 06:54:33 -0700 (PDT)
Subject: Re: [PATCH v5 07/15] acpi: move aml builder code for parallel device
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200507131640.14041-1-kraxel@redhat.com>
 <20200507131640.14041-8-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6e711923-d7da-f961-fee2-73f7bc5b0f73@redhat.com>
Date: Thu, 7 May 2020 15:54:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200507131640.14041-8-kraxel@redhat.com>
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
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/20 3:16 PM, Gerd Hoffmann wrote:
> Also adds support for multiple LPT devices.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/char/parallel.c   | 22 ++++++++++++++++++++++
>   hw/i386/acpi-build.c | 23 -----------------------
>   2 files changed, 22 insertions(+), 23 deletions(-)
>=20
> diff --git a/hw/char/parallel.c b/hw/char/parallel.c
> index 8dd67d13759b..c0f34bf924ec 100644
> --- a/hw/char/parallel.c
> +++ b/hw/char/parallel.c
> @@ -28,6 +28,7 @@
>   #include "qemu/module.h"
>   #include "chardev/char-parallel.h"
>   #include "chardev/char-fe.h"
> +#include "hw/acpi/aml-build.h"
>   #include "hw/irq.h"
>   #include "hw/isa/isa.h"
>   #include "hw/qdev-properties.h"
> @@ -568,6 +569,25 @@ static void parallel_isa_realizefn(DeviceState *dev,=
 Error **errp)
>                                s, "parallel");
>   }
>  =20
> +static void parallel_isa_build_aml(ISADevice *isadev, Aml *scope)
> +{
> +    ISAParallelState *isa =3D ISA_PARALLEL(isadev);
> +    Aml *dev;
> +    Aml *crs;
> +
> +    crs =3D aml_resource_template();
> +    aml_append(crs, aml_io(AML_DECODE16, isa->iobase, isa->iobase, 0x08,=
 0x08));
> +    aml_append(crs, aml_irq_no_flags(isa->isairq));
> +
> +    dev =3D aml_device("LPT%d", isa->index + 1);
> +    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0400")));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(isa->index + 1)));
> +    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +
> +    aml_append(scope, dev);
> +}
> +
>   /* Memory mapped interface */
>   static uint64_t parallel_mm_readfn(void *opaque, hwaddr addr, unsigned =
size)
>   {
> @@ -624,9 +644,11 @@ static Property parallel_isa_properties[] =3D {
>   static void parallel_isa_class_initfn(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    ISADeviceClass *isa =3D ISA_DEVICE_CLASS(klass);
>  =20
>       dc->realize =3D parallel_isa_realizefn;
>       dc->vmsd =3D &vmstate_parallel_isa;
> +    isa->build_aml =3D parallel_isa_build_aml;
>       device_class_set_props(dc, parallel_isa_properties);
>       set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>   }
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 2188a2b99d18..443db94deb5b 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1173,28 +1173,6 @@ static Aml *build_mouse_device_aml(void)
>       return dev;
>   }
>  =20
> -static void build_lpt_device_aml(Aml *scope)
> -{
> -    Aml *dev;
> -    Aml *crs;
> -
> -    if (!memory_region_present(get_system_io(), 0x0378)) {
> -        return;
> -    }
> -
> -    dev =3D aml_device("LPT");
> -    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0400")));
> -
> -    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
> -
> -    crs =3D aml_resource_template();
> -    aml_append(crs, aml_io(AML_DECODE16, 0x0378, 0x0378, 0x08, 0x08));
> -    aml_append(crs, aml_irq_no_flags(7));
> -    aml_append(dev, aml_name_decl("_CRS", crs));
> -
> -    aml_append(scope, dev);
> -}
> -
>   static void build_isa_devices_aml(Aml *table)
>   {
>       ISADevice *fdc =3D pc_find_fdc0();
> @@ -1208,7 +1186,6 @@ static void build_isa_devices_aml(Aml *table)
>       if (fdc) {
>           aml_append(scope, build_fdc_device_aml(fdc));
>       }
> -    build_lpt_device_aml(scope);
>  =20
>       if (ambiguous) {
>           error_report("Multiple ISA busses, unable to define IPMI ACPI d=
ata");
>=20


