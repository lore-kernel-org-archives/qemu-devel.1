Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499B3C74A36
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 19:59:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 161EC2064B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 19:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uWTewGIm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 161EC2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlIkR-0003zf-7I
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 15:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50069)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hlIjN-0002Rb-Vs
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 15:58:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hlIjN-0002KI-03
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 15:58:21 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45991)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1hlIjM-0002Hp-PJ
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 15:58:20 -0400
Received: by mail-wr1-x444.google.com with SMTP id f9so3708094wre.12
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 12:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=gdcMbXuqdEwk6AlM4aVA/i+6qtrYQZQXFvV3/PC4Wlk=;
 b=uWTewGIm8Duye9P4686vcGDZjK0IOvkfMrnBAEU7ms+bzHN2mSfRHm8AaXDcaOfHR8
 zpG2zfm5xkDEOpu9iqnI+vrCzhocLX71h8Wp1aVyYOKzYQYJi6mDYC23ONnP6Ff/k5Xq
 GB3UVWbLwWAdWHi3R/PLLzobpJqb++kAjiqLvflMtEjpTOUF6AyibEORVdfqAF1g1aSW
 P77Oh3dCH0oD75ooAf+MbYVelioXNTar0QsKsQLYr54lnBR1aF39Ky9I3cCLTc/E7h4e
 pDn1Fu6TfscsPKoHBUSaLxtSNn4c0Rz2ry3CWHpTJzCpWcYrZ9JrkzTpf04Vs1yR+E3V
 7/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gdcMbXuqdEwk6AlM4aVA/i+6qtrYQZQXFvV3/PC4Wlk=;
 b=E/ys8Nc0m2IGxV0Ze/5huVTRCsWDNG0qfT4u6Ylyyu+UnCA5JqCevf8fm25e2Bg8R9
 b0rwFM3zRHhzx9R0vYGFx8TsbIUUYj18ES4o8ccN1mq1aBAJkXF5i4dTZfu4I8M+fQNK
 Aw5jEQjQ8V0OC8BqZwHM9Z+IJphh3He89+eNo6utgf7C57RjisHxkldbyK94mdiZFKcF
 Q7VxT9mmQ3M2Q/DTHHX9cS42+nQpF5eKUIvBI7A60kYWxRooXozUVM2ALLLZpGnofM/F
 oAM9Pzo5sisae/b7oieV0BdWewXl9BaHSHg8fgHHIvAzHv8fFmDnD4BHguzKpW1LRNZ2
 NrPA==
X-Gm-Message-State: APjAAAX7CWuxhjLH84JL1F/2zYCgDLqk8TKRMvzWAr7NK6Z7hacQrGjG
 XrlLQ5MfyIja3OiGiVyh8U9xRts6/GYlHVuE+vA=
X-Google-Smtp-Source: APXvYqzIovfv2f3wNys9Kvgm0ajLX3cq/hSxuUDYpSFQE2zY84vGXiQoC9tiJqcm/dq1me6VCgvQkMed/8CDeL4xwMg=
X-Received: by 2002:a5d:6650:: with SMTP id f16mr883502wrw.89.1562788699374;
 Wed, 10 Jul 2019 12:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1562695780.git.DirtY.iCE.hu@gmail.com>
 <090ab2fb6a10d601e68012b4152c2dba7a902ca4.1562695780.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <090ab2fb6a10d601e68012b4152c2dba7a902ca4.1562695780.git.DirtY.iCE.hu@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 10 Jul 2019 23:58:07 +0400
Message-ID: <CAJ+F1C+LZp0-0D7gkbfTKHY91FpFyeMKOQRu1NVGwMe-ycEJ1g@mail.gmail.com>
To: =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH 09/11] paaudio: fix playback glitches
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

On Tue, Jul 9, 2019 at 10:49 PM K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.i=
ce.hu@gmail.com> wrote:
>
> Pulseaudio normally assumes that when the server wants it, the client
> can generate the audio samples and send it right away.  Unfortunately
> this is not the case with QEMU -- it's up to the emulated system when
> does it generate the samples.  Buffering the samples and sending them
> from a background thread is just a workaround, that doesn't work too
> well.  Instead enable pa's compatibility support and let pa worry about
> the details.
>
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>

Could you explain how this is related to PA_STREAM_ADJUST_LATENCY ?


> ---
>  audio/paaudio.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/audio/paaudio.c b/audio/paaudio.c
> index 9d46f11b0a..d320d2e453 100644
> --- a/audio/paaudio.c
> +++ b/audio/paaudio.c
> @@ -512,10 +512,8 @@ static pa_stream *qpa_simple_new (
>
>      flags =3D
>          PA_STREAM_INTERPOLATE_TIMING
> -#ifdef PA_STREAM_ADJUST_LATENCY
> -        | PA_STREAM_ADJUST_LATENCY
> -#endif
> -        | PA_STREAM_AUTO_TIMING_UPDATE;
> +        | PA_STREAM_AUTO_TIMING_UPDATE
> +        | PA_STREAM_EARLY_REQUESTS;
>
>      if (dev) {
>          /* don't move the stream if the user specified a sink/source */
> --
> 2.22.0
>
>


--
Marc-Andr=C3=A9 Lureau

