Received: from eggs.gnu.org ([2001:4830:134:3::10]:36051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gOr9v-0006Oi-EQ
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 16:32:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gOr9r-0000AW-LU
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 16:32:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:22913)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gOr9p-000063-NL
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 16:32:39 -0500
Date: Mon, 19 Nov 2018 19:32:32 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181119213232.GE3807@habkost.net>
References: <20181114233831.10374-1-ehabkost@redhat.com>
	<c1b4a0ee39dfddeb19f1be46710c10cbefd3f07a.camel@redhat.com>
	<20181116034551.GK3807@habkost.net>
	<20181119114105.4da89f2c.cohuck@redhat.com>
	<20181119125519-mutt-send-email-mst@kernel.org>
	<20181119193238.117c2f4e.cohuck@redhat.com>
	<20181119133434-mutt-send-email-mst@kernel.org>
	<20181119195638.49a9c21e.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119195638.49a9c21e.cohuck@redhat.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit@kernel.org>, Cleber Rosa <crosa@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jason Wang <jasowang@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, Laine Stump <laine@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Caio Carrara <ccarrara@redhat.com>

On Mon, Nov 19, 2018 at 07:56:38PM +0100, Cornelia Huck wrote:
> On Mon, 19 Nov 2018 13:42:58 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Nov 19, 2018 at 07:32:38PM +0100, Cornelia Huck wrote:
> > > On Mon, 19 Nov 2018 13:07:59 -0500
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > > > And I strongly believe command line users really really do not want all
> > > > this mess. Even adding "pci" is the name confuses people (what are the
> > > > other options?). For command line model=virtio is pretty much perfect.  
> > > 
> > > I'd argue that it's problematic on platforms where you have different
> > > options for virtio transports. What does "model=virtio" mean? Always
> > > virtio-pci, if available? Or rather virtio-<transport>, with
> > > <transport> being the best option for the machine?  
> > 
> > Most people don't care, for them it's "whatever works".
> > 
> > We have this assumption that if we force a choice then people will
> > choose the right thing but in practice they will do what we all do, play
> > with it until it kind of works and leave well alone afterwards.
> > That's at best - at worst give up and use an easier tool.
> 
> That implies that we (the developers) need to care and make sure that
> "model=virtio" gets them the best possible transport (i.e. on s390x,
> that would be ccw unless the user explicitly requests pci; I'm not sure
> what the situation with mmio is -- probably "use pci whenever
> possible"?) I think that's what libvirt already gives us today (I hope.)
> 
> What makes it messy on the pci side is that the "best option" actually
> depends on what kind of guest the user wants to run (if the guest is
> too old, you're stuck with transitional; if you want to reap the
> benefits of PCIe, you need non-transitional...)

Yeah, sometimes we can't make everything work out of the box on
the default case.  But I think in this case we can make the QEMU
command-line a bit more usable if we just cover more recent OSes.

However, I wish this kind of usability magic didn't automatically
imposed us the burden of keeping guest ABI compatibility too.
Keeping ABI compatibility on the machine-friendly device types and
interfaces is already hard enough.

We already have aliases that automatically select a virtio device
type at qdev-monitor.c:qdev_alias_table[], and I don't know if
they are supposed to keep a stable guest ABI.

-- 
Eduardo
