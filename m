Received: from eggs.gnu.org ([2001:4830:134:3::10]:35735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f9uc6-0005iC-9x
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 11:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f9uc5-0000ji-6F
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 11:39:46 -0400
References: <20180420225320.11275-1-mreitz@redhat.com>
	<0ac07a07-3c42-f37b-fb2e-48c467d73afd@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3e5b9842-2031-9fc5-e1bd-d2316ccfa43b@redhat.com>
Date: Sat, 21 Apr 2018 17:39:36 +0200
MIME-Version: 1.0
In-Reply-To: <0ac07a07-3c42-f37b-fb2e-48c467d73afd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fdvCv34Dvac9WwVxvGsSpzZzygGqhZOLi"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Check post-truncation size
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
--fdvCv34Dvac9WwVxvGsSpzZzygGqhZOLi
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <3e5b9842-2031-9fc5-e1bd-d2316ccfa43b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Check post-truncation size
References: <20180420225320.11275-1-mreitz@redhat.com>
 <0ac07a07-3c42-f37b-fb2e-48c467d73afd@redhat.com>
In-Reply-To: <0ac07a07-3c42-f37b-fb2e-48c467d73afd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-21 17:35, Eric Blake wrote:
> On 04/20/2018 05:53 PM, Max Reitz wrote:
>> Some block drivers (iscsi and file-posix when dealing with device file=
s)
>> do not actually support truncation, even though they provide a
>> .bdrv_truncate() method and will happily return success when providing=
 a
>> new size that does not exceed the current size.  This is because these=

>> drivers expect the user to resize the image outside of qemu and then
>> provide qemu with that information through the block_resize command
>> (compare cb1b83e740384b4e0d950f3d7c81c02b8ce86c2e).
>>
>> Of course, anyone using qemu-img resize will find that behavior useles=
s.
>> So we should check the actual size of the image after the supposedly
>> successful truncation took place, emit an error if nothing changed and=

>> emit a warning if the target size was not met.
>>
>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1523065
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> Testing this is not quite trivial.  Or, well, it is, but you need eith=
er
>> an iscsi test server or root access.
>=20
> Or, you need NBD to document and implement NBD_CMD_RESIZE, and then the=

> nbd driver will support .bdrv_truncate() but fail when talking to a
> server that doesn't actually resize after all.

I suppose the NBD client would recognize that, though, and return an
error code (and set *errp).  The issue in this case is that the drivers
in question pretend that everything went according to plan (they return
success) when actually nothing was resized at all.

>>
>> Because in my opinion iotests that require root access are never run, =
I
>> decided against writing such a test case.
>=20
> So maybe when I get around to adding NBD resize support, I should add
> such a test ;)
>=20
>=20
>> +    if (new_size !=3D total_size && new_size =3D=3D current_size) {
>> +        error_report("Image was not resized. Resizing may not be supp=
orted "
>> +                     "for this image.");
>=20
> error_report() generally does not have trailing dot, and generally has =
a
> single sentence.  Would this be better as:
>=20
> Image was not resized; resizing may not be supported for this image

Yes, it would.  I just made this a qprintf() in the first version and
forgot to change it when making it an error_report().

>> +        ret =3D -1;
>> +        goto out;
>> +    }
>> +
>> +    if (new_size !=3D total_size) {
>> +        warn_report("Image should have been resized to %" PRIi64
>> +                    " bytes, but was resized to %" PRIi64 " bytes.",
>> +                    total_size, new_size);
>=20
> Trailing dot again.

Same here, yes.

>                      Also, PRId64 is much more common than PRIi64, even=

> though the two are identical in behavior.

:-(

But I like my %i!

> But the idea makes sense to me.

OK, thanks.

Max


--fdvCv34Dvac9WwVxvGsSpzZzygGqhZOLi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrbWzgACgkQ9AfbAGHV
z0CUEgf/YUioHsS5YUTHUQHzV2Zs7Okgr6FsYMW7nlV3Qtyse5UaXEfSOh1OIzk8
dskhcJosHsfXp0AQjMq5kpNBn4KvY+Oq9qFxwpVe8mHnLDIlDBgIn75itqw1Memx
VKMrTLTIYsLDF1wsHY1kOqROuxSyT57j48oLn51aW0Oq74tEY+DSPy6oEAVmizOH
sCQBTFc6C1ju2CNwEVOHwO2klshXMDZhyl0PA05iEeMbCc66ZAf+84LqtccfWJnK
XQE9LDvWNbJNPhEUiTCw7pj4UGz4qSRuGAdW2J6tbAAG4MoW9EzHrbxHlq+eX9Sp
3dmYoV/tpgAat+wfi7pD4wm7yeJe5w==
=yUOq
-----END PGP SIGNATURE-----

--fdvCv34Dvac9WwVxvGsSpzZzygGqhZOLi--
