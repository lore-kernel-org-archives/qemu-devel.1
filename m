Received: from eggs.gnu.org ([2001:4830:134:3::10]:43894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceQmI-0004lV-2I
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 13:27:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceQmH-0000pm-1s
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 13:27:38 -0500
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:33994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ceQmG-0000ox-S5
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 13:27:36 -0500
Received: by mail-wr0-x22e.google.com with SMTP id z61so17544205wrc.1
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 10:27:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487262963-11519-4-git-send-email-peter.maydell@linaro.org>
References: <1487262963-11519-1-git-send-email-peter.maydell@linaro.org>
	<1487262963-11519-4-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Feb 2017 18:27:15 +0000
Message-ID: <CAFEAcA-JoKKkKtL=W0ecVQ=+wHbxe-gxKGho8GDm95YuyD7rWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 03/13] armv7m: Rewrite NVIC to not use
 any GIC code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "patches@linaro.org" <patches@linaro.org>

On 16 February 2017 at 16:35, Peter Maydell <peter.maydell@linaro.org> wrote:
> From: Michael Davidsaver <mdavidsaver@gmail.com>
>
> Despite some superficial similarities of register layout, the
> M-profile NVIC is really very different from the A-profile GIC.
> Our current attempt to reuse the GIC code means that we have
> significant bugs in our NVIC.
>
> Implement the NVIC as an entirely separate device, to give
> us somewhere we can get the behaviour correct.
>
> This initial commit does not attempt to implement exception
> priority escalation, since the GIC-based code didn't either.
> It does fix a few bugs in passing:
>  * ICSR.RETTOBASE polarity was wrong and didn't account for
>    internal exceptions
>  * ICSR.VECTPENDING was 16 too high if the pending exception
>    was for an external interrupt
>  * UsageFault, BusFault and MemFault were not disabled on reset
>    as they are supposed to be
>
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> [PMM: reworked, various bugs and stylistic cleanups]
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

> +    case 0x400 ... 0x5ef: /* NVIC Priority */
> +        startvec = 8 * (offset - 0x400) + NVIC_FIRST_IRQ; /* vector # */
> +
> +        for (i = 0; i < size; i++) {

Just noticed this line should be
+        for (i = 0; i < size && startvec + i < s->num_irq; i++) {

which brings it into line with the nvic_sysreg_read() code
and prevents an assert() in set_prio() if the guest writes to
registers beyond the end of the implemented IRQ range.

> +            set_prio(s, startvec + i, (value >> (i * 8)) & 0xff);
> +        }
> +        nvic_irq_update(s);
> +        return;

Unless there's some other problem that means I need
to respin anyway I propose to just squash in that fix.

thanks
-- PMM
