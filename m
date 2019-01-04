Received: from eggs.gnu.org ([208.118.235.92]:59578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gfKq0-0003JZ-PS
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 03:28:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gfKpw-0005By-Nv
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 03:28:16 -0500
Date: Fri, 4 Jan 2019 09:27:34 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190104092734.0c280c61.cohuck@redhat.com>
In-Reply-To: <20190103232454-mutt-send-email-mst@kernel.org>
References: <20181205195704.17605-1-ehabkost@redhat.com>
	<20181205195704.17605-3-ehabkost@redhat.com>
	<a28d196a-e2fe-a013-a6e2-99ac260f6279@redhat.com>
	<6d25cdc7-60f9-a0e0-b3be-d78da86752b5@redhat.com>
	<20190103114837.66429dbb.cohuck@redhat.com>
	<20190103183206.GA4157@habkost.net>
	<20190103232454-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v4 2/2] virtio: Provide
 version-specific variants of virtio PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Amit Shah <amit@kernel.org>, qemu-s390x@nongnu.org, Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>, Andrea Bolognani <abologna@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Max Reitz <mreitz@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Laine Stump <laine@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>

On Thu, 3 Jan 2019 23:27:08 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Jan 03, 2019 at 04:32:06PM -0200, Eduardo Habkost wrote:
> > On Thu, Jan 03, 2019 at 11:48:37AM +0100, Cornelia Huck wrote:  
> > > On Thu, 3 Jan 2019 11:14:44 +0100
> > > Thomas Huth <thuth@redhat.com> wrote:
> > >   
> > > > On 2019-01-03 10:38, Thomas Huth wrote:  
> > > > > On 2018-12-05 20:57, Eduardo Habkost wrote:    
> > > > >> Many of the current virtio-*-pci device types actually represent
> > > > >> 3 different types of devices:
> > > > >> * virtio 1.0 non-transitional devices
> > > > >> * virtio 1.0 transitional devices
> > > > >> * virtio 0.9 ("legacy device" in virtio 1.0 terminology)
> > > > >>
> > > > >> That would be just an annoyance if it didn't break our device/bus
> > > > >> compatibility QMP interfaces.  With these multi-purpose device
> > > > >> types, there's no way to tell management software that
> > > > >> transitional devices and legacy devices require a Conventional
> > > > >> PCI bus.
> > > > >>
> > > > >> The multi-purpose device types would also prevent us from telling
> > > > >> management software what's the PCI vendor/device ID for them,
> > > > >> because their PCI IDs change at runtime depending on the bus
> > > > >> where they were plugged.
> > > > >>
> > > > >> This patch adds separate device types for each of those virtio
> > > > >> device flavors:
> > > > >>
> > > > >> - virtio-*-pci: the existing multi-purpose device types
> > > > >>   - Configurable using `disable-legacy` and `disable-modern`
> > > > >>     properties
> > > > >>   - Legacy driver support is automatically enabled/disabled
> > > > >>     depending on the bus where it is plugged
> > > > >>   - Supports Conventional PCI and PCI Express buses
> > > > >>     (but Conventional PCI is incompatible with
> > > > >>     disable-legacy=off)
> > > > >>   - Changes PCI vendor/device IDs at runtime
> > > > >> - virtio-*-pci-transitional: virtio-1.0 device supporting legacy drivers
> > > > >>   - Supports Conventional PCI buses only, because
> > > > >>     it has a PIO BAR
> > > > >> - virtio-*-pci-non-transitional: modern-only
> > > > >>   - Supports both Conventional PCI and PCI Express buses
> > > > >>
> > > > >> The existing TYPE_* macros for these types will point to an
> > > > >> abstract base type, so existing casts in the code will keep
> > > > >> working for all variants.
> > > > >>
> > > > >> A simple test script (tests/acceptance/virtio_version.py) is
> > > > >> included, to check if the new device types are equivalent to
> > > > >> using the `disable-legacy` and `disable-modern` options.
> > > > >>
> > > > >> Acked-by: Andrea Bolognani <abologna@redhat.com>
> > > > >> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> > > > >> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>    
> > > > > 
> > > > >  Hi Eduardo,
> > > > > 
> > > > > with these new devices, I can trigger an abort on s390x:
> > > > > 
> > > > > $ qemu-system-s390x -M s390-ccw-virtio-2.5 -monitor stdio -no-shutdown
> > > > > QEMU 3.1.50 monitor - type 'help' for more information
> > > > > (qemu) device_add vhost-scsi-pci-non-transitional
> > > > > qemu-system-s390x: hw/core/qdev-properties.c:1236:
> > > > > qdev_prop_set_globals: Assertion `prop->user_provided' failed.
> > > > > Aborted (core dumped)    
> > > > FWIW, it happens with x86, too:
> > > > 
> > > > $ qemu-system-x86_64 -M pc-i440fx-2.6 -monitor stdio
> > > > QEMU 3.1.50 monitor - type 'help' for more information
> > > > (qemu) device_add vhost-scsi-pci-non-transitional
> > > > qemu-system-x86_64: hw/core/qdev-properties.c:1236:
> > > > qdev_prop_set_globals: Assertion `prop->user_provided' failed.
> > > > Aborted (core dumped)
> > > > 
> > > > Only machine types newer than 2.7 seem to be OK.  
> > > 
> > > It also fails for vhost-scsi-pci-transitional on 2.6 and older machines.
> > > 
> > > The problem is that HW_COMPAT_2_6 tries to set the disable_modern
> > > property, which the version-specific variants of virtio-pci do not have.
> > > 
> > > Not sure how to fix this. The version-specific devices cannot really
> > > work on the compat machine.  
> > 
> > Oops.
> > 
> > My patch broke the assumption that every virtio-pci subclass is a
> > generic legacy/modern device.  The good news is that HW_COMPAT_2_6
> > needs to affect only devices that existed in QEMU
> > 2.6 (not every subclass of virtio-pci).
> > 
> > I see 3 possible ways to address this:
> > 
> > 1) Making disable-legacy and disable-modern available on all
> > virtio-pci subclasses again.
> > 
> > This is simple to implement, but I would like to avoid that.  I'd
> > prefer to keep the legacy/modern logic complexity restricted to
> > the old generic virtio devices.  
> 
> As it's only for compat, we can probably use an "x-" property.

I'm not sure that makes it much better, though.

> > 2) Creating a virtio-pci-generic or virtio-pci-hybrid interface
> > type, add it to generic_type_info at virtio_pci_types_register(),
> > and use it on HW_COMPAT_2_6 instead of "virtio-pci".
> > 
> > This is simple to implement, but I'm wary.  I'm already bothered
> > by the complexity of our PCI and virtio type hierarchies.  We
> > have multiple overlapping sets of virtio-pci devices (depending
> > which way you look), and specifying exactly which set we want to
> > affect is tricky.  

I think the various virtio-pci types are already confusing enough
without an extra interface type.

> I'm not sure I understand this one. Would this be required
> anyway if we added a new feature to both transitional and modern
> devices?

I thought new features would need to be added to the base class anyway?

> 
> > 
> > 3) Replacing "virtio-pci" on HW_COMPAT_2_6 with an explicit list
> > of concrete virtio-pci types that existed when QEMU 2.6 was
> > released.  This will make HW_COMPAT_2_6 grow, but reduce
> > complexity of the whole system.  I'm inclined to implement this
> > solution.

This solution looks best to me as well.
