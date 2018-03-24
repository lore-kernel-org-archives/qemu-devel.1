Received: from eggs.gnu.org ([208.118.235.92]:38950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ezsc7-0002R6-N3
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 19:31:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ezrlK-0004fq-Qn
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 18:36:52 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:37649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ezrlK-0004fE-L7
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 18:35:46 -0400
Received: by mail-oi0-x236.google.com with SMTP id f186-v6so13205147oig.4
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 15:35:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8ByeRz-=3juyLZMeW8zK2Sa=u547ZCrEqgXqBibygQ=w@mail.gmail.com>
References: <1521915220-65389-1-git-send-email-mjc@sifive.com>
	<1521915220-65389-3-git-send-email-mjc@sifive.com>
	<CAFEAcA8ByeRz-=3juyLZMeW8zK2Sa=u547ZCrEqgXqBibygQ=w@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Sat, 24 Mar 2018 15:35:45 -0700
Message-ID: <CAHNT7NthMA8zva9MQjztboOdo1HbSFzNcevdefAKs_x_fvpE_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 08/26] RISC-V: Make sure rom has space
 for fdt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On Sat, Mar 24, 2018 at 2:25 PM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 24 March 2018 at 18:13, Michael Clark <mjc@sifive.com> wrote:
> > Remove a potential buffer overflow (not seen in practice).
> > Perhaps cpu_physical_memory_write already has bound checks.
>
> cpu_physical_memory_write() writes to the guest address
> space, so it won't overflow. If you ask it to write
> off the end of a ROM then it will correctly write into
> an unassigned part of the guest memory space (which does
> nothing) or into whatever device or other ram is there.
> You probably don't want to do that, but it is not a buffer
> overflow.
>

I assumed that was the case but it is still probably good discipline to
have the bounds check.

We have also expanded the ROM regions to account for the default FDT size
which was larger than the previous ROM region sizes. I discovered this
while debugging another issue, where I had a debug statement to print the
fdt_size and noticed it was larger than the ROM region reserved for it.

It's belts and braces change. I'd prefer we at least make sure our ROM
regions are large enough for the default FDT size. It could be overflowed
on the virt board eventually if we enable many CPUs and add more devices.
The error message is a nice to have, as we'll know if the FDT size is too
large rather than have a subtle failure due to the boot loader parsing
truncated device tree.

This problem is not seen in practice... yet... but I still think it is
worth fixing.
