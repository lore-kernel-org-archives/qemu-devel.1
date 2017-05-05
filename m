Received: from eggs.gnu.org ([2001:4830:134:3::10]:51187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d6YIr-0003mC-CR
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d6YIq-0001yu-Bw
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:09:29 -0400
Date: Fri, 5 May 2017 10:09:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170505100918.181acc8b@nial.brq.redhat.com>
In-Reply-To: <20170505014522.GK14413@umbus.fritz.box>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
	<1493816238-33120-13-git-send-email-imammedo@redhat.com>
	<20170505014522.GK14413@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 12/24] numa: add numa_[has_]node_id()
 wrappers
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

On Fri, 5 May 2017 11:45:22 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, May 03, 2017 at 02:57:06PM +0200, Igor Mammedov wrote:
> > wrappers should make access to [has]node_id fields more readable
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Correct, though I'm not sure it actually simplifies things that much.
> Maybe more in future patches, though.
that's what Drew insisted on, and even though I prefer other way around
I won't stall series arguing about styling issues,
so here this patch goes.

> 
> > ---
> >  follow up patches will use this wrappers
> >  v2:
> >     - add wrappers (Drew)
> > ---
> >  include/sysemu/numa.h | 10 ++++++++++
> >  numa.c                |  2 +-
> >  2 files changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> > index 46ea6c7..98d01e6 100644
> > --- a/include/sysemu/numa.h
> > +++ b/include/sysemu/numa.h
> > @@ -35,4 +35,14 @@ uint32_t numa_get_node(ram_addr_t addr, Error **errp);
> >  /* on success returns node index in numa_info,
> >   * on failure returns nb_numa_nodes */
> >  int numa_get_node_for_cpu(int idx);
> > +
> > +static inline bool numa_has_node_id(const CPUArchIdList *possible_cpus, int idx)
> > +{
> > +    return possible_cpus->cpus[idx].props.has_node_id;
> > +}
> > +
> > +static inline int numa_node_id(const CPUArchIdList *possible_cpus, int idx)
> > +{
> > +    return possible_cpus->cpus[idx].props.node_id;
> > +}
> >  #endif
> > diff --git a/numa.c b/numa.c
> > index c7e3e0a..872ee0d 100644
> > --- a/numa.c
> > +++ b/numa.c
> > @@ -394,7 +394,7 @@ void parse_numa_opts(MachineState *ms)
> >  
> >          possible_cpus = mc->possible_cpu_arch_ids(ms);
> >          for (i = 0; i < possible_cpus->len; i++) {
> > -            if (possible_cpus->cpus[i].props.has_node_id) {
> > +            if (numa_has_node_id(possible_cpus, i)) {
> >                  break;
> >              }
> >          }  
> 
