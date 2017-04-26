Received: from eggs.gnu.org ([2001:4830:134:3::10]:53268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d3SXK-0004eZ-FI
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 15:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d3SXJ-00086S-Cs
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 15:23:38 -0400
References: <20170424091659.26708-1-berrange@redhat.com>
	<20170424091659.26708-4-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <37ab2b55-5586-64a5-01d9-d122f4b5b432@redhat.com>
Date: Wed, 26 Apr 2017 21:23:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170424091659.26708-4-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0waWTTlEmhfaI02kPvQaHsUhPjiv6C3Nw"
Subject: Re: [Qemu-devel] [PATCH v5 3/4] qemu-img: introduce
 --target-image-opts for 'convert' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0waWTTlEmhfaI02kPvQaHsUhPjiv6C3Nw
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>
Message-ID: <37ab2b55-5586-64a5-01d9-d122f4b5b432@redhat.com>
Subject: Re: [PATCH v5 3/4] qemu-img: introduce --target-image-opts for
 'convert' command
References: <20170424091659.26708-1-berrange@redhat.com>
 <20170424091659.26708-4-berrange@redhat.com>
In-Reply-To: <20170424091659.26708-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24.04.2017 11:16, Daniel P. Berrange wrote:
> The '--image-opts' flags indicates whether the source filename
> includes options. The target filename has to remain in the
> plain filename format though, since it needs to be passed to
> bdrv_create().  When using --skip-create though, it would be
> possible to use image-opts syntax. This adds --target-image-opts
> to indicate that the target filename includes options. Currently
> this mandates use of the --skip-create flag too.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-img-cmds.hx |  4 +--
>  qemu-img.c       | 86 ++++++++++++++++++++++++++++++++++++++++--------=
--------
>  qemu-img.texi    | 12 ++++++--
>  3 files changed, 73 insertions(+), 29 deletions(-)

I'm afraid this will need a rebase onto block-next now (because of
Peter's "qemu-img: simplify img_convert" patch).

Besides the obvious rebase conflicts, there are some less obvious things
that may/should thus be changed:

> diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
> index 8ac7822..93b50ef 100644
> --- a/qemu-img-cmds.hx
> +++ b/qemu-img-cmds.hx

[...]

> @@ -2090,6 +2100,12 @@ static int img_convert(int argc, char **argv)
>          goto fail_getopt;
>      }
> =20
> +    if (tgt_image_opts && !skip_create) {
> +        error_report("--target-image-opts requires use of -n flag");
> +        ret =3D -1;

Depending on whether you decide to put this below
bdrv_parse_cache_mode() or above, you might actually no longer have to
set ret anymore.

> +        goto fail_getopt;
> +    }
> +
>      /* Initialize before goto out */
>      if (quiet) {
>          progress =3D 0;
> @@ -2100,8 +2116,14 @@ static int img_convert(int argc, char **argv)
>      out_filename =3D bs_n >=3D 1 ? argv[argc - 1] : NULL;
> =20
>      if (options && has_help_option(options)) {
> -        ret =3D print_block_option_help(out_filename, out_fmt);
> -        goto out;
> +        if (out_fmt) {
> +            ret =3D print_block_option_help(out_filename, out_fmt);
> +            goto out;
> +        } else {
> +            error_report("Option help requires a format be specified")=
;
> +            ret =3D -1;

Since this is most likely above bdrv_parse_cache_mode() (and may thus
end up above the previous hunk?), you probably don't have to set ret
here either (Sorry...).

The changes from v4 look good, but the rebase will result in non-trivial
changes, so I giving an R-b would not be of any real use, I'm afraid...

Max

> +            goto fail_getopt;
> +        }
>      }
> =20
>      if (bs_n < 1) {


--0waWTTlEmhfaI02kPvQaHsUhPjiv6C3Nw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkA860SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AT+gH/0zUzoV/2wq557IBkgzyK9ZeruUzTq/n
cp8W5ttKrHL+gQnDuQ5kkNNB3sFYayP+3+6FBUtrsG9lWhbbDDLESOnc44/8S3I/
1IOcsy0x67f7PTcJ94rGm7lX9iocRXEuMcnXoUjONy7O26/SmGKVPh1g7no+XhDR
0LpFQFQWNCuO5YkrbEuLbOaVMjJ0CoSnqgi0bEVLqR4Ts2fXhLDhElav4dwpq8if
zQU88zsrYf2KPG8OsHjX9c+8cnCVV9geD2YxN1dhqPo6mwdodNnCQ1RWwR6DPJw1
zGJms9TYQzEa9XBi+DHoyHjYkDWIsG370V3WgHTyImYpeLKUSsfcKHs=
=WB/e
-----END PGP SIGNATURE-----

--0waWTTlEmhfaI02kPvQaHsUhPjiv6C3Nw--
