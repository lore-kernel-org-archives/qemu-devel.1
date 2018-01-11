Received: from eggs.gnu.org ([2001:4830:134:3::10]:60834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZh4k-0004eu-Go
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 12:55:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZh4j-0003FQ-EP
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 12:55:38 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:44666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eZh4j-0003Ex-7p
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 12:55:37 -0500
Received: by mail-oi0-x244.google.com with SMTP id g128so2178368oib.11
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 09:55:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d78fb981-83a5-9398-f878-095d41fc3dff@linaro.org>
References: <1515637324-96034-1-git-send-email-mjc@sifive.com>
	<1515637324-96034-4-git-send-email-mjc@sifive.com>
	<d78fb981-83a5-9398-f878-095d41fc3dff@linaro.org>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 12 Jan 2018 06:55:36 +1300
Message-ID: <CAHNT7Nvw1J2Xv=CDLhyRNz44Ljd2ME60SjoKMGJ0uT8ZxLtrXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 03/21] RISC-V CPU Core Definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Fri, Jan 12, 2018 at 3:37 AM, Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 01/10/2018 06:21 PM, Michael Clark wrote:
> > +static inline void cpu_get_tb_cpu_state(CPURISCVState *env,
> target_ulong *pc,
> > +                                        target_ulong *cs_base, uint32_t
> *flags)
> > +{
> > +    *pc = env->pc;
> > +    *cs_base = 0;
> > +    *flags = 0; /* necessary to avoid compiler warning */
> > +}
>
> Actually, at minimum you have to put enough into flags to differentiate
> machine
> vs supervisor vs user mode.  Otherwise you can wind up running a previously
> translated block with the wrong permissions.
>
> The patch I saw from Stefan O'Rear would do nicely.
>

OK. I didn't see the patch. I'll trawl through my email for the last couple
of weeks before the next spin.

So any CPU state that can effect translation should be in flags?

Assuming that is the case, we could probably join mode with the lower 26
bits of misa and we probably should do a tb_flush on misa CSR writes if any
bits are changed. i.e. if extensions such as MAFDC are added or
removed (muldiv, atomics, fp-single, fp-double, compressed).
