Received: from eggs.gnu.org ([2001:4830:134:3::10]:55474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cxyEE-0001MZ-LR
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 12:01:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cxyED-0001su-JY
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 12:01:14 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:34629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1cxyED-0001rZ-F0
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 12:01:13 -0400
Received: by mail-oi0-x243.google.com with SMTP id o83so314867oik.1
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 09:01:13 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <CAFEAcA_E0vM9HE1=5DVhw9cA-BYea1wR2M1LHEXs1L+-Q5vUCg@mail.gmail.com>
References: <cover.1491349058.git.alistair.francis@xilinx.com>
	<325f60be9b819f261848db3d69554da640294ca4.1491349058.git.alistair.francis@xilinx.com>
	<CAFEAcA9Pp85ir53BEsd2dT=6iG8gi_6hH2hGkn12Fus0k1K8FQ@mail.gmail.com>
	<CAKmqyKOXoMRQbe+qEroxZxVPh06JU6vbZJ1wddBb_8imPeD-1A@mail.gmail.com>
	<CAFEAcA_E0vM9HE1=5DVhw9cA-BYea1wR2M1LHEXs1L+-Q5vUCg@mail.gmail.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 11 Apr 2017 09:00:41 -0700
Message-ID: <CAKmqyKMTmnipfAWwjAQdDgryXoVyMxQg+7ow4=wBO5sBv7gMtQ@mail.gmail.com>
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

On Tue, Apr 11, 2017 at 2:05 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 10 April 2017 at 23:23, Alistair Francis <alistair.francis@xilinx.com> wrote:
>> On Mon, Apr 10, 2017 at 5:44 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> Also the comment says "raise or lower interrupt based on current
>>> status", but the code will only ever do qemu_set_irq(..., 1),
>>> never 0. Which is right?
>>
>> This is a little confusing. The interrupts are lowered when the ISR is
>> read, so the assumption was that we never need to clear them in the
>> gem_update_int_status(). Although then if we perform a reset nothing
>> will clear the interrupts until the ISR is read from.
>
> On QEMU reset the other end will be reset anyway so it will
> update its idea of whether the irq is asserted (and calling
> qemu_set_irq in a reset function is generally not a good idea).
> If the device has guest-programmable reset of some kind you'd
> need to clear the irq lines then, though.

Ok, that explains why it was always working.

I still like the idea of all irq updates (raise or lower) being done
in a single function. Instead of how it was previously where the
raises where in one function and the lower was in the read function.
That way if in some future IP version the ISR is cleared somewhere
else the interrupt logic is ready to handle it.

I did make one small error in my V2 though, so I'll send a V3 with the
consolidation still in it.

Thanks,

Alistair

>
> thanks
> -- PMM
>
