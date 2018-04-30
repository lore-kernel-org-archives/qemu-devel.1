Received: from eggs.gnu.org ([2001:4830:134:3::10]:44841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fD3ZX-0006nC-Fn
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 03:50:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fD3ZW-0004hA-GD
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 03:50:07 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:40493)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fD3ZW-0004gi-BK
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 03:50:06 -0400
Received: by mail-oi0-x241.google.com with SMTP id c203-v6so6689825oib.7
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 00:50:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHNT7Nuv9p9Bdxc+zUuF_sii+gzZgk5SMAeg+7XHi0Q3X=ympg@mail.gmail.com>
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
	<1519998711-73430-19-git-send-email-mjc@sifive.com>
	<CAFEAcA9PQU3EFi2OwZ9=tzj3-59yzGuCrWomUKqCEcuqYP+Z9A@mail.gmail.com>
	<CAHNT7Nuv9p9Bdxc+zUuF_sii+gzZgk5SMAeg+7XHi0Q3X=ympg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Apr 2018 08:49:44 +0100
Message-ID: <CAFEAcA9g6nUdym79jwp0RwxT5b+xuoYXaD++noPKh=Sm=D8eVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 18/23] RISC-V VirtIO Machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 30 April 2018 at 01:18, Michael Clark <mjc@sifive.com> wrote:
> Quite a bit of our initialization code in several QOM classes allocate
> memory that is not freed. e.g. the PLIC. Usually these functions are only
> run once, but ideally all of the code should be memory clean. i.e. exit
> without leaks. Many programs don't bother with this but I think it is a good
> practice.
>
> Should we use dc->unrealize to point to an unrelalize function that calls
> g_free? Is unrealize the QOM destructor?

unrealize is the destructor, yes, but we currently only use it for
devices that are hot-pluggable (and thus unpluggable). For non-pluggable
devices we currently generally don't worry about giving the objects
a destructor, since it can never be called.

This is a bit weird though, and I think there's a thread on-list
somewhere where there's a proposal that we should (a) document
better the best way to divide tasks between init/realize and
(b) perhaps suggest that devices should init unrealize too.

Board model code is also rather prone to "allocate and never free",
because historically boards didn't have a QOM object to own the
memory they allocated. This is why board code often does
g_new0(MemoryRegion, 1) to allocate MemoryRegions, where device
code would just have a MemoryRegion field in its device struct.
Now that boards have real MachineState objects associated with
them, it is possible to write them the way you write a device --
hw/arm/mps2.c has an example of this. Since again it doesn't have
a destructor there's not much difference in practice, though:
we still rely on the memory being freed on program exit.

thanks
-- PMM
