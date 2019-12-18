Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD295C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:41:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 842D12082E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjhAPuZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 842D12082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihfCW-0007w9-Lr
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 14:41:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ihf7k-0002Er-2I
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:36:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ihf7i-0007F0-PF
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:36:43 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43639)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ihf7i-0007B3-EZ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:36:42 -0500
Received: by mail-oi1-x241.google.com with SMTP id x14so1729851oic.10
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 11:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zMRM82fuISdTXQ2oCk9rZrPdp71flIE7raxY+pJuYXk=;
 b=QjhAPuZDdlOJLpIBeU6tW8FOG0zC2M7Ea72/EO8pvfjlw5MvRMuN7hvazOyc6hr23L
 rBHdGC0cHK801cod2ehDIIvlVNQgjkIWYr4c1qDv0oUog4KfZYnEG8yPjUSia9BvSrwz
 l93rpJ3fW4MujkyEDhUMojpN8ugN7hDpyb3OD0/8zjW6+gyh9QZahPs6alC5am91x0gH
 93OkAgGem6DfUV1eZdt4+40Ve//DJpzsLqHiRNhDOJK6RGlP57rreH13f+gXR/LvvPQu
 kq8DmoKcihp2g41uzvOY/NdCb7EEt8ZmuCoQ0k5y8BBLRlOy4ZCPM2xEodOHJHYsM4O0
 A5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zMRM82fuISdTXQ2oCk9rZrPdp71flIE7raxY+pJuYXk=;
 b=R2xoCqXcae6ormvk1x2FSd+K5SvCsGmLDkczOLMGfk++y+QpDkBPHvDg1MbN67FO8f
 CQReYxzrqebRkvPoiAY0IxzRcdg6Fzy4RfCuwOnArM4i95IK1YmwM3qNSmk5BRQOl7SA
 usfaCfrTMEfenJW2fv3EDeDGkqCI//ilXvDehwBPQF1zf17X8VHPMFeLLFJNu0/+rv8a
 LJeVNcMLHWe/iCkamEIWfLRFQJ1O78ukTwlT4sKvxOjH2e9FT6JADR4Qjc1KuMvejVLg
 9NyWBbCBsljxHlCzljJ9GcCwhVK0694ZfqKiGI4gNAww5AWympiJ2s2vj0q+mOH2YeEY
 9Mgw==
X-Gm-Message-State: APjAAAWCYh9nmW8x/IAqY7JsvvbzPh/mnIXneaql/bL5pDVtelVjGeQZ
 XMoWE2Am+SxK7Ft2wE9lHkBIBBXAJVdXuAbjFNQ=
X-Google-Smtp-Source: APXvYqzzezAh6rRUoD4ux7uDVmWind6RXCS9r2Wb5LmBWE4ayishj9Nqw/FdgBxWWqKqrlDYI/1A4jkI+n0yISp73lc=
X-Received: by 2002:aca:bbc6:: with SMTP id l189mr1331670oif.53.1576697801751; 
 Wed, 18 Dec 2019 11:36:41 -0800 (PST)
MIME-Version: 1.0
References: <20191218192526.13845-1-philmd@redhat.com>
 <20191218192526.13845-2-philmd@redhat.com>
In-Reply-To: <20191218192526.13845-2-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 18 Dec 2019 20:36:30 +0100
Message-ID: <CAL1e-=j2j5O2CZvXPBZa2Sg6Ah8_MjjJjf6Fb2bAFMfR7Bowpw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] audio/audio: Add missing fall through comment
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 18, 2019 at 8:26 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> When building with GCC9 using CFLAG -Wimplicit-fallthrough=3D2 we get:
>
>   audio/audio.c: In function =E2=80=98audio_pcm_init_info=E2=80=99:
>   audio/audio.c:306:14: error: this statement may fall through [-Werror=
=3Dimplicit-fallthrough=3D]
>     306 |         sign =3D 1;
>         |         ~~~~~^~~
>   audio/audio.c:307:5: note: here
>     307 |     case AUDIO_FORMAT_U8:
>         |     ^~~~
>   cc1: all warnings being treated as errors
>
> Similarly to e46349414, add the missing fall through comment to
> hint GCC.
>
> Fixes: 2b9cce8c8c
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: Reword the description (Aleksandar)
>

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

> Cc: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: "K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n" <dirty.ice.hu@gmail.com>
> ---
>  audio/audio.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/audio/audio.c b/audio/audio.c
> index 56fae55047..57daf3f620 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -304,6 +304,7 @@ void audio_pcm_init_info (struct audio_pcm_info *info=
, struct audsettings *as)
>      switch (as->fmt) {
>      case AUDIO_FORMAT_S8:
>          sign =3D 1;
> +        /* fall through */
>      case AUDIO_FORMAT_U8:
>          mul =3D 1;
>          break;
> --
> 2.21.0
>

