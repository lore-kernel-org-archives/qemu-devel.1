Received: from eggs.gnu.org ([2001:4830:134:3::10]:38656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cOCc6-0005bS-T7
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 19:06:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cOCby-00038N-5v
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 19:05:58 -0500
Date: Tue, 3 Jan 2017 10:53:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170102235333.GJ12761@umbus.fritz.box>
References: <1482166064-18121-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1482166064-18121-2-git-send-email-joserz@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DesjdUuHQDwS2t4N"
Content-Disposition: inline
In-Reply-To: <1482166064-18121-2-git-send-email-joserz@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/6] target-ppc: Implement unsigned
 quadword left/right shift and unit tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, nikunj@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com


--DesjdUuHQDwS2t4N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 19, 2016 at 02:47:39PM -0200, Jose Ricardo Ziviani wrote:
> This commit implements functions to right and left shifts and the
> unittest for them. Such functions is needed due to instructions
> that requires them.
>=20
> Today, there is already a right shift implementation in int128.h
> but it's designed for signed numbers.

The subject line is misleading, since this isn't actually local to
target-ppc.  I'd want an ack from Paolo or Eric Blake before taking
this change to host-utils through my tree.

>=20
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> ---
>  include/qemu/host-utils.h |  3 ++
>  tests/Makefile.include    |  5 ++-
>  tests/test-shift128.c     | 98 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  util/Makefile.objs        |  2 +-
>  util/host-utils.c         | 44 +++++++++++++++++++++
>  5 files changed, 150 insertions(+), 2 deletions(-)
>  create mode 100644 tests/test-shift128.c
>=20
> diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
> index 46187bb..e87de19 100644
> --- a/include/qemu/host-utils.h
> +++ b/include/qemu/host-utils.h
> @@ -516,4 +516,7 @@ static inline uint64_t pow2ceil(uint64_t value)
>      return 1ULL << (64 - nlz);
>  }
> =20
> +void urshift(uint64_t *plow, uint64_t *phigh, uint32_t shift);
> +void ulshift(uint64_t *plow, uint64_t *phigh, uint32_t shift, bool *over=
flow);
> +
>  #endif
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index b574964..8ccaa3e 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -65,6 +65,8 @@ check-unit-$(CONFIG_POSIX) +=3D tests/test-vmstate$(EXE=
SUF)
>  endif
>  check-unit-y +=3D tests/test-cutils$(EXESUF)
>  gcov-files-test-cutils-y +=3D util/cutils.c
> +check-unit-y +=3D tests/test-shift128$(EXESUF)
> +gcov-files-test-shift128-y =3D util/host-utils.c
>  check-unit-y +=3D tests/test-mul64$(EXESUF)
>  gcov-files-test-mul64-y =3D util/host-utils.c
>  check-unit-y +=3D tests/test-int128$(EXESUF)
> @@ -464,7 +466,7 @@ test-obj-y =3D tests/check-qint.o tests/check-qstring=
=2Eo tests/check-qdict.o \
>  	tests/test-x86-cpuid.o tests/test-mul64.o tests/test-int128.o \
>  	tests/test-opts-visitor.o tests/test-qmp-event.o \
>  	tests/rcutorture.o tests/test-rcu-list.o \
> -	tests/test-qdist.o \
> +	tests/test-qdist.o tests/test-shift128.o \
>  	tests/test-qht.o tests/qht-bench.o tests/test-qht-par.o \
>  	tests/atomic_add-bench.o
> =20
> @@ -572,6 +574,7 @@ tests/test-qmp-commands$(EXESUF): tests/test-qmp-comm=
ands.o tests/test-qmp-marsh
>  tests/test-visitor-serialization$(EXESUF): tests/test-visitor-serializat=
ion.o $(test-qapi-obj-y)
>  tests/test-opts-visitor$(EXESUF): tests/test-opts-visitor.o $(test-qapi-=
obj-y)
> =20
> +tests/test-shift128$(EXESUF): tests/test-shift128.o $(test-util-obj-y)
>  tests/test-mul64$(EXESUF): tests/test-mul64.o $(test-util-obj-y)
>  tests/test-bitops$(EXESUF): tests/test-bitops.o $(test-util-obj-y)
>  tests/test-crypto-hash$(EXESUF): tests/test-crypto-hash.o $(test-crypto-=
obj-y)
> diff --git a/tests/test-shift128.c b/tests/test-shift128.c
> new file mode 100644
> index 0000000..52be6a2
> --- /dev/null
> +++ b/tests/test-shift128.c
> @@ -0,0 +1,98 @@
> +/*
> + * Test unsigned left and right shift
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2 or l=
ater.
> + * See the COPYING.LIB file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/host-utils.h"
> +
> +typedef struct {
> +    uint64_t low;
> +    uint64_t high;
> +    uint64_t rlow;
> +    uint64_t rhigh;
> +    int32_t shift;
> +    bool overflow;
> +} test_data;
> +
> +static const test_data test_ltable[] =3D {
> +    { 1223ULL, 0, 1223ULL,   0, 0, false },
> +    { 1ULL,    0, 2ULL,   0, 1, false }
> +    { 1ULL,    0, 4ULL,   0, 2, false },
> +    { 1ULL,    0, 16ULL,  0, 4, false },
> +    { 1ULL,    0, 256ULL, 0, 8, false },
> +    { 1ULL,    0, 65536ULL, 0, 16, false },
> +    { 1ULL,    0, 2147483648ULL, 0, 31, false },
> +    { 1ULL,    0, 35184372088832ULL, 0, 45, false },
> +    { 1ULL,    0, 1152921504606846976ULL, 0, 60, false },

These test cases would be much easier to follow in hex
,
> +    { 1ULL,    0, 0, 1ULL, 64, false },
> +    { 1ULL,    0, 0, 65536ULL, 80, false },
> +    { 1ULL,    0, 0, 9223372036854775808ULL, 127, false },
> +    { 0ULL,    1, 0, 0, 64, true },
> +    { 0x8888888888888888ULL, 0x9999999999999999ULL,
> +        0x8000000000000000ULL, 0x9888888888888888ULL, 60, true },
> +    { 0x8888888888888888ULL, 0x9999999999999999ULL,
> +        0, 0x8888888888888888ULL, 64, true },
> +    { 0x8ULL, 0, 0, 0x8ULL, 64, false },
> +    { 0x8ULL, 0, 0, 0x8000000000000000ULL, 124, false },
> +    { 0x1ULL, 0, 0, 0x4000000000000000ULL, 126, false },
> +    { 0x1ULL, 0, 0, 0x8000000000000000ULL, 127, false },
> +    { 0x1ULL, 0, 0x1ULL, 0, 128, true },
> +    { 0, 0, 0ULL, 0, 200, false },
> +};
> +
> +static const test_data test_rtable[] =3D {
> +    { 1223ULL, 0, 1223ULL,   0, 0, false },
> +    { 9223372036854775808ULL, 9223372036854775808ULL,
> +        2147483648L, 2147483648ULL, 32, false },
> +    { 9223372036854775808ULL, 9223372036854775808ULL,
> +        9223372036854775808ULL, 0, 64, false },
> +    { 9223372036854775808ULL, 9223372036854775808ULL,
> +        36028797018963968ULL, 0, 72, false },
> +    { 9223372036854775808ULL, 9223372036854775808ULL,
> +        1ULL, 0, 127, false },
> +    { 9223372036854775808ULL, 0, 4611686018427387904ULL, 0, 1, false },
> +    { 9223372036854775808ULL, 0, 2305843009213693952ULL, 0, 2, false },
> +    { 9223372036854775808ULL, 0, 36028797018963968ULL, 0, 8, false },
> +    { 9223372036854775808ULL, 0, 140737488355328ULL, 0, 16, false },
> +    { 9223372036854775808ULL, 0, 2147483648ULL, 0, 32, false },
> +    { 9223372036854775808ULL, 0, 1ULL, 0, 63, false },
> +    { 9223372036854775808ULL, 0, 0ULL, 0, 64, false },
> +};
> +
> +static void test_lshift(void)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(test_ltable); ++i) {
> +        bool overflow =3D false;
> +        test_data tmp =3D test_ltable[i];
> +        ulshift(&tmp.low, &tmp.high, tmp.shift, &overflow);
> +        g_assert_cmpuint(tmp.low, =3D=3D, tmp.rlow);
> +        g_assert_cmpuint(tmp.high, =3D=3D, tmp.rhigh);
> +        g_assert_cmpuint(tmp.overflow, =3D=3D, overflow);
> +    }
> +}
> +
> +static void test_rshift(void)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(test_rtable); ++i) {
> +        test_data tmp =3D test_rtable[i];
> +        urshift(&tmp.low, &tmp.high, tmp.shift);
> +        g_assert_cmpuint(tmp.low, =3D=3D, tmp.rlow);
> +        g_assert_cmpuint(tmp.high, =3D=3D, tmp.rhigh);
> +    }
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +    g_test_add_func("/host-utils/test_lshift", test_lshift);
> +    g_test_add_func("/host-utils/test_rshift", test_rshift);
> +    return g_test_run();
> +}
> diff --git a/util/Makefile.objs b/util/Makefile.objs
> index ad0f9c7..39ae26e 100644
> --- a/util/Makefile.objs
> +++ b/util/Makefile.objs
> @@ -11,7 +11,7 @@ util-obj-$(CONFIG_POSIX) +=3D memfd.o
>  util-obj-$(CONFIG_WIN32) +=3D oslib-win32.o
>  util-obj-$(CONFIG_WIN32) +=3D qemu-thread-win32.o
>  util-obj-y +=3D envlist.o path.o module.o
> -util-obj-$(call lnot,$(CONFIG_INT128)) +=3D host-utils.o
> +util-obj-y +=3D host-utils.o
>  util-obj-y +=3D bitmap.o bitops.o hbitmap.o
>  util-obj-y +=3D fifo8.o
>  util-obj-y +=3D acl.o
> diff --git a/util/host-utils.c b/util/host-utils.c
> index b166e57..1ee2433 100644
> --- a/util/host-utils.c
> +++ b/util/host-utils.c
> @@ -26,6 +26,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/host-utils.h"
> =20
> +#ifndef CONFIG_INT128
>  /* Long integer helpers */
>  static inline void mul64(uint64_t *plow, uint64_t *phigh,
>                           uint64_t a, uint64_t b)
> @@ -158,4 +159,47 @@ int divs128(int64_t *plow, int64_t *phigh, int64_t d=
ivisor)
> =20
>      return overflow;
>  }
> +#endif
> =20
> +void urshift(uint64_t *plow, uint64_t *phigh, uint32_t shift)
> +{
> +    shift &=3D 127;
> +    uint64_t h =3D *phigh >> (shift & 63);
> +    if (shift =3D=3D 0) {
> +        return;
> +    } else if (shift >=3D 64) {
> +        *plow =3D h;
> +        *phigh =3D 0;
> +    } else {
> +        *plow =3D (*plow >> (shift & 63)) | (*phigh << (64 - (shift & 63=
)));
> +        *phigh =3D h;
> +    }
> +}
> +
> +void ulshift(uint64_t *plow, uint64_t *phigh, uint32_t shift, bool *over=
flow)
> +{
> +    uint64_t low =3D *plow;
> +    uint64_t high =3D *phigh;
> +
> +    if (shift > 127 && (low | high)) {
> +        *overflow =3D true;
> +    }
> +    shift &=3D 127;
> +
> +    if (shift =3D=3D 0) {
> +        return;
> +    }
> +
> +    urshift(&low, &high, 128 - shift);
> +    if (low > 0 || high > 0) {
> +        *overflow =3D true;
> +    }
> +
> +    if (shift >=3D 64) {
> +        *phigh =3D *plow << (shift & 63);
> +        *plow =3D 0;
> +    } else {
> +        *phigh =3D (*plow >> (64 - (shift & 63))) | (*phigh << (shift & =
63));
> +        *plow =3D *plow << shift;
> +    }
> +}

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DesjdUuHQDwS2t4N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYauf7AAoJEGw4ysog2bOS/+MP/iHwXPTOqETVY336ca+Ccn3j
CKU/He6p4VB0ZGBFjB4LSx7RKwq3llXKO13L6QKfPW+cpuN4SwD5JgtHxMR0qfXl
4XoI932KrzNw+MHGCAUg8xGwXT7LFHSuXuJt4ymgjwnqegEbYdtploW0SLSit5oz
Xy4GJObg0lQ0iTdTFeCcUGbCv5TPilZ2gWYud2BOwVWQbRvf0Acam5yFb8dT7NM0
0CGbI/39cFn+6qP7Vg39trpHfXjfYKMpg71q1ifckbHqH1/J5W7wgnWHhCKrBm8d
/wO6yZIr/RXXoGLdQbwN8TVmAfi0v+BANPrnXbzfrABt+C4q15v2p3osgeD0tkDe
XKLSPzq24osb9/GkyLbnhEt72EIIDheWXt1lTyUqTAmQnYP6R/XNwQVgE3cmZdmF
4nx1zruGqRhPYv3oPG3t3aQkXSx0URBzJWXOZqdxMfYh4G9vgBdwPM5LGl3trtwH
RZ55fmLxSwuGDcYy9ISxztDpHtAmXv8e1AM9CexydEH6eQgfr+iPT53voo7Ts6rW
1nNEP8kFhacjwQ1k6yhVX7yDBGFmBVC/P26RUqf6Y3t4bH1pHTu73UWRAzOqhpdh
NBSUcKUvfktVoSgsiNjWkN/VQNue3PuBFVULuEQlcb7SZ7AXD//XZZEMMhaQbhcl
ocX2y9y0bJo/01JwM+uT
=O2fE
-----END PGP SIGNATURE-----

--DesjdUuHQDwS2t4N--
