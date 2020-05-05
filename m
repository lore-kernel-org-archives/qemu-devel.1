Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45E7C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 823F224960
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AwIfdYF7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823F224960
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVyRN-0004r2-JJ
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 10:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVyO5-0008Ku-JT
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:17:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43695
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVyO4-0005HF-Md
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588688251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=27MpypBmk9vVNVPWl6ks1YJk985+0VvxzLiLjVddjDo=;
 b=AwIfdYF7fRO9v6d251Fjbm/XLyTaCfuQ5PyYks2jbwld7RH77Jn3Xp7toGI7O2R7yihn7c
 5KZMjd8jXkqYbuXJm4nAypdaM0bgPXOvmdKby4ZACJSp9v2iOx4/bw+UMtjAs+tPUKz9ZE
 wE+TZKfizG0Z9KBD4d1xG/rFOUll/zI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-pQPpkittO7KplLwl_Uee5Q-1; Tue, 05 May 2020 10:17:29 -0400
X-MC-Unique: pQPpkittO7KplLwl_Uee5Q-1
Received: by mail-wm1-f70.google.com with SMTP id 71so877148wmb.8
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 07:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8Ui7k5ApTyQBkLl7iN7e6Q4UVrlWs+Jva2GSP4FkbJk=;
 b=FRit1TlA07v9pJZEsg5Mf8GrOvcIk8ec+J7ektwIlAe45xV7PyRtNev4Vbt+4EoEhT
 aYnDtaxtdKQMZBHkNzKMk9n4GbGK6LXfR0/tmUs6gEciSgQ5CSOXp64TJ9TGXEhpXdB2
 QvFcx2QpWFI4KnxxZPvTaRuS5WJL1VcLDZBEOm8fELzoRjEFdef1t5rsX1TAuxikdpTQ
 T82gc1ZJJ+9wqKDR5ojI/TeQMjM1lKFKtxrQuRFuRuoMsXr6NS2S/yL8xuhHbUSzAJl2
 Z/FvyETUMEthCGstHnxliot7rm2Gc1FLuByA7tUNCiGGUSKyfrUSZuqpHmVFKh6n+zYI
 1PMA==
X-Gm-Message-State: AGi0PublH/+sEdhk6v/EMJDNfZ90kHWWvyeRT+KH8jzLxGI6i5xqgUfj
 t+k6J7s2fGUK6I7Mz0cLrSBhrPMk4yw5wWH/uKv7pl2t7N4JGRDADOlZpxXF/dM/H6TwWnpZcWH
 UwCjrTdb+QBec3Og=
X-Received: by 2002:a05:600c:2:: with SMTP id g2mr3885472wmc.85.1588688248415; 
 Tue, 05 May 2020 07:17:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypJWqXhBpPY4uZom12upRjXAvGkOygIAPo7TMfiTfTXfy92iqHyqFOPrWKe+avXxASTjc9bz1g==
X-Received: by 2002:a05:600c:2:: with SMTP id g2mr3885456wmc.85.1588688248204; 
 Tue, 05 May 2020 07:17:28 -0700 (PDT)
Received: from [192.168.1.38] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id o129sm4291696wme.16.2020.05.05.07.17.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 07:17:27 -0700 (PDT)
Subject: Re: [PATCH v2 03/13] acpi: madt: skip pci override on pci-less
 systems (microvm)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200505134305.22666-1-kraxel@redhat.com>
 <20200505134305.22666-4-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <621236cf-9692-7421-1327-8ef131d4f8eb@redhat.com>
Date: Tue, 5 May 2020 16:17:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200505134305.22666-4-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:40
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/5/20 3:42 PM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/i386/acpi-common.h |  3 ++-
>   hw/i386/acpi-build.c  |  2 +-
>   hw/i386/acpi-common.c | 26 +++++++++++++++-----------
>   3 files changed, 18 insertions(+), 13 deletions(-)
>=20
> diff --git a/hw/i386/acpi-common.h b/hw/i386/acpi-common.h
> index c30e461f1854..9cac18dddf5b 100644
> --- a/hw/i386/acpi-common.h
> +++ b/hw/i386/acpi-common.h
> @@ -9,6 +9,7 @@
>   #define ACPI_BUILD_IOAPIC_ID 0x0
>  =20
>   void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
> -                     X86MachineState *x86ms, AcpiDeviceIf *adev);
> +                     X86MachineState *x86ms, AcpiDeviceIf *adev,
> +                     bool has_pci);
>  =20
>   #endif
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index eb530e5cd56d..4cce2192eeb0 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2441,7 +2441,7 @@ void acpi_build(AcpiBuildTables *tables, MachineSta=
te *machine)
>  =20
>       acpi_add_table(table_offsets, tables_blob);
>       acpi_build_madt(tables_blob, tables->linker, x86ms,
> -                    ACPI_DEVICE_IF(pcms->acpi_dev));
> +                    ACPI_DEVICE_IF(pcms->acpi_dev), true);
>  =20
>       vmgenid_dev =3D find_vmgenid_dev();
>       if (vmgenid_dev) {
> diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
> index 5caca16a0b59..ab9b00581a15 100644
> --- a/hw/i386/acpi-common.c
> +++ b/hw/i386/acpi-common.c
> @@ -72,7 +72,8 @@ void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
>   }
>  =20
>   void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
> -                     X86MachineState *x86ms, AcpiDeviceIf *adev)
> +                     X86MachineState *x86ms, AcpiDeviceIf *adev,
> +                     bool has_pci)
>   {
>       MachineClass *mc =3D MACHINE_GET_CLASS(x86ms);
>       const CPUArchIdList *apic_ids =3D mc->possible_cpu_arch_ids(MACHINE=
(x86ms));
> @@ -111,18 +112,21 @@ void acpi_build_madt(GArray *table_data, BIOSLinker=
 *linker,
>           intsrcovr->gsi    =3D cpu_to_le32(2);
>           intsrcovr->flags  =3D cpu_to_le16(0); /* conforms to bus specif=
ications */
>       }
> -    for (i =3D 1; i < 16; i++) {
> +
> +    if (has_pci) {
> +        for (i =3D 1; i < 16; i++) {
>   #define ACPI_BUILD_PCI_IRQS ((1<<5) | (1<<9) | (1<<10) | (1<<11))
> -        if (!(ACPI_BUILD_PCI_IRQS & (1 << i))) {
> -            /* No need for a INT source override structure. */
> -            continue;
> +            if (!(ACPI_BUILD_PCI_IRQS & (1 << i))) {
> +                /* No need for a INT source override structure. */
> +                continue;
> +            }
> +            intsrcovr =3D acpi_data_push(table_data, sizeof *intsrcovr);
> +            intsrcovr->type   =3D ACPI_APIC_XRUPT_OVERRIDE;
> +            intsrcovr->length =3D sizeof(*intsrcovr);
> +            intsrcovr->source =3D i;
> +            intsrcovr->gsi    =3D cpu_to_le32(i);
> +            intsrcovr->flags  =3D cpu_to_le16(0xd); /* active high, leve=
l triggered */
>           }
> -        intsrcovr =3D acpi_data_push(table_data, sizeof *intsrcovr);
> -        intsrcovr->type   =3D ACPI_APIC_XRUPT_OVERRIDE;
> -        intsrcovr->length =3D sizeof(*intsrcovr);
> -        intsrcovr->source =3D i;
> -        intsrcovr->gsi    =3D cpu_to_le32(i);
> -        intsrcovr->flags  =3D cpu_to_le16(0xd); /* active high, level tr=
iggered */
>       }
>  =20
>       if (x2apic_mode) {
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


