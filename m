Received: from eggs.gnu.org ([2001:4830:134:3::10]:45336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fY7sF-00037N-PW
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:40:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fY7sA-0005nz-Pj
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:40:31 -0400
Message-ID: <c071d87d3b3ad43c7c17de17ef5116ada666ef6f.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Wed, 27 Jun 2018 12:40:21 +0200
In-Reply-To: <9f9a4454bec8e7009a02d544d7a98f6215bd1fa0.camel@kernel.crashing.org>
References: <20180626135928.23950-1-clg@kaod.org>
	<20180627033321-mutt-send-email-mst@kernel.org>
	<1d70c0f9179990cd33d7c82c5190179e60ae4ce3.camel@kernel.crashing.org>
	<20180627072825.GH14434@umbus.fritz.box>
	<65c545f3-6279-62af-9bd8-2be93a3d7d18@kaod.org>
	<9f9a4454bec8e7009a02d544d7a98f6215bd1fa0.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: Add model for Power8 PHB3 PCIe
 Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On Wed, 2018-06-27 at 18:41 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2018-06-27 at 09:46 +0200, C=C3=A9dric Le Goater wrote:
> > So the "IBM PHB3 PCIE Root Port" is already user createable.
> >=20
> > I can take a look at user createable PHB3s. I think this is OK from a=
 model
> > perspective. The object is rather standalone, it needs the machine fo=
r=20
> > the XICS fabric and a couple of ids, phb id and chip id. These can co=
me
> > from the command line.
> >=20
> > We want at least one PHB3 per socket/chip though.=20
>=20
> We don't want the user to specify the SCOM addresses though (for the
> MMIO windows we should get skiboot to assign them).
>=20
> If the user gets to specify a thing it would be which of the 3 or 4 HW
> PHBs of the chip it is, the SCOM addresses gets deduced.

For pSeries guests libvirt will either automatically create, or
allow users to configure manually, PHBs with something like

  <controller type=3D'pci' index=3D'1' model=3D'pci-root'>
    <target index=3D'1'/>
  </controller>

which is ultimately converted to

  -device spapr-pci-host-bridge,index=3D1,id=3Dpci.1

Ideally the interface for PowerNV guests can be made to be similar
if not identical at the libvirt level, without having to add too
many hacks... It would certainly help a lot if the QEMU interface
for PowerNV PHBs didn't stray too far from the above.

--=20
Andrea Bolognani / Red Hat / Virtualization
