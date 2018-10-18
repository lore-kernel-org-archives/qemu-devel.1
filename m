Received: from eggs.gnu.org ([2001:4830:134:3::10]:53975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gD5Uk-0007IN-3Z
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 06:25:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gD5Ue-0005YN-Uw
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 06:25:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1gD5Ue-0005Ud-LL
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 06:25:28 -0400
Message-ID: <6f8d59b8ee2d92d73d2957b520bd8bac989fc796.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Thu, 18 Oct 2018 12:25:12 +0200
In-Reply-To: <20181017150137.GX31060@habkost.net>
References: <20181013025435.25785-1-ehabkost@redhat.com>
	<20181014173258-mutt-send-email-mst@kernel.org>
	<20181015181404.GQ31060@habkost.net> <20181016170236.GJ7995@redhat.com>
	<d8b9a6e6-c137-a553-8fe7-939edd2031b3@redhat.com>
	<048ea4797a31e3a584c36453e6cad10403462e55.camel@redhat.com>
	<20181017150137.GX31060@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Laine Stump <laine@redhat.com>, "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Fabian Deutsch <fdeutsch@redhat.com>

On Wed, 2018-10-17 at 12:01 -0300, Eduardo Habkost wrote:
> On Wed, Oct 17, 2018 at 12:43:02PM +0200, Andrea Bolognani wrote:
> > The proposal doesn't directly address the interaction between virtio
> > protocol version and slot type. [...]
> 
> It does.  See the interface names added to each device type.

Sorry, I might be blind but I'm still not seeing it... I see a bunch
of *-pci devices and exactly zero *-pcie devices. See below.

[...]
> The difference between the devices is not just the bus type: it
> is a different type of device with different behavior.  Using the
> bus type to differentiate them would be misleading.

I'm not arguing that we should use the bus type *only* to
differentiate them, but rather that we should *also* differentiate
them by bus type; failing to do so will mean that...

> e.g. both modern and transitional virtio devices can be plugged
> to Conventional PCI buses, but they have different PCI IDs.

... even people who should be very familiar with the topic by now,
like you and me, will get it wrong from time to time, as Michael
helpfully pointed out ;)

> I'm considering doing this in v2:
> 
> * Remove the -0.9 device type, because nobody seems to need it
> * Add two device types:
>   * virtio-1-blk-pci-non-transitional
>   * virtio-1-blk-pci-transitional
> 
> This way, we:
> * Include only the major version of the spec (so
>   we don't require new device types for virtio 1.1, 1.2, etc),
> * Use terms that come from the Virtio spec itself, to avoid
>   ambiguity.

That's quite a mouthful :)

Anyway, whether a device or not is transitional should go next to
the spec version rather than at the end: this will also help with
consistency because we will need -device and -ccw variants of all
these, no?

Can we assume if and when virtio 2.0 comes around it will also have
both a pure variant and a transitional one which is compatible with
virtio 1.0? If so, I would suggest the names should be

  virtio-1-blk-pcie               (1.x only,     PCIe slot)
  virtio-1-transitional-blk-pci   (transitional, PCI  slot)
  virtio-1-transitional-blk-pcie  (transitional, PCIe slot)

[...]
> > At the same time, we should not fool ourselves into thinking it will
> > take less than *years* before applications such as virt-manager can
> > actually take advantage of the new devices without compromising their
> > support for old libvirt and QEMU versions too much.
> > 
> > So if we're doing this to rectify some questionable design choices
> > with the goal of having a better situation in the long run, then by
> > all means we should go ahead; but if we think this will allow us to
> > run RHEL 6 on q35 in the short term, then our efforts are probably
> > misguided.
> 
> Good point.  You might be right about oVirt and OpenStack, but
> I'm assuming at least some applications (maybe KubeVirt?) don't
> care about supporting old libvirt/QEMU versions and won't have
> that problem.

AFAIK oVirt and OpenStack have been bumping their requirements quite
aggressively with each subsequent release, so it might not take them
that much time to catch up; I was thinking more about applications
like virt-manager, gnome-boxes and libguestfs, which historically
have maintained compatibility with old libvirt/QEMU releases for the
longest time.

-- 
Andrea Bolognani / Red Hat / Virtualization
