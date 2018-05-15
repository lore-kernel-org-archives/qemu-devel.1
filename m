Received: from eggs.gnu.org ([2001:4830:134:3::10]:42970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIVmv-0004nr-KP
	for qemu-devel@nongnu.org; Tue, 15 May 2018 04:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIVmu-0007mx-SF
	for qemu-devel@nongnu.org; Tue, 15 May 2018 04:58:29 -0400
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:45180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIVmu-0007ml-M9
	for qemu-devel@nongnu.org; Tue, 15 May 2018 04:58:28 -0400
Received: by mail-ot0-x22f.google.com with SMTP id 15-v6so17552317otn.12
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 01:58:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAG0V3WQCJ-ttZNo3A4tLy3Y=QADhfk8VaDFRRbrLjNBRWYw63w@mail.gmail.com>
References: <CAG0V3WQCJ-ttZNo3A4tLy3Y=QADhfk8VaDFRRbrLjNBRWYw63w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 09:58:07 +0100
Message-ID: <CAFEAcA-m7-xuMkpVyb4Xy-ENbraCgcDL0BeqMG0y6cb+_6H5EA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Question about io_writex()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eva Chen <debby83729@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 15 May 2018 at 02:26, Eva Chen <debby83729@gmail.com> wrote:
> Hello,
>
> I want to know the flow of how devices read/write function be called by
> code_gen_buffer().
> Take pl110_write() for example, I set a breakpoint in  pl110_write(), and
> the backtrace shows bellow.

Hi. This code flow is a bit complicated. You'll probably find
your backtraces give you better information if you build QEMU
without optimization (pass --enable-debug to configure). Then
you won't get all those <optimized out> things for parameters
in the backtrace, and the compiler will also be less likely to
confusingly inline functions.

> This backtrace shows that pl110_write() is called by io_wrtex(), but I
> can't find who call the io_writex().

io_writex() is called by functions in accel/tcg/softmmu_template.h.
These are a bit tricky because we include this header file multiple
times and use the C preprocessor to construct function names, like:

static inline void glue(io_write, SUFFIX)(CPUArchState *env,
                                          size_t mmu_idx, size_t index,
                                          DATA_TYPE val,
                                          target_ulong addr,
                                          uintptr_t retaddr)
{
[...]
}

The header is included multiple times, with SUFFIX being 'q', 'l',
'w', and so on, so this one line gives us functions io_writeq,
io_writel, io_writew.

> code_gen_buffer() is the part that QEMU execute the TB, I think maybe
> io_writex() is called by the helper function but I only find io_writex() in
> softmmu_template.h (*static inline void glue(io_write, SUFFIX)), *which is
> not related to the helper function.

It is related. io_writel and friends are called from
the functions defined in softmmu_template.h which look like
they're called 'helper_le_st_name' and 'helper_be_st_name', but
note that those are #defines defined earlier in the file, and
the actual function names are therefore a family of functions
with names like 'helper_le_ldul_mmu'. (A non-optimized build
will probably show you this function in the gdb backtrace.)
Those helper functions are called directly from generated TCG
code.

thanks
-- PMM
