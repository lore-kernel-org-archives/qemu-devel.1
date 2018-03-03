Received: from eggs.gnu.org ([2001:4830:134:3::10]:60509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1ervH3-00051z-DN
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 19:43:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1ervH0-000660-9E
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 19:43:41 -0500
Received: from mga05.intel.com ([192.55.52.43]:27958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1ervH0-00065F-0a
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 19:43:38 -0500
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Sat, 3 Mar 2018 00:43:31 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D1910274D1@SHSMSX101.ccr.corp.intel.com>
References: <20180228195504.25283.45666.stgit@gimli.home>
	<AADFC41AFE54684AB9EE6CBC0274A5D19102545C@SHSMSX101.ccr.corp.intel.com>
	<20180302110257.36cc0ed3@t450s.home>
In-Reply-To: <20180302110257.36cc0ed3@t450s.home>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/3] vfio/pci: ioeventfd support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peterx@redhat.com" <peterx@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>

> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Saturday, March 3, 2018 2:03 AM
>=20
> On Fri, 2 Mar 2018 07:08:51 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
>=20
> > > From: Alex Williamson
> > > Sent: Thursday, March 1, 2018 4:15 AM
> > >
> > > A vfio ioeventfd will perform the pre-specified device write on
> > > triggering of an eventfd.  When coupled with KVM ioeventfds, this
> > > feature allows a VM to trap a device page for virtualization, while
> > > also registering targeted ioeventfds to maintain performance of high
> > > frequency register writes within the trapped range.  Much like the
> > > existing interrupt eventfd/irqfd coupling, such writes can be handled
> > > entirely in the host kernel.
> > >
> > > The new VFIO device ioctl may be supported by any vfio bus driver,
> > > including mdev drivers, but the implementation here only enables
> > > vfio-pci.  This is intended as an acceleration path, bus drivers
> > > may choose which regions to support and userspace should always
> > > intend to fall back to non-accelerated handling when unavailable.
> > >
> >
> > it's a nice feature! A curious question. Is it possible for mdev driver
> > to directly create ioeventfd on specified offset? Currently ioeventfd
> > requires quirks in Qemu, which must know the device detail to
> > create ioeventfd and then connect vfio and kvm together. However
> > mdev instance is more software defined thus I'm not sure whether
> > asking Qemu to catch up quirk with underlying software logic could
> > be overwhelmed. Also in case of vendor driver emulating mdev
> > with same DID/VID as a real device, it might be difficult for Qemu
> > to figure out whether a vfio device is a real one or mdev one to
> > apply a mdev specific quirk. On the other hand, since vendor
> > driver knows all the logic constructing mdev, it would be more
> > convenient allowing vendor driver to directly create/destroy
> > ioeventfd on its demand?
>=20
> Are file descriptors the right interface between kernel components if
> userspace is not involved in connecting them?  Seems like not.  vfio is
> designed to be independent of KVM with the necessary interactions
> between them orchestrated by userspace.  KVMGT is about the only
> exception to that and TBH I'm not thrilled about extending that
> further.  Thanks,
>=20

why do you think KVMGT is the only exception? Isn't above scenario
general enough to any mdev implementation, just as what you're
trying to solve, that if a trapped operation happens too frequently on
mdev then we may want to optimize it? I understand fd is not a good=20
way in-between kernel components, just asking here in case you
have some good idea in mind. If adding mdev specific quirk in=20
Qemu is the only way for similar optimization, I'm fine with it. One
thing which I was not sure though is still about the scenario where=20
mdev is constructed same as a real device then what would happen
if Qemu applies a mdev-specific quirk to both sides - of course=20
just a mental thinking, not sure whether it happens in real...

Thanks
Kevin
