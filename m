Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C502C33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:01:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 237E520661
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LT9v284R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237E520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyUnm-0008BQ-CE
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 01:01:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iyUms-0007br-Os
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:00:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iyUmq-0007vp-Q0
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:00:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28040
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iyUmq-0007sp-JQ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580709644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RCDdPYJ4CJebkilqYHen5Ppk9focfoniFfnlmhfCCug=;
 b=LT9v284RTnywaZORGVlMTyRvBQ7jqeFxs9Jpxs0Zv3mdeRA7R1E1f/odcE95KUEP3yH3sh
 ErkuACUuIp0KPueFq65VDkCaqTLsh9hkN4O8Rao0jD08wvRmGl/AzG9g+TTc+KQffM1hFK
 0G7kRrZJNrhHwcptEJrRbJbJ96LaHnw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-mLIrViVyMry2I4ET4LxB4A-1; Mon, 03 Feb 2020 01:00:42 -0500
Received: by mail-wr1-f70.google.com with SMTP id l1so2625175wrt.4
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2020 22:00:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vuJRcWENNqLN0tXOKXzxUBajPmXPIC9NC0LDQfL3CHA=;
 b=Nd1jUJxvjFwRJVW6F3K16m3oGyvFvXdhBNzDrDiGB3XWb6R5Jah+fmEwqghM/zbsAX
 CNFosDXQ4fYhtgJxUtgAVT7+NxAGJqRGWIoJfs/cXF+fKxig4hPfFdeR5aVcq0pZLYPM
 YZX/1IN+VRrPKoV68K2tgamwRJx1t9V7ZeqNRfy9SP5+etROEyFDxZKK8wqlIss3wU/M
 D90kvI6E4zsFbP1QM3tIVjLjCTIzBDIiDBuFXqGhjEtrCj/r0f8Syshaer2knsU+Bvte
 svYPZ73Jb/7GRW8J3Qv2I0xG0RRBqGHb/JYsdSq459FMzgRbL7a3cWCnxhHGXhlouFJP
 0Mog==
X-Gm-Message-State: APjAAAURpGOfknVFCHN1porFJ7+gDPc5leLSMJ7Uk5F5mVK9Rsq9nnU0
 Bh9DT/qzycMuY/kQ7l6BzIC7KtH3yTj33cvq8pybfiAUmf28R3sMseAZq6gB8tKUcLrbUY6Uz8V
 rUFJAdVWlOVhBYiw=
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr28720694wmc.168.1580709640909; 
 Sun, 02 Feb 2020 22:00:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqwjx8x/9RKyApaZKzxKdRRUbo2Lg6rlXws9Cqcd+rVarilTFHSF/AAaUvB2/fgp74R0ZrqSkQ==
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr28720671wmc.168.1580709640737; 
 Sun, 02 Feb 2020 22:00:40 -0800 (PST)
Received: from redhat.com (ip-82-36-244-173.west.us.northamericancoax.com.
 [173.244.36.82])
 by smtp.gmail.com with ESMTPSA id x17sm23315758wrt.74.2020.02.02.22.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Feb 2020 22:00:40 -0800 (PST)
Date: Mon, 3 Feb 2020 01:00:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heyi Guo <guoheyi@huawei.com>
Subject: Re: [PATCH v2 6/7] arm/acpi: simplify the description of PCI _CRS
Message-ID: <20200203010023-mutt-send-email-mst@kernel.org>
References: <20200203001505.52573-1-guoheyi@huawei.com>
 <20200203001505.52573-7-guoheyi@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200203001505.52573-7-guoheyi@huawei.com>
X-MC-Unique: mLIrViVyMry2I4ET4LxB4A-1
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

On Mon, Feb 03, 2020 at 08:15:04AM +0800, Heyi Guo wrote:
> The original code defines a named object for the resource template but
> then returns the resource template object itself; the resulted output
> is like below:
>=20
> Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
> {
>     Name (RBUF, ResourceTemplate ()
>     {
>         WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
>             0x0000,             // Granularity
>             0x0000,             // Range Minimum
>             0x00FF,             // Range Maximum
>             0x0000,             // Translation Offset
>             0x0100,             // Length
>             ,, )
>         ......
>     })
>     Return (ResourceTemplate ()
>     {
>         WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
>             0x0000,             // Granularity
>             0x0000,             // Range Minimum
>             0x00FF,             // Range Maximum
>             0x0000,             // Translation Offset
>             0x0100,             // Length
>             ,, )
>         ......
>     })
> }
>=20
> So the named object "RBUF" is actually useless. The more natural way
> is to return RBUF instead, or simply drop RBUF definition.
>=20
> Choose the latter one to simplify the code.
>=20
> Signed-off-by: Heyi Guo <guoheyi@huawei.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-devel@nongnu.org
> ---
>  hw/arm/virt-acpi-build.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index f3e340b172..fb4b166f82 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -236,7 +236,6 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMa=
pEntry *memmap,
>                               size_mmio_high));
>      }
> =20
> -    aml_append(method, aml_name_decl("RBUF", rbuf));
>      aml_append(method, aml_return(rbuf));
>      aml_append(dev, method);
> =20
> --=20
> 2.19.1


