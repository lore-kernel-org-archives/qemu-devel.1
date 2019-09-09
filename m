Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F159C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:21:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D8512089F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mzCbHvZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8512089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7NMH-0002lL-8N
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 13:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i7NJX-0000Yy-R4
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i7NJW-00026p-KT
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:18:55 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43859)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i7NJW-000269-Fe
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:18:54 -0400
Received: by mail-ot1-x344.google.com with SMTP id b2so13284736otq.10
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 10:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rNkcwzhkOVl7tsc7aupKbRHPCUUgaEQGvFm2mebX6q4=;
 b=mzCbHvZ5ETX8i2G1LNEuUFyYH+svyQl2/kBcV1b0Yic3+s6q4E1DRye/JeHbVzA+Pw
 OwiH6MPd084KJQKFgRaV9g7tZcd+LfrqIW8rbGQ3Vv7Aewia+6YtgjJ5daCE0fDshtrW
 dvMwQoJMQoWi2oiWcY1drBeyEKt6I/WWmVe6YqeSIVxyG7xqtTpIca60YplXUMDOUSuU
 ymLyG134BneohWHu0qXVRBTIefppJKQdIdxVrdasKluOz6Oudljq+WOKxk2DxDE/UFG9
 CGTsZumh/UhL2DjoyPmdnvrxJZd9EYazfY+AbM2Pb2nfr3yNOINoylXdt5mR2fBj5O9N
 mOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rNkcwzhkOVl7tsc7aupKbRHPCUUgaEQGvFm2mebX6q4=;
 b=SWpZjCD4q0D4ciP5uUJPShlur6CMAD2kNK4p+Uk4EA/mdWjoEqTUf3rOYgrNHKgA6g
 E/+NMIG/xOhp3EuhBscpP1vYg9EK2pH0XmiSHalyCjJZZJzzmPAcAX5JSF3vMzDx9rPp
 O9P4TyKdkooWBKuSdbNoxSkx1zz3UeusDfj/mRxFzSk3OhdNAM7xJaODvZ4yJzHsGZKS
 i4jvNy1M1n14ODI7Ti29CkCPAa4mlROf3nYBlKkHyhvf/ck47dsLkvAGwx6kF8XHW3iZ
 FK+41YVGmDmuqiEUYnSDPxf7MfiWlbp4c1VJ7AeFGmuTPNlt7fGFiKqEdi3FDX4snauF
 KHkQ==
X-Gm-Message-State: APjAAAW7JWVnnjtqpaAWITq/3Sgq3LTBjzAGohUILePqELGdJU8HI6J+
 ud5vk1zzNoGWARSddrM1UdZtsu7KoLp0U0qfd2MwNw==
X-Google-Smtp-Source: APXvYqx8BwLutzIOZW/MZG8qjAbPDcWcbLCCFdwvuWyzNds3Js+5dqaZn8MWOaOhmJ9zwRkBy4ArZdXkQ4/+NcSYPPs=
X-Received: by 2002:a9d:68d6:: with SMTP id i22mr11404372oto.232.1568049533461; 
 Mon, 09 Sep 2019 10:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190821084113.1840-1-kraxel@redhat.com>
 <20190821084113.1840-4-kraxel@redhat.com>
In-Reply-To: <20190821084113.1840-4-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Sep 2019 18:18:42 +0100
Message-ID: <CAFEAcA-FmO5wdC2YJJpTYDMg0EY0_LyK=y-nBP78cfdqSkk6CA@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PULL 03/15] audio: basic support for multi
 backend audio
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
Cc: "Daniel P. Berrangé" <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Kővágó@redhat.com, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Walle <michael@walle.cc>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Zoltán <DirtY.iCE.hu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 21 Aug 2019 at 09:49, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> From: Kővágó, Zoltán <dirty.ice.hu@gmail.com>
>
> Audio functions no longer access glob_audio_state, instead they get an
> AudioState as a parameter.  This is required in order to support
> multiple backends.
>
> glob_audio_state is also gone, and replaced with a tailq so we can store
> more than one states.
>
> Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
> Message-id: 67aef54f9e729a7160fe95c465351115e392164b.1566168923.git.DirtY.iCE.hu@gmail.com
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Hi; Coverity spotted an issue in this patch:


> diff --git a/audio/audio_template.h b/audio/audio_template.h
> index c721fed75d7d..54f07338e76f 100644
> --- a/audio/audio_template.h
> +++ b/audio/audio_template.h
> @@ -428,7 +428,7 @@ SW *glue (AUD_open_, TYPE) (
>      struct audsettings *as
>      )
>  {
> -    AudioState *s = &glob_audio_state;
> +    AudioState *s = card->state;

Here we dereference 'card'...

>      AudiodevPerDirectionOptions *pdo = glue(audio_get_pdo_, TYPE)(s->dev);
>
>      if (audio_bug(__func__, !card || !name || !callback_fn || !as)) {

...but that is before this check on whether card is NULL.
The deref needs to go after the NULL-check.

This is issues CID 1405305 and 1405301 (one each for
AUD_open_in and AUD_open_out).

thanks
-- PMM

