Received: from eggs.gnu.org ([2001:4830:134:3::10]:51609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gMzmN-0008S0-EX
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 13:20:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gMzmJ-0001Yf-Gv
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 13:20:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gMzmJ-0001Vf-3J
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 13:20:39 -0500
Date: Wed, 14 Nov 2018 16:20:12 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181114182012.GE15086@habkost.net>
References: <20181013025435.25785-1-ehabkost@redhat.com>
	<20181014173258-mutt-send-email-mst@kernel.org>
	<20181015181404.GQ31060@habkost.net>
	<20181016170236.GJ7995@redhat.com>
	<d8b9a6e6-c137-a553-8fe7-939edd2031b3@redhat.com>
	<048ea4797a31e3a584c36453e6cad10403462e55.camel@redhat.com>
	<20181017150137.GX31060@habkost.net>
	<6f8d59b8ee2d92d73d2957b520bd8bac989fc796.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f8d59b8ee2d92d73d2957b520bd8bac989fc796.camel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: Provide version-specific variants
 of virtio PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Fabian Deutsch <fdeutsch@redhat.com>, qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>, Laine Stump <laine@redhat.com>, Cleber Rosa <crosa@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>

On Thu, Oct 18, 2018 at 12:25:12PM +0200, Andrea Bolognani wrote:
> On Wed, 2018-10-17 at 12:01 -0300, Eduardo Habkost wrote:
> > On Wed, Oct 17, 2018 at 12:43:02PM +0200, Andrea Bolognani wrote:
> > > The proposal doesn't directly address the interaction between virtio
> > > protocol version and slot type. [...]
> > 
> > It does.  See the interface names added to each device type.
> 
> Sorry, I might be blind but I'm still not seeing it... I see a bunch
> of *-pci devices and exactly zero *-pcie devices. See below.
> 
> [...]
> > The difference between the devices is not just the bus type: it
> > is a different type of device with different behavior.  Using the
> > bus type to differentiate them would be misleading.
> 
> I'm not arguing that we should use the bus type *only* to
> differentiate them, but rather that we should *also* differentiate
> them by bus type; failing to do so will mean that...
> 
> > e.g. both modern and transitional virtio devices can be plugged
> > to Conventional PCI buses, but they have different PCI IDs.
> 
> ... even people who should be very familiar with the topic by now,
> like you and me, will get it wrong from time to time, as Michael
> helpfully pointed out ;)
> 
> > I'm considering doing this in v2:
> > 
> > * Remove the -0.9 device type, because nobody seems to need it
> > * Add two device types:
> >   * virtio-1-blk-pci-non-transitional
> >   * virtio-1-blk-pci-transitional
> > 
> > This way, we:
> > * Include only the major version of the spec (so
> >   we don't require new device types for virtio 1.1, 1.2, etc),
> > * Use terms that come from the Virtio spec itself, to avoid
> >   ambiguity.
> 
> That's quite a mouthful :)
> 
> Anyway, whether a device or not is transitional should go next to
> the spec version rather than at the end: this will also help with
> consistency because we will need -device and -ccw variants of all
> these, no?

Answering this question: we won't need this on the other variants
they don't have the code that silently breaks compatibility with
legacy drivers depending on the bus it's plugged.  The device is
either always transitional or always non-transitional.

The root of the problem is in virtio-pci.  More precisely, it
begins at virtio_pci_realize():

    if (proxy->disable_legacy == ON_OFF_AUTO_AUTO) {
        proxy->disable_legacy = pcie_port ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
    }

combined with virtio_pci_device_plugged():

    if (legacy) {
        [...]
        pci_set_word(config + PCI_SUBSYSTEM_ID, virtio_bus_get_vdev_id(bus));
    } else {
        pci_set_word(config + PCI_VENDOR_ID,
                     PCI_VENDOR_ID_REDHAT_QUMRANET);
        pci_set_word(config + PCI_DEVICE_ID,
                     0x1040 + virtio_bus_get_vdev_id(bus));
        pci_config_set_revision(config, 1);
    }


> 
> Can we assume if and when virtio 2.0 comes around it will also have
> both a pure variant and a transitional one which is compatible with
> virtio 1.0? If so, I would suggest the names should be
> 
>   virtio-1-blk-pcie               (1.x only,     PCIe slot)
>   virtio-1-transitional-blk-pci   (transitional, PCI  slot)
>   virtio-1-transitional-blk-pcie  (transitional, PCIe slot)

I don't see any need to make separate transitional-pci and
transitional-pcie device types.  A -transitional device type that
supports both Conventional PCI and PCI Express will work and I
don't see any problem with that.

For reference, the next version of this patch will have 3 device
variants:

* virtio-blk-pci (existing device, for compatibility. Contains
  magic transitional/non-transitional logic depending on bus)
* virtio-blk-pci-transitional (1.x transitional, supports legacy
  drivers, Conventional PCI only)
* virtio-blk-pci-non-transitional (1.x non-transitional, no
  legacy driver support, supports both Conventional PCI and PCI
  Express)

-- 
Eduardo
