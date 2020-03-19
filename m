Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D7FC4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:36:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6CF720663
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUhq76be"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6CF720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35391 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jErax-0004uj-4d
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 05:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jErZq-0003ju-6x
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jErZp-0006AX-2H
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:34:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:57622)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jErZo-0006AL-V4
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584610496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9qhsjAirYmThC1vbADEFMB51JGPP59KRnSQ9P3VaqTo=;
 b=BUhq76beezeXqWnHG96DNZimlQXDxCTwapx4MGSr5Fj0FuXj+jhUUBrfdzLxNTUHV+cjsk
 ylcVx6KcOa2yPCR8V+Tm2n5q8Fu7SMqHL8+m4vWyMUQt6o7hFs2WFJwNnxAGw+oKopt3z5
 lUJmix3CoRFCI+o2ABWjg4kkBkwNgIA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-g99SeuqcOOKWJf6WaFESRw-1; Thu, 19 Mar 2020 05:34:54 -0400
X-MC-Unique: g99SeuqcOOKWJf6WaFESRw-1
Received: by mail-ed1-f69.google.com with SMTP id x93so1398019ede.19
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 02:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a7jqHBPIYzCfSWWCEWnP7+X46s72TVndqt8BFuTZpBE=;
 b=kiQO9HZ+0Nz9AmjiQx1889yt1lzFTnCEZWTuF7KHkrF0hNt1x+BX0GiNiZIK70kbqF
 I1qLLby3FG+4LtipkgpGv3UOVUUI6OYFm2G4PJgO+FZq/K6nBnHtAYiHFPnaXZyW+ZX9
 P3G1xCkd+bn81oZoCHkmhY/MNRs0Y8WQ7m3MamQnACTdlH+SExu9e8mfcSACUs/ea7/1
 njZKgKmOcfHVBBG+rfuSEBG6AdgfIx+rWDvoPDcxWZUOIfDXZ1HLEcGxkbf+kMjt/Qza
 dZPx8zoJ9t/LMFuVq+MlBi6EuXRR8tbpjhEHGrABgdQ3STX0a70gA6FBRj0MdFWI/nen
 MXMw==
X-Gm-Message-State: ANhLgQ1mlVJnE4Iwrr+XxfBS+VAa6fiMzSMMiIEQyW59cFxwFITOxC8j
 EhxOJSkWjDKh9lvsvf7ExfHHnOi6geFTnk9OFyaXU7gjvyAri971p5hiBbL+UAx31a29eaOYKXo
 7WZXSHACT5gUpjfU=
X-Received: by 2002:a17:906:5c0f:: with SMTP id
 e15mr2142464ejq.159.1584610493481; 
 Thu, 19 Mar 2020 02:34:53 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv7W59QqeG8JXCGhlPPUaVO0TFkI/pIvkIFk9QD7xX7yhicjgRaZrImZE3iHWvRXfQrj+t4HQ==
X-Received: by 2002:a17:906:5c0f:: with SMTP id
 e15mr2142437ejq.159.1584610493175; 
 Thu, 19 Mar 2020 02:34:53 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id m1sm72960ejr.68.2020.03.19.02.34.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2020 02:34:52 -0700 (PDT)
Subject: Re: [PATCH 01/13] acpi: make build_madt() more generic.
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200319080117.7725-1-kraxel@redhat.com>
 <20200319080117.7725-2-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b810545d-c5e4-d5b3-8bb9-d5e21c640623@redhat.com>
Date: Thu, 19 Mar 2020 10:34:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319080117.7725-2-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
> Remove PCMachineState dependency from build_madt().
> Pass AcpiDeviceIf as separate argument instead of
> depending on PCMachineState->acpi_dev.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/i386/acpi-build.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 9a19c14e661b..1b0684c433e3 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -360,14 +360,13 @@ void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
>   }
>  =20
>   static void
> -build_madt(GArray *table_data, BIOSLinker *linker, PCMachineState *pcms)
> +build_madt(GArray *table_data, BIOSLinker *linker,
> +           X86MachineState *x86ms, AcpiDeviceIf *adev)
>   {
> -    MachineClass *mc =3D MACHINE_GET_CLASS(pcms);
> -    X86MachineState *x86ms =3D X86_MACHINE(pcms);
> -    const CPUArchIdList *apic_ids =3D mc->possible_cpu_arch_ids(MACHINE(=
pcms));
> +    MachineClass *mc =3D MACHINE_GET_CLASS(x86ms);
> +    const CPUArchIdList *apic_ids =3D mc->possible_cpu_arch_ids(MACHINE(=
x86ms));
>       int madt_start =3D table_data->len;
> -    AcpiDeviceIfClass *adevc =3D ACPI_DEVICE_IF_GET_CLASS(pcms->acpi_dev=
);
> -    AcpiDeviceIf *adev =3D ACPI_DEVICE_IF(pcms->acpi_dev);
> +    AcpiDeviceIfClass *adevc =3D ACPI_DEVICE_IF_GET_CLASS(adev);
>       bool x2apic_mode =3D false;
>  =20
>       AcpiMultipleApicTable *madt;
> @@ -2807,7 +2806,8 @@ void acpi_build(AcpiBuildTables *tables, MachineSta=
te *machine)
>       aml_len +=3D tables_blob->len - fadt;
>  =20
>       acpi_add_table(table_offsets, tables_blob);
> -    build_madt(tables_blob, tables->linker, pcms);
> +    build_madt(tables_blob, tables->linker, x86ms,
> +               ACPI_DEVICE_IF(pcms->acpi_dev));
>  =20
>       vmgenid_dev =3D find_vmgenid_dev();
>       if (vmgenid_dev) {
>=20


