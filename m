Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336B6C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:47:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2BC42072A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ice6Vnaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2BC42072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipWHt-0000HB-V6
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 06:47:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33753)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ipWFn-0006VT-GU
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:45:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ipWFm-0002A6-Az
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:45:31 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53183
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ipWFl-00026k-W4
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:45:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578570329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RZqLtbvqfVwf1HSTemK5FAk0N0yMCdPmxVDSRhQf/qE=;
 b=ice6VnajDj7TIW20mUxLmwrI1IFM5oPBqGi197eF6aAk8fR0EWdxP0tvde7Jr//dJYmqq2
 3bpdB72+ASa2XZ8RWj7t3S5beAJM51SMq89H/V6wzbmSQHkgmxr4VSlRJHfqBbxJLbwcJV
 8Mfh1d43Sn1ai6HGZ8sg2ylu1M/IJww=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-ZruEADVbNfCXSiwcvq42ew-1; Thu, 09 Jan 2020 06:45:25 -0500
Received: by mail-qv1-f72.google.com with SMTP id v5so3933583qvn.21
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 03:45:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CUoAUFp5BIo2VOiZXqSb9QN+CPDWLn4/QBozFf5eSIQ=;
 b=itx6e27k9E9bcVpskdckqPa9jXqslwfkMiVeTuZZqvuhOUMiJTNIFLIuwNT5Aij82/
 Aw1Z7s0tRakz6K82xjcacrKxCxPLB5zmheznKPIbYQiUerNDrFUCL5VIBvbpkm6LgA3D
 3QqyttZECDHJ/XdXZBeyMxbBvxz1Lqrk4vIEXiZAjQsE8MDylM7oQY2RAAhGH2lm2Vao
 Y/+DEz4UyOaK07AcCo4ba/gyCQRZUSBW+A/ChtTMEYKe6qwOxtIMWGa9+Zl6eqVqTn1U
 Gy9ARccQaY5PXG2LWbdzSNmEXbVwllVhIbwHbFFpF+ohAzMPb5pzJFU/ShiG21L9Dvrm
 v76Q==
X-Gm-Message-State: APjAAAX8Dp0cVqbfqiHvsanBqACV+8Sn2G0Nn+yeGFYOQjmGIM2ekwJE
 TkQoLHLXYFUOYD6/b5IBoLf4K3O1WJEDRHhbIyjDqwuReKzV+pUG1B0QMe3TEaBF2touHNV+nk4
 mTNVhsq8yGRrGBSI=
X-Received: by 2002:aed:2fa1:: with SMTP id m30mr7250676qtd.211.1578570324792; 
 Thu, 09 Jan 2020 03:45:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqy9jJKn2P82fySN35ebfvMqLwMtI/FKZW/elJJj2O7v3QalqiqS6pu2ww+1j6Ady1spi71UPA==
X-Received: by 2002:aed:2fa1:: with SMTP id m30mr7250659qtd.211.1578570324629; 
 Thu, 09 Jan 2020 03:45:24 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id x42sm3259337qtc.25.2020.01.09.03.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 03:45:23 -0800 (PST)
Date: Thu, 9 Jan 2020 06:45:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 1/2] vhost: Don't pass ram device sections
Message-ID: <20200109064425-mutt-send-email-mst@kernel.org>
References: <20200108135353.75471-1-dgilbert@redhat.com>
 <20200108135353.75471-2-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200108135353.75471-2-dgilbert@redhat.com>
X-MC-Unique: ZruEADVbNfCXSiwcvq42ew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: jasowang@redhat.com, vkuznets@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 08, 2020 at 01:53:52PM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Don't pass RAM blocks that are marked as ram devices to vhost.
> There's normally something special about them and they're not
> normally just shared memory.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

So I think this is good by itself.

> ---
>  hw/virtio/vhost.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 4da0d5a6c5..c81f0be71b 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -402,6 +402,7 @@ static bool vhost_section(struct vhost_dev *dev, Memo=
ryRegionSection *section)
>      bool log_dirty =3D memory_region_get_dirty_log_mask(section->mr) &
>                       ~(1 << DIRTY_MEMORY_MIGRATION);
>      result =3D memory_region_is_ram(section->mr) &&
> +        !memory_region_is_ram_device(section->mr) &&
>          !memory_region_is_rom(section->mr);
> =20
>      /* Vhost doesn't handle any block which is doing dirty-tracking othe=
r
> --=20
> 2.24.1


