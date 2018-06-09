Received: from eggs.gnu.org ([2001:4830:134:3::10]:54177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fRloz-0004OX-0x
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 17:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fRloy-00040f-1Z
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 17:54:53 -0400
References: <20180606193702.7113-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fa3f17fd-5fe9-8471-b033-8192fe6224e8@redhat.com>
Date: Sat, 9 Jun 2018 23:54:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180606193702.7113-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KBzMDd1M391TMWmNayrkAa3WDVQQd82Rr"
Subject: Re: [Qemu-devel] [PATCH v2 0/3] qcow2: Do not mark inactive images
 corrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KBzMDd1M391TMWmNayrkAa3WDVQQd82Rr
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <fa3f17fd-5fe9-8471-b033-8192fe6224e8@redhat.com>
Subject: Re: [PATCH v2 0/3] qcow2: Do not mark inactive images corrupt
References: <20180606193702.7113-1-mreitz@redhat.com>
In-Reply-To: <20180606193702.7113-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-06 21:36, Max Reitz wrote:
> The non-public logs in
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1583346 (sorry...) reveal=

> this problem:
>=20
> $ (Create a qcow2 file "foo.qcow2" with a corrupted first L1 entry)
> $ echo 'qemu-io none0 "read 0 512"' \
>     | x86_64-softmmu/qemu-system-x86_64 -drive if=3Dnone,file=3Dfoo.qco=
w2 \
>                                         -monitor stdio \
>                                         -incoming exec:'cat /dev/null'
> QEMU 2.12.50 monitor - type 'help' for more information
> (qemu) qemu-io none0 "read 0 512"
> qcow2: Marking image as corrupt: L2 table offset 0x44200 unaligned (L1 =
index: 0); further corruption events will be suppressed
> qemu-system-x86_64: block/io.c:1691: bdrv_co_pwritev: Assertion `!(bs->=
open_flags & BDRV_O_INACTIVE)' failed.
> [1]    18444 done                 echo 'qemu-io none0 "read 0 512"' |
>        18445 abort (core dumped)  x86_64-softmmu/qemu-system-x86_64 -dr=
ive if=3Dnone,file=3Dfoo.qcow2 -monitor stdi
>=20
> Oops.
>=20
>=20
> The first patch in this series makes a function public that the second
> patch uses to fix the issue by treating all non-writable images like
> read-only images (yes, there is a difference...) in this regard (which
> most importantly means not trying to set the corrupt flag on them).
> Inactive images count as non-writable images, but not as read-only
> images, so that fixes it.
>=20
> The third patch adds an iotest case.

Thanks for the reviews, applied to my block branch.

Max


--KBzMDd1M391TMWmNayrkAa3WDVQQd82Rr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlscTKEACgkQ9AfbAGHV
z0Bx8gf+JI+4PFqoxiZFFVZQvRqMAmUUYG0F+X6PBNtF9ftjqm9zDu5VGMhzlVHv
2xwXhfgFb5QrBYVFt/Ybri3QOUr0GdU0lRViNVPmzVHgMGQqgmzC0z0+2kEAVT2K
WlUk+korPegA6xzsqeRuSugnmb/tMjtuxdQbyELKjIZrPYC6Fji6Gfgp/IGBj451
Pele7aF4Gw3b0oe+wbuP0qVN8qK+Xvmy1f8WPRHJRAfEsZk8VwpyBORR82IfVAfs
/sZhCpBWGzGg4vkPc3HHYvMRiarC/IgczrU5MZS8IFRKYp3Za1SvUpDocyKbcXwx
/Jh8ByKRg8n0WY5/IhkvappVsLK4BA==
=29hY
-----END PGP SIGNATURE-----

--KBzMDd1M391TMWmNayrkAa3WDVQQd82Rr--
