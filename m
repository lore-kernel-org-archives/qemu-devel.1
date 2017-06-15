Received: from eggs.gnu.org ([2001:4830:134:3::10]:33248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1dLWql-0000rX-3v
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 11:38:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1dLWqi-0004NA-0P
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 11:38:23 -0400
Received: from greensocs.com ([193.104.36.180]:53594)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1dLWqh-0004Jm-Jc
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 11:38:19 -0400
References: <1488276185-31168-1-git-send-email-fred.konrad@greensocs.com>
	<b690a50d-4ab3-830c-93a3-5f2b4b027448@greensocs.com>
	<CAFEAcA94RykH0U33F0aGEYRs_FXF_NNuwQAX_mOf4wVde0s9BQ@mail.gmail.com>
	<1db78209-e426-03b5-9a19-592da96adaee@greensocs.com>
	<CAFEAcA-pmVW-fnu6ZT=PeRcSf-U5UVsyYsJkzh2c_BFKDTU5kg@mail.gmail.com>
	<d0a7ebb7-9f3d-5b3c-692e-344f4a980c05@redhat.com>
	<CAFEAcA_BkOaRCs1tm2dv+mYZj4yaNTg7VhR2C-NAQGAhw1wazA@mail.gmail.com>
	<20170615145742.GF4859@toto>
	<CAFEAcA-zhur3vO8G_CPQuyEU3p7e81cixiZ58sFs96e+av4Mbg@mail.gmail.com>
	<20170615151530.GC12347@toto>
From: KONRAD Frederic <fred.konrad@greensocs.com>
Message-ID: <cc1ec5be-27ea-319a-16dc-988ac8f6d8bc@greensocs.com>
Date: Thu, 15 Jun 2017 17:38:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170615151530.GC12347@toto>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/10] Clock framework API.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Mark Burton <mark.burton@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>



Le 15/06/2017 =E0 17:15, Edgar E. Iglesias a =E9crit :
> On Thu, Jun 15, 2017 at 04:04:56PM +0100, Peter Maydell wrote:
>> On 15 June 2017 at 15:57, Edgar E. Iglesias <edgar.iglesias@gmail.com>=
 wrote:
>>> On Thu, Jun 15, 2017 at 03:40:40PM +0100, Peter Maydell wrote:
>>>> Unfortunately we make no guarantees at all about migration order
>>>> for devices as far as I'm aware, so devices have to cope regardless.
>>>
>>>
>>> How does this work for interrupts/gpios?
>>
>> Interrupts/gpios (qemu_irqs) don't have any internal state,
>> so all that is needed is for both devices to correctly migrate
>> their idea of their internal state, and it doesn't matter which
>> order that happens in. (Typically in QEMU devices track the state
>> of their inbound interrupt lines even if in real hardware there's
>> no flop doing that.)
>>
>> The difference here is that the clock objects themselves have
>> internal state. That's not necessarily a bad idea, but it does
>> mean that something's got to migrate that state or otherwise
>> regenerate it. (Anthony once proposed that we should change qemu_irq
>> objects to have internal state, because that's effectively what real
>> hardware is and it would save the need for each device to track its
>> input line state and be notified if the line didn't actually change
>> state. It would just have been an enormous upheaval and migration
>> compat break...)
>
> Thanks. I didn't realize that the internal clock state would be used in=
 a
> way that is not deriveable from other device state & input clocks.
> I'm not sure this is a use-case we need to support, thoughts?
>
> Maybe there's some value in keeping interrupt and clock handling alike,
> e.g removing the internal state from clocks.
>
> I need to have another look at the series before I comment too much
> since I don't remember the details...
>

The use case for that is essentially knowing the rate value when
needed:
   * for example in the monitor.
   * if don't want to refresh the whole tree.

For the rest.. yes we can just keep the value in the device state..

Fred

> Best regards,
> Edgar
>
