Received: from eggs.gnu.org ([2001:4830:134:3::10]:45367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfSOb-0001Lb-SW
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:55:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfSOW-0001Bh-P3
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:55:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dfSOW-0001Ab-55
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:55:36 -0400
References: <150228860899.28168.1415083032613087245.stgit@bahia>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d1343f6c-d524-0174-d1b7-fda2d83a3a44@redhat.com>
Date: Wed, 9 Aug 2017 09:55:32 -0500
MIME-Version: 1.0
In-Reply-To: <150228860899.28168.1415083032613087245.stgit@bahia>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JmHjilLhNlox918jmI56eWA7KurjdpAvM"
Subject: Re: [Qemu-devel] [for-2.10 PATCH v2] 9pfs: local: fix
 fchmodat_nofollow() limitations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: zhiyong.wu@ucloud.cn, Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JmHjilLhNlox918jmI56eWA7KurjdpAvM
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: zhiyong.wu@ucloud.cn, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d1343f6c-d524-0174-d1b7-fda2d83a3a44@redhat.com>
Subject: Re: [for-2.10 PATCH v2] 9pfs: local: fix fchmodat_nofollow()
 limitations
References: <150228860899.28168.1415083032613087245.stgit@bahia>
In-Reply-To: <150228860899.28168.1415083032613087245.stgit@bahia>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/09/2017 09:23 AM, Greg Kurz wrote:
> This function has to ensure it doesn't follow a symlink that could be u=
sed
> to escape the virtfs directory. This could be easily achieved if fchmod=
at()
> on linux honored the AT_SYMLINK_NOFOLLOW flag as described in POSIX, bu=
t
> it doesn't.

Might be worth including a URL of the LKML discussion on the last
version of that patch attempt.

>=20
> The current implementation covers most use-cases, but it notably fails =
if:
> - the target path has access rights equal to 0000 (openat() returns EPE=
RM),
>   =3D> once you've done chmod(0000) on a file, you can never chmod() ag=
ain
> - the target path is UNIX domain socket (openat() returns ENXIO)
>   =3D> bind() of UNIX domain sockets fails if the file is on 9pfs
>=20
> The solution is to use O_PATH: openat() now succeeds in both cases, and=
 we
> can ensure the path isn't a symlink with fstat(). The associated entry =
in
> "/proc/self/fd" can hence be safely passed to the regular chmod() sysca=
ll.

Hey - should we point this out as a viable solution to the glibc folks,
since their current user-space emulation of AT_SYMLINK_NOFOLLOW is broken=
?

>=20
> The previous behavior is kept for older systems that don't have O_PATH.=

>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v2: - renamed OPENAT_DIR_O_PATH to O_PATH_9P_UTIL and use it as a repla=
cement
>       for O_PATH to avoid build breaks on O_PATH-less systems
>     - keep current behavior for O_PATH-less systems
>     - added comments
>     - TODO in 2.11: add _nofollow suffix to openat_dir() and openat_fil=
e()
> ---
>  hw/9pfs/9p-local.c |   41 +++++++++++++++++++++++++++++++++--------
>  hw/9pfs/9p-util.h  |   24 +++++++++++++++---------
>  2 files changed, 48 insertions(+), 17 deletions(-)
>=20
> +     /* First, we clear non-racing symlinks out of the way. */
> +    if (fstatat(dirfd, name, &stbuf, AT_SYMLINK_NOFOLLOW)) {
> +        return -1;
> +    }
> +    if (S_ISLNK(stbuf.st_mode)) {
> +        errno =3D ELOOP;

I don't know if ELOOP is the best errno value to use here, but I don't
have any better suggestions so I'm okay with it.

> +        return -1;
> +    }
> +
> +    /* Access modes are ignored when O_PATH is supported. We try O_RDO=
NLY and
> +     * O_WRONLY for old-systems that don't support O_PATH.
>       */
> -    fd =3D openat_file(dirfd, name, O_RDONLY, 0);
> +    fd =3D openat_file(dirfd, name, O_RDONLY | O_PATH_9P_UTIL, 0);
>      if (fd =3D=3D -1) {
>          /* In case the file is writable-only and isn't a directory. */=

>          if (errno =3D=3D EACCES) {
> @@ -356,7 +366,22 @@ static int fchmodat_nofollow(int dirfd, const char=
 *name, mode_t mode)
>      if (fd =3D=3D -1) {
>          return -1;
>      }
> -    ret =3D fchmod(fd, mode);
> +
> +    /* Now we handle racing symlinks. */
> +    ret =3D fstat(fd, &stbuf);
> +    if (ret) {
> +        goto out;
> +    }
> +    if (S_ISLNK(stbuf.st_mode)) {
> +        errno =3D ELOOP;
> +        ret =3D -1;
> +        goto out;
> +    }
> +
> +    proc_path =3D g_strdup_printf("/proc/self/fd/%d", fd);
> +    ret =3D chmod(proc_path, mode);

Nope, unsafe when O_PATH_9P_UTIL is 0.  This needs to be more like:

/* Now we handle racing symlinks.  On kernels without O_PATH, we will
 * fail on some corner cases, but that's better than dereferencing a
 * symlink that was injected during the TOCTTOU between our initial
 * fstatat() and openat_file().
 */
if (O_PATH_9P_UTIL) {
    fstat, S_ISLINK, proc_path, chmod()
} else {
    fchmod()
}

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--JmHjilLhNlox918jmI56eWA7KurjdpAvM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmLImQACgkQp6FrSiUn
Q2qr2Af/W+kE7Ysk6KmczhxLyUJC9KlU6dHc+BQcoQ92bqJmCP6J4eOkU3KEl2xe
bNQNymv3EkG0Pld6ti22N/g7Cs9S7arvNoxdO30uFGClndGyOM9Q/qxwDMUkkzNj
FoJqz3FjI8Cj89oWKRgZenlXek7IWp+Y/r1NOEFBPKuQWgSKYelrcIFK7OZARFkl
z2ptsGxGJcm5FG8T7uftyewbMscfN7wHWP6oWZvN7yGnChGsNcDyBK37ZJrn4HUP
/OLT3Ep3W3PaF3gOCVEGVsxTXYyRj2JJTj/b9JagvIhtytBfuq4DCMMy1SeYTKhS
Qu/ZATz+0BpZ3rrPfy3NjY8EBXL/kA==
=Zx2f
-----END PGP SIGNATURE-----

--JmHjilLhNlox918jmI56eWA7KurjdpAvM--
