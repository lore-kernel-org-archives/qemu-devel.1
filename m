Received: from eggs.gnu.org ([2001:4830:134:3::10]:53167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ceCk0-0004nB-7j
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 22:28:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ceCjy-0003Sl-S8
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 22:28:20 -0500
Date: Thu, 16 Feb 2017 14:28:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170216032808.GR12369@umbus.fritz.box>
References: <95706652-0a80-92fc-951b-7a454d496ddf@redhat.com>
	<20170210003746.GP27610@umbus.fritz.box>
	<5ea3785c-b979-8b8c-3ab0-243d69384697@redhat.com>
	<20170213043307.GT25381@umbus>
	<45446029-e404-77d4-754e-5541a506bb7c@redhat.com>
	<20170214041532.GF2169@umbus.fritz.box>
	<c0e368b1-c89d-ef5a-d475-c92266d3eb41@redhat.com>
	<20170215014544.GC12369@umbus.fritz.box>
	<22b4c89b-bfeb-e196-73c3-927115398e5e@redhat.com>
	<20170216024842.GQ12369@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y2MHPAl/EzyWgzIZ"
Content-Disposition: inline
In-Reply-To: <20170216024842.GQ12369@umbus.fritz.box>
Subject: Re: [Qemu-devel] [RFC] virtio-pci: Allow PCIe virtio devices on
 root bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, abologna@redhat.com, lvivier@redhat.com, thuth@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, kraxel@redhat.com, Eduardo Habkost <ehabkost@redhat.com>


--y2MHPAl/EzyWgzIZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2017 at 01:48:42PM +1100, David Gibson wrote:
> On Wed, Feb 15, 2017 at 04:59:33PM +0200, Marcel Apfelbaum wrote:
> > On 02/15/2017 03:45 AM, David Gibson wrote:
> > > On Tue, Feb 14, 2017 at 02:53:08PM +0200, Marcel Apfelbaum wrote:
> > > > On 02/14/2017 06:15 AM, David Gibson wrote:
> > > > > On Mon, Feb 13, 2017 at 12:14:23PM +0200, Marcel Apfelbaum wrote:
> > > > > > On 02/13/2017 06:33 AM, David Gibson wrote:
> > > > > > > On Sun, Feb 12, 2017 at 09:05:46PM +0200, Marcel Apfelbaum wr=
ote:
> > > > > > > > On 02/10/2017 02:37 AM, David Gibson wrote:
> > > > > > > > > On Thu, Feb 09, 2017 at 10:04:47AM +0100, Laszlo Ersek wr=
ote:
> > > > > > > > > > On 02/09/17 05:16, David Gibson wrote:
> > > > > > > > > > > On Wed, Feb 08, 2017 at 11:40:50AM +0100, Laszlo Erse=
k wrote:
> > > > > > > > > > > > On 02/08/17 07:16, David Gibson wrote:
[snip]
> > > >   Which means that you can use it to
> > > > > drive PCIe devices just fine.  "Bus level" PCIe extensions like A=
ER
> > > > > and PCIe standard hotplug won't work, but PAPR has its own mechan=
isms
> > > > > for those (common between PCI and PCIe).
> > > > >=20
> > > > > I did float the idea of having the pseries PCI bus remain plain P=
CI
> > > > > but with a special flag to allow PCIe devices to be attached to it
> > > > > anyway.  It wasn't greeted with much enthusiasm..
> > > > >=20
> > > >=20
> > > > Can you point me to the discussion please? It seems similar to what=
 I proposed above.
> > >=20
> > > Sorry, I was misleading.  I think I just raised that idea with Andrea
> > > and a few other people internally, not on one of the lists at large.
> > >=20
> > > > As you properly described it, is much closer to PCI then PCIe, even=
 the only characteristic
> > > > that makes it "a little" PCIe, the Extended Configuration Space sup=
port,
> > > > is done with an alternative interface.
> > > >=20
> > > > I agree the PAPR bus is not PCIe.
> > >=20
> > > Ok, so if we take that direction, the question becomes how do we let
> > > PCIe devices plug into this mostly-not-PCIe bus.  Maybe introduce a
> > > "pci_bus_accepts_express()" function that will replace many, but not
> > > all current uses of "pci_bus_is_express()"?
> > >=20
> >=20
> > Sounds good and I think Eduardo is already working on exactly this
> > idea, however he is on PTO now. It is better to synchronize with him.
>=20
> Ah, right.  Do you know when he'll be back?  This is semi-urgent for
> Power.
>=20
>=20
> > > Such a helper could maybe simplify the logic in virtio-pci (and XHCI?)
> > > by returning false on an x86 root bus.
> > >=20
> >=20
> > The rule would me more complicated. We don't want to completely remove =
the
> > possibility to have PCIe devices as part of Root Complex. it seems
> > like I am contradicting myself, but no).
> > This is why we have guidelines and  not hard-coded policies.
> > Also ,the QEMU way is to be more permissive. We provide guidelines and =
sane
> > defaults, but we let the user to chose.
> >=20
> > Getting back to our problem, the rule would be:
> > hybrid devices should be PCI or PCIe for a bus?
> > PAPR bus should return 'PCIe' for hybrid devices.
> > X86 bus should return 'PCIe' if not root.
>=20
> Ok.

Wait, actually.. we have two possible directions to go, both of which
have been mentioned in the thread, but I don't think we've settled on
one:

1) Have pseries create a PCIe bus (as my first cut draft does).

That should allow pure PCIe devices to appear either under a port or
(more usually for PAPR) as "integrated endpoints".  In addition we'd
need as suggested above a "pcie_hybrid_type()" function that would
tell hybrid devices to also appear as PCIe rather than PCI.

2) Have pseries create a vanilla PCI bus (or a special PAPR PCI
   variant)

Appearing as vanilla PCI would in a number of ways more closely match
the way PCI buses are handled on PAPR.  However, we still need to
connect PCIe devices to it.  So we'd need some 'bus_accepts_pcie()'
hook and use that (in place of pci_bus_is_express()) to determine both
whether we can attach pure PCIe devices and that hybrid devices should
appear as PCIe rather than plain PCI.


Based on the immediately preceding discussion, I was leaning towards
(2).  Is that your feeling as well?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--y2MHPAl/EzyWgzIZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYpRxGAAoJEGw4ysog2bOSYNQQAIVmJbrZFExBf0g3PVglaTCi
3xTYnfDkIpRa5iS/E8ITSXukS+PnFJX9xRvtv9ZIlyK5JDyxfE1LTrRDI7WpwzLG
2Mebs97fZrUgrwOlBVT2lf3y3GhAzHVSngRtUfQPlnSwkN5FQ5C5e84x/b5kSWSH
qairc/Z3sxbr07k9AfjGHFen54sHsTG1C8GvYtua1vfKh21ZxEtrbSLu+ZUl0BP6
M5idfj+n97c2/nXUYtsFC80ol8QsyAfx+7EtF8VcENcg81h7eYDQH3c05hmqD9YM
SIXagIm8FboezmYEmU6nrRUwGzHRuSPKq/iBuFV9Zk+5wippuMdS2vCKSa4mT5pd
KlSwJy43mb8On/odwkvUq+hyet4Zrutoc7XUhDM2SoTC4Ag6uQqr9YESQvM59zPo
Pt8FhLKKjbMScJy7IYcs0E1meozlSuA0aLvaiTuveyrntwi2idv3TVgGj5/BQdNF
yROsBoHfC1EG0PM3hLV8PzAa3CZi2lUlUOUPLRLIeuHJIqPBH0lYZsLWR1G7ws1h
qcvkla1FYSMWLmLh8Uq+4QTJRVwfMqhmlGhEnOKbinsLqweiLzGQruaa9zhuS6Sl
Uic/R41IGuzmwTU7a/n5r5kEqnMzvgRKaBRe9ALa4Byt2oif0HmTPIggEyGZo/Ip
R8+7uqMPZ77M4xgu25un
=oXNB
-----END PGP SIGNATURE-----

--y2MHPAl/EzyWgzIZ--
