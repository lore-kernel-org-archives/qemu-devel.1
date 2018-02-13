Received: from eggs.gnu.org ([2001:4830:134:3::10]:38467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eldH2-0001Gj-WD
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:17:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eldGz-0004zT-3y
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:17:40 -0500
Date: Tue, 13 Feb 2018 17:17:30 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180213171730.1b3eed5d.cohuck@redhat.com>
In-Reply-To: <0152b654-a745-271f-2984-e9e078d986ed@linux.vnet.ibm.com>
References: <1518437672-7724-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518437672-7724-4-git-send-email-mihajlov@linux.vnet.ibm.com>
	<20180212172332.6d5c3232.cohuck@redhat.com>
	<0152b654-a745-271f-2984-e9e078d986ed@linux.vnet.ibm.com>
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
Cc: agraf@suse.de, ehabkost@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com, david@redhat.com, qemu-devel@nongnu.org, lcapitulino@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, dgilbert@redhat.com, rth@twiddle.net

On Tue, 13 Feb 2018 17:12:50 +0100
Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:

> On 12.02.2018 17:23, Cornelia Huck wrote:
> [...]
> >> diff --git a/cpus.c b/cpus.c
> >> index 6df6660..af67826 100644
> >> --- a/cpus.c
> >> +++ b/cpus.c
> >> @@ -2166,6 +2166,10 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
> >>      MachineClass *mc = MACHINE_GET_CLASS(ms);
> >>      CpuInfoFastList *head = NULL, *cur_item = NULL;
> >>      CPUState *cpu;
> >> +#if defined(TARGET_S390X)
> >> +    S390CPU *s390_cpu;
> >> +    CPUS390XState *env;
> >> +#endif
> >>  
> >>      CPU_FOREACH(cpu) {
> >>          CpuInfoFastList *info = g_malloc0(sizeof(*info));
> >> @@ -2183,6 +2187,12 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
> >>              info->value->props = props;
> >>          }
> >>  
> >> +#if defined(TARGET_S390X)
> >> +        s390_cpu = S390_CPU(cpu);
> >> +        env = &s390_cpu->env;  
> > 
> > You should be able to omit the s390_cpu variable by using
> > 
> >            env = &S390_CPU(cpu)->env;
> >   
> True, but I wanted to stay in style with the code in qmp_query_cpus.


TBH, I don't care too much one way or the other :)

> >> +        info->value->arch = CPU_INFO_ARCH_S390;
> >> +        info->value->u.s390.cpu_state = env->cpu_state;
> >> +#endif
> >>          if (!cur_item) {
> >>              head = cur_item = info;
> >>          } else {  
> > 
> > As you mentioned in the patch description, the duplication is a bit
> > awkward. I'll let the QAPI experts judge that; otherwise, this looks
> > fine to me.
> >   
> 
