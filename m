Received: from eggs.gnu.org ([2001:4830:134:3::10]:41265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cqyQG-0006tP-Rk
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:48:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cqyQG-0002VV-2l
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:48:44 -0400
Date: Thu, 23 Mar 2017 09:48:34 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170323094834.0de7c3cb@nial.brq.redhat.com>
In-Reply-To: <CAGZKiBpD=uLyJWFPhxKYfn0-wLL2WYnUm5h4KJhZ_fVHi+1z-w@mail.gmail.com>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
	<1490189568-167621-6-git-send-email-imammedo@redhat.com>
	<CAGZKiBpD=uLyJWFPhxKYfn0-wLL2WYnUm5h4KJhZ_fVHi+1z-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 05/23] numa: move source of
 default CPUs to NUMA node mapping into boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata.rao@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-arm@nongnu.org, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Thu, 23 Mar 2017 11:40:29 +0530
Bharata B Rao <bharata.rao@gmail.com> wrote:

> On Wed, Mar 22, 2017 at 7:02 PM, Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > diff --git a/numa.c b/numa.c
> > index e01cb54..b6e71bc 100644
> > --- a/numa.c
> > +++ b/numa.c
> > @@ -294,9 +294,10 @@ static void validate_numa_cpus(void)
> >      g_free(seen_cpus);
> >  }
> >
> > -void parse_numa_opts(MachineClass *mc)
> > +void parse_numa_opts(MachineState *ms)
> >  {
> >      int i;
> > +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> >
> >      for (i = 0; i < MAX_NODES; i++) {
> >          numa_info[i].node_cpu = bitmap_new(max_cpus);
> > @@ -378,14 +379,16 @@ void parse_numa_opts(MachineClass *mc)
> >           * rule grouping VCPUs by socket so that VCPUs from the same
> > socket
> >           * would be on the same node.
> >           */
> > +        if (!mc->cpu_index_to_instance_props) {
> > +            error_report("default CPUs to NUMA node mapping isn't
> > supported");
> > +            exit(1);
> > +        }
> >  
> 
> Just trying to understand the impact of the above enforcement. So targets
> and machine types that don't define ->cpu_index_to_instance_props() are
> expected not to boot ? Shouldn't they have a default to fall back upon ?
Currently there are 3 boards that support numa and with this series
they all implement cpu_index_to_instance_props callback,
so boards that has supported numa shouldn't be affected.

But if someone used '-numa' with a board that doesn't support numa,
it would stop booting with error message instead of silently parsing
not supported option or falling back bogus defaults (which aren't
used anyway).


> Regards,
> Bharata.
