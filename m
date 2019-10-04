Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EB9C47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 13:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4465B21D81
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 13:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPTLhJsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4465B21D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGNI6-0004dH-1R
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 09:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iGNFK-00039l-W9
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 09:03:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iGNFJ-0002iw-OA
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 09:03:46 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39137)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iGNFJ-0002iO-HK
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 09:03:45 -0400
Received: by mail-wm1-x343.google.com with SMTP id v17so5775082wml.4
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 06:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=J2cky8nSQ3EenkBPpT9k/0lVQ3W7KE5ctgjFEd9nMdU=;
 b=lPTLhJsVNSpH3yJP53ev234v2A7n9fliucte5MnGR+Hez3yzzUcgijaRGuBO7w3SrW
 V7uKjNJ23g1J8a77dLOdXgNolUf/3TE4OZvHgaRK24FYDp+Ka8Z0NXzj+FJYomAmmcSB
 PYXvfJK2x1qHCdnwjOOw/Ag2tSb2POe4YljxLu071XbqmzcoqMIoDGvyPbyonJZ7jyoy
 RRs1++78wioqdWEUrryOoS+aQVJIRwat4b6hG7o3HzyX269H/ZDUn/WQDRcmLEgFCaZI
 AZgQQnNoBVEkc8f22oqquoBPP3d7baS1nb2XwNpwKzWAxtPgYboG6SCPLGJFl9iL8Nlk
 L+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=J2cky8nSQ3EenkBPpT9k/0lVQ3W7KE5ctgjFEd9nMdU=;
 b=U9YakgzyK1AFYvxZKlQoVcXojJsJrzQMfuIC7WM457klI/81n1t/Z3/5gq+0CdjQE3
 xtet7e0ZfJpgvwvPOcH10dsv1/sijVUs6ozhM3v0zCClQBZAHy4OqqXRyiDux3/2UQae
 zuWfRGXQEb3oKs6ZQr1Yp5qxWy2yygV6DU6jlNeLacbOr25CcOIWWt2y29OO/R1Sbi3X
 eRLobbBVU2d7wKsrWogkuUOtgcVVqcC77Xvlh4UekHvriFjP6Y2DvGl4XsFVwqUrprqv
 3QqH9VtZkaS0QEUbXddmhC7sRUXdSMSL66SY+UCukTs1N1DpUzqZlPlRROjGVxuWvW5m
 ZFzQ==
X-Gm-Message-State: APjAAAXaNSan9uFjNqwPSoGKFeE7aU3cIGBI8D/QgE54+dse1PU/1ZUQ
 Jl23iFVP40DFtOZGZemqcqZPstDJrDXX28GBh5k=
X-Google-Smtp-Source: APXvYqwP2A4LlVHUOtHi5PkifQdKIeU8U9qXF+oMnWr7or98CSFx8DN6RburjLLEVmu59G1i3jiYx600IXOuzG40fI0=
X-Received: by 2002:a1c:2388:: with SMTP id
 j130mr10374779wmj.107.1570194223975; 
 Fri, 04 Oct 2019 06:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191004125641.24383-1-stefanha@redhat.com>
In-Reply-To: <20191004125641.24383-1-stefanha@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 4 Oct 2019 17:03:30 +0400
Message-ID: <CAJ+F1C+UZhVL0+UAo=cosSfeupck+kHbFcZ3D6vqo+2f8UV_-g@mail.gmail.com>
Subject: Re: [PATCH] audio: add -audiodev pa,in|out.latency= to documentation
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, Oct 4, 2019 at 4:57 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The "latency" parameter wasn't covered by the documentation.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> Hi Gerd,
> You asked me to resend this patch because there was a conflict.  I have
> rebased it onto qemu.git/master (4f59102571fc).
>
>  qemu-options.hx | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 2a04ca6ac5..5c27c57273 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -470,6 +470,7 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
>      "-audiodev pa,id=3Did[,prop[=3Dvalue][,...]]\n"
>      "                server=3D PulseAudio server address\n"
>      "                in|out.name=3D source/sink device name\n"
> +    "                in|out.latency=3D desired latency in microseconds\n=
"
>  #endif
>  #ifdef CONFIG_AUDIO_SDL
>      "-audiodev sdl,id=3Did[,prop[=3Dvalue][,...]]\n"
> @@ -630,6 +631,10 @@ Sets the PulseAudio @var{server} to connect to.
>  @item in|out.name=3D@var{sink}
>  Use the specified source/sink for recording/playback.
>
> +@item in|out.latency=3D@var{usecs}
> +Desired latency in microseconds.  The PulseAudio server will try to hono=
r this
> +value but actual latencies may be lower or higher.

default is 15ms according to f6142777659f2e7ad143f2850f1f036f899f475f,
might be worth to document.

otherwise, looks good:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> +
>  @end table
>
>  @item -audiodev sdl,id=3D@var{id}[,@var{prop}[=3D@var{value}][,...]]
> --
> 2.21.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

