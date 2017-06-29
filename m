Received: from eggs.gnu.org ([2001:4830:134:3::10]:52569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQYGh-0005V6-MN
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:09:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQYGd-00076L-KG
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:09:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dQYGd-00075A-Bt
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:09:51 -0400
Date: Thu, 29 Jun 2017 13:09:47 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170629120946.GG2894@work-vm>
References: <20170608054116.17203-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170608054116.17203-1-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [PATCH V2] monitor: Add -a (all) option to info
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

* Suraj Jitindar Singh (sjitindarsingh@gmail.com) wrote:
> The info registers command in the qemu monitor is used to dump register
> values.
> 
> Currently this command uses the monitor cpu (which can be set by the
> user) as the cpu for whose registers will be dumped. Sometimes it is
> useful to see the registers for all cpus and currently this requires
> setting the monitor cpu and the re-running the command for each cpu
> in the system. I would be nice if there was an easier way to do this.
> 
> Add the "-a" option to the info registers command to dump the register
> values for all cpus.
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> 
> ---
> 
> Change Log:
> 
> V1 -> V2:
>  - Add CPU number to beginning of register dump
> ---
>  hmp-commands-info.hx |  6 +++---
>  monitor.c            | 21 ++++++++++++++++-----
>  2 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index ae16901..ba98e58 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -100,9 +100,9 @@ ETEXI
>  
>      {
>          .name       = "registers",
> -        .args_type  = "",
> -        .params     = "",
> -        .help       = "show the cpu registers",
> +        .args_type  = "cpustate_all:-a",
> +        .params     = "[-a]",
> +        .help       = "show the cpu registers (-a: all - show register info for all cpus)",
>          .cmd        = hmp_info_registers,
>      },
>  
> diff --git a/monitor.c b/monitor.c
> index baa73c9..1629ad1 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1078,13 +1078,24 @@ int monitor_get_cpu_index(void)
>  
>  static void hmp_info_registers(Monitor *mon, const QDict *qdict)
>  {
> -    CPUState *cs = mon_get_cpu();
> +    bool all_cpus = qdict_get_try_bool(qdict, "cpustate_all", false);
> +    CPUState *cs;
>  
> -    if (!cs) {
> -        monitor_printf(mon, "No CPU available\n");
> -        return;
> +    if (all_cpus) {
> +        CPU_FOREACH(cs) {
> +            monitor_printf(mon, "\nCPU#%d\n", cs->cpu_index);
> +            cpu_dump_state(cs, (FILE *)mon, monitor_fprintf, CPU_DUMP_FPU);
> +        }
> +    } else {
> +        cs = mon_get_cpu();
> +
> +        if (!cs) {
> +            monitor_printf(mon, "No CPU available\n");
> +            return;
> +        }
> +
> +        cpu_dump_state(cs, (FILE *)mon, monitor_fprintf, CPU_DUMP_FPU);
>      }
> -    cpu_dump_state(cs, (FILE *)mon, monitor_fprintf, CPU_DUMP_FPU);
>  }
>  
>  static void hmp_info_jit(Monitor *mon, const QDict *qdict)
> -- 
> 2.9.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
