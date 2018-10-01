Received: from eggs.gnu.org ([2001:4830:134:3::10]:53268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g71Yb-0006yV-2V
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:00:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g71YN-0006CR-5H
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:00:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g71YM-0006Bx-GR
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:00:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id 63-v6so7522955wra.11
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 10:00:13 -0700 (PDT)
References: <20181001115704.701-1-luc.michel@greensocs.com>
	<20181001115704.701-5-luc.michel@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8da43fa4-0e8e-4e40-232c-6fd45b07a790@redhat.com>
Date: Mon, 1 Oct 2018 19:00:10 +0200
MIME-Version: 1.0
In-Reply-To: <20181001115704.701-5-luc.michel@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 04/15] gdbstub: add multiprocess support
 to vCont packets
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
> Add the gdb_first_cpu() and gdb_next_cpu() to iterate over all
> the CPUs in currently attached processes.
> 
> Add the gdb_first_cpu_in_process() and gdb_next_cpu_in_process() to
> iterate over CPUs of a given process.
> 
> Use them to add multiprocess extension support to vCont packets.
> 
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---
>  gdbstub.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 102 insertions(+), 15 deletions(-)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index a21ce3ca18..779cc8b241 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -704,10 +704,40 @@ static CPUState *find_cpu(uint32_t thread_id)
>      }
>  
>      return NULL;
>  }
>  
> +static CPUState *get_first_cpu_in_process(const GDBState *s,
> +                                          GDBProcess *process)
> +{
> +    CPUState *cpu;
> +
> +    CPU_FOREACH(cpu) {
> +        if (gdb_get_cpu_pid(s, cpu) == process->pid) {
> +            return cpu;
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
> +static CPUState *gdb_next_cpu_in_process(const GDBState *s, CPUState *cpu)
> +{
> +    uint32_t pid = gdb_get_cpu_pid(s, cpu);
> +    cpu = CPU_NEXT(cpu);
> +
> +    while (cpu) {
> +        if (gdb_get_cpu_pid(s, cpu) == pid) {
> +            break;
> +        }
> +
> +        cpu = CPU_NEXT(cpu);
> +    }
> +
> +    return cpu;
> +}
> +
>  static CPUState *gdb_get_cpu(const GDBState *s, uint32_t pid, uint32_t tid)
>  {
>      GDBProcess *process;
>      CPUState *cpu = find_cpu(tid);
>  
> @@ -731,10 +761,41 @@ static CPUState *gdb_get_cpu(const GDBState *s, uint32_t pid, uint32_t tid)
>      }
>  
>      return cpu;
>  }
>  
> +/* Return the cpu following @cpu, while ignoring
> + * unattached processes.
> + */
> +static CPUState *gdb_next_cpu(const GDBState *s, CPUState *cpu)
> +{
> +    cpu = CPU_NEXT(cpu);
> +
> +    while (cpu) {
> +        if (gdb_get_cpu_process(s, cpu)->attached) {
> +            break;
> +        }
> +
> +        cpu = CPU_NEXT(cpu);
> +    }
> +
> +    return cpu;
> +}
> +
> +/* Return the first attached cpu */
> +static CPUState *gdb_first_cpu(const GDBState *s)
> +{
> +    CPUState *cpu = first_cpu;
> +    GDBProcess *process = gdb_get_cpu_process(s, cpu);
> +
> +    if (!process->attached) {
> +        return gdb_next_cpu(s, cpu);
> +    }
> +
> +    return cpu;
> +}
> +
>  static const char *get_feature_xml(const char *p, const char **newp,
>                                     CPUClass *cc)
>  {
>      size_t len;
>      int i;
> @@ -1069,14 +1130,16 @@ static int is_query_packet(const char *p, const char *query, char separator)
>   * returns -ENOTSUP if a command is unsupported, -EINVAL or -ERANGE if there is
>   *         a format error, 0 on success.
>   */
>  static int gdb_handle_vcont(GDBState *s, const char *p)
>  {
> -    int res, idx, signal = 0;
> +    int res, signal = 0;
>      char cur_action;
>      char *newstates;
>      unsigned long tmp;
> +    uint32_t pid, tid;
> +    GDBProcess *process;
>      CPUState *cpu;
>  #ifdef CONFIG_USER_ONLY
>      int max_cpus = 1; /* global variable max_cpus exists only in system mode */
>  
>      CPU_FOREACH(cpu) {
> @@ -1115,29 +1178,52 @@ static int gdb_handle_vcont(GDBState *s, const char *p)
>          } else if (cur_action != 'c' && cur_action != 's') {
>              /* unknown/invalid/unsupported command */
>              res = -ENOTSUP;
>              goto out;
>          }
> -        /* thread specification. special values: (none), -1 = all; 0 = any */
> -        if ((p[0] == ':' && p[1] == '-' && p[2] == '1') || (p[0] != ':')) {
> -            if (*p == ':') {
> -                p += 3;
> -            }
> -            for (idx = 0; idx < max_cpus; idx++) {
> -                if (newstates[idx] == 1) {
> -                    newstates[idx] = cur_action;
> +
> +        if (*p++ != ':') {
> +            res = -ENOTSUP;
> +            goto out;
> +        }
> +
> +        switch (read_thread_id(p, &p, &pid, &tid)) {
> +        case GDB_READ_THREAD_ERR:
> +            res = -EINVAL;
> +            goto out;
> +
> +        case GDB_ALL_PROCESSES:
> +            cpu = gdb_first_cpu(s);
> +            while (cpu) {
> +                if (newstates[cpu->cpu_index] == 1) {
> +                    newstates[cpu->cpu_index] = cur_action;
>                  }
> +
> +                cpu = gdb_next_cpu(s, cpu);
>              }
> -        } else if (*p == ':') {
> -            p++;
> -            res = qemu_strtoul(p, &p, 16, &tmp);
> -            if (res) {
> +            break;
> +
> +        case GDB_ALL_THREADS:
> +            process = gdb_get_process(s, pid);
> +
> +            if (!process->attached) {
> +                res = -EINVAL;
>                  goto out;
>              }
>  
> -            /* 0 means any thread, so we pick the first valid CPU */
> -            cpu = tmp ? find_cpu(tmp) : first_cpu;
> +            cpu = get_first_cpu_in_process(s, process);
> +            while (cpu) {
> +                if (newstates[cpu->cpu_index] == 1) {
> +                    newstates[cpu->cpu_index] = cur_action;
> +                }
> +
> +                cpu = gdb_next_cpu_in_process(s, cpu);
> +            }
> +            break;
> +
> +        case GDB_ONE_THREAD:
> +            cpu = gdb_get_cpu(s, pid, tid);
>  
>              /* invalid CPU/thread specified */
>              if (!cpu) {
>                  res = -EINVAL;
>                  goto out;
> @@ -1145,10 +1231,11 @@ static int gdb_handle_vcont(GDBState *s, const char *p)
>  
>              /* only use if no previous match occourred */
>              if (newstates[cpu->cpu_index] == 1) {
>                  newstates[cpu->cpu_index] = cur_action;
>              }
> +            break;
>          }
>      }
>      s->signal = signal;
>      gdb_continue_partial(s, newstates);
>  
> 

Nice.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
