Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F8EC2D0B1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 06:32:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0F3D20838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 06:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQUGGQ+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F3D20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izxC4-0003z0-VV
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 01:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1izxBF-0003Xl-Lj
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 01:31:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1izxBE-0005df-92
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 01:31:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29356
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1izxBD-0005Z7-Ud
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 01:31:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581057115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yHXKTHRbvU/hlnHBEG8DGvXYaMI9x8xVzvJo+Od69yo=;
 b=eQUGGQ+w1tzF334zWqNIsdHwRHTFaCK0I1pEcRguaXAStH9KxkeuEi5F5q9V0hLCxZkSp0
 EEMBTnb1VK082aGoBqE1Rt/tmq6Vqo3xYxDszBCdRb0/v40ErsFwXRkNR4ejzFTFNsEKXs
 RwTv8ZgXN5tVy6ssDB+RNdknuP0I104=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-5wfRVQEdMpquwWRaTbtquw-1; Fri, 07 Feb 2020 01:31:48 -0500
Received: by mail-qk1-f197.google.com with SMTP id i11so736106qki.12
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 22:31:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=oS7Qa3s3lP9mfsFjCIvdVqUNKWJ3iUBI/IivcbVebqY=;
 b=J4TlAS9jRiW5cbEqwt3E9zDZOcLGx9kTi02Vc9nGTDzmJZnrjoAl7ImNKQ2b9B51eu
 J5AwD4TmN44Yd9LheAu3S0splLa5FHcsWawFWPl2HW4H6i6gbTCqsMLnzSAR1CuCs785
 CemDeECqezy67zYsRaMtGMJmkK/Xdy3R3AWtCYo99z8rb/+pm9rGQagpuWVhnhMI0Wqh
 uZ8km5dljAC6xPXzJmwFhEOMMTIfYmSRN7Cb6xj1X9gxKcf4ABfMvp9Fv/QGyn6BV9b+
 IX8OLD3Cgre7ZDqAXeCkRUfUnGZVCiZBPhG9BNjr9iXo0eBJD30XKjv6T6edKZTcK/lj
 LSJA==
X-Gm-Message-State: APjAAAU0IG+FDfx2rWot6ogUU0eX/zLcTFnNx5LcUTAJ5Swi6O7Jwwsb
 zYH94ojP1os8yA6Y3vphIVhiVoZKDpDacrJdg+sLMRQ5As/VLyfEgjEe3bIqzR27WJQAHGPsLuP
 /RXy3exNeE6T+12c=
X-Received: by 2002:a05:620a:14a6:: with SMTP id
 x6mr6206173qkj.206.1581057107994; 
 Thu, 06 Feb 2020 22:31:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqxTJY+AuhxAif36QdUP1VpEy8aRsoPd9bVIeR3jUMQGQR9/+dM5sqbKHdodkWapbsUDaadwfA==
X-Received: by 2002:a05:620a:14a6:: with SMTP id
 x6mr6206149qkj.206.1581057107728; 
 Thu, 06 Feb 2020 22:31:47 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id h4sm924493qtp.24.2020.02.06.22.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 22:31:46 -0800 (PST)
Date: Fri, 7 Feb 2020 01:31:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2] hw/core: Allow setting 'virtio-blk-device.scsi'
 property on OSX host
Message-ID: <20200207013044-mutt-send-email-mst@kernel.org>
References: <20200207001404.1739-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200207001404.1739-1-philmd@redhat.com>
X-MC-Unique: 5wfRVQEdMpquwWRaTbtquw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
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
Cc: Cornelia Huck <cohuck@redhat.com>, stefanha@redhat.com,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 07, 2020 at 01:14:04AM +0100, Philippe Mathieu-Daud=E9 wrote:
> Commit ed65fd1a2750 ("virtio-blk: switch off scsi-passthrough by
> default") changed the default value of the 'scsi' property of
> virtio-blk, which is only available on Linux hosts. It also added
> an unconditional compat entry for 2.4 or earlier machines.
>=20
> Trying to set this property on a pre-2.5 machine on OSX, we get:
>=20
>    Unexpected error in object_property_find() at qom/object.c:1201:
>    qemu-system-x86_64: -device virtio-blk-pci,id=3Dscsi0,drive=3Ddrive0: =
can't apply global virtio-blk-device.scsi=3Dtrue: Property '.scsi' not foun=
d
>=20
> Fix this error by marking the property optional.
>=20
> Fixes: ed65fd1a27 ("virtio-blk: switch off scsi-passthrough by default")
> Suggested-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Stefan I think this makes sense in your tree same as
the original patch it's fixing. Right?

> ---
> v2: Reworded description (Cornelia)
>=20
> Extracted from testing series:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg675074.html
> ---
>  hw/core/machine.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 3e288bfceb..d8e30e4895 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -148,7 +148,8 @@ GlobalProperty hw_compat_2_5[] =3D {
>  const size_t hw_compat_2_5_len =3D G_N_ELEMENTS(hw_compat_2_5);
> =20
>  GlobalProperty hw_compat_2_4[] =3D {
> -    { "virtio-blk-device", "scsi", "true" },
> +    /* Optional because the 'scsi' property is Linux-only */
> +    { "virtio-blk-device", "scsi", "true", .optional =3D true },
>      { "e1000", "extra_mac_registers", "off" },
>      { "virtio-pci", "x-disable-pcie", "on" },
>      { "virtio-pci", "migrate-extra", "off" },
> --=20
> 2.21.1


