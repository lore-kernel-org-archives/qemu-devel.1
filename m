Received: from eggs.gnu.org ([209.51.188.92]:33946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hJIMB-0008ST-N7
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:54:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hJIAh-0005Dq-1U
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:42:47 -0400
References: <20180713111424.23670-1-mreitz@redhat.com>
	<20180713111424.23670-3-mreitz@redhat.com>
	<cec09e49-6702-cb66-e668-42d728800a75@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0bf6aa98-3792-40bd-6520-f8ba419455d7@redhat.com>
Date: Wed, 24 Apr 2019 15:42:41 +0200
MIME-Version: 1.0
In-Reply-To: <cec09e49-6702-cb66-e668-42d728800a75@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UNxDxx9xL2ZSmtfEJSlAjub3m4iJPbTAn"
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
--UNxDxx9xL2ZSmtfEJSlAjub3m4iJPbTAn
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <0bf6aa98-3792-40bd-6520-f8ba419455d7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] qemu-img: Use zero writes after source
 backing EOF
References: <20180713111424.23670-1-mreitz@redhat.com>
 <20180713111424.23670-3-mreitz@redhat.com>
 <cec09e49-6702-cb66-e668-42d728800a75@redhat.com>
In-Reply-To: <cec09e49-6702-cb66-e668-42d728800a75@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.04.19 20:59, Eric Blake wrote:
> On 7/13/18 6:14 AM, Max Reitz wrote:
>> Past the end of the source backing file, we memset() buf_old to zero, =
so
>> it is clearly easy to use blk_pwrite_zeroes() instead of blk_pwrite()
>> then.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  qemu-img.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>=20
>> @@ -3458,8 +3461,12 @@ static int img_rebase(int argc, char **argv)
>>                  if (compare_buffers(buf_old + written, buf_new + writ=
ten,
>>                                      n - written, &pnum))
>>                  {
>> -                    ret =3D blk_pwrite(blk, offset + written,
>> -                                     buf_old + written, pnum, 0);
>> +                    if (buf_old_is_zero) {
>> +                        ret =3D blk_pwrite_zeroes(blk, offset + writt=
en, pnum, 0);
>=20
> Should we allow BDRV_REQ_MAY_UNMAP here, either unconditionally, or
> based on a command line knob that told us whether the user is more
> interested in a sparse result (that still reads as zero) vs. a
> fully-allocated result?

I wouldn=E2=80=99t trust that.  We haven=E2=80=99t yet switched to the ne=
w backing file
at this point, so I think a driver would be correct in handling such
requests by punching a hole in the file -- which would lead to the new
backing file poking through once we=E2=80=99ve switched to it.

Max

> Reviewed-by: Eric Blake <eblake@redhat.com>



--UNxDxx9xL2ZSmtfEJSlAjub3m4iJPbTAn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzAZ9EACgkQ9AfbAGHV
z0ANUgf9HgjsPsrvGPUZvs/281P2a9XloQt6lnutxa1Q97wvlOf7F9sOqBhZpcMR
NOFtrTbN81CBVOHjuSpP7rZUuXkML7LX65+vuF4b4/sw8nsU9uRz0bBPmW7WtLOR
Zmnw4mIQSa6uKV13eeo5RPCtQ7uL1MlrZvpQzPZMsYKx+PAauYu5pQ7xrEJv+1Sh
qrpZrrOMNQxatNgelcNY6ghXroWX8PmnmVE1A/sWLUhr3kMJ2A7tsjsJE2YYLFEV
qKvVr3uhM4PDMXAmNeV1ZE4QvD/YABrQatVCAOKQ5ZUErohVmYef0AhDhCZFm5L4
gb78iAT6ogqin0mLKkpKwHjCvay9GQ==
=cU4U
-----END PGP SIGNATURE-----

--UNxDxx9xL2ZSmtfEJSlAjub3m4iJPbTAn--
