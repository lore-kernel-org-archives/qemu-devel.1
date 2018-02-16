Received: from eggs.gnu.org ([2001:4830:134:3::10]:35906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emgbk-0000cw-7n
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 09:03:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emgbh-00032F-5O
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 09:03:24 -0500
References: <1518782691-1232-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518782691-1232-3-git-send-email-mihajlov@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ceb7028a-6878-9a63-004e-bdf774bb2509@redhat.com>
Date: Fri, 16 Feb 2018 08:03:17 -0600
MIME-Version: 1.0
In-Reply-To: <1518782691-1232-3-git-send-email-mihajlov@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv4 2/4] qmp: add query-cpus-fast
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

On 02/16/2018 06:04 AM, Viktor Mihajlovski wrote:
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
>   o Drop "halted" field as it can not be retrieved in a fast
>     way on most architectures
> 
>   o Drop irrelevant fields such as "current", "pc" and "arch"
> 
>   o Rename some fields for better clarification & proper naming
>     standard
> 
> Further, the HMP "info cpus" implementation is changed to
> use the new QMP interface to avoid the side effects caused
> by query-cpus. This means that only a reduced subset of cpu
> information will be reported, which is acceptable as
> the content of "info cpus" is not documented or guaranteed
> to be stable.
> 
> Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Acked-by: Eric Blake <eblake@redhat.com>

The HMP changes are non-trivial compared to v3, so I might have dropped 
all R-b and Acked-by to ensure they are looked at again.

In fact,...

> ---
>   cpus.c           | 38 ++++++++++++++++++++++++++++++
>   hmp.c            | 46 +++++--------------------------------
>   qapi-schema.json | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 114 insertions(+), 40 deletions(-)
> 

> +++ b/hmp.c
> @@ -360,50 +360,16 @@ void hmp_info_migrate_cache_size(Monitor *mon, const QDict *qdict)
>   
>   void hmp_info_cpus(Monitor *mon, const QDict *qdict)
>   {
> -    CpuInfoList *cpu_list, *cpu;
> +    CpuInfoFastList *head, *cpu;
>   
> -    cpu_list = qmp_query_cpus(NULL);
> +    head = qmp_query_cpus_fast(NULL);
>   
> -    for (cpu = cpu_list; cpu; cpu = cpu->next) {
> -        int active = ' ';
> -
> -        if (cpu->value->CPU == monitor_get_cpu_index()) {
> -            active = '*';
> -        }

The old code was doing multiple things - it was telling you the current 
HMP cpu (HMP has 'cpu' with no QMP counterpart, but if you are using 
HMP, knowing which cpu is the active target for future HMP commands that 
depend on the active target, this bit of information is important), as 
well as...

> -        monitor_printf(mon, "%c CPU #%" PRId64 ":", active, cpu->value->CPU);
> -
> -        switch (cpu->value->arch) {
> -        case CPU_INFO_ARCH_X86:
> -            monitor_printf(mon, " pc=0x%016" PRIx64, cpu->value->u.x86.pc);
> -            break;

...inundating you with the arch-specific slow stuff.  I'm in agreement 
that dropping the slow stuff is okay, but...

> +    for (cpu = head; cpu; cpu = cpu->next) {
> +        monitor_printf(mon, "  CPU #%" PRId64 ":", cpu->value->cpu_index);

...unilaterally dropping the '*' active indicator, which has no bearing 
on the QMP changes, and thus is not an appropriate change for this patch.

I've now gone through the entire patch (and not just the UI), so on the 
next revision, I'll be prepared to give a full R-b, rather than just 
Acked-by.  But I do think this means we need a v5.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
