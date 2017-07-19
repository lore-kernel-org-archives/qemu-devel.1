Received: from eggs.gnu.org ([2001:4830:134:3::10]:50318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1dXtYr-0002P9-Pg
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 14:19:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1dXtYo-0001dk-Lg
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 14:19:01 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:17717)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <konrad.wilk@oracle.com>)
	id 1dXtYo-0001dW-Bt
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 14:18:58 -0400
Date: Wed, 19 Jul 2017 14:18:53 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-ID: <20170719181853.GC13096@char.us.oracle.com>
References: <1500470414-7911-1-git-send-email-zuban32s@gmail.com>
	<20170719135726.GG5722@char.us.oracle.com>
	<CAKSfGUDgtN+S=u_4S7-s1wUxt6fZtibLG+ZSX+qZ0d+9marXQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKSfGUDgtN+S=u_4S7-s1wUxt6fZtibLG+ZSX+qZ0d+9marXQQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] Allow RedHat PCI bridges reserve
 more buses than necessary during init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Bezzubikov <zuban32s@gmail.com>
Cc: marcel@redhat.com, qemu-devel@nongnu.org, seabios@seabios.org

On Wed, Jul 19, 2017 at 05:14:41PM +0000, Alexander Bezzubikov wrote:
> =D1=81=D1=80, 19 =D0=B8=D1=8E=D0=BB=D1=8F 2017 =D0=B3. =D0=B2 16:57, Ko=
nrad Rzeszutek Wilk <konrad.wilk@oracle.com>:
>=20
> > On Wed, Jul 19, 2017 at 04:20:12PM +0300, Aleksandr Bezzubikov wrote:
> > > Now PCI bridges (and PCIE root port too) get a bus range number in
> > system init,
> > > basing on currently plugged devices. That's why when one wants to
> > hotplug another bridge,
> > > it needs his child bus, which the parent is unable to provide.
> >
> > Could you explain how you trigger this?
>=20
>=20
> I'm trying to hot plug pcie-pci bridge into pcie root port, and Linux s=
ays
> 'cannot allocate bus number for device bla-bla'. This obviously does no=
t
> allow me to use the bridge at all.
>=20
> >
> >
> > > The suggested workaround is to have vendor-specific capability in R=
edHat
> > generic pcie-root-port
> > > that contains number of additional bus to reserve on BIOS PCI init.
> >
> > But wouldn't the proper fix be for the PCI bridge to have the subordi=
nate
> > value be extended to fit more bus ranges?
>=20
>=20
> What do you mean? This is what I'm trying to do. Do you suppose to get =
rid
> of vendor-specific cap and use original register value instead of it?

I would suggest a simple fix - each bridge has a a number of bus devices
it can use. You have up to 255 - so you split the number of northbridge
numbers by the amount of NUMA nodes (if that is used) - so for example
if you have 4 NUMA nodes, each bridge would cover 63 bus numbers.

Meaning the root bridge would cover 0->63 bus, 64->128, and so on.
That gives you enough space to plug in your plugged in devices
(up to 63).

And if you need sub-briges then carve out a specific range.


>=20
> >
> > >
> > > Aleksandr Bezzubikov (2):
> > >   pci: add support for direct usage of bdf for capability lookup
> > >   pci: enable RedHat pci bridges to reserve more buses
> > >
> > >  src/fw/pciinit.c   | 12 ++++++++++--
> > >  src/hw/pcidevice.c | 24 ++++++++++++++++++++++++
> > >  src/hw/pcidevice.h |  1 +
> > >  3 files changed, 35 insertions(+), 2 deletions(-)
> > >
> > > --
> > > 2.7.4
> > >
> > >
> >
> --=20
> Alexander Bezzubikov
