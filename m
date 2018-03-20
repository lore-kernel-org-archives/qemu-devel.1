Received: from eggs.gnu.org ([2001:4830:134:3::10]:33102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eyLen-0008UM-Lc
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eyLem-0003Jc-Ep
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:06:45 -0400
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:38874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eyLem-0003JH-70
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:06:44 -0400
Received: by mail-ot0-x236.google.com with SMTP id 95-v6so2756315ote.5
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 11:06:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <75283674-1f4b-453c-0833-d84ab76a52cd@linaro.org>
References: <1521221171-47213-1-git-send-email-mjc@sifive.com>
	<dec4f79c-a46e-f341-ef17-7ba85086bc9a@amsat.org>
	<CAHNT7Nuv9G+e3-m-356HZDoiLju=vPCucfWhXLJ0QHPGM7NSQw@mail.gmail.com>
	<75283674-1f4b-453c-0833-d84ab76a52cd@linaro.org>
From: Michael Clark <mjc@sifive.com>
Date: Tue, 20 Mar 2018 11:06:43 -0700
Message-ID: <CAHNT7NsmzEaLavarW=qXYdx9o0GOQWY5_vDsEk9AU58S=jZocQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] RISC-V: Fix riscv_isa_string memory
 size bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, "Richard W.M. Jones" <rjones@redhat.com>

On Mon, Mar 19, 2018 at 9:43 PM, Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 03/20/2018 02:35 AM, Michael Clark wrote:
> > FYI - I also have an experimental branch containing a RISC-V TCG back-end
> > that I started on during the RISC-V Hackathon in Portland last week:
> >
> > - https://github.com/michaeljclark/riscv-qemu/tree/wip-riscv-tcg-backend
>
> Cool.
>
> > I'm able to run a very simple x86_64 hello world program on RISC-V,
> > avoiding all of the usual libc startup. However, it may be some time
> before
> > I submit a patch series for this branch. So far the RISC-V TCG backend
> > doesn't implement softmmu, have bigendian byteswapping in its load/store
> > implementation ...
>
> Before you work too hard on this last, ping me.  I've been intending to
> change
> TCG such that hosts that do not support byte-swapping memory operations do
> not
> need to handle them specially.  Instead, we'd expand a "normal" byte swap
> from
> a temporary after a load (and similarly before a store).
>

Okay. I'll leave the byte swapping out for now. The first priority is to
test the basic codegen with little endian front-ends e.g. riscv -> riscv
and x86 -> riscv, and the second priority is to implement softmmu. I still
have some bugs as its pretty new code, but as I mentioned, the bones are
there. i.e. we have relocs and instruction encoders for riscv.


> I expect this to improve the state of affairs for i386 (without movbe),
> where
> we are currently extremely limited in the available registers.
>

Okay, so this would move byte swapping into TCG generic code instead of the
TCG backend, unless the backend explicitly supports load/store with byte
swap?
