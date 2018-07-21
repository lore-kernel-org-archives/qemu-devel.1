Received: from eggs.gnu.org ([2001:4830:134:3::10]:44941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fgzBc-0007j3-OT
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 17:13:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fgzBb-0008HV-M8
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 17:13:08 -0400
References: <20180713111424.23670-1-mreitz@redhat.com>
	<20180713111424.23670-3-mreitz@redhat.com>
	<dbe0d208-1df1-07c4-b65f-7606596de289@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3fd8d5fd-8fb9-0e4c-8bdb-ccbd64d5cf91@redhat.com>
Date: Sat, 21 Jul 2018 23:13:00 +0200
MIME-Version: 1.0
In-Reply-To: <dbe0d208-1df1-07c4-b65f-7606596de289@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wWy2AdSa5b6Vx8YazDYBkCYp8SKmiErBT"
Subject: Re: [Qemu-devel] [PATCH 2/3] qemu-img: Use zero writes after source
 backing EOF
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
--wWy2AdSa5b6Vx8YazDYBkCYp8SKmiErBT
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <3fd8d5fd-8fb9-0e4c-8bdb-ccbd64d5cf91@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] qemu-img: Use zero writes after source
 backing EOF
References: <20180713111424.23670-1-mreitz@redhat.com>
 <20180713111424.23670-3-mreitz@redhat.com>
 <dbe0d208-1df1-07c4-b65f-7606596de289@redhat.com>
In-Reply-To: <dbe0d208-1df1-07c4-b65f-7606596de289@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-07-20 23:22, Eric Blake wrote:
> On 07/13/2018 06:14 AM, Max Reitz wrote:
>> Past the end of the source backing file, we memset() buf_old to zero, =
so
>> it is clearly easy to use blk_pwrite_zeroes() instead of blk_pwrite()
>> then.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 qemu-img.c | 11 +++++++++--
>> =C2=A0 1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/qemu-img.c b/qemu-img.c
>> index dd684d8bf0..2552e7dad6 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -3403,6 +3403,8 @@ static int img_rebase(int argc, char **argv)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (off=
set =3D 0; offset < size; offset +=3D n) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bo=
ol buf_old_is_zero =3D false;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* How many bytes can we handle with the next read? */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 n =3D MIN(IO_BUF_SIZE, size - offset);
>> =C2=A0 @@ -3423,6 +3425,7 @@ static int img_rebase(int argc, char **ar=
gv)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (offset >=3D old_backing_size) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(buf_old, 0, n);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 buf_old_is_zero =3D true;
>=20
> Do we still need to spend time on the memset(), or...
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (offset + n > old_backing_size) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 n =3D old_backing_=
size - offset;
>> @@ -3458,8 +3461,12 @@ static int img_rebase(int argc, char **argv)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (compare_buffers(buf_old + written, buf=
_new +
>> written,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 n - written, &pnum))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D blk_pwrite(blk, off=
set + written,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
buf_old + written, pnum, 0);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (buf_old_is_zero) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D blk_pwrite_zeroes(blk, offset +
>> written, pnum, 0);
>=20
> ...are we able to guarantee that old_buf will not be used when
> buf_old_is_zero?

It will certainly be used, as it is used in the compare_buffers() call.

It could be optimized, but I fear that may lead down a small rabbit hole
(we could then also get the block status of the target backing file, see
whether it is zero, and so on).  Considering that rebase is probably not
something many people use all the time, I think it=E2=80=99s OK to be slo=
wer
than possible for now.  (Until someone complains.)

Max

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D blk_pwrite(blk, offset + written,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 buf_old + written, pnum, 0);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 error_report("Error while writing to COW
>> image: %s",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 strerror(-ret));
>>
>=20
> The series seems reasonable, but is post-3.0 material, so I haven't
> reviewed it any closer than this question.
>=20



--wWy2AdSa5b6Vx8YazDYBkCYp8SKmiErBT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAltTodwACgkQ9AfbAGHV
z0AwpAf/btCGNmDnK+AOwDnheLdTD8BkP68skKZTYEH5y9rl2HmQiTLb5aRPn1UI
1WYZss7bYaVe0RshsQkzOo+XiMpiWIU/+Ww7HMEhDoZwfH4+gqcsJTYMH00ezv7F
JRM4a7Ucvk6z0cYueISwapV/q9D/60mnmHgDuKKuq3ULzcDbV83Kmed1zG8XfWcr
/SxK9XlhTcfYE47zku4pV3kGtEeWkHWE8CgAHSlsrjVyeUXcg08dly4V2jXZzsEo
ZSCX2r1WX46RnfJ9wNgtrE61b8hNPQsCBJyTjGaBEY7SbscvLU33/fKDNiT9gjb9
Col6QnZNatmTBl8pOWL8YXO3wcrtwg==
=tRUi
-----END PGP SIGNATURE-----

--wWy2AdSa5b6Vx8YazDYBkCYp8SKmiErBT--
