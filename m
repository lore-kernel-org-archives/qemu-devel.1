Received: from eggs.gnu.org ([2001:4830:134:3::10]:50945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dCnLp-0000nW-Pi
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dCnLl-0002Ro-1O
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:26:21 -0400
Date: Mon, 22 May 2017 15:26:00 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170522152600.3f6ea2ea@nial.brq.redhat.com>
In-Reply-To: <20170522125845.GA18350@thinpad.lan.raisama.net>
References: <1495094971-177754-1-git-send-email-imammedo@redhat.com>
	<1495094971-177754-2-git-send-email-imammedo@redhat.com>
	<20170518181913.GN4748@thinpad.lan.raisama.net>
	<20170522083931.568735a4@nial.brq.redhat.com>
	<20170522125845.GA18350@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] numa: consolidate cpu_preplug
 fixups/checks for pc/arm/spapr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Andrew Jones <drjones@redhat.com>

On Mon, 22 May 2017 09:58:45 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Mon, May 22, 2017 at 08:39:31AM +0200, Igor Mammedov wrote:
> > On Thu, 18 May 2017 15:19:13 -0300
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> >   
> > > On Thu, May 18, 2017 at 10:09:29AM +0200, Igor Mammedov wrote:  
> > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > > ---
> > > >  include/sysemu/numa.h |  1 +
> > > >  hw/arm/virt.c         | 16 ++--------------
> > > >  hw/i386/pc.c          | 17 +----------------
> > > >  hw/ppc/spapr.c        | 17 +----------------
> > > >  numa.c                | 22 ++++++++++++++++++++++
> > > >  5 files changed, 27 insertions(+), 46 deletions(-)
> > > > 
> > > > diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> > > > index 7ffde5b..610eece 100644
> > > > --- a/include/sysemu/numa.h
> > > > +++ b/include/sysemu/numa.h
> > > > @@ -35,4 +35,5 @@ void numa_legacy_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
> > > >                                   int nb_nodes, ram_addr_t size);
> > > >  void numa_default_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
> > > >                                    int nb_nodes, ram_addr_t size);
> > > > +void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **errp);    
> > > 
> > > I understand an explicitly call to numa_cpu_pre_plug() is needed
> > > on spapr_core_pre_plug() because it is not handling a TYPE_CPU
> > > object. But why not adding a numa_cpu_pre_plug() call to
> > > cpu_common_realizefn(), so the explicit calls in machvirt_init()
> > > and pc_cpu_pre_plug() are not necessary?  
> > 1. of the reasons is not to pollute all cpus with numa code  
> 
> I understand this goal...
> 
> >   
> > > Adding the code to cpu_common_realizefn() would also ensure
> > > CPUState::node_id is set consistently, even if hotplug was not
> > > done at thread level.  
> > 2. not all CPUs have node-id property  
> 
> ...and this. But: we already have the CPUState::numa_node field.
> If we don't handle it in common code, we risk leaving the field
> uninitialized, which is a problem if other code tries to use the
> field for something.
> 
> Maybe that's an argument for removing the CPUState::numa_node
> field too.
> 
> 
> > 3. call site of thread_realize() in encapsulating object (spapr_core)
> >    might be somewhere in the middle of parent's realize and likely
> >    failure would need proper parent state rollback/cleanup.  
> 
> I don't see why this could be a problem, if the code setting
> realized=true is already supposed to handle errors on the realize
> method.
> 
> > 4. and finely it's not cpu's responsibility to assign/check
> >    node-id property. It's machine's job that owns/manages topology
> >    layout. It' the same like with socket/core/thread properties.
> >    So for the sake of small optimization, I'm not really willing
> >    to violate that.  
> 
> I don't disagree with that, but in that case I would like to
> remove the CPUState::numa_node field soon, if possible.
ok, I'll try add a patch on respin to do it (I think that I've
tried this at some RFC time)
