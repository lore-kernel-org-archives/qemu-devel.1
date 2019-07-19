Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBC2C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 06:11:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A949321849
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 06:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYfNyQ7U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A949321849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoM7E-0001gq-Uc
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 02:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41010)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hoM75-0001Ci-PG
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 02:11:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hoM74-00052S-Su
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 02:11:27 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43407)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1hoM72-0004yD-Ti; Fri, 19 Jul 2019 02:11:25 -0400
Received: by mail-wr1-x441.google.com with SMTP id p13so30962446wru.10;
 Thu, 18 Jul 2019 23:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IMqib2Iv3NJCilmqP7Ijnt10gqm1wO7UAAQ2K/wwMYE=;
 b=OYfNyQ7U6w/2uUg26nEmux16sSF3D8cSFsOmKwz9gfCBs03Cy+TXA+fvHCEFF3Q+Bc
 RGeJmrfhDx0Wwjvtn1IOQBR8KMQxIAeWr9ulo4eelE/rOssMG5BcsBMYhxtzfiSVZ0hk
 1yozmyTdX4bC2CEpoplqdrgF8awblefhU/tGY8hWV4EkDdut8Q0Z0rSjx5sx9dQOAqvb
 nst6kRT5GLCFH89kmgbXfpnXDKtH3SG3dEWvgj5ax5DmoP2UfEBcLpYDu3ZU2v2WGckt
 OWknTGNpinwdR1woiCC17Ljc3UFAENmIelTXnskHK+8Uz6MOUWHxfsuuvn2WXTCUbxGA
 4vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IMqib2Iv3NJCilmqP7Ijnt10gqm1wO7UAAQ2K/wwMYE=;
 b=FzCbA1Xr7JTKrtONJS11c4Q+u+86BhiICB5l1iYrvSUxyRxcKuHoLMzGB/1axVFscM
 hga2Y+946sZiGZ6r80fbmKSPWpJ0v6Z8WzXf0pHdaGVayoFIp1vyTrOmfmdY8q3iPFaw
 hPr7BB5My043Qv/gJmZmMx0sDXU9yv4Y/3n3oo8ydU544CkXOVUEB6pmc1Q4fCiZ7m1J
 BZGt152QPUMKoKDjmmnY3lTh/ZecU18nd0DCRic1likvxIJBV2e3ylmdbTOmZWIpBaqC
 gBmI6HrpIlNhymeJ1kg3+9ywRqAt47wYL3E4s/2cjy9TaLKd6eLCZkRsmYi8l4oxb5w8
 w19Q==
X-Gm-Message-State: APjAAAWhHye6+OlIDqdDF4TLi+2rLifTVGR0d0zODqAf5z2HN9j8IaTM
 I4B3vIWruumxhfBILTO1myjZXDkftf0eNSkr4bE=
X-Google-Smtp-Source: APXvYqx9CQhzKv9t80+cFDd3sOkbTrt090XUBwCS6MVs4gj4+0iMQvQ62AInMJwCv2ndbJEpSFrnoCJbIRUBIWf41eo=
X-Received: by 2002:adf:ea8b:: with SMTP id s11mr52949925wrm.100.1563516683116; 
 Thu, 18 Jul 2019 23:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190718193441.12490-1-sw@weilnetz.de>
In-Reply-To: <20190718193441.12490-1-sw@weilnetz.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 19 Jul 2019 10:11:09 +0400
Message-ID: <CAJ+F1C+0YbsigM9A9k=4=fDHBJONRxFaOuZhRcMGFY8h=-UCBA@mail.gmail.com>
To: Stefan Weil <sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH] audio: Add missing fall through comments
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
Cc: qemu trival <qemu-trivial@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 19, 2019 at 2:12 AM Stefan Weil <sw@weilnetz.de> wrote:
>
> Signed-off-by: Stefan Weil <sw@weilnetz.de>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  audio/audio.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/audio/audio.c b/audio/audio.c
> index 5fd9a58a80..a7a13e900a 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -304,6 +304,7 @@ void audio_pcm_init_info (struct audio_pcm_info *info=
, struct audsettings *as)
>
>      case AUDIO_FORMAT_S16:
>          sign =3D 1;
> +        /* fall through */
>      case AUDIO_FORMAT_U16:
>          bits =3D 16;
>          shift =3D 1;
> @@ -311,6 +312,7 @@ void audio_pcm_init_info (struct audio_pcm_info *info=
, struct audsettings *as)
>
>      case AUDIO_FORMAT_S32:
>          sign =3D 1;
> +        /* fall through */
>      case AUDIO_FORMAT_U32:
>          bits =3D 32;
>          shift =3D 2;
> --
> 2.20.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

