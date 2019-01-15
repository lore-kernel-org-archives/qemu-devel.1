Received: from eggs.gnu.org ([209.51.188.92]:48798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gjWiq-00074N-1O
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:58:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gjWio-0001oi-Qs
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:58:11 -0500
Received: from mail-eopbgr750108.outbound.protection.outlook.com
	([40.107.75.108]:52928
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gjWik-0001lA-P2
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:58:06 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 15 Jan 2019 21:57:59 +0000
Message-ID: <BN6PR2201MB125196969C9702BEF0BBA30BC6810@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <cover.1547403692.git.noring@nocrew.org>,
	<f12b05b6581daa925e253a9639dd44d34441a511.1547403692.git.noring@nocrew.org>
In-Reply-To: <f12b05b6581daa925e253a9639dd44d34441a511.1547403692.git.noring@nocrew.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 9/9] tests/tcg/mips: Test R5900 multimedia
 instruction SQ
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
> Sent: Sunday, January 13, 2019 8:09 PM
> To: Aleksandar Markovic; Aurelien Jarno; Philippe Mathieu-Daud=E9
> Cc: J=FCrgen Urban; Maciej W. Rozycki; qemu-devel@nongnu.org
> Subject: [PATCH 9/9] tests/tcg/mips: Test R5900 multimedia instruction SQ
>=20
> Signed-off-by: Fredrik Noring <noring@nocrew.org>
> ---

The commit message is missing. I will deal with the rest of this patch once=
 LQ
implementation patch is accepted. Otherwise an interesting testing idea.


>  tests/tcg/mips/mipsn32r5900/Makefile |   1 +
>  tests/tcg/mips/mipsn32r5900/sq.c     | 105 +++++++++++++++++++++++++++
>  2 files changed, 106 insertions(+)
>  create mode 100644 tests/tcg/mips/mipsn32r5900/sq.c
>=20
> diff --git a/tests/tcg/mips/mipsn32r5900/Makefile b/tests/tcg/mips/mipsn3=
2r5900/Makefile
> index cb3ef9d26a..a9e9481457 100644
> --- a/tests/tcg/mips/mipsn32r5900/Makefile
> +++ b/tests/tcg/mips/mipsn32r5900/Makefile
> @@ -10,6 +10,7 @@ CFLAGS  =3D -Wall -mabi=3Dn32 -march=3Dr5900 -static
>=20
>  TESTCASES =3D lq.tst
>  TESTCASES +=3D pcpyuld.tst
> +TESTCASES +=3D sq.tst
>=20
>  all: $(TESTCASES)
>=20
> diff --git a/tests/tcg/mips/mipsn32r5900/sq.c b/tests/tcg/mips/mipsn32r59=
00/sq.c
> new file mode 100644
> index 0000000000..97b21711ba
> --- /dev/null
> +++ b/tests/tcg/mips/mipsn32r5900/sq.c
> @@ -0,0 +1,105 @@
> +/*
> + * Test SQ.
> + */
> +
> +#include <stdio.h>
> +#include <string.h>
> +#include <inttypes.h>
> +#include <assert.h>
> +
> +#define GUARD_BYTE 0xA9
> +
> +/* 128-bit multimedia register */
> +struct mmr { uint64_t hi, lo; } __attribute__((aligned(16)));
> +
> +static uint8_t data[64];
> +
> +#define SQ(value, base, offset) \
> +        __asm__ __volatile__ ( \
> +            "    pcpyld  %0, %0, %1\n" \
> +            "    sq %0, %3(%2)\n" \
> +            : \
> +            : "r" (value.hi), "r" (value.lo), \
> +              "r" (base), "i" (offset))
> +
> +static void verify_sq(struct mmr value, const void *base, int16_t offset=
)
> +{
> +    /*
> +     * The least significant four bits of the effective address are
> +     * masked to zero, effectively creating an aligned address. No
> +     * address exceptions due to alignment are possible.
> +     */
> +    const uint8_t *b =3D base;
> +    const uint8_t *o =3D &b[offset];
> +    const uint8_t *a =3D (const uint8_t*)((unsigned long)o & ~0xFUL);
> +    size_t i;
> +
> +    for (i =3D 0; i < sizeof(data); i++) {
> +        ssize_t d =3D &data[i] - &a[0];
> +
> +        if (d < 0) {
> +            assert(data[i] =3D=3D GUARD_BYTE);
> +        } else if (d < 8) {
> +            assert(data[i] =3D=3D ((value.lo >> (8 * (d - 0))) & 0xFF));
> +        } else if (d < 16) {
> +            assert(data[i] =3D=3D ((value.hi >> (8 * (d - 8))) & 0xFF));
> +        } else {
> +            assert(data[i] =3D=3D GUARD_BYTE);
> +        }
> +    }
> +}
> +
> +#define VERIFY_SQ(base, offset) \
> +    do { \
> +        struct mmr value =3D { \
> +            .hi =3D 0x6665646362613938, \
> +            .lo =3D 0x3736353433323130 \
> +        }; \
> +    \
> +        memset(data, GUARD_BYTE, sizeof(data)); \
> +        SQ(value, base, offset); \
> +        verify_sq(value, base, offset); \
> +    } while (0)
> +
> +int main()
> +{
> +    int i;
> +
> +    for (i =3D 16; i < 48; i++) {
> +        VERIFY_SQ(&data[i], -16);
> +        VERIFY_SQ(&data[i], -15);
> +        VERIFY_SQ(&data[i], -14);
> +        VERIFY_SQ(&data[i], -13);
> +        VERIFY_SQ(&data[i], -12);
> +        VERIFY_SQ(&data[i], -11);
> +        VERIFY_SQ(&data[i], -10);
> +        VERIFY_SQ(&data[i], -9);
> +        VERIFY_SQ(&data[i], -8);
> +        VERIFY_SQ(&data[i], -7);
> +        VERIFY_SQ(&data[i], -6);
> +        VERIFY_SQ(&data[i], -5);
> +        VERIFY_SQ(&data[i], -4);
> +        VERIFY_SQ(&data[i], -3);
> +        VERIFY_SQ(&data[i], -2);
> +        VERIFY_SQ(&data[i], -1);
> +        VERIFY_SQ(&data[i],  0);
> +        VERIFY_SQ(&data[i],  1);
> +        VERIFY_SQ(&data[i],  2);
> +        VERIFY_SQ(&data[i],  3);
> +        VERIFY_SQ(&data[i],  4);
> +        VERIFY_SQ(&data[i],  5);
> +        VERIFY_SQ(&data[i],  6);
> +        VERIFY_SQ(&data[i],  7);
> +        VERIFY_SQ(&data[i],  8);
> +        VERIFY_SQ(&data[i],  9);
> +        VERIFY_SQ(&data[i],  10);
> +        VERIFY_SQ(&data[i],  11);
> +        VERIFY_SQ(&data[i],  12);
> +        VERIFY_SQ(&data[i],  13);
> +        VERIFY_SQ(&data[i],  14);
> +        VERIFY_SQ(&data[i],  15);
> +        VERIFY_SQ(&data[i],  16);
> +    }
> +
> +    return 0;
> +}
> --
> 2.19.2
>=20
> =
