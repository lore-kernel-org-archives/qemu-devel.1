Received: from eggs.gnu.org ([2001:4830:134:3::10]:52417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e4Mfa-0007Ag-Np
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 03:52:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e4MfW-0001kH-Lh
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 03:52:10 -0400
Date: Tue, 17 Oct 2017 09:52:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171017095202.6d8a8df0@nial.brq.redhat.com>
In-Reply-To: <150817967599.32385.13210015253120051927.stgit@bahia.lan>
References: <150817967599.32385.13210015253120051927.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] monitor: fix dangling CPU pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Mon, 16 Oct 2017 20:47:56 +0200
Greg Kurz <groug@kaod.org> wrote:

...
> Note that the resolution should really return a CPU object, otherwise
> we have a bug. This is achieved by relying on object_resolve_path()
> and CPU() instead of calling object_resolve_path_type(path, TYPE_CPU).
Did you forget to remove this part?

> 
> Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
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
