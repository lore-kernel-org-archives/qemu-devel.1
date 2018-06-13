Received: from eggs.gnu.org ([2001:4830:134:3::10]:39591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fT2M2-0006v1-D9
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fT2Lz-0004ws-6B
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:46:14 -0400
Date: Wed, 13 Jun 2018 19:45:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180613094554.GF30690@umbus.fritz.box>
References: <20180613065707.30766-1-david@gibson.dropbear.id.au>
	<20180613065707.30766-7-david@gibson.dropbear.id.au>
	<b33c8376-88f6-1654-0d20-dbcbd51d10e0@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bGD25dtqTBkDy1zG"
Content-Disposition: inline
In-Reply-To: <b33c8376-88f6-1654-0d20-dbcbd51d10e0@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 6/7] target/ppc: Replace intc pointer with
 a general machine_data pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--bGD25dtqTBkDy1zG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2018 at 10:46:02AM +0200, C=E9dric Le Goater wrote:
> On 06/13/2018 08:57 AM, David Gibson wrote:
> > PowerPCCPU contains an (Object *)intc used to point to the cpu's interr=
upt
> > controller. Or more precisely to the "presentation" component of the
> > interrupt controller relevant to this cpu.
>=20
> yes and that made sense in terms of modeling because you actually have a=
=20
> set of wires between the presenter and the cores of a system.
>=20
> > Really, this field is machine specific.  The machines which use it can
> > point it to different types of object depending on their needs, and most
> > machines don't use it at all (since they have older style PICs which do=
n't
> > have per-cpu presentation components).
> >=20
> > There's also other information that's per-cpu, but platform/machine
> > specific.  So replace the intc pointer with a (void *)machine_data which
> > can be managed as the machine type likes to conveniently store per cpu
> > information.
>=20
> ah. so you have something else the store in the machine_data.=20
>=20
> If you were defining a type, we would have some more checks when=20
> casting the machine_data field. We also could parent the object=20
> to the CPU also. This is minor.

My intention is that machine_data be a "passive" structure, not a QOM
object.  Lifetime and type management are all up to the machine.

> The change should be compatible with the XIVE change which need=20
> to allocate a different type of presenter. So, sPAPRCPUState and=20
> PnvCPUState would look like :
>=20
> 	typedef struct sPAPRCPUState {
> 	    ICPState *icp;
> 	    XiveTCTX *tctx;
> 	} sPAPRCPUState;

Exactly.

> and the call to ipc_create() will move in an operation of the=20
> sPAPR IRQ backend, if that exists oneday, and in an operation of=20
> the PnvChip to handle the differences in the interrupt controller
> in use by the machine.=20
>=20
> So no big difference, but the cpu machine_data won't be populated
> from the core but from the machine. I hope this is compatible
> with the next changes.

intc was already populated from the machine.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bGD25dtqTBkDy1zG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsg59IACgkQbDjKyiDZ
s5LFXQ/+MCt9Q8L+rx/Xjh50VrVDlPHw+Ycu7v3puemCFRlDYx/IdBwZliJ2M4CG
UORS2NHZdfNOc2KR3O8mND6NLiVQufO7mg3xQZXi8EXVEblHGrFQ+X3yPf6cLTvY
jhZCDqzLmY4htxNEQw+wL0+ATdW2kOvaFFsl8pHdResQt94YY4mqakM4NlkN+c3b
rZAllTF7JQdkoSiYRE8n6tKIvKDSpFaovT8mK9s7TWYAHlOENdhHgvm4bvQ7Jbw0
hzH8D8Q/JExKgglqb9anbeIi3XwErVox6YtFiRzt03AzYgJFbskAEzdopif6HkmH
aHg3DksVSmWgCrqyJm1pLIG6qtjUxKLcAvg1CFIzhvyWvromgo08I13sVmzm1XGl
SnOan58ERBWI1XaJek03oA3aGFpI7gKEaZispnQRqA+m+gd9d/1RB+mWLToSdKVi
++ZKdHWKLGAcS3oeSeKzgyJRKVOnCNayZQGxyxr740OzVJf+3DBoeMo+W4UmSmdz
Ou0PGCnvk9uIQF0883LfpxtPNfJE7MwlqxE9XR89zmUOgdPRMIHFRpeur8u0uATp
SkFVCSfgEFvBfXbxlnHUXCBjnzuh3wyDr8kY7v/Zc6wbjmbUqWbzvDgCIkmhdJI8
19Xjl73qhpeX8ALcKHf/vLVtgctLhjKHjJ+Q63pvnTeawwhOvGU=
=UKVj
-----END PGP SIGNATURE-----

--bGD25dtqTBkDy1zG--
