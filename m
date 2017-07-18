Received: from eggs.gnu.org ([2001:4830:134:3::10]:51683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXUII-0003qW-0B
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:20:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXUIE-0006E5-TM
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:20:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dXUIE-0006Cv-Mv
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:20:10 -0400
Date: Tue, 18 Jul 2017 17:20:05 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170718172005.4f68c81c@gondolin>
In-Reply-To: <77385052-7626-acdc-fa2b-8085e15f778d@redhat.com>
References: <20170718142455.32676-1-cohuck@redhat.com>
	<20170718142455.32676-2-cohuck@redhat.com>
	<77385052-7626-acdc-fa2b-8085e15f778d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v2 1/9] kvm: remove hard dependency on
 pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com

On Tue, 18 Jul 2017 17:00:22 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 18.07.2017 16:24, Cornelia Huck wrote:
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
> >   
> 
> Would it be feasible to move the offending code from kvm-all.c into a
> new file called kvm-pci.c instead which then only gets compiled for
> CONFIG_PCI=y ? I think that would be a cleaner solution ...

msi(x) seems to have gotten a bit entangled with the kvm code (maybe
even before the two commits I mentioned above - but it must have worked
fine before we added zpci...) I'd rather just use this quick fix for
now and do a proper separation on top.
