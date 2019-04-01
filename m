Received: from eggs.gnu.org ([209.51.188.92]:39225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hAx9p-0001MB-BD
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 09:39:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hAx9o-0005O8-5n
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 09:39:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hAx9n-0005NU-QQ
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 09:39:24 -0400
References: <20190401133659.20421-1-vkuznets@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f402ff3c-3edd-2dce-6758-a301cfb2e061@redhat.com>
Date: Mon, 1 Apr 2019 15:39:15 +0200
MIME-Version: 1.0
In-Reply-To: <20190401133659.20421-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ioapic: allow buggy guests mishandling
 level-triggered interrupts to make progress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Liran Alon <liran.alon@oracle.com>

On 01/04/19 15:36, Vitaly Kuznetsov wrote:
> It was found that Hyper-V 2016 on KVM in some configurations (q35 machine +
> piix4-usb-uhci) hangs on boot. Trace analysis led us to the conclusion that
> it is mishandling level-triggered interrupt performing EOI without fixing
> the root cause. This causes immediate re-assertion and L2 VM (which is
> supposedly expected to fix the cause of the interrupt) is not making any
> progress.
> 
> Gory details: https://www.spinics.net/lists/kvm/msg184484.html
> 
> Turns out we were dealing with similar issues before; in-kernel IOAPIC
> implementation has commit 184564efae4d ("kvm: ioapic: conditionally delay
> irq delivery duringeoi broadcast") which describes a very similar issue.
> 
> Steal the idea from the above mentioned commit for IOAPIC implementation in
> QEMU. SUCCESSIVE_IRQ_MAX_COUNT, delay and the comment are borrowed as well.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  hw/intc/ioapic.c                  | 43 ++++++++++++++++++++++++++++++-
>  hw/intc/trace-events              |  1 +
>  include/hw/i386/ioapic_internal.h |  3 +++
>  3 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> index 9d75f84d3b..daf45cc8a8 100644
> --- a/hw/intc/ioapic.c
> +++ b/hw/intc/ioapic.c
> @@ -139,6 +139,15 @@ static void ioapic_service(IOAPICCommonState *s)
>      }
>  }
>  
> +#define SUCCESSIVE_IRQ_MAX_COUNT 10000
> +
> +static void ioapic_timer(void *opaque)
> +{
> +    IOAPICCommonState *s = opaque;
> +
> +    ioapic_service(s);
> +}
> +
>  static void ioapic_set_irq(void *opaque, int vector, int level)
>  {
>      IOAPICCommonState *s = opaque;
> @@ -227,7 +236,28 @@ void ioapic_eoi_broadcast(int vector)
>                  trace_ioapic_clear_remote_irr(n, vector);
>                  s->ioredtbl[n] = entry & ~IOAPIC_LVT_REMOTE_IRR;
>                  if (!(entry & IOAPIC_LVT_MASKED) && (s->irr & (1 << n))) {
> -                    ioapic_service(s);
> +                    bool level = ((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1)
> +                        == IOAPIC_TRIGGER_LEVEL;
> +
> +                    ++s->irq_reassert[vector];
> +                    if (!level ||
> +                        s->irq_reassert[vector] < SUCCESSIVE_IRQ_MAX_COUNT) {
> +                        ioapic_service(s);
> +                    } else {
> +                        /*
> +                         * Real hardware does not deliver the interrupt
> +                         * immediately during eoi broadcast, and this lets a
> +                         * buggy guest make slow progress even if it does not
> +                         * correctly handle a level-triggered interrupt. Emulate
> +                         * this behavior if we detect an interrupt storm.
> +                         */
> +                        trace_ioapic_eoi_delayed_reassert(vector);
> +                        timer_mod(s->timer,
> +                                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +                                  NANOSECONDS_PER_SECOND / 100);

Should this be done only if the timer isn't pending?

Paolo
