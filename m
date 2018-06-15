Received: from eggs.gnu.org ([2001:4830:134:3::10]:38753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTmOL-0004zZ-0e
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTmOK-00079y-7K
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:55:41 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:40152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTmOJ-00078T-Gg
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:55:39 -0400
Received: by mail-ot0-x243.google.com with SMTP id w9-v6so10502276otj.7
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 03:55:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180612204632.28780-1-jusual@mail.ru>
References: <20180612204632.28780-1-jusual@mail.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 11:55:18 +0100
Message-ID: <CAFEAcA-p5A4S=+ncW42KU2ivBHyALJdUswLUYhh=By6rKYstZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: Allow ARMv6-M Thumb2
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>

On 12 June 2018 at 21:46, Julia Suvorova <jusual@mail.ru> wrote:
> ARMv6-M supports 6 Thumb2 instructions. This patch checks for these
> instructions and allows their execution.
> Like Thumb2 cores, ARMv6-M always interprets BL instruction as 32-bit.
>
> This patch is required for future Cortex-M0 support.
>
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> @@ -10075,6 +10076,11 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
>  {
>      uint32_t imm, shift, offset;
>      uint32_t rd, rn, rm, rs;
> +    uint32_t armv6m_insn[] = {0xf3808000 /* msr */, 0xf3b08040 /* dsb */,
> +                              0xf3b08050 /* dmb */, 0xf3b08060 /* isb */,
> +                              0xf3e08000 /* mrs */, 0xf000d000 /* bl */};
> +    uint32_t armv6m_mask[] = {0xffe0d000, 0xfff0d0f0, 0xfff0d0f0,
> +                              0xfff0d0f0, 0xffe0d000, 0xf800d000};

I think these arrays should be 'const'; we can also move them closer
to their point of use, inside the scope of the if() below.

Since those are trivial tweaks, I'm going to put this into
target-arm.next with those changes made, if that's OK.

thanks
-- PMM
