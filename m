Received: from eggs.gnu.org ([2001:4830:134:3::10]:56410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d5wGb-00054M-MO
	for qemu-devel@nongnu.org; Wed, 03 May 2017 11:32:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d5wGW-0000sA-MB
	for qemu-devel@nongnu.org; Wed, 03 May 2017 11:32:37 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:36144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1d5wGW-0000rJ-EO
	for qemu-devel@nongnu.org; Wed, 03 May 2017 11:32:32 -0400
Received: by mail-wm0-x229.google.com with SMTP id u65so150743587wmu.1
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 08:32:32 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170412095111.11728-1-xiaoguangrong@tencent.com>
	<20170412095111.11728-4-xiaoguangrong@tencent.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b855686b-20cd-9403-c765-c8b3a3268302@redhat.com>
Date: Wed, 3 May 2017 17:32:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170412095111.11728-4-xiaoguangrong@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/5] mc146818rtc: properly count the time
 for the next interrupt
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
> +#ifdef TARGET_I386
> +            /*
> +             * if more than period clocks were passed, i.e, the timer interrupt
> +             * has been lost, we should catch up the time.
> +             */
> +            if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW &&
> +                (lost_clock / period)) {
> +                int lost_interrupt = lost_clock / period;
> +
> +                s->irq_coalesced += lost_interrupt;
> +                lost_clock -= lost_interrupt * period;
> +                if (lost_interrupt) {
> +                    DPRINTF_C("cmos: compensate %d interrupts, coalesced irqs "
> +                              "increased to %d\n", lost_interrupt,
> +                              s->irq_coalesced);
> +                    rtc_coalesced_timer_update(s);
> +                }

I think you should merge these two patches, since both of them
essentially update the number of coalesced ticks and then split it
between s->irq_coalesced and lost_clock.

Paolo

> +            } else
> +#endif
> +            /*
> +             * no way to compensate the interrupt if LOST_TICK_POLICY_SLEW
> +             * is not used, we should make the time progress anyway.
> +             */
> +            lost_clock = MIN(lost_clock, period);
> +            assert(lost_clock >= 0);
> +        }
> +
