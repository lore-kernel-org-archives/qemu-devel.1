Received: from eggs.gnu.org ([2001:4830:134:3::10]:40738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fq7tD-0000Y6-P4
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 22:19:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fq7tB-0002yE-Gr
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 22:19:55 -0400
References: <20180815025614.53588-1-eblake@redhat.com>
	<20180815025614.53588-2-eblake@redhat.com>
	<222b07f8-4a41-04f5-c93c-727244e6d1e8@redhat.com>
	<7ac0b1de-dada-33a9-30f1-5c5122982284@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <81792fb8-72c4-08ca-1673-fb2f6afda6b3@redhat.com>
Date: Thu, 16 Aug 2018 04:19:38 +0200
MIME-Version: 1.0
In-Reply-To: <7ac0b1de-dada-33a9-30f1-5c5122982284@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mT0emrqUcpD4jfPxrh0fPf1e3PobnHOWx"
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-img: Fix dd with skip= and count=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: fullmanet@gmail.com, qemu-block@nongnu.org, qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mT0emrqUcpD4jfPxrh0fPf1e3PobnHOWx
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: fullmanet@gmail.com, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <81792fb8-72c4-08ca-1673-fb2f6afda6b3@redhat.com>
Subject: Re: [PATCH 1/2] qemu-img: Fix dd with skip= and count=
References: <20180815025614.53588-1-eblake@redhat.com>
 <20180815025614.53588-2-eblake@redhat.com>
 <222b07f8-4a41-04f5-c93c-727244e6d1e8@redhat.com>
 <7ac0b1de-dada-33a9-30f1-5c5122982284@redhat.com>
In-Reply-To: <7ac0b1de-dada-33a9-30f1-5c5122982284@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-16 04:17, Eric Blake wrote:
> On 08/15/2018 09:03 PM, Max Reitz wrote:
>=20
>>> @@ -4559,19 +4559,23 @@ static int img_dd(int argc, char **argv)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> +=C2=A0=C2=A0=C2=A0 /* Overflow means the specified offset is beyond =
input image's
>>> size */
>>> +=C2=A0=C2=A0=C2=A0 if (dd.flags & C_SKIP && (in.offset > INT64_MAX /=
 in.bsz ||
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size < in.bsz * in.offset)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size =3D 0;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("%s: cannot =
skip to specified offset",
>>> in.filename);
>>
>> in_pos should be initialized as well (to "size", I suppose), or my gcc=

>> will continue to complain. :-)
>>
>=20
> Serves me right for compiling with -g instead of -O2 (gcc only does tha=
t
> warning on optimized builds, for some weird reason).=C2=A0 Will fix in =
v2.
>=20
>=20
>>> +++ b/tests/qemu-iotests/160
>>> @@ -44,6 +44,7 @@ _supported_os Linux
>>> =C2=A0 TEST_SKIP_BLOCKS=3D"1 2 30 30K"
>>>
>>> =C2=A0 for skip in $TEST_SKIP_BLOCKS; do
>>> +=C2=A0 for count in '' 'count=3D1 '; do
>>
>> Ah, so this is why we indent everything by four spaces!=C2=A0 So you c=
an
>> squeeze in three more block headers without having to re-indent
>> everything.=C2=A0 I finally see. O:-)
>=20
> I'm seriously thinking of reindenting things in this and the next patch=
,
> rather than my initial quick-and-dirty "squeeze it in".=C2=A0 'git diff=
 -w'
> is not that hard to use, after all.
>=20
>>
>> (Not sure why you put a space after the 'count=3D1', though, but OK)
>=20
> For this line:
>=20
> +=C2=A0=C2=A0=C2=A0 echo "=3D=3D Converting the image with dd with ${co=
unt}skip=3D$skip =3D=3D"
>=20
> so that when $count is empty, the .out file doesn't end up with a doubl=
e
> space.=C2=A0 Okay, I do have some sense of output aesthetics, even if m=
y
> re-indentation skills are lacking ;=3D)

Ah, right, I forgot you'd get the double space.  That's true.

Max


--mT0emrqUcpD4jfPxrh0fPf1e3PobnHOWx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt03zoACgkQ9AfbAGHV
z0Abcgf/cbDayaEItqbcX02twiXFrSH1I3vygN7YPxlLSyBFIfs1lxecjJfMhKfh
Hzz9CvtdJIEKqJaqbaBlNfnQtm+LtmgHI/GWMNqQrs9kBVdM9pKBpd5uCBQ3Uq0x
wYfzis1c00WoCvFEYeSdjCGfSn/MPJY1BTRglxdyCPY5/r/NG9BlFyHSlqi+hg2B
R09kkLmmKmFebw8Z0tx5ThblvwBS3JfO40jO/FaU+TO1wx+eu38AtCbED1labBP3
AcNwuVVSJFw3tpZtewIlOcAR5PfRuVB9eFOhzbWtEmWD3m8H53F54TATA0cuUNIo
akzlG5hKrIjMFOiLjYC0cnFD2YLLFw==
=2WoV
-----END PGP SIGNATURE-----

--mT0emrqUcpD4jfPxrh0fPf1e3PobnHOWx--
