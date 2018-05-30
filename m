Received: from eggs.gnu.org ([2001:4830:134:3::10]:45246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNxyM-0003YW-4I
	for qemu-devel@nongnu.org; Wed, 30 May 2018 06:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNxyL-0004nH-6T
	for qemu-devel@nongnu.org; Wed, 30 May 2018 06:04:50 -0400
References: <20180529203910.7615-1-kwolf@redhat.com>
	<20180529203910.7615-9-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <32442c85-cb05-0654-7157-0d7b864fb3fd@redhat.com>
Date: Wed, 30 May 2018 12:04:37 +0200
MIME-Version: 1.0
In-Reply-To: <20180529203910.7615-9-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jqrE00JHFn4W9FetKfKfG9gPzUhbcdV1Z"
Subject: Re: [Qemu-devel] [PATCH v2 08/16] qemu-iotests: Add VM.run_job()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jqrE00JHFn4W9FetKfKfG9gPzUhbcdV1Z
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com, eblake@redhat.com,
 pkrempa@redhat.com, qemu-devel@nongnu.org
Message-ID: <32442c85-cb05-0654-7157-0d7b864fb3fd@redhat.com>
Subject: Re: [PATCH v2 08/16] qemu-iotests: Add VM.run_job()
References: <20180529203910.7615-1-kwolf@redhat.com>
 <20180529203910.7615-9-kwolf@redhat.com>
In-Reply-To: <20180529203910.7615-9-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-29 22:39, Kevin Wolf wrote:
> Add an iotests.py function that runs a job and only returns when it is
> destroyed. An error is logged when the job failed and job-finalize and
> job-dismiss commands are issued if necessary.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
=2Epy
> index edcd2bb701..8b612cb891 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -418,6 +418,25 @@ class VM(qtest.QEMUQtestMachine):
>          log(str(result), filters)
>          return result
> =20
> +    def run_job(self, job, auto_finalize=3DTrue, auto_dismiss=3DFalse)=
:
> +        while True:
> +            for ev in self.get_qmp_events_filtered(wait=3DTrue):
> +                if ev['event'] =3D=3D 'JOB_STATUS_CHANGE':
> +                    status =3D ev['data']['status']
> +                    if status =3D=3D 'aborting':
> +                        result =3D self.qmp('query-jobs')
> +                        for j in result['return']:
> +                            if j['id'] =3D=3D job:
> +                                log('Job failed: %s' % (j['error']))
> +                    elif status =3D=3D 'pending' and not auto_finalize=
:
> +                        self.qmp_log('job-finalize', id=3Djob)
> +                    elif status =3D=3D 'concluded' and not auto_dismis=
s:
> +                        self.qmp_log('job-dismiss', id=3Djob)
> +                    elif status =3D=3D 'null':
> +                        return
> +                else:
> +                    iotests.log(ev)
> +
> =20
>  index_re =3D re.compile(r'([^\[]+)\[([^\]]+)\]')

No, I won't mention that I just realized you could get the job ID from
the event and don't actually need it as a parameter.

So without any comments:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--jqrE00JHFn4W9FetKfKfG9gPzUhbcdV1Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsOdzUACgkQ9AfbAGHV
z0DY7gf/cCVTVb/CsnXMf6XAd+1AAJfJMkyTKWj8DLPQ/v6f4wQKcCscaaLARSeO
oNhcnpAsNCT7qO8aeYUYe+egCNq5KIfy0NzwsMnw6PZWYnyVXFbzjuu6bwAqcTkc
iAVt3TLS+B9dtboWj8CvHilp9RVjVNiHvRhk8HSDbkHbd/CDix8C6kU9K9ObEiKf
Fy8JhEYg59h0bRvlQWuhyBL4BzexCZGpNMpy4vt+zW7V3xsFH1JPA9E2ocxZtyP0
rxAbtkf+QNuQGqmeV57cSR/t4lw4RzIe8AHHit+FED7tjY6iHkP6tetN5CD+UZGe
uJ6OpJcznMHaTjwR0P1x+KzMw/5CLA==
=RaR9
-----END PGP SIGNATURE-----

--jqrE00JHFn4W9FetKfKfG9gPzUhbcdV1Z--
