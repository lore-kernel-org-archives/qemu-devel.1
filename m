Received: from eggs.gnu.org ([209.51.188.92]:60753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gjWZD-0001De-0U
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:48:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gjWX0-0007aN-FL
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:46:00 -0500
Received: from mail-eopbgr810109.outbound.protection.outlook.com
	([40.107.81.109]:64679
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gjWWy-0007XX-Cq
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:45:58 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 15 Jan 2019 21:45:52 +0000
Message-ID: <BN6PR2201MB12516DEB41CA0F73D426AD0EC6810@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <cover.1547403692.git.noring@nocrew.org>,
	<5a4aa79777985d3d5c777ad2cdc6fdee9081345f.1547403692.git.noring@nocrew.org>
In-Reply-To: <5a4aa79777985d3d5c777ad2cdc6fdee9081345f.1547403692.git.noring@nocrew.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 7/9] tests/tcg/mips: Test R5900 multimedia
 instructions PCPYUD and PCPYLD
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
> Sent: Sunday, January 13, 2019 8:07 PM
> To: Aleksandar Markovic; Aurelien Jarno; Philippe Mathieu-Daud=E9
> Cc: J=FCrgen Urban; Maciej W. Rozycki; qemu-devel@nongnu.org
> Subject: [PATCH 7/9] tests/tcg/mips: Test R5900 multimedia instructions P=
CPYUD and PCPYLD
>=20
> Signed-off-by: Fredrik Noring <noring@nocrew.org>
> ---

Please just add a commit message. Otherwise:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

>  tests/tcg/mips/mipsn32r5900/Makefile  | 25 +++++++++++++++
>  tests/tcg/mips/mipsn32r5900/pcpyuld.c | 46 +++++++++++++++++++++++++++
>  2 files changed, 71 insertions(+)
>  create mode 100644 tests/tcg/mips/mipsn32r5900/Makefile
>  create mode 100644 tests/tcg/mips/mipsn32r5900/pcpyuld.c
>=20
> diff --git a/tests/tcg/mips/mipsn32r5900/Makefile b/tests/tcg/mips/mipsn3=
2r5900/Makefile
> new file mode 100644
> index 0000000000..f4887678ae
> --- /dev/null
> +++ b/tests/tcg/mips/mipsn32r5900/Makefile
> @@ -0,0 +1,25 @@
> +-include ../../config-host.mak
> +
> +CROSS=3Dmips64r5900el-unknown-linux-gnu-
> +
> +SIM=3Dqemu-mipsn32el
> +SIM_FLAGS=3D-cpu R5900
> +
> +CC      =3D $(CROSS)gcc
> +CFLAGS  =3D -Wall -mabi=3Dn32 -march=3Dr5900 -static
> +
> +TESTCASES =3D pcpyuld.tst
> +
> +all: $(TESTCASES)
> +
> +%.tst: %.c
> +       $(CC) $(CFLAGS) $< -o $@
> +
> +check: $(TESTCASES)
> +       @for case in $(TESTCASES); do \
> +        echo $(SIM) $(SIM_FLAGS) ./$$case;\
> +        $(SIM) $(SIM_FLAGS) ./$$case; \
> +       done
> +
> +clean:
> +       $(RM) -rf $(TESTCASES)
> diff --git a/tests/tcg/mips/mipsn32r5900/pcpyuld.c b/tests/tcg/mips/mipsn=
32r5900/pcpyuld.c
> new file mode 100644
> index 0000000000..c92af6330b
> --- /dev/null
> +++ b/tests/tcg/mips/mipsn32r5900/pcpyuld.c
> @@ -0,0 +1,46 @@
> +/*
> + * Test PCPYUD and PCPYLD.
> + */
> +
> +#include <stdio.h>
> +#include <string.h>
> +#include <inttypes.h>
> +#include <assert.h>
> +
> +/* 128-bit multimedia register */
> +struct mmr { uint64_t hi, lo; } __attribute__((aligned(16)));
> +
> +static void verify_zero(void)
> +{
> +    __asm__ __volatile__ (
> +        "    pcpyud  $0, $0, $0\n"
> +        "    pcpyld  $0, $0, $0\n"
> +    );
> +}
> +
> +static void verify_copy(void)
> +{
> +    const struct mmr value =3D {
> +        .hi =3D 0x6665646362613938,
> +        .lo =3D 0x3736353433323130
> +    };
> +    struct mmr result =3D { };
> +
> +    __asm__ __volatile__ (
> +        "    pcpyld  %0, %2, %3\n"
> +        "    move    %1, %0\n"
> +        "    pcpyud  %0, %0, %0\n"
> +        : "=3Dr" (result.hi), "=3Dr" (result.lo)
> +        : "r" (value.hi), "r" (value.lo));
> +
> +    assert(value.hi =3D=3D result.hi);
> +    assert(value.lo =3D=3D result.lo);
> +}
> +
> +int main()
> +{
> +    verify_zero();
> +    verify_copy();
> +
> +    return 0;
> +}
> --
> 2.19.2
>=20
> =
