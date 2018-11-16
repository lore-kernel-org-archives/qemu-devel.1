Received: from eggs.gnu.org ([2001:4830:134:3::10]:38358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gNmAV-0005U4-AS
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 17:00:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gNmAQ-0008EK-D3
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 17:00:49 -0500
References: <20181115094207.22846-1-luc.michel@greensocs.com>
	<20181115094207.22846-11-luc.michel@greensocs.com>
From: Alistair Francis <alistair23@gmail.com>
Message-ID: <c9e2e058-a91d-1b60-17e8-9b49ead54b7c@gmail.com>
Date: Fri, 16 Nov 2018 14:00:02 -0800
MIME-Version: 1.0
In-Reply-To: <20181115094207.22846-11-luc.michel@greensocs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 10/16] gdbstub: add multiprocess support
 to 'D' packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, alistair@alistair23.me, mark.burton@greensocs.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, saipava@xilinx.com, edgari@xilinx.com, qemu-arm@nongnu.org

On 15/11/2018 1:42 am, Luc Michel wrote:
> 'D' packets are used by GDB to detach from a process. In multiprocess
> mode, the PID to detach from is sent in the request.
> 
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   gdbstub.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 53 insertions(+), 7 deletions(-)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index 5df9929f92..eec1cf0d09 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1039,24 +1039,39 @@ static int gdb_breakpoint_remove(target_ulong addr, target_ulong len, int type)
>       default:
>           return -ENOSYS;
>       }
>   }
>   
> +static inline void gdb_cpu_breakpoint_remove_all(CPUState *cpu)
> +{
> +    cpu_breakpoint_remove_all(cpu, BP_GDB);
> +#ifndef CONFIG_USER_ONLY
> +    cpu_watchpoint_remove_all(cpu, BP_GDB);
> +#endif
> +}
> +
> +static void gdb_process_breakpoint_remove_all(const GDBState *s, GDBProcess *p)
> +{
> +    CPUState *cpu = get_first_cpu_in_process(s, p);
> +
> +    while (cpu) {
> +        gdb_cpu_breakpoint_remove_all(cpu);
> +        cpu = gdb_next_cpu_in_process(s, cpu);
> +    }
> +}
> +
>   static void gdb_breakpoint_remove_all(void)
>   {
>       CPUState *cpu;
>   
>       if (kvm_enabled()) {
>           kvm_remove_all_breakpoints(gdbserver_state->c_cpu);
>           return;
>       }
>   
>       CPU_FOREACH(cpu) {
> -        cpu_breakpoint_remove_all(cpu, BP_GDB);
> -#ifndef CONFIG_USER_ONLY
> -        cpu_watchpoint_remove_all(cpu, BP_GDB);
> -#endif
> +        gdb_cpu_breakpoint_remove_all(cpu);
>       }
>   }
>   
>   static void gdb_set_cpu_pc(GDBState *s, target_ulong pc)
>   {
> @@ -1331,13 +1346,44 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
>           /* Kill the target */
>           error_report("QEMU: Terminated via GDBstub");
>           exit(0);
>       case 'D':
>           /* Detach packet */
> -        gdb_breakpoint_remove_all();
> -        gdb_syscall_mode = GDB_SYS_DISABLED;
> -        gdb_continue(s);
> +        pid = 1;
> +
> +        if (s->multiprocess) {
> +            unsigned long lpid;
> +            if (*p != ';') {
> +                put_packet(s, "E22");
> +                break;
> +            }
> +
> +            if (qemu_strtoul(p + 1, &p, 16, &lpid)) {
> +                put_packet(s, "E22");
> +                break;
> +            }
> +
> +            pid = lpid;
> +        }
> +
> +        process = gdb_get_process(s, pid);
> +        gdb_process_breakpoint_remove_all(s, process);
> +        process->attached = false;
> +
> +        if (pid == gdb_get_cpu_pid(s, s->c_cpu)) {
> +            s->c_cpu = gdb_first_cpu(s);
> +        }
> +
> +        if (pid == gdb_get_cpu_pid(s, s->g_cpu)) {
> +            s->g_cpu = gdb_first_cpu(s);
> +        }
> +
> +        if (s->c_cpu == NULL) {
> +            /* No more process attached */
> +            gdb_syscall_mode = GDB_SYS_DISABLED;
> +            gdb_continue(s);
> +        }
>           put_packet(s, "OK");
>           break;
>       case 's':
>           if (*p != '\0') {
>               addr = strtoull(p, (char **)&p, 16);
> 
