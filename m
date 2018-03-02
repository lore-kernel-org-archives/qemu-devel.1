Received: from eggs.gnu.org ([2001:4830:134:3::10]:50926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1erkhT-0003rm-KX
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:26:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1erkhS-0007r5-DZ
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:26:15 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:34497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1erkhS-0007qs-6k
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:26:14 -0500
Received: by mail-ot0-x244.google.com with SMTP id n74so8697526ota.1
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 05:26:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180228222627.GA3575@flamenco>
References: <1519690504-37792-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_0qNcikG2iLii=4zEPYvhz1koEbhCCrCXssdKYv06OJA@mail.gmail.com>
	<CADJ6UvPQMDq_RES_u6WUmXHsita+On4oLu-V=emp3MnmmzjHhQ@mail.gmail.com>
	<CAHNT7Nv04hScm7QDtJMhFZeB=WOyOQ6HW1J-xOEO11GM1xFqyA@mail.gmail.com>
	<20180228222627.GA3575@flamenco>
From: Michael Clark <mjc@sifive.com>
Date: Sat, 3 Mar 2018 02:26:12 +1300
Message-ID: <CAHNT7NsPog=OLcU-RuVQQVpYk2n9nvHM453YLdDZocu8h0HYDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [patches] Re: [PULL] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Stef O'Rear <sorear2@gmail.com>, RISC-V Patches <patches@groups.riscv.org>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On Thu, Mar 1, 2018 at 11:26 AM, Emilio G. Cota <cota@braap.org> wrote:

> On Wed, Feb 28, 2018 at 13:09:11 +1300, Michael Clark wrote:
> > BTW somewhat coincidentally, the binary translator I wrote; RV8, which is
> > practicaly twice as fast as QEMU only supports privileged ISA v1.9.1 and
> I
> > personally want to keep binary compatiblity with it.
> (snip)
> > - https://rv8.io/
> > - https://rv8.io/bench
> > - https://anarch128.org/~mclark/rv8-carrv.pdf
> > - https://anarch128.org/~mclark/rv8-slides.pdf
>
> What QEMU versions did you use for those comparisons? I wonder if
> the recent indirect branch handling improvements were included in those
> (this work was merged in 2.10 for aarch64). Also, 2.7 is quite a bit
> faster than previous versions for user-mode due to the use of QHT,
> although you probably used a later version.
>

Yes I noticed indirect branch handling was very slow in the QEMU verison I
tested. I have highly optimised assembly stubs that implement a direct
mapped translation cache and translation cache miss fallback to C code that
does a fast hash map lookup.


> BTW after the merge you might want to look into optimizing indirect
> branches (and cross-page direct jumps in softmmu) for riscv in qemu.
> See examples with
>         $ git log -Stcg_gen_lookup_and_goto_ptr
>

It was qemu-2.7.50 (late 2016). The benchmarks were generated mid last year.

I can run the benchmarks again... Has it doubled in speed?

Note: I don't even have a register allocator. I've assigned RISC-V RVC
register to hard registers (compiler optimises to choose compressable
registers first) and the remainder are in spill slots that in many cases
can be embedded as memory operands in the x86_64 translation. i.e. no
explicit reload, we let the micro-architecture crack these into micro-ops,
as they help to keep up code density.

I think I can get close to double again with tiered optimization and a good
register allocator (lift RISC-V asm to SSA form). It's also a hotspot
interpreter, which is definately faster than compiling all code, as I
benchmarked it. It profiles and only translates hot paths, so code that
only runs a few iterations is not translated. When I did eager transaltion
I got a slow-down.
