Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E69C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 21:49:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED4CD222DC
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 21:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCqAUk+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED4CD222DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWotY-0003Jv-UH
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 16:49:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mtosatti@redhat.com>) id 1iWosn-0002v9-TU
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:48:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mtosatti@redhat.com>) id 1iWosi-0006WU-Mg
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:48:26 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34658
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mtosatti@redhat.com>) id 1iWosh-0006Uk-7d
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574113699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KNZnScmtFOst140DX1no7pFMRl6KOjraQTMXnJZY0qA=;
 b=iCqAUk+oKG1DDYUH846sn5HDHOhNIMjfBs+D6heL3Csx2jo+v/WESqbZe0X5abnGQVU/5m
 rI3/VGaoLHIMx7mdQCYE8VWZ/nln3HDBNjJsMbunmfBDw9INY7U07d246aLE0At7MjUfNK
 7yblD/Ipc5z/UcohMD9k4D/Q2VxAMW4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-NsIm6r_9NO-jhf3Fwy2mrQ-1; Mon, 18 Nov 2019 16:48:15 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 977A28E8046;
 Mon, 18 Nov 2019 21:48:14 +0000 (UTC)
Received: from amt.cnet (ovpn-112-7.gru2.redhat.com [10.97.112.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E95860BF4;
 Mon, 18 Nov 2019 21:48:11 +0000 (UTC)
Received: from amt.cnet (localhost [127.0.0.1])
 by amt.cnet (Postfix) with ESMTP id E17E210037D;
 Mon, 18 Nov 2019 19:44:39 -0200 (BRST)
Received: (from marcelo@localhost)
 by amt.cnet (8.14.7/8.14.7/Submit) id xAILiZoh018516;
 Mon, 18 Nov 2019 19:44:35 -0200
Date: Mon, 18 Nov 2019 19:44:30 -0200
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] mc146818rtc: fix timer interrupt reinjection
Message-ID: <20191118214428.GA15341@amt.cnet>
References: <20191010123008.GA19158@amt.cnet> <20191116135855.5e16bb7c@x1.home>
 <20191117032015.GA4568@amt.cnet> <20191116213115.611d8028@x1.home>
 <3ba4e29d-3436-9d7b-ebc0-5e1ae566e760@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3ba4e29d-3436-9d7b-ebc0-5e1ae566e760@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: NsIm6r_9NO-jhf3Fwy2mrQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Xiao Guangrong <guangrong.xiao@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Vadim Rozenfeld <vrozenfe@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Nov 17, 2019 at 11:12:43AM +0100, Paolo Bonzini wrote:
> On 17/11/19 05:31, Alex Williamson wrote:
> > The 'merge' option gives me a similar error.  The 'delay' option is
> > the only other choice where I can actually start the VM, but this
> > results in the commandline:
> >=20
> > -rtc base=3Dlocaltime
> >=20
> > (no driftfix specified)
>=20
> none is the default, so that's okay.
>=20
> > This does appear to resolve the issue, but of course compatibility
> > with existing configurations has regressed. Thanks,
>=20
> Yeah, I guess this was just a suggestion to double-check the cause of=20
> the regression.
>=20
> The problem could be that periodic_timer_update is using old_period =3D=
=3D 0=20
> for two cases: no period change, and old period was 0 (periodic timer=20
> off).


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

Second patch blocks NTPd from synchronizing to a source at all
(can't even confirm if it fails to synchronize after a while).

Problem seems to be that calling from timer interrupt path:

   /*
     * if the periodic timer's update is due to period re-configuration,
     * we should count the clock since last interrupt.
     */
    if (old_period) {
        int64_t last_periodic_clock, next_periodic_clock;

        next_periodic_clock =3D muldiv64(s->next_periodic_time,
                                RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
        last_periodic_clock =3D next_periodic_clock - old_period;
        lost_clock =3D cur_clock - last_periodic_clock;
        assert(lost_clock >=3D 0);
    }

Adds the difference between when the timer interrupt actually executed=20
(cur_clock) and when it should have executed (last_periodic_clock)=20
as reinject time (which will end up injecting more timer interrupts=20
than necessary, so the clock runs faster than it should).

Perhaps this is the reason for the 5%+ performance delta?

The following, on top of Paolo's two patches, fixes it for me
(and NTPd is able to maintain clock synchronized while playing video on Win=
dows 7).

Alex perhaps you can give it a try?

--- hw/rtc/mc146818rtc.c.orig=092019-11-18 19:16:49.077479836 -0200
+++ hw/rtc/mc146818rtc.c=092019-11-18 19:22:35.706803090 -0200
@@ -168,7 +168,7 @@
  * is just due to period adjustment.
  */
 static void
-periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_peri=
od)
+periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_peri=
od, bool period_change)
 {
     uint32_t period;
     int64_t cur_clock, next_irq_clock, lost_clock =3D 0;
@@ -190,7 +190,7 @@
      * if the periodic timer's update is due to period re-configuration,
      * we should count the clock since last interrupt.
      */
-    if (old_period) {
+    if (old_period && period_change) {
         int64_t last_periodic_clock, next_periodic_clock;
=20
         next_periodic_clock =3D muldiv64(s->next_periodic_time,
@@ -246,7 +246,7 @@
 {
     RTCState *s =3D opaque;
=20
-    periodic_timer_update(s, s->next_periodic_time, s->period);
+    periodic_timer_update(s, s->next_periodic_time, s->period, false);
     s->cmos_data[RTC_REG_C] |=3D REG_C_PF;
     if (s->cmos_data[RTC_REG_B] & REG_B_PIE) {
         s->cmos_data[RTC_REG_C] |=3D REG_C_IRQF;
@@ -512,7 +512,7 @@
=20
             if (update_periodic_timer) {
                 periodic_timer_update(s, qemu_clock_get_ns(rtc_clock),
-                                      old_period);
+                                      old_period, true);
             }
=20
             check_update_timer(s);
@@ -551,7 +551,7 @@
=20
             if (update_periodic_timer) {
                 periodic_timer_update(s, qemu_clock_get_ns(rtc_clock),
-                                      old_period);
+                                      old_period, true);
             }
=20
             check_update_timer(s);
@@ -805,7 +805,7 @@
         uint64_t now =3D qemu_clock_get_ns(rtc_clock);
         if (now < s->next_periodic_time ||
             now > (s->next_periodic_time + get_max_clock_jump())) {
-            periodic_timer_update(s, qemu_clock_get_ns(rtc_clock), s->peri=
od);
+            periodic_timer_update(s, qemu_clock_get_ns(rtc_clock), s->peri=
od, false);
         }
     }
=20


