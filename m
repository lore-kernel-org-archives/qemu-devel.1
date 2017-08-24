Received: from eggs.gnu.org ([2001:4830:134:3::10]:59340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkkIr-0003cW-2h
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 01:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkkIn-0006M8-4J
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 01:03:37 -0400
Date: Thu, 24 Aug 2017 14:27:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170824042719.GG5379@umbus.fritz.box>
References: <20170821200036.15036-1-bauerman@linux.vnet.ibm.com>
	<20170824025448.GA27401@fergus.ozlabs.ibm.com>
	<20170824040243.GF5379@umbus.fritz.box>
	<20170824041501.GC27401@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qCuyVVLLFvr0p6ls"
Content-Disposition: inline
In-Reply-To: <20170824041501.GC27401@fergus.ozlabs.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] spapr: Add ibm,
 processor-storage-keys property to CPU DT node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Ram Pai <linuxram@us.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>


--qCuyVVLLFvr0p6ls
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2017 at 02:15:01PM +1000, Paul Mackerras wrote:
> On Thu, Aug 24, 2017 at 02:02:43PM +1000, David Gibson wrote:
> > On Thu, Aug 24, 2017 at 12:54:48PM +1000, Paul Mackerras wrote:
> > > On Mon, Aug 21, 2017 at 05:00:36PM -0300, Thiago Jung Bauermann wrote:
> > > > LoPAPR says:
> > > >=20
> > > >     =E2=80=9Cibm,processor-storage-keys=E2=80=9D
> > > >=20
> > > >     property name indicating the number of virtual storage keys sup=
ported
> > > >     by the processor described by this node.
> > > >=20
> > > >     prop-encoded-array: Consists of two cells encoded as with encod=
e-int.
> > > >     The first cell represents the number of virtual storage keys su=
pported
> > > >     for data accesses while the second cell represents the number of
> > > >     virtual storage keys supported for instruction accesses. The ce=
ll value
> > > >     of zero indicates that no storage keys are supported for the ac=
cess
> > > >     type.
> > > >=20
> > > > pHyp provides the property above but there's a bug in P8 firmware w=
here the
> > > > second cell is zero even though POWER8 supports instruction access =
keys.
> > > > This bug will be fixed for P9.
> > > >=20
> > > > Tested with KVM on POWER8 Firenze machine and with TCG on x86_64 ma=
chine.
> > > >=20
> > > > Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> > > > ---
> > > >=20
> > > > The sysfs files are provided by this patch for Linux:
> > >=20
> > > Those sysfs files relate to the kernel's support for userspace
> > > processes using storage keys.  That is quite distinct from KVM's
> > > support for guests using storage keys, so I think that using those
> > > sysfs files to indicate what the guest can do is wrong.
> >=20
> > Ah!  Glad someone pointed that out.
> >=20
> > > In fact KVM allows guests to specify storage keys in the HPTE values
> > > that they set, except that there is a bug (for which Ram Pai has
> > > posted a patch) that means that KVM loses the top two bits of the key
> > > number.
> > >=20
> > > What I would suggest is that we use the 'pad' field in the struct
> > > kvm_ppc_smmu_info to report the number of keys supported by KVM for
> > > guest use.
> >=20
> > Is there a particular reason to put it there rather than a new KVM capa=
bility?
>=20
> Just that storage keys are an aspect of the "server" (i.e. HPT) MMU,
> so it seemed to make sense to put it together with the other
> information about the HPT MMU (segment sizes, page sizes, etc.).

Ok, works for me.

>=20
> > > That will be 0 in all current kernels, indicating that
> > > keys are not supported, which is reasonable because of the bug.  I
> > > will make sure the patch fixing the bug goes in first.
> >=20
> > Note that the same migration concerns still apply, so we'll still want
> > machine properties to control this in qemu, which are validated
> > against what the host can do.  Since current kernels are buggy, I
> > suggest we have these properties default to 0 - i.e. you need to
> > explicitly request storage keys on the command line if you want your
> > guest to use them.  Once fixed kernels are rolled out we can look at
> > changing that in a future machine type.
> >=20
> > > We could either have two u16 fields for the number of keys for data
> > > and instruction, or we could have a u32 field for the number of keys
> > > and a separate bit in the flags field to indicate that instruction
> > > keys are supported.  Which would be preferable?
> >=20
> > I'd prefer the separate numbers for I and D.  It's more flexible and
> > no harder to implement AFAICT.
>=20
> OK.
>=20
>=20
> Paul.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qCuyVVLLFvr0p6ls
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmeVaUACgkQbDjKyiDZ
s5JeMA/+IROzoE+AuSVpxSvPG46EIy40hPZ/5ZuO+2tunAT5zQExYHYVgCfSRST3
0FG8YGleWdXsWKTqyhdc9ezQWlymIlWfEMaNivx6mBp6ZoZXN+EbOk4bar5RFxFO
JhfObEfNN/aV9njFOEkMnPBunhoLYZwQ2QUHsBpoSefUPRAsWcppJ13Ikccv+mnE
bDgq3baoqE/qoypMERBut9UUw+TXEiZjsTkCfQH2pd3/vvfgav+8gicrK4TE/ySZ
MvXw1FKUEK4qPo6DGYUH9/zKW3wTlvSnrgZWBy0F4p9HN2sPrn2fdysyJ3mO7T7o
APLu6xXXvArs5kH7VgzOfTKdh9zOIsOqvY4D97Vs6IfcFiWQw2jrMywjyc48eKwQ
3T8PRKHtJA2hpl21W5tJRDPADT/PXV5gq4Km3Vq21OxOHJP1QINqFam7RQyXs3u5
RJd/6SGrUz6D8IlB/cpKemo9kwj2YiVjs2PmW76riC60iFczSV9jRCuY6hSy7+tM
WbMVC3mV0OJOAEjVKgWoJFk2mbbUqsZU+MUH8ag156xLTb8L6TUYTO1sLDHfQZ/+
JUrw98zVvYHFCO9g/FF4F+nd5sf32B/fS5GoOnsz2SU5CB1DnyX/D+x/GlUgnJmA
pIr9mjGC70blX/+vKosUUtb56qzgPJUslLH6yI+MZmmzlOyCc4c=
=wO0/
-----END PGP SIGNATURE-----

--qCuyVVLLFvr0p6ls--
