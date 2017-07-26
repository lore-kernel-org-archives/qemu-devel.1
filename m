Received: from eggs.gnu.org ([2001:4830:134:3::10]:42916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1daHeM-0006zJ-OZ
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1daHeJ-0004XN-LP
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:26:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1daHeJ-0004Wv-Bo
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:26:31 -0400
Date: Wed, 26 Jul 2017 10:26:23 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170726102623.1d182c07@gondolin>
In-Reply-To: <f914a2ea-2958-406f-f68f-511027bc30be@redhat.com>
References: <20170725153330.14966-1-cohuck@redhat.com>
	<20170725153330.14966-2-cohuck@redhat.com>
	<f914a2ea-2958-406f-f68f-511027bc30be@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/9] kvm: remove hard dependency on pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com

On Wed, 26 Jul 2017 08:52:44 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 25.07.2017 17:33, Cornelia Huck wrote:
> > The msi routing code in kvm calls some pci functions: provide
> > some stubs to enable builds without pci.
> > 
> > Fixes: e1d4fb2de ("kvm-irqchip: x86: add msi route notify fn")
> > Fixes: 767a554a0 ("kvm-all: Pass requester ID to MSI routing functions")
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  hw/pci/pci-stub.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
> > index ecad664946..bc228ce91e 100644
> > --- a/hw/pci/pci-stub.c
> > +++ b/hw/pci/pci-stub.c
> > @@ -23,6 +23,7 @@
> >  #include "monitor/monitor.h"
> >  #include "qapi/qmp/qerror.h"
> >  #include "hw/pci/pci.h"
> > +#include "hw/pci/msi.h"
> >  #include "qmp-commands.h"
> >  #include "hw/pci/msi.h"
> >  
> > @@ -38,3 +39,14 @@ void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict)
> >  {
> >      monitor_printf(mon, "PCI devices not supported\n");
> >  }
> > +
> > +/* kvm-all wants this */
> > +MSIMessage pci_get_msi_message(PCIDevice *dev, int vector)
> > +{
> > +    assert(false);
> > +}
> > +
> > +uint16_t pci_requester_id(PCIDevice *dev)
> > +{
> > +    assert(false);
> > +}  
> 
> Since this missed the 2.10 freeze anyway and we've got some more time to
> discuss it: I still think it would be much cleaner to move the functions
> from kvm-all.c that use these PCI functions into a separate file
> kvm-pci.c instead and compile that only with CONFIG_PCI=y. That way we
> likely also could prevent that more dependencies on CONFIG_PCI creep
> into kvm-all.c again at later points in time.
> 
> I've now had a closer look, and it seems like the only affected
> functions are kvm_irqchip_add_msi_route() and
> kvm_irqchip_update_msi_route() ... and these seems only to be used in
> code we would not care about on s390x with CONFIG_PCI=n. So could you
> please have at least a try to move these two functions (and other
> related msi functions) to a new file kvm-pci.c instead to see whether
> that would work, too?

I can try, as this missed the 2.10 boat anyway.

The code contains some parts that are not relevant in all cases (msi
routes if we don't use pci, adapter routes for anything not
s390x, ...), but I don't think trying to rip this out would be much of
an improvement. I'll try the minimal (well, not quite as minimal as
this patch) route instead.
