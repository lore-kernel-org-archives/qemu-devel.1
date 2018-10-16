Received: from eggs.gnu.org ([2001:4830:134:3::10]:47223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gCSke-0003q0-Us
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:03:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gCSkP-0002IO-BH
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:03:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gCSkP-0002F6-1V
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:03:09 -0400
Date: Tue, 16 Oct 2018 18:02:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181016170236.GJ7995@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181013025435.25785-1-ehabkost@redhat.com>
	<20181014173258-mutt-send-email-mst@kernel.org>
	<20181015181404.GQ31060@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181015181404.GQ31060@habkost.net>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laine Stump <laine@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>, Fabian Deutsch <fdeutsch@redhat.com>

On Mon, Oct 15, 2018 at 03:14:04PM -0300, Eduardo Habkost wrote:
> On Sun, Oct 14, 2018 at 05:35:12PM -0400, Michael S. Tsirkin wrote:
> > On Fri, Oct 12, 2018 at 11:54:35PM -0300, Eduardo Habkost wrote:
> > > The current virtio-*-pci device types actually represent 3
> > > different types of devices:
> > > * virtio 1.0 non-transitional devices
> > > * virtio 1.0 transitional devices
> > > * virtio 0.9 ("legacy device" in virtio 1.0 terminology)
> > > 
> > > That would be just an annoyance if it didn't break our device/bus
> > > compatibility QMP interfaces.  With this multi-purpose device
> > > type, there's no way to tell management software that
> > > transitional devices and legacy devices require a Conventional
> > > PCI bus.
> > > 
> > > The multi-purpose device types would also prevent us from telling
> > > management software what's the PCI vendor/device ID for them,
> > > because their PCI IDs change at runtime depending on the bus
> > > where they were is plugged.
> > > 
> > > This patch adds separate device types for each of those virtio
> > > device flavors:
> > > 
> > > - virtio-*-pci: the existing multi-purpose device types
> > >   - Configurable using `disable-legacy` and `disable-modern`
> > >     properties
> > >   - Legacy driver support is automatically enabled/disabled
> > >     depending on the bus where it is plugged
> > >   - Supports Conventional PCI and PCI Express buses
> > >     (but Conventional PCI is incompatible with
> > >     disable-legacy=off)
> > >   - Changes PCI vendor/device IDs at runtime
> > > - virtio-*-pci-0.9: legacy virtio device
> > >   - Supports Conventional PCI buses only, because
> > >     it has a PIO BAR
> > > - virtio-*-pci-1.0-transitional: virtio-1.0 device supporting legacy drivers
> > >   - Supports Conventional PCI buses only, because
> > >     it has a PIO BAR
> > > - virtio-*-pci-1.0: modern-only
> > >   - Supports both Conventional PCI and PCI Express buses
> > 
> > I would prefer a "modern" suffix since it will likely cover future
> > revisions as well.
> 
> That's on purpose. The new device types don't cover future
> revisions, otherwise we'll have exactly the same ambiguity
> problems in the future.
> 
> The moment we have a new virtio specification released, a device
> type called "modern" will automatically become ambiguous.

Agreed, I don't want to see us back in the same mess, if a
virtio-2.0 ever gets released with non-backcompatible
changes.

How about using only the major digit in the device names eg

  'virtio-blk-0.x'
  'virtio-blk-1.x'

to make it clearer that we cover 1.0 and 1.1 (and 1.2, etc
by the same device.

This assumes that virtio authors are indeed using semantic
versioning where minor digit indicates backcompat changes
and major digit indicates breaking  compat changes. 


> > Besides, I don't have a problem with this but I'd like an
> > ack from someone on the management side, confirming
> > these new interfaces are actually going to be used.
> > 
> > Could you copy some relevant people as well pls?
> 
> CCing Andrea, Daniel, and Laine from the libvirt side.

I don't have a objection from libvirt side.

Last time, I suggested/discussed this I was not convinced that the benefit
was compelling enough to justify the  work across all levels in the stack.

Apps using the new device model names would either make themselves
incompatible with older libvirt/QEMU, or they would increase their
code complexity & testing matrix by having to support both old & new
names. The usage would also harm migration to older hosts.

This just to be able to switch from i440fx to q35 for OS which don't
support virtio-1.0, but for such old OS, q35 isn't offering any
compelling features, so they might as well stick with the thing that
is known to work well.

If QEMU supports this, we'd support it in libvirt, but my recommendation
to apps would still likely be to not use it and simply stick with i440fx
for such older OS.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
