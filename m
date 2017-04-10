Received: from eggs.gnu.org ([2001:4830:134:3::10]:47042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cxhij-0002U1-MJ
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 18:23:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cxhii-0002rW-Ea
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 18:23:37 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:35489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1cxhii-0002qi-8Z
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 18:23:36 -0400
Received: by mail-oi0-x243.google.com with SMTP id g204so14631340oib.2
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 15:23:36 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <CAFEAcA9Pp85ir53BEsd2dT=6iG8gi_6hH2hGkn12Fus0k1K8FQ@mail.gmail.com>
References: <cover.1491349058.git.alistair.francis@xilinx.com>
	<325f60be9b819f261848db3d69554da640294ca4.1491349058.git.alistair.francis@xilinx.com>
	<CAFEAcA9Pp85ir53BEsd2dT=6iG8gi_6hH2hGkn12Fus0k1K8FQ@mail.gmail.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 10 Apr 2017 15:23:04 -0700
Message-ID: <CAKmqyKOXoMRQbe+qEroxZxVPh06JU6vbZJ1wddBb_8imPeD-1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v1 3/5] cadence_gem: Only trigger
 interrupts if the status register is set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Apr 10, 2017 at 5:44 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 5 April 2017 at 00:40, Alistair Francis <alistair.francis@xilinx.com> wrote:
>> Only trigger multi-queue GEM interrupts if the interrupt status register
>> is set. This logic was already used for non multi-queue interrupts but
>> it also applies to multi-queue interrupts.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>>
>>  hw/net/cadence_gem.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
>> index 3e37665..b9eaed4 100644
>> --- a/hw/net/cadence_gem.c
>> +++ b/hw/net/cadence_gem.c
>> @@ -518,7 +518,7 @@ static void gem_update_int_status(CadenceGEMState *s)
>>      }
>>
>>      for (i = 0; i < s->num_priority_queues; ++i) {
>> -        if (s->regs[GEM_INT_Q1_STATUS + i]) {
>> +        if (s->regs[GEM_INT_Q1_STATUS + i] && s->regs[GEM_ISR]) {
>>              DB_PRINT("asserting int. (q=%d)\n", i);
>>              qemu_set_irq(s->irq[i], 1);
>>          }
>
> With this change, if s->regs[GEM_ISR] is zero then the entire
> function never does anything, so you could hoist that up to
> the start, rather than testing it inside the loop and in the
> previous conditional.

Yep, I have moved it to the top.

>
> Also the comment says "raise or lower interrupt based on current
> status", but the code will only ever do qemu_set_irq(..., 1),
> never 0. Which is right?

This is a little confusing. The interrupts are lowered when the ISR is
read, so the assumption was that we never need to clear them in the
gem_update_int_status(). Although then if we perform a reset nothing
will clear the interrupts until the ISR is read from. So that is a
bug. I'll update this patch to fix this up in V2.

Thanks,

Alistair

>
> thanks
> -- PMM
