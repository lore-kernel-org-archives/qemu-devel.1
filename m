Received: from eggs.gnu.org ([209.51.188.92]:33924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hAygg-0000mD-Vh
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 11:17:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hAygg-0007ZX-4B
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 11:17:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hAygf-0007UI-Na
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 11:17:26 -0400
References: <20190401133659.20421-1-vkuznets@redhat.com>
	<f402ff3c-3edd-2dce-6758-a301cfb2e061@redhat.com>
	<87d0m521yd.fsf@vitty.brq.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7f24ed64-21f2-4d67-ad2f-68358b617bb9@redhat.com>
Date: Mon, 1 Apr 2019 17:17:04 +0200
MIME-Version: 1.0
In-Reply-To: <87d0m521yd.fsf@vitty.brq.redhat.com>
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

On 01/04/19 17:13, Vitaly Kuznetsov wrote:
>>> +                        trace_ioapic_eoi_delayed_reassert(vector);
>>> +                        timer_mod(s->timer,
>>> +                                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
>>> +                                  NANOSECONDS_PER_SECOND / 100);
>> Should this be done only if the timer isn't pending?
> Hm, maybe ... but how can this happen? To get here we need remote IRR
> bit and we clear it so someone needs to re-set it. The source won't
> probably be doing this (it is a level-triggered interrupt and it is
> already pending - why re-asserting?) but even if it does
> ioapic_service(s) will be called and when our timer fires we will just
> do nothing (consequitive ioapic_service() doesn't hurt).

Yeah, it's just for cleanliness.  Let's change it to
timer_mod_anticipate and call it a day.

Paolo
