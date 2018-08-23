Received: from eggs.gnu.org ([2001:4830:134:3::10]:46942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chrisfriedt@gmail.com>) id 1fsvcf-0004Mq-GE
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 15:50:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chrisfriedt@gmail.com>) id 1fsvce-0006AN-LC
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 15:50:25 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:37465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <chrisfriedt@gmail.com>)
	id 1fsvce-00069x-Ej
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 15:50:24 -0400
Received: by mail-oi0-x241.google.com with SMTP id p84-v6so11395896oic.4
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 12:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAF4BF-R8iAkeHXFPHazY2Tmr+Yh=WrG4yKx=LVm7rRLBnxKseA@mail.gmail.com>
	<CAFEAcA_y2-N_aaG4W4rQABsTe=B++pSMp53_kKay0_MjGT4WpA@mail.gmail.com>
In-Reply-To: <CAFEAcA_y2-N_aaG4W4rQABsTe=B++pSMp53_kKay0_MjGT4WpA@mail.gmail.com>
From: Christopher Friedt <chrisfriedt@gmail.com>
Date: Thu, 23 Aug 2018 15:50:11 -0400
Message-ID: <CAF4BF-RzCr_hx6iAPR3pQ_eAChue38eTE646EOou6XE6FkNSVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Fix ARM v7m gen_intermediate_code()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu., Aug. 23, 2018, 2:20 p.m. Peter Maydell, <peter.maydell@linaro.org>
wrote:

> On 23 August 2018 at 17:36, Christopher Friedt <chrisfriedt@gmail.com>
> wrote:
>
> Hi; thanks for your patch, but I don't think it is correct.
> What it does is to make QEMU ignore the T bit in the xPSR.
> The architecture says that what should happen is that attempts
> to execute with the T bit clear should cause an INVSTATE
> UsageFault, which is exactly what we do. The reason we end up
> aborting is because the CPU should really be going into
> Lockup mode (where it basically hangs indefinitely),
> and QEMU doesn't implement that.
>
> Your guest code almost certainly has a bug where it is
> not setting the low bit in the words in its exception
> vector table. See the v7M ARM ARM section B1.5.3 if you
> happen to have a copy on your lake, but the short answer
> is that bit 1 must be set, exactly because this is what
> defines whether EPSR.T is set on exception entry. If
> you tried this on real hardware it would fail in the
> same way (except that the hardware would lock up and sit
> there like a lemon rather than calling abort()).
>

Doh! You're right, although I checked for that in my rom vector table. As
it turns out, I relocated my vtable to ram and *then* zeroed bss, which
would obviously clear the T bit.

Cheers ;-)

>
