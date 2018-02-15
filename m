Received: from eggs.gnu.org ([2001:4830:134:3::10]:60263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emKOK-00051C-PM
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:20:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emKOG-00075P-Pe
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:20:04 -0500
References: <1518690027-31318-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518690027-31318-3-git-send-email-mihajlov@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3b41b0f0-09cf-9e43-bfa4-617335d76584@redhat.com>
Date: Thu, 15 Feb 2018 08:19:57 -0600
MIME-Version: 1.0
In-Reply-To: <1518690027-31318-3-git-send-email-mihajlov@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv3 2/4] qmp: add query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de, ehabkost@redhat.com, armbru@redhat.com, cohuck@redhat.com, david@redhat.com, dgilbert@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

On 02/15/2018 04:20 AM, Viktor Mihajlovski wrote:
> From: Luiz Capitulino <lcapitulino@redhat.com>
> 
> The query-cpus command has an extremely serious side effect:
> it always interrupts all running vCPUs so that they can run
> ioctl calls. This can cause a huge performance degradation for
> some workloads. And most of the information retrieved by the
> ioctl calls are not even used by query-cpus.
> 
> This commit introduces a replacement for query-cpus called
> query-cpus-fast, which has the following features:
> 
>   o Never interrupt vCPUs threads. query-cpus-fast only returns
>     vCPU information maintained by QEMU itself, which should be
>     sufficient for most management software needs
> 
>   o Drop "halted" field as it can not retrieved in a fast

s/can not retrieved/cannot be retrieved/

>     way on most architectures
> 
>   o Drop irrelevant fields such as "current", "pc" and "arch"
> 
>   o Rename some fields for better clarification & proper naming
>     standard
> 
> Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Acked-by: Eric Blake <eblake@redhat.com>
> ---

> +++ b/hmp-commands-info.hx
> @@ -160,6 +160,20 @@ Show infos for each CPU.

Pre-existing, but while we are here, it wouldn't hurt to do 
s/infos/information/

>   ETEXI
>   
>       {
> +        .name       = "cpus_fast",
> +        .args_type  = "",
> +        .params     = "",
> +        .help       = "show information for each CPU without interrupting them",
> +        .cmd        = hmp_info_cpus_fast,
> +    },
> +
> +STEXI
> +@item info cpus_fast
> +@findex info cpus_fast
> +Show infos for each CPU without performance penalty.

and again here, where you copied and pasted.

You know, we have no back-compat guarantees on HMP.  We could make 'info 
cpu' just ALWAYS call query-cpus-fast, with no HMP counterpart for the 
slower query-cpus, and without needing a deprecation period.  But I'll 
leave that up to David if that makes more sense.

> +++ b/hmp.c
> @@ -410,6 +410,20 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict)
>       qapi_free_CpuInfoList(cpu_list);
>   }
>   
> +void hmp_info_cpus_fast(Monitor *mon, const QDict *qdict)
> +{
> +    CpuInfoFastList *head, *cpu;
> +
> +    head = qmp_query_cpus_fast(NULL);
> +
> +    for (cpu = head; cpu; cpu = cpu->next) {
> +        monitor_printf(mon, "  CPU #%" PRId64 ":", cpu->value->cpu_index);
> +        monitor_printf(mon, " thread-id=%" PRId64 "\n", cpu->value->thread_id);
> +    }

This is particularly true since your HMP implementation is not even 
printing all the information returned by query-cpus-fast!

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
