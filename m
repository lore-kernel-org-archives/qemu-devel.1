Received: from eggs.gnu.org ([2001:4830:134:3::10]:52236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gPBUq-0001Nr-S3
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:15:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gPBUd-0000w5-2o
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:15:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gPBUa-0000oz-Ve
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:15:26 -0500
Date: Tue, 20 Nov 2018 14:14:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181120140251-mutt-send-email-mst@kernel.org>
References: <20181114233831.10374-1-ehabkost@redhat.com>
	<c1b4a0ee39dfddeb19f1be46710c10cbefd3f07a.camel@redhat.com>
	<20181116034551.GK3807@habkost.net>
	<20181119114105.4da89f2c.cohuck@redhat.com>
	<20181119125519-mutt-send-email-mst@kernel.org>
	<20181119193238.117c2f4e.cohuck@redhat.com>
	<20181119133434-mutt-send-email-mst@kernel.org>
	<20181119195638.49a9c21e.cohuck@redhat.com>
	<20181119140813-mutt-send-email-mst@kernel.org>
	<9bc6ced6b0491643775081b8f8437065684e9959.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bc6ced6b0491643775081b8f8437065684e9959.camel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2] virtio: Provide
 version-specific variants of virtio PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit@kernel.org>, Cleber Rosa <crosa@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jason Wang <jasowang@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, Laine Stump <laine@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Caio Carrara <ccarrara@redhat.com>

On Tue, Nov 20, 2018 at 01:27:05PM +0100, Andrea Bolognani wrote:
> On Mon, 2018-11-19 at 14:14 -0500, Michael S. Tsirkin wrote:
> > On Mon, Nov 19, 2018 at 07:56:38PM +0100, Cornelia Huck wrote:
> > > On Mon, 19 Nov 2018 13:42:58 -0500 "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > We have this assumption that if we force a choice then people will
> > > > choose the right thing but in practice they will do what we all do, play
> > > > with it until it kind of works and leave well alone afterwards.
> > > > That's at best - at worst give up and use an easier tool.
> > > 
> > > That implies that we (the developers) need to care and make sure that
> > > "model=virtio" gets them the best possible transport (i.e. on s390x,
> > > that would be ccw unless the user explicitly requests pci; I'm not sure
> > > what the situation with mmio is -- probably "use pci whenever
> > > possible"?) I think that's what libvirt already gives us today (I hope.)
> 
> The interface at the libvirt level is exactly "model=virtio", with
> that ultimately translating to virtio-*-pci or virtio-*-ccw or
> virtio-*-device or whatever else based on the architecture, machine
> type and other information about the guest.
> 
> > > What makes it messy on the pci side is that the "best option" actually
> > > depends on what kind of guest the user wants to run (if the guest is
> > > too old, you're stuck with transitional; if you want to reap the
> > > benefits of PCIe, you need non-transitional...)
> > 
> > Well it works now - connect it to a bus and it figures out whether it
> > should do transitional or not. You can force transitional in PCIe anyway
> > but then you are limited to about 15 devices - probably sufficient for
> > most people ...
> 
> That's not how it works, though: current virtio-*-pci devices will
> be transitional (and thus support older guest OS) or not based on
> the kind of slot you plug them into.
> 
> >From the management point of view that's problematic, because libvirt
> (which takes care of the virtual hardware, including assigning PCI
> addresses to devices) has no knowledge of the guest OS running on
> said hardware, and management apps (which know about the guest OS and
> can figure out its capabilities using libosinfo) don't want to be in
> the business of assigning PCI addresses themselves.
> 
> Having separate transitional and non-transitional variants solves the
> issue because now management apps can query libosinfo to figure out
> whether the guest OS supports non-transitional virtio devices, and
> based on that they can ask libvirt to use either the transitional or
> non-transitional variant; from that, libvirt will be able to choose
> the correct slot for the device.
> 
> None of the above quite works if we have a single variant that
> morphs based on the slot, as we have today.

So can we get an ack on the patchset then?

> -- 
> Andrea Bolognani / Red Hat / Virtualization
