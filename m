Received: from eggs.gnu.org ([2001:4830:134:3::10]:45586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fsmf5-0000q1-Ok
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:16:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fsmf4-0004W8-9k
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:16:19 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:33903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fsmf4-0004VJ-09
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:16:18 -0400
Received: by mail-oi0-x243.google.com with SMTP id 13-v6so8372360ois.1
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 03:16:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7421acd0-4c9d-95ca-dbd2-a903ef0ee2b8@greensocs.com>
References: <20180821132811.17675-1-peter.maydell@linaro.org>
	<20180821132811.17675-2-peter.maydell@linaro.org>
	<7421acd0-4c9d-95ca-dbd2-a903ef0ee2b8@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Aug 2018 11:15:56 +0100
Message-ID: <CAFEAcA9iZwxtBLVeungN5FNc2AhhZQzKQ+C5sJRj0S4XJ6qA6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/9] hw/intc/arm_gic: Document QEMU
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 22 August 2018 at 09:15, Luc Michel <luc.michel@greensocs.com> wrote:
>
>
> On 8/21/18 3:28 PM, Peter Maydell wrote:
>> The GICv2's QEMU interface (sysbus MMIO regions, IRQs,
>> etc) is now quite complicated with the addition of the
>> virtualization extensions. Add a comment in the header
>> file which documents it.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> I needed to write this out to figure out what I was
>> connecting to what in the a15mpcore object :-)
>> ---
>>  include/hw/intc/arm_gic.h | 35 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>
>> diff --git a/include/hw/intc/arm_gic.h b/include/hw/intc/arm_gic.h
>> index 42bb535fd45..989bc837606 100644
>> --- a/include/hw/intc/arm_gic.h
>> +++ b/include/hw/intc/arm_gic.h
>> @@ -18,6 +18,41 @@
>>   * with this program; if not, see <http://www.gnu.org/licenses/>.
>>   */
>>
>> +/*
>> + * QEMU interface:
>> + *  + QOM property "num-cpu": number of CPUs to support
>> + *  + QOM property "num-irq": number of IRQs (including both SPIs and PPIs)
>> + *  + QOM property "revision": GIC version (1 or 2), or 0 for the 11MPCore GIC
>> + *  + QOM property "has-security-extensions": set true if the GIC should
>> + *    implement the security extensions
>> + *  + QOM property "has-virtualization-extensions": set true if the GIC should
>> + *    implement the virtualization extensions
>> + *  + unnamed GPIO inputs: (where P is number of PPIs, i.e. num-irq - 32)
> "where P is the number of SPIs"
>> + *    [0..P-1]  SPIs
>> + *    [P..P+31] PPIs for CPU 0
>> + *    [P+32..P+63] PPIs for CPU 1
>> + *    ...
>> + *  + sysbus IRQ 0 : IRQ
>> + *  + sysbus IRQ 1 : FIQ
>> + *  + sysbus IRQ 2 : VIRQ (exists even if virt extensions not present)
>> + *  + sysbus IRQ 3 : VFIQ (exists even if virt extensions not present)
>> + *  + sysbus IRQ 4 : maintenance IRQ for CPU i/f 0 (only if virt extns present)
>> + *  + sysbus IRQ 5 : maintenance IRQ for CPU i/f 1 (only if virt extns present)
> I think it's more like
>
> For a GIC supporting N CPUs:
>   + sysbus IRQ 0: IRQ for CPU 0
>   + ...
>   + sysbus IRQ N-1: IRQ for CPU N-1
>
>   + sysbus IRQ N: FIQ for CPU 0
>   + ...
>   + sysbus IRQ 2*N-1: FIQ for CPU N-1
>
>   + sysbus IRQ 2*N: VIRQ for CPU 0
>   + ...
>   + sysbus IRQ 3*N-1: VIRQ for CPU N-1
>
>   + sysbus IRQ 3*N: VFIQ for CPU 0
>   + ...
>   + sysbus IRQ 4*N-1: VFIQ for CPU N-1
>
>   + sysbus IRQ 4*N: maintenance IRQ for CPU i/f 0 (only if virt extns
> present)
>   + ...
>   + sysbus IRQ 5*N-1: maintenance IRQ for CPU i/f N-1 (only if virt
> extns present)

Yes, indeed. Since this is just a comment patch, I'll apply
2-9 from this series to target-arm.next and respin this patch.
Thanks for the review.

-- PMM
