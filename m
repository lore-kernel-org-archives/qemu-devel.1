Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC65BC43141
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 22:09:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98EF5208CD
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 22:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tu+NCKco"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98EF5208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWpCt-0002ad-Ra
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 17:09:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iWpCA-00028Y-KH
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 17:08:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iWpC8-000759-8H
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 17:08:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50259
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iWpC8-000751-0h
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 17:08:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574114907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=Xvuq2snESy1ImhUKhjUoDBfO847tkuNFJfGqets2amk=;
 b=Tu+NCKco57SZTPgrdZTtN/xIuxvGw/+i/2xIZNOp2tc+Pi/+jOMr5b71D2CDbzKlHT13pq
 EMIPuZR6uDatStE4UyFFSUPsAQgTpMmExS3Ymp9rC9b1Sqgol6JKUnfAVpFvf6Hq0z6FB3
 Q3boIxf3uR3Yp7rT+kk0Ufw4CcPQplo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-medByIk_OiK7rNeau7kyQw-1; Mon, 18 Nov 2019 17:08:26 -0500
Received: by mail-wr1-f71.google.com with SMTP id e10so16706363wrt.16
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 14:08:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lYPlYQWOWNmRSpC7c56y0xM/BnNOJSaaHWCavbFlXYA=;
 b=sD0OjuMuNVDNQTdS2Ik3Evv7/bmU+lseEGGzeQjIqNkOd/UZe0CdzEVo+22jk3jqa/
 5eeFQdK3Ua1FpzlGKoBxVRVd0VJQ2Baxpf1TYbPUpWDtFUYB+Jo6jXEnwxHDzDaZqv3f
 uqHRkNt0dT+sYcYCXimtY+APY54kcUOWa+ha0Fvw95jnYJGQ4kG/n+Ti0I7P1RhyTOEa
 lIHFE4How8azd329XRovmV4cp93IvPp+Tp5nteR6SvcOYNPbiYA8MRuYvTjITP8zi09a
 7+SBDA7DWMQ38kcZWpDDrqf/e9+/KofcdaICLkD/zBT5ZFyCxxFl8V6a1GWdwGbmZwwh
 c0uQ==
X-Gm-Message-State: APjAAAX+S0fypwmZNsTX6soR8PRlUdyXmTGIaOo/pR1AHf0HYhdmco9V
 BwOql3a6dj+cNgorLfPawI8YorSu+HrOyXV15qGSrBhXzWKx4sPkSAvvw0QRqUPmEV0Xl+vTFL2
 IH6rFItROhGclqqg=
X-Received: by 2002:a7b:ce11:: with SMTP id m17mr1836581wmc.113.1574114904880; 
 Mon, 18 Nov 2019 14:08:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqw/jdicZePbuq+bicfH6PzZxcGRIYu+uKZ45WyA3XGNKKOMMV7fu5KRL6iaw7poCDHda8LvJQ==
X-Received: by 2002:a7b:ce11:: with SMTP id m17mr1836554wmc.113.1574114904466; 
 Mon, 18 Nov 2019 14:08:24 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a15b:f753:1ac4:56dc?
 ([2001:b07:6468:f312:a15b:f753:1ac4:56dc])
 by smtp.gmail.com with ESMTPSA id j11sm24315614wrq.26.2019.11.18.14.08.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2019 14:08:23 -0800 (PST)
Subject: Re: [PATCH v2] mc146818rtc: fix timer interrupt reinjection
To: Marcelo Tosatti <mtosatti@redhat.com>
References: <20191010123008.GA19158@amt.cnet>
 <20191116135855.5e16bb7c@x1.home> <20191117032015.GA4568@amt.cnet>
 <20191116213115.611d8028@x1.home>
 <3ba4e29d-3436-9d7b-ebc0-5e1ae566e760@redhat.com>
 <20191118214428.GA15341@amt.cnet>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <1bbda036-35f7-7e3e-3fa3-c111e6c24c35@redhat.com>
Date: Mon, 18 Nov 2019 23:08:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191118214428.GA15341@amt.cnet>
Content-Language: en-US
X-MC-Unique: medByIk_OiK7rNeau7kyQw-1
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Xiao Guangrong <guangrong.xiao@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Vadim Rozenfeld <vrozenfe@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/11/19 22:44, Marcelo Tosatti wrote:
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

Yes, I made a similar reasoning.  Thanks for the patch, I don't like=20
that it adds complication over complication but I guess it would be okay=20
for 4.2, if Alex confirms it works for him.  Mine is a much bigger
change .

> Perhaps this is the reason for the 5%+ performance delta?
>=20
> The following, on top of Paolo's two patches, fixes it for me
> (and NTPd is able to maintain clock synchronized while playing video on W=
indows 7).

FYI, here is my attempt at cleaning up everything:

------------------- 8< ----------------
From c0a53b1c9a331ac4cf5846b477ba0fb795933a34 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 17 Nov 2019 10:07:38 +0100
Subject: [PATCH 1/5] Revert "mc146818rtc: fix timer interrupt reinjection"

This reverts commit b429de730174b388ea5760e3debb0d542ea3c261, except
that the reversal of the outer "if (period)" is left in.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/rtc/mc146818rtc.c | 67 ++++++++++++++++++++++++++----------------------=
----
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index ee6bf82..9869dc5 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -174,7 +174,6 @@ periodic_timer_update(RTCState *s, int64_t current_time=
, uint32_t old_period)
     int64_t cur_clock, next_irq_clock, lost_clock =3D 0;
=20
     period =3D rtc_periodic_clock_ticks(s);
-
     if (!period) {
         s->irq_coalesced =3D 0;
         timer_del(s->periodic_timer);
@@ -197,42 +196,42 @@ periodic_timer_update(RTCState *s, int64_t current_ti=
me, uint32_t old_period)
         last_periodic_clock =3D next_periodic_clock - old_period;
         lost_clock =3D cur_clock - last_periodic_clock;
         assert(lost_clock >=3D 0);
+    }
=20
+    /*
+     * s->irq_coalesced can change for two reasons:
+     *
+     * a) if one or more periodic timer interrupts have been lost,
+     *    lost_clock will be more that a period.
+     *
+     * b) when the period may be reconfigured, we expect the OS to
+     *    treat delayed tick as the new period.  So, when switching
+     *    from a shorter to a longer period, scale down the missing,
+     *    because the OS will treat past delayed ticks as longer
+     *    (leftovers are put back into lost_clock).  When switching
+     *    to a shorter period, scale up the missing ticks since the
+     *    OS handler will treat past delayed ticks as shorter.
+     */
+    if (s->lost_tick_policy =3D=3D LOST_TICK_POLICY_SLEW) {
+        uint32_t old_irq_coalesced =3D s->irq_coalesced;
+
+        s->period =3D period;
+        lost_clock +=3D old_irq_coalesced * old_period;
+        s->irq_coalesced =3D lost_clock / s->period;
+        lost_clock %=3D s->period;
+        if (old_irq_coalesced !=3D s->irq_coalesced ||
+            old_period !=3D s->period) {
+            DPRINTF_C("cmos: coalesced irqs scaled from %d to %d, "
+                      "period scaled from %d to %d\n", old_irq_coalesced,
+                      s->irq_coalesced, old_period, s->period);
+            rtc_coalesced_timer_update(s);
+        }
+    } else {
         /*
-         * s->irq_coalesced can change for two reasons:
-         *
-         * a) if one or more periodic timer interrupts have been lost,
-         *    lost_clock will be more that a period.
-         *
-         * b) when the period may be reconfigured, we expect the OS to
-         *    treat delayed tick as the new period.  So, when switching
-         *    from a shorter to a longer period, scale down the missing,
-         *    because the OS will treat past delayed ticks as longer
-         *    (leftovers are put back into lost_clock).  When switching
-         *    to a shorter period, scale up the missing ticks since the
-         *    OS handler will treat past delayed ticks as shorter.
+         * no way to compensate the interrupt if LOST_TICK_POLICY_SLEW
+         * is not used, we should make the time progress anyway.
          */
-        if (s->lost_tick_policy =3D=3D LOST_TICK_POLICY_SLEW) {
-            uint32_t old_irq_coalesced =3D s->irq_coalesced;
-
-            s->period =3D period;
-            lost_clock +=3D old_irq_coalesced * old_period;
-            s->irq_coalesced =3D lost_clock / s->period;
-            lost_clock %=3D s->period;
-            if (old_irq_coalesced !=3D s->irq_coalesced ||
-                old_period !=3D s->period) {
-                DPRINTF_C("cmos: coalesced irqs scaled from %d to %d, "
-                          "period scaled from %d to %d\n", old_irq_coalesc=
ed,
-                          s->irq_coalesced, old_period, s->period);
-                rtc_coalesced_timer_update(s);
-            }
-        } else {
-            /*
-             * no way to compensate the interrupt if LOST_TICK_POLICY_SLEW
-             * is not used, we should make the time progress anyway.
-             */
-            lost_clock =3D MIN(lost_clock, period);
-        }
+        lost_clock =3D MIN(lost_clock, period);
     }
=20
     assert(lost_clock >=3D 0 && lost_clock <=3D period);
--=20
1.8.3.1


From 6a989dedd43b1885bd3f2178d686bf7a4fe06a08 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 17 Nov 2019 10:28:14 +0100
Subject: [PATCH 2/5] mc146818rtc: keep s->period up to date

Right now s->period is only used if s->lost_tick_policy =3D=3D
LOST_TICK_POLICY_SLEW.  Not having to recompute it all the time
will come in handy in upcoming refactoring, so just store it in
RTCState.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/rtc/mc146818rtc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 9869dc5..da7837c 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -174,6 +174,8 @@ periodic_timer_update(RTCState *s, int64_t current_time=
, uint32_t old_period)
     int64_t cur_clock, next_irq_clock, lost_clock =3D 0;
=20
     period =3D rtc_periodic_clock_ticks(s);
+    s->period =3D period;
+
     if (!period) {
         s->irq_coalesced =3D 0;
         timer_del(s->periodic_timer);
@@ -215,7 +217,6 @@ periodic_timer_update(RTCState *s, int64_t current_time=
, uint32_t old_period)
     if (s->lost_tick_policy =3D=3D LOST_TICK_POLICY_SLEW) {
         uint32_t old_irq_coalesced =3D s->irq_coalesced;
=20
-        s->period =3D period;
         lost_clock +=3D old_irq_coalesced * old_period;
         s->irq_coalesced =3D lost_clock / s->period;
         lost_clock %=3D s->period;
@@ -231,12 +232,12 @@ periodic_timer_update(RTCState *s, int64_t current_ti=
me, uint32_t old_period)
          * no way to compensate the interrupt if LOST_TICK_POLICY_SLEW
          * is not used, we should make the time progress anyway.
          */
-        lost_clock =3D MIN(lost_clock, period);
+        lost_clock =3D MIN(lost_clock, s->period);
     }
=20
-    assert(lost_clock >=3D 0 && lost_clock <=3D period);
+    assert(lost_clock >=3D 0 && lost_clock <=3D s->period);
=20
-    next_irq_clock =3D cur_clock + period - lost_clock;
+    next_irq_clock =3D cur_clock + s->period - lost_clock;
     s->next_periodic_time =3D periodic_clock_to_ns(next_irq_clock) + 1;
     timer_mod(s->periodic_timer, s->next_periodic_time);
 }
@@ -794,6 +795,7 @@ static int rtc_post_load(void *opaque, int version_id)
         s->offset =3D 0;
         check_update_timer(s);
     }
+    s->period =3D rtc_periodic_clock_ticks(s);
=20
     /* The periodic timer is deterministic in record/replay mode,
      * so there is no need to update it after loading the vmstate.
--=20
1.8.3.1


From 258e46c4f234385c60857ef3542c335bf6560608 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 18 Nov 2019 11:50:31 +0100
Subject: [PATCH 3/5] mc146818rtc: clean up update of coalesced timer for
 periodic_timer_update

Remove knowledge of old_period from the code that sets up the
next periodic timer deadline.  Instead, account the missed IRQs into
lost_clock before that part runs.

This prepares for splitting periodic_timer_update in two parts,
one for period reconfiguration and one that sets up the next
periodic timer deadline.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/rtc/mc146818rtc.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index da7837c..47d966c 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -198,6 +198,12 @@ periodic_timer_update(RTCState *s, int64_t current_tim=
e, uint32_t old_period)
         last_periodic_clock =3D next_periodic_clock - old_period;
         lost_clock =3D cur_clock - last_periodic_clock;
         assert(lost_clock >=3D 0);
+
+        if (s->lost_tick_policy =3D=3D LOST_TICK_POLICY_SLEW) {
+            lost_clock +=3D s->irq_coalesced * old_period;
+            s->irq_coalesced =3D 0;
+            timer_del(s->coalesced_timer);
+        }
     }
=20
     /*
@@ -215,18 +221,9 @@ periodic_timer_update(RTCState *s, int64_t current_tim=
e, uint32_t old_period)
      *    OS handler will treat past delayed ticks as shorter.
      */
     if (s->lost_tick_policy =3D=3D LOST_TICK_POLICY_SLEW) {
-        uint32_t old_irq_coalesced =3D s->irq_coalesced;
-
-        lost_clock +=3D old_irq_coalesced * old_period;
         s->irq_coalesced =3D lost_clock / s->period;
         lost_clock %=3D s->period;
-        if (old_irq_coalesced !=3D s->irq_coalesced ||
-            old_period !=3D s->period) {
-            DPRINTF_C("cmos: coalesced irqs scaled from %d to %d, "
-                      "period scaled from %d to %d\n", old_irq_coalesced,
-                      s->irq_coalesced, old_period, s->period);
-            rtc_coalesced_timer_update(s);
-        }
+        rtc_coalesced_timer_update(s);
     } else {
         /*
          * no way to compensate the interrupt if LOST_TICK_POLICY_SLEW
@@ -883,6 +880,7 @@ static void rtc_reset(void *opaque)
     if (s->lost_tick_policy =3D=3D LOST_TICK_POLICY_SLEW) {
         s->irq_coalesced =3D 0;
         s->irq_reinject_on_ack_count =3D 0;
+        rtc_coalesced_timer_update(s);
     }
 }
=20
--=20
1.8.3.1


From c722009caa5d4959499a89d63d74082164385f45 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 18 Nov 2019 12:04:43 +0100
Subject: [PATCH 4/5] mc146818rtc: reorganize arguments of
 periodic_timer_update

This is mostly preparation for the next patch.  Because the next patch
will pass the number of lost 32 kHz ticks to periodic_timer_update,
it makes sense that the current time is also passed in 32 kHz units.
This makes calling periodic_timer_update from cmos_ioport_write a
bit unwieldy, so extract periodic_timer_reconfigure.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/rtc/mc146818rtc.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 47d966c..8a9e004 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -163,15 +163,23 @@ static uint32_t rtc_periodic_clock_ticks(RTCState *s)
     return periodic_period_to_clock(period_code);
 }
=20
+static uint32_t rtc_periodic_clock_get_ticks(void)
+{
+    int64_t current_time =3D qemu_clock_get_ns(rtc_clock);
+
+    /* compute 32 khz clock */
+    return muldiv64(current_time, RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
+}
+
 /*
  * handle periodic timer. @old_period indicates the periodic timer update
  * is just due to period adjustment.
  */
 static void
-periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_peri=
od)
+periodic_timer_update(RTCState *s, int64_t cur_clock, uint32_t old_period)
 {
     uint32_t period;
-    int64_t cur_clock, next_irq_clock, lost_clock =3D 0;
+    int64_t next_irq_clock, lost_clock =3D 0;
=20
     period =3D rtc_periodic_clock_ticks(s);
     s->period =3D period;
@@ -182,10 +190,6 @@ periodic_timer_update(RTCState *s, int64_t current_tim=
e, uint32_t old_period)
         return;
     }
=20
-    /* compute 32 khz clock */
-    cur_clock =3D
-        muldiv64(current_time, RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
-
     /*
      * if the periodic timer's update is due to period re-configuration,
      * we should count the clock since last interrupt.
@@ -239,11 +243,23 @@ periodic_timer_update(RTCState *s, int64_t current_ti=
me, uint32_t old_period)
     timer_mod(s->periodic_timer, s->next_periodic_time);
 }
=20
+static void
+periodic_timer_reconfigure(RTCState *s, uint32_t old_period)
+{
+    int64_t cur_clock =3D rtc_periodic_clock_get_ticks();
+
+    periodic_timer_update(s, cur_clock, old_period);
+}
+
 static void rtc_periodic_timer(void *opaque)
 {
     RTCState *s =3D opaque;
+    int64_t last_periodic_clock;
+
+    last_periodic_clock =3D
+        muldiv64(s->next_periodic_time, RTC_CLOCK_RATE, NANOSECONDS_PER_SE=
COND);
=20
-    periodic_timer_update(s, s->next_periodic_time, 0);
+    periodic_timer_update(s, last_periodic_clock, 0);
     s->cmos_data[RTC_REG_C] |=3D REG_C_PF;
     if (s->cmos_data[RTC_REG_B] & REG_B_PIE) {
         s->cmos_data[RTC_REG_C] |=3D REG_C_IRQF;
@@ -508,8 +524,7 @@ static void cmos_ioport_write(void *opaque, hwaddr addr=
,
                 (s->cmos_data[RTC_REG_A] & REG_A_UIP);
=20
             if (update_periodic_timer) {
-                periodic_timer_update(s, qemu_clock_get_ns(rtc_clock),
-                                      old_period);
+                periodic_timer_reconfigure(s, old_period);
             }
=20
             check_update_timer(s);
@@ -547,8 +562,7 @@ static void cmos_ioport_write(void *opaque, hwaddr addr=
,
             s->cmos_data[RTC_REG_B] =3D data;
=20
             if (update_periodic_timer) {
-                periodic_timer_update(s, qemu_clock_get_ns(rtc_clock),
-                                      old_period);
+                periodic_timer_reconfigure(s, old_period);
             }
=20
             check_update_timer(s);
@@ -802,7 +816,7 @@ static int rtc_post_load(void *opaque, int version_id)
         uint64_t now =3D qemu_clock_get_ns(rtc_clock);
         if (now < s->next_periodic_time ||
             now > (s->next_periodic_time + get_max_clock_jump())) {
-            periodic_timer_update(s, qemu_clock_get_ns(rtc_clock), 0);
+            periodic_timer_reconfigure(s, s->period);
         }
     }
=20
--=20
1.8.3.1


From 8994fed352d8147d2dea99710728cc15fb9f2cc2 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 18 Nov 2019 11:59:59 +0100
Subject: [PATCH 5/5] mc146818rtc: fix timer interrupt reinjection again

Commit 369b41359af46bded5799c9ef8be2b641d92e043 broke timer interrupt
reinjection when there is no period change by the guest.  In that
case, old_period is 0, which ends up zeroing irq_coalesced (counter of
reinjected interrupts).

The consequence is Windows 7 is unable to synchronize time via NTP.
Easily reproducible by playing a fullscreen video with cirrus and VNC.

That part of periodic_timer_update that introduces the bug is
only needed due to reconfiguration of the period, so move it to
periodic_timer_reconfigure.  In that path, old_period =3D=3D 0 does mean
that the periodic timer was off.

Reported-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/rtc/mc146818rtc.c | 72 +++++++++++++++++++++++++-----------------------=
----
 1 file changed, 34 insertions(+), 38 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 8a9e004..823f706 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -171,44 +171,10 @@ static uint32_t rtc_periodic_clock_get_ticks(void)
     return muldiv64(current_time, RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
 }
=20
-/*
- * handle periodic timer. @old_period indicates the periodic timer update
- * is just due to period adjustment.
- */
 static void
-periodic_timer_update(RTCState *s, int64_t cur_clock, uint32_t old_period)
+periodic_timer_update(RTCState *s, int64_t cur_clock, int64_t lost_clock)
 {
-    uint32_t period;
-    int64_t next_irq_clock, lost_clock =3D 0;
-
-    period =3D rtc_periodic_clock_ticks(s);
-    s->period =3D period;
-
-    if (!period) {
-        s->irq_coalesced =3D 0;
-        timer_del(s->periodic_timer);
-        return;
-    }
-
-    /*
-     * if the periodic timer's update is due to period re-configuration,
-     * we should count the clock since last interrupt.
-     */
-    if (old_period) {
-        int64_t last_periodic_clock, next_periodic_clock;
-
-        next_periodic_clock =3D muldiv64(s->next_periodic_time,
-                                RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
-        last_periodic_clock =3D next_periodic_clock - old_period;
-        lost_clock =3D cur_clock - last_periodic_clock;
-        assert(lost_clock >=3D 0);
-
-        if (s->lost_tick_policy =3D=3D LOST_TICK_POLICY_SLEW) {
-            lost_clock +=3D s->irq_coalesced * old_period;
-            s->irq_coalesced =3D 0;
-            timer_del(s->coalesced_timer);
-        }
-    }
+    int64_t next_irq_clock;
=20
     /*
      * s->irq_coalesced can change for two reasons:
@@ -243,23 +209,53 @@ periodic_timer_update(RTCState *s, int64_t cur_clock,=
 uint32_t old_period)
     timer_mod(s->periodic_timer, s->next_periodic_time);
 }
=20
+/* adjust periodic timer on period adjustment */
 static void
 periodic_timer_reconfigure(RTCState *s, uint32_t old_period)
 {
     int64_t cur_clock =3D rtc_periodic_clock_get_ticks();
+    int64_t lost_clock =3D 0;
=20
-    periodic_timer_update(s, cur_clock, old_period);
+    s->period =3D rtc_periodic_clock_ticks(s);
+    if (!s->period) {
+        s->irq_coalesced =3D 0;
+        timer_del(s->periodic_timer);
+        return;
+    }
+
+    /*
+     * if the periodic timer was active before, account the time since
+     * the last interrupt.
+     */
+    if (old_period) {
+        int64_t last_periodic_clock, next_periodic_clock;
+
+        next_periodic_clock =3D muldiv64(s->next_periodic_time,
+                                RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
+        last_periodic_clock =3D next_periodic_clock - old_period;
+        lost_clock =3D cur_clock - last_periodic_clock;
+        assert(lost_clock >=3D 0);
+
+        if (s->lost_tick_policy =3D=3D LOST_TICK_POLICY_SLEW) {
+            lost_clock +=3D s->irq_coalesced * old_period;
+            s->irq_coalesced =3D 0;
+            timer_del(s->coalesced_timer);
+        }
+    }
+
+    periodic_timer_update(s, cur_clock, lost_clock);
 }
=20
 static void rtc_periodic_timer(void *opaque)
 {
     RTCState *s =3D opaque;
+    int64_t cur_clock =3D rtc_periodic_clock_get_ticks();
     int64_t last_periodic_clock;
=20
     last_periodic_clock =3D
         muldiv64(s->next_periodic_time, RTC_CLOCK_RATE, NANOSECONDS_PER_SE=
COND);
=20
-    periodic_timer_update(s, last_periodic_clock, 0);
+    periodic_timer_update(s, cur_clock, cur_clock - last_periodic_clock);
     s->cmos_data[RTC_REG_C] |=3D REG_C_PF;
     if (s->cmos_data[RTC_REG_B] & REG_B_PIE) {
         s->cmos_data[RTC_REG_C] |=3D REG_C_IRQF;
--=20
1.8.3.1


