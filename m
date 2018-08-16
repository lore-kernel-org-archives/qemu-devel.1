Received: from eggs.gnu.org ([2001:4830:134:3::10]:40883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fq7uA-0002JK-Lg
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 22:20:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fq7u7-0003Vi-QL
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 22:20:54 -0400
References: <20180815025614.53588-1-eblake@redhat.com>
	<20180815025614.53588-3-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <48010463-405e-bb08-f9c5-8263dcf3bb48@redhat.com>
Date: Thu, 16 Aug 2018 04:20:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180815025614.53588-3-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9R6eVboQO4di827M443xY8K7gL483dekQ"
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-img: Add dd seek= option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: fullmanet@gmail.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9R6eVboQO4di827M443xY8K7gL483dekQ
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: fullmanet@gmail.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <48010463-405e-bb08-f9c5-8263dcf3bb48@redhat.com>
Subject: Re: [PATCH 2/2] qemu-img: Add dd seek= option
References: <20180815025614.53588-1-eblake@redhat.com>
 <20180815025614.53588-3-eblake@redhat.com>
In-Reply-To: <20180815025614.53588-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-15 04:56, Eric Blake wrote:
> For feature parity with dd, we want to be able to specify
> the offset within the output file, just as we can specify
> the offset for the input (in particular, this makes copying
> a subset range of guest-visible bytes from one file to
> another much easier).

In my opinion, we do not want feature parity with dd.  What we do want
is feature parity with convert.

> The code style for 'qemu-img dd' was pretty hard to read;
> unfortunately this patch focuses only on adding the new
> feature in the existing style rather than trying to improve
> the overall flow, other than switching octal constants to
> hex.  Oh well.

No, the real issue is that dd is still not implemented just as a
frontend to convert.  Which it should be.  I'm not sure dd was a very
good idea from the start, and now it should ideally be a frontend to
convert.

(My full opinion on the matter: dd has a horrible interface.  I don't
quite see why we replicated that inside qemu-img.  Also, if you want to
use dd, why not use qemu-nbd + Linux nbd device + real dd?)

((That gave me a good idea.  Actually, it's probably not such a good
idea, but I guess I'll do it in my spare time anyway.  A qemu-img fuse
might be nice which represents an image as a raw image at some mount
point.  Benefits over qemu-nbd: (1) You don't need root, (2) you don't
need to type modprobe nbd.))

> Also, switch the test to use an offset of 0 instead of 1,
> to test skip=3D and seek=3D on their own; as it is, this is
> effectively quadrupling the test runtime, which starts
> to make this test borderline on whether it should still
> belong to './check -g quick'.  And I didn't bother to
> reindent the test shell code for the new nested loop.

In my opinion, it should no longer belong to quick.  It takes 8 s on my
tmpfs.  My border is somewhere around 2 or 3; and I haven't yet decided
whether that's on tmpfs or SSD.

> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qemu-img.c                 |  41 ++++--
>  tests/qemu-iotests/160     |  12 +-
>  tests/qemu-iotests/160.out | 304 +++++++++++++++++++++++++++++++++++++=
++++++--
>  3 files changed, 336 insertions(+), 21 deletions(-)
>=20
> diff --git a/qemu-img.c b/qemu-img.c
> index d72f0f0ec94..ee01a18f331 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c

[...]

> @@ -4574,7 +4592,14 @@ static int img_dd(int argc, char **argv)
>          size =3D dd.count * in.bsz;
>      }
>=20
> -    qemu_opt_set_number(opts, BLOCK_OPT_SIZE, size, &error_abort);
> +    if (dd.flags & C_SEEK && out.offset * out.bsz > INT64_MAX - size) =
{

What about overflows in out.offset * out.bsz?

> +        error_report("Seek too large for '%s'", out.filename);
> +        ret =3D -1;
> +        goto out;

Real dd doesn't seem to error out (it just reports an error).  I don't
know whether that makes any difference, though.

The test looks good to me.

Max

> +    }
> +    seek =3D out.offset * out.bsz;
> +
> +    qemu_opt_set_number(opts, BLOCK_OPT_SIZE, size + seek, &error_abor=
t);
>      end =3D size + in_pos;
>=20
>      ret =3D bdrv_create(drv, out.filename, opts, &local_err);


--9R6eVboQO4di827M443xY8K7gL483dekQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt033gACgkQ9AfbAGHV
z0DtoggAiTfJsjjPEE+mqQjLiaDi87GYDxOZS+zDnsJQHInfrVwu39ZvyTPhyU5/
FZ3YGpACFSCyT5XbUzRXBwHWts9Y9+zr2tOPb6iJgXPX/LYjALBMZDB8+nHZKdyT
nMtKQtrckdEhDdtiDYNwULwahernUuTDD6sD5BfcGAV/NrsZn8O6MAFoCqLE4UDB
NcQWKbmr3fa5LqDpJDMVtWVGJAKxIHRkrq+IjaQxNULEuyqG4/G8EzYln+jDoNGP
50vih0eBJEW30jcqlepElFLBl8+niDAOT+tYV5ioe1iLUxAMXzZIWBOYC9FAalB2
sSv8UbEhsizsXi34KbWcXbw1gWbBvA==
=SRXB
-----END PGP SIGNATURE-----

--9R6eVboQO4di827M443xY8K7gL483dekQ--
