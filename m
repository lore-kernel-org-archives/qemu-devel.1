Received: from eggs.gnu.org ([2001:4830:134:3::10]:60631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gFh5S-0004Pv-Pd
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gFgus-0007tE-LQ
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:21 -0400
Received: from ozlabs.org ([203.11.71.1]:57113)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1gFgur-0007hd-EI
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:18 -0400
Date: Thu, 25 Oct 2018 15:41:07 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181025144107.GB2697@umbus.hotspot.internet-for-guests.com>
References: <20181023152306.3123-1-david@redhat.com>
	<20181023152306.3123-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline
In-Reply-To: <20181023152306.3123-3-david@redhat.com>
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
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 23, 2018 at 05:23:01PM +0200, David Hildenbrand wrote:
> Right now, we parse uint64_t values just like int64_t values, resulting
> in negative values getting accepted and certain valid large numbers only
> being representable as negative numbers. Also, reported errors indicate
> that an int64_t is expected.
>=20
> Parse uin64_t separately. We don't have to worry about ranges.
>=20
> E.g. we can now also specify
>     -device nvdimm,memdev=3Dmem1,id=3Dnv1,addr=3D0xFFFFFFFFC0000000
> Instead of only going via negative values
>     -device nvdimm,memdev=3Dmem1,id=3Dnv1,addr=3D-0x40000000
>=20
> Resulting in the same values
>=20
> (qemu) info memory-devices
> Memory device [nvdimm]: "nv1"
>   addr: 0xffffffffc0000000
>   slot: 0
>   node: 0
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  qapi/string-input-visitor.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
> index c1454f999f..f2df027325 100644
> --- a/qapi/string-input-visitor.c
> +++ b/qapi/string-input-visitor.c
> @@ -247,15 +247,16 @@ error:
>  static void parse_type_uint64(Visitor *v, const char *name, uint64_t *ob=
j,
>                                Error **errp)
>  {
> -    /* FIXME: parse_type_int64 mishandles values over INT64_MAX */
> -    int64_t i;
> -    Error *err =3D NULL;
> -    parse_type_int64(v, name, &i, &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -    } else {
> -        *obj =3D i;
> +    StringInputVisitor *siv =3D to_siv(v);
> +    uint64_t val;
> +
> +    if (qemu_strtou64(siv->string, NULL, 0, &val)) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : "nu=
ll",
> +                   "an uint64 value");
> +        return;
>      }
> +
> +    *obj =3D val;
>  }

It's not obvious to me why this looks so different from the code in
parse_type_int64().  Should we be using qemu_strtoi64() in the
pre-existing function, instead of what's there now?

> =20
>  static void parse_type_size(Visitor *v, const char *name, uint64_t *obj,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvR1gMACgkQbDjKyiDZ
s5LFbw/9FtqrNYBIwvTCCtbxups7Ex2/dfNIFZdDj1VSa2zWcqSN98bOCGCjoAcr
mEyV/gSfXvZo7waQNFpn/nlD8+EEhYYbQBV7ns+fN9YE2ReYUZTWDCiixWzXqx16
qcjnUd5P0g3YpPgQKMO1DxywJ6/usZqkB0+bI52bbsfkMSnxcSvX82UCwShUfh0l
ySa0DrupTx803uJBgQUtYgi/C/jr3lOvPx1I+dcJl/AAXIyTaGkfnirhlNFD8+mZ
RDRiPqJkDfFUkWjQPjzkXvKNe8gwANHnIJMYMNiQVUA1K9vsIAfO0B2OxZ6l+6Dy
uH59Fxe4NtGk0IDGgYKIiaFsHzdCuMTaXmHKFcXmyTMFve06slhCA9er0HUp+ZAI
MR6UmJduwnFk5qD/aqXQ0DeQ0p/EOvDMJ5l4Z97mLHmG8ndqTHEr+8Qy/OhQ8PKO
iMSjCHBV8HlJZoKU6wPVWi+xremG1hlNOgv94WO3R7qemznvvTbMMPiL5+PN6Vgg
JRf+NVaQJ0zlIqnjNIatiiTUV228QSNYb5Lu4vhxycSygMEKfvqn1qSHRhZ0GjMO
4eg4z6hUtCNN1A3S8yz5fdq27KrSa0DifIEwCwUqr5IqwPeeOEB+FLondTyxt2hb
163Suwkz1GMK073uQAmUA09Jsods92O4dRHK04aWiaYVd1SPWSA=
=btHV
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
