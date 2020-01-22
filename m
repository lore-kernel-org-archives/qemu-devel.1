Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5213BC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 05:40:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1643321835
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 05:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0KfHDvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1643321835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu8kG-0004RY-8O
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 00:40:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iu8jQ-0003aE-Vs
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:39:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iu8jP-00067D-Sy
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:39:12 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48025
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iu8jP-00066s-Or
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:39:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579671551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2xGw66LZwTu5IRYjYJERzR5WdKSQelMqF7fIoxl369U=;
 b=A0KfHDvL4khtKqUhq9aTfTDzaPEt39Skhdxt2VGAnm/WJyR6aM3PhsdqOyaWOty91Gca56
 VLig7d8IMoXjsEU6zdMudGm2XN5NnADn1dmSXsoH6fM2QO/AgMg/HKlnmiBdtu4NwElMt6
 8VmxlsZBN6vr9Th6NE1fn8c/YeyLkz4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-5Yjjj-QuPaC7V97ax5HQuQ-1; Wed, 22 Jan 2020 00:39:09 -0500
Received: by mail-wr1-f71.google.com with SMTP id d8so2518192wrq.12
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 21:39:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Tvln9ek2hRFIqeBfROyYmFI4dOvddID7++NI0jdRHGM=;
 b=ni2o+fXdHoqg05oT9m6QrazzW+i6bThr4alvez6+SKUYrCTXPENn8kIrFHPaMTC9X3
 Ls+rh4WZWMJ6QOVWB4eWURjXDkd6+WVRX/DkpYsoze3B8Kleg6lBWF7Aix8hafEDfqTR
 o/ayfQqia951xt5a7G+M8eL6mjWOJ9Gg/pE6Oig8vZihZZN9LbqkC0QrjPr1+77VX/VH
 0Ojewt9fUaBGPkWUEIeyiPUmRtjXPqoVJh1KmzOjGBYkwTFvs7fDQmz96tH190P+MNBO
 ssK5oe3z92klKOnSL/4vg0IIEjixvHfMcSRebB8hpEGI4cgVsMdDROqfUUa6jwb04125
 JXPg==
X-Gm-Message-State: APjAAAUQoSYNO12pZ0Sve5XUo2oMY3+7UoNMIXo6Fu1iHzAjGW/qx/6C
 uZnopDjWQCY7fhQASwS5FehLoSpU2/AYM1zfqi1pC8Z3KEIR6rVnXnmydEEogi9dkpG7vbNpRto
 BMc6lmn/qIcDHwjM=
X-Received: by 2002:adf:e984:: with SMTP id h4mr9131167wrm.275.1579671548293; 
 Tue, 21 Jan 2020 21:39:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqywsSohbdCaPLIdJs0SsVI0v8RLkCAdjd3GhPOSzdrgnJEf1u5//NhNYy52IgXw50cd8SK0wA==
X-Received: by 2002:adf:e984:: with SMTP id h4mr9131145wrm.275.1579671548042; 
 Tue, 21 Jan 2020 21:39:08 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 p18sm2426275wmg.4.2020.01.21.21.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 21:39:07 -0800 (PST)
Date: Wed, 22 Jan 2020 00:39:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heyi Guo <guoheyi@huawei.com>
Subject: Re: [PATCH 1/2] arm/virt/acpi: remove meaningless sub device "PR0"
 from PCI0
Message-ID: <20200122003809-mutt-send-email-mst@kernel.org>
References: <20191219064759.35053-1-guoheyi@huawei.com>
 <20191219064759.35053-2-guoheyi@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20191219064759.35053-2-guoheyi@huawei.com>
X-MC-Unique: 5Yjjj-QuPaC7V97ax5HQuQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 19, 2019 at 02:47:58PM +0800, Heyi Guo wrote:
> The sub device "PR0" under PCI0 in ACPI/DSDT does not make any sense,
> so simply remote it.
>=20
> Signed-off-by: Heyi Guo <guoheyi@huawei.com>

So given this has no methods except _ADR, I think it's
safe to remove:

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-devel@nongnu.org
> ---
>  hw/arm/virt-acpi-build.c          |   4 ----
>  tests/data/acpi/virt/DSDT         | Bin 18462 -> 18449 bytes
>  tests/data/acpi/virt/DSDT.memhp   | Bin 19799 -> 19786 bytes
>  tests/data/acpi/virt/DSDT.numamem | Bin 18462 -> 18449 bytes
>  4 files changed, 4 deletions(-)
>=20
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index bd5f771e9b..9f4c7d1889 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -317,10 +317,6 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemM=
apEntry *memmap,
>      aml_append(method, aml_return(buf));
>      aml_append(dev, method);
> =20
> -    Aml *dev_rp0 =3D aml_device("%s", "RP0");
> -    aml_append(dev_rp0, aml_name_decl("_ADR", aml_int(0)));
> -    aml_append(dev, dev_rp0);
> -
>      Aml *dev_res0 =3D aml_device("%s", "RES0");
>      aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));
>      crs =3D aml_resource_template();
> diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/virt/DSDT
> index d0f3afeb134fdf1c11f64cd06dbcdd30be603b80..b5895cb22446860a0b9be3d32=
ec856feb388be4c 100644
> GIT binary patch
> delta 39
> vcmbO?fpOvlMlP3Nmk>b@1_q`B6S<_Bdg?Z+cXBfI+}XT|v(|R9jr$`2@RSW)
>=20
> delta 50
> zcmbO@fpOjhMlP3Nmk>D*1_q{tiCof5o%I{lJ2{y;?{412S!>J19TZ>?&k^tF5;R%I
> G{V4!>hYx%J
>=20
> diff --git a/tests/data/acpi/virt/DSDT.memhp b/tests/data/acpi/virt/DSDT.=
memhp
> index 41ccc6431b917252bcbaac86c33b340c796be5ce..69ad844f65d047973a3e55198=
beecd45a35b8fce 100644
> GIT binary patch
> delta 40
> wcmcaUi}BPfMlP3Nmk=3D*s1_q}3iCof5t(P{ccXBfI+}XT|v(|RAjk`1(02g)*ivR!s
>=20
> delta 51
> zcmX>#i}Cs_MlP3NmymE@1_mbiiCof5O_w*ScXBdy-rc;3v(}c2J1D>)o+IATC1|sb
> HyBr$;t7;Fc
>=20
> diff --git a/tests/data/acpi/virt/DSDT.numamem b/tests/data/acpi/virt/DSD=
T.numamem
> index d0f3afeb134fdf1c11f64cd06dbcdd30be603b80..b5895cb22446860a0b9be3d32=
ec856feb388be4c 100644
> GIT binary patch
> delta 39
> vcmbO?fpOvlMlP3Nmk>b@1_q`B6S<_Bdg?Z+cXBfI+}XT|v(|R9jr$`2@RSW)
>=20
> delta 50
> zcmbO@fpOjhMlP3Nmk>D*1_q{tiCof5o%I{lJ2{y;?{412S!>J19TZ>?&k^tF5;R%I
> G{V4!>hYx%J
>=20
> --=20
> 2.19.1


