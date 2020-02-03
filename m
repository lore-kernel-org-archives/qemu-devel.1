Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F378C33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 05:34:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D01762080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 05:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkbktRAS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01762080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyUNL-0000xD-2k
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 00:34:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iyUMU-0000Kb-IW
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 00:33:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iyUMS-0005l7-1x
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 00:33:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30343
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iyUMQ-0005fr-PM
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 00:33:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580708006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1v5ZDgJz4lo0/aHyDLKtNK1jfVSHLJs35hRLryCl0B0=;
 b=IkbktRASxHHjof7l4CT2tj0m03f7OxsWmGX6BGiG9P/kw/5VrSxxu6K6tYLTqwbr5SXZc9
 As2ZN5yQpcOrb1GoNQn+192h5c2RRHVIOlI/uZS8BpBdw3ixOo5tMKvrse0xF/jROeNqbG
 a2HQF43gU5amG65Ew03YgIP96SiJwCg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-UffCRytNOpOcz-hZzKSF9g-1; Mon, 03 Feb 2020 00:33:18 -0500
Received: by mail-wr1-f69.google.com with SMTP id d8so7605482wrq.12
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2020 21:33:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=D/ynwPAmUV5gzUzi87Vny8EAYzqtaWbLP3m6OVmvvSQ=;
 b=SN+tb/znC/lGiRwrrwmkxpz9JE1J1/c6ea2684zWJ5bpiUA62whzkb7YLQ8aB3DGGX
 3zTLP/qQa6e3MDK2uaRV809iaJKWf4BWLwJN7c8xSvuFH5cvK+Wz4NkNTCGIKD3YjC5h
 I99AdVLxURZi34PlR3EDeRGB4IS9wEOZLth6RxYLSsotFOIbNyqBkARIWjU1Mup/qLAW
 QSUxdpPAqFRyDreWhrvFCIzAZDFOm0MgGG29LvLVYDFYDaoyBfSWA5mSQd1b9YZPPc1V
 Sede/AwqhXRlUW0FJq0hTsj6+GZOcXZMfZ8NAY2hatlFvxD+UwAqxOPkJpPcjawU8ZtX
 amzg==
X-Gm-Message-State: APjAAAUoFbybV8eDtJXafciZ6fUwy3xlbES8HUkRJc/78mHPs2EPtxJA
 zmEQ8Pu2Krr0iEZ/4FyRhdFgj2SYwYDyMvp+J3OWYkH4us1RwogUT5yNG1TBiyZra7aCWkU8pHG
 tlOh35ZQ9Jd6CMfs=
X-Received: by 2002:a1c:6308:: with SMTP id x8mr27193860wmb.80.1580707997235; 
 Sun, 02 Feb 2020 21:33:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqy7rxWwgyHeodk9104tOWk8hMJLx9ch3cKpX3fjpKPmvcbYFZgTV1k3a/Udp5UnSkG8gcr0tw==
X-Received: by 2002:a1c:6308:: with SMTP id x8mr27193828wmb.80.1580707996983; 
 Sun, 02 Feb 2020 21:33:16 -0800 (PST)
Received: from redhat.com (ip-82-36-244-173.west.us.northamericancoax.com.
 [173.244.36.82])
 by smtp.gmail.com with ESMTPSA id p11sm11553020wrn.40.2020.02.02.21.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Feb 2020 21:33:15 -0800 (PST)
Date: Mon, 3 Feb 2020 00:33:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heyi Guo <guoheyi@huawei.com>
Subject: Re: [PATCH v2 3/7] arm/virt/acpi: remove _ADR from devices
 identified by _HID
Message-ID: <20200203003301-mutt-send-email-mst@kernel.org>
References: <20200203001505.52573-1-guoheyi@huawei.com>
 <20200203001505.52573-4-guoheyi@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200203001505.52573-4-guoheyi@huawei.com>
X-MC-Unique: UffCRytNOpOcz-hZzKSF9g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

On Mon, Feb 03, 2020 at 08:15:01AM +0800, Heyi Guo wrote:
> According to ACPI spec, _ADR should be used for device on a bus that
> has a standard enumeration algorithm, but not for device which is on
> system bus and must be enumerated by OSPM. And it is not recommended
> to contain both _HID and _ADR in a single device.
>=20
> See ACPI 6.3, section 6.1, top of page 343:
>=20
> A device object must contain either an _HID object or an _ADR object,
> but should not contain both.
>=20
> (https://uefi.org/sites/default/files/resources/ACPI_6_3_May16.pdf)
>=20
> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> Acked-by: Igor Mammedov <imammedo@redhat.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-devel@nongnu.org
> ---
>  hw/arm/virt-acpi-build.c | 8 --------
>  1 file changed, 8 deletions(-)
>=20
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 9f4c7d1889..be752c0ad8 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -78,11 +78,6 @@ static void acpi_dsdt_add_uart(Aml *scope, const MemMa=
pEntry *uart_memmap,
>                               AML_EXCLUSIVE, &uart_irq, 1));
>      aml_append(dev, aml_name_decl("_CRS", crs));
> =20
> -    /* The _ADR entry is used to link this device to the UART described
> -     * in the SPCR table, i.e. SPCR.base_address.address =3D=3D _ADR.
> -     */
> -    aml_append(dev, aml_name_decl("_ADR", aml_int(uart_memmap->base)));
> -
>      aml_append(scope, dev);
>  }
> =20
> @@ -170,7 +165,6 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMa=
pEntry *memmap,
>      aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
>      aml_append(dev, aml_name_decl("_SEG", aml_int(0)));
>      aml_append(dev, aml_name_decl("_BBN", aml_int(0)));
> -    aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
>      aml_append(dev, aml_name_decl("_UID", aml_string("PCI0")));
>      aml_append(dev, aml_name_decl("_STR", aml_unicode("PCIe 0 Device")))=
;
>      aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
> @@ -334,7 +328,6 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemM=
apEntry *gpio_memmap,
>  {
>      Aml *dev =3D aml_device("GPO0");
>      aml_append(dev, aml_name_decl("_HID", aml_string("ARMH0061")));
> -    aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
>      aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> =20
>      Aml *crs =3D aml_resource_template();
> @@ -364,7 +357,6 @@ static void acpi_dsdt_add_power_button(Aml *scope)
>  {
>      Aml *dev =3D aml_device(ACPI_POWER_BUTTON_DEVICE);
>      aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C0C")));
> -    aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
>      aml_append(dev, aml_name_decl("_UID", aml_int(0)));
>      aml_append(scope, dev);
>  }
> --=20
> 2.19.1


