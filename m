Received: from eggs.gnu.org ([2001:4830:134:3::10]:39102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1elGtK-0000m0-C4
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1elGtJ-0001Hx-8i
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:23:42 -0500
Date: Mon, 12 Feb 2018 17:23:32 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180212172332.6d5c3232.cohuck@redhat.com>
In-Reply-To: <1518437672-7724-4-git-send-email-mihajlov@linux.vnet.ibm.com>
References: <1518437672-7724-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518437672-7724-4-git-send-email-mihajlov@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] qmp: add architecture specific cpu
 data for query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, lcapitulino@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, dgilbert@redhat.com, rth@twiddle.net, borntraeger@de.ibm.com, agraf@suse.de, david@redhat.com, eblake@redhat.com, armbru@redhat.com, berrange@redhat.com

On Mon, 12 Feb 2018 13:14:32 +0100
Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:

> The s390 CPU state can be retrieved without interrupting the
> VM execution. Extendend the CpuInfoFast union with architecture
> specific data and an implementation for s390.
> 
> Return data looks like this:
>  [
>    {"thread-id":64301,"props":{"core-id":0},
>     "arch":"s390","cpu-state":"operating",
>     "qom-path":"/machine/unattached/device[0]","cpu-index":0},
>    {"thread-id":64302,"props":{"core-id":1},
>     "arch":"s390","cpu-state":"operating",
>     "qom-path":"/machine/unattached/device[1]","cpu-index":1}
> ]
> 
> Currently there's a certain amount of duplication between
> the definitions of CpuInfo and CpuInfoFast, both in the
> base and variable areas, since there are data fields common
> to the slow and fast variants.
> 
> A suggestion was made on the mailing list to enhance the QAPI
> code generation to support two layers of unions. This would
> allow to specify the common fields once and avoid the duplication
> in the leaf unions.
> 
> On the other hand, the slow query-cpus should be deprecated
> along with the slow CpuInfo type and eventually be removed.
> Assuming that new architectures will not be added at high
> rates, we could live with the duplication for the time being.
> 
> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> ---
>  cpus.c           | 10 ++++++++++
>  hmp.c            |  8 ++++++++
>  qapi-schema.json | 35 +++++++++++++++++++++++++++++------
>  3 files changed, 47 insertions(+), 6 deletions(-)
> 
> diff --git a/cpus.c b/cpus.c
> index 6df6660..af67826 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -2166,6 +2166,10 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
>      MachineClass *mc = MACHINE_GET_CLASS(ms);
>      CpuInfoFastList *head = NULL, *cur_item = NULL;
>      CPUState *cpu;
> +#if defined(TARGET_S390X)
> +    S390CPU *s390_cpu;
> +    CPUS390XState *env;
> +#endif
>  
>      CPU_FOREACH(cpu) {
>          CpuInfoFastList *info = g_malloc0(sizeof(*info));
> @@ -2183,6 +2187,12 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
>              info->value->props = props;
>          }
>  
> +#if defined(TARGET_S390X)
> +        s390_cpu = S390_CPU(cpu);
> +        env = &s390_cpu->env;

You should be able to omit the s390_cpu variable by using

           env = &S390_CPU(cpu)->env;

> +        info->value->arch = CPU_INFO_ARCH_S390;
> +        info->value->u.s390.cpu_state = env->cpu_state;
> +#endif
>          if (!cur_item) {
>              head = cur_item = info;
>          } else {

As you mentioned in the patch description, the duplication is a bit
awkward. I'll let the QAPI experts judge that; otherwise, this looks
fine to me.
