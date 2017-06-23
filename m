Received: from eggs.gnu.org ([2001:4830:134:3::10]:58081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dONrV-0005vs-GG
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:38:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dONrQ-0000i3-JO
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:38:57 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:36333
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1dONrQ-0000hb-AM
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:38:52 -0400
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
	<CAFEAcA-ZzVGJ+ueZXLuhtkMk=42QGhpJiu5PNZ7DAGXJf3hvXA@mail.gmail.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <209d2c8f-fd46-0a6f-17ac-b4f53f47c43e@adacore.com>
Date: Fri, 23 Jun 2017 14:38:48 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-ZzVGJ+ueZXLuhtkMk=42QGhpJiu5PNZ7DAGXJf3hvXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
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
To: Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: Mark Burton <mark.burton@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, KONRAD Frederic <fred.konrad@greensocs.com>



Le 06/23/2017 =C3=A0 11:51 AM, Peter Maydell a =C3=A9crit :
> On 15 June 2017 at 16:15, Edgar E. Iglesias <edgar.iglesias@xilinx.com>=
 wrote:
>> On Thu, Jun 15, 2017 at 04:04:56PM +0100, Peter Maydell wrote:
>>> The difference here is that the clock objects themselves have
>>> internal state. That's not necessarily a bad idea, but it does
>>> mean that something's got to migrate that state or otherwise
>>> regenerate it. (Anthony once proposed that we should change qemu_irq
>>> objects to have internal state, because that's effectively what real
>>> hardware is and it would save the need for each device to track its
>>> input line state and be notified if the line didn't actually change
>>> state. It would just have been an enormous upheaval and migration
>>> compat break...)
>>
>> Thanks. I didn't realize that the internal clock state would be used i=
n a
>> way that is not deriveable from other device state & input clocks.
>> I'm not sure this is a use-case we need to support, thoughts?
>>
>> Maybe there's some value in keeping interrupt and clock handling alike=
,
>> e.g removing the internal state from clocks.
>=20
> It occurs to me that it might be possible to split the
> difference, ie the clock object still has internal state,
> but the device that owns it is responsible for that state's
> migration, so you would have
>    VMSTATE_CLOCK(myclock, MyDeviceState),

Yes I think that makes sense.

>=20
> in the vmstate for every clock you owned. (Not sure whether
> that should be "every input clock" or "every output clock"
> or even both?)
>=20
> As an aside, I still find it very odd that you get a clock
> object for both an input clock and an output clock. I feel
> like we should have one end owns the clock object and the
> other just has a reference to it of some kind.

The point is beeing able to bind/unbind clocks inside the device
to model a clock selector for example. So you just bind/unbind
the input and output clocks.

Secondly you can print the clock input rate in the mtree command
so you can eg: debug it.

Thanks,
Fred

>=20
> thanks
> -- PMM
>=20
