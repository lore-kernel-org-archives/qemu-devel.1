Received: from eggs.gnu.org ([2001:4830:134:3::10]:57390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNnwK-0002QJ-DP
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 18:17:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNnwJ-0002GY-5n
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 18:17:32 -0400
References: <20170613121639.17853-1-pbutsykin@virtuozzo.com>
	<20170613121639.17853-2-pbutsykin@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b5367763-781e-0fdc-b9e7-fa6ee44ce66b@redhat.com>
Date: Thu, 22 Jun 2017 00:17:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170613121639.17853-2-pbutsykin@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="P9NGuTISkSV0TxgHtMMdDimVpbbvQdhSv"
Subject: Re: [Qemu-devel] [PATCH v2 1/4] qemu-img: add --shrink flag for
 resize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P9NGuTISkSV0TxgHtMMdDimVpbbvQdhSv
From: Max Reitz <mreitz@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org
Message-ID: <b5367763-781e-0fdc-b9e7-fa6ee44ce66b@redhat.com>
Subject: Re: [PATCH v2 1/4] qemu-img: add --shrink flag for resize
References: <20170613121639.17853-1-pbutsykin@virtuozzo.com>
 <20170613121639.17853-2-pbutsykin@virtuozzo.com>
In-Reply-To: <20170613121639.17853-2-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-13 14:16, Pavel Butsykin wrote:
> The flag as additional precaution of data loss. Perhaps in the future t=
he
> operation shrink without this flag will be banned, but while we need to=

> maintain compatibility.
>=20
> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> ---
>  qemu-img-cmds.hx       |  4 ++--
>  qemu-img.c             | 15 +++++++++++++++
>  qemu-img.texi          |  5 ++++-
>  tests/qemu-iotests/102 |  4 ++--
>  4 files changed, 23 insertions(+), 5 deletions(-)
>=20
> diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
> index a39fcdba71..3b2eab9d20 100644
> --- a/qemu-img-cmds.hx
> +++ b/qemu-img-cmds.hx
> @@ -76,9 +76,9 @@ STEXI
>  ETEXI
> =20
>  DEF("resize", img_resize,
> -    "resize [--object objectdef] [--image-opts] [-q] filename [+ | -]s=
ize")
> +    "resize [--object objectdef] [--image-opts] [-q] [--shrink] filena=
me [+ | -]size")
>  STEXI
> -@item resize [--object @var{objectdef}] [--image-opts] [-q] @var{filen=
ame} [+ | -]@var{size}
> +@item resize [--object @var{objectdef}] [--image-opts] [-q] [--shrink]=
 @var{filename} [+ | -]@var{size}
>  ETEXI
> =20
>  DEF("amend", img_amend,
> diff --git a/qemu-img.c b/qemu-img.c
> index 0ad698d7f1..bfe5f61b0b 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -61,6 +61,7 @@ enum {
>      OPTION_FLUSH_INTERVAL =3D 261,
>      OPTION_NO_DRAIN =3D 262,
>      OPTION_TARGET_IMAGE_OPTS =3D 263,
> +    OPTION_SHRINK =3D 264,
>  };
> =20
>  typedef enum OutputFormat {
> @@ -3452,6 +3453,7 @@ static int img_resize(int argc, char **argv)
>          },
>      };
>      bool image_opts =3D false;
> +    bool shrink =3D false;
> =20
>      /* Remove size from argv manually so that negative numbers are not=
 treated
>       * as options by getopt. */
> @@ -3469,6 +3471,7 @@ static int img_resize(int argc, char **argv)
>              {"help", no_argument, 0, 'h'},
>              {"object", required_argument, 0, OPTION_OBJECT},
>              {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
> +            {"shrink", no_argument, 0, OPTION_SHRINK},
>              {0, 0, 0, 0}
>          };
>          c =3D getopt_long(argc, argv, ":f:hq",
> @@ -3503,6 +3506,9 @@ static int img_resize(int argc, char **argv)
>          case OPTION_IMAGE_OPTS:
>              image_opts =3D true;
>              break;
> +        case OPTION_SHRINK:
> +            shrink =3D true;
> +            break;
>          }
>      }
>      if (optind !=3D argc - 1) {
> @@ -3562,6 +3568,15 @@ static int img_resize(int argc, char **argv)
>          goto out;
>      }
> =20
> +    if (total_size < blk_getlength(blk) && !shrink) {
> +        qprintf(quiet, "Warning: shrinking of the image can lead to da=
ta loss. "

I think this should always be printed to stderr, even if quiet is true;
especially considering we (or at least I) plan to make it mandatory.

> +                       "Before performing shrink operation you must ma=
ke sure "

*Before performaing a shrink operation

Also, I'd rather use the imperative: "Before ... operation, make sure
that the..."

(English isn't my native language either, but as far as I remember
"must" is generally used for external influences. But it's not like a
force of nature is forcing you to confirm there's no important data; you
can just ignore this advice and see all of your non-backed-up childhood
pictures go to /dev/null.)

> +                       "that the shrink part of image doesn't contain =
important"

Hmm... I don't think "shrink part" really works.

Maybe the following would work better:

  Warning: Shrinking an image will delete all data beyond the shrunken
  image's end. Before performing such an operation, make sure there is
  no important data there.

> +                       " data.\n");
> +        qprintf(quiet,
> +                "If you don't want to see this message use --shrink op=
tion.\n");

You should make a note that --shrink may (and I hope it will) become
necessary in the future, like:

  Using the --shrink option will suppress this message. Note that future
  versions of qemu-img may refuse to shrink images without this option!

> +    }
> +
>      ret =3D blk_truncate(blk, total_size, &err);
>      if (!ret) {
>          qprintf(quiet, "Image resized.\n");
> diff --git a/qemu-img.texi b/qemu-img.texi
> index 5b925ecf41..c2b694cd00 100644
> --- a/qemu-img.texi
> +++ b/qemu-img.texi
> @@ -499,7 +499,7 @@ qemu-img rebase -b base.img diff.qcow2
>  At this point, @code{modified.img} can be discarded, since
>  @code{base.img + diff.qcow2} contains the same information.
> =20
> -@item resize @var{filename} [+ | -]@var{size}
> +@item resize [--shrink] @var{filename} [+ | -]@var{size}
> =20
>  Change the disk image as if it had been created with @var{size}.
> =20
> @@ -507,6 +507,9 @@ Before using this command to shrink a disk image, y=
ou MUST use file system and
>  partitioning tools inside the VM to reduce allocated file systems and =
partition
>  sizes accordingly.  Failure to do so will result in data loss!
> =20
> +If @code{--shrink} is specified, warning about data loss doesn't print=
 for
> +the shrink operation.
> +

Maybe rather:

@code{--shrink} informs qemu-img that the user is certain about wanting
to shrink an image and is aware that any data beyond the truncated
image's end will be lost. Trying to shrink an image without this option
results in a warning; future versions may make it an error.

The functional changes look good to me; even though I'd rather have it
an error for qcow2 now (even if that means having to check the image
format in img_resize(), and being inconsistent because you wouldn't need
--shrink for raw, but for qcow2 you would). But, well, I'm not going to
stop this series over that.

Max


--P9NGuTISkSV0TxgHtMMdDimVpbbvQdhSv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZSvBvEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQCmE
B/96+h1X0uPxxse26XAeqa3V1tLxD00ha/5JTdkGIiVkFOQfudE72eD+4ur4xkj9
pU/CISq8bQHL1XdVhC6ImArEdOY8vS1fhre3vAb9tu2TVfCXmg85D3u+U845aGvD
0dMqe9LsGBtAx7EDSXqyb8JwsGyJfcrxwgfE36Nm5wmKOjIBXykY1e/DwJQpWg/c
NWxvo6bgOVB8/tv9G4OWMnKruc2gSqQJbXcuVQg9ju2cKfYRqK4wNWFjAvVG0Axx
v6dLjhAPw0AwbvCjN8bY+IB4jJjQ7cWeXFSFz3UiljFJjJiD299WtrDzGmCroA9j
DzYWdaAeWkoqnGFeBkBcYqok
=tcFr
-----END PGP SIGNATURE-----

--P9NGuTISkSV0TxgHtMMdDimVpbbvQdhSv--
