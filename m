Received: from eggs.gnu.org ([2001:4830:134:3::10]:40862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e22Ix-0008Jl-HR
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 17:43:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e22Iw-0004zF-Lw
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 17:43:11 -0400
References: <20171010134205.6120-1-vsementsov@virtuozzo.com>
	<00ece7c6-3c55-f84b-adcf-27869a596eb5@redhat.com>
	<19ae13ac-92f1-04e0-ad7a-6e0e0d152b9f@openvz.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <61ec4431-25a1-a834-515d-2629a7c70f19@redhat.com>
Date: Tue, 10 Oct 2017 16:42:58 -0500
MIME-Version: 1.0
In-Reply-To: <19ae13ac-92f1-04e0-ad7a-6e0e0d152b9f@openvz.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5m0Uob3tkIcb0qCwNNIufWDbTVpm6eKgb"
Subject: Re: [Qemu-devel] [PATCH RFC] file-posix: make lock_fd read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5m0Uob3tkIcb0qCwNNIufWDbTVpm6eKgb
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, berrange@redhat.com
Message-ID: <61ec4431-25a1-a834-515d-2629a7c70f19@redhat.com>
Subject: Re: [PATCH RFC] file-posix: make lock_fd read-only
References: <20171010134205.6120-1-vsementsov@virtuozzo.com>
 <00ece7c6-3c55-f84b-adcf-27869a596eb5@redhat.com>
 <19ae13ac-92f1-04e0-ad7a-6e0e0d152b9f@openvz.org>
In-Reply-To: <19ae13ac-92f1-04e0-ad7a-6e0e0d152b9f@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/10/2017 02:30 PM, Denis V. Lunev wrote:
> On 10/10/2017 09:50 PM, Eric Blake wrote:
>> On 10/10/2017 08:42 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> We do not reopen lock_fd on bdrv_reopen which leads to problems on
>>> reopen image RO. So, lets make lock_fd be always RO.
>>> This is correct, because qemu_lock_fd always called with exclusive=3D=
false
>>> on lock_fd.
>> How is that correct?  file-posix.c calls:
>>             ret =3D qemu_lock_fd_test(s->lock_fd, off, 1, true);
>> where exclusive being true in turn sets:
>>         .l_type   =3D exclusive ? F_WRLCK : F_RDLCK,
>>
>> and F_WRLCK requests fail on a RO fd with EBADF.
> this works fine for us as here we do not get the lock but just
> query it.
>=20

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ftruncate(fd, 1024);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fcntl(fd, F_SETLK, &fl_rd);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fcntl(fd, F_GETLK, &fl_wr);

Trying with F_OFD_SETLK (which is more important, because it matches
what we prefer to use) gives the same results as your strace (remember
to #define _GNU_SOURCE 1 before compilation, to get F_OFD_SETLK into scop=
e).

>=20
> The key is that in test cod we do not _set_ the lock, but query it! Thi=
s
> is allowed even on
> RDONLY file descriptor.

Hmm, you're right: file-posix only uses qemu_lock_fd() to set locks
(with exclusive =3D=3D false), and qemu_lock_fd_test() to query locks
(there, exclusive =3D=3D true means to probe if a write lock can be grabb=
ed,
but does not actually grab one so it doesn't care whether the fd is RW.
We ).

We'd need a lot more explanation in the commit message (for example, you
still haven't stated an actual backtrace or error message you got when
the lock file is left RW), but you may have just convinced me that the
conversion to always use a RO lock fd is correct, at least for
file-posix' use of fcntl locking.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--5m0Uob3tkIcb0qCwNNIufWDbTVpm6eKgb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlndPuIACgkQp6FrSiUn
Q2qLcQf8CucHNRfBQRtsL3vSnYEJ7Donigppcu2b5qBqVMNfG+glkddHgSybBaAD
guYFkrPk0F4WX75q7vL6E1DRkRlAFWC3Lcnt1U8hKLd7tGAIpFKI2R0hE6pGTVBg
d0y8ioY4t03lkg/sncRu4rRjJ5dvpzZRovghYh6hk2W3YwBfRn9p7CvEV9fRvzFt
9AjAkaQhxb7HCxEH7axfzj6G37HbmOoZsXO1+Up14ZQYh5MBaXl/gNJuSyZNsUv6
R6KX/po5f8qZU2PZoE+av3HWrkpmfsUWJSE56T23Te1wgqurS9yrbtWxJTybX1xi
xWzjp5zYvgfAo7Rc2HkYM7Kj+FcRhQ==
=CNQB
-----END PGP SIGNATURE-----

--5m0Uob3tkIcb0qCwNNIufWDbTVpm6eKgb--
