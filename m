Received: from eggs.gnu.org ([2001:4830:134:3::10]:48132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1df9xS-0007bn-7E
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 15:14:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1df9xN-0004qa-R6
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 15:14:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1df9xN-0004p8-Hl
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 15:14:21 -0400
References: <150221331695.15915.4904484630739512874.stgit@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d9f906a7-eef1-e89c-36db-8e142a1272da@redhat.com>
Date: Tue, 8 Aug 2017 14:14:18 -0500
MIME-Version: 1.0
In-Reply-To: <150221331695.15915.4904484630739512874.stgit@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8uG1NiL4FPfui9L1vpoBmbuOIlJvIWXV4"
Subject: Re: [Qemu-devel] [for-2.10 PATCH] 9pfs: local: fix
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
Cc: zhiyong.wu@ucloud.cn

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8uG1NiL4FPfui9L1vpoBmbuOIlJvIWXV4
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: zhiyong.wu@ucloud.cn
Message-ID: <d9f906a7-eef1-e89c-36db-8e142a1272da@redhat.com>
Subject: Re: [for-2.10 PATCH] 9pfs: local: fix fchmodat_nofollow() limitations
References: <150221331695.15915.4904484630739512874.stgit@bahia.lan>
In-Reply-To: <150221331695.15915.4904484630739512874.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/08/2017 12:28 PM, Greg Kurz wrote:
> This function has to ensure it doesn't follow a symlink that could be u=
sed
> to escape the virtfs directory. This could be easily achieved if fchmod=
at()
> on linux honored the AT_SYMLINK_NOFOLLOW flag as described in POSIX, bu=
t
> it doesn't.
>=20
> The current implementation covers most use-cases, but it notably fails =
if:
> - the target path has access rights equal to 0000 (openat() returns EPE=
RM),
>   =3D> once you've done chmod(0000) on a file, you can never chmod() ag=
ain
> - the target path is UNIX domain socket (openat() returns ENXIO)
>   =3D> bind() of UNIX domain sockets fails if the file is on 9pfs

Did your attempt at a kernel patch for AT_SYMLINK_NOFOLLOW ever get
anywhere?

>=20
> The solution is to use O_PATH: openat() now succeeds in both cases, and=
 we
> can ensure the path isn't a symlink with fstat(). The associated entry =
in
> "/proc/self/fd" can hence be safely passed to the regular chmod() sysca=
ll.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |   44 ++++++++++++++++++++++++++++----------------=

>  hw/9pfs/9p-util.h  |   10 +++++++---
>  2 files changed, 35 insertions(+), 19 deletions(-)
>=20
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index 6e478f4765ef..b178d627c764 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -333,30 +333,42 @@ update_map_file:
> =20
>  static int fchmodat_nofollow(int dirfd, const char *name, mode_t mode)=

>  {
> +    struct stat stbuf;
>      int fd, ret;
> +    char *proc_path;
> =20
>      /* FIXME: this should be handled with fchmodat(AT_SYMLINK_NOFOLLOW=
).
> -     * Unfortunately, the linux kernel doesn't implement it yet. As an=

> -     * alternative, let's open the file and use fchmod() instead. This=

> -     * may fail depending on the permissions of the file, but it is th=
e
> -     * best we can do to avoid TOCTTOU. We first try to open read-only=

> -     * in case name points to a directory. If that fails, we try write=
-only
> -     * in case name doesn't point to a directory.
> +     * Unfortunately, the linux kernel doesn't implement it yet.
>       */
> -    fd =3D openat_file(dirfd, name, O_RDONLY, 0);
> -    if (fd =3D=3D -1) {
> -        /* In case the file is writable-only and isn't a directory. */=

> -        if (errno =3D=3D EACCES) {
> -            fd =3D openat_file(dirfd, name, O_WRONLY, 0);
> -        }
> -        if (fd =3D=3D -1 && errno =3D=3D EISDIR) {
> -            errno =3D EACCES;
> -        }
> +    if (fstatat(dirfd, name, &stbuf, AT_SYMLINK_NOFOLLOW)) {
> +        return -1;
>      }

Checking the file...

> +
> +    if (S_ISLNK(stbuf.st_mode)) {
> +        errno =3D ELOOP;
> +        return -1;
> +    }
> +
> +    fd =3D openat_file(dirfd, name, O_RDONLY | O_PATH, 0);

=2E..and then opening the file is a TOCTTOU race (although it works most
of the time and avoids the open where it is easy)...

>      if (fd =3D=3D -1) {
>          return -1;
>      }
> -    ret =3D fchmod(fd, mode);
> +
> +    ret =3D fstat(fd, &stbuf);
> +    if (ret) {
> +        goto out;
> +    }

=2E..so you are double-checking that you got a non-symlink after all (you=
r
insurance against the race having done the wrong thing [but see below])..=
=2E

> +
> +    if (S_ISLNK(stbuf.st_mode)) {
> +        errno =3D ELOOP;
> +        ret =3D -1;
> +        goto out;
> +    }
> +
> +    proc_path =3D g_strdup_printf("/proc/self/fd/%d", fd);
> +    ret =3D chmod(proc_path, mode);

=2E..at which point you now have a valid file name that represents the
file you wanted to chmod() in the first place (even if another rename
occurs in the meantime, you are changing the mode tied to the
non-symlink fd that you double-checked, which ends up behaving as if you
had won the race and made the chmod() call before the rename).

> +    g_free(proc_path);
> +out:
>      close_preserve_errno(fd);
>      return ret;

Might be worth littering some comments in the code explaining why you
have to call both fstatat() and stat(), or perhaps you could drop the
first fstatat() and just always do the open().

Reading 'man open', it looks like O_PATH will chase symlinks UNLESS you
also use O_NOFOLLOW.  So I had to code up a simple test program to
verify if things work...

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#define _GNU_SOURCE 1
#include <sys/stat.h>
#include <stdio.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>

int main(void) {
    struct stat st;
    int fd;

    remove("f");
    remove("l");
    if (creat("f", 0) < 0)
        return 1;
    if (symlink("f", "l") < 0)
        return 2;

    fd =3D open("l", O_RDONLY | O_PATH);
    if (fd < 0)
        return 3;
    if (fstat(fd, &st) < 0)
        return 4;
    if (S_ISLNK(st.st_mode)) {
        printf("got a link\n");
    } else {
        printf("dereferenced\n");
    }
    close(fd);

    fd =3D open("l", O_RDONLY | O_PATH | O_NOFOLLOW);
    if (fd < 0)
        return 5;
    if (fstat(fd, &st) < 0)
        return 6;
    if (S_ISLNK(st.st_mode)) {
        printf("got a link\n");
    } else {
        printf("dereferenced\n");
    }
    close(fd);

    remove("f");
    remove("l");
    return 0;
}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
$ ./foo
dereferenced
got a link

Ouch - you need to fix your patch to use open(O_NOFOLLOW | O_PATH).

Furthermore, I'm worried that your patch is regressing commit 918112c0,
when compiling for older platforms where either O_PATH does not exist,
or where libc exposes the constant but the kernel is too old to
understand it.  (I guess the latter problem is already existing in our
code base, so we really only need to worry about the former of compiling
when the constant does not exist).  So if supporting old platforms is
desired, you MUST keep BOTH approaches intact, gated by whether O_PATH
is defined to a non-zero value, rather than just assuming O_PATH works.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--8uG1NiL4FPfui9L1vpoBmbuOIlJvIWXV4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmKDYoACgkQp6FrSiUn
Q2orYAf/V5ZIJ0MxsOIdyc6INLRP1Zmw73qW9FLGMSrtf6dtyuz5LEH8BIN8ib0T
bNfP91T21WHZKh7bv1VHn4cetieNiEnpC1wqU70fAPoUh9Al0Od05rBOudd4u6jK
lLD20GQ7PjH1MODPkvVS43R2oEKEcpXnPHP+ZGPD68dXfgYHaEyYgoRkzKKwuNWH
4IYEeIu+8WX14dEsRJVt2vD4dLOiuF9VK8C2C906d+zFGduxfzBTqucYepzGmdQl
7Cc29LLbqe7KnLSOb8H42p9QccMb1VyV+7t+7Rl8qGx19yld1rl8k8Cx/Ym3Sdip
aLGQ1cKWRiRDgzsvoduqi+jxm2l0bQ==
=kCID
-----END PGP SIGNATURE-----

--8uG1NiL4FPfui9L1vpoBmbuOIlJvIWXV4--
