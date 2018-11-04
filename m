Received: from eggs.gnu.org ([2001:4830:134:3::10]:44135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gJ9Bd-000604-OV
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 23:34:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gJ9Bb-0004qR-P3
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 23:34:53 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:51011)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1gJ9BZ-0004ZM-TP
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 23:34:51 -0400
Date: Sun, 4 Nov 2018 14:27:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181104032700.GH24365@umbus.hotspot.internet-for-guests.com>
References: <20181023152306.3123-1-david@redhat.com>
	<20181023152306.3123-3-david@redhat.com>
	<87zhuudw4o.fsf@dusky.pond.sub.org>
	<4a5ef5ab-52c5-1aec-bb20-85e7c487fb98@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="smOfPzt+Qjm5bNGJ"
Content-Disposition: inline
In-Reply-To: <4a5ef5ab-52c5-1aec-bb20-85e7c487fb98@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/7] qapi: correctly parse uint64_t
 values from strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Igor Mammedov <imammedo@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--smOfPzt+Qjm5bNGJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 31, 2018 at 06:18:33PM +0100, David Hildenbrand wrote:
> On 31.10.18 15:32, Markus Armbruster wrote:
> > David Hildenbrand <david@redhat.com> writes:
> >=20
> >> Right now, we parse uint64_t values just like int64_t values, resulting
> >> in negative values getting accepted and certain valid large numbers on=
ly
> >> being representable as negative numbers. Also, reported errors indicate
> >> that an int64_t is expected.
> >>
> >> Parse uin64_t separately. We don't have to worry about ranges.
> >=20
> > The commit message should mention *why* we don't we have to worry about
> > ranges.
>=20
> "Parse uin64_t separately. We don't have to worry about ranges as far as
> I can see. Ranges are parsed and processed via start_list()/next_list()
> and friends. parse_type_int64() only has to deal with ranges as it
> reuses the function parse_str(). E.g. parse_type_size() also does not
> have to handle ranges. (I assume that we could easily reimplement
> parse_type_int64() in a similar fashion, too).
>=20
> The only thing that will change is that uint64_t properties that didn't
> expect a range will now actually bail out if a range is supplied."
>=20
> I'll do some more testing.
>=20
> >=20
> >>
> >> E.g. we can now also specify
> >>     -device nvdimm,memdev=3Dmem1,id=3Dnv1,addr=3D0xFFFFFFFFC0000000
> >> Instead of only going via negative values
> >>     -device nvdimm,memdev=3Dmem1,id=3Dnv1,addr=3D-0x40000000
> >>
> >> Resulting in the same values
> >>
> >> (qemu) info memory-devices
> >> Memory device [nvdimm]: "nv1"
> >>   addr: 0xffffffffc0000000
> >>   slot: 0
> >>   node: 0
> >>
> >=20
> > Suggest to mention this makes the string-input-visitor catch up with the
> > qobject-input-visitor, which got changed similarly in commit
> > 5923f85fb82.
>=20
> Yes, I will add that!
>=20
> >=20
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  qapi/string-input-visitor.c | 17 +++++++++--------
> >>  1 file changed, 9 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
> >> index c1454f999f..f2df027325 100644
> >> --- a/qapi/string-input-visitor.c
> >> +++ b/qapi/string-input-visitor.c
> >> @@ -247,15 +247,16 @@ error:
> >>  static void parse_type_uint64(Visitor *v, const char *name, uint64_t =
*obj,
> >>                                Error **errp)
> >>  {
> >> -    /* FIXME: parse_type_int64 mishandles values over INT64_MAX */
> >> -    int64_t i;
> >> -    Error *err =3D NULL;
> >> -    parse_type_int64(v, name, &i, &err);
> >> -    if (err) {
> >> -        error_propagate(errp, err);
> >> -    } else {
> >> -        *obj =3D i;
> >> +    StringInputVisitor *siv =3D to_siv(v);
> >> +    uint64_t val;
> >> +
> >> +    if (qemu_strtou64(siv->string, NULL, 0, &val)) {
> >=20
> > Works because qemu_strtou64() accepts negative numbers and interprets
> > them modulo 2^64.
>=20
> I will also add a comment to the description that negative numbers will
> continue to work.
>=20
> >=20
> >> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : =
"null",
> >> +                   "an uint64 value");
> >=20
> > I think this should be "a uint64 value".
>=20
> As I am not a native speaker, I will stick to your suggestion unless
> somebody else speaks up.

I am a native speaker and "a uint64 value" sounds better to me.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--smOfPzt+Qjm5bNGJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlveZwIACgkQbDjKyiDZ
s5LklxAAzrdcHBfPiuNZmVZnjleV2/KlDXtjsoE0hVNo5uvVeP1wbqhtjoR6QUZd
bRL87CIY1Q4vaYY47HklUcFnfl0Q4txhdmWl/qlKI5FFWC+g6vkyCW4tgNbjFBHj
hi44/tGdQn6hVxn+E2yMUGBCK3JQATRexEG9ruWq+nzi1OTPA6aHDOnYUjzMgl0p
kb99Y4JGk38aqe4ORJCyXRwys5OPWv8OeWgQJdSXdscG0D4E4zRyiv0fd8uFjxKw
+t5n/FwjE30XOy6JMJ82+dzfGln1lgowYDKk+Y69cEDG80xh6T9z/dGef+cvGvmA
wVkB5Ky6s//eoGJ0MR07UG25Lph68SZ6T0BdEOXcF+MmNeDGHVdyKAMdEIFlh7ap
fdIpdBUMKCjhOxtEoqqbI2xRvAGkVfeIPV8slQWVOVdcbEcfx6+/oMaRSHe/Q/9f
NdlVfVnYF3pruMolsruxnO4zMskZbmccHm8nw/jjir9iWtmLTRBxbpntpnGv2bCA
nJyTVwjmnt9LOoScehKdcEDunZbaej0uLT6gq1QBaRDljcfFvMQX9SSuogUpqma6
LF4SGpXE4oLwDK+FKPtLBT5mG6r0l157kedI2iCQYsny1ND47EnW07/dOlmhMllT
9vcwDLHG2Cp5B1upjjAmMLmGBfHqoP0Pb4VwIAzxb+cj1IaQTdE=
=5JS1
-----END PGP SIGNATURE-----

--smOfPzt+Qjm5bNGJ--
