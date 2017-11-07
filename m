Received: from eggs.gnu.org ([2001:4830:134:3::10]:34014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eC5QG-00056P-8L
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:04:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eC5QC-0006WI-8z
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:04:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eC5QC-0006W2-0P
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:04:12 -0500
Date: Tue, 7 Nov 2017 16:04:04 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171107160404.40e368da.cohuck@redhat.com>
In-Reply-To: <20171106180216.GT3111@localhost.localdomain>
References: <1508170976-96869-4-git-send-email-imammedo@redhat.com>
	<1508325132-70513-1-git-send-email-imammedo@redhat.com>
	<20171019063151.GA13245@umbus>
	<20171031150114.60e0958e@nial.brq.redhat.com>
	<20171106180216.GT3111@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 3/6] possible_cpus: add CPUArchId::type
 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, peter.maydell@linaro.org, pkrempa@redhat.com, pbonzini@redhat.com, drjones@redhat.com

On Mon, 6 Nov 2017 16:02:16 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Tue, Oct 31, 2017 at 03:01:14PM +0100, Igor Mammedov wrote:
> > On Thu, 19 Oct 2017 17:31:51 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >   
> > > On Wed, Oct 18, 2017 at 01:12:12PM +0200, Igor Mammedov wrote:  
> > > > For enabling early cpu to numa node configuration at runtime
> > > > qmp_query_hotpluggable_cpus() should provide a list of available
> > > > cpu slots at early stage, before machine_init() is called and
> > > > the 1st cpu is created, so that mgmt might be able to call it
> > > > and use output to set numa mapping.
> > > > Use MachineClass::possible_cpu_arch_ids() callback to set
> > > > cpu type info, along with the rest of possible cpu properties,
> > > > to let machine define which cpu type* will be used.
> > > > 
> > > > * for SPAPR it will be a spapr core type and for ARM/s390x/x86
> > > >   a respective descendant of CPUClass.
> > > > 
> > > > Move parse_numa_opts() in vl.c after cpu_model is parsed into
> > > > cpu_type so that possible_cpu_arch_ids() would know which
> > > > cpu_type to use during layout initialization.
> > > > 
> > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>    
> > > 
> > > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> > >   
> > > > ---
> > > >   v2:
> > > >      - fix NULL dereference caused by not initialized
> > > >        MachineState::cpu_type at the time parse_numa_opts()
> > > >        were called
> > > > ---
> > > >  include/hw/boards.h        |  2 ++
> > > >  hw/arm/virt.c              |  3 ++-
> > > >  hw/core/machine.c          | 12 ++++++------
> > > >  hw/i386/pc.c               |  4 +++-
> > > >  hw/ppc/spapr.c             | 13 ++++++++-----
> > > >  hw/s390x/s390-virtio-ccw.c |  1 +
> > > >  vl.c                       |  3 +--
> > > >  7 files changed, 23 insertions(+), 15 deletions(-)
> > > > 
> > > > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > > > index 191a5b3..fa21758 100644
> > > > --- a/include/hw/boards.h
> > > > +++ b/include/hw/boards.h
> > > > @@ -80,6 +80,7 @@ void machine_set_cpu_numa_node(MachineState *machine,
> > > >   * CPUArchId:
> > > >   * @arch_id - architecture-dependent CPU ID of present or possible CPU    
> > > 
> > > I know this isn't really in scope for this patch, but is @arch_id here
> > > supposed to have meaning defined by the target, or by the machine?
> > > 
> > > If it's the machime, it could do with a rename - "arch" means target
> > > to most people (thanks to Linux).
> > > 
> > > If it's the target, it's kind of bogus, because it doesn't necessarily
> > > have a clear meaning per target - get_arch_id in CPUClass has the same
> > > problem, which is probably one reason it's basically only used by the
> > > x86 code at present.
> > > 
> > > e.g. for target/ppc, what do we use?  There's the PIR, which is in the
> > > CPU.. but only on some cpu models, not all.  There will generally be
> > > some kind of master PIC id, but there are different PIC models on
> > > different boards.  What goes in the devicetree?  Well only some
> > > machines use devicetree, and they might define the cpu reg 
> > > differently.
> > > 
> > > Board designs will generally try to make some if not all of those
> > > possible values equal for simplicity, but there's still no real way of
> > > defining a sensible arch_id independent of machine / board.  
> > I'd say arch_id is machine specific so far, it was introduced when we
> > didn't have CpuInstanceProperties and at that time we considered only
> > vcpus (threads) and doesn't really apply to spapr cores.
> > 
> > In general we could do away with arch_id and use CpuInstanceProperties
> > instead, but arch_id also serves aux purpose, it allows machine to
> > pre-calculate(cache) apic-id/mpidr values in one place and then they
> > are/(could be) used by arch in-depended code to build acpi tables.
> > So if we drop arch_id we would need to introduce a machine hook,
> > which would translate CpuInstanceProperties into current arch_id.  
> 
> I think we need to do a better to job documenting where exactly
> we expect arch_id to be used and how, so people know what it's
> supposed to return.
> 
> If the only place where it's useful now is ACPI code (is it?),
> should we rename it to something like get_acpi_id()?

It is also used in hw/s390x/sclp.c to fill out a control block, so acpi
isn't the only user.
