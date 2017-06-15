Received: from eggs.gnu.org ([2001:4830:134:3::10]:47306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLWKm-0002Bv-33
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 11:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLWKl-0005tH-2F
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 11:05:20 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:34419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dLWKk-0005sr-Ml
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 11:05:19 -0400
Received: by mail-wm0-x236.google.com with SMTP id d64so505762wmf.1
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 08:05:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170615145742.GF4859@toto>
References: <1488276185-31168-1-git-send-email-fred.konrad@greensocs.com>
	<b690a50d-4ab3-830c-93a3-5f2b4b027448@greensocs.com>
	<CAFEAcA94RykH0U33F0aGEYRs_FXF_NNuwQAX_mOf4wVde0s9BQ@mail.gmail.com>
	<1db78209-e426-03b5-9a19-592da96adaee@greensocs.com>
	<CAFEAcA-pmVW-fnu6ZT=PeRcSf-U5UVsyYsJkzh2c_BFKDTU5kg@mail.gmail.com>
	<d0a7ebb7-9f3d-5b3c-692e-344f4a980c05@redhat.com>
	<CAFEAcA_BkOaRCs1tm2dv+mYZj4yaNTg7VhR2C-NAQGAhw1wazA@mail.gmail.com>
	<20170615145742.GF4859@toto>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Jun 2017 16:04:56 +0100
Message-ID: <CAFEAcA-zhur3vO8G_CPQuyEU3p7e81cixiZ58sFs96e+av4Mbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 00/10] Clock framework API.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Mark Burton <mark.burton@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, KONRAD Frederic <fred.konrad@greensocs.com>

On 15 June 2017 at 15:57, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> On Thu, Jun 15, 2017 at 03:40:40PM +0100, Peter Maydell wrote:
>> Unfortunately we make no guarantees at all about migration order
>> for devices as far as I'm aware, so devices have to cope regardless.
>
>
> How does this work for interrupts/gpios?

Interrupts/gpios (qemu_irqs) don't have any internal state,
so all that is needed is for both devices to correctly migrate
their idea of their internal state, and it doesn't matter which
order that happens in. (Typically in QEMU devices track the state
of their inbound interrupt lines even if in real hardware there's
no flop doing that.)

The difference here is that the clock objects themselves have
internal state. That's not necessarily a bad idea, but it does
mean that something's got to migrate that state or otherwise
regenerate it. (Anthony once proposed that we should change qemu_irq
objects to have internal state, because that's effectively what real
hardware is and it would save the need for each device to track its
input line state and be notified if the line didn't actually change
state. It would just have been an enormous upheaval and migration
compat break...)

thanks
-- PMM
