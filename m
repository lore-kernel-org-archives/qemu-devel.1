Received: from eggs.gnu.org ([2001:4830:134:3::10]:36275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cEmWW-0002nj-5z
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 19:25:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cEmWS-0005Li-9f
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 19:25:20 -0500
Received: from 001b2d01.pphosted.com ([148.163.156.1]:56615
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cEmWS-0005LG-2N
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 19:25:16 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB80BlpA120419
	for <qemu-devel@nongnu.org>; Wed, 7 Dec 2016 19:25:14 -0500
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0a-001b2d01.pphosted.com with ESMTP id 276u96m60b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Dec 2016 19:25:14 -0500
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Wed, 7 Dec 2016 22:25:11 -0200
Date: Wed, 7 Dec 2016 22:24:58 -0200
From: joserz@linux.vnet.ibm.com
References: <1481053210-26821-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1481053210-26821-3-git-send-email-joserz@linux.vnet.ibm.com>
	<20161207054153.GD12489@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161207054153.GD12489@umbus.fritz.box>
Message-Id: <20161208002458.GA4914@pacoca>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 2/7] target-ppc: Implement
 unsigned quadword left/right shift and unit tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

On Wed, Dec 07, 2016 at 04:41:53PM +1100, David Gibson wrote:
> On Tue, Dec 06, 2016 at 05:40:05PM -0200, Jose Ricardo Ziviani wrote:
> > This commit implements functions to right and left shifts and the
> > unittest for them. Such functions is needed due to instructions
> > that requires them.
> >=20
> > Today, there is already a right shift implementation in int128.h
> > but it's for signed numbers.
> >=20
> > Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> > ---
> >  include/qemu/host-utils.h | 43 +++++++++++++++++++++
> >  tests/Makefile.include    |  5 ++-
> >  tests/test-shift128.c     | 98 +++++++++++++++++++++++++++++++++++++=
++++++++++
> >  3 files changed, 145 insertions(+), 1 deletion(-)
> >  create mode 100644 tests/test-shift128.c
> >=20
> > diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
> > index 46187bb..e22d723 100644
> > --- a/include/qemu/host-utils.h
> > +++ b/include/qemu/host-utils.h
> > @@ -516,4 +516,47 @@ static inline uint64_t pow2ceil(uint64_t value)
> >      return 1ULL << (64 - nlz);
> >  }
> > =20
> > +static inline void urshift(uint64_t *plow, uint64_t *phigh, uint32_t=
 shift)
>=20
> These are complicated enough that they probably shouldn't be inlines.

I'm only allowed to implement inline functions in header, otherwise
I get "error: no previous prototype for =E2=80=98ulshift=E2=80=99
[-Werror=3Dmissing-prototypes]"

But host-utils.c is compiled only if CONFIG_INT128 is false:
util-obj-$(call lnot,$(CONFIG_INT128)) +=3D host-utils.o

Is that ok for you if I remove this condition from the Makefile and put
the #ifdef in .c, to guard the existing functions and put mine after it?

Thanks

>=20
> > +{
> > +    shift &=3D 127;
> > +    uint64_t h =3D *phigh >> (shift & 63);
> > +    if (shift =3D=3D 0) {
> > +        return;
> > +    } else if (shift >=3D 64) {
> > +        *plow =3D h;
> > +        *phigh =3D 0;
> > +    } else {
> > +        *plow =3D (*plow >> (shift & 63)) | (*phigh << (64 - (shift =
& 63)));
> > +        *phigh =3D h;
> > +    }
> > +}
> > +
> > +static inline void ulshift(uint64_t *plow, uint64_t *phigh, uint32_t=
 shift,
> > +        bool *overflow)
> > +{
> > +    uint64_t low =3D *plow;
> > +    uint64_t high =3D *phigh;
> > +
> > +    if (shift > 127 && (low | high)) {
> > +        *overflow =3D true;
> > +    }
> > +    shift &=3D 127;
> > +
> > +    if (shift =3D=3D 0) {
> > +        return;
> > +    }
> > +
> > +    urshift(&low, &high, 128 - shift);
> > +    if (low > 0 || high > 0) {
> > +        *overflow =3D true;
> > +    }
> > +
> > +    if (shift >=3D 64) {
> > +        *phigh =3D *plow << (shift & 63);
> > +        *plow =3D 0;
> > +    } else {
> > +        *phigh =3D (*plow >> (64 - (shift & 63))) | (*phigh << (shif=
t & 63));
> > +        *plow =3D *plow << shift;
> > +    }
> > +}
> >  #endif
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index e98d3b6..89e5e85 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -65,6 +65,8 @@ check-unit-$(CONFIG_POSIX) +=3D tests/test-vmstate$=
(EXESUF)
> >  endif
> >  check-unit-y +=3D tests/test-cutils$(EXESUF)
> >  gcov-files-test-cutils-y +=3D util/cutils.c
> > +check-unit-y +=3D tests/test-shift128$(EXESUF)
> > +gcov-files-test-shift128-y =3D util/host-utils.c
> >  check-unit-y +=3D tests/test-mul64$(EXESUF)
> >  gcov-files-test-mul64-y =3D util/host-utils.c
> >  check-unit-y +=3D tests/test-int128$(EXESUF)
> > @@ -460,7 +462,7 @@ test-obj-y =3D tests/check-qint.o tests/check-qst=
ring.o tests/check-qdict.o \
> >  	tests/test-x86-cpuid.o tests/test-mul64.o tests/test-int128.o \
> >  	tests/test-opts-visitor.o tests/test-qmp-event.o \
> >  	tests/rcutorture.o tests/test-rcu-list.o \
> > -	tests/test-qdist.o \
> > +	tests/test-qdist.o tests/test-shift128.o \
> >  	tests/test-qht.o tests/qht-bench.o tests/test-qht-par.o \
> >  	tests/atomic_add-bench.o
> > =20
> > @@ -568,6 +570,7 @@ tests/test-qmp-commands$(EXESUF): tests/test-qmp-=
commands.o tests/test-qmp-marsh
> >  tests/test-visitor-serialization$(EXESUF): tests/test-visitor-serial=
ization.o $(test-qapi-obj-y)
> >  tests/test-opts-visitor$(EXESUF): tests/test-opts-visitor.o $(test-q=
api-obj-y)
> > =20
> > +tests/test-shift128$(EXESUF): tests/test-shift128.o $(test-util-obj-=
y)
> >  tests/test-mul64$(EXESUF): tests/test-mul64.o $(test-util-obj-y)
> >  tests/test-bitops$(EXESUF): tests/test-bitops.o $(test-util-obj-y)
> >  tests/test-crypto-hash$(EXESUF): tests/test-crypto-hash.o $(test-cry=
pto-obj-y)
> > diff --git a/tests/test-shift128.c b/tests/test-shift128.c
> > new file mode 100644
> > index 0000000..52be6a2
> > --- /dev/null
> > +++ b/tests/test-shift128.c
> > @@ -0,0 +1,98 @@
> > +/*
> > + * Test unsigned left and right shift
> > + *
> > + * This work is licensed under the terms of the GNU LGPL, version 2 =
or later.
> > + * See the COPYING.LIB file in the top-level directory.
> > + *
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/host-utils.h"
> > +
> > +typedef struct {
> > +    uint64_t low;
> > +    uint64_t high;
> > +    uint64_t rlow;
> > +    uint64_t rhigh;
> > +    int32_t shift;
> > +    bool overflow;
> > +} test_data;
> > +
> > +static const test_data test_ltable[] =3D {
> > +    { 1223ULL, 0, 1223ULL,   0, 0, false },
> > +    { 1ULL,    0, 2ULL,   0, 1, false },
> > +    { 1ULL,    0, 4ULL,   0, 2, false },
> > +    { 1ULL,    0, 16ULL,  0, 4, false },
> > +    { 1ULL,    0, 256ULL, 0, 8, false },
> > +    { 1ULL,    0, 65536ULL, 0, 16, false },
> > +    { 1ULL,    0, 2147483648ULL, 0, 31, false },
> > +    { 1ULL,    0, 35184372088832ULL, 0, 45, false },
> > +    { 1ULL,    0, 1152921504606846976ULL, 0, 60, false },
> > +    { 1ULL,    0, 0, 1ULL, 64, false },
> > +    { 1ULL,    0, 0, 65536ULL, 80, false },
> > +    { 1ULL,    0, 0, 9223372036854775808ULL, 127, false },
> > +    { 0ULL,    1, 0, 0, 64, true },
> > +    { 0x8888888888888888ULL, 0x9999999999999999ULL,
> > +        0x8000000000000000ULL, 0x9888888888888888ULL, 60, true },
> > +    { 0x8888888888888888ULL, 0x9999999999999999ULL,
> > +        0, 0x8888888888888888ULL, 64, true },
> > +    { 0x8ULL, 0, 0, 0x8ULL, 64, false },
> > +    { 0x8ULL, 0, 0, 0x8000000000000000ULL, 124, false },
> > +    { 0x1ULL, 0, 0, 0x4000000000000000ULL, 126, false },
> > +    { 0x1ULL, 0, 0, 0x8000000000000000ULL, 127, false },
> > +    { 0x1ULL, 0, 0x1ULL, 0, 128, true },
> > +    { 0, 0, 0ULL, 0, 200, false },
> > +};
> > +
> > +static const test_data test_rtable[] =3D {
> > +    { 1223ULL, 0, 1223ULL,   0, 0, false },
> > +    { 9223372036854775808ULL, 9223372036854775808ULL,
> > +        2147483648L, 2147483648ULL, 32, false },
> > +    { 9223372036854775808ULL, 9223372036854775808ULL,
> > +        9223372036854775808ULL, 0, 64, false },
> > +    { 9223372036854775808ULL, 9223372036854775808ULL,
> > +        36028797018963968ULL, 0, 72, false },
> > +    { 9223372036854775808ULL, 9223372036854775808ULL,
> > +        1ULL, 0, 127, false },
> > +    { 9223372036854775808ULL, 0, 4611686018427387904ULL, 0, 1, false=
 },
> > +    { 9223372036854775808ULL, 0, 2305843009213693952ULL, 0, 2, false=
 },
> > +    { 9223372036854775808ULL, 0, 36028797018963968ULL, 0, 8, false }=
,
> > +    { 9223372036854775808ULL, 0, 140737488355328ULL, 0, 16, false },
> > +    { 9223372036854775808ULL, 0, 2147483648ULL, 0, 32, false },
> > +    { 9223372036854775808ULL, 0, 1ULL, 0, 63, false },
> > +    { 9223372036854775808ULL, 0, 0ULL, 0, 64, false },
> > +};
> > +
> > +static void test_lshift(void)
> > +{
> > +    int i;
> > +
> > +    for (i =3D 0; i < ARRAY_SIZE(test_ltable); ++i) {
> > +        bool overflow =3D false;
> > +        test_data tmp =3D test_ltable[i];
> > +        ulshift(&tmp.low, &tmp.high, tmp.shift, &overflow);
> > +        g_assert_cmpuint(tmp.low, =3D=3D, tmp.rlow);
> > +        g_assert_cmpuint(tmp.high, =3D=3D, tmp.rhigh);
> > +        g_assert_cmpuint(tmp.overflow, =3D=3D, overflow);
> > +    }
> > +}
> > +
> > +static void test_rshift(void)
> > +{
> > +    int i;
> > +
> > +    for (i =3D 0; i < ARRAY_SIZE(test_rtable); ++i) {
> > +        test_data tmp =3D test_rtable[i];
> > +        urshift(&tmp.low, &tmp.high, tmp.shift);
> > +        g_assert_cmpuint(tmp.low, =3D=3D, tmp.rlow);
> > +        g_assert_cmpuint(tmp.high, =3D=3D, tmp.rhigh);
> > +    }
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +    g_test_init(&argc, &argv, NULL);
> > +    g_test_add_func("/host-utils/test_lshift", test_lshift);
> > +    g_test_add_func("/host-utils/test_rshift", test_rshift);
> > +    return g_test_run();
> > +}
>=20
> --=20
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _oth=
er_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
