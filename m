Received: from eggs.gnu.org ([2001:4830:134:3::10]:39509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebXxZ-0007xV-Kz
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:35:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebXxY-0004gX-9l
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:35:53 -0500
References: <20180115225047.28607-1-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cf2e7128-9062-c270-5def-5f05a1001d47@redhat.com>
Date: Tue, 16 Jan 2018 14:35:36 -0600
MIME-Version: 1.0
In-Reply-To: <20180115225047.28607-1-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="palW329kmR1ne7dmWjT7sEomA2joaAJPG"
Subject: Re: [Qemu-devel] [PATCH v2] file-posix: specify expected filetypes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--palW329kmR1ne7dmWjT7sEomA2joaAJPG
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Message-ID: <cf2e7128-9062-c270-5def-5f05a1001d47@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] file-posix: specify expected filetypes
References: <20180115225047.28607-1-jsnow@redhat.com>
In-Reply-To: <20180115225047.28607-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/15/2018 04:50 PM, John Snow wrote:
> I don't think there's a legitimate reason to open directories as if
> they were files. This prevents QEMU from opening and attempting to prob=
e
> a directory inode, which can break in exciting ways. One of those ways
> is lseek on ext4/xfs, which will return 0x7fffffffffffffff as the file
> size instead of EISDIR. This can coax QEMU into responding with a
> confusing "file too big" instead of "Hey, that's not a file".
>=20
> See: https://bugs.launchpad.net/qemu/+bug/1739304/
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>=20

> @@ -556,10 +557,30 @@ static int raw_open_common(BlockDriverState *bs, =
QDict *options,
>          error_setg_errno(errp, errno, "Could not stat file");
>          goto fail;
>      }
> -    if (S_ISREG(st.st_mode)) {
> -        s->discard_zeroes =3D true;
> -        s->has_fallocate =3D true;
> +
> +    if (!device) {
> +        if (S_ISBLK(st.st_mode)) {
> +            warn_report("Opening a block device as file using 'file'"
> +                        "driver is deprecated");

Do we have a proper deprecation documentation in place, and a time frame
for when we'd start rejecting this rather than permitting it with the
warning?

> +        } else if (S_ISCHR(st.st_mode)) {
> +            warn_report("Opening a character device as file using the =
'file'"
> +                        "driver is deprecated");
> +        } else if (!S_ISREG(st.st_mode)) {
> +            error_setg(errp, "A regular file was expected by the 'file=
' driver,"
> +                       "but something else was given");

This makes sense.


> @@ -589,7 +610,6 @@ static int raw_open_common(BlockDriverState *bs, QD=
ict *options,
>          s->needs_alignment =3D true;
>      }
>  #endif
> -
>  #ifdef CONFIG_XFS
>      if (platform_test_xfs_fd(s->fd)) {

Spurious whitespace change.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--palW329kmR1ne7dmWjT7sEomA2joaAJPG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpeYhgACgkQp6FrSiUn
Q2o7Lgf/eSZAQL25mH7+y46cl9znwripuTmKjj+rpp14jtiszq2CqMniZ5XC0jmQ
rmvhg4RW8kjXJmWF91wI8/qlxBFp6SDKR6TvbIKsGNAEK9ck4O4gg7BZf+CrwP3y
lL00rl4Hs3x0NvzQ/Na29reIRwTVV+KU4L1EEYjLOaFzp6PVHqBm6jHV6ZaZ7n9S
467jmNOM1e6+ZHrhhMpfvAgFrBJhH+xgOihPXgMxsN8m2DfLUS8+ALNpLicAuj6V
0jVSpfCEZv6sCUi651EskeXAnca+q+nlw7a5FoBK0RERjV/C3wP2Jrr2J+OjM0mX
sT1IgEWvqqthlR31exMhlILL8MxwLA==
=ZijX
-----END PGP SIGNATURE-----

--palW329kmR1ne7dmWjT7sEomA2joaAJPG--
