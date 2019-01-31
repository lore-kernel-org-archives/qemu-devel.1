Received: from eggs.gnu.org ([209.51.188.92]:60298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gp3Gw-0004C2-NT
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 22:44:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gp3Gv-0002xE-TR
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 22:44:14 -0500
References: <20190131022648.14264-1-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9fb6044c-1535-9580-e968-670ed253dcbc@redhat.com>
Date: Wed, 30 Jan 2019 21:44:06 -0600
MIME-Version: 1.0
In-Reply-To: <20190131022648.14264-1-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="raYK7UgeLMg3CZxCOrf9TVINI0MHpbZhO"
Subject: Re: [Qemu-devel] [PATCH] iotests/236: fix transaction kwarg order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--raYK7UgeLMg3CZxCOrf9TVINI0MHpbZhO
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <9fb6044c-1535-9580-e968-670ed253dcbc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests/236: fix transaction kwarg order
References: <20190131022648.14264-1-jsnow@redhat.com>
In-Reply-To: <20190131022648.14264-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/30/19 8:26 PM, John Snow wrote:
> It's not enough to order the kwargs for consistent QMP log output,
> we must also sort any sub-dictionaries in lists that appear as values.
>=20
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/qemu-iotests/236.out    | 56 +++++++++++++++++------------------=

>  tests/qemu-iotests/iotests.py | 21 ++++++-------
>  2 files changed, 39 insertions(+), 38 deletions(-)
>=20

> +++ b/tests/qemu-iotests/iotests.py
> @@ -76,15 +76,16 @@ def qemu_img(*args):
>          sys.stderr.write('qemu-img received signal %i: %s\n' % (-exitc=
ode, ' '.join(qemu_img_args + list(args))))
>      return exitcode
> =20
> -def ordered_kwargs(kwargs):
> -    # kwargs prior to 3.6 are not ordered, so:
> -    od =3D OrderedDict()
> -    for k, v in sorted(kwargs.items()):
> -        if isinstance(v, dict):
> -            od[k] =3D ordered_kwargs(v)
> -        else:
> -            od[k] =3D v
> -    return od
> +def ordered_qmp(qmsg):
> +    # Dictionaries are not ordered prior to 3.6, therefore:
> +    if isinstance(qmsg, list):
> +        return [ordered_qmp(atom) for atom in qmsg]
> +    if isinstance(qmsg, dict):
> +        od =3D OrderedDict()
> +        for k, v in sorted(qmsg.items()):
> +            od[k] =3D ordered_qmp(v)
> +        return od
> +    return qmsg
> =20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--raYK7UgeLMg3CZxCOrf9TVINI0MHpbZhO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxSbwYACgkQp6FrSiUn
Q2qpGwf+OUOnxe2KgvfpSGihgoxjTCEBMKljO/EGJI6o/XAKcRlnOmQXn0YaGhLe
HYF66u8cjQnFy0F7gMGFNYXgUGRg4kBsLE3Cv4jspJhouPj/FSnhowtm/+Cr/IdT
DqTUhuKUKIqll2VYyLT45G+Ke1KvBN/CPymtlnts1XLPD1CemUYrzUfJL0TLfigR
1C+k8kFmSg21AnMEWZgqxgolv/N6UPR8h2sUhvMX7q/s12YBWNsyXMDSxnC79GcA
sXaF8tft/z9Tr7BZNkcuqXgIPmO8RVz3QY8vsAk7ImcwjSocGpf5pjBryBkufxNu
ks6AAsWYoVqUff9Mfu0gwQqZ4WZl8Q==
=9OJo
-----END PGP SIGNATURE-----

--raYK7UgeLMg3CZxCOrf9TVINI0MHpbZhO--
