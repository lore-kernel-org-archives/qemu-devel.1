Return-Path: <SRS0=iAYr=VY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491D3C433FF
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jul 2019 10:00:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 121222084C
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jul 2019 10:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8m6H6Mg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121222084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrJVG-00075q-JI
	for qemu-devel@archiver.kernel.org; Sat, 27 Jul 2019 06:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44965)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hrJV3-0006fg-GU
 for qemu-devel@nongnu.org; Sat, 27 Jul 2019 06:00:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hrJV2-0007q5-6R
 for qemu-devel@nongnu.org; Sat, 27 Jul 2019 06:00:25 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50201)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1hrJV1-0007or-UQ
 for qemu-devel@nongnu.org; Sat, 27 Jul 2019 06:00:24 -0400
Received: by mail-wm1-x344.google.com with SMTP id v15so49903825wml.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jul 2019 03:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=J9HnEN0Znsv9LovnnNYc8UwNm663ZWuhqsK7HktijJc=;
 b=a8m6H6Mg9oYUnXrvuBYPOi6hdVD6BygFhBJ9p7+ghzly4J7lqaNPubroFZLCZhKObD
 N2G70Iz1l6pSvKC2kszFQ8lI9jlSQJlHt+uyX/qjNhr2kBdkMVdDdK1PTtWVqH4W0Ah3
 cF3B119PAJl3Yi6pMF7nXbva3/4qz89lu87s13FRgBwiKenyLJJlUPvbqCCxvUm0Ddzz
 zr2KJYorjK2wwfz5PqOmdFM37sx+eYMduy4Um3lHA0ViSvDx/6r/KGemK3y8qUawa3zF
 PI2/b1RulBIfFcgI/8tXZbgL2Uiz4bKYoobT2A7net9p8xbP+mjdlDbVIhvaNtJ//hAY
 XqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=J9HnEN0Znsv9LovnnNYc8UwNm663ZWuhqsK7HktijJc=;
 b=SJ7gXNnQtAeyHMdixeS2S5IwwoBvXhp8LxKHFMWX1dodOkNvwvW7+aNDMHAoZZOhhB
 zb1eltL/QGVuCWw3kwkcicBFk3o0T6BfhjbNVw1c4jp+UdP9gNXh7UbA9l0B2XO/MwKl
 4GF+Z1U9kDSCNwNxkA8CHiYtpWsxHe0yZDhN/2L8XuaKneKUOk//7CIcXvxN7ez6U6SO
 x47tqg3HGhdQSwmciiNRaVjlcVPr2cTPCiTRtcgsSwlxkCqHaugmANiJ9Z3fAp27ywVH
 9+0J5ii+gTeTF3QTgKb+xwrlbBZ+ddeWCYmnYvZ7X2mwNgf3SomFMAZELgHZzCZ5gtu6
 LlOw==
X-Gm-Message-State: APjAAAWHHbmvwLQZX7kNRwDpa9lLAOAdHpat1SVHlMoK1kgK9xPr4Krj
 /Io5BIn31TtSaR3UMsQa8TkFE+kmL/NZmkxLOHk=
X-Google-Smtp-Source: APXvYqwpzRA4cH4Fq6Um4kG8BYYn5BaybiXI5Nokb6ft662rTKK//TMLizJDkE/vXN0a/vdcBS3L8Kw2l4GhZ8oRLfw=
X-Received: by 2002:a7b:cc81:: with SMTP id p1mr85927742wma.107.1564221621553; 
 Sat, 27 Jul 2019 03:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <759f8f44-9a01-a9f1-c7cf-65d40151a93a@web.de>
In-Reply-To: <759f8f44-9a01-a9f1-c7cf-65d40151a93a@web.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 27 Jul 2019 14:00:09 +0400
Message-ID: <CAJ+F1C+tRzRXzTWE1E7Uyvz1q_XU-6i_+utD461i-WbJ+wdR2w@mail.gmail.com>
To: Jan Kiszka <jan.kiszka@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: slirp: Remove myself as
 maintainer
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Sat, Jul 27, 2019 at 10:16 AM Jan Kiszka <jan.kiszka@web.de> wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> I haven't been doing anything here for a long time, nor does my git repo
> still play a role.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

too bad, we could still use some help ;)

thanks anyway!

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  MAINTAINERS | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6de200453..238feb965f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2089,13 +2089,11 @@ F: include/hw/registerfields.h
>
>  SLIRP
>  M: Samuel Thibault <samuel.thibault@ens-lyon.org>
> -M: Jan Kiszka <jan.kiszka@siemens.com>
>  S: Maintained
>  F: slirp/
>  F: net/slirp.c
>  F: include/net/slirp.h
>  T: git https://people.debian.org/~sthibault/qemu.git slirp
> -T: git git://git.kiszka.org/qemu.git queues/slirp
>
>  Stubs
>  M: Paolo Bonzini <pbonzini@redhat.com>
> --
> 2.16.4
>


--=20
Marc-Andr=C3=A9 Lureau

