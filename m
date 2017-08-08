Received: from eggs.gnu.org ([2001:4830:134:3::10]:56151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfAH7-0000aL-QT
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 15:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfAH3-00075s-T5
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 15:34:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dfAH3-00075H-JM
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 15:34:41 -0400
References: <150221331695.15915.4904484630739512874.stgit@bahia.lan>
	<9e56de2e-2c20-6e28-efd0-1f78b21a7be5@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9f3c0af6-1ff8-adca-9f69-2be8dd7d250f@redhat.com>
Date: Tue, 8 Aug 2017 14:34:36 -0500
MIME-Version: 1.0
In-Reply-To: <9e56de2e-2c20-6e28-efd0-1f78b21a7be5@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XjJRbB0EkDI1PahoQBifX7LCBThUeoBmH"
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: zhiyong.wu@ucloud.cn, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XjJRbB0EkDI1PahoQBifX7LCBThUeoBmH
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: zhiyong.wu@ucloud.cn, qemu-devel@nongnu.org
Message-ID: <9f3c0af6-1ff8-adca-9f69-2be8dd7d250f@redhat.com>
Subject: Re: [Qemu-devel] [for-2.10 PATCH] 9pfs: local: fix
 fchmodat_nofollow() limitations
References: <150221331695.15915.4904484630739512874.stgit@bahia.lan>
 <9e56de2e-2c20-6e28-efd0-1f78b21a7be5@amsat.org>
In-Reply-To: <9e56de2e-2c20-6e28-efd0-1f78b21a7be5@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/08/2017 01:48 PM, Philippe Mathieu-Daud=C3=A9 wrote:

>> +    fd =3D openat_file(dirfd, name, O_RDONLY | O_PATH, 0);
>=20
> since you use O_PATH, you can drop O_RDONLY.

Technically, POSIX says (and 'man 2 open' agrees, modulo the fact that
Linux still lacks O_SEARCH) that you MUST provide one of the 5 access
modes (they are O_RDONLY, O_RDWR, O_WRONLY, O_EXEC, and O_SEARCH;
although POSIX allows O_EXEC and O_SEARCH to be the same bit pattern),
and then bitwise-or any additional flags.  So the usage here is correct.

Practically, though, this code is ONLY compilable on Linux (no one else
has O_PATH yet, although it is a useful Linux invention), and on Linux,
O_RDONLY is 0.  So behaviorally, you are correct that open(O_PATH)
rather than open(O_RDONLY | O_PATH) does the same thing, even if it sets
a bad example. [Well, insofar as you don't have any other bugs by
omitting O_NOFOLLOW, per my other thread...]

>> +++ b/hw/9pfs/9p-util.h
>> @@ -43,9 +43,13 @@ static inline int openat_file(int dirfd, const char=

>> *name, int flags,
>>       }
>>         serrno =3D errno;
>> -    /* O_NONBLOCK was only needed to open the file. Let's drop it. */=

>> -    ret =3D fcntl(fd, F_SETFL, flags);
>> -    assert(!ret);
>> +    /* O_NONBLOCK was only needed to open the file. Let's drop it. We=

>> don't
>> +     * do that with O_PATH since it ignores O_NONBLOCK.
>> +     */
>=20
> thinking about if someone uses openat_file(d, O_PATH|O_CLOEXEC, ...),
> why not set the fd flags always? like:
>=20
>        ret =3D fcntl(fd, F_SETFL, flags);
>        assert((flags & O_PATH) || !ret);

Syscalls are expensive.  It's better to avoid fcntl() up front than it
is to skip failure after the fact.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XjJRbB0EkDI1PahoQBifX7LCBThUeoBmH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmKEkwACgkQp6FrSiUn
Q2oLJggApErIGHEJtdi1es0pYIFYK4hGCbACzkFJLOOVcDkqW7OVjMQjXMcHYwD/
P+XIe+T5fbqPceWC/fw6jjemOSvDkTzvszFVYnzF5rTGZMy3eXIirPZxiaH2JQAk
gebQ1fyhEcLMBPKl80kLkCtHV1ib+HzAmI42itdsqoTiPfoBX3bYfFXLFPyoTSAS
spSEQGcCD0KBFyQ0nsRn+yTJqVAWYKPwTnhEC4uPrqbSXgaoQdUKzXGSv/2XEvVY
NVw3B8G0UIkZsU+vx9RB1EZN4wrhE0eFPQiaug1fW6WSKpmGyLwsEMhd21CKXizF
tefVRwxC0NHI8Lrgo51Ccr5aghr5WQ==
=l1G8
-----END PGP SIGNATURE-----

--XjJRbB0EkDI1PahoQBifX7LCBThUeoBmH--
