Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B14CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41FD420663
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OgIOkOSi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41FD420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLVEe-0002Xk-7t
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 12:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iLVD9-0001OI-R7
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:34:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iLVD8-0002Uo-M8
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:34:43 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46842)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iLVD8-0002UF-D0
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:34:42 -0400
Received: by mail-ot1-x343.google.com with SMTP id 89so5451527oth.13
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 09:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MQDgG+VSoz7w0pvjeuYNnntQyuijU7xkSpl329/x290=;
 b=OgIOkOSi+iyFO2vxzwq/U3ZHFOe4/f96QtXsVoYbxC1S+5kynZFEVlnlxxMw9l+IAq
 f3gdLJYsyZfyoMOzpTS4Bv6tjFREe6Tp++VzaWKKEyuuWou3flAlhu8zSTOA38l++KsI
 +gtLdOCCkkHMf5eVvVzEi3J3e+a3taSTArjCO7/ZGsos6RSaG1R2itcnho1JWv7jLoSh
 aEPfJc34gNdtLYiYC0nFT+xop42Fz0ZcxFvl5dfTxDvljrekZbmnQwtrgRVej2vi9AJN
 g2Uq5++FUE00PtW5Z92MQLpQKOJCqDi8NgO1fEV224rzlVK62UxPH/tjp9vV745e5Ion
 cjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MQDgG+VSoz7w0pvjeuYNnntQyuijU7xkSpl329/x290=;
 b=cBNAB/+xlE/Zur4fqodexuL1rBzZxmSuzSF/8pWjOM1JZhmLPl3jaITxCi/65cOSVu
 MU6ICRkXEOsTY8FrFtqjXlPwKunzauoviJjUES3IaRl3g6IzgiR3teIWFQ4UmPQURlOc
 nK5IepR2W+nd/hAIVyOQovmeErH1LSdHr98A8Q2I7L4nu1Wo6v+k/otGLiQJnk8rAy1y
 eDIFB7S1YdDCySu2kVgcuoVuTwjn/50A1dN2DTqMrNHKy9flOqjcAzn/f6PfQShed5nH
 1cSjh6q84pAei4qBcYUV7jJxYD76TRjIjnPoPxHTuhQXKpMCYTz9qL2hkJvaxQFzLSpO
 E1iQ==
X-Gm-Message-State: APjAAAV68C6TwtlqJKBGLxDhTg55ZVZJDzHqsHdjgZnyc5YkDbeQw4Sm
 0Y94LfoMbttp77OTEoapeuLoskPuN61c2q4u4/tKFQ==
X-Google-Smtp-Source: APXvYqxEPwkOi/lrcnRV2nbqGhCwgvetTqD/3OkvnxIFpsN4u/lxGJmYWSG1ZU9ipZn8wMOd2wFLKQu+A/L+793ND98=
X-Received: by 2002:a05:6830:4c1:: with SMTP id
 s1mr8722180otd.232.1571416481493; 
 Fri, 18 Oct 2019 09:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20191018154212.13458-1-marcandre.lureau@redhat.com>
 <20191018154212.13458-5-marcandre.lureau@redhat.com>
 <CAFEAcA-Qaq0W-4kpRGSQTxzH1LZ3znoxZo6Fnd4NmnnE4O_G9w@mail.gmail.com>
 <CAJ+F1CL8AdRv8ktb8V0Ox7XZEO7GOXqPjVd=_CsZ=oSmHxtP_Q@mail.gmail.com>
In-Reply-To: <CAJ+F1CL8AdRv8ktb8V0Ox7XZEO7GOXqPjVd=_CsZ=oSmHxtP_Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2019 17:34:30 +0100
Message-ID: <CAFEAcA8+ZegXJRKTJ7pKLFZ6DdeP2VFxnRz5q21Z7tDt_mUpqQ@mail.gmail.com>
Subject: Re: [PATCH 04/14] etraxfs: remove PROP_PTR usage
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Magnus Damm <magnus.damm@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 at 17:11, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
> Is there really much difference between:
>
> dev =3D qdev_create()
> qdev_prop_set_ptr(dev, "prop", ptr);
> qdev_init_nofail()
>
> and
>
> dev =3D qdev_create(MYDEV)
> MYDEV(dev)->prop =3D ptr;
> qdev_init_nofail()

One is easier to grep for than the other if you're
looking for things we need to fix :-)

I've just replied to patch 1 of this set with a reply that
gives my general objections which are the same for this patch
as that one; it's probably less confusing if we keep the
conversation in that thread rather than conducting it along
two parallel tracks (my fault for not reading the whole
series first; I should probably have replied to the cover
letter).

thanks
-- PMM

