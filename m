Received: from eggs.gnu.org ([2001:4830:134:3::10]:43840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dFJW3-0000Ph-8G
	for qemu-devel@nongnu.org; Mon, 29 May 2017 08:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dFJW1-0001Yg-Ol
	for qemu-devel@nongnu.org; Mon, 29 May 2017 08:11:19 -0400
Date: Mon, 29 May 2017 14:11:08 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170529141108.37bb0cd8@nial.brq.redhat.com>
In-Reply-To: <20170526145814.GE22043@thinpad.lan.raisama.net>
References: <1495550330-34087-1-git-send-email-imammedo@redhat.com>
	<1495550330-34087-5-git-send-email-imammedo@redhat.com>
	<20170523144854.GF32274@thinpad.lan.raisama.net>
	<20170523174403.26a69d7c@Igors-MacBook-Pro.local>
	<20170526145814.GE22043@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/5] numa: fallback to default NUMA node
 instead of node 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Andrew Jones <drjones@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Fri, 26 May 2017 11:58:14 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Tue, May 23, 2017 at 05:44:03PM +0200, Igor Mammedov wrote:
> > On Tue, 23 May 2017 11:48:54 -0300
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> >   
> > > On Tue, May 23, 2017 at 04:38:49PM +0200, Igor Mammedov wrote:  
> > > > Do the same as we did in commit
> > > >   (57924bcd8 numa: introduce machine callback for VCPU to node mapping)
> > > > but only for incomplete mapping usecase, falling back to board
> > > > provided default cpu to node mapping if user hasn't provided
> > > > mapping for CPU explicitly.
> > > > 
> > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> > > 
> > > This breaks migration compatibility, doesn't it? I understand
> > > this use case is not supported, but if are going to break stuff
> > > for people using incomplete mappings (by rejecting the
> > > configuration on a future release), I would prefer to break it
> > > only once.  
> > it's firmware change and we generally don't care nor maintain firmware compat stuff
> > the same as with above mentioned 
> >  (57924bcd8 numa: introduce machine callback for VCPU to node mapping)  
> 
> 
> We normally keep resulting NUMA topology compatible, even if NUMA
> information is implemented only by firmware.  See how we set
> MachineClass::numa_auto_assign_ram and
> MachineClass::numa_mem_align_shift in older machine-types, for
> example.
it's relative new and pure firmaware change wrt arm/i386,
but it might influence ABI for spapr, my guess is that's why
it was compat flags were introduced
(otherwise they shouldn't have been added).
So I wouldn't consider this precedent as policy change
wrt firmware changes.

 
> Sometimes we didn't keep compatibility, though (e.g. on commit
> fb43b73b92 "pc: fix default VCPU to NUMA node mapping").
and more
(27111931 acpi: provide _PXM method for CPU devices if QEMU is started numa enabled)
and this sometimes is more consistent with other firmware
changes that are not versioned and the general approach
(I don't see why numa is any more special that any other
subsystem).

> I wouldn't disagree with this change if we planned to support
> incomplete mappings forever.  But if we are going to remove
> support for incomplete mappings soon, I would prefer to break
> user expectations only once.
My take on why we can't remove incomplete mappings without
obsoleting them first is not because of firmware changes but
that it breaks wrong CLI (i.e. scripts with incomplete mapping
will fail to start guest). So it's not the same vs firmware
behavior change.

I'm agreeing to drop this patch just because I don't care much
about this particular fixup as it's small isolated part in one place
and doesn't affect the rest of the code.


> > >   
> > > > ---
> > > >  hw/core/machine.c | 3 ---
> > > >  1 file changed, 3 deletions(-)
> > > > 
> > > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > > index 964b75d..b8df15f 100644
> > > > --- a/hw/core/machine.c
> > > > +++ b/hw/core/machine.c
> > > > @@ -730,9 +730,6 @@ static void machine_numa_finish_init(MachineState *machine)
> > > >                  g_string_append_printf(s, "%sCPU %d [%s]",
> > > >                                         s->len ? ", " : "", i, cpu_str);
> > > >                  g_free(cpu_str);
> > > > -
> > > > -                /* non mapped cpus used to fallback to node 0 */
> > > > -                props.node_id = 0;
> > > >              }
> > > >  
> > > >              props.has_node_id = true;
> > > > -- 
> > > > 2.7.4
> > > >   
> > >   
> > 
> >   
> 
