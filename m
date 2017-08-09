Received: from eggs.gnu.org ([2001:4830:134:3::10]:47993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfSU6-0004A9-Hi
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfSU2-0004eG-Ld
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:01:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dfSU2-0004dY-9n
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:01:18 -0400
References: <150228860899.28168.1415083032613087245.stgit@bahia>
	<d1343f6c-d524-0174-d1b7-fda2d83a3a44@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4e7d8277-4930-9de5-bfce-04969f1f781d@redhat.com>
Date: Wed, 9 Aug 2017 10:01:14 -0500
MIME-Version: 1.0
In-Reply-To: <d1343f6c-d524-0174-d1b7-fda2d83a3a44@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LmxAkj9vo4LkWJ5HHCN5kC5ItvnVDVOuW"
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
--LmxAkj9vo4LkWJ5HHCN5kC5ItvnVDVOuW
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: zhiyong.wu@ucloud.cn, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4e7d8277-4930-9de5-bfce-04969f1f781d@redhat.com>
Subject: Re: [for-2.10 PATCH v2] 9pfs: local: fix fchmodat_nofollow()
 limitations
References: <150228860899.28168.1415083032613087245.stgit@bahia>
 <d1343f6c-d524-0174-d1b7-fda2d83a3a44@redhat.com>
In-Reply-To: <d1343f6c-d524-0174-d1b7-fda2d83a3a44@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/09/2017 09:55 AM, Eric Blake wrote:
> On 08/09/2017 09:23 AM, Greg Kurz wrote:
>> This function has to ensure it doesn't follow a symlink that could be =
used
>> to escape the virtfs directory. This could be easily achieved if fchmo=
dat()
>> on linux honored the AT_SYMLINK_NOFOLLOW flag as described in POSIX, b=
ut
>> it doesn't.
>=20
> Might be worth including a URL of the LKML discussion on the last
> version of that patch attempt.
>=20
>>
>> The current implementation covers most use-cases, but it notably fails=
 if:
>> - the target path has access rights equal to 0000 (openat() returns EP=
ERM),
>>   =3D> once you've done chmod(0000) on a file, you can never chmod() a=
gain
>> - the target path is UNIX domain socket (openat() returns ENXIO)
>>   =3D> bind() of UNIX domain sockets fails if the file is on 9pfs
>>
>> The solution is to use O_PATH: openat() now succeeds in both cases, an=
d we
>> can ensure the path isn't a symlink with fstat(). The associated entry=
 in
>> "/proc/self/fd" can hence be safely passed to the regular chmod() sysc=
all.
>=20
> Hey - should we point this out as a viable solution to the glibc folks,=

> since their current user-space emulation of AT_SYMLINK_NOFOLLOW is brok=
en?
>=20


> Nope, unsafe when O_PATH_9P_UTIL is 0.  This needs to be more like:
>=20
> /* Now we handle racing symlinks.  On kernels without O_PATH, we will
>  * fail on some corner cases, but that's better than dereferencing a
>  * symlink that was injected during the TOCTTOU between our initial
>  * fstatat() and openat_file().
>  */
> if (O_PATH_9P_UTIL) {
>     fstat, S_ISLINK, proc_path, chmod()
> } else {
>     fchmod()
> }

For that matter, I think you also want to avoid the O_WRONLY fallback
when O_PATH works, as in:

>> -    fd =3D openat_file(dirfd, name, O_RDONLY, 0);
>> +    fd =3D openat_file(dirfd, name, O_RDONLY | O_PATH_9P_UTIL, 0);
>>      if (fd =3D=3D -1) {

changing this to 'if (fd =3D=3D -1 && !O_PATH_9P_UTIL)'

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LmxAkj9vo4LkWJ5HHCN5kC5ItvnVDVOuW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmLI7oACgkQp6FrSiUn
Q2r6sQf7B56bmPswJTQ3Y1ioEnMe5SGfQ8VWxZm8RcXOzkxxJgGGbZct7cLmLzvv
iXaXSMVj4J766+Kim3ZS4BbSe5ls1Z76ANUqfxsIw+tFRuhKF4tDPZuTRWlYRuin
4v912ZeFeCxzDN7P+3/lMJnIo4znlTu34bfQezercoZJ1LZqHntFDZqGuWKvU1GB
ya8lxynGci4JPTkDgF1qKY7aL+AJ8A6Xjt49eSGOKE/fxn3ymoh4L+vZGcs8t2U+
lh7GVPRTYC7QWgd4YfjxR8oGyoL/ZqGbq2gUc5q09e93wYx1/BJdg6epVjqaFEaP
o+OJkp8e/Q0bkbpCAbjki91fmhowew==
=LF6m
-----END PGP SIGNATURE-----

--LmxAkj9vo4LkWJ5HHCN5kC5ItvnVDVOuW--
