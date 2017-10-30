Received: from eggs.gnu.org ([2001:4830:134:3::10]:49139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e9F5u-0002ZH-6U
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 14:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e9F5r-0004SX-36
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 14:47:30 -0400
Date: Mon, 30 Oct 2017 18:47:21 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171030184721.GB24825@work-vm>
References: <150822818243.26242.12993827911736928961.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <150822818243.26242.12993827911736928961.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v3] monitor: fix dangling CPU pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>

* Greg Kurz (groug@kaod.org) wrote:
> If a CPU selected with the "cpu" command is hot-unplugged then "info cpus"
> causes QEMU to exit:
> 
> (qemu) device_del cpu1
> (qemu) info cpus
> qemu:qemu_cpu_kick_thread: No such process
> 
> This happens because "cpu" stores the pointer to the selected CPU into
> the monitor structure. When the CPU is hot-unplugged, we end up with a
> dangling pointer. The "info cpus" command then does:
> 
> hmp_info_cpus()
>  monitor_get_cpu_index()
>   mon_get_cpu()
>    cpu_synchronize_state() <--- called with dangling pointer
> 
> This could cause a QEMU crash as well.
> 
> This patch switches the monitor to store the QOM path instead of a
> pointer to the current CPU. The path is then resolved when needed.
> If the resolution fails, we assume that the CPU was removed and the
> path is resetted to the default (ie, path of first_cpu).
> 
> Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Queued for HMP

Dave

> ---
> v3: - drop irrelevant paragraph about object_resolve_path() from the
>       changelog
> 
> v2: - use object_resolve_path_type()
>     - add Reported-by tag
> ---
>  monitor.c |   23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/monitor.c b/monitor.c
> index fe0d1bdbb461..ce577e46e568 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -200,7 +200,7 @@ struct Monitor {
>  
>      ReadLineState *rs;
>      MonitorQMP qmp;
> -    CPUState *mon_cpu;
> +    gchar *mon_cpu_path;
>      BlockCompletionFunc *password_completion_cb;
>      void *password_opaque;
>      mon_cmd_t *cmd_table;
> @@ -579,6 +579,7 @@ static void monitor_data_init(Monitor *mon)
>  
>  static void monitor_data_destroy(Monitor *mon)
>  {
> +    g_free(mon->mon_cpu_path);
>      qemu_chr_fe_deinit(&mon->chr, false);
>      if (monitor_is_qmp(mon)) {
>          json_message_parser_destroy(&mon->qmp.parser);
> @@ -1047,20 +1048,32 @@ int monitor_set_cpu(int cpu_index)
>      if (cpu == NULL) {
>          return -1;
>      }
> -    cur_mon->mon_cpu = cpu;
> +    g_free(cur_mon->mon_cpu_path);
> +    cur_mon->mon_cpu_path = object_get_canonical_path(OBJECT(cpu));
>      return 0;
>  }
>  
>  CPUState *mon_get_cpu(void)
>  {
> -    if (!cur_mon->mon_cpu) {
> +    CPUState *cpu;
> +
> +    if (cur_mon->mon_cpu_path) {
> +        cpu = (CPUState *) object_resolve_path_type(cur_mon->mon_cpu_path,
> +                                                    TYPE_CPU, NULL);
> +        if (!cpu) {
> +            g_free(cur_mon->mon_cpu_path);
> +            cur_mon->mon_cpu_path = NULL;
> +        }
> +    }
> +    if (!cur_mon->mon_cpu_path) {
>          if (!first_cpu) {
>              return NULL;
>          }
>          monitor_set_cpu(first_cpu->cpu_index);
> +        cpu = first_cpu;
>      }
> -    cpu_synchronize_state(cur_mon->mon_cpu);
> -    return cur_mon->mon_cpu;
> +    cpu_synchronize_state(cpu);
> +    return cpu;
>  }
>  
>  CPUArchState *mon_get_cpu_env(void)
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
