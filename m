Received: from eggs.gnu.org ([2001:4830:134:3::10]:34778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGSPH-0008Jd-BI
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:53:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGSPG-0001H9-Ax
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:53:03 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:35119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGSPG-0001Fk-3V
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:53:02 -0400
Received: by mail-it0-x244.google.com with SMTP id 67so6827284itx.2
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 08:53:00 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170601144915.20778-1-alex.bennee@linaro.org>
	<20170601144915.20778-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ffaa048b-5a20-15d6-91bb-5d577226bb70@amsat.org>
Date: Thu, 1 Jun 2017 12:52:55 -0300
MIME-Version: 1.0
In-Reply-To: <20170601144915.20778-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/4] qom/cpu: remove host_tid field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, pbonzini@redhat.com, doug16k@gmail.com, imbrenda@linux.vnet.ibm.com
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>

On 06/01/2017 11:49 AM, Alex Bennée wrote:
> This was only used by the gdbstub and even then was only being set for
> subsequent threads. Rather the continue duplicating the number just
> make the gdbstub get the information from TaskState structure.
>
> Now the tid is correctly reported for all threads the bug I was seeing
> with "vCont;C04:0;c" packets is fixed as the correct tid is reported
> to gdb.
>
> I moved cpu_gdb_index into the gdbstub to facilitate easy access to
> the TaskState which is used elsewhere in gdbstub.
>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  gdbstub.c              | 15 +++++++++++++++
>  include/exec/gdbstub.h | 14 --------------
>  include/qom/cpu.h      |  2 --
>  linux-user/syscall.c   |  1 -
>  4 files changed, 15 insertions(+), 17 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 026d1fe6bb..45a3a0b16b 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -55,6 +55,21 @@ static inline int target_memory_rw_debug(CPUState *cpu, target_ulong addr,
>      return cpu_memory_rw_debug(cpu, addr, buf, len, is_write);
>  }
>
> +/* Return the GDB index for a given vCPU state.
> + *
> + * For user mode this is simply the thread id. In system mode GDB
> + * numbers CPUs from 1 as 0 is reserved as an "any cpu" index.
> + */
> +static inline int cpu_gdb_index(CPUState *cpu)
> +{
> +#if defined(CONFIG_USER_ONLY)
> +    TaskState *ts = (TaskState *) cpu->opaque;
> +    return ts->ts_tid;
> +#else
> +    return cpu->cpu_index + 1;
> +#endif
> +}
> +
>  enum {
>      GDB_SIGNAL_0 = 0,
>      GDB_SIGNAL_INT = 2,
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index c4fe567600..9aa7756d92 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -58,20 +58,6 @@ void gdb_register_coprocessor(CPUState *cpu,
>                                gdb_reg_cb get_reg, gdb_reg_cb set_reg,
>                                int num_regs, const char *xml, int g_pos);
>
> -/* Return the GDB index for a given vCPU state.
> - *
> - * For user mode this is simply the thread id. In system mode GDB
> - * numbers CPUs from 1 as 0 is reserved as an "any cpu" index.
> - */
> -static inline int cpu_gdb_index(CPUState *cpu)
> -{
> -#if defined(CONFIG_USER_ONLY)
> -    return cpu->host_tid;
> -#else
> -    return cpu->cpu_index + 1;
> -#endif
> -}
> -
>  /* The GDB remote protocol transfers values in target byte order.  This means
>   * we can use the raw memory access routines to access the value buffer.
>   * Conveniently, these also handle the case where the buffer is mis-aligned.
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 55214ce131..909e7ae994 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -266,7 +266,6 @@ struct qemu_work_item;
>   * @nr_cores: Number of cores within this CPU package.
>   * @nr_threads: Number of threads within this CPU.
>   * @numa_node: NUMA node this CPU is belonging to.
> - * @host_tid: Host thread ID.
>   * @running: #true if CPU is currently running (lockless).
>   * @has_waiter: #true if a CPU is currently waiting for the cpu_exec_end;
>   * valid under cpu_list_lock.
> @@ -321,7 +320,6 @@ struct CPUState {
>      HANDLE hThread;
>  #endif
>      int thread_id;
> -    uint32_t host_tid;
>      bool running, has_waiter;
>      struct QemuCond *halt_cond;
>      bool thread_kicked;
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index cec8428589..cada188e58 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6216,7 +6216,6 @@ static void *clone_func(void *arg)
>      thread_cpu = cpu;
>      ts = (TaskState *)cpu->opaque;
>      info->tid = gettid();
> -    cpu->host_tid = info->tid;
>      task_settid(ts);
>      if (info->child_tidptr)
>          put_user_u32(info->tid, info->child_tidptr);
>
