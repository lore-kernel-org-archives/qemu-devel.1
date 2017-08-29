Received: from eggs.gnu.org ([2001:4830:134:3::10]:38839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dmXIY-0007Bp-EK
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 23:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dmXIX-0005WZ-4C
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 23:34:42 -0400
Date: Tue, 29 Aug 2017 11:57:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170829015753.GE2578@umbus.fritz.box>
References: <20170821200036.15036-1-bauerman@linux.vnet.ibm.com>
	<20170824025448.GA27401@fergus.ozlabs.ibm.com>
	<20170824181122.GA5632@ram.oc3035372033.ibm.com>
	<20170825042313.GD2772@umbus.fritz.box>
	<20170828175011.GA26893@ram.oc3035372033.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BZaMRJmqxGScZ8Mx"
Content-Disposition: inline
In-Reply-To: <20170828175011.GA26893@ram.oc3035372033.ibm.com>
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
To: Ram Pai <linuxram@us.ibm.com>
Cc: Paul Mackerras <paulus@ozlabs.org>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Michael Ellerman <mpe@ellerman.id.au>


--BZaMRJmqxGScZ8Mx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2017 at 10:50:11AM -0700, Ram Pai wrote:
> On Fri, Aug 25, 2017 at 02:23:13PM +1000, David Gibson wrote:
> > On Thu, Aug 24, 2017 at 11:11:22AM -0700, Ram Pai wrote:
> > > On Thu, Aug 24, 2017 at 12:54:48PM +1000, Paul Mackerras wrote:
> > > > On Mon, Aug 21, 2017 at 05:00:36PM -0300, Thiago Jung Bauermann wro=
te:
> > > > > LoPAPR says:
> > > > >=20
> > > > >     =E2=80=9Cibm,processor-storage-keys=E2=80=9D
> > > > >=20
> > > > >     property name indicating the number of virtual storage keys s=
upported
> > > > >     by the processor described by this node.
> > > > >=20
> > > > >     prop-encoded-array: Consists of two cells encoded as with enc=
ode-int.
> > > > >     The first cell represents the number of virtual storage keys =
supported
> > > > >     for data accesses while the second cell represents the number=
 of
> > > > >     virtual storage keys supported for instruction accesses. The =
cell value
> > > > >     of zero indicates that no storage keys are supported for the =
access
> > > > >     type.
> > > > >=20
> > > > > pHyp provides the property above but there's a bug in P8 firmware=
 where the
> > > > > second cell is zero even though POWER8 supports instruction acces=
s keys.
> > > > > This bug will be fixed for P9.
> > > > >=20
> > > > > Tested with KVM on POWER8 Firenze machine and with TCG on x86_64 =
machine.
> > > > >=20
> > > > > Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> > > > > ---
> > > > >=20
> > > > > The sysfs files are provided by this patch for Linux:
> > > >=20
> > > > Those sysfs files relate to the kernel's support for userspace
> > > > processes using storage keys.  That is quite distinct from KVM's
> > > > support for guests using storage keys, so I think that using those
> > > > sysfs files to indicate what the guest can do is wrong.
> > > >=20
> > > > In fact KVM allows guests to specify storage keys in the HPTE values
> > > > that they set, except that there is a bug (for which Ram Pai has
> > > > posted a patch) that means that KVM loses the top two bits of the k=
ey
> > > > number.
> > > >=20
> > > > What I would suggest is that we use the 'pad' field in the struct
> > > > kvm_ppc_smmu_info to report the number of keys supported by KVM for
> > > > guest use.  That will be 0 in all current kernels, indicating that
> > > > keys are not supported, which is reasonable because of the bug.  I
> > > > will make sure the patch fixing the bug goes in first.
> > >=20
> > > with the current kernels, even with the bug, KVM can still support 8
> > > keys. Should we say 8 instead of 0?  It will help enable keys on KVM
> > > earlier and give a jump start to its adaption by applications.
> >=20
> > But the point isn't really what we *can* say, it's with what is
> > implicitly said by kernels that don't advertise anything
> > specifically.  Which is 0.
> >=20
>=20
> Right. I was pointing to the case where nothing is said implicitly by
> the kernel (no advertised values), to default to 8 instead of defaulting
> to 0.

The point is that the kernel advertising nothing is indistinguishable
=66rom it advertising 0.  We don't get to chose that default value.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BZaMRJmqxGScZ8Mx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmkyh8ACgkQbDjKyiDZ
s5IttA//YupT4qT1g5FURkGUNSsZckqnnG4b+ymTRa0ejDiZ+aooVkfo8OnZ/4/n
9NL/MfEtqlAQM8kB2zY5+c+CWCrtrnyUiBoBvVihFoeUABJeCXQgHpe5b1063d30
Pw84hYj9DMJgdmQeTm5ZHjW4uqrYZtYBFupMLxyW7f/ca99jGiMoJ+47IKmhbQBX
gpNL9NyVlkLGAHH99q4Ccmf6Z6pqRKw5kgPMxJsrBlIhxZEOIAEuPnkCVmXMt3gI
O2/WqX5fLxGcMZ39qo6GzPEgHtEP77kE3zBkJ6GWi7qeYOOcVx1n3aJ3mh72J9LL
KNCOn5EUlXr2CRIs+OjrHh/zvCbCcYHlgb3zwgPrT+tYrVVXAnuzfigH2uMKYXG4
CJEZ7v+g4PXU9j/APuDMPSAYmWF7WowxV2u9Oa94vZXBhQX8Py4394qkt4XOGR13
WeBxlz68lK39inZ0nYPydSK9BVqhx7vhHN6VgX2JxRXVy9F3hWCOcvcDE4foP6Ic
+JDr3SqzWyTCJRTXPVAdAL972GKY9/Uml/N4kUdvsmSJLgnQCRK6TTEGrwDFn7Th
++vBRC6CD57ffnAlGWCxgz/E1lPDTCXxsTJKK7HSXn3BCp291tgtbS6IwR5ET3tV
I6b7yfipl4PpcECRfF3QUuKW5YypaxN70vK3Vpx93wcqk5i4B/g=
=c9rj
-----END PGP SIGNATURE-----

--BZaMRJmqxGScZ8Mx--
