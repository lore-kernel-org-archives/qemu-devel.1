Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A77C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:09:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E2E12051A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AiIDpOEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E2E12051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOd6l-0003vW-Rm
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 04:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOd60-0002xk-3L
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOd5y-00064i-O6
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:08:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58283
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOd5y-00062D-KC
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586938110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NLb3J6KknSIpIQG6qoJuymVTS6ocZqFv05q/r/z4pqs=;
 b=AiIDpOEgkfYd8h5iAPCeZMb92zXLhqtb7pGBM85ZzalV8L65ZTCXzbMm1bBOMYoDRzUbk7
 LV6opRHQzTwVi64WTwuNJj6s7TIhTKjF6xhZpdPcOHLP1/nSo0vdyHJYzQ50i7qrOuEGxL
 FeVhNhROT+niSBQSd6fnOU9xUPnhwqI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-A8sqlciZMVmP3Uw0g7-AdA-1; Wed, 15 Apr 2020 04:08:27 -0400
X-MC-Unique: A8sqlciZMVmP3Uw0g7-AdA-1
Received: by mail-ed1-f70.google.com with SMTP id eb6so2230431edb.12
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 01:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XHyEm8c4E+spvWhsm8X7aogjDRLmTu11yDvuSGUlUz8=;
 b=Ojj6K+qj+EYJl1DLftkIRs/7aDzYgq0HUm+yFfYUrZtIbzKUceoORhMn5a2LX3nJMT
 +7aRGtG8aka5LDEJWaxourP7QihPaLTOC8c9l8pIDhGWHK4yH5Hu3Oiua94oIjcleiGP
 M57YYtjCd84VwLrgGzKlUTfhR/hM0pmJY2M45pu6Ur6vdr3CzWUjIq4SrGPRgOClm+OZ
 w+Y2fiwwkebS+ahGPzQv2hc3Z7qX2Rb7muTsVDwLSkQcjwvSKFC26dFITZqOnxdorwkH
 lTy++1XR3L9CkcZ+5d4rhvapywo1SLL3wsmULwQYcul/dhvOD+AtE2LvEv6cjdTygZQe
 h26w==
X-Gm-Message-State: AGi0PuaMtLA10tC9bvn1mvQ04n3UtwTVDsAj73f+uD4UNVPEQPaI+cw1
 woc68SpygBNsU2cOw4ugDP5ezYKyaooDK9zu3K9HZU/3+3pxtuSz0mY1TCux/VcnEnBBln/h2sE
 Wte8BSyN72ZI5jZI=
X-Received: by 2002:a17:906:32d8:: with SMTP id
 k24mr4011970ejk.2.1586938106437; 
 Wed, 15 Apr 2020 01:08:26 -0700 (PDT)
X-Google-Smtp-Source: APiQypJbqr2FgpgRsN/uMcXjD3GMcR06aKxoFKlAZOzYy37mzCOi2Ny6ZUPLhGnoKo5U8Iac/SzqVg==
X-Received: by 2002:a17:906:32d8:: with SMTP id
 k24mr4011920ejk.2.1586938106057; 
 Wed, 15 Apr 2020 01:08:26 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id u2sm2044974edj.21.2020.04.15.01.08.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 01:08:25 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 10/12] hw/block/pflash: Check return value of
 blk_pwrite()
To: qemu-devel@nongnu.org
References: <20200414133052.13712-1-philmd@redhat.com>
 <20200414133052.13712-11-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e32b3082-6e6d-8dd0-f74c-3add72a3173d@redhat.com>
Date: Wed, 15 Apr 2020 10:08:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200414133052.13712-11-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Mansour Ahmadi <mansourweb@gmail.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Fabien Chouteau <chouteau@adacore.com>, Max Filippov <jcmvbkbc@gmail.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Stafford Horne <shorne@gmail.com>, Max Reitz <mreitz@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/14/20 3:30 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> From: Mansour Ahmadi <mansourweb@gmail.com>
>=20
> When updating the PFLASH file contents, we should check for a
> possible failure of blk_pwrite(). Similar to commit 3a688294e.
>=20

There is actually a Coverity report for this issue, CID 1357678=20
(Unchecked return value) from 2016-07-15 06:28:48:

CID 1357678 (#2 of 2): Unchecked return value (CHECKED_RETURN).=20
check_return: Calling blk_pwrite without checking return value (as is=20
done elsewhere 52 out of 59 times).

So it seems fair to add:

Reported-by: Coverity (CID 1357678 CHECKED_RETURN)

> Signed-off-by: Mansour Ahmadi <mansourweb@gmail.com>
> Message-Id: <20200408003552.58095-1-mansourweb@gmail.com>
> [PMD: Add missing "qemu/error-report.h" include and TODO comment]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   hw/block/pflash_cfi01.c | 8 +++++++-
>   hw/block/pflash_cfi02.c | 8 +++++++-
>   2 files changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 24f3bce7ef..be1954c5d8 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -42,6 +42,7 @@
>   #include "hw/qdev-properties.h"
>   #include "sysemu/block-backend.h"
>   #include "qapi/error.h"
> +#include "qemu/error-report.h"
>   #include "qemu/timer.h"
>   #include "qemu/bitops.h"
>   #include "qemu/error-report.h"
> @@ -399,13 +400,18 @@ static void pflash_update(PFlashCFI01 *pfl, int off=
set,
>                             int size)
>   {
>       int offset_end;
> +    int ret;
>       if (pfl->blk) {
>           offset_end =3D offset + size;
>           /* widen to sector boundaries */
>           offset =3D QEMU_ALIGN_DOWN(offset, BDRV_SECTOR_SIZE);
>           offset_end =3D QEMU_ALIGN_UP(offset_end, BDRV_SECTOR_SIZE);
> -        blk_pwrite(pfl->blk, offset, pfl->storage + offset,
> +        ret =3D blk_pwrite(pfl->blk, offset, pfl->storage + offset,
>                      offset_end - offset, 0);
> +        if (ret < 0) {
> +            /* TODO set error bit in status */
> +            error_report("Could not update PFLASH: %s", strerror(-ret));
> +        }
>       }
>   }
>  =20
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index 12f18d401a..c6b6f2d082 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -37,6 +37,7 @@
>   #include "hw/block/flash.h"
>   #include "hw/qdev-properties.h"
>   #include "qapi/error.h"
> +#include "qemu/error-report.h"
>   #include "qemu/bitmap.h"
>   #include "qemu/timer.h"
>   #include "sysemu/block-backend.h"
> @@ -393,13 +394,18 @@ static uint64_t pflash_read(void *opaque, hwaddr of=
fset, unsigned int width)
>   static void pflash_update(PFlashCFI02 *pfl, int offset, int size)
>   {
>       int offset_end;
> +    int ret;
>       if (pfl->blk) {
>           offset_end =3D offset + size;
>           /* widen to sector boundaries */
>           offset =3D QEMU_ALIGN_DOWN(offset, BDRV_SECTOR_SIZE);
>           offset_end =3D QEMU_ALIGN_UP(offset_end, BDRV_SECTOR_SIZE);
> -        blk_pwrite(pfl->blk, offset, pfl->storage + offset,
> +        ret =3D blk_pwrite(pfl->blk, offset, pfl->storage + offset,
>                      offset_end - offset, 0);
> +        if (ret < 0) {
> +            /* TODO set error bit in status */
> +            error_report("Could not update PFLASH: %s", strerror(-ret));
> +        }
>       }
>   }
>  =20
>=20


