Received: from eggs.gnu.org ([2001:4830:134:3::10]:48953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIqsV-0005Xo-8i
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 02:25:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIqsU-0002Dp-6Q
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 02:25:07 -0400
Date: Thu, 8 Jun 2017 16:01:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170608060156.GD25805@umbus.fritz.box>
References: <1496822093-5700-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1496822093-5700-2-git-send-email-bharata@linux.vnet.ibm.com>
	<20170608042848.GA13397@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lkTb+7nhmha7W+c3"
Content-Disposition: inline
In-Reply-To: <20170608042848.GA13397@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH v5 1/2] spapr: Add a "no HPT" encoding to
 HTAB migration stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com, sjitindarsingh@gmail.com


--lkTb+7nhmha7W+c3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 02:28:48PM +1000, David Gibson wrote:
> On Wed, Jun 07, 2017 at 01:24:52PM +0530, Bharata B Rao wrote:
> > Add a "no HPT" encoding (using value -1) to the HTAB migration
> > stream (in the place of HPT size) when the guest doesn't allocate HPT.
> > This will help the target side to match target HPT with the source HPT
> > and thus enable successful migration.
> >=20
> > Suggested-by: David Gibson <david@gibson.dropbear.id.au>
> > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
>=20
> As dicussed in the thread on the previous version, I still think you
> can use section_hdr =3D=3D 0 as the no-HPT encoding (matching htab_shift
> =3D=3D 0.

Bharata discussed this with me on IRC and pointed out I was mistaken.
It thought the overall stream header was distinct from the incremental
content, but it's not.  The zero value in the header marks this
"chunk" of data as being continuing incremental content (the "middle"
of the stream) rather than the initial stream header which gives the
HPT size.

So, yes, we do need a new and different encoding for "no HPT".

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lkTb+7nhmha7W+c3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZOOhRAAoJEGw4ysog2bOSoakQAKTkEXQWqxVkT+94M5HoCOex
akw+CZRW81bNoAaitUq97S15D/eGq5O5wzEEW+bs2aKiVNYS3Ov1gaeuXdosyo1t
HQ/ZvT+uUi9Irk4ViTQsZ7OnLbW7P65lmITNhhyEPCr7dJR7yVUV6UPjY+iYdXNO
X95RZB67B1Fmj8QPoOw4Ftf9FSw+oDAQ3uAFmnwatl9ruGhlpZC90VsJFtRyyZbo
+0cbRaPeF4AP0kD39PQPK+/rttBA1Uj7kdI3rie+Yst5X+L5TSeWc6Rfbh/OKgza
weKxCwLF2Al82hzyi0kqRuiM3nEtNFPsCCBbNEEcFl+vZrGc+DyLFL+TG9lOrWcY
R9DbLRPRQ2BTO0uKhVPL5SO+q9WQncDBHrwThL4VbTJpYGK3dZOxhWF9CpT/IX2j
bqQjIbBqApor1YhnuXvR6i+JepRpu2kSnBqEoPXPso70cVhmAPsULFHVoUEQIiQK
qQu87Yva2B3wB3hmFvdT4TDhvBUyBlT+Pke6RKYGC5udcljg5C9kzLzw9DCxcx+O
VbMAOycerHp8OSwITB7Tcp+A31YAD3fX5FUHtIZmyCjsDRMRAsu4s4QqPqpumnkf
G2UgUZL7bEEIKD6qdDtyJk/GXYwmV1C8E/zA1XV5atQRhFOkzdgEq/44Mr6RotES
F3vo/zALu9Sj8y/VZXTP
=oobc
-----END PGP SIGNATURE-----

--lkTb+7nhmha7W+c3--
