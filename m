Return-Path: <SRS0=ZAHP=ZJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212EBC432C0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2019 10:13:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3BC1206CC
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2019 10:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="clF61Jzy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3BC1206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWHYx-0000gc-TA
	for qemu-devel@archiver.kernel.org; Sun, 17 Nov 2019 05:13:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35219)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iWHY4-0000Eo-MN
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 05:12:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iWHY1-000694-55
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 05:12:50 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49403
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iWHY0-00067f-RQ
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 05:12:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573985567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=TgertlcxDc1a8BIFq/zZe5yVgae0M8Eu/+Z9YFL0cNs=;
 b=clF61JzymIp49NSu6gtZRCm5DHham1uThXuGBjmPCAF5ufGQJS/viDnSuzdo8k8gDKXDLF
 370B2czg0MhLBOu1FoQUTCgK9KYbcA48Tu7XxaOvO6W3hU+eJ+lKRAhlnu6uKDsEHE37EM
 65vp/VVc5wG8R2nMABoqdNBDemFEAd0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-b4VawqTDNi--lNBuMs5fkw-1; Sun, 17 Nov 2019 05:12:44 -0500
Received: by mail-wm1-f69.google.com with SMTP id m68so11978513wme.7
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2019 02:12:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a+n9fl5fWXb2CNpsg1sApRoXB/bHGtxwIWtgHQGxoFs=;
 b=p4cx049KVQA5uOs224b+dBU3kjGd8IppkL7TOrJMhcTARF4uYrQD77aUBak4XuunuE
 sm0OgiftbmiWPoiX3e4sxyFLREnfbjHnTiO+17sBiMXqPC7UoOpSiHPw6mUyxNncgNN+
 3hUfMcKwAD8w+Ov0nK5dzbWPINe6ShvjvA7oHayQGW0BhtI6Z2S6CF5xZ5eoik4ezACA
 5LBpwysTQt5EQE6gVXPZKB1zEJojBMsvPa42iQWhNUc/EcC5rkHDmryZ8h53tBD9FDiC
 i2qdC7WmT9A+ri6Wf2e+NNfPQgYEHCvo2edcO0Taid0y5b7g+Jge/khQdEWPv2kyih+W
 LfQA==
X-Gm-Message-State: APjAAAWQVgkUnjjQ1JN7P6KFIBa0OkOBqhk2JfIyKaZFBLGgIMTG2Jq6
 EtsXVh+CvzT4QIb8aadlcPVkQ83f/M103H7SVuNfnveLdbGZcpWgvGgtdoJ0PaLmXl1pszYnUB9
 c2Lj9p1IPIXdi3HE=
X-Received: by 2002:a1c:30b:: with SMTP id 11mr22003118wmd.171.1573985563325; 
 Sun, 17 Nov 2019 02:12:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqz/ak7aJmu0+b5gfW7gFn2daC6Zr2EsXD1BWLnjiKrkA061P4Ec/mgl/ptmqu48pjsxjkAVog==
X-Received: by 2002:a1c:30b:: with SMTP id 11mr22003090wmd.171.1573985562905; 
 Sun, 17 Nov 2019 02:12:42 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a15b:f753:1ac4:56dc?
 ([2001:b07:6468:f312:a15b:f753:1ac4:56dc])
 by smtp.gmail.com with ESMTPSA id f24sm16017956wmb.37.2019.11.17.02.12.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Nov 2019 02:12:42 -0800 (PST)
Subject: Re: [PATCH v2] mc146818rtc: fix timer interrupt reinjection
To: Alex Williamson <alex.williamson@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20191010123008.GA19158@amt.cnet>
 <20191116135855.5e16bb7c@x1.home> <20191117032015.GA4568@amt.cnet>
 <20191116213115.611d8028@x1.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3ba4e29d-3436-9d7b-ebc0-5e1ae566e760@redhat.com>
Date: Sun, 17 Nov 2019 11:12:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191116213115.611d8028@x1.home>
Content-Language: en-US
X-MC-Unique: b4VawqTDNi--lNBuMs5fkw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
Cc: Xiao Guangrong <guangrong.xiao@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, Vadim Rozenfeld <vrozenfe@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/11/19 05:31, Alex Williamson wrote:
> The 'merge' option gives me a similar error.  The 'delay' option is
> the only other choice where I can actually start the VM, but this
> results in the commandline:
>=20
> -rtc base=3Dlocaltime
>=20
> (no driftfix specified)

none is the default, so that's okay.

> This does appear to resolve the issue, but of course compatibility
> with existing configurations has regressed. Thanks,

Yeah, I guess this was just a suggestion to double-check the cause of=20
the regression.

The problem could be that periodic_timer_update is using old_period =3D=3D =
0=20
for two cases: no period change, and old period was 0 (periodic timer=20
off).

Something like the following distinguishes the two cases by always using
s->period (currently it was only used for driftfix=3Dslew) and passing
s->period instead of 0 when there is no period change.

More cleanups are possible, but this is the smallest patch that implements
the idea.  The first patch is big but, indentation changes aside, it's
moving a single closed brace.

Alex/Marcelo, can you check if it fixes both of your test cases?

------------- 8< ---------------
From 48dc9d140c636067b8de1ab8e25b819151c83162 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 17 Nov 2019 10:07:38 +0100
Subject: [PATCH 1/2] Revert "mc146818rtc: fix timer interrupt reinjection"

This reverts commit b429de730174b388ea5760e3debb0d542ea3c261, except
that the reversal of the outer "if (period)" is left in.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/rtc/mc146818rtc.c | 67 ++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index ee6bf82b40..9869dc5031 100644
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
2.21.0


From 8546b5b65d9bc7b3f9c5fed4a650b27880ac72b3 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 17 Nov 2019 10:28:14 +0100
Subject: [PATCH 2/2] mc146818rtc: fix timer interrupt reinjection again

Commit 369b41359af46bded5799c9ef8be2b641d92e043 broke timer interrupt
reinjection when there is no period change by the guest.  In that
case, old_period is 0, which ends up zeroing irq_coalesced (counter of
reinjected interrupts).

The consequence is Windows 7 is unable to synchronize time via NTP.
Easily reproducible by playing a fullscreen video with cirrus and VNC.

Fix by passing s->period when periodic_timer_update is called due to
expiration of the timer.  With this change, old_period =3D=3D 0 only
means that the periodic timer was off.

Reported-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/rtc/mc146818rtc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 9869dc5031..944677bea9 100644
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
@@ -245,7 +246,7 @@ static void rtc_periodic_timer(void *opaque)
 {
     RTCState *s =3D opaque;
=20
-    periodic_timer_update(s, s->next_periodic_time, 0);
+    periodic_timer_update(s, s->next_periodic_time, s->period);
     s->cmos_data[RTC_REG_C] |=3D REG_C_PF;
     if (s->cmos_data[RTC_REG_B] & REG_B_PIE) {
         s->cmos_data[RTC_REG_C] |=3D REG_C_IRQF;
@@ -794,6 +795,7 @@ static int rtc_post_load(void *opaque, int version_id)
         s->offset =3D 0;
         check_update_timer(s);
     }
+    s->period =3D rtc_periodic_clock_ticks(s);
=20
     /* The periodic timer is deterministic in record/replay mode,
      * so there is no need to update it after loading the vmstate.
@@ -803,7 +805,7 @@ static int rtc_post_load(void *opaque, int version_id)
         uint64_t now =3D qemu_clock_get_ns(rtc_clock);
         if (now < s->next_periodic_time ||
             now > (s->next_periodic_time + get_max_clock_jump())) {
-            periodic_timer_update(s, qemu_clock_get_ns(rtc_clock), 0);
+            periodic_timer_update(s, qemu_clock_get_ns(rtc_clock), s->peri=
od);
         }
     }
=20
--=20
2.21.0


