Received: from eggs.gnu.org ([2001:4830:134:3::10]:57842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chHiY-0000tb-09
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:23:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chHiU-00050G-17
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:23:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1chHiT-000508-O9
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:23:29 -0500
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760173919.31154.7555675803159581620.stgit@bahia.lan>
	<20170223151042.GW30636@stefanha-x1.localdomain>
	<20170224113402.07a0fb44@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b3f08f09-9678-2142-c4d7-5a66f49b173d@redhat.com>
Date: Fri, 24 Feb 2017 09:23:25 -0600
MIME-Version: 1.0
In-Reply-To: <20170224113402.07a0fb44@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5MDGE0E9igk1obFoVhH0bIMFahEmMrrEW"
Subject: Re: [Qemu-devel] [PATCH 23/29] 9pfs: local: chmod: don't follow
 symlinks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5MDGE0E9igk1obFoVhH0bIMFahEmMrrEW
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Jann Horn <jannh@google.com>,
 Prasad J Pandit <prasad@redhat.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <b3f08f09-9678-2142-c4d7-5a66f49b173d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 23/29] 9pfs: local: chmod: don't follow
 symlinks
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
 <148760173919.31154.7555675803159581620.stgit@bahia.lan>
 <20170223151042.GW30636@stefanha-x1.localdomain>
 <20170224113402.07a0fb44@bahia.lan>
In-Reply-To: <20170224113402.07a0fb44@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/24/2017 04:34 AM, Greg Kurz wrote:
> On Thu, 23 Feb 2017 15:10:42 +0000
> Stefan Hajnoczi <stefanha@gmail.com> wrote:
>=20
>> On Mon, Feb 20, 2017 at 03:42:19PM +0100, Greg Kurz wrote:
>>> The local_chmod() callback is vulnerable to symlink attacks because i=
t
>>> calls:
>>>
>>> (1) chmod() which follows symbolic links for all path elements
>>> (2) local_set_xattr()->setxattr() which follows symbolic links for al=
l
>>>     path elements
>>> (3) local_set_mapped_file_attr() which calls in turn local_fopen() an=
d
>>>     mkdir(), both functions following symbolic links for all path
>>>     elements but the rightmost one
>>>

>>> +        fd =3D local_open_nofollow(fs_ctx, fs_path->data, O_RDONLY, =
0);
>>> +        if (fd =3D=3D -1) {
>>> +            return -1;
>>> +        }
>>> +        ret =3D fchmod(fd, credp->fc_mode);
>>> +        close_preserve_errno(fd); =20
>>
>> As mentioned on IRC, not sure this is workable since chmod(2) must not=

>> require read permission on the file.  This patch introduces failures
>> when the file isn't readable.
>>
>=20
> Yeah :-\ This one is the more painful issue to address. I need a
> chmod() variant that would fail on symlinks instead of following
> them... and I'm kinda suffering to implement this in a race-free
> manner.

BSD has lchmod(), but Linux does not.  And Linux does not yet properly
implement AT_SYMLINK_NOFOLLOW.  (The BSD semantics are pretty cool:
restricting mode bits on a symlink can create scenarios where some users
can dereference the symlink but others get ENOENT failures - but I don't
know of any effort to add those semantics to the Linux kernel)

POSIX says support for AT_SYMLINK_NOFOLLOW is optional, precisely
because POSIX does not require permissions on symlinks to matter, but
the way it requires it is that AT_SYMLINK_NOFOLLOW is supposed to be a
no-op for regular files, and cause an EOPNOTSUPP failure for symlinks.

Unfortunately, the Linux man page says that Linux fails with ENOTSUP
(which is identical to EOPNOTSUPP) any time AT_SYMLINK_NOFOLLOW is set,
and not just if it is attempted on a symlink.  And I just verified that
poor behavior as follows:

$ cat foo.c
#include <stdio.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <unistd.h>
#include <errno.h>

int main(int argc, char **argv)
{
    int ret =3D 1;
    if (symlink("a", "l") < 0)
        goto cleanup;
    if (fchmodat(AT_FDCWD, "l", 0600, AT_SYMLINK_NOFOLLOW) =3D=3D 0)
        printf("kernel supports mode bits on symlinks\n");
    else if (errno !=3D EOPNOTSUPP) {
        printf("Oops, kernel failed with %m on symlink\n");
        goto cleanup;
    }
    if (creat("f", 0600) < 0)
        goto cleanup;
    if (fchmodat(AT_FDCWD, "f", 0600, AT_SYMLINK_NOFOLLOW) < 0) {
        printf("Oops, kernel failed with %m on regular file\n");
        goto cleanup;
    }
    ret =3D 0;
 cleanup:
    remove("l");
    remove("f");
    return ret;
}
$ ./foo
Oops, kernel failed with Operation not supported on regular file

If you were to get that kernel bug fixed, then you could use fchmodat()
to do a safe chmod() which does not chase through a final symlink, and
relative to a safe directory fd that you obtain for the rest of the path
(as done elsewhere in the series).  Use the CVE nature of the problem as
leverage on the kernel developers, if that's what it takes.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--5MDGE0E9igk1obFoVhH0bIMFahEmMrrEW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYsE/tAAoJEKeha0olJ0Nqea0H/Ro8QjCZycaYYVU3stlSzCFT
Q9psWrWe5R7mXq/MVC7mTMwNUokNc4t+2zeXOGBQI/DmMbiNAHV8hNmHf+HC/1I7
kQ1MJtYpIMDi6JeRLJhvjTx0elcR0UfchEBsPknKX0HmsQhpXC2IrrC/rZLXmT8d
gqM8Yfv7RyW2Qvag+IfbOb9tfvJhqcq2RPVom1E64tIpFSa/MCu2e/0CTQBm7JAq
OLdQXHOkIcN6lX6Ujq+KnmZ+Obzbk6aV32+Af5ShRKBZDNvpMjv7jleGrqFFNTaC
DHahvmGYJU8LLzgY3bQv5hdkKH0hubx4f+URzplWZEFbOaEbcCOETCjrEOjpMaw=
=UTWc
-----END PGP SIGNATURE-----

--5MDGE0E9igk1obFoVhH0bIMFahEmMrrEW--
