Received: from eggs.gnu.org ([2001:4830:134:3::10]:47172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTpt9-00084R-5S
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:02:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTpt8-00086y-0b
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:02:55 -0500
References: <1477928314-11184-1-git-send-email-famz@redhat.com>
	<1477928314-11184-14-git-send-email-famz@redhat.com>
	<2acb8480-8e7d-1d47-4f8b-0d9b68c37884@redhat.com>
	<20170118104825.GF6199@lemon>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <611793e4-fc6d-1ccf-0e15-e52a56a224f5@redhat.com>
Date: Wed, 18 Jan 2017 14:02:41 +0100
MIME-Version: 1.0
In-Reply-To: <20170118104825.GF6199@lemon>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ei3KTgFrBNE04wBELfmgQrgEKbFqSOtpn"
Subject: Re: [Qemu-devel] [PATCH 13/14] raw-posix: Implement image locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, rjones@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ei3KTgFrBNE04wBELfmgQrgEKbFqSOtpn
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, rjones@redhat.com
Message-ID: <611793e4-fc6d-1ccf-0e15-e52a56a224f5@redhat.com>
Subject: Re: [PATCH 13/14] raw-posix: Implement image locking
References: <1477928314-11184-1-git-send-email-famz@redhat.com>
 <1477928314-11184-14-git-send-email-famz@redhat.com>
 <2acb8480-8e7d-1d47-4f8b-0d9b68c37884@redhat.com>
 <20170118104825.GF6199@lemon>
In-Reply-To: <20170118104825.GF6199@lemon>
Content-Type: multipart/mixed;
 boundary="------------BC8E1EEDADED8279AEDC70C1"

--------------BC8E1EEDADED8279AEDC70C1
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 18.01.2017 11:48, Fam Zheng wrote:
> On Fri, 12/02 03:58, Max Reitz wrote:
>> On 31.10.2016 16:38, Fam Zheng wrote:
>>> This implements open flag sensible image locking for local file
>>> and host device protocol.
>>>
>>> virtlockd in libvirt locks the first byte, so we start looking at the=

>>> file bytes from 1.
>>>
>>> Quoting what was proposed by Kevin Wolf <kwolf@redhat.com>, there are=

>>> four locking modes by combining two bits (BDRV_O_RDWR and
>>> BDRV_O_SHARE_RW), and implemented by taking two locks:
>>>
>>> Lock bytes:
>>>
>>> * byte 1: I can't allow other processes to write to the image
>>> * byte 2: I am writing to the image
>>>
>>> Lock modes:
>>>
>>> * shared writer (BDRV_O_RDWR | BDRV_O_SHARE_RW): Take shared lock on
>>>   byte 2. Test whether byte 1 is locked using an exclusive lock, and
>>>   fail if so.
>>
>> Testing whether something is locked would be easier by using F_OFD_GET=
LK
>> instead of actually creating an exclusive lock and then releasing it.
>=20
> My attempt to do this shows it doesn't work: fcntl forces the tested lo=
ck type
> to read lock for some unknown reason, so it cannot be used to test othe=
r shared
> lockers.

Do you have a reproducer? The attached quick and dirty test case works
for me (compile test.c to test and test2.c to test2), producing the
following output (when running ./test):

set rd lock: 0, Success
get lock: 0, Success; read lock in place
set wr lock: -1, Resource temporarily unavailable
unset lock: 0, Resource temporarily unavailable
=3D=3D=3D
unset lock: 0, Success
get lock: 0, Success; unlocked
set wr lock: 0, Success
unset lock: 0, Success
=3D=3D=3D
set wr lock: 0, Success
get lock: 0, Success; write lock in place
set wr lock: -1, Resource temporarily unavailable
unset lock: 0, Resource temporarily unavailable

So the l_type field is correctly set after every F_OFD_GETLK query call.

Max

--------------BC8E1EEDADED8279AEDC70C1
Content-Type: text/x-csrc;
 name="test.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="test.c"

#define _GNU_SOURCE

#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>


int main(void)
{
    system("touch foo");


    int fd =3D open("foo", O_RDWR);

    int ret =3D fcntl(fd, F_OFD_SETLK, &(struct flock){ .l_type =3D F_RDL=
CK });
    printf("set rd lock: %i, %s\n", ret, strerror(errno));

    system("./test2");

    printf("=3D=3D=3D\n");

    ret =3D fcntl(fd, F_OFD_SETLK, &(struct flock){ .l_type =3D F_UNLCK }=
);
    printf("unset lock: %i, %s\n", ret, strerror(errno));

    system("./test2");

    printf("=3D=3D=3D\n");

    ret =3D fcntl(fd, F_OFD_SETLK, &(struct flock){ .l_type =3D F_WRLCK }=
);
    printf("set wr lock: %i, %s\n", ret, strerror(errno));

    system("./test2");

    close(fd);
    return 0;
}

--------------BC8E1EEDADED8279AEDC70C1
Content-Type: text/x-csrc;
 name="test2.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="test2.c"

#define _GNU_SOURCE

#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>


static const char *lock_names[] =3D {
    [F_UNLCK] =3D "unlocked",
    [F_RDLCK] =3D "read lock in place",
    [F_WRLCK] =3D "write lock in place",
};


int main(void)
{
    int fd =3D open("foo", O_RDWR);

    struct flock fl =3D { .l_type =3D F_WRLCK };
    int ret =3D fcntl(fd, F_OFD_GETLK, &fl);
    printf("get lock: %i, %s; %s\n", ret, strerror(errno), lock_names[fl.=
l_type]);

    ret =3D fcntl(fd, F_OFD_SETLK, &(struct flock){ .l_type =3D F_WRLCK }=
);
    printf("set wr lock: %i, %s\n", ret, strerror(errno));

    close(fd);
    return 0;
}

--------------BC8E1EEDADED8279AEDC70C1--

--Ei3KTgFrBNE04wBELfmgQrgEKbFqSOtpn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlh/Z3ESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A7FoIAKQeln/saQ2H2DkL6ms/fXtMPZo0uw8o
uksDJqhoIJwgDyGjNUMhU22BK/RRfQCKrFVDhyVaaJFKzBsx3KSbEqXokXxwcg0W
Uf+KnGpHLA+LDWrwnvccf6tef3D2YrjrdVmvv07sRNbHDOmxWDFn6PO1tNwH07fL
HJPPICGo+//ZUznocbNIY1kSjuiHz0XzVRVNHfr5EjpwLSOncCXBJUy0wNo6eea5
S/MACACe3Clxi7vJQ8wLjh7v+l6oHvlNtwbhI8VGE7ByKLAkueQItw8AIaAU86JB
GU9AMwkfFv93nmL1clpGOPMFVMe0iIlk7MV7GR3xazerhssNagZqRBk=
=xrga
-----END PGP SIGNATURE-----

--Ei3KTgFrBNE04wBELfmgQrgEKbFqSOtpn--
