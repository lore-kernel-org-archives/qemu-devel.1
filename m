Received: from eggs.gnu.org ([2001:4830:134:3::10]:54291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1fizB0-0006cL-Fr
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1fizAv-0004Te-Jk
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:36:46 -0400
Message-ID: <e642d9da57a167aeb5ae65566dd61317fcd37d2c.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 27 Jul 2018 18:08:46 +1000
In-Reply-To: <20180727053247.GK3694@umbus.fritz.box>
References: <20180628083633.12413-1-clg@kaod.org>
	<20180628083633.12413-2-clg@kaod.org>
	<20180718061230.GE2102@umbus.fritz.box>
	<f6500bf1-792b-aba5-9deb-adc3303eeee7@kaod.org>
	<20180727053247.GK3694@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] ppc/pnv: Add model for Power8 PHB3
 PCIe Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Andrea Bolognani <abologna@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, 2018-07-27 at 15:32 +1000, David Gibson wrote:
> 
> > > What is this pci bridge representing?  I know PCI-e PHBs typically
> > > have a pseudo P2P bridge right under them, but isn't that represnted
> > > by the root complex above?
> > 
> > This is the legacy pci bridge under the pcie bus.
> 
> Ah, ok.  Didn't realise there was a vanilla PCI bridge built in.

There isn't. That should probably be created by the machine.

> > Here is is the qdev hierarchy :
> > 
> >   dev: pnv-phb3, id ""
> >     index = 0 (0x0)
> >     chip-id = 0 (0x0)
> >     bus: phb3-root-bus
> >       type pnv-phb3-root-bus
> >       dev: pnv-phb3-rc, id ""
> >         power_controller_present = true
> >         chassis = 0 (0x0)
> >         slot = 1 (0x1)
> >         port = 0 (0x0)
> >         aer_log_max = 8 (0x8)
> >         addr = 00.0
> >         romfile = ""
> >         rombar = 1 (0x1)
> >         multifunction = false
> >         command_serr_enable = true
> >         x-pcie-lnksta-dllla = true
> >         x-pcie-extcap-init = true
> >         class PCI bridge, addr 00:00.0, pci id 1014:03dc (sub 0000:0000)
> >         bus: pcie.0
> >           type PCIE
> >           dev: pci-bridge, id ""
> >             chassis_nr = 128 (0x80)
> >             msi = "off"
> >             shpc = false
> >             addr = 00.0
> >             romfile = ""
> >             rombar = 1 (0x1)
> >             multifunction = false
> >             command_serr_enable = true
> >             x-pcie-lnksta-dllla = true
> >             x-pcie-extcap-init = true
> >             class PCI bridge, addr 00:00.0, pci id 1b36:0001 (sub 0000:0000)
> >             bus: pci.0
> >               type PCI
> > 
> > [ ... ]
> > 
> > >> +static const PropertyInfo pnv_phb3_phb_id_propinfo = {
> > >> +    .name = "irq",
> > >> +    .get = pnv_phb3_get_phb_id,
> > >> +    .set = pnv_phb3_set_phb_id,
> > >> +};
> > > 
> > > Can't you use a static DeviceProps style property for this, which is a
> > > bit simpler?
> > 
> > OK. We will address user creatable PHBs in some other way. Most
> > certainly in the realize routine like you suggested.
> > 
> > Thanks,
> > 
> > C. 
> > 
> 
