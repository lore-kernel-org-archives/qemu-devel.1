Received: from eggs.gnu.org ([2001:4830:134:3::10]:47488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3LhZ-0001aV-1r
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 09:10:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3LhT-0007eX-1I
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 09:10:16 -0400
References: <20180403110810.25624-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d1633a50-2aad-af64-081c-bfac72b89e12@redhat.com>
Date: Tue, 3 Apr 2018 08:09:49 -0500
MIME-Version: 1.0
In-Reply-To: <20180403110810.25624-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vwxfPCS9bltii5i2m5KvJ17co3ORuWOH2"
Subject: Re: [Qemu-devel] [PATCH for-2.12] gluster: Fix blockdev-add with
 server.N.type=unix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, prasanna.kalever@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vwxfPCS9bltii5i2m5KvJ17co3ORuWOH2
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, prasanna.kalever@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <d1633a50-2aad-af64-081c-bfac72b89e12@redhat.com>
Subject: Re: [PATCH for-2.12] gluster: Fix blockdev-add with
 server.N.type=unix
References: <20180403110810.25624-1-kwolf@redhat.com>
In-Reply-To: <20180403110810.25624-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/03/2018 06:08 AM, Kevin Wolf wrote:
> The legacy command line interface gets the socket path from an option
> called 'socket'. QAPI in contract uses SocketAddress, where the
> corresponding option is called 'path'.
>=20
> Fix the gluster block driver to accept both 'socket' and 'path', with
> 'path' being the preferred syntax.
>=20
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1545155
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/gluster.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

Should we also add a deprecation warning for 'socket' and update the
deprecation documentation, so we can start the clock ticking on getting
rid of maintaining the back-compat glue forever?

> @@ -615,10 +620,18 @@ static int qemu_gluster_parse_json(BlockdevOption=
sGluster *gconf,
>                  goto out;
>              }
> =20
> -            ptr =3D qemu_opt_get(opts, GLUSTER_OPT_SOCKET);
> +            ptr =3D qemu_opt_get(opts, GLUSTER_OPT_PATH);
> +            if (!ptr) {
> +                ptr =3D qemu_opt_get(opts, GLUSTER_OPT_SOCKET);

Here's where we'd warn, if we want to deprecate things.

> +            } else if (qemu_opt_get(opts, GLUSTER_OPT_SOCKET)) {
> +                error_setg(&local_err,
> +                           "Conflicting parameters 'path' and 'socket'=
");
> +                error_append_hint(&local_err, GERR_INDEX_HINT, i);
> +                goto out;
> +            }
>              if (!ptr) {

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vwxfPCS9bltii5i2m5KvJ17co3ORuWOH2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrDfR0ACgkQp6FrSiUn
Q2oIUwgAjxQf+cvjuStWbCx/cPHJEc0LFVX+gTwYO06mqpQBbB+hd2jfyiwIWaTR
wT0O0grgAxGzCrbrgHfTvDXdmjvR5mIRRJQk8d2SxS24ObAlvCx8xsrXaHv/DDEu
G29DiHgO2Vs/OVD9KvsLYAVwClVCR6QnfbtaxLbNsGSh+DLfHfH1TADVCj0tufpA
9gnLs16OIPn3D9/CFTl3aqWwH31aR+71kEepHdN77JQhvCIXJ11HUMDS/1q0JSnV
jMg9iWWO7NsZGTqnyOsU180OVOTYQ1nM/wWVxMnwz8vY7+M9uzuttJx7Ld5bwzRM
W5OjJBfqFttrBGY1PfoJCqaK7750fA==
=bUia
-----END PGP SIGNATURE-----

--vwxfPCS9bltii5i2m5KvJ17co3ORuWOH2--
