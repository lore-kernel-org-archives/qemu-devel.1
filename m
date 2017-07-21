Received: from eggs.gnu.org ([2001:4830:134:3::10]:53823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYX5J-0002Pu-Fy
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:31:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYX5I-0004E8-Bm
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:31:09 -0400
References: <20170721102059.14663-1-famz@redhat.com>
	<20170721102059.14663-2-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d0569b90-8e46-aac1-4ceb-70c10260b1e5@redhat.com>
Date: Fri, 21 Jul 2017 07:30:56 -0500
MIME-Version: 1.0
In-Reply-To: <20170721102059.14663-2-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qSEL17FGUsxVrGBfUXG5fO6WPJpR1smhR"
Subject: Re: [Qemu-devel] [PATCH 1/2] osdep: Add runtime OFD lock detection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, jsnow@redhat.com, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qSEL17FGUsxVrGBfUXG5fO6WPJpR1smhR
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, jsnow@redhat.com,
 Max Reitz <mreitz@redhat.com>
Message-ID: <d0569b90-8e46-aac1-4ceb-70c10260b1e5@redhat.com>
Subject: Re: [PATCH 1/2] osdep: Add runtime OFD lock detection
References: <20170721102059.14663-1-famz@redhat.com>
 <20170721102059.14663-2-famz@redhat.com>
In-Reply-To: <20170721102059.14663-2-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/21/2017 05:20 AM, Fam Zheng wrote:
> Build time check of OFD lock is not sufficient and can cause image open=

> errors when the runtime environment doesn't support it.
>=20
> Add a helper function to probe it at runtime, additionally. Also provid=
e
> a qemu_has_ofd_lock() for callers to check the status.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  include/qemu/osdep.h |  1 +
>  util/osdep.c         | 72 ++++++++++++++++++++++++++++++++++++++++++++=
+-------
>  2 files changed, 64 insertions(+), 9 deletions(-)

> =20
> +static void qemu_probe_lock_ops(void)
> +{
> +    if (fcntl_op_setlk =3D=3D -1) {
> +#ifdef F_OFD_SETLK
> +        int fd;
> +        int ret;
> +        const char *tmpdir;
> +        char *filename;
> +        struct flock fl =3D {
> +            .l_whence =3D SEEK_SET,
> +            .l_start  =3D 0,
> +            .l_len    =3D 0,
> +            .l_type   =3D F_WRLCK,

Do we actually need to grab a lock over the entire file,...

> +        };
> +
> +        tmpdir =3D getenv("TMPDIR");
> +        if (!tmpdir) {
> +            tmpdir =3D "/var/tmp";
> +        }
> +        filename =3D g_strdup_printf("%s/qemu_lock_probe.XXXXXX", tmpd=
ir);
> +        fd =3D mkstemp(filename);

Can we skip the temporary file, and just open("/dev/null", O_RDWR), for
slightly less work?

> +        if (fd < 0) {
> +            fprintf(stderr, "Failed to create temporary file '%s': %s\=
n",
> +                    filename, strerror(errno));
> +            fcntl_op_setlk =3D F_SETLK;
> +            fcntl_op_getlk =3D F_GETLK;
> +            goto out;
> +        }
> +        ret =3D fcntl(fd, F_OFD_SETLK, &fl);

=2E..or should we change this to the much-weaker F_OFD_GETLK?  I guess it=

doesn't matter if we use a temporary file, but does if we are trying to
simplify by using /dev/null.

At any rate, the rest of the patch looks sane.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qSEL17FGUsxVrGBfUXG5fO6WPJpR1smhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllx9AAACgkQp6FrSiUn
Q2o9Igf/TDXNfa7GpnGhd9VlxzkztlzPsaJD14JtLx6o6WBIVHzJ57Wvmc7oc6Ww
myqWAz43DyJ8EkzU4hFWIDcnFvjXV+K3j6AWqYq+3cSOngubHaecdzKwkHVgXKwu
noQLVPSDxMfb0T/qX22FuRuMZMJbWcqf5PFNOnF0ti3BdDjI2HwQZfY/x+DXon96
5d92aCKz49+4a3kmFDQUaDmE0EJ8OnI5yek1cY27pju8pcJcFcGdKo9bolro6reG
nvDHkIfPEsTkA2pYPpMf9NdWWUMs+YVHmvMhlkrvs+Geemq1Kgd0Rz6fpQkvYTC8
+wjCaPkLQQhcxmOyLTFBbuN1OAIcOQ==
=qvVT
-----END PGP SIGNATURE-----

--qSEL17FGUsxVrGBfUXG5fO6WPJpR1smhR--
