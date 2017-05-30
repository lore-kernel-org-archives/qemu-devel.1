Received: from eggs.gnu.org ([2001:4830:134:3::10]:54331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFoCu-00046m-Lj
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:57:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFoCt-0004Pe-Lp
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:57:36 -0400
References: <20170526165518.7580-1-mreitz@redhat.com>
	<20170526165518.7580-5-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0f959146-af02-f219-8a48-3562b26b0493@redhat.com>
Date: Tue, 30 May 2017 15:57:24 -0500
MIME-Version: 1.0
In-Reply-To: <20170526165518.7580-5-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="K7fkoEjem2ujh1isbcmJBU0QUsmA99ulW"
Subject: Re: [Qemu-devel] [PATCH v3 04/16] qemu-img: Expose PreallocMode for
 resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--K7fkoEjem2ujh1isbcmJBU0QUsmA99ulW
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <0f959146-af02-f219-8a48-3562b26b0493@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 04/16] qemu-img: Expose PreallocMode for
 resizing
References: <20170526165518.7580-1-mreitz@redhat.com>
 <20170526165518.7580-5-mreitz@redhat.com>
In-Reply-To: <20170526165518.7580-5-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/26/2017 11:55 AM, Max Reitz wrote:
> Add a --preallocation command line option to qemu-img resize which can
> be used to set the PreallocMode parameter of blk_truncate().
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qemu-img.c    | 33 ++++++++++++++++++++++++++++++---
>  qemu-img.texi |  7 ++++++-
>  2 files changed, 36 insertions(+), 4 deletions(-)

> @@ -3553,8 +3566,16 @@ static int img_resize(int argc, char **argv)
>          goto out;
>      }
> =20
> +    current_size =3D blk_getlength(blk);
> +    if (current_size < 0) {
> +        error_report("Failed to inquire current image length: %s",
> +                     strerror(-current_size));
> +        ret =3D -1;
> +        goto out;
> +    }
> +
>      if (relative) {
> -        total_size =3D blk_getlength(blk) + n * relative;
> +        total_size =3D current_size + n * relative;

You snuck in a bug fix here (reporting failure, rather than using a
bogus total_size, if querying the size fails).  Please mention that in
the commit message.

> @@ -541,6 +541,11 @@ After using this command to grow a disk image, you=
 must use file system and
>  partitioning tools inside the VM to actually begin using the new space=
 on the
>  device.
> =20
> +When growing an image, the @code{--preallocation} option may be used t=
o specify
> +how the additional image area should be allocated on the host.  See th=
e format
> +description in the @code{NOTES} section which values are allowed.  Usi=
ng this
> +option may result in more data being allocated than necessary.

Should we tone it down a bit by saying 'slightly more data'?  (We'd
rather over-estimate than fall short, but our over-estimation will
probably be < 1% off, and not something drastic like an order of
magnitude off).

With the improved commit message,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--K7fkoEjem2ujh1isbcmJBU0QUsmA99ulW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLdy0AAoJEKeha0olJ0NqsPAH/Ao4hW7iaj58sxLJVP0zCgKo
NlUeo/1hA7aMa0nCoVoIw5S3+MxefmyMu/xEb/kaFOCnbp5az+j3NwErRbExcMdG
yQj/t+JTJ8PEyaXfVgpfYowJrxgLuowzUs2dnCX7nchtxHv+U1TD1hewUOxVIngz
1yhG7/8MUd4dLrCWzZsRuHvlXzWeYZy2ty4JdFDrKKWjnLoMouQuHVPmoQmDWUV7
/HObj0VyojNOwHFDevXmArL/Nw16CEFRAIYqoOBlqJyUVVYhplgV6Sfwmp+TtNet
WrFl+D1ySAMpo69VQP4TlTOEc/hMTzuKm5NKFC0EJhwDGDAwuirfKkTOPBnRgak=
=V381
-----END PGP SIGNATURE-----

--K7fkoEjem2ujh1isbcmJBU0QUsmA99ulW--
