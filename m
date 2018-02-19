Received: from eggs.gnu.org ([2001:4830:134:3::10]:49260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1enolA-0004QJ-C0
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:57:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1enol5-0005F1-Pp
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:57:48 -0500
References: <1518797321-28356-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518797321-28356-6-git-send-email-mihajlov@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <45949808-40af-8f8b-0651-08cb98300043@redhat.com>
Date: Mon, 19 Feb 2018 10:57:39 -0600
MIME-Version: 1.0
In-Reply-To: <1518797321-28356-6-git-send-email-mihajlov@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv5 5/5] hmp: change hmp_info_cpus to use
 query-cpus-fast
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

On 02/16/2018 10:08 AM, Viktor Mihajlovski wrote:
> Changing the implementation of hmp_info_cpus() to call
> qmp_query_cpus_fast() instead of qmp_query_cpus. This has the
> following consequences:
> 
>    o No further code change required for qmp_query_cpus deprecation
> 
>    o HMP profits from the less disruptive cpu information retrieval
> 
>    o HMP 'info cpus' won't display architecture specific data anymore,
>      which should be tolerable in the light of the deprecation of
>      query-cpus.
> 
> In order to allow 'info cpus' to be executed completely on the
> fast path, monitor_get_cpu_index() has been adapted to not synchronize
> the cpu state.
> 
> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> ---
>   hmp.c     | 41 +++++++----------------------------------
>   monitor.c | 13 ++++++++++---
>   2 files changed, 17 insertions(+), 37 deletions(-)
> 
> diff --git a/hmp.c b/hmp.c
> index 7870d6a..ae86bfb 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -360,50 +360,23 @@ void hmp_info_migrate_cache_size(Monitor *mon, const QDict *qdict)
>   
>   void hmp_info_cpus(Monitor *mon, const QDict *qdict)
>   {
> -    CpuInfoList *cpu_list, *cpu;
> +    CpuInfoFastList *cpu_list, *cpu;
>   
> -    cpu_list = qmp_query_cpus(NULL);
> +    cpu_list = qmp_query_cpus_fast(NULL);

Pre-existing, but a bit unusual to call this with errors completely 
ignored.  Can be a followup patch, if desired.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
