Received: from eggs.gnu.org ([209.51.188.92]:32803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvwdL-0003rI-As
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 23:03:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvwdF-0002PK-MK
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 23:03:49 -0500
Date: Tue, 19 Feb 2019 14:46:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190219034649.GQ9345@umbus.fritz.box>
References: <20190215170029.15641-1-clg@kaod.org>
	<20190215170029.15641-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wr1Q/2bz0MCWWNYv"
Content-Disposition: inline
In-Reply-To: <20190215170029.15641-4-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 03/12] target/ppc: Re-enable RMLS on POWER9
 for virtual hypervisors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--wr1Q/2bz0MCWWNYv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 06:00:20PM +0100, C=E9dric Le Goater wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> Historically the 64-bit server MMU supports two way of configuring the
> guest "real mode" mapping:
>=20
>  - The "RMA" with is a single chunk of physically contiguous
> memory remapped as guest real, and controlled by the RMLS
> field in the LPCR register and the RMOR register.
>=20
>  - The "VRMA" which uses special PTEs inserted in the partition
> hash table by the hypervisor.
>=20
> POWER9 deprecates the former, which is reflected by the filtering
> done in ppc_store_lpcr() which effectively prevents setting of
> the RMLS field.
>=20
> However, when using fully emulated SPAPR machines, our qemu code
> currently only knows how to define the guest real mode memory using
> RMLS.
>=20
> Thus you cannot run a SPAPR machine anymore with a POWER9 CPU
> model today.
>=20
> This works around it with a quirk in ppc_store_lpcr() to continue
> allowing the RMLS field to be set when using a virtual hypervisor.
>=20
> Ultimately we will want to implement configuring a VRMA instead
> which will also be necessary if we want to migrate a SPAPR guest
> between TCG and KVM but this is a lot more work.

Urgh.  I'm applying this because it fixes a real bug, but it's not
really the right solution.

We will want to support VRMAs at some point in order to let emulated
powernv machines run guests, but implementing VRMA doesn't really make
sense in the context of a PAPR machine.

The real problem here is that we're using the LPCR - which notionally
doesn't even exist in a PAPR machine - to trick the softmmu code,
which is written from the point of view of bare metal - into doing
more or less the right thing for a PAPR machine.

The correct solution, I think, is to put a test on cpu->vhyp into the
guts of the softmmu code so that in non-HV real mode it doesn't even
consult the LPCR and just goes directly to GPAs (which is the only
think that the pseries machine knows about).

Although then I guess we'd need some way in the vhyp of representing
the permissible max address of real mode accesses.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wr1Q/2bz0MCWWNYv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxrfCMACgkQbDjKyiDZ
s5KXQhAAy2mFMmlsQdxwesUSvjkEQiSPMMOpkZ0CCiOwGGKWuL3QKEFCpeDRugkz
R3KSxY65Dn6/x7ZTAygjhA86yaUDK85+w4hoF61BD/Zznbitg86P6MNc/KYq0tUP
9HdoYyUcmv8jRx0kllKaWkGFrRyy4ERTw0cflFMOzLrzp7Op6CF355uNK4/iIDwe
63e2fvxmF1zGGJvh+hQvMNF10/i8wtsjCIKBd+en9sXnBSSqKg6P0dOxC1UCOV1H
Zl7vTn4Jbr/010k52OgNetijWjTT8/aGc3640kFHgNDUwdJ1goFBTwjfYCSLGx5d
1cSITyQMuTrv1WoPc8suyPxrv42kxs9lSlRMqXiRfv/zcUi4lq3VMSlc/LD6dP+n
bVGORUxtgiQcugmkh+4q6RfoCGH+Fi2VfmC25QStjh/xKbkOBWTYTIf7h862k4fs
fxjjyq+SWVq2E/r1Gfld9LwNg+Xr51JpZvy+f1RBOW4c6+wwV+yE1mLzrOjGMJiu
sav1v8mS1U0kyJjdbQsDBXYGrHx/YyNiKa0a1mXaP7XKsBC7fAuPt1pf8Y4CNdPI
z7F/lab+pxvZsjhUfIs2Yeki+i5UvzNyyzHT1EV/kyjEydDHNOQ0c4ZL2ziwKfSV
MpMBYsFOsxhRhmDq98/TXIrIpzQ3DnU6P/8VeYC7soj/u0JIW50=
=B/Vn
-----END PGP SIGNATURE-----

--wr1Q/2bz0MCWWNYv--
