Received: from eggs.gnu.org ([2001:4830:134:3::10]:52044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQwIn-0002Or-Nt
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQwIk-0001I6-MN
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:49:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1dQwIk-0001Ht-CQ
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:49:38 -0400
References: <20170614153557.3319-1-stefanha@redhat.com>
	<20170614153557.3319-8-stefanha@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <825f23ec-081c-a9cd-7dae-29d754747275@redhat.com>
Date: Fri, 30 Jun 2017 15:49:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170614153557.3319-8-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4sAhfAfC8pLgCCMaXlUWXcjutGFWB94qD"
Subject: Re: [Qemu-devel] [PATCH v8 7/9] qemu-img: add measure subcommand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4sAhfAfC8pLgCCMaXlUWXcjutGFWB94qD
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>,
 Alberto Garcia <berto@igalia.com>
Message-ID: <825f23ec-081c-a9cd-7dae-29d754747275@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 7/9] qemu-img: add measure subcommand
References: <20170614153557.3319-1-stefanha@redhat.com>
 <20170614153557.3319-8-stefanha@redhat.com>
In-Reply-To: <20170614153557.3319-8-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-14 17:35, Stefan Hajnoczi wrote:
> The measure subcommand calculates the size required by a new image file=
=2E
> This can be used by users or management tools that need to allocate
> space on an LVM volume, SAN LUN, etc before creating or converting an
> image file.
>=20
> Suggested-by: Maor Lipchuk <mlipchuk@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v7:
>  * Really use UINT64_MAX everywhere instead of ~0ULL [Berto]
> v5:
>  * Use UINT64_MAX instead of ~0ULL [Berto]
>  * Document qemu-img measure ofmt, fmt, output_fmt, and snapshot_param
>    [Berto]
> ---
>  qemu-img.c       | 234 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  qemu-img-cmds.hx |   6 ++
>  qemu-img.texi    |  30 +++++++
>  3 files changed, 270 insertions(+)

[...]

> diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
> index a39fcdb..ac5946b 100644
> --- a/qemu-img-cmds.hx
> +++ b/qemu-img-cmds.hx
> @@ -63,6 +63,12 @@ STEXI
>  @item map [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--=
output=3D@var{ofmt}] [-U] @var{filename}
>  ETEXI
> =20
> +DEF("measure", img_measure,
> +"measure [--output=3Dofmt] [-O output_fmt] [-o options] [--size N | [-=
-object objectdef] [--image-opts] [-f fmt] [-l snapshot_param] filename]"=
)
> +STEXI
> +@item measure [--output=3D@var{ofmt}] [-O @var{output_fmt}] [-o @var{o=
ptions}] [--size @var{N} | [--object @var{objectdef}] [--image-opts] [-f =
@var{fmt}] [-l @var{snapshot_param}] @var{filename}]
> +ETEXI
> +
>  DEF("snapshot", img_snapshot,
>      "snapshot [--object objectdef] [--image-opts] [-U] [-q] [-l | -a s=
napshot | -c snapshot | -d snapshot] filename")
>  STEXI
> diff --git a/qemu-img.texi b/qemu-img.texi
> index 5b925ec..3db035f 100644
> --- a/qemu-img.texi
> +++ b/qemu-img.texi
> @@ -438,6 +438,36 @@ preallocated.
>  For more information, consult @file{include/block/block.h} in QEMU's
>  source code.
> =20
> +@item measure [--output=3D@var{ofmt}] [-O @var{output_fmt}] [-o @var{o=
ptions}] [--size @var{N} | [--object @var{objectdef}] [--image-opts] [-f =
@var{fmt}] [-l @var{snapshot_param}] @var{filename}]
> +
> +Calculate the file size required for a new image.  This information ca=
n be used
> +to size logical volumes or SAN LUNs appropriately for the image that w=
ill be
> +placed in them.  The values reported are guaranteed to be large enough=
 to fit
> +the image.  The command can output in the format @var{ofmt} which is e=
ither
> +@code{human} or @code{json}.
> +
> +If the size @var{N} is given then act as if creating a new empty image=
 file
> +using @command{qemu-img create}.  If @var{filename} is given then act =
as if
> +converting an existing image file using @command{qemu-img convert}.  T=
he format
> +of the new file is given by @var{fmt} while the format of an existing =
file is
> +given by @var{output_fmt}.

Sorry to reply so late (I wanted to take the series), but calling this
parameter output_fmt is weird. It is exactly the opposite.

Max


--4sAhfAfC8pLgCCMaXlUWXcjutGFWB94qD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZVlbnEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQO7D
B/9qGc2Gy6zZeNZO2iviE6LMvAio3r58LPgTfXcfIlFB25VyhIOguPuEreVxRtR3
0GgqPRnPR5J5lsetbYHcBiTO9siJiy1MyxhShWpqY5TFePyZIqokQtx66j7XMXeZ
W/1SjwN4nz47W16pou1tuS9DifBoAU73yEvwWhs56GeweCjF+Np+j2Oggw/nKaAX
70XWiJvksypgu6HTwZKb0XTSSp8OvbJigwoLJd1qC+G6An1PEZJwYD0BnKGqMI/1
Tjbs9Obwn63UIea784cEQE6qIuUd92hSCSO9B1JT6LicC9tzDo/z142qxisUmrbF
R3sNxxstnihlCpVcBDHmHuZS
=UoyC
-----END PGP SIGNATURE-----

--4sAhfAfC8pLgCCMaXlUWXcjutGFWB94qD--
