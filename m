Received: from eggs.gnu.org ([2001:4830:134:3::10]:49911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gN1MF-0006C8-KI
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 15:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gN1ME-00075i-Cn
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 15:01:51 -0500
References: <20180809223117.7846-1-mreitz@redhat.com>
	<20180809223117.7846-8-mreitz@redhat.com>
	<c85988da-52e7-b035-8985-d96780678dde@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <084563e1-9074-6fc4-1b36-391afb351e62@redhat.com>
Date: Wed, 14 Nov 2018 21:01:09 +0100
MIME-Version: 1.0
In-Reply-To: <c85988da-52e7-b035-8985-d96780678dde@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="yFPaxRrZoNtttnBtdn6z24ji2WTkaj1hW"
Subject: Re: [Qemu-devel] [PATCH v2 07/11] block: Leave BDS.backing_file
 constant
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yFPaxRrZoNtttnBtdn6z24ji2WTkaj1hW
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <084563e1-9074-6fc4-1b36-391afb351e62@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 07/11] block: Leave BDS.backing_file
 constant
References: <20180809223117.7846-1-mreitz@redhat.com>
 <20180809223117.7846-8-mreitz@redhat.com>
 <c85988da-52e7-b035-8985-d96780678dde@redhat.com>
In-Reply-To: <c85988da-52e7-b035-8985-d96780678dde@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.11.18 00:08, Eric Blake wrote:
> On 8/9/18 5:31 PM, Max Reitz wrote:
>> Parts of the block layer treat BDS.backing_file as if it were whatever=

>> the image header says (i.e., if it is a relative path, it is relative =
to
>> the overlay), other parts treat it like a cache for
>> bs->backing->bs->filename (relative paths are relative to the CWD).
>> Considering bs->backing->bs->filename exists, let us make it mean the
>> former.
>>
>> Among other things, this now allows the user to specify a base when
>> using qemu-img to commit an image file in a directory that is not the
>> CWD (assuming, everything uses relative filenames).
>>
>> Before this patch:
>>
>> $ ./qemu-img create -f qcow2 foo/bot.qcow2 1M
>> $ ./qemu-img create -f qcow2 -b bot.qcow2 foo/mid.qcow2
>> $ ./qemu-img create -f qcow2 -b mid.qcow2 foo/top.qcow2
>> $ ./qemu-img commit -b mid.qcow2 foo/top.qcow2
>> qemu-img: Did not find 'mid.qcow2' in the backing chain of
>> 'foo/top.qcow2'
>> $ ./qemu-img commit -b foo/mid.qcow2 foo/top.qcow2
>> qemu-img: Did not find 'foo/mid.qcow2' in the backing chain of
>> 'foo/top.qcow2'
>> $ ./qemu-img commit -b $PWD/foo/mid.qcow2 foo/top.qcow2
>> qemu-img: Did not find '[...]/foo/mid.qcow2' in the backing chain of
>> 'foo/top.qcow2'
>=20
> Three failures in a row - no way to commit short of changing your
> working directory.
>=20
>>
>> After this patch:
>>
>> $ ./qemu-img commit -b mid.qcow2 foo/top.qcow2
>> Image committed.
>> $ ./qemu-img commit -b foo/mid.qcow2 foo/top.qcow2
>> qemu-img: Did not find 'foo/mid.qcow2' in the backing chain of
>> 'foo/top.qcow2'
>> $ ./qemu-img commit -b $PWD/foo/mid.qcow2 foo/top.qcow2
>> Image committed.
>=20
> Yay, that looks saner.
>=20
>>
>> With this change, bdrv_find_backing_image() must look at whether the
>> user has overridden a BDS's backing file.=C2=A0 If so, it can no longe=
r use
>> bs->backing_file, but must instead compare the given filename against
>> the backing node's filename directly.
>>
>> Note that this changes the QAPI output for a node's backing_file.=C2=A0=
 We
>> had very inconsistent output there (sometimes what the image header
>> said, sometimes the actual filename of the backing image).=C2=A0 This
>> inconsistent output was effectively useless, so we have to decide one
>> way or the other.=C2=A0 Considering that bs->backing_file usually at r=
untime
>> contained the path to the image relative to qemu's CWD (or absolute),
>> this patch changes QAPI's backing_file to always report the
>> bs->backing->bs->filename from now on.=C2=A0 If you want to receive th=
e image
>> header information, you have to refer to full-backing-filename.
>>
>> This necessitates a change to iotest 228.=C2=A0 The interesting inform=
ation
>> it really wanted is the image header, and it can get that now, but it
>> has to use full-backing-filename instead of backing_file.=C2=A0 Becaus=
e of
>> this patch's changes to bs->backing_file's behavior, we also need some=

>> reference output changes.
>>
>> Along with the changes to bs->backing_file, stop updating
>> BDS.backing_format in bdrv_backing_attach() as well.=C2=A0 This necess=
itates
>> a change to the reference output of iotest 191.
>=20
> Good explanations for the test changes.
>=20
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 include/block/block_int.h=C2=A0 | 14 +++++++++-----
>> =C2=A0 block.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 29 ++++++++++=
++++++++++++-------
>> =C2=A0 block/qapi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++++---
>> =C2=A0 qemu-img.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 ++++++++++--
>> =C2=A0 tests/qemu-iotests/191.out |=C2=A0 1 -
>> =C2=A0 tests/qemu-iotests/228=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++---=

>> =C2=A0 tests/qemu-iotests/228.out |=C2=A0 6 +++---
>> =C2=A0 7 files changed, 51 insertions(+), 24 deletions(-)
>>
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index d3d8b22155..8f2c515ec1 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -737,11 +737,15 @@ struct BlockDriverState {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool walking_aio_notifiers; /* to make =
removal during iteration
>> safe */
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char filename[PATH_MAX];
>> -=C2=A0=C2=A0=C2=A0 char backing_file[PATH_MAX]; /* if non zero, the i=
mage is a diff of
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 this f=
ile image */
>> -=C2=A0=C2=A0=C2=A0 /* The backing filename indicated by the image hea=
der; if we ever
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * open this file, then this is replaced by t=
he resulting BDS's
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * filename (i.e. after a bdrv_refresh_filena=
me() run). */
>> +=C2=A0=C2=A0=C2=A0 /* If non-zero, the image is a diff of this image =
file.=C2=A0 Note that
>=20
> Pre-existing, but that sentence might read nicer as:
>=20
> If not empty, this image is a diff in relation to backing_file.
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * this the name given in the image header an=
d may therefore not
>=20
> "this the name" is wrong; did you mean "this is the name" or "this name=
"
> or "the name"?

Would any of the latter two make more grammatical sense? O:-)

Will fix.

I'll also fix the "may" wording.  Like this it sounds as if this is not
allowed to be equal to .backing->bs->filename, which of course is not
true.  It may or may not be equal.  So, I'll reword to:

"If not empty, this image is a diff in relation to backing_file.  Note
that this is the name given in the image header and therefore may or may
not be equal to .backing->bs->filename.  If this field contains a
relative path, it is to be resolved relatively to the overlay's location.=
"


Thanks for reviewing!

Max

>> +=C2=A0=C2=A0=C2=A0=C2=A0 * be equal to .backing->bs->filename, and re=
lative paths are
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * resolved relatively to their overlay. */
>> +=C2=A0=C2=A0=C2=A0 char backing_file[PATH_MAX];
>> +=C2=A0=C2=A0=C2=A0 /* The backing filename indicated by the image hea=
der.=C2=A0 Contrary
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * to backing_file, if we ever open this file=
, auto_backing_file
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * is replaced by the resulting BDS's filenam=
e (i.e. after a
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * bdrv_refresh_filename() run). */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char auto_backing_file[PATH_MAX];
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char backing_format[16]; /* if non-zero=
 and backing_file exists */
>> =C2=A0=20
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20



--yFPaxRrZoNtttnBtdn6z24ji2WTkaj1hW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvsfwUACgkQ9AfbAGHV
z0BJmAgApB6LQXIbhhDHeVMfdpfMjzbbh/w/kt4Pi9ivGxmv+0xifzSsHgfcO91m
LVCO85i5/jOWQaNa6l4TO8HOmYdv9s2UKTFhBDkb/0bzRkgtkgG+z0XO2ZK3L1UR
opsRzybvmGjtgWZtEvjO4ytMoOjgQpAvMVlD0hSsaRls0tZs+VgDFJAy/TdJWvY7
eGLt3rB2I96XZxkp6T9zXCW5za5HLRakjVQ5JyZzeCzyZLIKe++cveP1inHO2gMF
KlVmcQkymUWomLX5XsU4jq06DQUelJ9CzlKbS/6IM0XtnAe5rNUrL1CArDTHG55F
/e0Y+/KllmImYpFMxpbf4ev1u3ABNQ==
=A2qc
-----END PGP SIGNATURE-----

--yFPaxRrZoNtttnBtdn6z24ji2WTkaj1hW--
