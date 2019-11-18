Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B3CC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 14:32:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 632502075E
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 14:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mkfLUFP0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632502075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWi54-0003gs-K3
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 09:32:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWi2V-0001rM-KN
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:30:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWi2R-0007DG-LP
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:30:03 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37246)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWi2R-0007Ck-Fo
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:29:59 -0500
Received: by mail-ot1-x341.google.com with SMTP id d5so14649572otp.4
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 06:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=eF8+xnntoDNkaBQUw00kLVfENwf421O4C05Y47PY7GY=;
 b=mkfLUFP027T+uear23kWrQVYvFzfU8w5//wVWgUZnOZVjBMoYaeluADixOahZOGqW6
 dSNufuNRkB9/3F/XIM/KKClFykwwwNmYMfijl7huAFwRa5hEDCc0kxtCc2DN3nKZg6So
 1ofXr4v3vt2vufQHOhTjBQym3IkXjlxrWbU4N0ulVGyG9JzrfuswCj8K/2Uu/5cF/Poe
 hO6wKPU0Ku2LxnpGS4N5phkyX/3ppQCiB7a+V8Uv7bOkbbEjOLT8Fflr0Ip56qfhsqeF
 Bk8+0sCNtsFBfDZAdb7LdK5nfUZlfyLj9TD/r9JTveK1MgWZQWmNjzmmny0aAl7UsSbN
 G2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eF8+xnntoDNkaBQUw00kLVfENwf421O4C05Y47PY7GY=;
 b=PoQQYkSydyE40lAv+/Esib9LCz50U4B5ULy3KnD4NpqFrviO6KWDZb/lku9hmYjjwu
 lNpaaUr9sO5HKdFSIcbtjfN2BrMPVly2yWF5U/tgcR/FVywKdEsXRF8TdmQh8aCjkxcH
 3/nzjxMh6cCelzA/OIte9IcA8kDNzfq/NFJgxKz0SSB+0lPtxbot+73ra2T0dZ9slmFk
 R0F2iPGix9sgd5jKRm5RrC96V/mfpBAPYlx135ehT6+8vP6AMnbWJuLP0MF8pTT10HpH
 +qe4WGNCtMuwGuh4/mRsghh06T66RH9Ntis8fbFwPJCVB/hdgCJmwBVbYFzr8VpK4e04
 aB8A==
X-Gm-Message-State: APjAAAUlDGlSkuhqmzfpIrWnNIKp2g9B7E0j22Nw9u2GwTZrVY1aBuNd
 rH4Pzu0hWij+p8lLHWS7TJnZXFwhdMOE6cTeBWyjNg==
X-Google-Smtp-Source: APXvYqyf2mvJ2nIO8S098TWxEtpke2Vopow1br62ctiMCza5QxLRH2x/tvBEJL4yjkgHi2dpupmJxDrkb+n3sgT6hG4=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr23376563otg.232.1574087397596; 
 Mon, 18 Nov 2019 06:29:57 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-11-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-11-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2019 14:29:46 +0000
Message-ID: <CAFEAcA-vhJZSKH8hDsBYVi9WKMNOFL19Q+XrwRvp94uXMbyNbA@mail.gmail.com>
Subject: Re: [PATCH v3 10/33] serial: add "instance-id" property
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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

On Wed, 23 Oct 2019 at 18:33, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> This property will be used to move common vmstate registration to
> device realize in following patch.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/char/serial.c         | 3 +++
>  include/hw/char/serial.h | 1 +
>  2 files changed, 4 insertions(+)
>
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index 069d8715d0..0b61a71e4e 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -990,6 +990,7 @@ SerialState *serial_init(int base, qemu_irq irq, int =
baudbase,
>      s->irq =3D irq;
>      qdev_prop_set_uint32(dev, "baudbase", baudbase);
>      qdev_prop_set_chr(dev, "chardev", chr);
> +    qdev_prop_set_int32(dev, "instance-id", base);
>      serial_realize_core(s, &error_fatal);
>      qdev_set_legacy_instance_id(dev, base, 2);
>      qdev_init_nofail(dev);
> @@ -1003,6 +1004,7 @@ SerialState *serial_init(int base, qemu_irq irq, in=
t baudbase,
>  static Property serial_properties[] =3D {
>      DEFINE_PROP_CHR("chardev", SerialState, chr),
>      DEFINE_PROP_UINT32("baudbase", SerialState, baudbase, 115200),
> +    DEFINE_PROP_INT32("instance-id", SerialState, instance_id, 0),

This could use an explanatory comment, because I have no
idea what it does or when a user of the device would want
or need to set it... (I am guessing that part of the answer
may be "needed only by legacy users of this device that don't
want to break migration compatibility" ?)

>      DEFINE_PROP_END_OF_LIST(),
>  };

thanks
-- PMM

