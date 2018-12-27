Received: from eggs.gnu.org ([208.118.235.92]:38249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gccLO-0001QF-W9
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 15:33:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gccLK-0007Hq-2B
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 15:33:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gccLJ-0007AP-Bz
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 15:33:22 -0500
Date: Thu, 27 Dec 2018 18:33:12 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181227203312.GB19442@habkost.net>
References: <20181224115235.16881-1-wainersm@redhat.com>
	<20181224115235.16881-2-wainersm@redhat.com>
	<20181225052005.GB12850@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181225052005.GB12850@xz-x1>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] hw/core: add qom getter for
 kernel-irqchip property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org, marcel.apfelbaum@gmail.com, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Dec 25, 2018 at 01:20:05PM +0800, Peter Xu wrote:
> On Mon, Dec 24, 2018 at 06:52:35AM -0500, Wainer dos Santos Moschetta wrote:
> > Allows to access the kernel-irqchip property of a Machine
> > Class object via QOM get method.
> > 
> > Before this patch the property cannot be read although it is
> > listed by qom-list:
> > 
> > qemu-system-x86_64 -M q35,accel=kvm,kernel-irqchip=split (...)
> > -> {"execute": "qom-list", "arguments": {"path": "/machine"}}
> > <- {"return": [{"name": "type", "type": "string"}, (...) , {"name": "kernel-irqchip", "type": "on|off|split"} (...)}
> > -> {"execute": "qom-get", "arguments": {"path": "/machine", "property": "kernel-irqchip"}}
> > <- {"error": {"class": "GenericError", "desc": "Insufficient permission to perform this operation"}}
> > 
> > It is implemented the machine_get_kernel_irqchip() method,
> > which evaluates the kernel_irqchip_allowed, *_required, and
> > *_split fields to determine the value of kernel-irqchip. Note: we
> > assume there is not inconsistency on the value of those fields.
> > 
> > Then with this change in place, it works as expected:
> > 
> > qemu-system-x86_64 -M q35,accel=kvm,kernel-irqchip=split (...)
> > -> {"execute": "qom-get", "arguments": {"path": "/machine", "property": "kernel-irqchip"}}
> > <- {"return": "split"}
> > 
> > Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> > ---
> >  hw/core/machine.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index c51423b647..f61003f8f2 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -37,6 +37,21 @@ static void machine_set_accel(Object *obj, const char *value, Error **errp)
> >      ms->accel = g_strdup(value);
> >  }
> >  
> > +static void machine_get_kernel_irqchip(Object *obj, Visitor *v,
> > +                                       const char *name, void *opaque,
> > +                                       Error **errp)
> > +{
> > +    MachineState *ms = MACHINE(obj);
> > +    OnOffSplit mode;
> > +
> > +    if (ms->kernel_irqchip_split) {
> > +        mode = ON_OFF_SPLIT_SPLIT;
> > +    } else {
> > +        mode = (ms->kernel_irqchip_allowed && ms->kernel_irqchip_required) ?
> > +                ON_OFF_SPLIT_ON : ON_OFF_SPLIT_OFF;
> 
> Hi, Wainer,
> 
> The new interface seems to be a good thing, though the implementation
> might be incorrect here.  AFAIU these parameters only decide "how we
> want to choose the kernel-irqchip parameter" rather than the real
> result, which could depend on more (e.g., whether KVM is used).
> 
> IMHO you should simply fetch the results from kvm_irqchip_in_kernel()
> and kvm_irqchip_is_split() where the real results are stored.

Agreed.  Knowing the actual values of kvm_irqchip_*() would be
even more useful for test code (this way we would be testing all
the KVM irqchip initialization code, not just a few lines of
property getter/seter code).

-- 
Eduardo
