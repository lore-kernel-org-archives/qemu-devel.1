Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DA1C3524A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 06:37:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10ADB2087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 06:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSGE2wiz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10ADB2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyrq1-0003Fk-9J
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 01:37:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60311)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iyro9-0000ml-TF
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 01:35:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iyro8-0005p0-Iq
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 01:35:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39322
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iyro7-0005lU-R8
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 01:35:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580798135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XHFBdP4vsGft36CQ0GuQBDcAbUK0/4qbdY8aCuH2oHA=;
 b=fSGE2wizWAm63iSBjw5ENBS4zU1veclLl7IRSBWYQryCLOeyAmE7YSbFIToKO1vfN1LQVu
 phHwpynbt8JjaiTrwfM+o4B7Zj4GYGeRVu/gv02aEvtYOR1+uQtKhi64XPxTsenX0p2Yvk
 BgUOuz/RiCV0nzlPb11X/OXiak7wUPE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-C39VfoO7MV-yeYpZ4NCRHQ-1; Tue, 04 Feb 2020 01:35:21 -0500
Received: by mail-qk1-f199.google.com with SMTP id b23so3089875qkg.17
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 22:35:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kN9e3boAdrYe1NQoFTzohP/11uCgTvpjemqgsNre2A8=;
 b=RW+3jIojcv6QFZfDB/YpdwjOaVelQGBl3y6nGdT97p3b4A09tXdOiyjhypzPtUKwp6
 O6XXLgTz+3/xB2mf5c7kYRGpQ2yNai5ri6LuzxawXyQshEd/tfelhnAfquZgLzpwGgMV
 K7+NDdDgoKwslkAQbNcd6TOWvvBVT4qVfHT2pjG7ZS4pzj9jVvIB1hRp7ZNS400qoH3e
 o7W5kx1pgqiB8CAoM+Vi5CtQ6uvtY9dzLpYGSECXy1AQ+GurrTnSZ0tf7roTsdQcnAvG
 EOSUvidI0VJk0TT/Sf4yxgjKDcl5VhANL/jgVHwtzqP8J7hRsBo7/yWH21NJUdOtctuP
 DpRA==
X-Gm-Message-State: APjAAAU2wd0H6FNqbiDSwvY3LnBVej09nUtNkPv35yvHAb84xtD5dqxI
 +CNz0/c2Smd1XqWmV67+61LyWejLKvjDJnFeXIeMoPrAwj+cLCyjSju3KDqKGfHGXoQTStgVueg
 tmF9jJJ16tr/JvpQ=
X-Received: by 2002:ac8:3fd7:: with SMTP id v23mr26851887qtk.293.1580798120915; 
 Mon, 03 Feb 2020 22:35:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqwD2r+9lpz6KZLW6NEVuUB1Iq0iLhKyNHZiqkk5l2yO1KWatevDbfAcEJFBDtHNulGA2UO1RQ==
X-Received: by 2002:ac8:3fd7:: with SMTP id v23mr26851877qtk.293.1580798120676; 
 Mon, 03 Feb 2020 22:35:20 -0800 (PST)
Received: from redhat.com (bzq-109-64-11-187.red.bezeqint.net. [109.64.11.187])
 by smtp.gmail.com with ESMTPSA id c79sm4687636qkg.12.2020.02.03.22.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 22:35:19 -0800 (PST)
Date: Tue, 4 Feb 2020 01:35:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heyi Guo <guoheyi@huawei.com>
Subject: Re: [PATCH v3 3/7] arm/virt/acpi: remove _ADR from devices
 identified by _HID
Message-ID: <20200204013508-mutt-send-email-mst@kernel.org>
References: <20200204014325.16279-1-guoheyi@huawei.com>
 <20200204014325.16279-4-guoheyi@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200204014325.16279-4-guoheyi@huawei.com>
X-MC-Unique: C39VfoO7MV-yeYpZ4NCRHQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On Tue, Feb 04, 2020 at 09:43:21AM +0800, Heyi Guo wrote:
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
> Acked-by: Michael S. Tsirkin <mst@redhat.com>


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

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


