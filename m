Received: from eggs.gnu.org ([2001:4830:134:3::10]:56180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdd2J-0002el-Fi
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:57:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdd2I-0000aG-9t
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:57:39 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:43303)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fdd2I-0000ZD-3J
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:57:38 -0400
Received: by mail-oi0-x241.google.com with SMTP id b15-v6so56271874oib.10
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 07:57:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d4a776fc-2022-979e-cc68-beb3123d35bd@greensocs.com>
References: <20180629132954.24269-1-luc.michel@greensocs.com>
	<20180629132954.24269-21-luc.michel@greensocs.com>
	<d8062fb6-8eef-eff3-fa92-9f9f791ee669@web.de>
	<a199e550-4576-3a03-a7c1-8c21bb502cf5@web.de>
	<d4a776fc-2022-979e-cc68-beb3123d35bd@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jul 2018 15:57:16 +0100
Message-ID: <CAFEAcA8ZLzy22uJO07UMXmOTwMqLAggeM18NK8ofZg307OXhhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 20/20] arm/virt: Add support for GICv2
 virtualization extensions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: Jan Kiszka <jan.kiszka@web.de>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, Mark Burton <mark.burton@greensocs.com>

On 5 July 2018 at 09:46, Luc Michel <luc.michel@greensocs.com> wrote:
> On 07/05/2018 10:00 AM, Jan Kiszka wrote:
>> On 2018-07-05 08:51, Jan Kiszka wrote:
>>> But now I'm running into troubles with reading back GICD ITARGETSR.
>>> Maybe we are emulating an "early implementation" here?
>>>
>>> [from the related Jailhouse code [1]]
>>> /*
>>>  * Get the CPU interface ID for this cpu. It can be discovered by
>>>  * reading the banked value of the PPI and IPI TARGET registers
>>>  * Patch 2bb3135 in Linux explains why the probe may need to scans the
>>>  * first 8 registers: some early implementation returned 0 for the first
>>>  * ITARGETSR registers.
>>>  * Since those didn't have virtualization extensions, we can safely
>>>  * ignore that case.
>>>  */
>>>
>>> But maybe I'm just off with the configuration, checking...
>>>
>>
>> As suspected, it's a bug in QEMU, this resolves it, and I can run Linux
>> as root cell and a bare metal non-root cell:
>>
>> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
>> index 7d24348d96..199f953ddb 100644
>> --- a/hw/intc/arm_gic.c
>> +++ b/hw/intc/arm_gic.c
>> @@ -965,7 +965,11 @@ static uint32_t gic_dist_readb(void *opaque, hwaddr offset, MemTxAttrs attrs)
>>              if (irq >= 29 && irq <= 31) {
>>                  res = cm;
>>              } else {
>> -                res = GIC_DIST_TARGET(irq);
>> +                if (irq < GIC_INTERNAL) {
>> +                    res = 1 << gic_get_current_cpu(s);

We already have the CPU number of the current cpu in the 'cpu'
local variable, so we don't need to call gic_get_current_cpu() again,
and we have 1 << cpu in "cm".

>> +                } else {
>> +                    res = GIC_DIST_TARGET(irq);
>> +                }
>>              }
>>          }
>>      } else if (offset < 0xf00) {
>>
>> Didn't test Linux as non-root cell (secondary guest) yet, but that
>> should work as well. I'm seeing issues in an error shutdown path, but
>> that might be the same on real hw, needs cross-checking.Hi Jan, thanks for your feedback!
>
> Yes I encountered the same issue with Xen in SMP (see my cover letter).
> Re-reading the GICv2 specs, it's now clear to me that a read to
> ITARGETSR0 to ITARGETSR7 should return "the number of the processor
> performing the read". Reading the message of commit 2bb3135 in Linux, it
> seems that older versions of the GIC exposed this value in IRQs 29, 30,
> 31, hence the
>    if (irq >= 29 && irq <= 31) { res = cm; }
> in the current QEMU implementation.
>
> I should probably add a patch to fix that. I'll have to dig in specs of
> older GIC revisions to see when this behaviour actually appeared.

The "29..31 give the current CPU and others are zero" behaviour is
specific to the 11MPCore:
http://arminfo.emea.arm.com/help/topic/com.arm.doc.ddi0360f/CCHBHJFH.html
The GICv1 spec matches the GICv2 here.

So what we want is probably to refactor this to pull the 11MPCore
code out as the top level special case (since it's weird for
uniprocessor setups too). I'll send a patch in a bit...

thanks
-- PMM
