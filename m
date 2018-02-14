Received: from eggs.gnu.org ([2001:4830:134:3::10]:55160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1em4bw-0001iY-MN
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 16:29:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1em4bv-0002mb-KJ
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 16:29:04 -0500
References: <20180214204915.7980-1-mreitz@redhat.com>
	<20180214204915.7980-3-mreitz@redhat.com>
	<eb2c00e1-eae0-7d71-b4dc-0df0054a3fb2@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <50748db3-8b75-2bb2-e194-bf4b590d61f4@redhat.com>
Date: Wed, 14 Feb 2018 22:28:40 +0100
MIME-Version: 1.0
In-Reply-To: <eb2c00e1-eae0-7d71-b4dc-0df0054a3fb2@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WBjBoRbHgnXlhMKinSjY6A9O9AjIr7tTs"
Subject: Re: [Qemu-devel] [PATCH 2/3] block/ssh: Make ssh_grow_file()
 blocking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Richard W . M . Jones" <rjones@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WBjBoRbHgnXlhMKinSjY6A9O9AjIr7tTs
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Richard W . M . Jones"
 <rjones@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Message-ID: <50748db3-8b75-2bb2-e194-bf4b590d61f4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] block/ssh: Make ssh_grow_file() blocking
References: <20180214204915.7980-1-mreitz@redhat.com>
 <20180214204915.7980-3-mreitz@redhat.com>
 <eb2c00e1-eae0-7d71-b4dc-0df0054a3fb2@redhat.com>
In-Reply-To: <eb2c00e1-eae0-7d71-b4dc-0df0054a3fb2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-14 22:11, Eric Blake wrote:
> On 02/14/2018 02:49 PM, Max Reitz wrote:
>> At runtime (that is, during a future ssh_truncate()), the SSH session =
is
>> non-blocking.=C2=A0 However, ssh_truncate() (or rather, bdrv_truncate(=
) in
>> general) is not a coroutine, so this resize operation needs to block.
>>
>> For ssh_create(), that is fine, too; the session is never set to
>> non-blocking anyway.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 block/ssh.c | 7 +++++++
>> =C2=A0 1 file changed, 7 insertions(+)
>>
>> diff --git a/block/ssh.c b/block/ssh.c
>> index 964e55f7fe..ff8576f21e 100644
>> --- a/block/ssh.c
>> +++ b/block/ssh.c
>> @@ -803,17 +803,24 @@ static int ssh_file_open(BlockDriverState *bs,
>> QDict *options, int bdrv_flags,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>> =C2=A0 +/* Note: This is a blocking operation */
>> =C2=A0 static int ssh_grow_file(BDRVSSHState *s, int64_t offset, Error=
 **errp)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ssize_t ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char c[1] =3D { '\0' };
>> +=C2=A0=C2=A0=C2=A0 int was_blocking =3D libssh2_session_get_blocking(=
s->session);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* offset must be strictly great=
er than the current size so we do
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * not overwrite anything */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(offset > 0 && offset > s->attrs.=
filesize);
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 libssh2_session_set_blocking(s->session, 1)=
;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libssh2_sftp_seek64(s->sftp_handle, off=
set - 1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D libssh2_sftp_write(s->sftp_hand=
le, c, 1);
>> +
>> +=C2=A0=C2=A0=C2=A0 libssh2_session_set_blocking(s->session, was_block=
ing);
>=20
> Is it worth skipping the two libssh2_session_set_blocking() calls if
> was_blocking is 1?=C2=A0 But that's a micro-optimization that probably =
won't
> be noticeable, so I'm also fine with unconditional.

I was hoping libssh2 is clever enough for that itself. :-)

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

Max


--WBjBoRbHgnXlhMKinSjY6A9O9AjIr7tTs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqEqggSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AuhsH/39+M/S1gVQz7xX7s3r4jspJb7AE14vd
sxDiBskjIbVQE4+KQqvYHB9X8zeE+mB/Yqu+xNrB2tb61uOALZ/F8cFKEQZyHx/G
J4Cby0lMDyFDJ6KCX4Bg8oXOgtMZje/vp7My5C3/0fpGsff+WRiOsh9Ic8ScmlY6
MslVRs/vmhMSsbk1VGGKvKxEQ25SmuELDrnwvO9rPgTEUPi/AY7yRCJboIPJvEtS
Dm1sCS7FzaFi7+vqVmZaRWAoLF4uhbxjWQ1ZMdYhGvswU0XpYQgO1+QDT4zRxQPm
IuPIdOSwUSGTA/lCe0TE2G3l4k1TpyDjZRE4V9jc2r+CnVxkxZujT+8=
=Uigs
-----END PGP SIGNATURE-----

--WBjBoRbHgnXlhMKinSjY6A9O9AjIr7tTs--
