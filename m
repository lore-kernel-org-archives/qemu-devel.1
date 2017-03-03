Received: from eggs.gnu.org ([2001:4830:134:3::10]:54893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjwrd-0005Az-Hn
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 18:43:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjwra-000075-E5
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 18:43:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cjwra-000053-4n
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 18:43:54 -0500
References: <148856193073.554.6631259860971664030.stgit@bahia>
	<ef91a081-c25f-881e-eb60-90798df36a5a@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ebe5c30c-0af6-7f5b-15bf-4626773a2a9d@redhat.com>
Date: Fri, 3 Mar 2017 17:43:49 -0600
MIME-Version: 1.0
In-Reply-To: <ef91a081-c25f-881e-eb60-90798df36a5a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NdrJEkmW6WTVLg1FH5NXNdKgQV4PQMgps"
Subject: Re: [Qemu-devel] [PATCH] 9pfs: fix vulnerability in openat_dir()
 and local_unlinkat_common()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NdrJEkmW6WTVLg1FH5NXNdKgQV4PQMgps
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <ebe5c30c-0af6-7f5b-15bf-4626773a2a9d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] 9pfs: fix vulnerability in openat_dir() and
 local_unlinkat_common()
References: <148856193073.554.6631259860971664030.stgit@bahia>
 <ef91a081-c25f-881e-eb60-90798df36a5a@redhat.com>
In-Reply-To: <ef91a081-c25f-881e-eb60-90798df36a5a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/03/2017 12:14 PM, Eric Blake wrote:
> On 03/03/2017 11:25 AM, Greg Kurz wrote:
>> We should pass O_NOFOLLOW otherwise openat() will follow symlinks and =
make
>> QEMU vulnerable.
>>
>> O_PATH was used as an optimization: the fd returned by openat_dir() is=
 only
>> passed to openat() actually, so we don't really need to reach the unde=
rlying
>> filesystem.
>>
>> O_NOFOLLOW | O_PATH isn't an option: if name is a symlink, openat() wi=
ll
>> return a fd, forcing us to do some other syscall to detect we have a
>> symlink. Also, O_PATH doesn't exist in glibc 2.13 and older.
>=20
> But the very next use of openat(fd, ) should fail with EBADF if fd is

or ENOTDIR, actually

> not a directory, so you don't need any extra syscalls.  I agree that we=

> _need_ O_NOFOLLOW, but I'm not yet convinced that we must avoid O_PATH
> where it works.
>=20
> I'm in the middle of writing a test program to probe kernel behavior an=
d
> demonstrate (at least to myself) whether there are scenarios where
> O_PATH makes it possible to open something where omitting it did not,
> while at the same time validating that O_NOFOLLOW doesn't cause problem=
s
> if a symlink-fd is returned instead of a directory fd, based on our
> subsequent use of that fd in a *at call.

My test case is below.  Note that based on my testing, I think you want
a v2 of this patch, which does:

#ifndef O_PATH
#define O_PATH 0
#endif

 static inline int openat_dir(int dirfd, const char *name)
 {
-    return openat(dirfd, name, O_DIRECTORY | O_RDONLY | O_PATH);
+    return openat(dirfd, name, O_DIRECTORY | O_RDONLY | O_NOFOLLOW |
O_PATH);
 }



#define _GNU_SOURCE 1
#include <stdio.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <unistd.h>
#include <errno.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
    int i =3D 0;
    int ret =3D 1;
    int fd;
    struct stat st;

    if (mkdir("d", 0700) < 0) {
        printf("giving up, please try again once 'd' is removed\n");
        return ret;
    }

    /* Create a playground for testing with. */
    i =3D 1;
    if (creat("d/file", 0600) < 0)
        goto cleanup;
    i =3D 2;
    if (mkdir("d/subdir", 0700) < 0)
        goto cleanup;
    i =3D 3;
    if (creat("d/subdir/subfile", 0600) < 0)
        goto cleanup;
    i =3D 4;
    if (chmod("d/subdir", 0100) < 0)
        goto cleanup;
    i =3D 5;
    if (symlink("file", "d/link-file") < 0)
        goto cleanup;
    i =3D 6;
    if (symlink("subdir", "d/link-subdir") < 0)
        goto cleanup;

    /* Sanity: We can stat a child file with just search permissions,
     * whether via a directory or symlink-to-directory */
    i =3D 7;
    if (stat("d/subdir/subfile", &st) < 0)
        goto cleanup;
    i =3D 8;
    if (stat("d/link-subdir/subfile", &st) < 0)
        goto cleanup;

    /* Since the directory is not readable, we can't get a normal fd */
    fd =3D open("d/subdir", O_DIRECTORY | O_NOFOLLOW | O_RDONLY);
    if (fd !=3D -1) {
        printf("unexpected success opening non-readable dir\n");
        ret =3D 2;
        goto cleanup;
    }
    /* But we can get at it with O_PATH */
    i =3D 9;
    fd =3D open("d/subdir", O_DIRECTORY | O_NOFOLLOW | O_RDONLY | O_PATH)=
;
    if (fd < 0)
        goto cleanup;
    /* And use it in *at functions */
    i =3D 10;
    if (fstatat(fd, "subfile", &st, 0) < 0)
        goto cleanup;
    i =3D 11;
    if (close(fd) < 0)
        goto cleanup;

    /* Note that O_DIRECTORY fails on symlinks with O_PATH... */
    i =3D 12;
    fd =3D open("d/link-subdir", O_DIRECTORY | O_NOFOLLOW | O_RDONLY |
O_PATH);
    if (fd !=3D -1) {
        printf("unexpected success on symlink-dir with O_DIRECTORY\n");
        ret =3D 2;
        goto cleanup;
    }
    /* or on symlinks to files regardless of O_PATH... */
    i =3D 13;
    fd =3D open("d/link-file", O_DIRECTORY | O_NOFOLLOW | O_RDONLY | O_PA=
TH);
    if (fd !=3D -1) {
        printf("unexpected success on symlink-file with
O_DIRECTORY|O_PATH\n");
        ret =3D 2;
        goto cleanup;
    }
    i =3D 14;
    fd =3D open("d/link-file", O_DIRECTORY | O_NOFOLLOW | O_RDONLY);
    if (fd !=3D -1) {
        printf("unexpected success on symlink-file with just
O_DIRECTORY\n");
        ret =3D 2;
        goto cleanup;
    }
    /* but O_PATH without O_DIRECTORY opens a symlink fd */
    i =3D 15;
    fd =3D open("d/link-subdir", O_NOFOLLOW | O_RDONLY | O_PATH);
    if (fd < 0)
        goto cleanup;
    /* However, that symlink fd is not usable in *at */
    i =3D 16;
    if (fstatat(fd, "subfile", &st, 0) =3D=3D 0) {
        printf("unexpected success using symlink fd in fstatat\n");
        ret =3D 2;
        goto cleanup;
    }
    if (errno !=3D EBADF && errno !=3D ENOTDIR)
        goto cleanup;
    i =3D 17;
    if (close(fd) < 0)
        goto cleanup;

    printf("All tests passed\n");
    ret =3D 0;

 cleanup:
    if (ret =3D=3D 1) {
        perror("unexpected failure");
        printf("encountered when i=3D%d\n", i);
    }
    system("chmod -R u+rwx d; rm -rf d");
    return ret;
}



--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--NdrJEkmW6WTVLg1FH5NXNdKgQV4PQMgps
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYuf+1AAoJEKeha0olJ0NqPV8H/0pmcETl8xoOFUN1GUi7fmVT
SYtP4eDPdDYyNkzym2Fyot6jpa4ePGUJQj4nplwq6KeSekIWBGTOQojGVpS9hFhs
RcO44TOcKpWOIO9borMZp0HdMpYvArZtA4dSRiufJ2iVt1cjCeHU2GjOO4fakJJQ
4bwP6F4A5A4NkxrxhLvCHeFkACG5/ntwwn+s4M1bgx/Eq9qvtNRDb2lKCf7yJN7a
XTBenqZdKt2QsM3IaMCrpmyAZoc+336/J5LDbKrcsojKkpwCZAMhKn/LkSga0Rbi
yFI27h1kQR3SJhI3gDUTfkItJTFluQD5mK2gUO+eJeUOQ30q0B+IDd8xBUY+D/A=
=Wg6v
-----END PGP SIGNATURE-----

--NdrJEkmW6WTVLg1FH5NXNdKgQV4PQMgps--
