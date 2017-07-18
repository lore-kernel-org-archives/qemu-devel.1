Received: from eggs.gnu.org ([2001:4830:134:3::10]:42135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dXTtH-0001Pa-KM
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:54:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dXTtG-00080H-BH
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:54:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dXTtG-0007zo-1R
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:54:22 -0400
Date: Tue, 18 Jul 2017 16:54:17 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170718165417.1b18bcbc@nial.brq.redhat.com>
In-Reply-To: <1500342577-12486-1-git-send-email-wang.yi59@zte.com.cn>
References: <1500342577-12486-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hmp: allow cpu index for "info lapic"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Wang <wang.yi59@zte.com.cn>
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org, liu.yunh@zte.com.cn, Liu.Jianjun3@zte.com.cn

On Mon, 17 Jul 2017 21:49:37 -0400
Yi Wang <wang.yi59@zte.com.cn> wrote:

> Add [vcpu] index support for hmp command "info lapic", which is
> useful when debugging ipi and so on. Current behavior is not
> changed when the parameter isn't specified.
we shouldn't expose cpu_index to users anymore,

I would suggest using to use real APIC ID here but we don't
have monitor command that returns APIC IDs for present cpus.

"info hotpluggable-cpus" gives you a list of available CPUs
it also gives you qom_path to cpu so potentially you could
read apic-id property of cpu.

But we have only QMP variant of qom-get so monitor needs
addition of qom-get command that will be a wrapper around
QMP command.

It could be solved in 2 ways:
 * use socket-id/core-id/thread-id to specify desired cpu
   /possible values in 'info hotpluggable-cpus'/

 * use apic-id value to specify interrupt controller
   - apic-id could be retrieved with new qom-get
     (qom-get would also be useful to read other properties)
   - extend 'info registers' with apic id value
    for example instead of current:
    
     CPU#1
     EAX=00000c06 EBX=00000000 ECX=000002ff EDX=00000000
     ....

    it would look like:

     CPU#1 (socket-id: a, core-id: b, thread-id: c, apic-id: d)
     ...


> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> Signed-off-by: Yun Liu <liu.yunh@zte.com.cn>
> ---
>  hmp-commands-info.hx  | 6 +++---
>  target/i386/monitor.c | 8 +++++++-
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index d9df238..c534b03 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -115,9 +115,9 @@ ETEXI
>  #if defined(TARGET_I386)
>      {
>          .name       = "lapic",
> -        .args_type  = "",
> -        .params     = "",
> -        .help       = "show local apic state",
> +        .args_type  = "vcpu:i?",
> +        .params     = "[vcpu]",
> +        .help       = "show local apic state (vcpu: vCPU to read, default is 0)",
>          .cmd        = hmp_info_local_apic,
>      },
>  #endif
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index 77ead60..813005e 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -632,8 +632,14 @@ const MonitorDef *target_monitor_defs(void)
>  
>  void hmp_info_local_apic(Monitor *mon, const QDict *qdict)
>  {
> -    CPUState *cs = mon_get_cpu();
> +    CPUState *cs;
>  
> +    if (qdict_haskey(qdict, "vcpu")) {
> +        int index = qdict_get_try_int(qdict, "vcpu", 0);
> +        cs = qemu_get_cpu(index);
> +    } else {
> +        cs = mon_get_cpu();
> +    }
>      if (!cs) {
>          monitor_printf(mon, "No CPU available\n");
>          return;
