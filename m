Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454C3C76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:27:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 125DB21849
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r2PWhrEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 125DB21849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoSvA-0001UX-6J
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35524)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hoSut-0000Wx-Lf
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:27:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hoSus-0000hC-Kt
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:27:19 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36179)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hoSus-0000gO-Dd
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:27:18 -0400
Received: by mail-ot1-x343.google.com with SMTP id r6so32728957oti.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 06:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3iJes9TBAmHxPIxu+PzOit8mMntNWTqXpnPXCuxWDJ8=;
 b=r2PWhrEjm2P9FCPPDTCdkL3+w4DfRn4z/JgvDdVDBBo6M3G5oQrAZEYV6YJmplvhVI
 KpSNcjZTrUTIlsJ5VDwvQkEHIeCRNss6GRdOLyKtQhHJ4QmaN4G/6uCaG9eiktIyAIby
 XAbmkyjObBecRjp50ZLhOHJym8jOR8huEXzQF+BM3FXAHaSInAYKyDD7urBCQSQXpvpx
 l24b4T4vgvtN1TytrW1wHhutYc5n3D9K2T7YCQ2XEXgTmuNHtNEcd6DooisiHCJOynI7
 Ae4oPq28mxU2Ad1C7qWKjX53bp9IkEVm/DXfzHTSdYr62HmPy+pVq+ucmLzrUp53cMwY
 D6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3iJes9TBAmHxPIxu+PzOit8mMntNWTqXpnPXCuxWDJ8=;
 b=rKY/mDzBjoAoHz81UYvaygk3ncdF6barkrErtakKCHobwBUGv6sGzVQhPG++JfkWyT
 IlVRCMJIXN4i8Yeo1HPEBM4SUjaHYZV1Q66WAYmqKVbSfRQU/0m3nLPqTKoNObJoDi0A
 4Ru6EXmBX0XHKvaWPlD4GmE57oVNAeZmbltIg+rxwIbNJozxyZzZiO/ZD4XKGM+FXZOt
 lwJYTTkZy6yK2iejAAcv3bY85qxf4cPJw5tB8yKYOPnHRHQcwTKkC/TrJiueDXGPoJ2+
 MjRxOIECDcargqKkrmORRJTZ5QVs5N3gTKvzcgoDW2JlNapEHplqVfO4+Gs7S3EkabF8
 IaPQ==
X-Gm-Message-State: APjAAAWyiWUPaKF0Xs86AvC09NO9/KyUkRQXot/LoWJ3UxG1YzEpjV7+
 J5oQhcRBBSS9xygoSG30U/bDGExwDQfJ7gGiqcF8DQ==
X-Google-Smtp-Source: APXvYqw17AicZXZeb0Qps+ZpCk7n92TNb1aqu+nNpU+WNh7n9UWSnkKWZ8aAcPB7/4h4ALnN32G8JTT3L/LOZiHugjs=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr36901471otj.97.1563542837424; 
 Fri, 19 Jul 2019 06:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190719131425.10835-1-philmd@redhat.com>
 <20190719131425.10835-3-philmd@redhat.com>
In-Reply-To: <20190719131425.10835-3-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jul 2019 14:27:06 +0100
Message-ID: <CAFEAcA9oa=f4JQ8whrChb_1-6eOBq13PuGoLu41E6fnQUyGFag@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH-for-4.1? 2/7] hw/dma/omap_dma: Move switch
 'fall through' comment to correct place
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Corey Minyard <minyard@acm.org>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 19 Jul 2019 at 14:14, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Reported by GCC9 when building with CFLAG -Wimplicit-fallthrough=3D2:
>
>     CC      hw/dma/omap_dma.o
>   hw/dma/omap_dma.c: In function =E2=80=98omap_dma_write=E2=80=99:
>   hw/dma/omap_dma.c:1532:12: error: this statement may fall through [-Wer=
ror=3Dimplicit-fallthrough=3D]
>    1532 |         if (s->model <=3D omap_dma_3_1)
>         |            ^
>   hw/dma/omap_dma.c:1534:5: note: here
>    1534 |     case 0x400:
>         |     ^~~~
>   cc1: all warnings being treated as errors
>
> Correctly place the 'fall through' comment.
>
> Reported-by: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/dma/omap_dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
> index eab83c5c3a..6677237d42 100644
> --- a/hw/dma/omap_dma.c
> +++ b/hw/dma/omap_dma.c
> @@ -1531,8 +1531,8 @@ static void omap_dma_write(void *opaque, hwaddr add=
r,
>      case 0x404 ... 0x4fe:
>          if (s->model <=3D omap_dma_3_1)
>              break;
> +        /* fall through */
>      case 0x400:
> -        /* Fall through. */
>          if (omap_dma_sys_write(s, addr, value))
>              break;
>          return;
> -

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

