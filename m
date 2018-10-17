Received: from eggs.gnu.org ([2001:4830:134:3::10]:44731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gCnoS-00084Z-Qt
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 11:32:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gCnoO-00036T-CQ
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 11:32:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gCnoO-00031w-3d
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 11:32:40 -0400
Date: Wed, 17 Oct 2018 11:32:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181017112522-mutt-send-email-mst@kernel.org>
References: <20181013025435.25785-1-ehabkost@redhat.com>
	<20181017092237.GD22755@stefanha-x1.localdomain>
	<20181017151004.GY31060@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017151004.GY31060@habkost.net>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Caio Carrara <ccarrara@redhat.com>, Markus Armbruster <armbru@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>, Laine Stump <laine@redhat.com>, Cleber Rosa <crosa@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>

On Wed, Oct 17, 2018 at 12:10:04PM -0300, Eduardo Habkost wrote:
> On Wed, Oct 17, 2018 at 10:22:37AM +0100, Stefan Hajnoczi wrote:
> > On Fri, Oct 12, 2018 at 11:54:35PM -0300, Eduardo Habkost wrote:
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
> > If new device types are being created, is it time to decouple the VIRTIO
> > PCI transport from the actual VIRTIO device (blk, net, scsi) like we
> > already have with virtio-mmio?
> > 
> >   -device virtio-pci-1.0,id=virtio-pci-0
> >   -device virtio-blk,bus=virtio-pci-0,drive=drive0,serial=mydisk
> > 
> > That way we avoid lots of boilerplate code and an explosion of new
> > device types.
> 
> I don't think that would work.  This would in turn make
> virtio-pci-1.0 a chameleon device that changes PCI ID depending
> on the backend device plugged to it.
> 
> Also, PCI IDs are not the only information contained inside the
> virtio-pci subclasses.  See all the PCI-specific +
> device-type-specific knowledge encoded inside the class_init and
> instance_init functions of each virtio-pci subclass.

I think we need to draw the line somewhere. We can't make new
classes and bother users each time there is a behaviour
change in the device.

But I also think the transport/device split it also an internal virtio
thing, no one who has not read the spec cares about it.

> -- 
> Eduardo
