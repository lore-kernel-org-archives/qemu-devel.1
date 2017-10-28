Received: from eggs.gnu.org ([2001:4830:134:3::10]:41486)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1e8UY7-0005ZC-HR
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 13:05:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1e8UY6-0004g0-41
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 13:05:31 -0400
References: <20170903164952.26760-1-n54@gmx.com>
	<20170911171639.22005-1-n54@gmx.com>
	<CAFEAcA-wNp2T7BGih1O3-Tq1+OrYNnM1VqAneM3QfXrd5u9ZPg@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <d0aa7605-c262-273f-7fab-94e72f202aa7@gmx.com>
Date: Sat, 28 Oct 2017 19:07:46 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-wNp2T7BGih1O3-Tq1+OrYNnM1VqAneM3QfXrd5u9ZPg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kXKATRI3JJQ2qNrKdkG2iWIaJswGXAvbU"
Subject: Re: [Qemu-devel] [PATCH v2] Discover openpty(3) dynamically in
 configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Jonathan Perkin <jperkin@joyent.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Tribble <peter.tribble@gmail.com>, =?UTF-8?Q?Antonio_Huete_Jim=c3=a9nez?= <tuxillo@quantumachine.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kXKATRI3JJQ2qNrKdkG2iWIaJswGXAvbU
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Jonathan Perkin <jperkin@joyent.com>, QEMU Developers
 <qemu-devel@nongnu.org>, Peter Tribble <peter.tribble@gmail.com>,
 =?UTF-8?Q?Antonio_Huete_Jim=c3=a9nez?= <tuxillo@quantumachine.net>
Message-ID: <d0aa7605-c262-273f-7fab-94e72f202aa7@gmx.com>
Subject: Re: [Qemu-devel] [PATCH v2] Discover openpty(3) dynamically in
 configure
References: <20170903164952.26760-1-n54@gmx.com>
 <20170911171639.22005-1-n54@gmx.com>
 <CAFEAcA-wNp2T7BGih1O3-Tq1+OrYNnM1VqAneM3QfXrd5u9ZPg@mail.gmail.com>
In-Reply-To: <CAFEAcA-wNp2T7BGih1O3-Tq1+OrYNnM1VqAneM3QfXrd5u9ZPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 14.09.2017 15:52, Peter Maydell wrote:
> On 11 September 2017 at 18:16, Kamil Rytarowski <n54@gmx.com> wrote:
>> openpty(3) might:
>>  - exists in libc (OSX)
>>  - exists in libutil (GNU, BSD)
>>  - does not exist (SmartOS)
>>
>> Add a function to discover this function in the ./configure script.
>> Add new config types: CONFIG_OPENPTY_LIBC and CONFIG_OPENPTY_LIBUTIL,
>> respectively defined when openpts(3) links with -lc or -lutil.
>>
>> Replace the condition adding -lutil in tests (for openpty(3)) from
>> CONFIG_POSIX to CONFIG_OPENPTY_LIBUTIL.
>>
>> Replace the fallback openpty(3) impelementation comment from Solaris
>> to SmartOS. Solaris is EOL'ed and it's confirmed that it does not work=

>> on Oracle Solaris.
>> ---
>>  configure              | 25 +++++++++++++++++++++++++
>>  tests/Makefile.include |  2 +-
>>  util/qemu-openpty.c    |  4 ++--
>>  3 files changed, 28 insertions(+), 3 deletions(-)
>>
>> diff --git a/configure b/configure
>> index fd7e3a5e81..a614adcd29 100755
>> --- a/configure
>> +++ b/configure
>> @@ -3819,6 +3819,25 @@ EOF
>>    fi
>>  fi
>>
>> +##########################################
>> +# openpty probe
>> +openpty_libc=3Dno
>> +openpty_libutil=3Dno
>> +cat > $TMPC << EOF
>> +extern int openpty(int *amaster, int *aslave, char *name, void *termp=
, void *winp);
>=20
> I think the need to provide a prototype here rather than
> using the system header to define it is revealing that we
> also need a configure test for
>  * openpty() in <pty.h>
>  * openpty() in <libutil.h>
>  * openpty() in <util.h>
>=20
> Something like this untested code ought to do:
>=20
> cat > $TMPC << EOF
> #if defined(CONFIG_OPENPTY_IN_PTY_H)
> #include <pty.h>
> #elif defined(CONFIG_OPENPTY_IN_LIBUTIL_H)
> #include <libutil.h>
> #elif defined(CONFIG_OPENPTY_IN_UTIL_H)
> #include <util.h>
> #endif
> int main(void) { return openpty(0, 0, 0, 0, 0); }
> EOF
>=20
> # Different platforms put openpty() in different headers,
> # and may or may not need us to link against -lutil
> if compile_prog -DCONFIG_OPENPTY_IN_PTY_H ""; then
>   openpty_in_pty_h=3Dyes
> elif compile_prog -D_CONFIG_OPENPTY_IN_PTY_H -lutil; then
>   openpty_in_pty_h=3Dyes
>   openpty_libutil=3Dyes
> elif compile_object -DCONFIG_OPENPTY_IN_LIBUTIL_H; then
>   openpty_in_libutil_h=3Dyes
> elif compile_prog -D_CONFIG_OPENPTY_IN_LIBUTIL_H -lutil; then
>   openpty_in_libutil_h=3Dyes
>   openpty_libutil=3Dyes
> elif compile_object -DCONFIG_OPENPTY_IN_UTIL_H; then
>   openpty_in_util_h=3Dyes
> elif compile_prog -D_CONFIG_OPENPTY_IN_UTIL_H -lutil; then
>   openpty_in_util_h=3Dyes
>   openpty_libutil=3Dyes
> fi
>=20
> Then in qemu-openpty.c we can do
>=20
> #include <termios.h>
>=20
> #if defined(CONFIG_OPENPTY_IN_PTY_H)
> #include <pty.h>
> #elif defined(CONFIG_OPENPTY_IN_LIBUTIL_H)
> #include <libutil.h>
> #elif defined(CONFIG_OPENPTY_IN_UTIL_H)
> #include <util.h>
> #else
> /* sunos fallback code */
> #endif
>=20
>=20
>> +if test "$openpty_libc" =3D "yes" ; then
>> +  echo "CONFIG_OPENPTY_LIBC=3Dy" >> $config_host_mak
>> +fi
>=20
>=20
> If we use the CONFIG_OPENPTY_IN_*_H constants as above
> we don't need CONFIG_OPENPTY_LIBC any more.
>=20
> thanks
> -- PMM
>=20
Hello,

I've naively expected that once a build on a certain OS will be fixed,
it will be functional for longer period (at least few weeks). In one
month qemu has been broken on DragonFly and SmartOS so they are not just
broken in tests, but also in the basic build.

SmartOS has new compatibility problems with grep(1) invocations and tpm
emulator fatal build failure. Few old problems with conflicts with
system headers like conflicts with symbols CS and REG_SP.

There are certainly other small incompatibility problems, after the
breakage. Just a remind that SmartOS was not capable to execute tests
because of incompatible diff(1) invocations and unclear gmake(1)
misbehavior. And this was just the beginning of the problems.

DragonFlyBSD has problems with PAGE_SIZE, PAGE_MASK clash with headers
in s390x code. PAGE_MASK, PAGE_SHIFT and PAGE_SIZE in nand. No single
GTESTER invocation passes.

Because there is need to fix the SmartOS build in order to improve this
openpty(3) patch, I'm resigning from it. I also resign from helping
DragonFly port.

I will focus entirely on the bits that I registered as a maintainer.

I leave the decisions and steps about support of these platforms to
other volunteers and qemu core maintainers.

+ CC Antonio and Peter


--kXKATRI3JJQ2qNrKdkG2iWIaJswGXAvbU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZ9LltAAoJEEuzCOmwLnZsWKAP/iADeS1EL+mN5EuNcg3UGxop
P6qmrRBd3KGo6eo+TU2tLYkB/h07PMWTJEIsSATEmjGKYkDKHMmPNhkojXTOO3Gl
xf1eSuUlCV9DbVgHB0D2HlQ/CIn1vuzX8soF3iE0+kPOx3dVb8JIAu2Qw7TvjCZy
D3y0hFi5pY7ZR+xlfpepBcwxUGspWsvZjKvMFHu7Qk3XBAi6PMf6tGU3uA7HJnud
1jH3/r1tQq2lld+0L7/l2pJ8/8/95ExuKFeon0nq51OpGt7sqz4k5qAPz31nHiVD
NbuA523YEdd1BnxiBgOL2gDiTX0SYHPIXRwbaws+y2qWV3uN5r8oL8frKhrvf4G/
tdweq0Z9+TsfGMz9C9zANCSDGsVOT1x7a7J6JqwgiDYi7f3YMNMFbMtVPvQSTPJU
PFga/6VgKyIAgaO/BMTacTfSqmwakvLR/ZlXVZHvSDmtoRxs8J+I7NM39cJWNVN7
0PtKTs6hNwvt3B9YqrLsa5ruriHGY8tODDe5Z0OMQ6H6WfwMUodlfR7/hFQsdQyr
kQzmTCwTV5Mwgih/sgl8bEKHpWBxOT9YFd62SbL8TRehZh2+YHDohqmKQB7TaWTF
bdDbizg3FOmBVdeyLZnqOAHEJt7x39nQRtKC5w57qaWKNJ8yJ//xpa3+75croxGr
2muIzwFy3kt31LmMm71+
=miJb
-----END PGP SIGNATURE-----

--kXKATRI3JJQ2qNrKdkG2iWIaJswGXAvbU--
