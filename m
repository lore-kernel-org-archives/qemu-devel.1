Received: from eggs.gnu.org ([209.51.188.92]:53496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj38o-0008DF-Kk
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:23:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj38n-0007X6-Rs
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:23:02 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gj38n-0007T0-MB
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:23:01 -0500
Received: by mail-wm1-x342.google.com with SMTP id t200so9088803wmt.0
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 06:22:53 -0800 (PST)
References: <20190114011122.5995-1-richard.henderson@linaro.org>
	<20190114011122.5995-18-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190114011122.5995-18-richard.henderson@linaro.org>
Date: Mon, 14 Jan 2019 14:22:51 +0000
Message-ID: <878sznpbd0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 17/17] tests/tcg/aarch64: Add mte smoke
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> ??? Requires a quite recent aarch64 assembler.  Use .inst instead?

How recent? Given buster is nearing release we could start using it as a
basis for the ARM cross compiler images. That is shipping gcc 8.2.0 as
of now.

>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tests/tcg/aarch64/mte-1.c         | 27 +++++++++++++++++++++
>  tests/tcg/aarch64/mte-2.c         | 39 +++++++++++++++++++++++++++++++
>  tests/tcg/aarch64/Makefile.target |  4 ++++
>  3 files changed, 70 insertions(+)
>  create mode 100644 tests/tcg/aarch64/mte-1.c
>  create mode 100644 tests/tcg/aarch64/mte-2.c
>
> diff --git a/tests/tcg/aarch64/mte-1.c b/tests/tcg/aarch64/mte-1.c
> new file mode 100644
> index 0000000000..740bf506f1
> --- /dev/null
> +++ b/tests/tcg/aarch64/mte-1.c
> @@ -0,0 +1,27 @@
> +/*
> + * Memory tagging, basic pass cases.
> + */
> +
> +#include <assert.h>
> +
> +asm(".arch armv8.5-a+memtag");
> +
> +int data[16 / sizeof(int)] __attribute__((aligned(16)));
> +
> +int main(int ac, char **av)
> +{
> +    int *p0 =3D data;
> +    int *p1, *p2;
> +    long c;
> +
> +    asm("irg %0,%1,%2" : "=3Dr"(p1) : "r"(p0), "r"(1));
> +    assert(p1 !=3D p0);
> +    asm("subp %0,%1,%2" : "=3Dr"(c) : "r"(p0), "r"(p1));
> +    assert(c =3D=3D 0);
> +
> +    asm("stg [%0]" : : "r"(p1));
> +    asm("ldg %0, [%1]" : "=3Dr"(p2) : "r"(p0));
> +    assert(p1 =3D=3D p2);
> +
> +    return 0;
> +}
> diff --git a/tests/tcg/aarch64/mte-2.c b/tests/tcg/aarch64/mte-2.c
> new file mode 100644
> index 0000000000..4d2004ab41
> --- /dev/null
> +++ b/tests/tcg/aarch64/mte-2.c
> @@ -0,0 +1,39 @@
> +/*
> + * Memory tagging, basic fail cases.
> + */
> +
> +#include <assert.h>
> +#include <signal.h>
> +#include <stdlib.h>
> +
> +asm(".arch armv8.5-a+memtag");
> +
> +int data[16 / sizeof(int)] __attribute__((aligned(16)));
> +
> +void pass(int sig)
> +{
> +    exit(0);
> +}
> +
> +int main(int ac, char **av)
> +{
> +    int *p0 =3D data;
> +    int *p1, *p2;
> +    long excl =3D 1;
> +
> +    /* Create two differently tagged pointers.  */
> +    asm("irg %0,%1,%2" : "=3Dr"(p1) : "r"(p0), "r"(excl));
> +    asm("gmi %0,%1,%0" : "+r"(excl) : "r" (p1));
> +    assert(excl !=3D 1);
> +    asm("irg %0,%1,%2" : "=3Dr"(p2) : "r"(p0), "r"(excl));
> +    assert(p1 !=3D p2);
> +
> +    /* Store the tag from the first pointer.  */
> +    asm("stg [%0]" : : "r"(p1));
> +
> +    *p1 =3D 0;
> +    signal(SIGSEGV, pass);
> +    *p2 =3D 0;
> +
> +    assert(0);
> +}
> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefi=
le.target
> index 3d56e7c6ea..1c4ebe894c 100644
> --- a/tests/tcg/aarch64/Makefile.target
> +++ b/tests/tcg/aarch64/Makefile.target
> @@ -19,4 +19,8 @@ AARCH64_TESTS +=3D bti-1
>  bti-1: LDFLAGS +=3D -nostartfiles -nodefaultlibs -nostdlib
>  run-bti-1: QEMU +=3D -cpu max,guarded_pages=3Don
>
> +AARCH64_TESTS +=3D mte-1 mte-2
> +mte-%: CFLAGS +=3D -O -g
> +run-mte-%: QEMU +=3D -cpu max
> +
>  TESTS:=3D$(AARCH64_TESTS)


--
Alex Benn=C3=A9e
