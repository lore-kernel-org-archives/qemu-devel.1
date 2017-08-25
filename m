Received: from eggs.gnu.org ([2001:4830:134:3::10]:40622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dlEgF-00031c-5i
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dlEgD-0005mL-Jt
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:29:47 -0400
Date: Fri, 25 Aug 2017 23:28:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170825132800.GM2772@umbus.fritz.box>
References: <1503562911-2776-1-git-send-email-imammedo@redhat.com>
	<1503562911-2776-3-git-send-email-imammedo@redhat.com>
	<20170825013819.GQ5379@umbus.fritz.box>
	<20170825092740.239b6a82@nial.brq.redhat.com>
	<20170825094538.GI2772@umbus.fritz.box>
	<20170825134007.73d69fa3@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DheUW4aQn8WJk6WR"
Content-Disposition: inline
In-Reply-To: <20170825134007.73d69fa3@nial.brq.redhat.com>
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


--DheUW4aQn8WJk6WR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2017 at 01:40:07PM +0200, Igor Mammedov wrote:
> On Fri, 25 Aug 2017 19:45:38 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, Aug 25, 2017 at 09:27:40AM +0200, Igor Mammedov wrote:
> > > On Fri, 25 Aug 2017 11:38:19 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >  =20
> > > > On Thu, Aug 24, 2017 at 10:21:47AM +0200, Igor Mammedov wrote: =20
> > > > > PPC handles -cpu FOO rather incosistently,
> > > > > i.e. it does case-insensitive matching of FOO to
> > > > > a CPU type (see: ppc_cpu_compare_class_name) but
> > > > > handles alias names as case-sensitive, as result:
> > > > >=20
> > > > >  # qemu-system-ppc64 -M mac99 -cpu g3
> > > > >  qemu-system-ppc64: unable to find CPU model ' kN=EF=BF=BDU'
> > > > >=20
> > > > >  # qemu-system-ppc64 -cpu 970MP_V1.1
> > > > >  qemu-system-ppc64: Unable to find sPAPR CPU Core definition
> > > > >=20
> > > > > while
> > > > >=20
> > > > >  # qemu-system-ppc64 -M mac99 -cpu G3
> > > > >  # qemu-system-ppc64 -cpu 970MP_v1.1
> > > > >=20
> > > > > start up just fine.
> > > > >=20
> > > > > Considering we can't take case-insensitive matching away,
> > > > > make it case-insensitive for  all alias/type/core_type
> > > > > lookups.
> > > > >=20
> > > > > As side effect it allows to remove duplicate core types
> > > > > which are the same but use lower-case letters in name.
> > > > >=20
> > > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>   =20
> > > >=20
> > > > Hmm.  So, I'm certainly good with making the matching more consiste=
nt,
> > > > and removing extra entries differing only in case.
> > > >=20
> > > > However, I don't like capitalizing everything in the model table.  =
The
> > > > "canonical" capitalization - as in how it appears in manuals and
> > > > marketing info - is quite frequently mixed case.  So I think making
> > > > everything caps in the table will make it harder to read in the
> > > > context of looking at the corresponding documentation. =20
> > > only cpu models =3D> typenames are made caps, the rest =20
> >=20
> > Yes, I know.  A number of the CPU model names themselves have mixed
> > case.  Really.
> >=20
> > > incl. description is kept as is in mixed case.
> > > It looks like _desc is the thing one would use for
> > > 1:1 lookup in spec, while _name isn't direct match consistently
> > > (i.e. sometimes it skips spaces and sometimes spaces are replaced by =
underscore).
> > > So keeping _name in mixed case unnecessarily complicates name->type l=
ookup.
> > >=20
> > > These mixed case + case-insensitive is what made lookup
> > > code over-engineered and overly complex. =20
> >=20
> > I'm fine with making all the lookups case insensitive.  I just don't
> > want to drop the case on the names in the actual code.
> I've tried to find a way but considering that names are statically
> 'converted' into typenames and lack of ability to magically
> uppercase them with preprocessor, I've gave up on this approach.

Ok.

> Providing that there is _desc with model name that should be
> greppable in spec and complexity of lookup code that mixed-cased
> typenames incur, I've opted in favor of simplifying lookup
> code at expense uniform typenames (which is inter QEMU thingy).
> It is easier to maintain and less chances to make mistake.

Yeah, I guess.  It just looks weird to have non-standard capsing in
the table field.

Any chance we could standardize on lowercase rather than upper - for
some reason that would seem less odd to me (I guess because C-ish
names and identifiers are usually lowercased).

> Other targets use exact match for cpu_model so whether
> they use mixed casing or not doesn't matter.
>=20
> > > As result it evolved (regressed) to inconsistent name handling
> > > since it's rather hard to understand what's going on there. =20
> >=20
> > Yeah, I know :/.
> >=20
> > > > Can we instead retain mixed case in the table, and capitalize both
> > > > sides at the comparison time? =20
> > > it has to be the same-case since PPC has case-insensitive cpu_model
> > > matching (sometimes :/). Normalized /same case/ typenames
> > > are necessary for object_class_by_name() to work as it does exact mat=
ch.
> > > So it would be possible to replace custom fetching of CPU types
> > > and iterating over it with custom comparator with object_class_by_nam=
e().
> > > As it's done in 4/6.
> > > This patch and 3/6 are only preparatory patches for 4/6. =20
> >=20
> > Ah.  Hrm.  That's awkward.
> It's fine to squash all 3 in 1 patch, but then it becomes huge and
> unreview-able, as logic changes are buried within names normalization.

Sorry, I meant it's awkward that that object_class_by_name() uses exact
and so we'd need a custom iterator to do a case insensitive search.
The patch structure is fine.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DheUW4aQn8WJk6WR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmgJeAACgkQbDjKyiDZ
s5LbeRAAhetWvMZX+p2hr82cYKKhAHfkQvbBC2xUHwJkCvBLMSvFJ8sqG/mFPaQN
YsJy0LCPecbEqM4w5vsZ7xSwRyQQS19XZdgpq9VCLt+1Hkq1OGEWB6FiotW9RSAN
PhDgA+zJEv1Zb0jwTF0ohK+MiX0YSrlNlAXXJ5bNpF9ON/TSXvc08IbEJzCsk4LP
DqhIjR5GKXNenT3xOh+mfIdd/2oDJTugmXG5BXYRXr4LS/CVAh74q2+rqpEKACke
KnzvilfrhivPCZPg8ZjCxR//QFvwyoEqyB1le6mfBM4GyZxvMOdtJ/sbeIst+v5y
y/RcZT2lmU2RJqW1b1+kuwrw9SD8L4yUgJAJ+vUaPiZ5+Gr70gXjkQI4lYkKJnrU
WjigKea3A4Yx870OlTKvzFyPO99P0C0CN1Sr97A+RUwzqGzwuiD4jBrFpVshiym6
k5bwHTKYwh+K4cmkLMeiADoneKt2OVKyU2QFWCRXlLsYbi/VGpJJDr4jAAuNIzIQ
Su6T839iruvRGDKUzNyZGvLztVgkNeVnPuI4rXYBZWnKOcJjn63jeLYpVehdeuOf
HlVvVLZ9bG+6zuOpVuP0qvrhIhsr0Lz0+i9viuNUXL4D/YlfXTmztBNeZyXaqjvL
/W2Gdj2ZmPMbEiYfe6bq7ZU3lgYi9bf1F2bBvBljy0BXugdtLF8=
=ouvS
-----END PGP SIGNATURE-----

--DheUW4aQn8WJk6WR--
