Received: from eggs.gnu.org ([2001:4830:134:3::10]:48550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f6ECc-0001di-SF
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 07:46:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f6ECZ-00049f-Qg
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 07:46:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51524 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1f6ECZ-000491-LP
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 07:46:11 -0400
Date: Wed, 11 Apr 2018 13:46:00 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180411134600.0ed8158a@redhat.com>
In-Reply-To: <20180411111602.20156-1-linzhecheng@huawei.com>
References: <20180411111602.20156-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] cpu: skip unpluged cpu when querying cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>
Cc: qemu-devel@nongnu.org, xuyandong2@huawei.com, pbonzini@redhat.com, wangxinxin.wang@huawei.com, rth@twiddle.net, crosthwaite.peter@gmail.com

On Wed, 11 Apr 2018 19:16:02 +0800
linzhecheng <linzhecheng@huawei.com> wrote:

> From: XuYandong <xuyandong2@huawei.com>
> 
> After vcpu1 thread exiting, vcpu0 thread (received notification) is still waiting for
> holding qemu_global_mutex in cpu_remove_sync, at this moment, vcpu1 is still in global cpus list.
> If main thread grab qemu_global_mutex in order to handle qmp command "info cpus",
> qmp_query_cpus visit unpluged vcpu1 will lead qemu process to exit.
Add here exact error or better stack trace in case it crashes.

 
> Signed-off-by: XuYandong <xuyandong2@huawei.com>
> ---
>  cpus.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/cpus.c b/cpus.c
> index 2cb0af9..9b3a6c4 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -2018,6 +2018,11 @@ CpuInfoList *qmp_query_cpus(Error **errp)
>  
>      CPU_FOREACH(cpu) {
>          CpuInfoList *info;
> +
> +        if (cpu->unplug) {
> +            continue;
> +        }
Shouldn't be it done for qmp_query_cpus_fast() as well?

> +
>  #if defined(TARGET_I386)
>          X86CPU *x86_cpu = X86_CPU(cpu);
>          CPUX86State *env = &x86_cpu->env;
