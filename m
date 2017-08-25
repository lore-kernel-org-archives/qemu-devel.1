Received: from eggs.gnu.org ([2001:4830:134:3::10]:50182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dlCS7-0005s5-5r
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dlCS3-0008Tg-2A
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:07:03 -0400
Date: Fri, 25 Aug 2017 19:45:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170825094538.GI2772@umbus.fritz.box>
References: <1503562911-2776-1-git-send-email-imammedo@redhat.com>
	<1503562911-2776-3-git-send-email-imammedo@redhat.com>
	<20170825013819.GQ5379@umbus.fritz.box>
	<20170825092740.239b6a82@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dCSxeJc5W8HZXZrD"
Content-Disposition: inline
In-Reply-To: <20170825092740.239b6a82@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 2/6] ppc: make cpu_model
 translation to type consistent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--dCSxeJc5W8HZXZrD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2017 at 09:27:40AM +0200, Igor Mammedov wrote:
> On Fri, 25 Aug 2017 11:38:19 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Aug 24, 2017 at 10:21:47AM +0200, Igor Mammedov wrote:
> > > PPC handles -cpu FOO rather incosistently,
> > > i.e. it does case-insensitive matching of FOO to
> > > a CPU type (see: ppc_cpu_compare_class_name) but
> > > handles alias names as case-sensitive, as result:
> > >=20
> > >  # qemu-system-ppc64 -M mac99 -cpu g3
> > >  qemu-system-ppc64: unable to find CPU model ' kN=EF=BF=BDU'
> > >=20
> > >  # qemu-system-ppc64 -cpu 970MP_V1.1
> > >  qemu-system-ppc64: Unable to find sPAPR CPU Core definition
> > >=20
> > > while
> > >=20
> > >  # qemu-system-ppc64 -M mac99 -cpu G3
> > >  # qemu-system-ppc64 -cpu 970MP_v1.1
> > >=20
> > > start up just fine.
> > >=20
> > > Considering we can't take case-insensitive matching away,
> > > make it case-insensitive for  all alias/type/core_type
> > > lookups.
> > >=20
> > > As side effect it allows to remove duplicate core types
> > > which are the same but use lower-case letters in name.
> > >=20
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com> =20
> >=20
> > Hmm.  So, I'm certainly good with making the matching more consistent,
> > and removing extra entries differing only in case.
> >=20
> > However, I don't like capitalizing everything in the model table.  The
> > "canonical" capitalization - as in how it appears in manuals and
> > marketing info - is quite frequently mixed case.  So I think making
> > everything caps in the table will make it harder to read in the
> > context of looking at the corresponding documentation.
> only cpu models =3D> typenames are made caps, the rest

Yes, I know.  A number of the CPU model names themselves have mixed
case.  Really.

> incl. description is kept as is in mixed case.
> It looks like _desc is the thing one would use for
> 1:1 lookup in spec, while _name isn't direct match consistently
> (i.e. sometimes it skips spaces and sometimes spaces are replaced by unde=
rscore).
> So keeping _name in mixed case unnecessarily complicates name->type looku=
p.
>=20
> These mixed case + case-insensitive is what made lookup
> code over-engineered and overly complex.

I'm fine with making all the lookups case insensitive.  I just don't
want to drop the case on the names in the actual code.

> As result it evolved (regressed) to inconsistent name handling
> since it's rather hard to understand what's going on there.

Yeah, I know :/.

> > Can we instead retain mixed case in the table, and capitalize both
> > sides at the comparison time?
> it has to be the same-case since PPC has case-insensitive cpu_model
> matching (sometimes :/). Normalized /same case/ typenames
> are necessary for object_class_by_name() to work as it does exact match.
> So it would be possible to replace custom fetching of CPU types
> and iterating over it with custom comparator with object_class_by_name().
> As it's done in 4/6.
> This patch and 3/6 are only preparatory patches for 4/6.

Ah.  Hrm.  That's awkward.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dCSxeJc5W8HZXZrD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmf8bwACgkQbDjKyiDZ
s5KAfhAAoJZ9YT2e8FY7WLCRYuYDCP8cEy4SpFgV+WuF+xHEnp/PYQkSG4m2f/wP
aac7RAbYRNhLTEzYNgcbDLbdTtMOw79p9SiZARoX+mUd8Kd12dSKC4F/hHbTlAHh
jmsySEFmoAMWaNQh7WWrsG7mdeDNhZKwN6Nrm3JTpNT7Lqe48fG82N+xyr3OG/MJ
VqLT10aUWre8wx0JIuE/kKJ9QL7ZtnfhN43WzMB9vjE325BsaxQRz5duZ3RWRt/U
zMpQP+2D4C5GQ1GqWsA9CzL3iSiP/pBfKSvkagLveRv15WhHTUw1JtuI0vMNwnJI
Q+DQtBan8qlSQ5YUZydSxlmQPrspZkYU8uCmqic08ZhIGtLB2pPK1VhgHoNSUoRo
O/+nWM7IJrBVbd/gBGV8j84YQa0tlaMTCn7n3nwyYTeuWaReyud6pkQovuEKgrDl
yJDshABlHsO6ltZzQqsHuZ5Cdlg9W0lF2FgNQ2NP5uvXdiYBFcoiWkPiUy47AdQT
FHBljmtVqZhmhFSqCPr/luPzIb0E9udZZGDLdhsVLu+u4bP1TpGIiJsTDkWgD26n
Y9TtBMfIVYBsleh54BFtpuwqY0vY8JdUCAgKVjDJNCg6zuRJokF2HKSX6ctSjnrG
+nDmPxjM/KybYitgzInWos2BfcOinQP1OG70MzVXviwuhCP6S3k=
=ONH4
-----END PGP SIGNATURE-----

--dCSxeJc5W8HZXZrD--
