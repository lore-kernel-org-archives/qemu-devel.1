Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F687C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:40:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE3D92195D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ffLsnQ71"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3D92195D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWj8T-0002z3-V5
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 10:40:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWj6u-0001Rz-Kl
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:38:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWj6t-00004t-EH
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:38:40 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43531)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWj6t-0008VA-A6
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:38:39 -0500
Received: by mail-ot1-x344.google.com with SMTP id l14so14851921oti.10
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 07:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1pD54Fbas7sgzt3kUq9V6FfsWPFxMPrH/M0BmfGXJdc=;
 b=ffLsnQ71+f9vFFPY2XnobtteFoDAXJiLhYOw8TpFdK0Wxjw0uu8k57QwfDfc/ZKrWy
 gOe4598bK2zi5MB4gp88P/iIzB7zUJwkdt+ub7Z2xf1OmhftGwaV4Y0PiQ3GbyP6ziR1
 F/WqATmH0AXrgXbJyRY7XPHNQ0jqSeAAKPgzcvrBXfezSB5clE848v9sCMb0bQtbbo54
 uIve7eRJVmkDTYkaXQfWxWKTIcrCCCGApNCdKfhIq2I6vjv/ui21RRmC+H0a8Tj0y5JG
 2kDGmiEIeaujzIxKhISLPvnRyaEnfzDQaCc8O1UtxpbPgoVc/+Nqc9skWGK5H00aejMU
 ON1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1pD54Fbas7sgzt3kUq9V6FfsWPFxMPrH/M0BmfGXJdc=;
 b=tuq/Fem0MMtrMJG22EEZlDbLcpJ2ObwLZ7IAjGKugN3VwHAEkU71KUZHZiS3Q/F1UY
 b/XUkXXN3nBBbvFqeUc45hu0ICtaKHL1l5ohKCSYfej3JmrBRxrjb4aLcEL3JpmTOGz0
 lPjjaaUe0ks+kGsXAAUJscd0nF8dZxSORVmituKJEQJxHfmOGIGL6RuRoUr/YAAcvz4Z
 VmrgVivXrPYUdUCKhGaa4iY8Hh3ZoJwocuy9L8jjLqMvHkUsVQBWWwRCIky6huWMsg1z
 KdfjZGLabHDNDOXFHSi3PdYQUaUBxC7/vNkhOCsr7EkL2slen2UKxDjK9QcVCa6o86yd
 94Cw==
X-Gm-Message-State: APjAAAXjJ6KhhyVemaql8lw66CH0MKas4AAbrKWRS8Vkq2TgPBrN/G21
 +u89fe2pIK6d17ETOUFisYF/5z1m+VQpJW98ksIQ9w==
X-Google-Smtp-Source: APXvYqwmzDN/osZAAC1IxFjvX9/rJzj2b1FDncfhSwnqkS7aqAGAFPDnhn8UgA5TKKYVg8PsYYZHAQYru5MlyEj/kuE=
X-Received: by 2002:a9d:6357:: with SMTP id y23mr320752otk.91.1574091518044;
 Mon, 18 Nov 2019 07:38:38 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-26-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-26-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2019 15:38:27 +0000
Message-ID: <CAFEAcA_gW21o9KoNyRkQNEh+ZZf7Orm5fymr=v94iVmXmRtSrw@mail.gmail.com>
Subject: Re: [PATCH v3 25/33] sparc: move PIL irq handling to cpu.c
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 23 Oct 2019 at 18:34, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Rather than tweaking CPU bits from leon3 machine, move it to cpu.c.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/sparc/leon3.c          | 37 -------------------------------------
>  hw/sparc/trace-events     |  4 ----
>  target/sparc/cpu.c        | 39 +++++++++++++++++++++++++++++++++++++++
>  target/sparc/trace-events |  4 ++++
>  4 files changed, 43 insertions(+), 41 deletions(-)

> @@ -762,6 +799,8 @@ static void sparc_cpu_realizefn(DeviceState *dev, Err=
or **errp)
>      env->version |=3D env->def.nwindows - 1;
>  #endif
>
> +    env->pil_irq =3D qemu_allocate_irq(sparc_set_pil_in, env, 0);
> +

I think what I had in mind when I suggested this was that
once this was part of a DeviceState device you would then
create the IRQs with gpio_init_gpio_in_named() and
connect them on the board side with the usual gpio
connection functions.

I also don't know enough SPARC stuff to suggest whether this
irq creation should be conditional on "is this CPU a leon3"
or not.

thanks
-- PMM

