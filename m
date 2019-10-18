Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C911CA9EAB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:59:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D46D3222C5
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d6+xbfA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46D3222C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLWWe-0005C0-Fb
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 13:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iLWJx-0007oo-BY
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iLWJw-0006BE-0j
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:45:49 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33049)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iLWJv-0006Ai-RF
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:45:47 -0400
Received: by mail-oi1-x241.google.com with SMTP id a15so5946004oic.0
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 10:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=JlLGVu1MR8+UuiAegXarHtWa4HEkEy/RYhkYzFlbvXY=;
 b=d6+xbfA4BTcsTB+G9upJ0mng5T7huBF/hE4ymA12v3gaiRriGX38SbImNuGQA8vv7a
 N6dB42JtJdad9uA0lJ+xZP2vh2AKxcL7VoeNQmkX9rZHGfA7uZl9gZBhw70wWGEPTx3v
 rt7Zp13UkrEwYjZHyuwe24GmPWK+d62u5x7wlTT93ovwvNhAXC80YXe6YmBryJ09lGeM
 YkJxPGOpNtVHr1Nl/22zDbcRjVokhulN75DiWexSabVUgfE4mTC2/uPrZ+b84Y7GibiI
 Q5Yn5Kw76MNATA8Xbk/P8k2TyzVWwdWMItlLR5N5qWW1ss4Z90xTRrSrglPxmp94trjF
 fHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JlLGVu1MR8+UuiAegXarHtWa4HEkEy/RYhkYzFlbvXY=;
 b=M8Jdo7iJ2VcLfE/Ma88+VH0yG31sAm2LAo7I3JpAMEt5+U7QBvm4CeCeMOU2iqBgcd
 wtpZO3NnvGnLrbeTbhjM75RsrZzA9xsEUZY50/mqOVGavK7A59/0kKJzIk0K7Ch7iLzF
 wumnVrCudUvcfIeioNjzTepnyP24HsiLMIz7X3jgxtm3Kvfk9Avx74AdRwPsNNELOL5b
 IxdICQ6XPtvH3RNzEyuCD8gY7ZfP+0E7gtx3gCbTkqaqkjjJv2attsPK4HtNWbgTBCBW
 Ph5LikxjsigzD2zE5nNZrnCqo5sk6MhuZZSEtdlxjgLQAZ3r1X1Od1JB610iW88NLnjN
 39SQ==
X-Gm-Message-State: APjAAAWlpvEJMSTzjGHvGFH65Sy2SXrHXcSFN2fCxzmsQ5ZtD1rrZjDt
 5TxJwZyBvIttJNDX/OaxBJudWf9hRMHKoHrEuearvw==
X-Google-Smtp-Source: APXvYqxogIHGqBOdu6sWKC8OPFYLTmId6R8++f1ll6BBJQZiilHLawTtKDJjEvWuwuknD1c/pQWgDnQyRrG9Z/uC8iY=
X-Received: by 2002:aca:49c2:: with SMTP id w185mr9199116oia.163.1571420746929; 
 Fri, 18 Oct 2019 10:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <20191018154212.13458-1-marcandre.lureau@redhat.com>
 <20191018154212.13458-7-marcandre.lureau@redhat.com>
In-Reply-To: <20191018154212.13458-7-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2019 18:45:35 +0100
Message-ID: <CAFEAcA-6Qes3_aiDF7a+GJQssDSJyiJeyjO9Y96=i9z+bmtipA@mail.gmail.com>
Subject: Re: [PATCH 06/14] leon3: replace PROP_PTR with PROP_LINK
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
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

On Fri, 18 Oct 2019 at 16:43, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> "set_pil_in" and "set_pil_in" are used to set a callback, but have a
> single user and cannot be modified by the user.
>
> Simplify the code by calling directly into leon3_set_pil_in(), and use
> a "cpu" link property.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/intc/grlib_irqmp.c | 20 ++++++--------------
>  hw/sparc/leon3.c      |  7 +++----
>  target/sparc/cpu.h    |  1 +
>  3 files changed, 10 insertions(+), 18 deletions(-)
>
> diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
> index bc78e1a14f..34b7e1b4e1 100644
> --- a/hw/intc/grlib_irqmp.c
> +++ b/hw/intc/grlib_irqmp.c
> @@ -58,10 +58,8 @@ typedef struct IRQMP {
>
>      MemoryRegion iomem;
>
> -    void *set_pil_in;
> -    void *set_pil_in_opaque;
> -
>      IRQMPState *state;
> +    SPARCCPU *cpu;
>  } IRQMP;
>
>  struct IRQMPState {
> @@ -82,7 +80,6 @@ static void grlib_irqmp_check_irqs(IRQMPState *state)
>      uint32_t      pend   =3D 0;
>      uint32_t      level0 =3D 0;
>      uint32_t      level1 =3D 0;
> -    set_pil_in_fn set_pil_in;
>
>      assert(state !=3D NULL);
>      assert(state->parent !=3D NULL);
> @@ -97,13 +94,11 @@ static void grlib_irqmp_check_irqs(IRQMPState *state)
>      trace_grlib_irqmp_check_irqs(state->pending, state->force[0],
>                                   state->mask[0], level1, level0);
>
> -    set_pil_in =3D (set_pil_in_fn)state->parent->set_pil_in;
> -
>      /* Trigger level1 interrupt first and level0 if there is no level1 *=
/
>      if (level1 !=3D 0) {
> -        set_pil_in(state->parent->set_pil_in_opaque, level1);
> +        leon3_set_pil_in(state->parent->cpu, level1);
>      } else {
> -        set_pil_in(state->parent->set_pil_in_opaque, level0);
> +        leon3_set_pil_in(state->parent->cpu, level0);
>      }
>  }
>
> @@ -348,14 +343,13 @@ static void grlib_irqmp_realize(DeviceState *dev, E=
rror **errp)
>      IRQMP *irqmp =3D GRLIB_IRQMP(dev);
>
>          /* Check parameters */
> -    if (irqmp->set_pil_in =3D=3D NULL) {
> -        error_setg(errp, "set_pil_in cannot be NULL.");
> +    if (irqmp->cpu =3D=3D NULL) {
> +        error_setg(errp, "cpu cannot be NULL.");
>      }
>  }

>  static Property grlib_irqmp_properties[] =3D {
> -    DEFINE_PROP_PTR("set_pil_in", IRQMP, set_pil_in),
> -    DEFINE_PROP_PTR("set_pil_in_opaque", IRQMP, set_pil_in_opaque),
> +    DEFINE_PROP_LINK("cpu", IRQMP, cpu, TYPE_SPARC_CPU, SPARCCPU *),
>      DEFINE_PROP_END_OF_LIST(),
>  };

This is using ptr properties to define a callback
mechanism where the device says "call the callback
function, passing it an opaque cookie and a
32-bit value". We already have a generic mechanism
for doing that, which is the qemu_irq. So we should
just use that instead of adding a link property between
the interrupt controller and the CPU.

(Bonus further cleanup: the code currently in
leon3_set_pil_in() should probably be part of the
SPARC CPU object itself, as a handler for an inbound
gpio line, as then you could just wire the qemu_irq
from the interrupt controller to the CPU. But you
can leave it as ad-hoc code in leon3.c for now.)

thanks
-- PMM

