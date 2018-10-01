Received: from eggs.gnu.org ([2001:4830:134:3::10]:44707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g715n-0008Ea-1P
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 12:30:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g715j-0006RW-RR
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 12:30:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40287)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g715j-0006RD-GF
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 12:30:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id y8-v6so14696599wrh.7
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 09:30:39 -0700 (PDT)
References: <20181001115704.701-1-luc.michel@greensocs.com>
	<20181001115704.701-9-luc.michel@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <76691be8-e054-ba95-ade5-895919aefae6@redhat.com>
Date: Mon, 1 Oct 2018 18:30:36 +0200
MIME-Version: 1.0
In-Reply-To: <20181001115704.701-9-luc.michel@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 08/15] gdbstub: add multiprocess support
 to gdb_vm_state_change()
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
> Add support for multiprocess extension in gdb_vm_state_change()
> function.
> 
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  gdbstub.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index 9065e8e140..c1a02c34cd 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1692,10 +1692,11 @@ void gdb_set_stop_cpu(CPUState *cpu)
>  static void gdb_vm_state_change(void *opaque, int running, RunState state)
>  {
>      GDBState *s = gdbserver_state;
>      CPUState *cpu = s->c_cpu;
>      char buf[256];
> +    char thread_id[16];
>      const char *type;
>      int ret;
>  
>      if (running || s->state == RS_INACTIVE) {
>          return;
> @@ -1703,10 +1704,18 @@ static void gdb_vm_state_change(void *opaque, int running, RunState state)
>      /* Is there a GDB syscall waiting to be sent?  */
>      if (s->current_syscall_cb) {
>          put_packet(s, s->syscall_buf);
>          return;
>      }
> +
> +    if (cpu == NULL) {
> +        /* No process attached */
> +        return;
> +    }
> +
> +    gdb_fmt_thread_id(s, cpu, thread_id, sizeof(thread_id));
> +
>      switch (state) {
>      case RUN_STATE_DEBUG:
>          if (cpu->watchpoint_hit) {
>              switch (cpu->watchpoint_hit->flags & BP_MEM_ACCESS) {
>              case BP_MEM_READ:
> @@ -1720,12 +1729,12 @@ static void gdb_vm_state_change(void *opaque, int running, RunState state)
>                  break;
>              }
>              trace_gdbstub_hit_watchpoint(type, cpu_gdb_index(cpu),
>                      (target_ulong)cpu->watchpoint_hit->vaddr);
>              snprintf(buf, sizeof(buf),
> -                     "T%02xthread:%02x;%swatch:" TARGET_FMT_lx ";",
> -                     GDB_SIGNAL_TRAP, cpu_gdb_index(cpu), type,
> +                     "T%02xthread:%s;%swatch:" TARGET_FMT_lx ";",
> +                     GDB_SIGNAL_TRAP, thread_id, type,
>                       (target_ulong)cpu->watchpoint_hit->vaddr);
>              cpu->watchpoint_hit = NULL;
>              goto send_packet;
>          } else {
>              trace_gdbstub_hit_break();
> @@ -1763,11 +1772,11 @@ static void gdb_vm_state_change(void *opaque, int running, RunState state)
>          trace_gdbstub_hit_unknown(state);
>          ret = GDB_SIGNAL_UNKNOWN;
>          break;
>      }
>      gdb_set_stop_cpu(cpu);
> -    snprintf(buf, sizeof(buf), "T%02xthread:%02x;", ret, cpu_gdb_index(cpu));
> +    snprintf(buf, sizeof(buf), "T%02xthread:%s;", ret, thread_id);
>  
>  send_packet:
>      put_packet(s, buf);
>  
>      /* disable single step if it was enabled */
> 
