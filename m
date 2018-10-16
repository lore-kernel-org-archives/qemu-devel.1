Received: from eggs.gnu.org ([2001:4830:134:3::10]:33584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gCPSk-00072Q-6c
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:32:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gCPSh-0000pS-1Y
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:32:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gCPSg-0000m9-OV
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:32:38 -0400
Date: Tue, 16 Oct 2018 10:32:20 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181016133220.GP31060@habkost.net>
References: <20181013025435.25785-1-ehabkost@redhat.com>
	<20181014173258-mutt-send-email-mst@kernel.org>
	<20181015181404.GQ31060@habkost.net>
	<20181016103930.287d0c2a.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016103930.287d0c2a.cohuck@redhat.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Fabian Deutsch <fdeutsch@redhat.com>, Markus Armbruster <armbru@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>, Laine Stump <laine@redhat.com>, Cleber Rosa <crosa@redhat.com>, Andrea Bolognani <abologna@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>

On Tue, Oct 16, 2018 at 10:39:30AM +0200, Cornelia Huck wrote:
> On Mon, 15 Oct 2018 15:14:04 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Sun, Oct 14, 2018 at 05:35:12PM -0400, Michael S. Tsirkin wrote:
> > > On Fri, Oct 12, 2018 at 11:54:35PM -0300, Eduardo Habkost wrote:  
> > > > The current virtio-*-pci device types actually represent 3
> > > > different types of devices:
> > > > * virtio 1.0 non-transitional devices
> > > > * virtio 1.0 transitional devices
> > > > * virtio 0.9 ("legacy device" in virtio 1.0 terminology)
> > > > 
> > > > That would be just an annoyance if it didn't break our device/bus
> > > > compatibility QMP interfaces.  With this multi-purpose device
> > > > type, there's no way to tell management software that
> > > > transitional devices and legacy devices require a Conventional
> > > > PCI bus.
> > > > 
> > > > The multi-purpose device types would also prevent us from telling
> > > > management software what's the PCI vendor/device ID for them,
> > > > because their PCI IDs change at runtime depending on the bus
> > > > where they were is plugged.
> > > > 
> > > > This patch adds separate device types for each of those virtio
> > > > device flavors:
> > > > 
> > > > - virtio-*-pci: the existing multi-purpose device types
> > > >   - Configurable using `disable-legacy` and `disable-modern`
> > > >     properties
> > > >   - Legacy driver support is automatically enabled/disabled
> > > >     depending on the bus where it is plugged
> > > >   - Supports Conventional PCI and PCI Express buses
> > > >     (but Conventional PCI is incompatible with
> > > >     disable-legacy=off)
> > > >   - Changes PCI vendor/device IDs at runtime
> > > > - virtio-*-pci-0.9: legacy virtio device
> > > >   - Supports Conventional PCI buses only, because
> > > >     it has a PIO BAR
> > > > - virtio-*-pci-1.0-transitional: virtio-1.0 device supporting legacy drivers
> > > >   - Supports Conventional PCI buses only, because
> > > >     it has a PIO BAR
> > > > - virtio-*-pci-1.0: modern-only
> > > >   - Supports both Conventional PCI and PCI Express buses  
> > > 
> > > I would prefer a "modern" suffix since it will likely cover future
> > > revisions as well.  
> > 
> > That's on purpose. The new device types don't cover future
> > revisions, otherwise we'll have exactly the same ambiguity
> > problems in the future.
> > 
> > The moment we have a new virtio specification released, a device
> > type called "modern" will automatically become ambiguous.
> 
> I don't think that's a problem.
> 
> Most of the issues come from the major changes that virtio-pci did when
> moving to the 1.0 standard (like that PIO BAR, or the changed ids). The
> 1.0 standard allows for gradual enhancements and changes guarded by
> feature bits.
> 
> Consider the packed ring layout, which is one of the major changes for
> 1.1: It is completely guarded by feature bits, and it does not come
> with any changes down in the pci area. If we want to fence it off for
> compat machines, we need to fence off offering the bits (for _any_
> transport), which does not imply a new type of virtio-pci device.
> 
> There are other, pci-specific changes which are also guarded by feature
> bits and don't need a new device type.
> 
> Also, many of the enhancements of the virtio standard are likely to be
> new device types and new features for existing device types. None of
> that is pci specific.
> 
> So, what I'd propose is:
> - virtio-*-pci-standard: compliant with the virtio standard 1.0 or
>   later; no legacy fallback
> - virtio-*-pci-transitional: compliant with the virtio standard 1.0 or
>   later; fallback to legacy included, as specified by the standard
> (- virtio-*-pci-legacy: legacy devices, should we need that for compat
> reasons)
> 
> We could also use '-virtio-1' instead of '-standard', if we do a major
> break with a 2.x standard (I don't see it yet). But having a new type
> for 1.1 sounds wrong.

That's true: adding a new type for 1.1 is probably going to be
wrong.

But how can I make any promises about the existing device type
being compatible with 1.1 (or 1.2, 1.3...), if the 1.1 (or 1.2,
1.3...) specification wasn't released yet?

Maybe using "-virtio-1" would be a good way to be clear we're
talking about virtio-1.x without making any promises about 1.1,
1.2, 1.3, etc.


> 
> Also note that virtio-ccw does not need this (we managed to avoid many
> of the issues virtio-pci had due to being late to the party :). I'm not
> sure what virtio-mmio does, or if we even care.
> 

-- 
Eduardo
