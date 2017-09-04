Received: from eggs.gnu.org ([2001:4830:134:3::10]:54520)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dp12F-0006yN-3e
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 19:44:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dp12A-00069b-Gp
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 19:44:07 -0400
References: <20170903164952.26760-1-n54@gmx.com>
	<CAFEAcA-wB8JezCNjyU92U83+75C5NccfBHe1G5q-D67H4CMTKA@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <747d805a-98ed-3d36-c4e7-5e6b21b89924@gmx.com>
Date: Tue, 5 Sep 2017 01:46:15 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-wB8JezCNjyU92U83+75C5NccfBHe1G5q-D67H4CMTKA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="t8SX5MW7MiO7GaUOwQ1f4nX2bmPd5xQ2P"
Subject: Re: [Qemu-devel] [PATCH] tests: Do not include lutil on SunOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Jonathan Perkin <jperkin@joyent.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t8SX5MW7MiO7GaUOwQ1f4nX2bmPd5xQ2P
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Jonathan Perkin <jperkin@joyent.com>
Message-ID: <747d805a-98ed-3d36-c4e7-5e6b21b89924@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] tests: Do not include lutil on SunOS
References: <20170903164952.26760-1-n54@gmx.com>
 <CAFEAcA-wB8JezCNjyU92U83+75C5NccfBHe1G5q-D67H4CMTKA@mail.gmail.com>
In-Reply-To: <CAFEAcA-wB8JezCNjyU92U83+75C5NccfBHe1G5q-D67H4CMTKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.09.2017 11:32, Peter Maydell wrote:
> On 3 September 2017 at 17:49, Kamil Rytarowski <n54@gmx.com> wrote:
>> This fixes build on SmartOS (Joyent).
>>
>> Patch cherry-picked from pkgsrc by jperkin (Joyent).
>>
>> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
>> ---
>>  tests/Makefile.include | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index f08b7418f0..0e5e6cb9b8 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -810,8 +810,10 @@ tests/migration/initrd-stress.img: tests/migratio=
n/stress$(EXESUF)
>>         rmdir $(INITRD_WORK_DIR)
>>
>>  ifeq ($(CONFIG_POSIX),y)
>> +ifneq ($(CONFIG_SOLARIS),y)
>>  LIBS +=3D -lutil
>>  endif
>> +endif
>=20
> I don't object to this patch in principle, but I don't think
> this is the best way to fix the underlying problem.
>=20
> My assumption is that the issue is that Solaris doesn't
> have a -lutil (it's helpful to quote the linker or
> compiler error message for this kind of patch to clarify
> what the failure is that we're trying to fix).
>=20

There is no libutil on SmartOS.

I cannot provide any information about the proprietary Solaris here and
in next questions.

> It looks like we use libutil here for openpty, which
> is used in the test-char test. But the condition we're
> using in tests/Makefile.include isn't the same as the
> one we used to decide whether to add -lutil to the
> emulator binary link line, which is in configure:
>=20
> if test "$darwin" !=3D "yes" -a "$mingw32" !=3D "yes" -a "$solaris" !=3D=
 yes -a \
>         "$aix" !=3D "yes" -a "$haiku" !=3D "yes" ; then
>     libs_softmmu=3D"-lutil $libs_softmmu"
> fi
>=20
> So I think I'd prefer it if we have:
>  * a configure test for "is openpty() in libutil"
>  * use that to determine whether to add -lutil to
>    libs_softmmu and to the libs for tests, rather than
>    doing OS-specific tests
>=20

This looks cleaner. I will go for it.

> Q: does Solaris still not have an openpty() implementation?
> Currently we have a local implementation in util/qemu-openpty.c,
> but if that workaround is only needed in old Solaris we don't
> support any more we could perhaps drop it.
>=20

SmartOS does not have openpty(). I don't see it either in the mainstream
Illumos-gate repository.

According to pkgsrc, openpty() is in libutil (-lutil) on all BSDs and
Darwin.

> thanks
> -- PMM
>=20



--t8SX5MW7MiO7GaUOwQ1f4nX2bmPd5xQ2P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZreXNAAoJEEuzCOmwLnZsTxYQAJtnp6SLHbuEMVqlBgNssBS9
RDsxbeGkCVzGqmk7IdizJIOGN3X+7Y9j5r2MIFfi4hu3e4D9MU1rozcr62TjcVhj
q2tyVTOnwyeJQYg9D/Rsi3dml3wq40q3f86XqzSpw7snMRW/uyxwwEHXBgozFCg+
gaQ3OSJey8MtNU1j7r9qjPeeg+/iy2AjqdEHiuHL5vS69OsTGU9ymHZC+QjEgLht
dSDhk3DssHosa1x9ySOGUl0GwdnY9hkq4SXo/rJrMSBTBvioHAocmV0bQiAwYcA0
ArQkJwHY6IWkLheBEj96hueXw2ir48mwF4owqOGmduIpQ0EFGDokhEFdDDw9cJyo
Uj+Cccqo0qgLIu7A3msFPajxqOfjLQ3c5yJU2ZZ+Tx3QfJrwS1wAoIMlxiu6KZc7
8zxVb414r7VcUVQrQx6KBX9HHUFU2JHByEHJ5GShpQ+7j5n2njyYaSaVJtvWl444
tbK9Ctlt90NZH9A1b/O/Q8ND3glOGf/ALxWQkOszYOP9VH3z/+Zze9pBGGytsiQF
bfA3jUMt1FGgujlT7biuDqn0wUKDdvdNoK2+DxC89+colGm0tiEGvFYH/x7AMFUD
WtG0FCQGfGlXsXcJMnDo75Z7Ssexn+StA/jplsKhcAfAu/ad0Y989cX1+/qnFPDG
b/zw+iwkbF+1fHpagrDN
=agIo
-----END PGP SIGNATURE-----

--t8SX5MW7MiO7GaUOwQ1f4nX2bmPd5xQ2P--
