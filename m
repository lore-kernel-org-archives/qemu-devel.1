Received: from eggs.gnu.org ([2001:4830:134:3::10]:50162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewn7m-0005Hk-QC
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewn7h-0004Mf-67
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:02:14 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:38081)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ewn7h-0004MU-0p
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:02:09 -0400
Received: by mail-ot0-x242.google.com with SMTP id 95-v6so9940929ote.5
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 04:02:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180316103408.22295-1-richard.henderson@linaro.org>
References: <20180316103408.22295-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Mar 2018 11:01:46 +0000
Message-ID: <CAFEAcA_fABdsR8z4NTNP9Ux6ZLGVsfw5NpPyqB1HqV72_VjgDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] linux-user: Allocate extra space for brk
 in PIE executable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, 1749393@bugs.launchpad.net

On 16 March 2018 at 10:34, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Limit this to 16M; there does not appear to be any special
> support for this in the kernel itself, at least for i686.
>
> Fixes: https://bugs.launchpad.net/bugs/1749393
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>
> Commentary in the launchpad bug suggests 128M gap for x86_64, but that's
> somewhat irrelevant to the given i686 test case.  There's certainly nothing
> in the referenced kernel patch that does any more than we had been doing
> without this patch.

I think the 128MB is enforced by mmap_base() in arch/x86/mm/mmap.c:
since x86-64 sots HAVE_ARCH_UNMAPPED_AREA_TOPDOWN, mmap_base is the
highest address in memory where mmap is permitted, and mmap_base()
enforces that it goes at least 128MB below the bottom of the stack
(accounting for rlimit stack size requirements also). Since
binfmt_elf() loads ELF segments via mmap this means that they won't
go too close to the stack. (The commit a87938b2e246 ensures the
gap is honoured by using the full binary size when it does the first
mapping so that mmap picks an address that is sufficiently before the
end of the mmap region for everything to fit.)
The kernel also uses ELF_ET_DYN_BASE to ensure that PIE programs
themselves get loaded clear of the ELF interpreter, which we
don't have any equivalent of (so you can see that different values
of -R result in either the interpreter or the executable getting
loaded at lower addresses.)

PS: do you know what the intention of the
        if (reserved_va) {
            mmap_next_start = reserved_va;
        }
code in linux-user/main.c is? It seems a bit odd to say "ok,
we have reserved a big region. we will start trying to mmap
outside it.", especially when that region covers the full
4G that the guest can access...

thanks
-- PMM
