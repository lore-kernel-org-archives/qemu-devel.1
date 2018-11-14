Received: from eggs.gnu.org ([2001:4830:134:3::10]:56140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1gMsSl-00032Z-5J
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:32:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1gMsSj-00060X-Ko
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:31:59 -0500
Date: Wed, 14 Nov 2018 11:31:29 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20181114103129.GD7447@toto>
References: <20181110081147.4027-1-luc.michel@greensocs.com>
	<20181110081147.4027-3-luc.michel@greensocs.com>
	<20181113105216.GG1148@toto>
	<2785510b-5db5-7ded-2404-7d5653a98764@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2785510b-5db5-7ded-2404-7d5653a98764@greensocs.com>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v5 02/16] gdbstub: introduce GDB
 processes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, alistair@alistair23.me, mark.burton@greensocs.com, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, saipava@xilinx.com, edgari@xilinx.com, qemu-arm@nongnu.org

On Wed, Nov 14, 2018 at 11:14:31AM +0100, Luc Michel wrote:
> Hi Edgar,
> 
> On 11/13/18 11:52 AM, Edgar E. Iglesias wrote:
> > On Sat, Nov 10, 2018 at 09:11:33AM +0100, Luc Michel wrote:
> >> Add a structure GDBProcess that represent processes from the GDB
> >> semantic point of view.
> >>
> >> CPUs can be split into different processes, by grouping them under
> >> different cpu-cluster objects.  Each occurrence of a cpu-cluster object
> >> implies the existence of the corresponding process in the GDB stub. The
> >> GDB process ID is derived from the corresponding cluster ID as follows:
> >>
> >>   GDB PID = cluster ID + 1
> >>
> >> This is because PIDs -1 and 0 are reserved in GDB and cannot be used by
> >> processes.
> >>
> >> When no such container are found, all the CPUs are put in a unique GDB
> >> process (create_unique_process()). This is also the case when compiled
> >> in user mode, where multi-processes do not make much sense for now.
> >>
> >> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> >> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> >> ---
> >>  gdbstub.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 76 insertions(+)
> >>
> >> diff --git a/gdbstub.c b/gdbstub.c
> >> index c4e4f9f082..0d70b89598 100644
> >> --- a/gdbstub.c
> >> +++ b/gdbstub.c
> >> @@ -27,10 +27,11 @@
> >>  #include "monitor/monitor.h"
> >>  #include "chardev/char.h"
> >>  #include "chardev/char-fe.h"
> >>  #include "sysemu/sysemu.h"
> >>  #include "exec/gdbstub.h"
> >> +#include "hw/cpu/cluster.h"
> >>  #endif
> >>  
> >>  #define MAX_PACKET_LENGTH 4096
> >>  
> >>  #include "qemu/sockets.h"
> >> @@ -294,10 +295,15 @@ typedef struct GDBRegisterState {
> >>      gdb_reg_cb set_reg;
> >>      const char *xml;
> >>      struct GDBRegisterState *next;
> >>  } GDBRegisterState;
> >>  
> >> +typedef struct GDBProcess {
> >> +    uint32_t pid;
> >> +    bool attached;
> >> +} GDBProcess;
> >> +
> >>  enum RSState {
> >>      RS_INACTIVE,
> >>      RS_IDLE,
> >>      RS_GETLINE,
> >>      RS_GETLINE_ESC,
> >> @@ -322,10 +328,13 @@ typedef struct GDBState {
> >>      int running_state;
> >>  #else
> >>      CharBackend chr;
> >>      Chardev *mon_chr;
> >>  #endif
> >> +    bool multiprocess;
> >> +    GDBProcess *processes;
> >> +    int process_num;
> >>      char syscall_buf[256];
> >>      gdb_syscall_complete_cb current_syscall_cb;
> >>  } GDBState;
> >>  
> >>  /* By default use no IRQs and no timers while single stepping so as to
> >> @@ -1749,10 +1758,24 @@ void gdb_exit(CPUArchState *env, int code)
> >>  #ifndef CONFIG_USER_ONLY
> >>    qemu_chr_fe_deinit(&s->chr, true);
> >>  #endif
> >>  }
> >>  
> >> +/*
> >> + * Create a unique process containing all the CPUs.
> >> + */
> >> +static void create_unique_process(GDBState *s)
> >> +{
> >> +    GDBProcess *process;
> >> +
> >> +    s->processes = g_malloc0(sizeof(GDBProcess));
> >> +    s->process_num = 1;
> >> +    process = &s->processes[0];
> >> +
> >> +    process->pid = 1;
> >> +}
> >> +
> >>  #ifdef CONFIG_USER_ONLY
> >>  int
> >>  gdb_handlesig(CPUState *cpu, int sig)
> >>  {
> >>      GDBState *s;
> >> @@ -1846,10 +1869,11 @@ static bool gdb_accept(void)
> >>      }
> >>  
> >>      s = g_malloc0(sizeof(GDBState));
> >>      s->c_cpu = first_cpu;
> >>      s->g_cpu = first_cpu;
> >> +    create_unique_process(s);
> >>      s->fd = fd;
> >>      gdb_has_xml = false;
> >>  
> >>      gdbserver_state = s;
> >>      return true;
> >> @@ -2002,10 +2026,58 @@ static const TypeInfo char_gdb_type_info = {
> >>      .name = TYPE_CHARDEV_GDB,
> >>      .parent = TYPE_CHARDEV,
> >>      .class_init = char_gdb_class_init,
> >>  };
> >>  
> >> +static int find_cpu_clusters(Object *child, void *opaque)
> >> +{
> >> +    if (object_dynamic_cast(child, TYPE_CPU_CLUSTER)) {
> >> +        GDBState *s = (GDBState *) opaque;
> >> +        CPUClusterState *cluster = CPU_CLUSTER(child);
> >> +        GDBProcess *process;
> >> +
> >> +        s->processes = g_renew(GDBProcess, s->processes, ++s->process_num);
> >> +
> >> +        process = &s->processes[s->process_num - 1];
> >> +
> >> +        /* GDB process IDs -1 and 0 are reserved */
> >> +        process->pid = cluster->cluster_id + 1;
> > 
> > This may be theoretical but since both pid and cluster_id are uint32_t
> > you may end up with 0 here.
> > 
> > You may want to limit cluster_id's to something like the range 0 - INT32_MAX.
> That would be an efficient solution to workaround this problem. However
> it seems a bit artificial to limit the cluster_id range in the "generic"
> CPU_CLUSTER class, just for the GDB stub code to work correctly.
> 
> Another solution could be to add a `gdb_pid' property to the CPU_CLUSTER
> type, that would automatically be set to `cpu_cluster + 1' during
> realization (and customized by the platform if needed). That way, value
> 0 could be explicitly forbidden in the CPU_CLUSTER API. However, Peter
> was not a big fan of having explicit GDB stuff in the platform.
> 
> If somebody comes with a good compromise, I can change this. Otherwise
> if we want to be extra safe, maybe we can simply assert that cluster_id
> UINT32_MAX is not used in GDB stub.

Yeah, the latter will at least avoid subtle errors at runtime. Sounds
good to me...


> 
> (snip)
> >> +static int pid_order(const void *a, const void *b)
> >> +{
> >> +    GDBProcess *pa = (GDBProcess *) a;
> >> +    GDBProcess *pb = (GDBProcess *) b;
> >> +
> >> +    return pa->pid - pb->pid;
> > 
> > Similarly here, is this safe?
> > e.g:
> > pa->pid = 1
> > pb->pid = 0x80000002
> To make it safe, I think we can do explicit comparisons:
> 
> if (pa->pid < pb->pid) {
>     return -1;
> } else if (pa->pid > pb->pid) {
>     return 1;
> } else {
>     return 0;
> }


Looks good.

Thanks,
Edgar


> 
> 
> Thanks,
> Luc
> 
> > 
> > 
> > Otherwise:
> > Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> > 
> > 
> > 
> >> +}
> >> +
> >> +static void create_processes(GDBState *s)
> >> +{
> >> +    object_child_foreach(object_get_root(), find_cpu_clusters, s);
> >> +
> >> +    if (!s->processes) {
> >> +        /* No CPU cluster specified by the machine */
> >> +        create_unique_process(s);
> >> +    } else {
> >> +        /* Sort by PID */
> >> +        qsort(s->processes, s->process_num, sizeof(s->processes[0]), pid_order);
> >> +    }
> >> +}
> >> +
> >> +static void cleanup_processes(GDBState *s)
> >> +{
> >> +    g_free(s->processes);
> >> +    s->process_num = 0;
> >> +    s->processes = NULL;
> >> +}
> >> +
> >>  int gdbserver_start(const char *device)
> >>  {
> >>      trace_gdbstub_op_start(device);
> >>  
> >>      GDBState *s;
> >> @@ -2058,15 +2130,19 @@ int gdbserver_start(const char *device)
> >>                                     NULL, &error_abort);
> >>          monitor_init(mon_chr, 0);
> >>      } else {
> >>          qemu_chr_fe_deinit(&s->chr, true);
> >>          mon_chr = s->mon_chr;
> >> +        cleanup_processes(s);
> >>          memset(s, 0, sizeof(GDBState));
> >>          s->mon_chr = mon_chr;
> >>      }
> >>      s->c_cpu = first_cpu;
> >>      s->g_cpu = first_cpu;
> >> +
> >> +    create_processes(s);
> >> +
> >>      if (chr) {
> >>          qemu_chr_fe_init(&s->chr, chr, &error_abort);
> >>          qemu_chr_fe_set_handlers(&s->chr, gdb_chr_can_receive, gdb_chr_receive,
> >>                                   gdb_chr_event, NULL, NULL, NULL, true);
> >>      }
> >> -- 
> >> 2.19.1
> >>
> >>
