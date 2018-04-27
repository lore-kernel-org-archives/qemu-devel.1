Received: from eggs.gnu.org ([2001:4830:134:3::10]:56783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fBxeX-00087j-UM
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 03:18:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fBxeW-0004xx-T2
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 03:18:45 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:33555)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fBxeW-0004xm-NB
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 03:18:44 -0400
Received: by mail-oi0-x236.google.com with SMTP id 126-v6so774038oig.0
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 00:18:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7ec6ba72-fee7-52db-a73a-be1720a06383@linaro.org>
References: <1524699938-6764-1-git-send-email-mjc@sifive.com>
	<1524699938-6764-23-git-send-email-mjc@sifive.com>
	<7ec6ba72-fee7-52db-a73a-be1720a06383@linaro.org>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 27 Apr 2018 19:18:43 +1200
Message-ID: <CAHNT7NsJOsJdFPEA96OeB2CSO0Gvz_iY192__7D0yUS4=F6Njg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 22/35] RISC-V: Use atomic_cmpxchg to
 update PLIC bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, RISC-V Patches <patches@groups.riscv.org>

On Fri, Apr 27, 2018 at 12:14 PM, Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 04/25/2018 01:45 PM, Michael Clark wrote:
> > +    uint32_t old, new;
> > +    do {
> > +        old = atomic_read(&plic->pending[word]);
> > +        new = (old & ~(1 << (irq & 31))) | (-!!pending & (1 << (irq &
> 31)));
> > +    } while (atomic_cmpxchg(&plic->pending[word], old, new) != old);
>
> I prefer
>
>   uint32_t old, new, cmp = atomic_read(...);
>   do {
>     old = cmp;
>     new = ...;
>     cmp = atomic_cmpxchg(...);
>   } while (old != cmp);
>
> to avoid an extra load, should we loop.
>

Thanks. I've revised the code to use this convention.

I've also done so in "Implement atomic mip/sip CSR updates" which has the
same pattern.

That said, what you have is not wrong.  So,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~
>
