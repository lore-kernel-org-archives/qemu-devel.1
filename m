Received: from eggs.gnu.org ([2001:4830:134:3::10]:51597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dk57T-0003KY-PN
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 05:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dk57N-0007VV-Sw
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 05:05:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dk57N-0007Um-Lg
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 05:05:01 -0400
Date: Tue, 22 Aug 2017 11:04:54 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170822110454.200ff0ed.cohuck@redhat.com>
In-Reply-To: <cb66ce20-c407-2462-0e51-8d6751af9f7b@linux.vnet.ibm.com>
References: <20170821091614.28251-1-cohuck@redhat.com>
	<20170821091614.28251-3-cohuck@redhat.com>
	<cb66ce20-c407-2462-0e51-8d6751af9f7b@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 02/10] kvm: remove hard dependency on pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, zyimin@linux.vnet.ibm.com, david@redhat.com, agraf@suse.de, borntraeger@de.ibm.com

On Mon, 21 Aug 2017 18:02:12 +0200
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> On 21/08/2017 11:16, Cornelia Huck wrote:
> > The msi routing code in kvm calls some pci functions: provide
> > some stubs to enable builds without pci.
> > 
> > Also, to make this more obvious, guard them via a pci_available boolean
> > (which also can be reused in other places).
> > 
> > Fixes: e1d4fb2de ("kvm-irqchip: x86: add msi route notify fn")
> > Fixes: 767a554a0 ("kvm-all: Pass requester ID to MSI routing functions")
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >   accel/kvm/kvm-all.c  |  6 +++---
> >   hw/pci/pci-stub.c    | 15 +++++++++++++++
> >   hw/pci/pci.c         |  2 ++
> >   include/hw/pci/pci.h |  2 ++
> >   4 files changed, 22 insertions(+), 3 deletions(-)
> > 
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > index 46ce479dc3..f85553a851 100644
> > --- a/accel/kvm/kvm-all.c
> > +++ b/accel/kvm/kvm-all.c
> > @@ -1248,7 +1248,7 @@ int kvm_irqchip_add_msi_route(KVMState *s, int vector, PCIDevice *dev)
> >       int virq;
> >       MSIMessage msg = {0, 0};
> > 
> > -    if (dev) {
> > +    if (pci_available && dev) {
> >           msg = pci_get_msi_message(dev, vector);
> >       }  
> 
> Hi Conny,
> 
> I did not find a case where pci_available is false and dev is true.
> but anyway, sure is sure.

It makes things more obvious, I think.

> > diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
> > index ecad664946..ace43821ca 100644
> > --- a/hw/pci/pci-stub.c
> > +++ b/hw/pci/pci-stub.c
> > @@ -23,10 +23,12 @@
> >   #include "monitor/monitor.h"
> >   #include "qapi/qmp/qerror.h"
> >   #include "hw/pci/pci.h"
> > +#include "hw/pci/msi.h"  
> 
> I think you forgot that...
> 
> >   #include "qmp-commands.h"
> >   #include "hw/pci/msi.h"  
> 
> ...you already have it included here. Didn't you ?

Hum, once should really be enough.

> otherwise LGTM

Thanks. Can I translate that into a tag? :)
