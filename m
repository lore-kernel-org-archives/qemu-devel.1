Received: from eggs.gnu.org ([2001:4830:134:3::10]:56256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g71nG-0000JI-6G
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g71nB-0003qC-Vz
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:15:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g71nB-0003pk-OG
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:15:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id n23-v6so9549251wmc.1
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 10:15:33 -0700 (PDT)
References: <20181001115704.701-1-luc.michel@greensocs.com>
	<20181001115704.701-7-luc.michel@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <300b2d3b-c1b4-7612-7336-0b50494d5315@redhat.com>
Date: Mon, 1 Oct 2018 19:15:30 +0200
MIME-Version: 1.0
In-Reply-To: <20181001115704.701-7-luc.michel@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 06/15] gdbstub: add multiprocess support
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
Cc: Peter Maydell <peter.maydell@linaro.org>, alistair@alistair23.me, mark.burton@greensocs.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, saipava@xilinx.com, edgari@xilinx.com, qemu-arm@nongnu.org



On 01/10/2018 13:56, Luc Michel wrote:
> Change the thread info related packets handling to support multiprocess
> extension.
> 
> Add the CPUs class name in the extra info to help differentiate
> them in multiprocess mode.
> 
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---
>  gdbstub.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index 3242f0d261..63d7913269 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1248,11 +1248,10 @@ out:
>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>  {
>      CPUState *cpu;
>      CPUClass *cc;
>      const char *p;
> -    uint32_t thread;
>      uint32_t pid, tid;
>      int ch, reg_size, type, res;
>      uint8_t mem_buf[MAX_PACKET_LENGTH];
>      char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
>      char thread_id[16];
> @@ -1540,30 +1539,43 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
>              snprintf(buf, sizeof(buf), "QC%s",
>                       gdb_fmt_thread_id(s, cpu, thread_id, sizeof(thread_id)));
>              put_packet(s, buf);
>              break;
>          } else if (strcmp(p,"fThreadInfo") == 0) {
> -            s->query_cpu = first_cpu;
> +            s->query_cpu = gdb_first_cpu(s);
>              goto report_cpuinfo;
>          } else if (strcmp(p,"sThreadInfo") == 0) {
>          report_cpuinfo:
>              if (s->query_cpu) {
> -                snprintf(buf, sizeof(buf), "m%x", cpu_gdb_index(s->query_cpu));
> +                snprintf(buf, sizeof(buf), "m%s",
> +                         gdb_fmt_thread_id(s, s->query_cpu,
> +                                       thread_id, sizeof(thread_id)));
>                  put_packet(s, buf);
> -                s->query_cpu = CPU_NEXT(s->query_cpu);
> +                s->query_cpu = gdb_next_cpu(s, s->query_cpu);
>              } else
>                  put_packet(s, "l");
>              break;
>          } else if (strncmp(p,"ThreadExtraInfo,", 16) == 0) {
> -            thread = strtoull(p+16, (char **)&p, 16);
> -            cpu = find_cpu(thread);
> +            read_thread_id(p + 16, &p, &pid, &tid);

Check similar to patch #3:

        if (read_thread_id(p, &p, &pid, &tid) == GDB_READ_THREAD_ERR) {
            put_packet(s, "E22");
            break;
        }

With equivalent change:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +            cpu = gdb_get_cpu(s, pid, tid);
>              if (cpu != NULL) {
>                  cpu_synchronize_state(cpu);
> -                /* memtohex() doubles the required space */
> -                len = snprintf((char *)mem_buf, sizeof(buf) / 2,
> -                               "CPU#%d [%s]", cpu->cpu_index,
> -                               cpu->halted ? "halted " : "running");
> +
> +                if (s->multiprocess && (s->process_num > 1)) {
> +                    /* Print the CPU model in multiprocess mode */
> +                    ObjectClass *oc = object_get_class(OBJECT(cpu));
> +                    const char *cpu_model = object_class_get_name(oc);
> +                    len = snprintf((char *)mem_buf, sizeof(buf) / 2,
> +                                   "CPU#%d %s [%s]", cpu->cpu_index,
> +                                   cpu_model,
> +                                   cpu->halted ? "halted " : "running");
> +                } else {
> +                    /* memtohex() doubles the required space */
> +                    len = snprintf((char *)mem_buf, sizeof(buf) / 2,
> +                                   "CPU#%d [%s]", cpu->cpu_index,
> +                                   cpu->halted ? "halted " : "running");
> +                }
>                  trace_gdbstub_op_extra_info((char *)mem_buf);
>                  memtohex(buf, mem_buf, len);
>                  put_packet(s, buf);
>              }
>              break;
> 
