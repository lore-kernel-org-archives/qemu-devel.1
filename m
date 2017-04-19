Received: from eggs.gnu.org ([2001:4830:134:3::10]:53194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0p43-0003zO-G1
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 08:50:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0p42-0000PS-NJ
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 08:50:31 -0400
Date: Wed, 19 Apr 2017 09:50:01 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170419125001.GU25239@thinpad.lan.raisama.net>
References: <20170418221724.5707-1-ehabkost@redhat.com>
	<20170418221724.5707-4-ehabkost@redhat.com>
	<CAFEAcA_Ky5SecogNFq3+RO8pX4sqxvsSbw0KihAv=8teqCSJbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_Ky5SecogNFq3+RO8pX4sqxvsSbw0KihAv=8teqCSJbw@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC v2 3/6] pci: Rename and change signatures of
 pci_bus_new() & related functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <dgibson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Paul Burton <paul.burton@imgtec.com>, Richard Henderson <rth@twiddle.net>, Scott Wood <scottwood@freescale.com>, Yongbok Kim <yongbok.kim@imgtec.com>, qemu-arm <qemu-arm@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On Wed, Apr 19, 2017 at 09:41:42AM +0100, Peter Maydell wrote:
> On 18 April 2017 at 23:17, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > pci_bus_new*() and pci_register_bus() work only when the 'parent'
> > argument is a PCI_HOST_BRIDGE object. Rename them to reflect that they
> > are meant to initialize a bus that's in a PCI host bridge.
> >
> > The new function names are:
> > * pci_host_bus_init() (replacing pci_bus_new())
> > * pci_host_bus_init_inplace() (replacing pci_bus_new_inplace())
> > * pci_host_bus_init_irqs() (replacing pci_register_bus())
> 
> This is moving these functions away from the convention that
> we seem to mostly follow for buses (eg ISA, SCSI) of
> foo_bus_new() to allocate and return a new bus, and
> foo_bus_new_inplace() to initialize a bus that's inline in
> some other struct.
> 
> I'm not sure this is a good idea unless we have a plan to
> convert all the other QOM buses and document that this is
> the right way to implement init for a bus.

The point of the rename is that those functions are doing more
than just allocating a PCIBus. They do some initialization of
PCIHostState as well. That's why non-root PCI buses can't be
created by pci_bus_new*() today.

Maybe the answer here is to move the PCI_HOST_BRIDGE-specific
code somewhere else, and make pci_bus_new*() more generic. This
would allow us to reuse pci_bus_new*() when creating non-root PCI
buses, later.

-- 
Eduardo
