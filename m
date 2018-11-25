Received: from eggs.gnu.org ([2001:4830:134:3::10]:43765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1Tm-0006tY-Rx
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 15:58:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1Ti-0002HF-KU
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 15:58:10 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gR1Ti-0002GW-C3
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 15:58:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so16864516wrs.8
	for <qemu-devel@nongnu.org>; Sun, 25 Nov 2018 12:58:06 -0800 (PST)
References: <20181123091729.29921-1-luc.michel@greensocs.com>
	<20181123091729.29921-3-luc.michel@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c9b126f0-2f2b-3fee-49f0-b04f11dac041@redhat.com>
Date: Sun, 25 Nov 2018 21:58:00 +0100
MIME-Version: 1.0
In-Reply-To: <20181123091729.29921-3-luc.michel@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 02/16] gdbstub: introduce GDB processes
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

On 23/11/18 10:17, Luc Michel wrote:
> Add a structure GDBProcess that represent processes from the GDB
> semantic point of view.
> 
> CPUs can be split into different processes, by grouping them under
> different cpu-cluster objects.  Each occurrence of a cpu-cluster object
> implies the existence of the corresponding process in the GDB stub. The
> GDB process ID is derived from the corresponding cluster ID as follows:
> 
>   GDB PID = cluster ID + 1
> 
> This is because PIDs -1 and 0 are reserved in GDB and cannot be used by
> processes.
> 
> When no such container are found, all the CPUs are put in a unique GDB
> process (create_unique_process()). This is also the case when compiled
> in user mode, where multi-processes do not make much sense for now.
> 
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  gdbstub.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index c4e4f9f082..26f5a7449a 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -27,10 +27,11 @@
>  #include "monitor/monitor.h"
>  #include "chardev/char.h"
>  #include "chardev/char-fe.h"
>  #include "sysemu/sysemu.h"
>  #include "exec/gdbstub.h"
> +#include "hw/cpu/cluster.h"
>  #endif
>  
>  #define MAX_PACKET_LENGTH 4096
>  
>  #include "qemu/sockets.h"
> @@ -294,10 +295,15 @@ typedef struct GDBRegisterState {
>      gdb_reg_cb set_reg;
>      const char *xml;
>      struct GDBRegisterState *next;
>  } GDBRegisterState;
>  
> +typedef struct GDBProcess {
> +    uint32_t pid;
> +    bool attached;
> +} GDBProcess;
> +
>  enum RSState {
>      RS_INACTIVE,
>      RS_IDLE,
>      RS_GETLINE,
>      RS_GETLINE_ESC,
> @@ -322,10 +328,13 @@ typedef struct GDBState {
>      int running_state;
>  #else
>      CharBackend chr;
>      Chardev *mon_chr;
>  #endif
> +    bool multiprocess;
> +    GDBProcess *processes;
> +    int process_num;
>      char syscall_buf[256];
>      gdb_syscall_complete_cb current_syscall_cb;
>  } GDBState;
>  
>  /* By default use no IRQs and no timers while single stepping so as to
> @@ -1749,10 +1758,24 @@ void gdb_exit(CPUArchState *env, int code)
>  #ifndef CONFIG_USER_ONLY
>    qemu_chr_fe_deinit(&s->chr, true);
>  #endif
>  }
>  
> +/*
> + * Create a unique process containing all the CPUs.
> + */
> +static void create_unique_process(GDBState *s)
> +{
> +    GDBProcess *process;
> +
> +    s->processes = g_malloc0(sizeof(GDBProcess));

good place to use:

       s->processes = g_new0(GDBProcess, 1);

Regardless:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +    s->process_num = 1;
> +    process = &s->processes[0];
> +
> +    process->pid = 1;
> +}
> +
>  #ifdef CONFIG_USER_ONLY
>  int
>  gdb_handlesig(CPUState *cpu, int sig)
>  {
>      GDBState *s;
> @@ -1846,10 +1869,11 @@ static bool gdb_accept(void)
>      }
>  
>      s = g_malloc0(sizeof(GDBState));
>      s->c_cpu = first_cpu;
>      s->g_cpu = first_cpu;
> +    create_unique_process(s);
>      s->fd = fd;
>      gdb_has_xml = false;
>  
>      gdbserver_state = s;
>      return true;
> @@ -2002,10 +2026,69 @@ static const TypeInfo char_gdb_type_info = {
>      .name = TYPE_CHARDEV_GDB,
>      .parent = TYPE_CHARDEV,
>      .class_init = char_gdb_class_init,
>  };
>  
> +static int find_cpu_clusters(Object *child, void *opaque)
> +{
> +    if (object_dynamic_cast(child, TYPE_CPU_CLUSTER)) {
> +        GDBState *s = (GDBState *) opaque;
> +        CPUClusterState *cluster = CPU_CLUSTER(child);
> +        GDBProcess *process;
> +
> +        s->processes = g_renew(GDBProcess, s->processes, ++s->process_num);
> +
> +        process = &s->processes[s->process_num - 1];
> +
> +        /*
> +         * GDB process IDs -1 and 0 are reserved. To avoid subtle errors at
> +         * runtime, we enforce here that the machine does not use a cluster ID
> +         * that would lead to PID 0. */
> +        assert(process->pid != UINT32_MAX);
> +        process->pid = cluster->cluster_id + 1;
> +        process->attached = false;
> +
> +        return 0;
> +    }
> +
> +    return object_child_foreach(child, find_cpu_clusters, opaque);
> +}
> +
> +static int pid_order(const void *a, const void *b)
> +{
> +    GDBProcess *pa = (GDBProcess *) a;
> +    GDBProcess *pb = (GDBProcess *) b;
> +
> +    if (pa->pid < pb->pid) {
> +        return -1;
> +    } else if (pa->pid > pb->pid) {
> +        return 1;
> +    } else {
> +        return 0;
> +    }
> +}
> +
> +static void create_processes(GDBState *s)
> +{
> +    object_child_foreach(object_get_root(), find_cpu_clusters, s);
> +
> +    if (!s->processes) {
> +        /* No CPU cluster specified by the machine */
> +        create_unique_process(s);
> +    } else {
> +        /* Sort by PID */
> +        qsort(s->processes, s->process_num, sizeof(s->processes[0]), pid_order);
> +    }
> +}
> +
> +static void cleanup_processes(GDBState *s)
> +{
> +    g_free(s->processes);
> +    s->process_num = 0;
> +    s->processes = NULL;
> +}
> +
>  int gdbserver_start(const char *device)
>  {
>      trace_gdbstub_op_start(device);
>  
>      GDBState *s;
> @@ -2058,15 +2141,19 @@ int gdbserver_start(const char *device)
>                                     NULL, &error_abort);
>          monitor_init(mon_chr, 0);
>      } else {
>          qemu_chr_fe_deinit(&s->chr, true);
>          mon_chr = s->mon_chr;
> +        cleanup_processes(s);
>          memset(s, 0, sizeof(GDBState));
>          s->mon_chr = mon_chr;
>      }
>      s->c_cpu = first_cpu;
>      s->g_cpu = first_cpu;
> +
> +    create_processes(s);
> +
>      if (chr) {
>          qemu_chr_fe_init(&s->chr, chr, &error_abort);
>          qemu_chr_fe_set_handlers(&s->chr, gdb_chr_can_receive, gdb_chr_receive,
>                                   gdb_chr_event, NULL, NULL, NULL, true);
>      }
> 
