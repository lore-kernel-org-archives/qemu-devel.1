Received: from eggs.gnu.org ([2001:4830:134:3::10]:37334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gX8QJ-0002f9-EA
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:35:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gX8QI-0005kL-39
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:35:51 -0500
References: <20181207090135.7651-1-luc.michel@greensocs.com>
	<20181207090135.7651-8-luc.michel@greensocs.com>
From: Alistair Francis <alistair23@gmail.com>
Message-ID: <00da96e1-5cfc-05bb-4765-33a71d8aff88@gmail.com>
Date: Wed, 12 Dec 2018 09:35:41 -0800
MIME-Version: 1.0
In-Reply-To: <20181207090135.7651-8-luc.michel@greensocs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 07/16] gdbstub: add multiprocess support
 to (f|s)ThreadInfo and ThreadExtraInfo
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

On 07/12/2018 1:01 am, Luc Michel wrote:
> Change the thread info related packets handling to support multiprocess
> extension.
> 
> Add the CPUs class name in the extra info to help differentiate
> them in multiprocess mode.
> 
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   gdbstub.c | 37 +++++++++++++++++++++++++++----------
>   1 file changed, 27 insertions(+), 10 deletions(-)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index bea0215f30..770915446a 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1267,11 +1267,10 @@ out:
>   static int gdb_handle_packet(GDBState *s, const char *line_buf)
>   {
>       CPUState *cpu;
>       CPUClass *cc;
>       const char *p;
> -    uint32_t thread;
>       uint32_t pid, tid;
>       int ch, reg_size, type, res;
>       uint8_t mem_buf[MAX_PACKET_LENGTH];
>       char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
>       char thread_id[16];
> @@ -1563,30 +1562,48 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
>               snprintf(buf, sizeof(buf), "QC%s",
>                        gdb_fmt_thread_id(s, cpu, thread_id, sizeof(thread_id)));
>               put_packet(s, buf);
>               break;
>           } else if (strcmp(p,"fThreadInfo") == 0) {
> -            s->query_cpu = first_cpu;
> +            s->query_cpu = gdb_first_attached_cpu(s);
>               goto report_cpuinfo;
>           } else if (strcmp(p,"sThreadInfo") == 0) {
>           report_cpuinfo:
>               if (s->query_cpu) {
> -                snprintf(buf, sizeof(buf), "m%x", cpu_gdb_index(s->query_cpu));
> +                snprintf(buf, sizeof(buf), "m%s",
> +                         gdb_fmt_thread_id(s, s->query_cpu,
> +                                       thread_id, sizeof(thread_id)));
>                   put_packet(s, buf);
> -                s->query_cpu = CPU_NEXT(s->query_cpu);
> +                s->query_cpu = gdb_next_attached_cpu(s, s->query_cpu);
>               } else
>                   put_packet(s, "l");
>               break;
>           } else if (strncmp(p,"ThreadExtraInfo,", 16) == 0) {
> -            thread = strtoull(p+16, (char **)&p, 16);
> -            cpu = find_cpu(thread);
> +            if (read_thread_id(p + 16, &p, &pid, &tid) == GDB_READ_THREAD_ERR) {
> +                put_packet(s, "E22");
> +                break;
> +            }
> +            cpu = gdb_get_cpu(s, pid, tid);
>               if (cpu != NULL) {
>                   cpu_synchronize_state(cpu);
> -                /* memtohex() doubles the required space */
> -                len = snprintf((char *)mem_buf, sizeof(buf) / 2,
> -                               "CPU#%d [%s]", cpu->cpu_index,
> -                               cpu->halted ? "halted " : "running");
> +
> +                if (s->multiprocess && (s->process_num > 1)) {
> +                    /* Print the CPU model and name in multiprocess mode */
> +                    ObjectClass *oc = object_get_class(OBJECT(cpu));
> +                    const char *cpu_model = object_class_get_name(oc);
> +                    char *cpu_name =
> +                        object_get_canonical_path_component(OBJECT(cpu));
> +                    len = snprintf((char *)mem_buf, sizeof(buf) / 2,
> +                                   "%s %s [%s]", cpu_model, cpu_name,
> +                                   cpu->halted ? "halted " : "running");
> +                    g_free(cpu_name);
> +                } else {
> +                    /* memtohex() doubles the required space */
> +                    len = snprintf((char *)mem_buf, sizeof(buf) / 2,
> +                                   "CPU#%d [%s]", cpu->cpu_index,
> +                                   cpu->halted ? "halted " : "running");
> +                }
>                   trace_gdbstub_op_extra_info((char *)mem_buf);
>                   memtohex(buf, mem_buf, len);
>                   put_packet(s, buf);
>               }
>               break;
> 
