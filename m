Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D95C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:30:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C23D5206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQrVxO0T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23D5206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxei-0002lX-UP
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVxdV-0001rB-UM
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:29:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40958
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVxdU-0001pE-6f
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588685363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9laci2qA5FX6MZ8FY/WWODnLACFBOM+yKXXUQQfglJo=;
 b=bQrVxO0TA+PrrxlAI7kTPrHIumWQ6X/beQV6SjTCRM27vygGFfhAkjtCqsyXjgpaw/0lOV
 6ktq3KfzHMqmVnR3o34J6MFbARxW62sADb9vkQqGkeluuRoryBKvLzxyE7cRfAvZpXjgHr
 r82okZyA42sRRXBU7KKH7WZx0NW/m+M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-ugbn_2N8MlKSiGs8asQy4A-1; Tue, 05 May 2020 09:29:21 -0400
X-MC-Unique: ugbn_2N8MlKSiGs8asQy4A-1
Received: by mail-wm1-f71.google.com with SMTP id 14so798360wmo.9
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 06:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LCvtt8uBGMZNsetFNRoACHc601uJciXIfc192FgnKnA=;
 b=JLjP+Fi9v22SAtUO33qu5/Vc+rRArtIGrLOjW0+3yDgLaMwdnB3pN25EkVI0FL9zkh
 qYuYbefCHcU9Y3p5CKUBhhZhSQMyUWULYwwwOymmNOybEWav1Jgrvk2c+Ya1+KC/96H9
 28THFvZAroEFiO/cEKulF9RFksRKVFQslozEfhWKSBw5mm6E2/Q4WrzdI4ISAymltjtC
 1NFbf9yp1cExLcnvdgRgEf9Esaw5dpkyBprfvVqGxZy2n9uQoxaN8Bqtk93IWElgGT3+
 WmtcECe76DUT85REs+MDOrbaX7aD6qRhTkMV/ISCXqgn6Dmv7ZaTF40TbqScEeYy470F
 e6HQ==
X-Gm-Message-State: AGi0PuZ2UZS13fXDdrMc6W3qLP2Xa+qF+3m/UWjA2C5wXYEsaUgnGlos
 vhdrYLT+cNSMlnN95cfUt1Wsa0w5jT8YFDKBsIkUbXKVIzg8R3klMYCUfuf9O4Wu8bF/N1Anz8z
 DLLTcsqO/6pwFkC0=
X-Received: by 2002:a1c:32c7:: with SMTP id y190mr3746207wmy.13.1588685360367; 
 Tue, 05 May 2020 06:29:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypLDCF2M5NYRcbaMjdfwB8PMYOwDVjAYh/VDDF9Y3XO2sChKA/3XsW8bovlkYV9Jj3/2eUx1Aw==
X-Received: by 2002:a1c:32c7:: with SMTP id y190mr3746188wmy.13.1588685360200; 
 Tue, 05 May 2020 06:29:20 -0700 (PDT)
Received: from [192.168.1.38] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id e21sm3270027wrc.1.2020.05.05.06.29.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 06:29:19 -0700 (PDT)
Subject: Re: [PATCH v4 11/13] acpi: simplify build_isa_devices_aml()
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200505113843.22012-1-kraxel@redhat.com>
 <20200505113843.22012-12-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a58af70b-fd7c-d402-39ea-120e17a6d06e@redhat.com>
Date: Tue, 5 May 2020 15:29:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200505113843.22012-12-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
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
> x86 machines can have a single ISA bus only.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/i386/acpi-build.c | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index cb3913d2ee76..1922868f3401 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1061,19 +1061,14 @@ static void build_hpet_aml(Aml *table)
>   static void build_isa_devices_aml(Aml *table)
>   {
>       bool ambiguous;
> -
> -    Aml *scope =3D aml_scope("_SB.PCI0.ISA");
>       Object *obj =3D object_resolve_path_type("", TYPE_ISA_BUS, &ambiguo=
us);
> +    Aml *scope;
>  =20
> -    if (ambiguous) {
> -        error_report("Multiple ISA busses, unable to define IPMI ACPI da=
ta");
> -    } else if (!obj) {
> -        error_report("No ISA bus, unable to define IPMI ACPI data");
> -    } else {
> -        build_acpi_ipmi_devices(scope, BUS(obj), "\\_SB.PCI0.ISA");
> -        isa_build_aml(ISA_BUS(obj), scope);
> -    }
> +    assert(obj && !ambiguous);
>  =20
> +    scope =3D aml_scope("_SB.PCI0.ISA");
> +    build_acpi_ipmi_devices(scope, BUS(obj), "\\_SB.PCI0.ISA");
> +    isa_build_aml(ISA_BUS(obj), scope);
>       aml_append(table, scope);
>   }
>  =20
>=20


