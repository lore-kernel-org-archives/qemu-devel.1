Received: from eggs.gnu.org ([2001:4830:134:3::10]:37143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxp4c-0002el-0Z
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 02:14:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxp4a-000437-Od
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 02:14:42 -0400
Date: Tue, 11 Apr 2017 16:06:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170411060613.GA12900@umbus.fritz.box>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-21-git-send-email-clg@kaod.org>
	<20170410081414.GS27571@umbus>
	<1491879951.4166.222.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <1491879951.4166.222.camel@kernel.crashing.org>
Subject: Re: [Qemu-devel] [PATCH 20/21] ppc/pnv: Add model for Power8 PHB3
 PCIe Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Tue, Apr 11, 2017 at 01:05:51PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2017-04-10 at 18:14 +1000, David Gibson wrote:
> > > +=A0=A0=A0 switch (size) {
> > > +=A0=A0=A0 case 1:
> > > +=A0=A0=A0=A0=A0=A0=A0 break;
> > > +=A0=A0=A0 case 2:
> > > +=A0=A0=A0=A0=A0=A0=A0 val =3D bswap16(val);
> >=20
> > An unconditional bswap() seems unlikely to be correct.=A0 What's the
> > purpose of thise?
>=20
> Though it is :-) I *think* ... I did test with both LE and BE hosts I
> believe but Cedric can double check.
>=20
> >From memory it comes from the fact that the PHB register space is
> declared to be big endian since 99% of it actually is.
>=20
> However the CONFIG_DATA register used to issue config space accesses is
> "special" and expect little endian accesses.
>=20
> However because the whole region is marked BE, qemu will have done
> the necessary swapping for BE, which thus needs to be undone for
> that specific register unconditionally:
>=20
>  - BE host will not swap the value, so we get the LE value written by
> the guest which needs to be swapped to BE.
>=20
>  - LE host will have swapped the value as if it was BE except it isn't
> so we need to re-swap it.
>=20
> IE. Another option would be to create a specific memory region just for
> that one register but it's easier to just unconditionally swap.

Ok, that makes sense.  A comment saying that this one register is LE
whereas most are BE would be helpful.

> > > +=A0=A0=A0=A0=A0=A0=A0 break;
> > > +=A0=A0=A0 case 4:
> > > +=A0=A0=A0=A0=A0=A0=A0 val =3D bswap32(val);
> > > +=A0=A0=A0=A0=A0=A0=A0 break;
> >=20
> > No 64-bit config registers?
>=20
> No, they don't exist. (Which is also why an assert isn't a good
> idea as other registers do support 64-bit accesses).

Ah, ok.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY7HJTAAoJEGw4ysog2bOSag8P/08JWQ5/Phr7WFx072Vo76ju
6mplzm4HXtjT38PgzTMoWa394C7RfMf9lry3HGqmP8skxA3qI7EzMfDzK9+2vKuT
EnGISxMZl4nKB0ISB6g7O+AxEgGEF5xJDulRdBBQ4+ynDC6LMxJRi0zHx6eIrzlL
z/NwExkdm7QKeJ4Az8yz11G5QGI/OaeIi7bOnGzZ4JAb4nuGDyyJ4CkP2Xi/OY5D
Xox/StaTsqgbJU+eQQCT1uRinYpDTMWrIKb/MmjG1LYpcmJ2JEpkTE/YgF+OJlX1
fNy3njAP9RdTiczMJ/ggBCipQGATvhM9R6kQITVnC/baZttW+FKByupjVgRTnpAS
uPyeqUjAkKuOMTkUm1sC+1+DK2lMvD7cQjmc1N8913g3y5X9z2wf5X1MM0hyd+ms
VFDFFdyTvs+nlQHb8t0fdQJDsGCc1MjH6PBYPS4maf0p22r7+0sjN/TwltSX1M0G
6x/zyY0Z4Qi3rwCfiOuLWzowUc1KmsKzUNuLG8kH2AHV6zDOFIUB1YgXT8SqgS+B
GBLYbZNRxzY9nhClRKoDpn+uJr/PQl/0NsaKasAx9wzjcC0Z/Oyu/gmukbEv8lDN
mLbpH64l+jQisXJBj5nGfeKHbbVPdd7cayj3e+1Ibg2mtBDeIJmcqI0UoKtS/CnK
ZXX7vs7Vk0pG/zLapx2p
=IaQ1
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
