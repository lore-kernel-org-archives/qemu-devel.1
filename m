Received: from eggs.gnu.org ([2001:4830:134:3::10]:55843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ewneF-0002FY-KC
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ewneD-0003MY-Rx
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:35:47 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:54518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ewneD-0003MG-KU
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:35:45 -0400
Received: by mail-wm0-x241.google.com with SMTP id h76so2445464wme.4
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 04:35:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180227095338.1060.27385.stgit@pasha-VirtualBox>
References: <20180227095135.1060.36549.stgit@pasha-VirtualBox>
	<20180227095338.1060.27385.stgit@pasha-VirtualBox>
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 16 Mar 2018 19:35:43 +0800
Message-ID: <CAFXwXrn75c3YzborcLYeKmopxVanzBuGxgYJ2+fOxsKA9sKx1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 22/22] tcg: fix cpu_io_recompile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, kwolf@redhat.com, Peter Maydell <peter.maydell@linaro.org>, war2jordan@live.com, Juan Quintela <quintela@redhat.com>, ciro.santilli@gmail.com, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, Gerd Hoffmann <kraxel@redhat.com>, boost.lists@gmail.com, thomas.dullien@googlemail.com, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 27 February 2018 at 17:53, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru> wrote:
>
> cpu_io_recompile() function was broken by
> the commit 9b990ee5a3cc6aa38f81266fb0c6ef37a36c45b9. Instead of regenerating
> the block starting from PC of the original block, it just set the instruction
> counter for TCG. In most cases this was unnoticed, but in icount mode
> there was an exception for incorrect usage of CF_LAST_IO flag.
> This patch recovers recompilation of the original block and also
> configures translation for executing single IO instruction which
> caused a recompilation.
>
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> ---
>  accel/tcg/translate-all.c |   18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 67795cd..5ad1b91 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1728,7 +1728,8 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
>      CPUArchState *env = cpu->env_ptr;
>  #endif
>      TranslationBlock *tb;
> -    uint32_t n;
> +    uint32_t n, flags;
> +    target_ulong pc, cs_base;
>
>      tb_lock();
>      tb = tb_find_pc(retaddr);
> @@ -1766,8 +1767,14 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
>          cpu_abort(cpu, "TB too big during recompile");
>      }
>
> -    /* Adjust the execution state of the next TB.  */
> -    cpu->cflags_next_tb = curr_cflags() | CF_LAST_IO | n;
> +    pc = tb->pc;
> +    cs_base = tb->cs_base;
> +    flags = tb->flags;
> +    tb_phys_invalidate(tb, -1);
> +
> +    /* Execute one IO instruction without caching
> +       instead of creating large TB. */
> +    cpu->cflags_next_tb = curr_cflags() | CF_LAST_IO | CF_NOCACHE | 1;
>
>      if (tb->cflags & CF_NOCACHE) {
>          if (tb->orig_tb) {
> @@ -1778,6 +1785,11 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
>          tb_remove(tb);
>      }
>
> +    /* Generate new TB instead of the current one. */
> +    /* FIXME: In theory this could raise an exception.  In practice
> +       we have already translated the block once so it's probably ok.  */
> +    tb_gen_code(cpu, pc, cs_base, flags, curr_cflags() | CF_LAST_IO | n);

This isn't right.  The whole point of the patch that you reference as
having broken
things is that calls to tb_gen_code which ignore their return value
are by definition
relying on the side effect of altering the TB cache, and are therefore
by definition racy.

That is exactly the point of cpu->cflags_next_tb, that when we next
arrive in cpu_exec
we look up (or generate) the next TB with the given flags.  At which
point we will *not*
be relying on the TB cache, and we'll execute the generated TB right away.

I do not have enough context within this patch to determine what the
proper solution is.


r~
