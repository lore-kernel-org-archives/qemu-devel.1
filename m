Received: from eggs.gnu.org ([2001:4830:134:3::10]:40135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duKzd-0000K5-Dw
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:03:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duKzZ-0007KW-DU
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:03:25 -0400
References: <a6ad8398-fcef-2d7f-548a-024c54ad2379@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1b770acc-8020-71dd-acc5-c87148a7c673@redhat.com>
Date: Tue, 19 Sep 2017 11:03:08 -0500
MIME-Version: 1.0
In-Reply-To: <a6ad8398-fcef-2d7f-548a-024c54ad2379@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vPsuJdGFGBlnDPgM0jkID1jsrAExJdL2F"
Subject: Re: [Qemu-devel] [Qemu-block] image locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vPsuJdGFGBlnDPgM0jkID1jsrAExJdL2F
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Fam Zheng <famz@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>
Message-ID: <1b770acc-8020-71dd-acc5-c87148a7c673@redhat.com>
Subject: Re: [Qemu-block] image locking
References: <a6ad8398-fcef-2d7f-548a-024c54ad2379@virtuozzo.com>
In-Reply-To: <a6ad8398-fcef-2d7f-548a-024c54ad2379@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/19/2017 10:46 AM, Vladimir Sementsov-Ogievskiy wrote:
> Hi Fam!
>=20
> I have a question about your image locking series:
>=20
> Can you please explain, why OFD locking is enabled by default and posix=

> locking is not? What is wrong with posix locking, what are the problems=
?

POSIX locking (lockf(3), which wraps fcntl(2)) has a severe flaw,
mandated by POSIX due to historical behavior, regarding the duration of
the lock - within a single process, ALL lock access to the same inode,
regardless of which fd triggered the access, is tied together:

int fd1 =3D open("/dev/null", O_RDONLY);
int fd2 =3D open("/dev/null", O_RDONLY);
fcntl(F_SETLK, fd1, ...); // Obtain lock
close(fd2); // oops, lock on fd1 is lost!

BSD locks (flock(2)) do not have this issue, but have a different flaw -
they can only lock the entire file at once.  But we need fine-grained
access (we lock different byte ranges in order to convey multiple pieces
of information across processes).

Hence, Linux invented OFD locking as the best of both worlds (the locks
are tied to the inode rather than the process, but allow fine-grained
access), and it is likely that POSIX will eventually standardize it
(http://austingroupbugs.net/view.php?id=3D768).

More from the Linux 'man fcntl' page:

>        The  record  locks  described  above  are  associated  with the =
process
>        (unlike the open file description locks  described  below).   Th=
is  has
>        some unfortunate consequences:
>=20
>        *  If  a  process  closes any file descriptor referring to a fil=
e, then
>           all of the process's locks on that file are released, regardl=
ess  of
>           the  file  descriptor(s)  on which the locks were obtained.  =
This is
>           bad: it means that a process can lose its locks on a  file  s=
uch  as
>           /etc/passwd  or  /etc/mtab  when  for some reason a library f=
unction
>           decides to open, read, and close the same file.
>=20
>        *  The threads in a process share locks.   In  other  words,  a =
 multi=E2=80=90
>           threaded  program  can't  use  record locking to ensure that =
threads
>           don't simultaneously access the same region of a file.
>=20
>        Open file description locks solve both of these problems.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vPsuJdGFGBlnDPgM0jkID1jsrAExJdL2F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnBP7wACgkQp6FrSiUn
Q2o6egf/YVzbdvdvYPaKf13LSbaAXnYVP8SAMQRn+8/KF5IB4CVu6yHOO12zGbzJ
k6cu+HZ3y0a/DtVmGyy/fES9oQUGRsQp9t1WlZbcIfe+tYtXHg2J7HqlkT0bXIcM
xmIzdGzVYCjh1bn1yS9f8/oPK/6ysTisLoZ6cfrsox7uY7IfWl99kN6BK0Fehr3d
FdmISoZNLQ1kd5+XxNbaGhwD8IIQMkqcg+U9NjL0V43CKfI2kw9qUGeU3GIq7+sv
iCPWQWCJXLKtaXnEGR8jrzD2Nld2EqSeahn6VZgCGaqjmIHlR5cFsjJ2y2/w6XX8
Y/RP/zTGLfMYN6VqbWdYKmxUmoAqSw==
=fUqA
-----END PGP SIGNATURE-----

--vPsuJdGFGBlnDPgM0jkID1jsrAExJdL2F--
