Received: from eggs.gnu.org ([2001:4830:134:3::10]:42693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuyqU-0001VR-1T
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:41:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuyoj-0008CW-D2
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:39:22 -0400
References: <cover.1535291602.git.berto@igalia.com>
	<e4b359c3971bb95e1e3cc55e0f69e68404f33f17.1535291602.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d3ea4f66-e8f3-35a2-1c3b-dcedb989827a@redhat.com>
Date: Wed, 29 Aug 2018 13:39:10 +0200
MIME-Version: 1.0
In-Reply-To: <e4b359c3971bb95e1e3cc55e0f69e68404f33f17.1535291602.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QgJIjrGnFjEDPksfjD0YNEHq2dHS3hgy8"
Subject: Re: [Qemu-devel] [PATCH 7/9] block: Allow changing 'discard' on
 reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QgJIjrGnFjEDPksfjD0YNEHq2dHS3hgy8
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <d3ea4f66-e8f3-35a2-1c3b-dcedb989827a@redhat.com>
Subject: Re: [PATCH 7/9] block: Allow changing 'discard' on reopen
References: <cover.1535291602.git.berto@igalia.com>
 <e4b359c3971bb95e1e3cc55e0f69e68404f33f17.1535291602.git.berto@igalia.com>
In-Reply-To: <e4b359c3971bb95e1e3cc55e0f69e68404f33f17.1535291602.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-26 16:09, Alberto Garcia wrote:
> 'discard' is one of the basic BlockdevOptions available for all
> drivers, but it's silently ignored by bdrv_reopen_prepare/commit(), so
> the user cannot change it and doesn't get an error explaining that it
> can't be changed.
>=20
> This should update the discard setting, but does nothing:
>=20
>    (qemu) qemu-io virtio0 "reopen -o discard=3Don"
>=20
> Since there's no reason why we shouldn't allow changing it and the
> implementation is simple let's just do it.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/block.c b/block.c
> index 804d557608..21f1eb9cd1 100644
> --- a/block.c
> +++ b/block.c
> @@ -3178,6 +3178,15 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_=
state, BlockReopenQueue *queue,
> =20
>      update_flags_from_options(&reopen_state->flags, opts);
> =20
> +    value =3D qemu_opt_get(opts, "discard");
> +    if (value !=3D NULL) {
> +        if (bdrv_parse_discard_flags(value, &reopen_state->flags) !=3D=
 0) {
> +            error_setg(errp, "Invalid discard option");
> +            ret =3D -EINVAL;
> +            goto error;
> +        }
> +    }
> +
>      /* node-name and driver must be unchanged. Put them back into the =
QDict, so
>       * that they are checked at the end of this function. */
>      value =3D qemu_opt_get(opts, "node-name");

Hm.  Why not just use the same "trick" here as in your last patch, i.e.
use qemu_opt_get_del() above and then qemu_opts_to_qdict() to return all
unhandled options to the QDict?

(We'd have to use *_del() in update_flags_from_options() as well, but
that would be OK for all callers, I believe.)

Max


--QgJIjrGnFjEDPksfjD0YNEHq2dHS3hgy8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluGhd8ACgkQ9AfbAGHV
z0D/yAf9FMgDZ053E7yXuDZeqohULrRoQr3BuEFPygldXFfUzKhXzkRvQuFGfMt9
HtKoheef3F0ENBgWYyYSwqkC/e8j9tAar3JW3+VNcnrl+W9YP+OgWwr9LEzuGzCn
v9LVRulXHovOiIo3YMDNnl4Gp73YYEdGtNjQTIaDsz5oNCw5RC6XrX9ZrpiMoe7D
foDTHT8+X7fp24OVUtfnc9GBYIaCumGjzaGdRHfNz2EV9BfTOgZDDDMhPtaOTAz0
JuubvuvSLbU7CxBbRSL2lJ7uuJzCw3UPDFvlW/MzjK+oWg2cF8oGC7tY936Ujf2H
J67I8jhzG/9DPpyZOdM0qC3ABJ/MyQ==
=32Yg
-----END PGP SIGNATURE-----

--QgJIjrGnFjEDPksfjD0YNEHq2dHS3hgy8--
