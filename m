Received: from eggs.gnu.org ([2001:4830:134:3::10]:35849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGeis-0005kg-12
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 01:02:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGeiq-0007nx-Vj
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 01:02:06 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:35649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGeiq-0007nl-RN
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 01:02:04 -0400
Received: by mail-oi0-x241.google.com with SMTP id f206so263151oig.2
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 22:02:04 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170601144915.20778-1-alex.bennee@linaro.org>
	<20170601144915.20778-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1c79c655-bc7f-c8b6-da4f-bcdf43fdb19b@amsat.org>
Date: Fri, 2 Jun 2017 02:02:02 -0300
MIME-Version: 1.0
In-Reply-To: <20170601144915.20778-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/4] gdbstub: rename cpu_index ->
 cpu_gdb_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, pbonzini@redhat.com, doug16k@gmail.com, imbrenda@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org

On 06/01/2017 11:49 AM, Alex Bennée wrote:
> This is to make it clear the index is purely a gdbstub function and
> should not be confused with the value of cpu->cpu_index.
>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  gdbstub.c              | 12 ++++++------
>  include/exec/gdbstub.h |  7 ++++++-
>  2 files changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index a249846954..026d1fe6bb 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -837,7 +837,7 @@ static CPUState *find_cpu(uint32_t thread_id)
>      CPUState *cpu;
>
>      CPU_FOREACH(cpu) {
> -        if (cpu_index(cpu) == thread_id) {
> +        if (cpu_gdb_index(cpu) == thread_id) {
>              return cpu;
>          }
>      }
> @@ -925,7 +925,7 @@ static int gdb_handle_vcont(GDBState *s, const char *p)
>              idx = tmp;
>              /* 0 means any thread, so we pick the first valid CPU */
>              if (!idx) {
> -                idx = cpu_index(first_cpu);
> +                idx = cpu_gdb_index(first_cpu);
>              }
>
>              /*
> @@ -975,7 +975,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
>      case '?':
>          /* TODO: Make this return the correct value for user-mode.  */
>          snprintf(buf, sizeof(buf), "T%02xthread:%02x;", GDB_SIGNAL_TRAP,
> -                 cpu_index(s->c_cpu));
> +                 cpu_gdb_index(s->c_cpu));
>          put_packet(s, buf);
>          /* Remove all the breakpoints when this query is issued,
>           * because gdb is doing and initial connect and the state
> @@ -1243,7 +1243,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
>          } else if (strcmp(p,"sThreadInfo") == 0) {
>          report_cpuinfo:
>              if (s->query_cpu) {
> -                snprintf(buf, sizeof(buf), "m%x", cpu_index(s->query_cpu));
> +                snprintf(buf, sizeof(buf), "m%x", cpu_gdb_index(s->query_cpu));
>                  put_packet(s, buf);
>                  s->query_cpu = CPU_NEXT(s->query_cpu);
>              } else
> @@ -1400,7 +1400,7 @@ static void gdb_vm_state_change(void *opaque, int running, RunState state)
>              }
>              snprintf(buf, sizeof(buf),
>                       "T%02xthread:%02x;%swatch:" TARGET_FMT_lx ";",
> -                     GDB_SIGNAL_TRAP, cpu_index(cpu), type,
> +                     GDB_SIGNAL_TRAP, cpu_gdb_index(cpu), type,
>                       (target_ulong)cpu->watchpoint_hit->vaddr);
>              cpu->watchpoint_hit = NULL;
>              goto send_packet;
> @@ -1434,7 +1434,7 @@ static void gdb_vm_state_change(void *opaque, int running, RunState state)
>          break;
>      }
>      gdb_set_stop_cpu(cpu);
> -    snprintf(buf, sizeof(buf), "T%02xthread:%02x;", ret, cpu_index(cpu));
> +    snprintf(buf, sizeof(buf), "T%02xthread:%02x;", ret, cpu_gdb_index(cpu));
>
>  send_packet:
>      put_packet(s, buf);
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index f9708bbcd6..c4fe567600 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -58,7 +58,12 @@ void gdb_register_coprocessor(CPUState *cpu,
>                                gdb_reg_cb get_reg, gdb_reg_cb set_reg,
>                                int num_regs, const char *xml, int g_pos);
>
> -static inline int cpu_index(CPUState *cpu)
> +/* Return the GDB index for a given vCPU state.
> + *
> + * For user mode this is simply the thread id. In system mode GDB
> + * numbers CPUs from 1 as 0 is reserved as an "any cpu" index.
> + */
> +static inline int cpu_gdb_index(CPUState *cpu)
>  {
>  #if defined(CONFIG_USER_ONLY)
>      return cpu->host_tid;
>
