Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82814C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:56:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 562D32067B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 562D32067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXzv-0003fg-Hd
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57753)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mtosatti@redhat.com>) id 1iIXaW-0002n7-7S
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mtosatti@redhat.com>) id 1iIXaU-00013V-TS
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:30:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49962)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mtosatti@redhat.com>) id 1iIXaU-00013K-Kd
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:30:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C43E330224AA;
 Thu, 10 Oct 2019 12:30:33 +0000 (UTC)
Received: from amt.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EF5519C4F;
 Thu, 10 Oct 2019 12:30:31 +0000 (UTC)
Received: from amt.cnet (localhost [127.0.0.1])
 by amt.cnet (Postfix) with ESMTP id CFB5E105177;
 Thu, 10 Oct 2019 09:28:10 -0300 (BRT)
Received: (from marcelo@localhost)
 by amt.cnet (8.14.7/8.14.7/Submit) id x9ACS7oD019214;
 Thu, 10 Oct 2019 09:28:07 -0300
Date: Thu, 10 Oct 2019 09:28:07 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] mc146818rtc: fix timer interrupt reinjection
Message-ID: <20191010122806.GA19189@amt.cnet>
References: <20191009184011.GA26234@amt.cnet>
 <8319ce4d-2775-a68d-c08b-f4312d9c30a2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8319ce4d-2775-a68d-c08b-f4312d9c30a2@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 10 Oct 2019 12:30:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Tai Yunfang <yunfangtai@tencent.com>,
 Xiao Guangrong <guangrong.xiao@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Vadim Rozenfeld <vrozenfe@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 09, 2019 at 11:13:16PM +0200, Paolo Bonzini wrote:
> On 09/10/19 20:40, Marcelo Tosatti wrote:
> >              s->period = period;
> >              lost_clock += old_irq_coalesced * old_period;
> > -            s->irq_coalesced = lost_clock / s->period;
> > +            if (old_period) {
> > +                s->irq_coalesced = lost_clock / s->period;
> > +            }
> > +
> >              lost_clock %= s->period;
> >              if (old_irq_coalesced != s->irq_coalesced ||
> >                  old_period != s->period) {
> 
> I think none of the code in the "if (s->lost_tick_policy == 
> LOST_TICK_POLICY_SLEW) {" matters if old_period == 0 (and lost_clock 
> will always be 0).  So perhaps we should place all that big "if" under
> the existing "if (old_period)"?
> 
> Or even something like:

This skips reprogramming the timer if the period is equal.

Sending v2 based on your suggestions and patch below.

> 
> diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
> index 6cb378751b..3337a8da98 100644
> --- a/hw/timer/mc146818rtc.c
> +++ b/hw/timer/mc146818rtc.c
> @@ -202,25 +202,33 @@ periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_period)
>      int64_t cur_clock, next_irq_clock, lost_clock = 0;
>  
>      period = rtc_periodic_clock_ticks(s);
> +    if (old_period && old_period == period) {
> +        return;
> +    }
>  
> -    if (period) {
> -        /* compute 32 khz clock */
> -        cur_clock =
> -            muldiv64(current_time, RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
> +    if (!period) {
> +        s->irq_coalesced = 0;
> +        timer_del(s->periodic_timer);
> +        return;
>  
> -        /*
> -        * if the periodic timer's update is due to period re-configuration,
> -        * we should count the clock since last interrupt.
> -        */
> -        if (old_period) {
> -            int64_t last_periodic_clock, next_periodic_clock;
> -
> -            next_periodic_clock = muldiv64(s->next_periodic_time,
> -                                    RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
> -            last_periodic_clock = next_periodic_clock - old_period;
> -            lost_clock = cur_clock - last_periodic_clock;
> -            assert(lost_clock >= 0);
> -        }
> +    }
> +
> +    /* compute 32 khz clock */
> +    cur_clock =
> +        muldiv64(current_time, RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
> +
> +    /*
> +     * if the periodic timer's update is due to period re-configuration,
> +     * we should count the clock since last interrupt.
> +     */
> +    if (old_period) {
> +        int64_t last_periodic_clock, next_periodic_clock;
> +
> +        next_periodic_clock = muldiv64(s->next_periodic_time,
> +                                       RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
> +        last_periodic_clock = next_periodic_clock - old_period;
> +        lost_clock = cur_clock - last_periodic_clock;
> +        assert(lost_clock >= 0);
>  
>          /*
>           * s->irq_coalesced can change for two reasons:
> @@ -243,13 +251,10 @@ periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_period)
>              lost_clock += old_irq_coalesced * old_period;
>              s->irq_coalesced = lost_clock / s->period;
>              lost_clock %= s->period;
> -            if (old_irq_coalesced != s->irq_coalesced ||
> -                old_period != s->period) {
> -                DPRINTF_C("cmos: coalesced irqs scaled from %d to %d, "
> -                          "period scaled from %d to %d\n", old_irq_coalesced,
> -                          s->irq_coalesced, old_period, s->period);
> -                rtc_coalesced_timer_update(s);
> -            }
> +            DPRINTF_C("cmos: coalesced irqs scaled from %d to %d, "
> +                      "period scaled from %d to %d\n", old_irq_coalesced,
> +                      s->irq_coalesced, old_period, s->period);
> +            rtc_coalesced_timer_update(s);
>          } else {
>             /*
>               * no way to compensate the interrupt if LOST_TICK_POLICY_SLEW
> @@ -257,16 +262,12 @@ periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_period)
>               */
>              lost_clock = MIN(lost_clock, period);
>          }
> -
>          assert(lost_clock >= 0 && lost_clock <= period);
> -
> -        next_irq_clock = cur_clock + period - lost_clock;
> -        s->next_periodic_time = periodic_clock_to_ns(next_irq_clock) + 1;
> -        timer_mod(s->periodic_timer, s->next_periodic_time);
> -    } else {
> -        s->irq_coalesced = 0;
> -        timer_del(s->periodic_timer);
>      }
> +
> +    next_irq_clock = cur_clock + period - lost_clock;
> +    s->next_periodic_time = periodic_clock_to_ns(next_irq_clock) + 1;
> +    timer_mod(s->periodic_timer, s->next_periodic_time);
>  }
>  
>  static void rtc_periodic_timer(void *opaque)
> 
> 
> Best read with "diff -b".
> 
> Paolo

