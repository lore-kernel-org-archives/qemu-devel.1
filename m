Received: from eggs.gnu.org ([2001:4830:134:3::10]:37322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1ePZWY-00034r-UC
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 14:50:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1ePZWU-00068e-TR
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 14:50:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1ePZWU-00067p-KT
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 14:50:26 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBEJmcv4145815
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 14:50:23 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2euws84yjg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 14:50:22 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Thu, 14 Dec 2017 14:50:21 -0500
References: <20171213181540.7949-1-danielhb@linux.vnet.ibm.com>
	<20171213181540.7949-3-danielhb@linux.vnet.ibm.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Thu, 14 Dec 2017 17:50:17 -0200
MIME-Version: 1.0
In-Reply-To: <20171213181540.7949-3-danielhb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <3821202a-0a95-54cc-2b4a-d5ea1b516a98@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/2] cpus.c: change qmp_query_cpus
 'value->current' logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, armbru@redhat.com



On 12/13/2017 04:15 PM, Daniel Henrique Barboza wrote:
> qmp_query_cpus always return the same information, ignoring the
> monitor state. This means that information such as cpu->value->current
> will always return the same value ((cpu == first_cpu) at this moment).
> This function is used by hmp_info_cpus that does its own logic based on
> monitor_get_cpu_index() to print the current/active CPU information,
> ignoring cpu->value->current. This value is used as is in QMP
> query-cpus though.
>
> This wasn't a problem because QMP couldn't set its current CPU via
> qmp_cpu anyway, so query-cpus returning the same state all the time
> (regarding current CPU for the monitor) wasn't a problem. But now
> we can use qmp_cpu to set the current monitor CPU, making the return
> from query-cpus wrong.
>
> This patch makes a simple change in qmp_query_cpus to change the
> cpu->value->current logic to consider the current monitor state,
> like it was being done in hmp_info_cpus. Now, cpu->value->current
> will return an accurate value for both QMP and HMP calls. hmp_info_cpus
> can no use this value directly instead of doing its own logic.
>
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> ---
The purpose of this patch watered away with qmp_cpu doing nothing.

Although there is a point to be made that this might be "nicer" that
what we have, a sort of cleanup, I am not sure if it's worth it. Apply
it or leave it alone, either way works for me.


Daniel


>   cpus.c | 2 +-
>   hmp.c  | 6 +-----
>   2 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/cpus.c b/cpus.c
> index 114c29b6a0..d3b79d1c02 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1919,7 +1919,7 @@ CpuInfoList *qmp_query_cpus(Error **errp)
>           info = g_malloc0(sizeof(*info));
>           info->value = g_malloc0(sizeof(*info->value));
>           info->value->CPU = cpu->cpu_index;
> -        info->value->current = (cpu == first_cpu);
> +        info->value->current = (cpu->cpu_index == monitor_get_cpu_index());
>           info->value->halted = cpu->halted;
>           info->value->qom_path = object_get_canonical_path(OBJECT(cpu));
>           info->value->thread_id = cpu->thread_id;
> diff --git a/hmp.c b/hmp.c
> index 7506f105a0..1259cafc1f 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -363,11 +363,7 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict)
>       cpu_list = qmp_query_cpus(NULL);
>
>       for (cpu = cpu_list; cpu; cpu = cpu->next) {
> -        int active = ' ';
> -
> -        if (cpu->value->CPU == monitor_get_cpu_index()) {
> -            active = '*';
> -        }
> +        int active = cpu->value->current ? '*' : ' ';
>
>           monitor_printf(mon, "%c CPU #%" PRId64 ":", active, cpu->value->CPU);
>
