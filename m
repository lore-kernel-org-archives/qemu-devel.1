Received: from eggs.gnu.org ([2001:4830:134:3::10]:33489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbGZC-0004Qw-Ew
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 19:57:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbGZB-0003D7-9R
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 19:57:02 -0500
References: <20170123123056.30383-1-famz@redhat.com>
	<20170123123056.30383-14-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <478fc62f-e0c0-bc28-0f89-7b44d5b69d63@redhat.com>
Date: Wed, 8 Feb 2017 01:56:50 +0100
MIME-Version: 1.0
In-Reply-To: <20170123123056.30383-14-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6ijgqoNhMB7I7V05IQqC6evPGDiB2QKBt"
Subject: Re: [Qemu-devel] [PATCH v12 13/16] tests: Disable image lock in
 test-replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6ijgqoNhMB7I7V05IQqC6evPGDiB2QKBt
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org,
 eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com
Message-ID: <478fc62f-e0c0-bc28-0f89-7b44d5b69d63@redhat.com>
Subject: Re: [PATCH v12 13/16] tests: Disable image lock in test-replication
References: <20170123123056.30383-1-famz@redhat.com>
 <20170123123056.30383-14-famz@redhat.com>
In-Reply-To: <20170123123056.30383-14-famz@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 23.01.2017 13:30, Fam Zheng wrote:
> The COLO block replication architecture requires one disk to be shared
> between primary and secondary, in the test both processes use posix fil=
e
> protocol (instead of over NBD) so it is affected by image locking.
> Disable the lock.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/test-replication.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Running these tests (even when fixed) results in a failure before the
next patch because disable-lock is not yet implemented. So just putting
this test fix after the next patch wouldn't be any worse, the test would
fail for a single revision.

I'm more or less fine with this, but you could also just squash this
patch into the next one; it's small enough.

Or you find a way to split up the next patch so this can go in between.

> diff --git a/tests/test-replication.c b/tests/test-replication.c
> index fac2da3..5bede49 100644
> --- a/tests/test-replication.c
> +++ b/tests/test-replication.c
> @@ -179,7 +179,8 @@ static BlockBackend *start_primary(void)
>      char *cmdline;
> =20
>      cmdline =3D g_strdup_printf("driver=3Dreplication,mode=3Dprimary,n=
ode-name=3Dxxx,"
> -                              "file.driver=3Dqcow2,file.file.filename=3D=
%s"
> +                              "file.driver=3Dqcow2,file.file.filename=3D=
%s,"
> +                              "file.file.disable-lock=3Don"
>                                , p_local_disk);

That is interesting formatting (albeit pre-existing).

>      opts =3D qemu_opts_parse_noisily(&qemu_drive_opts, cmdline, false)=
;
>      g_free(cmdline);
> @@ -310,7 +311,9 @@ static BlockBackend *start_secondary(void)
>      Error *local_err =3D NULL;
> =20
>      /* add s_local_disk and forge S_LOCAL_DISK_ID */
> -    cmdline =3D g_strdup_printf("file.filename=3D%s,driver=3Dqcow2", s=
_local_disk);
> +    cmdline =3D g_strdup_printf("file.filename=3D%s,driver=3Dqcow2,"
> +                              "file.file.disable-lock=3Don",
> +                              s_local_disk);
>      opts =3D qemu_opts_parse_noisily(&qemu_drive_opts, cmdline, false)=
;
>      g_free(cmdline);
> =20
> @@ -331,8 +334,10 @@ static BlockBackend *start_secondary(void)
>      /* add S_(ACTIVE/HIDDEN)_DISK and forge S_ID */
>      cmdline =3D g_strdup_printf("driver=3Dreplication,mode=3Dsecondary=
,top-id=3D%s,"
>                                "file.driver=3Dqcow2,file.file.filename=3D=
%s,"
> +                              "file.file.disable-lock=3Don",

Comma should be before the " (gcc complains about a format string error
when compiling).

>                                "file.backing.driver=3Dqcow2,"
>                                "file.backing.file.filename=3D%s,"
> +                              "file.backing.file.disable-lock=3Don",

Same here.

Max

>                                "file.backing.backing=3D%s"
>                                , S_ID, s_active_disk, s_hidden_disk
>                                , S_LOCAL_DISK_ID);
>=20



--6ijgqoNhMB7I7V05IQqC6evPGDiB2QKBt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliabNMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AEjkH/j47geYpDKNjj1ug1yY5XAv4s8l++AOI
bd6xJpJPlG2Vu43THm+5sasYwV5TYMkS/7hXeVmyk7ZJE4WLr+muGxKWHiNEtZVv
BzYuju2U/0PNKR6qctMLSK/VoVj9TigLuxDan0bzZ0FlKWQd0/S16ADJHt6vy/K0
hvGwAc2pDq5txGDQsfVz9+RVTAOD7jneNpkNan8WExtsnFxKRY+J9Pwu+rw8op6k
zBlAAewHfiaaVEBtKzrot0ALDRMZ0DRVDPWx3Trm4M4V0qpIuuVaISteq2OXXOBk
9wGn/pU0YcovKKkrxNA+RINjZ3FkdLQB+JqwGbv11Czi9AqO1TsbZ1E=
=Ylfw
-----END PGP SIGNATURE-----

--6ijgqoNhMB7I7V05IQqC6evPGDiB2QKBt--
