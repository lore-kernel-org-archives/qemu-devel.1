Received: from eggs.gnu.org ([2001:4830:134:3::10]:48316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cf7DZ-0003M8-GA
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 10:46:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cf7DY-0004Mk-Ka
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 10:46:37 -0500
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:33227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cf7DY-0004Lw-Eq
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 10:46:36 -0500
Received: by mail-wr0-x231.google.com with SMTP id 35so3677041wrw.0
	for <qemu-devel@nongnu.org>; Sat, 18 Feb 2017 07:46:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <076b0d94-738e-252c-1ed8-4640a864ac34@ispras.ru>
References: <076b0d94-738e-252c-1ed8-4640a864ac34@ispras.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 18 Feb 2017 15:46:14 +0000
Message-ID: <CAFEAcA-zURkUb28wVA347AFJX5Wa4GyXbFSVmUDH1BSXRMA+rQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] ARM i.MX timers: fix software
 reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kurban Mallachiev <mallachiev@ispras.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>

On 17 February 2017 at 18:18, Kurban Mallachiev <mallachiev@ispras.ru> wrote:
> Hello!
>
> i.MX6 RM says that setting software reset bit in CR register of GPT (general
> purpose timers) should resets all of the registers of GPT to their default
> reset values, except for the CLKSRC, EN, ENMOD, STOPEN, WAITEN, and DBGEN
> bits in CR. But current implementation does the opposite for CR register (it
> clears CLKSRC and friends bits and preserves the others).
>
> Most importantly this leads to that software reset bit doesn't clears
> automatically.
>
> I have a look at git history and found that software reset bit was being
> cleared before 462566fc5e3 commit.
>
> I have doubts about the correct fixing of this problem. I don't really
> understand the nature of the "Soft reset doesn't touch some bits; hard reset
> clears them" comment in imx_gpt_reset function, does it mean that
> imx_gpt_reset performs a hard reset or soft reset? I see two possible
> fixings:
>
> 1. If imx_gpt_reset purpose is to do a software reset of device, then we
> should fix this function. My patch at the end of email fixes this function.
>
> 2. If imx_gpt_reset purpose is to do a hard reset of device? then there
> should be another function to software reset of device. If so I can create a
> new patch.

As the function registered via the DeviceState's dc->reset
pointer, imx_gpt_reset() has to behave as a "device was
powercycled" level reset. It looks like we also call it
from imx_gpt_write() when the guest does a write to a
particular register. If that guest-requested reset has
to have different behaviour from "device was powered off
and on again" then it needs to use a different function
and can't just call imx_gpt_reset().

thanks
-- PMM
