Received: from eggs.gnu.org ([209.51.188.92]:35841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gj9Cu-0002w5-H4
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 15:51:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gj9Cr-0001KO-PK
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 15:51:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gj9Cr-0001Jr-Gk
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 15:51:37 -0500
Date: Mon, 14 Jan 2019 18:51:34 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190114205134.GB16013@habkost.net>
References: <1547468699-17633-1-git-send-email-like.xu@linux.intel.com>
	<1547468699-17633-3-git-send-email-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547468699-17633-3-git-send-email-like.xu@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/5] vl.c: add -smp,
 dies=* command line support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Like Xu <like.xu@linux.intel.com>
Cc: qemu-devel@nongnu.org, like.xu@intel.com, imammedo@redhat.com, drjones@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

On Mon, Jan 14, 2019 at 08:24:56PM +0800, Like Xu wrote:
> This patch updates the check rules on legeacy -smp parse from user command
> and it's designed to obey the same restrictions as socket/core/thread model.
> 
> Signed-off-by: Like Xu <like.xu@linux.intel.com>

This would require the documentation for -smp to be updated.
qemu-options.hx still says that "cores=" is the number of cores
per socket.

Also, I'm not completely sure we should change the meaning of
"cores=" and smp_cores to be per-die instead of per-socket.  Most
machines won't have any code for tracking dies, so we probably
shouldn't make the extra complexity affect all machines.[1]

What would be the disadvantages of a simple -machine
"dies-per-socket" option, specific for PC?

Keeping core-id and smp_cores per-socket instead of per-die also
seems necessary to keep backwards compatibility on the interface
for identifying CPU hotplug slots.  Igor, what do you think?


[1] I would even argue that the rest of the -smp options belong
    to the machine object, and topology rules should be
    machine-specific, but cleaning this up will require
    additional work.

> ---
>  hmp.c             |  3 +++
>  hw/core/machine.c | 12 ++++++++++++
>  vl.c              | 33 ++++++++++++++++++++-------------
>  3 files changed, 35 insertions(+), 13 deletions(-)
> 
> diff --git a/hmp.c b/hmp.c
> index 80aa5ab..05ac133 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -3013,6 +3013,9 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict)
>          if (c->has_socket_id) {
>              monitor_printf(mon, "    socket-id: \"%" PRIu64 "\"\n", c->socket_id);
>          }
> +        if (c->has_die_id) {
> +            monitor_printf(mon, "    die-id: \"%" PRIu64 "\"\n", c->die_id);
> +        }
>          if (c->has_core_id) {
>              monitor_printf(mon, "    core-id: \"%" PRIu64 "\"\n", c->core_id);
>          }
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 95dc7c3..05bc545 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -601,6 +601,11 @@ void machine_set_cpu_numa_node(MachineState *machine,
>              return;
>          }
>  
> +        if (props->has_die_id && !slot->props.has_die_id) {
> +            error_setg(errp, "die-id is not supported");
> +            return;
> +        }
> +
>          if (props->has_socket_id && !slot->props.has_socket_id) {
>              error_setg(errp, "socket-id is not supported");
>              return;
> @@ -615,6 +620,10 @@ void machine_set_cpu_numa_node(MachineState *machine,
>                  continue;
>          }
>  
> +        if (props->has_die_id && props->die_id != slot->props.die_id) {
> +                continue;
> +        }
> +
>          if (props->has_socket_id && props->socket_id != slot->props.socket_id) {
>                  continue;
>          }
> @@ -849,6 +858,9 @@ static char *cpu_slot_to_string(const CPUArchId *cpu)
>      if (cpu->props.has_socket_id) {
>          g_string_append_printf(s, "socket-id: %"PRId64, cpu->props.socket_id);
>      }
> +    if (cpu->props.has_die_id) {
> +        g_string_append_printf(s, "die-id: %"PRId64, cpu->props.die_id);
> +    }
>      if (cpu->props.has_core_id) {
>          if (s->len) {
>              g_string_append_printf(s, ", ");
> diff --git a/vl.c b/vl.c
> index 9b8ea3f..72be689 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -169,6 +169,7 @@ int win2k_install_hack = 0;
>  int singlestep = 0;
>  int smp_cpus;
>  unsigned int max_cpus;
> +int smp_dies = 1;
>  int smp_cores = 1;
>  int smp_threads = 1;
>  int acpi_enabled = 1;
> @@ -1208,6 +1209,9 @@ static QemuOptsList qemu_smp_opts = {
>              .name = "sockets",
>              .type = QEMU_OPT_NUMBER,
>          }, {
> +             .name = "dies",
> +            .type = QEMU_OPT_NUMBER,
> +        }, {
>              .name = "cores",
>              .type = QEMU_OPT_NUMBER,
>          }, {
> @@ -1226,32 +1230,34 @@ static void smp_parse(QemuOpts *opts)
>      if (opts) {
>          unsigned cpus    = qemu_opt_get_number(opts, "cpus", 0);
>          unsigned sockets = qemu_opt_get_number(opts, "sockets", 0);
> +        unsigned dies = qemu_opt_get_number(opts, "dies", 0);
>          unsigned cores   = qemu_opt_get_number(opts, "cores", 0);
>          unsigned threads = qemu_opt_get_number(opts, "threads", 0);
>  
>          /* compute missing values, prefer sockets over cores over threads */
> +        dies = dies > 0 ? dies : 1;
>          if (cpus == 0 || sockets == 0) {
>              cores = cores > 0 ? cores : 1;
>              threads = threads > 0 ? threads : 1;
>              if (cpus == 0) {
>                  sockets = sockets > 0 ? sockets : 1;
> -                cpus = cores * threads * sockets;
> +                cpus = cores * threads * dies * sockets;
>              } else {
>                  max_cpus = qemu_opt_get_number(opts, "maxcpus", cpus);
> -                sockets = max_cpus / (cores * threads);
> +                sockets = max_cpus / (cores * threads * dies);
>              }
>          } else if (cores == 0) {
>              threads = threads > 0 ? threads : 1;
> -            cores = cpus / (sockets * threads);
> +            cores = cpus / (sockets * dies * threads);
>              cores = cores > 0 ? cores : 1;
>          } else if (threads == 0) {
> -            threads = cpus / (cores * sockets);
> +            threads = cpus / (cores * dies * sockets);
>              threads = threads > 0 ? threads : 1;
> -        } else if (sockets * cores * threads < cpus) {
> +        } else if (sockets * dies * cores * threads < cpus) {
>              error_report("cpu topology: "
> -                         "sockets (%u) * cores (%u) * threads (%u) < "
> +                         "sockets (%u) * dies (%u) * cores (%u) * threads (%u) < "
>                           "smp_cpus (%u)",
> -                         sockets, cores, threads, cpus);
> +                         sockets, dies, cores, threads, cpus);
>              exit(1);
>          }
>  
> @@ -1262,22 +1268,23 @@ static void smp_parse(QemuOpts *opts)
>              exit(1);
>          }
>  
> -        if (sockets * cores * threads > max_cpus) {
> +        if (sockets * dies * cores * threads > max_cpus) {
>              error_report("cpu topology: "
> -                         "sockets (%u) * cores (%u) * threads (%u) > "
> +                         "sockets (%u) * dies (%u) * cores (%u) * threads (%u) > "
>                           "maxcpus (%u)",
> -                         sockets, cores, threads, max_cpus);
> +                         sockets, dies, cores, threads, max_cpus);
>              exit(1);
>          }
>  
> -        if (sockets * cores * threads != max_cpus) {
> +        if (sockets * dies * cores * threads != max_cpus) {
>              warn_report("Invalid CPU topology deprecated: "
> -                        "sockets (%u) * cores (%u) * threads (%u) "
> +                        "sockets (%u) * dies (%u) * cores (%u) * threads (%u) "
>                          "!= maxcpus (%u)",
> -                        sockets, cores, threads, max_cpus);
> +                        sockets, dies, cores, threads, max_cpus);
>          }
>  
>          smp_cpus = cpus;
> +        smp_dies = dies;
>          smp_cores = cores;
>          smp_threads = threads;
>      }
> -- 
> 1.8.3.1
> 

-- 
Eduardo
