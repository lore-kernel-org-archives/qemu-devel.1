Received: from eggs.gnu.org ([2001:4830:134:3::10]:40575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ckz1S-00040d-0U
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 15:14:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ckz1R-0001G7-0Q
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 15:14:22 -0500
References: <20170306195255.15806-1-mreitz@redhat.com>
	<20170306195434.16782-1-mreitz@redhat.com>
	<ad414a21-b74e-8f25-1b1e-024c0db7986a@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c694ca93-5c15-40f2-10e5-40fbead92209@redhat.com>
Date: Mon, 6 Mar 2017 21:14:11 +0100
MIME-Version: 1.0
In-Reply-To: <ad414a21-b74e-8f25-1b1e-024c0db7986a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pEDtH1HmLkFqAR2Ot9Guhs0CjK5hTmjAc"
Subject: Re: [Qemu-devel] [PATCH for-2.10 3/3] block: Add some
 bdrv_truncate() error messages
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
--pEDtH1HmLkFqAR2Ot9Guhs0CjK5hTmjAc
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <c694ca93-5c15-40f2-10e5-40fbead92209@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 3/3] block: Add some bdrv_truncate()
 error messages
References: <20170306195255.15806-1-mreitz@redhat.com>
 <20170306195434.16782-1-mreitz@redhat.com>
 <ad414a21-b74e-8f25-1b1e-024c0db7986a@redhat.com>
In-Reply-To: <ad414a21-b74e-8f25-1b1e-024c0db7986a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.03.2017 21:09, Eric Blake wrote:
> On 03/06/2017 01:54 PM, Max Reitz wrote:
>> Add missing error messages for the drivers I am comfortable to do this=

>> in.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/file-posix.c | 8 +++++++-
>>  block/qcow2.c      | 2 ++
>>  block/qed.c        | 4 +++-
>>  block/raw-format.c | 2 ++
>>  4 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/file-posix.c b/block/file-posix.c
>> index 9d2bea730d..553213221c 100644
>> --- a/block/file-posix.c
>> +++ b/block/file-posix.c
>> @@ -1341,20 +1341,26 @@ static int raw_truncate(BlockDriverState *bs, =
int64_t offset, Error **errp)
>>  {
>>      BDRVRawState *s =3D bs->opaque;
>>      struct stat st;
>> +    int ret;
>> =20
>>      if (fstat(s->fd, &st)) {
>> -        return -errno;
>> +        ret =3D -errno;
>> +        error_setg_errno(errp, -ret, "Failed to fstat() the file");
>> +        return ret;
>>      }
>> =20
>>      if (S_ISREG(st.st_mode)) {
>>          if (ftruncate(s->fd, offset) < 0) {
>> +            /* The generic error message will be fine */
>>              return -errno;
>=20
> Relying on a generic error message in the caller is awkward. I see it a=
s
> evidence of a partial conversion if we have an interface that requires =
a
> return of a negative errno value to make up for when errp is not set.

I'm not sure what you mean by this exactly. I can agree that it's not
nice within a single driver. But I think it's fine to have some drivers
that generate an Error object and others that do not, as long as the
generic interface (bdrv_truncate()) masks this behavior.

>                                                                        =
I
> know you aren't comfortable converting all drivers, but for the drivers=

> you do convert, I'd rather guarantee that ALL errors set errp.

Can do, I just felt bad that it be would exactly the same as the message
that would be generated in bdrv_truncate() anyway.

Max


--pEDtH1HmLkFqAR2Ot9Guhs0CjK5hTmjAc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAli9wxMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Am9QH/1ZNs4bTtUelDegV33AaE3oeqDl/gLnM
+IBsS2iBxhczO7H/Z/47O+gv2nKh8TrYwD0PTKEaMvmkNIehuHXDDO3UEm4pedDL
kwlpkICXTT4jouwOgZ0F4PrWnPsmZK9aO+j2VI2qAHEOAvcYCZnC4+X+LQ3BImsf
96q0MUh1oD4RL3MDWTw57tdytvjviyTlbLR+/dL4Tjf1Ol5jbQ0xDTHenMTFncWx
CwsE82fd+IniCV7Cv4nBsQgsseAwizJMmm+8I8agNBA2lgIu7H+QV4E39KEON2hx
WzZDaLlsvTm6PagJ4BtU5T4x0Ikqt140n7h7tvoNpTFthkNFnj87MTc=
=PQHu
-----END PGP SIGNATURE-----

--pEDtH1HmLkFqAR2Ot9Guhs0CjK5hTmjAc--
