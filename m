Received: from eggs.gnu.org ([2001:4830:134:3::10]:49604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e2zz8-0000Ob-Dz
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 09:26:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e2zz5-0004Si-9E
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 09:26:42 -0400
Received: from 6.mo5.mail-out.ovh.net ([178.32.119.138]:57452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e2zz5-0004SE-2P
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 09:26:39 -0400
Received: from player773.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 973E71405E4
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 15:26:36 +0200 (CEST)
Date: Fri, 13 Oct 2017 15:26:32 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171013152632.3bbbe956@bahia.lan>
In-Reply-To: <150789527176.5487.14861721766357709655.stgit@bahia.lan>
References: <150789527176.5487.14861721766357709655.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] monitor: fix dangling CPU pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Fri, 13 Oct 2017 13:47:51 +0200
Greg Kurz <groug@kaod.org> wrote:

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
> Note that the resolution should really return a CPU object, otherwise
> we have a bug. This is achieved by relying on object_resolve_path()
> and CPU() instead of calling object_resolve_path_type(path, TYPE_CPU).
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---

Whoever merges this patch, please add:

Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

Thanks!

>  monitor.c |   25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/monitor.c b/monitor.c
> index fe0d1bdbb461..8489b2ad99c0 100644
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
> @@ -1047,20 +1048,34 @@ int monitor_set_cpu(int cpu_index)
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
> +        Object *obj = object_resolve_path(cur_mon->mon_cpu_path, NULL);
> +
> +        if (!obj) {
> +            g_free(cur_mon->mon_cpu_path);
> +            cur_mon->mon_cpu_path = NULL;
> +        } else {
> +            cpu = CPU(obj);
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
> 
