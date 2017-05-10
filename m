Received: from eggs.gnu.org ([2001:4830:134:3::10]:51329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8P1i-0001CC-Sd
	for qemu-devel@nongnu.org; Wed, 10 May 2017 06:39:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8P1e-000279-Jb
	for qemu-devel@nongnu.org; Wed, 10 May 2017 06:39:26 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8P1e-00026z-Eu
	for qemu-devel@nongnu.org; Wed, 10 May 2017 06:39:22 -0400
Received: by mail-qk0-x243.google.com with SMTP id o85so4014918qkh.0
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 03:39:22 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170509180715.22910-1-rth@twiddle.net>
	<20170509180715.22910-4-rth@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <acc911e4-63e4-ca7e-70c6-33dfa8090095@amsat.org>
Date: Wed, 10 May 2017 07:39:18 -0300
MIME-Version: 1.0
In-Reply-To: <20170509180715.22910-4-rth@twiddle.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 3/6] target/s390x: Diagnose
 specification exception for atomics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

On 05/09/2017 03:07 PM, Richard Henderson wrote:
> All of the interlocked access facility instructions raise a
> specification exception for unaligned accesses.  Do this by
> using the (previously unused) unaligned_access hook.
>
> Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
>
