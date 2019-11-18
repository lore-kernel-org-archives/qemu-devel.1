Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE55C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 23:29:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECBCE22303
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 23:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3TeRiZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBCE22303
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWqSR-0005Kx-5D
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 18:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iWqRc-0004v2-4u
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 18:28:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iWqRY-0000Vb-1x
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 18:28:29 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31751
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iWqRW-0000TW-Hi
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 18:28:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574119703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KLfF9HDxN++9cz3Zg/f/3Byzkkj3Ks7BllDOAl0eDfs=;
 b=M3TeRiZT94rqrZquEL+9AV7kOg07ZFkZSW9vgGUwsmI+DOUUTPRyCbEFyPgD3xVMdl//CE
 fUs3iygZ4/HUi7ev2PFoCYYFzEf+GBi9hZzKgBFGnwcRhYHcZBBNFsOPeXgMCg0Oi9iJcu
 10kLsWZYw6fi/awHp+443VNODhtL7n0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-Ka18Hme6Msihge5bXf8bOw-1; Mon, 18 Nov 2019 18:28:22 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E215107ACC6;
 Mon, 18 Nov 2019 23:28:21 +0000 (UTC)
Received: from x1.home (ovpn-116-56.phx2.redhat.com [10.3.116.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC0F35D9E5;
 Mon, 18 Nov 2019 23:28:20 +0000 (UTC)
Date: Mon, 18 Nov 2019 16:28:20 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v2] mc146818rtc: fix timer interrupt reinjection
Message-ID: <20191118162820.76691082@x1.home>
In-Reply-To: <20191118214428.GA15341@amt.cnet>
References: <20191010123008.GA19158@amt.cnet> <20191116135855.5e16bb7c@x1.home>
 <20191117032015.GA4568@amt.cnet> <20191116213115.611d8028@x1.home>
 <3ba4e29d-3436-9d7b-ebc0-5e1ae566e760@redhat.com>
 <20191118214428.GA15341@amt.cnet>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Ka18Hme6Msihge5bXf8bOw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Xiao Guangrong <guangrong.xiao@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Vadim Rozenfeld <vrozenfe@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 Nov 2019 19:44:30 -0200
Marcelo Tosatti <mtosatti@redhat.com> wrote:

> On Sun, Nov 17, 2019 at 11:12:43AM +0100, Paolo Bonzini wrote:
> > On 17/11/19 05:31, Alex Williamson wrote: =20
> > > The 'merge' option gives me a similar error.  The 'delay' option is
> > > the only other choice where I can actually start the VM, but this
> > > results in the commandline:
> > >=20
> > > -rtc base=3Dlocaltime
> > >=20
> > > (no driftfix specified) =20
> >=20
> > none is the default, so that's okay.
> >  =20
> > > This does appear to resolve the issue, but of course compatibility
> > > with existing configurations has regressed. Thanks, =20
> >=20
> > Yeah, I guess this was just a suggestion to double-check the cause of=
=20
> > the regression.
> >=20
> > The problem could be that periodic_timer_update is using old_period =3D=
=3D 0=20
> > for two cases: no period change, and old period was 0 (periodic timer=
=20
> > off). =20
>=20
>=20
> > Something like the following distinguishes the two cases by always usin=
g
> > s->period (currently it was only used for driftfix=3Dslew) and passing
> > s->period instead of 0 when there is no period change.
> >=20
> > More cleanups are possible, but this is the smallest patch that impleme=
nts
> > the idea.  The first patch is big but, indentation changes aside, it's
> > moving a single closed brace.
> >=20
> > Alex/Marcelo, can you check if it fixes both of your test cases? =20
>=20
> Second patch blocks NTPd from synchronizing to a source at all
> (can't even confirm if it fails to synchronize after a while).
>=20
> Problem seems to be that calling from timer interrupt path:
>=20
>    /*
>      * if the periodic timer's update is due to period re-configuration,
>      * we should count the clock since last interrupt.
>      */
>     if (old_period) {
>         int64_t last_periodic_clock, next_periodic_clock;
>=20
>         next_periodic_clock =3D muldiv64(s->next_periodic_time,
>                                 RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
>         last_periodic_clock =3D next_periodic_clock - old_period;
>         lost_clock =3D cur_clock - last_periodic_clock;
>         assert(lost_clock >=3D 0);
>     }
>=20
> Adds the difference between when the timer interrupt actually executed=20
> (cur_clock) and when it should have executed (last_periodic_clock)=20
> as reinject time (which will end up injecting more timer interrupts=20
> than necessary, so the clock runs faster than it should).
>=20
> Perhaps this is the reason for the 5%+ performance delta?
>=20
> The following, on top of Paolo's two patches, fixes it for me
> (and NTPd is able to maintain clock synchronized while playing video on W=
indows 7).
>=20
> Alex perhaps you can give it a try?

Yes, Paolo's two patches plus this seems to resolve both the functional
and performance issues.  Thanks,

Alex
=20
> --- hw/rtc/mc146818rtc.c.orig=092019-11-18 19:16:49.077479836 -0200
> +++ hw/rtc/mc146818rtc.c=092019-11-18 19:22:35.706803090 -0200
> @@ -168,7 +168,7 @@
>   * is just due to period adjustment.
>   */
>  static void
> -periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_pe=
riod)
> +periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_pe=
riod, bool period_change)
>  {
>      uint32_t period;
>      int64_t cur_clock, next_irq_clock, lost_clock =3D 0;
> @@ -190,7 +190,7 @@
>       * if the periodic timer's update is due to period re-configuration,
>       * we should count the clock since last interrupt.
>       */
> -    if (old_period) {
> +    if (old_period && period_change) {
>          int64_t last_periodic_clock, next_periodic_clock;
> =20
>          next_periodic_clock =3D muldiv64(s->next_periodic_time,
> @@ -246,7 +246,7 @@
>  {
>      RTCState *s =3D opaque;
> =20
> -    periodic_timer_update(s, s->next_periodic_time, s->period);
> +    periodic_timer_update(s, s->next_periodic_time, s->period, false);
>      s->cmos_data[RTC_REG_C] |=3D REG_C_PF;
>      if (s->cmos_data[RTC_REG_B] & REG_B_PIE) {
>          s->cmos_data[RTC_REG_C] |=3D REG_C_IRQF;
> @@ -512,7 +512,7 @@
> =20
>              if (update_periodic_timer) {
>                  periodic_timer_update(s, qemu_clock_get_ns(rtc_clock),
> -                                      old_period);
> +                                      old_period, true);
>              }
> =20
>              check_update_timer(s);
> @@ -551,7 +551,7 @@
> =20
>              if (update_periodic_timer) {
>                  periodic_timer_update(s, qemu_clock_get_ns(rtc_clock),
> -                                      old_period);
> +                                      old_period, true);
>              }
> =20
>              check_update_timer(s);
> @@ -805,7 +805,7 @@
>          uint64_t now =3D qemu_clock_get_ns(rtc_clock);
>          if (now < s->next_periodic_time ||
>              now > (s->next_periodic_time + get_max_clock_jump())) {
> -            periodic_timer_update(s, qemu_clock_get_ns(rtc_clock), s->pe=
riod);
> +            periodic_timer_update(s, qemu_clock_get_ns(rtc_clock), s->pe=
riod, false);
>          }
>      }
> =20


