Received: from eggs.gnu.org ([2001:4830:134:3::10]:59991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d1D5H-0007f9-8T
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:29:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d1D5G-0002lK-7z
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:29:23 -0400
Date: Thu, 20 Apr 2017 16:29:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170420162912.52241bfe@nial.brq.redhat.com>
In-Reply-To: <20170328041920.GC21068@umbus.fritz.box>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
	<1490189568-167621-6-git-send-email-imammedo@redhat.com>
	<20170328041920.GC21068@umbus.fritz.box>
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Shannon Zhao <zhaoshenglong@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 28 Mar 2017 15:19:20 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Mar 22, 2017 at 02:32:30PM +0100, Igor Mammedov wrote:
[...]
answering to questions that I forgot to answer before

> > @@ -1554,6 +1554,16 @@ static void virt_set_gic_version(Object *obj, const char *value, Error **errp)
> >      }
> >  }
> >  
> > +static CpuInstanceProperties
> > +virt_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
> > +{
> > +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> > +    const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(ms);
> > +
> > +    assert(cpu_index < possible_cpus->len);
> > +    return possible_cpus->cpus[cpu_index].props;;
> > +}
> > +  
> 
> It seems a bit weird to have a machine specific hook to pull the
> property information when one way or another it's coming from the
> possible_cpus table, which is already constructed by a machine
> specific hook.  Could we add a range or list of cpu_index values to
> each possible_cpus entry instead, and have a generic lookup of the
> right entry based on that?
Mainly I dislike the idea because it adds duplicate data to manage
that could be computed from already stored there CpuInstanceProperties.

And secondly if it were just 1 number then generic lookup would be trivial
but with list it becomes cumbersome to manage and implementation
larger then 3 *_cpu_index_to_props() hooks combined, it's not worth it
in foreseeable future.
 
> >  static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
> >  {
> >      int n;
> > @@ -1573,8 +1583,12 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
> >          ms->possible_cpus->cpus[n].props.has_thread_id = true;
> >          ms->possible_cpus->cpus[n].props.thread_id = n;
> >  
> > -        /* TODO: add 'has_node/node' here to describe
> > -           to which node core belongs */
> > +        /* default distribution of CPUs over NUMA nodes */
> > +        if (nb_numa_nodes) {
> > +            /* preset values but do not enable them i.e. 'has_node_id = false',
> > +             * board will enable them if manual mapping wasn't present on CLI */  
> 
> I'm a little confused by this comment, since I don't see any board
> code altering has_node_id.
it happens in the last 2 hunks of patch 10/23
may be I should write it like this:

+            /* preset values but do not enable them i.e. 'has_node_id = false',
+             * numa initialization code will enable them later if manual mapping
+             * wasn't present on CLI */

> 
> > +            ms->possible_cpus->cpus[n].props.node_id = n % nb_numa_nodes;;
> > +        }
> >      }
> >      return ms->possible_cpus;
> >  }
[...]
