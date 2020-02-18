Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF15C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:56:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7BED20659
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZEG1ofHs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7BED20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3zce-0006ue-PD
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:56:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1j3zbN-0004QZ-U6
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:55:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1j3zbM-0003Ae-Kd
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:55:37 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29098
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1j3zbM-00039i-Fe
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:55:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582019736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7cJzAc12RVZRNEnjQBJhzyiL3IOCizN0eERxIa09ET0=;
 b=ZEG1ofHs+LC6qQawtVNyVTFn7I5L3wzfANjepgtTM0wg7agrQuLo9PJ8DzDwg10AXaf3cX
 G/Kc3ftXvO3xnPFzJgT8FzeTSHTMbMtb3kcJx83jD72C4UdoXwesITDvKhFkq8XhxTmYGd
 D8165w+Rv8i4Av2wjd9zxO/XwWVqcb0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-psAqnPbNNi6zQBjjnYtLDg-1; Tue, 18 Feb 2020 04:55:33 -0500
Received: by mail-wr1-f70.google.com with SMTP id 50so10575288wrc.2
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 01:55:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=HgFqoSoARH3uk7odBpEdG6HCEcZqvIBJgyeE0i3cD20=;
 b=eD2Kd0RxifdrMI0dAX2BzL8tD27fUllQI5sIpmLdR7Kjs04e+ff34nty2anGlDuJG/
 mpIZj+zhALMbeVaLXy82nXV3eY+1x+aYQRdRL/Q/LBeIEbRDuKMMzzBG9t+wgn4hqJ1X
 zRhJHtIWrLx1p+eYQGc03HOSPx/NjHP7G8AjdQvRBgg33a3M5kxkaUBzB/xkM7gQ8J5G
 H0PtVv7iZ1g12dQXL/r6OYfwg2ieQY7k97/PoRKa2TjUmFH64IXXiY34dDxbcnRhbbXt
 I0iawzqFNkCPNjfde2MdWc1q8l3IlR8QUS1YVdU46GkDF5kafvT/GEElC98OwNZootZx
 5stQ==
X-Gm-Message-State: APjAAAUdHSJQK9Nft/crYn2kOzgc98PD3+a2iTC1bo1A0eR8CBf5LMAr
 CLA/U6LH+4snSTZk/Gsq5z6wvtZ9mbazukYS9AZf4Pn8yQGEiAoD3xpq/uiYuKI6YR3qWkK7Bwo
 S4xurVvMqU3PUkBI=
X-Received: by 2002:adf:a453:: with SMTP id e19mr27305872wra.305.1582019732646; 
 Tue, 18 Feb 2020 01:55:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqzZIgwzQofXO7sILwU2QL82ipDu8k4lihQNI4Pu2DEIWsf5g/MijuhSe9qBXuQpibLr2FwL4A==
X-Received: by 2002:adf:a453:: with SMTP id e19mr27305806wra.305.1582019732327; 
 Tue, 18 Feb 2020 01:55:32 -0800 (PST)
Received: from steredhat (host209-4-dynamic.27-79-r.retail.telecomitalia.it.
 [79.27.4.209])
 by smtp.gmail.com with ESMTPSA id 25sm2912651wmi.32.2020.02.18.01.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 01:55:31 -0800 (PST)
Date: Tue, 18 Feb 2020 10:55:28 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH RESEND 04/13] block/io_uring: Remove superfluous semicolon
Message-ID: <20200218095528.3i26z4shmvqznput@steredhat>
References: <20200218094402.26625-1-philmd@redhat.com>
 <20200218094402.26625-5-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200218094402.26625-5-philmd@redhat.com>
X-MC-Unique: psAqnPbNNi6zQBjjnYtLDg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Julia Suvorova <jusual@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 18, 2020 at 10:43:53AM +0100, Philippe Mathieu-Daud=E9 wrote:
> Fixes: 6663a0a3376
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  block/io_uring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>=20
> diff --git a/block/io_uring.c b/block/io_uring.c
> index 56892fd1ab..a3142ca989 100644
> --- a/block/io_uring.c
> +++ b/block/io_uring.c
> @@ -187,7 +187,7 @@ static void luring_process_completions(LuringState *s=
)
>                      ret =3D 0;
>                  }
>              } else {
> -                ret =3D -ENOSPC;;
> +                ret =3D -ENOSPC;
>              }
>          }
>  end:
> --=20
> 2.21.1
>=20


