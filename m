Received: from eggs.gnu.org ([2001:4830:134:3::10]:44330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dcSZU-0000zH-5m
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 04:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dcSZP-000848-Mk
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 04:30:32 -0400
Date: Tue, 1 Aug 2017 10:30:24 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170801083024.GZ4859@toto>
References: <1495537965-4187-1-git-send-email-diana.craciun@nxp.com>
	<20170525011034-mutt-send-email-mst@kernel.org>
	<AM3PR04MB061619F6FDC53F7FD4C1DAE4FFF10@AM3PR04MB0616.eurprd04.prod.outlook.com>
	<20170706023845-mutt-send-email-mst@kernel.org>
	<AM3PR04MB0616507B6F0989360D582F37FFB20@AM3PR04MB0616.eurprd04.prod.outlook.com>
	<20170731170217-mutt-send-email-mst@kernel.org>
	<AM3PR04MB061656F255D688500AC8622BFFB20@AM3PR04MB0616.eurprd04.prod.outlook.com>
	<20170801045857-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170801045857-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 0/2] Add global device ID in
 virt machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Diana Madalina Craciun <diana.craciun@nxp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>, Mike Caraman <mike.caraman@nxp.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "marcel@redhat.com" <marcel@redhat.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, Laurentiu Tudor <laurentiu.tudor@nxp.com>

On Tue, Aug 01, 2017 at 05:05:42AM +0300, Michael S. Tsirkin wrote:
> On Mon, Jul 31, 2017 at 03:13:09PM +0000, Diana Madalina Craciun wrote:
> > On 07/31/2017 05:06 PM, Michael S. Tsirkin wrote:
> > > On Mon, Jul 31, 2017 at 01:22:45PM +0000, Diana Madalina Craciun wrote:
> > >>>> If we are to use a value of 0 for the constant in case of PCI devices,
> > >>>> what happens if we have multiple PCI controllers?
> > >>> I guess we'd use the PCI Segment number for that?
> > >>>
> > >>>
> > >> Yes, we can use the PCI segment for this scenario. But this would mean
> > >> different solutions for the same problem. The main problem is that we
> > >> can have multiple entities in the system that are using MSIs (for now
> > >> PCI and NXP non-PCI bus infrastructure
> > >> (https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flwn.net%2FArticles%2F635905%2F&data=01%7C01%7Cdiana.craciun%40nxp.com%7C6b0c6c879af64718a21908d4d81d534e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0&sdata=bpYMMqajWzgzdbdQgy%2FUYR7y%2BswyvwE%2BqFzs7wdIkkA%3D&reserved=0). I guess that we may have other
> > >> platform devices that are using MSIs in the future.
> > >>
> > >> Thanks,
> > >> Diana
> > >>
> > >>
> > > Don't have the time to explore NXP in depth, sorry - there's
> > > a lot of complexity there.
> > > Could you maybe stick some bits to specify bus type in there?
> > > It just looks very wrong to push low level things like this
> > > that users have no interest in up the stack.
> > >
> > Let's generalize the problem a little bit, the NXP details just does not
> > matter much. The problem we have is the following:
> > 
> > The GIC-ITS, the ARM MSI controller is using deviceIDs in order to remap
> > the interrupts. Each device which is expected to send MSIs has a
> > deviceID associated with it. These deviceIDs are configured into devices
> > by software/firmware. There is support in the device tree to specify the
> > correlation between requesterID and deviceID:
> > 
> > "msi-map: Maps a Requester ID to an MSI controller and associated
> >   msi-specifier data. The property is an arbitrary number of tuples of
> >   (rid-base,msi-controller,msi-base,length)"
> > (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pci/pci-msi.txt)
> > 
> > Our problem is that we have to allocate these deviceIDs in QEMU as well
> > and we have to ensure that they are unique. Currently, for PCI, the
> > assumption requesterID=deviceID is made which will no longer be true in
> > case other devices are added. So we need a way (preferable a general
> > one) to allocate these IDs to different devices in the system in a
> > consistent way which will ensure that two devices do not share the same ID.
> 
> My question would be, do other types of devices that are there
> right now have some kind of ID like the requester ID?
> If so I would say just use that, and set high bits in the device ID
> to specify the type (e.g. 00 for pci, etc).
> 
> 
> IMHO if possible that is preferable to pushing this up to users.
> 
> 
> > The reason I put this ID into the controller itself is because on real
> > hardware is actually programmed into the controller. It is needed (for
> > example) when the MSIs are sent.
> > 
> > Thanks,
> > 
> > Diana
> > 
> 
> IIUC what happens on real hardware is controller maps each requester ID
> (or presumably other source ID in the request) to the device ID,
> and the mapping is internal to controller.
> If you wanted a lot of flexibility then looks like you could pass this
> mapping to controllers, but is it really necessary?
> Why don't we build a mapping that's convenient for us?
> 

Hi,

I agree with you for boards that are defined by QEMU (like the ARM virt board).
We can pick a convenient scheme and avoid too much user interaction.

But when we model real SoCs, the IDs and the way bridges convert these IDs
needs to match real HW. Otherwise guest SW will not work unmodified.
To make this work, users should not need to be involved though, it's
the machine and SoC modules that should instantiate the necessary handling
of it, IMO.

Cheers,
Edgar
