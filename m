Received: from eggs.gnu.org ([2001:4830:134:3::10]:50779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1crOCm-0005yd-KY
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 08:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1crOCl-0006eu-D8
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 08:20:32 -0400
Date: Fri, 24 Mar 2017 13:20:17 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170324132017.385a3a12@nial.brq.redhat.com>
In-Reply-To: <59448b66-430d-48a1-cf98-541873c87cb7@redhat.com>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
	<1490189568-167621-16-git-send-email-imammedo@redhat.com>
	<59448b66-430d-48a1-cf98-541873c87cb7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 15/23] QMP: include
 CpuInstanceProperties into query_cpus output output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Shannon Zhao <zhaoshenglong@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Thu, 23 Mar 2017 08:19:24 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 03/22/2017 08:32 AM, Igor Mammedov wrote:
> > if board supports CpuInstanceProperties, report them for
> > each CPU thread listed. Main motivation for this is to
> > provide these properties introspection via QMP interface
> > for using in test cases to verify numa node to cpu mapping,
> > which includes not only boards that support cpu hotplug
> > and have this info in query-hotpluggable-cpus (pc/spapr)
> > but also for boards that don't not support hotpluggable-cpus
> > but support numa mapping (virt-arm).
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---  
> 
> > @@ -1860,6 +1863,12 @@ CpuInfoList *qmp_query_cpus(Error **errp)
> >  #else
> >          info->value->arch = CPU_INFO_ARCH_OTHER;
> >  #endif
> > +        if ((info->value->has_props = !!mc->cpu_index_to_instance_props)) {  
> 
> checkpatch.pl doesn't flag that? We generally try to avoid side-effects
> inside conditionals.
it does, fixed in v2 branch
(lazy me skipped checkpatch since QMP test case been added,
I've also fixed another checkpatch error in the next patch)
 
> > +            CpuInstanceProperties *props;
> > +            props = g_malloc0(sizeof(*props));
> > +            *props = mc->cpu_index_to_instance_props(ms, cpu->cpu_index);
> > +            info->value->props =  props;  
> 
> Why two spaces after =?
fixed

> 
> With those cleaned up,
> Reviewed-by: Eric Blake <eblake@redhat.com>
Thanks! 
