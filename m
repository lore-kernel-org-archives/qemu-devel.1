Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25B2C3524A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 06:36:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 873692087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 06:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jCuRJfIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873692087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyrpC-00024Z-P4
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 01:36:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iyroN-00016b-90
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 01:35:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iyroM-00064r-7j
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 01:35:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38790
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iyroM-00064C-4B
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 01:35:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580798149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wVqf0acbo6uek2evnAMsQCoUgPVt9B9GWsSlHwXLCUo=;
 b=jCuRJfIRcJsQXZmsvsb97fo3gldTZZSermZ82glxrWppw+LG2GZagyFjJ3XZDISFDE07Nm
 +0TIuEJc7Zf32VkpedesO8hy5N7qqeWmhBFERDvDcxmtd9bEB6d/N5QG3sOTtQyTEb5Jrp
 cZOY3F+y8F5bKMaS3RcVPe8dWlTF/6A=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-0WufhnTEMjC6tw3Y74PuXw-1; Tue, 04 Feb 2020 01:35:46 -0500
Received: by mail-qk1-f200.google.com with SMTP id s9so11159855qkg.21
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 22:35:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hNAbxjmT3EJKtjyG7rQniLNeqzdU/9mrDavT+lFPQ6o=;
 b=mwstSPhAULVVJfNPYeHMYS831zICclr/YS4RAOjObqBN7Xe94s/vlEW6HqMa5rnSNl
 iRfv749kjesYq6NN+/XUjZYtXRzd2uLqyCAC6K0xKhayiNXPh1W44ARTOe/o7SSG4YUA
 foT0DezA6JpXQsJOTUQxlQmIfogPiRHTow8zQ+EhbP2nh8ZcEsTZ6hJRfsVt5skpASqK
 v0IpTcRKdGeIEWLH/3ZW9mfKXzWtXfNnpCIAefFfXqsJvdf7HyRw+iKNGaU9GaJceGdK
 hKFVBEdzVWBouYASCZMy5LFRu61cLIW0azTlXfYZ7IjoqjImww/ShvKMKjex8lMyS9V1
 61dw==
X-Gm-Message-State: APjAAAXMOLN2QzkT6IdWzzX2vcvC3SDBQPHdJSc0d4nK1LxbkHbwsOjx
 kvDQcKadgVJcXGAmIiE8Be0wW1GeXAzNFZprzoFY48EVuTBDzVmmcBKN8Lk4J/jp0qBM0YvL3qV
 +C1FbVBgjUh9BIx8=
X-Received: by 2002:ac8:754e:: with SMTP id b14mr27501059qtr.220.1580798145511; 
 Mon, 03 Feb 2020 22:35:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqzru7KKxcFmceQBfaXpNP8b0S6nl560HD1wEaeMj6RWZJbmbdxOAXBOEn5lIj74J2d9ISaDZA==
X-Received: by 2002:ac8:754e:: with SMTP id b14mr27501046qtr.220.1580798145302; 
 Mon, 03 Feb 2020 22:35:45 -0800 (PST)
Received: from redhat.com (bzq-109-64-11-187.red.bezeqint.net. [109.64.11.187])
 by smtp.gmail.com with ESMTPSA id t2sm10394260qkc.31.2020.02.03.22.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 22:35:44 -0800 (PST)
Date: Tue, 4 Feb 2020 01:35:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heyi Guo <guoheyi@huawei.com>
Subject: Re: [PATCH v3 2/7] arm/virt/acpi: remove meaningless sub device
 "RP0" from PCI0
Message-ID: <20200204013535-mutt-send-email-mst@kernel.org>
References: <20200204014325.16279-1-guoheyi@huawei.com>
 <20200204014325.16279-3-guoheyi@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200204014325.16279-3-guoheyi@huawei.com>
X-MC-Unique: 0WufhnTEMjC6tw3Y74PuXw-1
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

On Tue, Feb 04, 2020 at 09:43:20AM +0800, Heyi Guo wrote:
> The sub device "RP0" under PCI0 in ACPI/DSDT does not contain any
> method or property other than "_ADR", so it is safe to remove it.
>=20
> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> Acked-by: "Michael S. Tsirkin" <mst@redhat.com>


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-devel@nongnu.org
> ---
>  hw/arm/virt-acpi-build.c | 4 ----
>  1 file changed, 4 deletions(-)
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
> --=20
> 2.19.1


