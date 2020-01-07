Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3147C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:40:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C5902077B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJ2XwZQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5902077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iomHa-00084H-Jy
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 05:40:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iom0G-0001H9-0Z
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:22:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iom0E-00046u-UV
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:22:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59754
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iom0E-00046H-Qe
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:22:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578392542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bfFiZlrjL2+1me2zvC/8PzE/iU5WzxoO07KcMswUPVw=;
 b=iJ2XwZQvv+Edktw/tKqK5q8ivEITeWYNhBmbXGSNJjOFF9Alh8o9lCo6ULcMRxAFiXh/hE
 3TMlBEa/JhicjmftwRh+nbko8Hz4mJv0KanSgVbZgNvHp5y1QZwlxtzuQMI9Ux1lWGS3Mo
 clCK1Nm9M/jtPwft/8e9pT8P3tW1DTI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-8d6Zo0maP9yaO10RCkKqRw-1; Tue, 07 Jan 2020 05:22:17 -0500
Received: by mail-wr1-f69.google.com with SMTP id u12so28436809wrt.15
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 02:22:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=fQtUZKSyxRcIHhex5SLf6+Wtv5SZLUxWndPuKbjdgC4=;
 b=scGraLVX59e4gFS9ppdWfHf5G0+n+p6nJ/c8+kc40fTNCFq/PakF6pOV31Hj6+FsEe
 sUs2zdzF2X7pFJ0kcVEY+Mhia5RG8DXsYo377NZWwSPkPNxY44ih2BVlDnfG8uTe2i5L
 7x+K3Ye9G756zNL16DrpstF/hLgE3kyh2uBvSbvJ80hMBF7RuQZc8+coDhuzk/962GPL
 jpmOcsLu/2Z9KoSJkSjImUgNxzD6cGbEFoXCwilIXkR5frOw+mqE1Z4fb0boUsjlMtXd
 eETm9h8FUC5le4NB/FFQNjYlJy0GW1z4GzAtbPPEM3I4ls/OGM7MpR42y352a8KpwZrZ
 zEhw==
X-Gm-Message-State: APjAAAWDAc2r66GSW0loGmtTNhxf1n0eqbCcSm+nrDwHt+racuc2HGiR
 PkEOJ3A3kynIMWFdlExn9CdVB1pwDpy6kwfmvbg4w/etoo0jr4ZgXQrMVbGg61GETcjUc12vYbC
 4zlQHnhqhsyvEScE=
X-Received: by 2002:a7b:c946:: with SMTP id i6mr38755429wml.28.1578392536155; 
 Tue, 07 Jan 2020 02:22:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqzLKH73/xgifMEt08njgZnJmBIJaCh/jvKuYByaLpvPhpAxplIS2yEe8zZP/TbwdHLzpy8d0A==
X-Received: by 2002:a7b:c946:: with SMTP id i6mr38755407wml.28.1578392535931; 
 Tue, 07 Jan 2020 02:22:15 -0800 (PST)
Received: from steredhat
 (host221-164-dynamic.248-95-r.retail.telecomitalia.it. [95.248.164.221])
 by smtp.gmail.com with ESMTPSA id s8sm74501677wrt.57.2020.01.07.02.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 02:22:15 -0800 (PST)
Date: Tue, 7 Jan 2020 11:22:11 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] scripts/git.orderfile: Display decodetree before C source
Message-ID: <20200107102211.rpadulqbox5tquzy@steredhat>
References: <20191230082856.30556-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191230082856.30556-1-philmd@redhat.com>
X-MC-Unique: 8d6Zo0maP9yaO10RCkKqRw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Sven Schnelle <svens@stackframe.org>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Stafford Horne <shorne@gmail.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 30, 2019 at 09:28:56AM +0100, Philippe Mathieu-Daud=E9 wrote:
> To avoid scrolling each instruction when reviewing tcg
> helpers written for the decodetree script, display the
> .decode files (similar to header declarations) before
> the C source (implementation of previous declarations).
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  scripts/git.orderfile | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>=20
> diff --git a/scripts/git.orderfile b/scripts/git.orderfile
> index e89790941c..1f747b583a 100644
> --- a/scripts/git.orderfile
> +++ b/scripts/git.orderfile
> @@ -25,5 +25,8 @@ qga/*.json
>  # headers
>  *.h
> =20
> +# decoding tree specification
> +*.decode
> +
>  # code
>  *.c
> --=20
> 2.21.0
>=20
>=20


