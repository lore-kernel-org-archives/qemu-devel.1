Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C2DC4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:37:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CEB820663
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ioZ1xwr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CEB820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jErcU-0006Oz-EX
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 05:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jErbk-0005aX-1c
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jErbi-0007Vw-Rx
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:36:55 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:58036)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jErbi-0007Vj-Og
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584610614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=485zYR2xSUDCz0nT4AG1Y6/nhHKzdSnykRsgx2l9rYA=;
 b=ioZ1xwr57vdNrGTWCO84XuOJO0XDSLnUZC22/wcSd3ilmk6IxXEJ1e7+MCkdGtoV1ggoLH
 kHJeKaGWvNoAnTPurFs/CAP7c2TUY9VPrglVNGKZGTf4mTuoJt9mMTQgKMSjXII/LVVAHz
 fbSR9Nbr9rO7JUM3HYoY8sd7ujeh6Kc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-cd81S0-RNiO_ZHnD101meg-1; Thu, 19 Mar 2020 05:36:52 -0400
X-MC-Unique: cd81S0-RNiO_ZHnD101meg-1
Received: by mail-ed1-f69.google.com with SMTP id x93so1402356ede.19
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 02:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n5yKpnOrTddyfGAlJQzjmr6SNI/SN5qqRSwRgHNbZzo=;
 b=B+NTdSs1e1sc+C/pB7RoTE7EJhxP+p5DifOwykSrKBpfz48OhujGo1fUwSK2KiDZ1G
 T/vlF5EbuR1eNVr3oiqTky+YZ1gISBq+6VNi1mFTK/Zv1jYQTUdoC4+2rxnPcndcVN5M
 NelnOJ6s60flkq51PuccQewnWCWA0uYE4uDDBqSH7edpgP0UzRG0yBsn3uxEa8nPBYkJ
 tukrKgq/ftg5d6Z+414UHgmJdej48IoI8wbqXMwmzLkBhVeaNwnBsnso0VY/02P22+1+
 IVFYnFvKMklc7ajTekm4j3mCUeV9+lpaVNIc3TJ2UxE1ZxQkjtcir7N3GgdjD24o/PWH
 KqlQ==
X-Gm-Message-State: ANhLgQ0VWH4dBV+zpHVhVgSy97+BBIOJa9hA4uqQogmHzMNDpuywqTfs
 kgU8Bsil+1hhEhqPWE0nJk73gXjKwi5mWWOWyQkfBfVdTYt8GUrz8hlJygsqHSRNIKY6qFbB/IF
 lViomyngp+MYV1+g=
X-Received: by 2002:a50:d847:: with SMTP id v7mr1745153edj.154.1584610610813; 
 Thu, 19 Mar 2020 02:36:50 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvzwTvI6EKrO0oS8WqsYWEY3mP1lL0UV3/I+XKI+7l4h7UVr7BODJCmcHbSrtOi0oGU0FXqUw==
X-Received: by 2002:a50:d847:: with SMTP id v7mr1745130edj.154.1584610610516; 
 Thu, 19 Mar 2020 02:36:50 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id v3sm31157eju.34.2020.03.19.02.36.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2020 02:36:49 -0700 (PDT)
Subject: Re: [PATCH 02/13] acpi: factor out acpi_dsdt_add_fw_cfg()
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200319080117.7725-1-kraxel@redhat.com>
 <20200319080117.7725-3-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c3e285b5-6104-ff8a-97d4-1c60cdac9907@redhat.com>
Date: Thu, 19 Mar 2020 10:36:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319080117.7725-3-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/19/20 9:01 AM, Gerd Hoffmann wrote:
> Add helper function to add fw_cfg device.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/i386/acpi-build.c | 50 ++++++++++++++++++++++++--------------------
>   1 file changed, 27 insertions(+), 23 deletions(-)
>=20
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 1b0684c433e3..9c98b07116cc 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1822,6 +1822,32 @@ static void build_smb0(Aml *table, I2CBus *smbus, =
int devnr, int func)
>       aml_append(table, scope);
>   }
>  =20
> +static void acpi_dsdt_add_fw_cfg(Aml *scope, Object *fw_cfg)
> +{
> +    /*
> +     * when using port i/o, the 8-bit data register *always* overlaps
> +     * with half of the 16-bit control register. Hence, the total size
> +     * of the i/o region used is FW_CFG_CTL_SIZE; when using DMA, the
> +     * DMA control register is located at FW_CFG_DMA_IO_BASE + 4
> +     */
> +    uint8_t io_size =3D object_property_get_bool(fw_cfg, "dma_enabled", =
NULL) ?
> +        ROUND_UP(FW_CFG_CTL_SIZE, 4) + sizeof(dma_addr_t) :
> +        FW_CFG_CTL_SIZE;
> +    Aml *dev =3D aml_device("FWCF");
> +    Aml *crs =3D aml_resource_template();
> +
> +    aml_append(dev, aml_name_decl("_HID", aml_string("QEMU0002")));
> +
> +    /* device present, functioning, decoding, not shown in UI */
> +    aml_append(dev, aml_name_decl("_STA", aml_int(0xB)));
> +
> +    aml_append(crs,
> +        aml_io(AML_DECODE16, FW_CFG_IO_BASE, FW_CFG_IO_BASE, 0x01, io_si=
ze));
> +
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +    aml_append(scope, dev);
> +}
> +
>   static void
>   build_dsdt(GArray *table_data, BIOSLinker *linker,
>              AcpiPmInfo *pm, AcpiMiscInfo *misc,
> @@ -2101,30 +2127,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>  =20
>       /* create fw_cfg node, unconditionally */
>       {
> -        /* when using port i/o, the 8-bit data register *always* overlap=
s
> -         * with half of the 16-bit control register. Hence, the total si=
ze
> -         * of the i/o region used is FW_CFG_CTL_SIZE; when using DMA, th=
e
> -         * DMA control register is located at FW_CFG_DMA_IO_BASE + 4 */
> -        uint8_t io_size =3D object_property_get_bool(OBJECT(x86ms->fw_cf=
g),
> -                                                   "dma_enabled", NULL) =
?
> -                          ROUND_UP(FW_CFG_CTL_SIZE, 4) + sizeof(dma_addr=
_t) :
> -                          FW_CFG_CTL_SIZE;
> -
>           scope =3D aml_scope("\\_SB.PCI0");
> -        dev =3D aml_device("FWCF");
> -
> -        aml_append(dev, aml_name_decl("_HID", aml_string("QEMU0002")));
> -
> -        /* device present, functioning, decoding, not shown in UI */
> -        aml_append(dev, aml_name_decl("_STA", aml_int(0xB)));
> -
> -        crs =3D aml_resource_template();
> -        aml_append(crs,
> -            aml_io(AML_DECODE16, FW_CFG_IO_BASE, FW_CFG_IO_BASE, 0x01, i=
o_size)
> -        );
> -        aml_append(dev, aml_name_decl("_CRS", crs));
> -
> -        aml_append(scope, dev);
> +        acpi_dsdt_add_fw_cfg(scope, OBJECT(x86ms->fw_cfg));
>           aml_append(dsdt, scope);
>       }
>  =20
>=20


