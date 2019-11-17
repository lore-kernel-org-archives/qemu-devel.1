Return-Path: <SRS0=ZAHP=ZJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5586C432C0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2019 18:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8334E20674
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2019 18:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJv7xEdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8334E20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWPMm-0003kl-Jn
	for qemu-devel@archiver.kernel.org; Sun, 17 Nov 2019 13:33:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iWPLY-0003Fe-C7
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 13:32:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iWPLV-0006Ft-8q
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 13:32:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54111
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iWPLV-0006FF-4s
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 13:32:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574015543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SW1nwKgZ8NRu2KeWu1a7Vy4vH1Nav+Zm9LfJ9uUloqg=;
 b=aJv7xEdIMGpTDbv/CI16ZIH4zpx8nFXGchn6X9fBP2I2pZdMTZg+2fNJf9/upuZ6rgcOxs
 WVYCvJWppCCSuE88eTKQ++eWK8r73t2x30nbX19t2wDza/1VMWBffQhK6srJxoOA724/Fq
 KPnBSLIQHe1G+QLj595dfIxfEDwkjG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-vbNjmzRjMbuQLP9g330mHQ-1; Sun, 17 Nov 2019 13:32:20 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FC611005500;
 Sun, 17 Nov 2019 18:32:19 +0000 (UTC)
Received: from x1.home (ovpn-116-56.phx2.redhat.com [10.3.116.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A5100627D7;
 Sun, 17 Nov 2019 18:32:18 +0000 (UTC)
Date: Sun, 17 Nov 2019 11:32:18 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] mc146818rtc: fix timer interrupt reinjection
Message-ID: <20191117113218.3fb53864@x1.home>
In-Reply-To: <3ba4e29d-3436-9d7b-ebc0-5e1ae566e760@redhat.com>
References: <20191010123008.GA19158@amt.cnet> <20191116135855.5e16bb7c@x1.home>
 <20191117032015.GA4568@amt.cnet> <20191116213115.611d8028@x1.home>
 <3ba4e29d-3436-9d7b-ebc0-5e1ae566e760@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: vbNjmzRjMbuQLP9g330mHQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 Xiao Guangrong <guangrong.xiao@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Vadim Rozenfeld <vrozenfe@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 17 Nov 2019 11:12:43 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 17/11/19 05:31, Alex Williamson wrote:
> > The 'merge' option gives me a similar error.  The 'delay' option is
> > the only other choice where I can actually start the VM, but this
> > results in the commandline:
> >=20
> > -rtc base=3Dlocaltime
> >=20
> > (no driftfix specified) =20
>=20
> none is the default, so that's okay.
>=20
> > This does appear to resolve the issue, but of course compatibility
> > with existing configurations has regressed. Thanks, =20
>=20
> Yeah, I guess this was just a suggestion to double-check the cause of=20
> the regression.
>=20
> The problem could be that periodic_timer_update is using old_period =3D=
=3D 0=20
> for two cases: no period change, and old period was 0 (periodic timer=20
> off).
>=20
> Something like the following distinguishes the two cases by always using
> s->period (currently it was only used for driftfix=3Dslew) and passing
> s->period instead of 0 when there is no period change.
>=20
> More cleanups are possible, but this is the smallest patch that implement=
s
> the idea.  The first patch is big but, indentation changes aside, it's
> moving a single closed brace.
>=20
> Alex/Marcelo, can you check if it fixes both of your test cases?

It resolves the majority of the regression, but I think there's still a
performance issue.  Passmark PerformanceTest in the guest shows a 5+%
decrease versus a straight revert.  Thanks,

Alex

> ------------- 8< ---------------
> From 48dc9d140c636067b8de1ab8e25b819151c83162 Mon Sep 17 00:00:00 2001
> From: Paolo Bonzini <pbonzini@redhat.com>
> Date: Sun, 17 Nov 2019 10:07:38 +0100
> Subject: [PATCH 1/2] Revert "mc146818rtc: fix timer interrupt reinjection=
"
>=20
> This reverts commit b429de730174b388ea5760e3debb0d542ea3c261, except
> that the reversal of the outer "if (period)" is left in.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/rtc/mc146818rtc.c | 67 ++++++++++++++++++++++----------------------
>  1 file changed, 33 insertions(+), 34 deletions(-)
>=20
> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
> index ee6bf82b40..9869dc5031 100644
> --- a/hw/rtc/mc146818rtc.c
> +++ b/hw/rtc/mc146818rtc.c
> @@ -174,7 +174,6 @@ periodic_timer_update(RTCState *s, int64_t current_ti=
me, uint32_t old_period)
>      int64_t cur_clock, next_irq_clock, lost_clock =3D 0;
> =20
>      period =3D rtc_periodic_clock_ticks(s);
> -
>      if (!period) {
>          s->irq_coalesced =3D 0;
>          timer_del(s->periodic_timer);
> @@ -197,42 +196,42 @@ periodic_timer_update(RTCState *s, int64_t current_=
time, uint32_t old_period)
>          last_periodic_clock =3D next_periodic_clock - old_period;
>          lost_clock =3D cur_clock - last_periodic_clock;
>          assert(lost_clock >=3D 0);
> +    }
> =20
> +    /*
> +     * s->irq_coalesced can change for two reasons:
> +     *
> +     * a) if one or more periodic timer interrupts have been lost,
> +     *    lost_clock will be more that a period.
> +     *
> +     * b) when the period may be reconfigured, we expect the OS to
> +     *    treat delayed tick as the new period.  So, when switching
> +     *    from a shorter to a longer period, scale down the missing,
> +     *    because the OS will treat past delayed ticks as longer
> +     *    (leftovers are put back into lost_clock).  When switching
> +     *    to a shorter period, scale up the missing ticks since the
> +     *    OS handler will treat past delayed ticks as shorter.
> +     */
> +    if (s->lost_tick_policy =3D=3D LOST_TICK_POLICY_SLEW) {
> +        uint32_t old_irq_coalesced =3D s->irq_coalesced;
> +
> +        s->period =3D period;
> +        lost_clock +=3D old_irq_coalesced * old_period;
> +        s->irq_coalesced =3D lost_clock / s->period;
> +        lost_clock %=3D s->period;
> +        if (old_irq_coalesced !=3D s->irq_coalesced ||
> +            old_period !=3D s->period) {
> +            DPRINTF_C("cmos: coalesced irqs scaled from %d to %d, "
> +                      "period scaled from %d to %d\n", old_irq_coalesced=
,
> +                      s->irq_coalesced, old_period, s->period);
> +            rtc_coalesced_timer_update(s);
> +        }
> +    } else {
>          /*
> -         * s->irq_coalesced can change for two reasons:
> -         *
> -         * a) if one or more periodic timer interrupts have been lost,
> -         *    lost_clock will be more that a period.
> -         *
> -         * b) when the period may be reconfigured, we expect the OS to
> -         *    treat delayed tick as the new period.  So, when switching
> -         *    from a shorter to a longer period, scale down the missing,
> -         *    because the OS will treat past delayed ticks as longer
> -         *    (leftovers are put back into lost_clock).  When switching
> -         *    to a shorter period, scale up the missing ticks since the
> -         *    OS handler will treat past delayed ticks as shorter.
> +         * no way to compensate the interrupt if LOST_TICK_POLICY_SLEW
> +         * is not used, we should make the time progress anyway.
>           */
> -        if (s->lost_tick_policy =3D=3D LOST_TICK_POLICY_SLEW) {
> -            uint32_t old_irq_coalesced =3D s->irq_coalesced;
> -
> -            s->period =3D period;
> -            lost_clock +=3D old_irq_coalesced * old_period;
> -            s->irq_coalesced =3D lost_clock / s->period;
> -            lost_clock %=3D s->period;
> -            if (old_irq_coalesced !=3D s->irq_coalesced ||
> -                old_period !=3D s->period) {
> -                DPRINTF_C("cmos: coalesced irqs scaled from %d to %d, "
> -                          "period scaled from %d to %d\n", old_irq_coale=
sced,
> -                          s->irq_coalesced, old_period, s->period);
> -                rtc_coalesced_timer_update(s);
> -            }
> -        } else {
> -            /*
> -             * no way to compensate the interrupt if LOST_TICK_POLICY_SL=
EW
> -             * is not used, we should make the time progress anyway.
> -             */
> -            lost_clock =3D MIN(lost_clock, period);
> -        }
> +        lost_clock =3D MIN(lost_clock, period);
>      }
> =20
>      assert(lost_clock >=3D 0 && lost_clock <=3D period);


