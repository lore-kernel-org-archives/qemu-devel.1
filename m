Received: from eggs.gnu.org ([2001:4830:134:3::10]:48604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cELyn-0000Ko-JW
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:04:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cELyj-0005S7-E4
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:04:45 -0500
Received: from mail-wj0-f181.google.com ([209.85.210.181]:33890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cELyi-0005Ph-Kw
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:04:41 -0500
Received: by mail-wj0-f181.google.com with SMTP id tg4so80406839wjb.1
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 12:04:40 -0800 (PST)
References: <1481047629-7763-1-git-send-email-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1481047629-7763-1-git-send-email-peter.maydell@linaro.org>
Date: Tue, 06 Dec 2016 20:03:37 +0000
Message-ID: <87bmwozuxy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.8] exec.c: Fix breakpoint
 invalidation race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Julian Brown <julian@codesourcery.com>


Peter Maydell <peter.maydell@linaro.org> writes:

> A bug (1647683) was reported showing a crash when removing
> breakpoints.  The reproducer was bisected to 3359baad when tb_flush
> was finally made thread safe.  While in MTTCG the locking in
> breakpoint_invalidate would have prevented any problems, but
> currently tb_lock() is a NOP for system emulation.
>
> The race is between a tb_flush from the gdbstub and the
> tb_invalidate_phys_addr() in breakpoint_invalidate().
>
> Ideally we'd have actual locking here; for the moment the
> simple fix is to do a full tb_flush() for a bp invalidate,
> since that is thread-safe even if no lock is taken.
>
> Reported-by: Julian Brown <julian@codesourcery.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This is quite similar to Alex's patch
> http://patchwork.ozlabs.org/patch/703188/
> ("exec.c: simplify the breakpoint invalidation logic").
> The difference is that this patch doesn't drop the
> breakpoint_invalidate() function entirely. I think this
> is better both for a future "correct fix" and as a
> minimal "just fix this for 2.8 release" change.
> ---
>  exec.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)
>
> diff --git a/exec.c b/exec.c
> index 3d867f1..08c558e 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -684,28 +684,15 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
>  #endif
>  }
>
> -#if defined(CONFIG_USER_ONLY)
> -static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
> -{
> -    mmap_lock();
> -    tb_lock();
> -    tb_invalidate_phys_page_range(pc, pc + 1, 0);
> -    tb_unlock();
> -    mmap_unlock();
> -}
> -#else
>  static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
>  {
> -    MemTxAttrs attrs;
> -    hwaddr phys = cpu_get_phys_page_attrs_debug(cpu, pc, &attrs);
> -    int asidx = cpu_asidx_from_attrs(cpu, attrs);
> -    if (phys != -1) {
> -        /* Locks grabbed by tb_invalidate_phys_addr */
> -        tb_invalidate_phys_addr(cpu->cpu_ases[asidx].as,
> -                                phys | (pc & ~TARGET_PAGE_MASK));
> -    }
> +    /* Flush the whole TB as this will not have race conditions
> +     * even if we don't have proper locking yet.
> +     * Ideally we would just invalidate the TBs for the
> +     * specified PC.
> +     */
> +    tb_flush(cpu);
>  }
> -#endif
>
>  #if defined(CONFIG_USER_ONLY)
>  void cpu_watchpoint_remove_all(CPUState *cpu, int mask)

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Alex Bennée <alex.bennee@linaro.org>

--
Alex Bennée
