Received: from eggs.gnu.org ([2001:4830:134:3::10]:57452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d7sVa-0000Wy-8w
	for qemu-devel@nongnu.org; Mon, 08 May 2017 19:56:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d7sVZ-0000jo-Cn
	for qemu-devel@nongnu.org; Mon, 08 May 2017 19:56:06 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:60806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d7sVZ-0000jL-0k
	for qemu-devel@nongnu.org; Mon, 08 May 2017 19:56:05 -0400
Date: Tue, 9 May 2017 01:56:03 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170508235603.d6676ezjv5p7gmgs@aurel32.net>
References: <20170508151707.5434-1-rth@twiddle.net>
	<20170508151707.5434-4-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170508151707.5434-4-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 3/6] target/s390x: Diagnose
 specification exception for atomics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On 2017-05-08 08:17, Richard Henderson wrote:
> All of the interlocked access facility instructions raise a
> specification exception for unaligned accesses.  Do this by
> using the (previously unused) unaligned_access hook.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/cpu.c    |  1 +
>  target/s390x/cpu.h    |  3 +++
>  target/s390x/helper.c | 16 ++++++++++++++++
>  3 files changed, 20 insertions(+)
> 
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 066dcd1..a1bf2ba 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -430,6 +430,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
>      cc->write_elf64_note = s390_cpu_write_elf64_note;
>      cc->cpu_exec_interrupt = s390_cpu_exec_interrupt;
>      cc->debug_excp_handler = s390x_cpu_debug_excp_handler;
> +    cc->do_unaligned_access = s390x_cpu_do_unaligned_access;
>  #endif
>      cc->disas_set_info = s390_cpu_disas_set_info;
>  
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 058ddad..bbed320 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -480,6 +480,9 @@ int s390_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw,
>  
>  #ifndef CONFIG_USER_ONLY
>  void do_restart_interrupt(CPUS390XState *env);
> +void s390x_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
> +                                   MMUAccessType access_type,
> +                                   int mmu_idx, uintptr_t retaddr);
>  
>  static inline hwaddr decode_basedisp_s(CPUS390XState *env, uint32_t ipb,
>                                         uint8_t *ar)
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index 68bd2f9..9978490 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -718,4 +718,20 @@ void s390x_cpu_debug_excp_handler(CPUState *cs)
>          cpu_loop_exit_noexc(cs);
>      }
>  }
> +
> +/* Unaligned accesses are only diagnosed with MO_ALIGN.  At the moment,
> +   this is only for the atomic operations, for which we want to raise a
> +   specification exception.  */
> +void s390x_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
> +                                   MMUAccessType access_type,
> +                                   int mmu_idx, uintptr_t retaddr)
> +{
> +    S390CPU *cpu = S390_CPU(cs);
> +    CPUS390XState *env = &cpu->env;
> +
> +    if (retaddr) {
> +        cpu_restore_state(cs, retaddr);
> +    }
> +    program_interrupt(env, PGM_SPECIFICATION, ILEN_LATER);
> +}
>  #endif /* CONFIG_USER_ONLY */

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
