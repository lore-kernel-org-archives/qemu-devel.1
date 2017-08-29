Received: from eggs.gnu.org ([2001:4830:134:3::10]:51279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dmeIE-0005r7-Ib
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 07:02:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dmeI8-0001H6-CQ
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 07:02:50 -0400
Date: Tue, 29 Aug 2017 17:26:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170829072657.GL2578@umbus.fritz.box>
References: <1503562911-2776-1-git-send-email-imammedo@redhat.com>
	<1503562911-2776-3-git-send-email-imammedo@redhat.com>
	<20170825013819.GQ5379@umbus.fritz.box>
	<20170825092740.239b6a82@nial.brq.redhat.com>
	<20170825094538.GI2772@umbus.fritz.box>
	<20170825134007.73d69fa3@nial.brq.redhat.com>
	<20170825132800.GM2772@umbus.fritz.box>
	<20170825163426.234753d4@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7ArrI7P/b+va1vZ8"
Content-Disposition: inline
In-Reply-To: <20170825163426.234753d4@nial.brq.redhat.com>
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


--7ArrI7P/b+va1vZ8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2017 at 04:34:26PM +0200, Igor Mammedov wrote:
> On Fri, 25 Aug 2017 23:28:00 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, Aug 25, 2017 at 01:40:07PM +0200, Igor Mammedov wrote:
> > > On Fri, 25 Aug 2017 19:45:38 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >  =20
> > > > On Fri, Aug 25, 2017 at 09:27:40AM +0200, Igor Mammedov wrote: =20
> > > > > On Fri, 25 Aug 2017 11:38:19 +1000
> > > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > >    =20
> > > > > > On Thu, Aug 24, 2017 at 10:21:47AM +0200, Igor Mammedov wrote: =
  =20
> > > > > > > PPC handles -cpu FOO rather incosistently,
> > > > > > > i.e. it does case-insensitive matching of FOO to
> > > > > > > a CPU type (see: ppc_cpu_compare_class_name) but
> > > > > > > handles alias names as case-sensitive, as result:
> > > > > > >=20
> > > > > > >  # qemu-system-ppc64 -M mac99 -cpu g3
> > > > > > >  qemu-system-ppc64: unable to find CPU model ' kN=EF=BF=BDU'
> > > > > > >=20
> > > > > > >  # qemu-system-ppc64 -cpu 970MP_V1.1
> > > > > > >  qemu-system-ppc64: Unable to find sPAPR CPU Core definition
> > > > > > >=20
> > > > > > > while
> > > > > > >=20
> > > > > > >  # qemu-system-ppc64 -M mac99 -cpu G3
> > > > > > >  # qemu-system-ppc64 -cpu 970MP_v1.1
> > > > > > >=20
> > > > > > > start up just fine.
> > > > > > >=20
> > > > > > > Considering we can't take case-insensitive matching away,
> > > > > > > make it case-insensitive for  all alias/type/core_type
> > > > > > > lookups.
> > > > > > >=20
> > > > > > > As side effect it allows to remove duplicate core types
> > > > > > > which are the same but use lower-case letters in name.
> > > > > > >=20
> > > > > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>     =20
> > > > > >=20
> > > > > > Hmm.  So, I'm certainly good with making the matching more cons=
istent,
> > > > > > and removing extra entries differing only in case.
> > > > > >=20
> > > > > > However, I don't like capitalizing everything in the model tabl=
e.  The
> > > > > > "canonical" capitalization - as in how it appears in manuals and
> > > > > > marketing info - is quite frequently mixed case.  So I think ma=
king
> > > > > > everything caps in the table will make it harder to read in the
> > > > > > context of looking at the corresponding documentation.   =20
> > > > > only cpu models =3D> typenames are made caps, the rest   =20
> > > >=20
> > > > Yes, I know.  A number of the CPU model names themselves have mixed
> > > > case.  Really.
> > > >  =20
> > > > > incl. description is kept as is in mixed case.
> > > > > It looks like _desc is the thing one would use for
> > > > > 1:1 lookup in spec, while _name isn't direct match consistently
> > > > > (i.e. sometimes it skips spaces and sometimes spaces are replaced=
 by underscore).
> > > > > So keeping _name in mixed case unnecessarily complicates name->ty=
pe lookup.
> > > > >=20
> > > > > These mixed case + case-insensitive is what made lookup
> > > > > code over-engineered and overly complex.   =20
> > > >=20
> > > > I'm fine with making all the lookups case insensitive.  I just don't
> > > > want to drop the case on the names in the actual code. =20
> > > I've tried to find a way but considering that names are statically
> > > 'converted' into typenames and lack of ability to magically
> > > uppercase them with preprocessor, I've gave up on this approach. =20
> >=20
> > Ok.
> >=20
> > > Providing that there is _desc with model name that should be
> > > greppable in spec and complexity of lookup code that mixed-cased
> > > typenames incur, I've opted in favor of simplifying lookup
> > > code at expense uniform typenames (which is inter QEMU thingy).
> > > It is easier to maintain and less chances to make mistake. =20
> >=20
> > Yeah, I guess.  It just looks weird to have non-standard capsing in
> > the table field.
> >=20
> > Any chance we could standardize on lowercase rather than upper - for
> > some reason that would seem less odd to me (I guess because C-ish
> > names and identifiers are usually lowercased).
> The only reason I've picked up uppercase is that diffstat is smaller
> then with lowercase.
> So if you prefer lowercase, I'll switch case in v2.

Please do, thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7ArrI7P/b+va1vZ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmlF0EACgkQbDjKyiDZ
s5J7tRAAm+ANxaGyHHEwS0ACxz3GC0azaVGoow98JmBFokW22LBw5ANMH/1IeR5j
WDdsRAJT9/tc578tiHttAM6cB/DKdHENle4Of8Kh5D/Vw0pIBWFCspvva7CrKwGv
0OU+I6h+Y8HRxzSrJigQiVqo7eR9JgXkhS5XJhl6JDRURWui1CgEafwYUiKQJETL
nHiLuHWq2Uyg+U4lqYyOIccHE9QDAr1Lhot1nqlzkFS/xVJkkutKdUMdnrMdVAUQ
u1TL/uZTa9MFR+dJFQXbV0P6LlGHgNrtjfBR2zazZGgAZhjDLuR1zyTKtRbG2442
Xmsx70ZzeapRzINxs89cVA/oBLYPeO6Qiu8FbzRGgzyhWEFJ32W7P8z/Sqw0wsYp
06ffxT1ZcX65VWvbmZwlrEftc5KmPTslWAXAihun1V3sXEskp41n/7VbHpZa37UB
oQZXqNfnqXUAsW5mqUtYo/corZA0C+1v9dXRqdcfXX3coo7Emt2sTdUMyvZgQtER
N663xzFg2P0gqYI417NCyb0B/dQmUWrdT5HWCvSnhcugTsKi3CF4/P6nUcC618z/
AQmvDXHic28vSBE+jDTyvGO5nezmwFakQ7HNRAWPgD5/ms4NtPz2hiCvwShTp7A/
Q87V0cBBpBZnnicJTcY2BwC7ELXo6vK88JTwJFlqUVPOYKH1wXg=
=YCsZ
-----END PGP SIGNATURE-----

--7ArrI7P/b+va1vZ8--
