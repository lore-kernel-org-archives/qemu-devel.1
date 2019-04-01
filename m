Received: from eggs.gnu.org ([209.51.188.92]:32835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1hAycx-0007DP-JX
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 11:13:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1hAycw-0005Em-J7
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 11:13:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1hAycw-0005EB-Aa
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 11:13:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id a184so10852059wma.2
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 08:13:33 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
In-Reply-To: <f402ff3c-3edd-2dce-6758-a301cfb2e061@redhat.com>
References: <20190401133659.20421-1-vkuznets@redhat.com>
	<f402ff3c-3edd-2dce-6758-a301cfb2e061@redhat.com>
Date: Mon, 01 Apr 2019 17:13:30 +0200
Message-ID: <87d0m521yd.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Liran Alon <liran.alon@oracle.com>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 01/04/19 15:36, Vitaly Kuznetsov wrote:
...
>>  static void ioapic_set_irq(void *opaque, int vector, int level)
>>  {
>>      IOAPICCommonState *s = opaque;
>> @@ -227,7 +236,28 @@ void ioapic_eoi_broadcast(int vector)
>>                  trace_ioapic_clear_remote_irr(n, vector);
>>                  s->ioredtbl[n] = entry & ~IOAPIC_LVT_REMOTE_IRR;
>>                  if (!(entry & IOAPIC_LVT_MASKED) && (s->irr & (1 << n))) {
>> -                    ioapic_service(s);
>> +                    bool level = ((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1)
>> +                        == IOAPIC_TRIGGER_LEVEL;
>> +
>> +                    ++s->irq_reassert[vector];
>> +                    if (!level ||
>> +                        s->irq_reassert[vector] < SUCCESSIVE_IRQ_MAX_COUNT) {
>> +                        ioapic_service(s);
>> +                    } else {
>> +                        /*
>> +                         * Real hardware does not deliver the interrupt
>> +                         * immediately during eoi broadcast, and this lets a
>> +                         * buggy guest make slow progress even if it does not
>> +                         * correctly handle a level-triggered interrupt. Emulate
>> +                         * this behavior if we detect an interrupt storm.
>> +                         */
>> +                        trace_ioapic_eoi_delayed_reassert(vector);
>> +                        timer_mod(s->timer,
>> +                                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
>> +                                  NANOSECONDS_PER_SECOND / 100);
>
> Should this be done only if the timer isn't pending?

Hm, maybe ... but how can this happen? To get here we need remote IRR
bit and we clear it so someone needs to re-set it. The source won't
probably be doing this (it is a level-triggered interrupt and it is
already pending - why re-asserting?) but even if it does
ioapic_service(s) will be called and when our timer fires we will just
do nothing (consequitive ioapic_service() doesn't hurt).

-- 
Vitaly
