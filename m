Received: from eggs.gnu.org ([2001:4830:134:3::10]:59843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbTbZ-0007r8-DK
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 09:52:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbTbY-0004w8-Ci
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 09:52:21 -0500
References: <20170123123056.30383-1-famz@redhat.com>
	<20170123123056.30383-17-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3b90326b-1daa-f438-fe33-c7600ccfd4ef@redhat.com>
Date: Wed, 8 Feb 2017 15:52:10 +0100
MIME-Version: 1.0
In-Reply-To: <20170123123056.30383-17-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3p0mJnm59TjLi4KCDQTdiB8HgnuGM0IPG"
Subject: Re: [Qemu-devel] [PATCH v12 16/16] tests: Add test-image-lock
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
--3p0mJnm59TjLi4KCDQTdiB8HgnuGM0IPG
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org,
 eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com
Message-ID: <3b90326b-1daa-f438-fe33-c7600ccfd4ef@redhat.com>
Subject: Re: [PATCH v12 16/16] tests: Add test-image-lock
References: <20170123123056.30383-1-famz@redhat.com>
 <20170123123056.30383-17-famz@redhat.com>
In-Reply-To: <20170123123056.30383-17-famz@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 23.01.2017 13:30, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/Makefile.include   |   2 +
>  tests/test-image-lock.c  | 206 +++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/test-replication.c |   6 +-
>  3 files changed, 211 insertions(+), 3 deletions(-)
>  create mode 100644 tests/test-image-lock.c

Looks good overall, just some minor issues below.

[...]

> diff --git a/tests/test-image-lock.c b/tests/test-image-lock.c
> new file mode 100644
> index 0000000..9c929ca
> --- /dev/null
> +++ b/tests/test-image-lock.c
> @@ -0,0 +1,206 @@

[...]

> +int main(int argc, char **argv)
> +{
> +#ifndef F_OFD_SETLK
> +    return 0;
> +#endif
> +    int r;
> +    test_image_fd =3D mkstemp(test_image);
> +
> +    qemu_init_main_loop(&error_fatal);
> +    bdrv_init();
> +
> +    g_assert(test_image_fd >=3D 0);
> +    r =3D ftruncate(test_image_fd, TEST_IMAGE_SIZE);
> +    g_assert_cmpint(r, =3D=3D, 0);
> +    g_test_init(&argc, &argv, NULL);
> +    g_test_add_func("/image-lock/compat", test_compat);
> +    g_test_add_func("/image-lock/compat_after_reopen", test_compat_aft=
er_reopen);
> +    g_test_add_func("/image-lock/compat_0bytefile", test_0bytefile);
> +    g_test_add_func("/image-lock/disable", test_disable);

Maybe test_0bytefile should be the last test since it truncates the test
image to 0 bytes.

> +    aio_context_acquire(qemu_get_aio_context());
> +    r =3D g_test_run();
> +    aio_context_release(qemu_get_aio_context());

Should test_image be unlinked here?

> +    return r;
> +}


> diff --git a/tests/test-replication.c b/tests/test-replication.c
> index 5bede49..5fb69d2 100644
> --- a/tests/test-replication.c
> +++ b/tests/test-replication.c
> @@ -312,7 +312,7 @@ static BlockBackend *start_secondary(void)
> =20
>      /* add s_local_disk and forge S_LOCAL_DISK_ID */
>      cmdline =3D g_strdup_printf("file.filename=3D%s,driver=3Dqcow2,"
> -                              "file.file.disable-lock=3Don",
> +                              "file.disable-lock=3Don",
>                                s_local_disk);
>      opts =3D qemu_opts_parse_noisily(&qemu_drive_opts, cmdline, false)=
;
>      g_free(cmdline);
> @@ -334,10 +334,10 @@ static BlockBackend *start_secondary(void)
>      /* add S_(ACTIVE/HIDDEN)_DISK and forge S_ID */
>      cmdline =3D g_strdup_printf("driver=3Dreplication,mode=3Dsecondary=
,top-id=3D%s,"
>                                "file.driver=3Dqcow2,file.file.filename=3D=
%s,"
> -                              "file.file.disable-lock=3Don",
> +                              "file.file.disable-lock=3Don,"
>                                "file.backing.driver=3Dqcow2,"
>                                "file.backing.file.filename=3D%s,"
> -                              "file.backing.file.disable-lock=3Don",
> +                              "file.backing.file.disable-lock=3Don,"
>                                "file.backing.backing=3D%s"
>                                , S_ID, s_active_disk, s_hidden_disk
>                                , S_LOCAL_DISK_ID);
>=20

These two hunks should be in patch 13, I presume.

Max


--3p0mJnm59TjLi4KCDQTdiB8HgnuGM0IPG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlibMJoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A4Y0H/RS7C267BDHbRRK5W/ms3dlUtaVuLPdx
7Jvr2GlnX6HEBHNn0Xm6CTA7pnQybsKY5bN95eejEjz4s9vdIFvq6+NfGhwL7RkV
nPFhG/n+elJjuhtLkuatmrZ5pZTnjWB1YhI0/hr0jSumzVEE/7nexh4xKG044Io8
vm8Sb4dvlfbs2CQ5N29XmgAGP0ULWwzwtMXX92BZ3t3q/RWFl1qWolvYPbDndeKp
E48oIXhp6suI7Xr3CjSTUtEVcszGFM/yfk5f4xPUfjpYbuTSVwovoHNe0mab/lB7
j05LHdQlU6AMAOotoBsiZlRaQkiGtMTLzU9k/ID8h2f695n7CBqvXb0=
=Wd8e
-----END PGP SIGNATURE-----

--3p0mJnm59TjLi4KCDQTdiB8HgnuGM0IPG--
