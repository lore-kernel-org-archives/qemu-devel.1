Received: from eggs.gnu.org ([209.51.188.92]:46823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gjWh9-00067t-7d
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:56:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gjWh7-0000hM-9A
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:56:27 -0500
Received: from mail-eopbgr780135.outbound.protection.outlook.com
	([40.107.78.135]:10624
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gjWh5-0000dp-FM
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:56:25 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 15 Jan 2019 21:56:20 +0000
Message-ID: <BN6PR2201MB125152B0D011F028EA3DCA4BC6810@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <cover.1547403692.git.noring@nocrew.org>,
	<e1efe4eff36a4069bbf8411a09d01acd387fb49d.1547403692.git.noring@nocrew.org>
In-Reply-To: <e1efe4eff36a4069bbf8411a09d01acd387fb49d.1547403692.git.noring@nocrew.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 8/9] tests/tcg/mips: Test R5900 multimedia
 instruction LQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: =?iso-8859-1?Q?J=FCrgen_Urban?= <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> From: Fredrik Noring <noring@nocrew.org>
> Sent: Sunday, January 13, 2019 8:08 PM
> To: Aleksandar Markovic; Aurelien Jarno; Philippe Mathieu-Daud=E9
> Cc: J=FCrgen Urban; Maciej W. Rozycki; qemu-devel@nongnu.org
> Subject: [PATCH 8/9] tests/tcg/mips: Test R5900 multimedia instruction LQ
>=20
> Signed-off-by: Fredrik Noring <noring@nocrew.org>
> ---

The commit message is missing. I will deal with the rest of this patch once=
 LQ
implementation patch is accepted.

>  tests/tcg/mips/mipsn32r5900/Makefile |   3 +-
>  tests/tcg/mips/mipsn32r5900/lq.c     | 111 +++++++++++++++++++++++++++
>  2 files changed, 113 insertions(+), 1 deletion(-)
>  create mode 100644 tests/tcg/mips/mipsn32r5900/lq.c
>=20
> diff --git a/tests/tcg/mips/mipsn32r5900/Makefile b/tests/tcg/mips/mipsn3=
2r5900/Makefile
> index f4887678ae..cb3ef9d26a 100644
> --- a/tests/tcg/mips/mipsn32r5900/Makefile
> +++ b/tests/tcg/mips/mipsn32r5900/Makefile
> @@ -8,7 +8,8 @@ SIM_FLAGS=3D-cpu R5900
>  CC      =3D $(CROSS)gcc
>  CFLAGS  =3D -Wall -mabi=3Dn32 -march=3Dr5900 -static
>=20
> -TESTCASES =3D pcpyuld.tst
> +TESTCASES =3D lq.tst
> +TESTCASES +=3D pcpyuld.tst
>=20
>  all: $(TESTCASES)
>=20
> diff --git a/tests/tcg/mips/mipsn32r5900/lq.c b/tests/tcg/mips/mipsn32r59=
00/lq.c
> new file mode 100644
> index 0000000000..5a16b12450
> --- /dev/null
> +++ b/tests/tcg/mips/mipsn32r5900/lq.c
> @@ -0,0 +1,111 @@
> +/*
> + * Test LQ.
> + */
> +
> +#include <stdio.h>
> +#include <inttypes.h>
> +#include <assert.h>
> +
> +/* 128-bit multimedia register */
> +struct mmr { uint64_t hi, lo; } __attribute__((aligned(16)));
> +
> +#define LQ(base, offset) \
> +    ({ \
> +        uint64_t hi, lo; \
> +    \
> +        __asm__ __volatile__ ( \
> +            "    pcpyld  %1, %1, %1\n" \
> +            "    lq %1, %3(%2)\n" \
> +            "    pcpyud  %0, %1, %1\n" \
> +            : "=3Dr" (hi), "=3Dr" (lo) \
> +            : "r" (base), "i" (offset)); \
> +    \
> +        (struct mmr) { .hi =3D hi, .lo =3D lo }; \
> +    })
> +
> +static uint64_t ld_reference(const void *base, int16_t offset)
> +{
> +    const uint8_t *p =3D base;
> +    uint64_t r =3D 0;
> +    int i;
> +
> +    for (i =3D 0; i < 8; i++) {
> +        r |=3D (uint64_t)p[offset + i] << (8 * i);
> +    }
> +
> +    return r;
> +}
> +
> +static struct mmr lq_reference(const void *base, int16_t offset)
> +{
> +    /*
> +     * The least significant four bits of the effective address are
> +     * masked to zero, effectively creating an aligned address. No
> +     * address exceptions due to alignment are possible.
> +     */
> +    const uint8_t *b =3D base;
> +    const uint8_t *o =3D &b[offset];
> +    const void *a =3D (const void*)((unsigned long)o & ~0xFUL);
> +
> +    return (struct mmr) {
> +        .hi =3D ld_reference(a, 8),
> +        .lo =3D ld_reference(a, 0)
> +    };
> +}
> +
> +static void assert_equal_mmr(struct mmr a, struct mmr b)
> +{
> +    assert(a.hi =3D=3D b.hi);
> +    assert(a.lo =3D=3D b.lo);
> +}
> +
> +#define VERIFY_LQ(base, offset) \
> +    assert_equal_mmr(LQ(base, offset), lq_reference(base, offset))
> +
> +int main()
> +{
> +    static const char data[] __attribute__((aligned(16)))=3D
> +        "0123456789abcdef"
> +        "ghijklmnopqrstuv"
> +        "wxyzABCDEFGHIJKL"
> +        "MNOPQRSTUVWXYZ.,";
> +    int i;
> +
> +    for (i =3D 16; i < 48; i++) {
> +        VERIFY_LQ(&data[i], -16);
> +        VERIFY_LQ(&data[i], -15);
> +        VERIFY_LQ(&data[i], -14);
> +        VERIFY_LQ(&data[i], -13);
> +        VERIFY_LQ(&data[i], -12);
> +        VERIFY_LQ(&data[i], -11);
> +        VERIFY_LQ(&data[i], -10);
> +        VERIFY_LQ(&data[i], -9);
> +        VERIFY_LQ(&data[i], -8);
> +        VERIFY_LQ(&data[i], -7);
> +        VERIFY_LQ(&data[i], -6);
> +        VERIFY_LQ(&data[i], -5);
> +        VERIFY_LQ(&data[i], -4);
> +        VERIFY_LQ(&data[i], -3);
> +        VERIFY_LQ(&data[i], -2);
> +        VERIFY_LQ(&data[i], -1);
> +        VERIFY_LQ(&data[i],  0);
> +        VERIFY_LQ(&data[i],  1);
> +        VERIFY_LQ(&data[i],  2);
> +        VERIFY_LQ(&data[i],  3);
> +        VERIFY_LQ(&data[i],  4);
> +        VERIFY_LQ(&data[i],  5);
> +        VERIFY_LQ(&data[i],  6);
> +        VERIFY_LQ(&data[i],  7);
> +        VERIFY_LQ(&data[i],  8);
> +        VERIFY_LQ(&data[i],  9);
> +        VERIFY_LQ(&data[i],  10);
> +        VERIFY_LQ(&data[i],  11);
> +        VERIFY_LQ(&data[i],  12);
> +        VERIFY_LQ(&data[i],  13);
> +        VERIFY_LQ(&data[i],  14);
> +        VERIFY_LQ(&data[i],  15);
> +        VERIFY_LQ(&data[i],  16);
> +    }
> +
> +    return 0;
> +}
> --
> 2.19.2
>=20
> =
