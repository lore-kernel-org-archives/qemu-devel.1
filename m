Received: from eggs.gnu.org ([2001:4830:134:3::10]:34603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eooxs-0007J0-0O
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:23:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eooxq-0006pc-TA
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:23:03 -0500
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:43068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eooxq-0006og-Nf
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:23:02 -0500
Received: by mail-ot0-x236.google.com with SMTP id q12so4288486otg.10
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 03:23:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180220132627.4163-1-hlandau@devever.net>
References: <20180220132627.4163-1-hlandau@devever.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 11:22:41 +0000
Message-ID: <CAFEAcA-xAAHnyGxh0xjUiyw_cgHKv2eKspxo3=5xp7Ypbt2O_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Fix ast2500 protection register emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hugo Landau <hlandau@devever.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>

On 20 February 2018 at 13:26, Hugo Landau <hlandau@devever.net> wrote:
> Some register blocks of the ast2500 are protected by protection key
> registers which require the right magic value to be written to those
> registers to allow those registers to be mutated.
>
> Register manuals indicate that writing the correct magic value to these
> registers should cause subsequent reads from those values to return 1,
> and writing any other value should cause subsequent reads to return 0.
>
> Previously, qemu implemented these registers incorrectly: the registers
> were handled as simple memory, meaning that writing some value x to a
> protection key register would result in subsequent reads from that
> register returning the same value x. The protection was implemented by
> ensuring that the current value of that register equaled the magic
> value.
>
> This modifies qemu to have the correct behaviour: attempts to write to a
> ast2500 protection register results in a transition to 1 or 0 depending
> on whether the written value is the correct magic. The protection logic
> is updated to ensure that the value of the register is nonzero.
>
> This bug caused deadlocks with u-boot HEAD: when u-boot is done with a
> protectable register block, it attempts to lock it by writing the
> bitwise inverse of the correct magic value, and then spinning forever
> until the register reads as zero. Since qemu implemented writes to these
> registers as ordinary memory writes, writing the inverse of the magic
> value resulted in subsequent reads returning that value, leading to
> u-boot spinning forever.
>
> Signed-off-by: Hugo Landau <hlandau@devever.net>

> -    if (addr != R_PROT && s->regs[R_PROT] != PROT_KEY_UNLOCK) {
> +    if (addr == R_PROT) {
> +      s->regs[addr] = (data == PROT_KEY_UNLOCK) ? 1 : 0;
> +      return;
> +    }

Applied to target-arm.next, thanks. I fixed up the incorrect indentation
in this part which checkpatch complains about.

-- PMM
