Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50087C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:17:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B259218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ea3pvbPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B259218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvgN-0002No-88
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1ihvAG-0000tg-HO
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:44:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1ihvAE-0002Xq-5j
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:44:23 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36821
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1ihvAD-0002RY-Tn
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:44:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576759455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rfdRneFSm7RFKRJ/UNsH3LyVkWPGx2Jtz+vbjGMWQ2g=;
 b=Ea3pvbPAA5ZM/FfZ+7gllV5z7E+Kee32A11/InVpHRfgrIU4bSYRK4j1tqXO5PodCaWbCy
 cgHs9BVRI81Hk2gJeY5IUCMCaovmO2iIF2SFwYCZWgMVT3iIVz2ckJC4uxTDk6D3Nbho2B
 3cKdPAaybIsGcX7DW3pOk8p4KTyO6cI=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-D4HstsbpMD-BNT2kYYGbng-1; Thu, 19 Dec 2019 07:44:12 -0500
Received: by mail-oi1-f197.google.com with SMTP id v14so2700506oic.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 04:44:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rfdRneFSm7RFKRJ/UNsH3LyVkWPGx2Jtz+vbjGMWQ2g=;
 b=RVpDKSzRLDkY8wfK9mdGszJeE4jEJ0ULWS2MdOsZdHiPPpmy/T8iDNqZDpizkGr2EJ
 yQ4xc7MFWfrWJrV/ZGm6zQumkYp/59mZ/a3xl/H2h7rWS++7xUvmPF1/WljwAZurXGF1
 i/gkO4D2sCr2kRjLPeuW7kOJ70pFFqkSVo+tvt+S/qV7KsjNkhm1Hu2hjACpomMJPvip
 d/61v/cTjpWa84ZAPOZKiIDBrKi3b6BW+E1fjlQj/cabE0dQ7huh72dfzMkffj9T1c3A
 SrQbglhc4Ns7VCEbpRruuVJaprE5n/i4fKHwtuwkH2Q10iFeNSI5NJOvrvVopge7aStU
 fKAA==
X-Gm-Message-State: APjAAAWv2E6w0AqQ9EbNTbreNd7jtDoD1ODxcJOIOAAKsIOrxRrtlr25
 Sp3hA8FpcBkC29rnh0g1XOFaaMU54P1lrWs0SdDA/TMY9s/3KyyWcRfYV9q5XKtvjNgsRZzKiTx
 J9Imp8qQM3A5KM8MEKBwCOdxRtdBCgII=
X-Received: by 2002:a05:6830:56a:: with SMTP id
 f10mr8178220otc.368.1576759451985; 
 Thu, 19 Dec 2019 04:44:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqzV5wevwD1e28DFJESfpZriIX3gPczD4NQ7qzgfopl21W6k+56tfXxfxdkROnom60Cmpdpk5qPa1gSdOnx71+M=
X-Received: by 2002:a05:6830:56a:: with SMTP id
 f10mr8178202otc.368.1576759451779; 
 Thu, 19 Dec 2019 04:44:11 -0800 (PST)
MIME-Version: 1.0
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-28-marcandre.lureau@redhat.com>
 <CAFEAcA-k5tHOzAoUERk2MGx8BPjHUvWELgvgONfLS_UQMmJRuA@mail.gmail.com>
 <c2b7f742-917a-fb20-4f0a-2b4bef7a1a62@redhat.com>
In-Reply-To: <c2b7f742-917a-fb20-4f0a-2b4bef7a1a62@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 19 Dec 2019 16:44:00 +0400
Message-ID: <CAMxuvawnv_xRozGhkD2tmxNGkSdEK=LfUNCNdiJ1SbMOsRVZWw@mail.gmail.com>
Subject: Re: [PATCH v4 27/37] leon3: use qdev gpio facilities for the PIL
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-MC-Unique: D4HstsbpMD-BNT2kYYGbng-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Dec 15, 2019 at 10:10 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 11/21/19 2:51 PM, Peter Maydell wrote:
> > On Wed, 20 Nov 2019 at 15:30, Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@redhat.com> wrote:
> >>
> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> ---
> >>   hw/sparc/leon3.c   | 6 ++++--
> >>   target/sparc/cpu.h | 1 -
> >>   2 files changed, 4 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> >> index cac987373e..1a89d44e57 100644
> >> --- a/hw/sparc/leon3.c
> >> +++ b/hw/sparc/leon3.c
> >> @@ -230,8 +230,10 @@ static void leon3_generic_hw_init(MachineState *m=
achine)
> >>
> >>       /* Allocate IRQ manager */
> >>       dev =3D qdev_create(NULL, TYPE_GRLIB_IRQMP);
> >> -    env->pil_irq =3D qemu_allocate_irq(leon3_set_pil_in, env, 0);
> >> -    qdev_connect_gpio_out_named(dev, "grlib-irq", 0, env->pil_irq);
> >> +    qdev_init_gpio_in_named_with_opaque(DEVICE(env), leon3_set_pil_in=
,
> >> +                                        env, "pil", 1);
> >> +    qdev_connect_gpio_out_named(dev, "grlib-irq", 0,
> >> +                                qdev_get_gpio_in_named(DEVICE(env), "=
pil", 0));
> >>       qdev_init_nofail(dev);
> >>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_IRQMP_OFFSET);
> >>       env->irq_manager =3D dev;
> >
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> >
> > Creating a gpio pin on some object that isn't yourself
> > looks a bit odd, but all this leon3 code is modifying
> > the CPU object from the outside anyway. Someday we might
> > tidy it up, but not today.
>
> Watch out, while SPARCCPU inherits DeviceState from CPUState,
> env does not: it is not QDEV but a CPUSPARCState object.
>
> If you replace both DEVICE(env) uses by DEVICE(cpu), your patch looks saf=
e.
>
> If you agree with the change:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

good catch (it was actually already fixed in my branch ;)
thanks


