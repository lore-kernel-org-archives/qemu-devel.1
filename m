Received: from eggs.gnu.org ([2001:4830:134:3::10]:57329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cEH9l-00044H-J8
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 09:55:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cEH9h-0003VY-Ml
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 09:55:45 -0500
Received: from mail-ua0-f179.google.com ([209.85.217.179]:36693)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cEH9h-0003VF-H5
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 09:55:41 -0500
Received: by mail-ua0-f179.google.com with SMTP id b35so382975169uaa.3
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 06:55:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161206145104.16048-1-alex.bennee@linaro.org>
References: <20161206113915.26308.72810.malonedeb@wampee.canonical.com>
	<20161206145104.16048-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Dec 2016 14:54:20 +0000
Message-ID: <CAFEAcA8tnP5_annrApB2O_ZUXvc7HXM7+K1XOsPUVqrU6hHLeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] exec.c: simplify the breakpoint
 invalidation logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Bug 1647683 <1647683@bugs.launchpad.net>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "open list:Overall" <qemu-devel@nongnu.org>

On 6 December 2016 at 14:51, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> A bug (1647683) was reported showing a crash when removing
> breakpoints. The reproducer was bisected to 3359baad when tb_flush was
> finally made thread safe. While in MTTCG the locking in
> breakpoint_invalidate should have prevented any problems currently
> tb_lock() is a NOP for system emulation.
>
> On top of it all the invalidation code was special-cased between user
> and system emulation which was ugly. As we now have a safe tb_flush()
> we might as well use that when breakpoints and added and removed. This
> is the same thing we do for single-stepping and as this is during
> debugging it isn't a major performance concern.
>
> Reported-by: Julian Brown
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  exec.c | 31 ++++---------------------------
>  1 file changed, 4 insertions(+), 27 deletions(-)
>
> diff --git a/exec.c b/exec.c
> index 3d867f1..e991221 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -685,29 +685,6 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
>  }
>
>  #if defined(CONFIG_USER_ONLY)
> -static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
> -{
> -    mmap_lock();
> -    tb_lock();
> -    tb_invalidate_phys_page_range(pc, pc + 1, 0);
> -    tb_unlock();
> -    mmap_unlock();
> -}
> -#else
> -static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
> -{
> -    MemTxAttrs attrs;
> -    hwaddr phys =3D cpu_get_phys_page_attrs_debug(cpu, pc, &attrs);
> -    int asidx =3D cpu_asidx_from_attrs(cpu, attrs);
> -    if (phys !=3D -1) {
> -        /* Locks grabbed by tb_invalidate_phys_addr */
> -        tb_invalidate_phys_addr(cpu->cpu_ases[asidx].as,
> -                                phys | (pc & ~TARGET_PAGE_MASK));
> -    }
> -}
> -#endif
> -
> -#if defined(CONFIG_USER_ONLY)
>  void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
>
>  {
> @@ -839,7 +816,7 @@ int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, in=
t flags,
>          QTAILQ_INSERT_TAIL(&cpu->breakpoints, bp, entry);
>      }
>
> -    breakpoint_invalidate(cpu, pc);
> +    tb_flush(cpu);
>
>      if (breakpoint) {
>          *breakpoint =3D bp;
> @@ -855,6 +832,7 @@ int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, in=
t flags)
>      QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
>          if (bp->pc =3D=3D pc && bp->flags =3D=3D flags) {
>              cpu_breakpoint_remove_by_ref(cpu, bp);
> +            tb_flush(cpu);
>              return 0;
>          }
>      }
> @@ -865,9 +843,6 @@ int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, in=
t flags)
>  void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *breakpoi=
nt)
>  {
>      QTAILQ_REMOVE(&cpu->breakpoints, breakpoint, entry);
> -
> -    breakpoint_invalidate(cpu, breakpoint->pc);
> -
>      g_free(breakpoint);
>  }
>
> @@ -881,6 +856,8 @@ void cpu_breakpoint_remove_all(CPUState *cpu, int mas=
k)
>              cpu_breakpoint_remove_by_ref(cpu, bp);
>          }
>      }
> +
> +    tb_flush(cpu);
>  }
>
>  /* enable or disable single step mode. EXCP_DEBUG is returned by the

I think this is the wrong direction. We only need to invalidate
the TBs for the specific location the breakpoint is at.
Even if we for the moment want to apply a big hammer of doing
a full tb flush on breakpoint to fix this issue for this release,
we shouldn't drop the indirection through breakpoint_invalidate(),
because then we can't go back to invalidating just the parts we need
easily later.

thanks
-- PMM
