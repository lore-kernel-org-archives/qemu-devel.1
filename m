Received: from eggs.gnu.org ([2001:4830:134:3::10]:44173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxrkO-00057y-33
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxrkN-0000Wf-0D
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:06:00 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:35847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cxrkM-0000WP-Pe
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:05:58 -0400
Received: by mail-wr0-x231.google.com with SMTP id c55so90805339wrc.3
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 02:05:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKOXoMRQbe+qEroxZxVPh06JU6vbZJ1wddBb_8imPeD-1A@mail.gmail.com>
References: <cover.1491349058.git.alistair.francis@xilinx.com>
	<325f60be9b819f261848db3d69554da640294ca4.1491349058.git.alistair.francis@xilinx.com>
	<CAFEAcA9Pp85ir53BEsd2dT=6iG8gi_6hH2hGkn12Fus0k1K8FQ@mail.gmail.com>
	<CAKmqyKOXoMRQbe+qEroxZxVPh06JU6vbZJ1wddBb_8imPeD-1A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Apr 2017 10:05:37 +0100
Message-ID: <CAFEAcA_E0vM9HE1=5DVhw9cA-BYea1wR2M1LHEXs1L+-Q5vUCg@mail.gmail.com>
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
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 10 April 2017 at 23:23, Alistair Francis <alistair.francis@xilinx.com> wrote:
> On Mon, Apr 10, 2017 at 5:44 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> Also the comment says "raise or lower interrupt based on current
>> status", but the code will only ever do qemu_set_irq(..., 1),
>> never 0. Which is right?
>
> This is a little confusing. The interrupts are lowered when the ISR is
> read, so the assumption was that we never need to clear them in the
> gem_update_int_status(). Although then if we perform a reset nothing
> will clear the interrupts until the ISR is read from.

On QEMU reset the other end will be reset anyway so it will
update its idea of whether the irq is asserted (and calling
qemu_set_irq in a reset function is generally not a good idea).
If the device has guest-programmable reset of some kind you'd
need to clear the irq lines then, though.

thanks
-- PMM
