Received: from eggs.gnu.org ([2001:4830:134:3::10]:33685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9uYO-0003lG-2G
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 11:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9uYN-0005GS-2G
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 11:35:56 -0400
References: <20180420225320.11275-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0ac07a07-3c42-f37b-fb2e-48c467d73afd@redhat.com>
Date: Sat, 21 Apr 2018 10:35:41 -0500
MIME-Version: 1.0
In-Reply-To: <20180420225320.11275-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LLXGbEXQTV6ldkfjzmhbUZBPIEDQxNZtb"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Check post-truncation size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LLXGbEXQTV6ldkfjzmhbUZBPIEDQxNZtb
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <0ac07a07-3c42-f37b-fb2e-48c467d73afd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Check post-truncation size
References: <20180420225320.11275-1-mreitz@redhat.com>
In-Reply-To: <20180420225320.11275-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/20/2018 05:53 PM, Max Reitz wrote:
> Some block drivers (iscsi and file-posix when dealing with device files=
)
> do not actually support truncation, even though they provide a
> .bdrv_truncate() method and will happily return success when providing =
a
> new size that does not exceed the current size.  This is because these
> drivers expect the user to resize the image outside of qemu and then
> provide qemu with that information through the block_resize command
> (compare cb1b83e740384b4e0d950f3d7c81c02b8ce86c2e).
>=20
> Of course, anyone using qemu-img resize will find that behavior useless=
=2E
> So we should check the actual size of the image after the supposedly
> successful truncation took place, emit an error if nothing changed and
> emit a warning if the target size was not met.
>=20
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1523065
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> Testing this is not quite trivial.  Or, well, it is, but you need eithe=
r
> an iscsi test server or root access.

Or, you need NBD to document and implement NBD_CMD_RESIZE, and then the
nbd driver will support .bdrv_truncate() but fail when talking to a
server that doesn't actually resize after all.

>=20
> Because in my opinion iotests that require root access are never run, I=

> decided against writing such a test case.

So maybe when I get around to adding NBD resize support, I should add
such a test ;)


> +    if (new_size !=3D total_size && new_size =3D=3D current_size) {
> +        error_report("Image was not resized. Resizing may not be suppo=
rted "
> +                     "for this image.");

error_report() generally does not have trailing dot, and generally has a
single sentence.  Would this be better as:

Image was not resized; resizing may not be supported for this image

> +        ret =3D -1;
> +        goto out;
> +    }
> +
> +    if (new_size !=3D total_size) {
> +        warn_report("Image should have been resized to %" PRIi64
> +                    " bytes, but was resized to %" PRIi64 " bytes.",
> +                    total_size, new_size);

Trailing dot again.  Also, PRId64 is much more common than PRIi64, even
though the two are identical in behavior.

But the idea makes sense to me.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LLXGbEXQTV6ldkfjzmhbUZBPIEDQxNZtb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrbWk0ACgkQp6FrSiUn
Q2pSDwgAidOf5Wu2jz5DZZx1B2uQt9N42yq8LroSJO1L+ltiOYgJwbHpTRHCa2RH
ttN9AjMK3czv8uA7yCLewIcmAHo9qHLOFIiox+6EmtThIqPN+Chn8i4Q2wONLswd
f61ep+RjjYH+Q6juz+ZfHVwQITXS4/w2C5T0ET6DOuOxvfgXO4/4nPnoCjVgjL2g
PvDP2QQ8ppgEVLY4uJEkHb/Sx8pGMaeOME6/S3wYvMPpH8fABQGn5uUKxi3D25lE
9iQ/m/DRHNnpOCdnJpw78o0MGDX+hrd4Crdb2oJ7ptto/PD9laKCKo48tn2zcBqs
Nfyy0k8MM/ZZBUhF0untDT29gGRT/g==
=Ce4q
-----END PGP SIGNATURE-----

--LLXGbEXQTV6ldkfjzmhbUZBPIEDQxNZtb--
