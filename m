Received: from eggs.gnu.org ([2001:4830:134:3::10]:51654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d5w0A-0006ED-FA
	for qemu-devel@nongnu.org; Wed, 03 May 2017 11:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d5w07-0004JZ-8w
	for qemu-devel@nongnu.org; Wed, 03 May 2017 11:15:38 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:33910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1d5w06-0004IR-Vh
	for qemu-devel@nongnu.org; Wed, 03 May 2017 11:15:35 -0400
Received: by mail-wr0-x232.google.com with SMTP id l9so110856312wre.1
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 08:15:34 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170412095111.11728-1-xiaoguangrong@tencent.com>
	<20170412095111.11728-3-xiaoguangrong@tencent.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <46377b3a-d06e-2119-eb97-5384013b0ac8@redhat.com>
Date: Wed, 3 May 2017 17:15:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170412095111.11728-3-xiaoguangrong@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/5] mc146818rtc: fix clock lost after
 scaling coalesced irq
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, yunfangtai@tencent.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 12/04/2017 11:51, guangrong.xiao@gmail.com wrote:
> +            int current_irq_coalesced = s->irq_coalesced;
> +
> +            s->irq_coalesced = (current_irq_coalesced * s->period) / period;
> +
> +            /*
> +             * calculate the lost clock after it is scaled which should be
> +             * compensated in the next interrupt.
> +             */
> +            lost_clock += current_irq_coalesced * s->period -
> +                            s->irq_coalesced * period;

This is:

   lost_clock = current_irq_coalesced * s->period -
	(current_irq_coalesced * s->period) / period * period;

i.e.

   /* When switching from a shorter to a longer period, scale down the
    * missing ticks since we expect the OS handler to treat the delayed
    * ticks as longer.  Any leftovers are put back into next_irq_clock.
    *
    * When switching to a shorter period, scale up the missing ticks
    * since we expect the OS handler to treat the delayed ticks as
    * shorter.
    */
   lost_clock = (s->irq_coalesced * s->period) % period;
   s->irq_coalesced = (s->irq_coalesced * s->period) / period;

Is this correct?

Paolo

> +            DPRINTF_C("cmos: coalesced irqs scaled from %d to %d, %ld clocks "
> +                      "are compensated.\n",
> +                      current_irq_coalesced, s->irq_coalesced, lost_clock);
>          }
>          s->period = period;
>  #endif
> @@ -170,7 +193,7 @@ static void periodic_timer_update(RTCState *s, int64_t current_time)
>          cur_clock =
>              muldiv64(current_time, RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
>  
> -        next_irq_clock = (cur_clock & ~(period - 1)) + period;
> +        next_irq_clock = cur_clock + period - lost_clock;
>          s->next_periodic_time = muldiv64(next_irq_clock, NANOSECONDS_PER_SECOND,
>                                           RTC_CLOCK_RATE) + 1;
>          timer_mod(s->periodic_timer, s->next_periodic_time);
> -- 
