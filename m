Received: from eggs.gnu.org ([209.51.188.92]:55951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1go4kG-0003QS-J7
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:06:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1go4kE-0003yR-54
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:06:28 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1go4k7-0003xi-8M
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:06:20 -0500
Received: by mail-wm1-x343.google.com with SMTP id m22so13467891wml.3
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 03:06:17 -0800 (PST)
References: <20190125225714.10234-1-richard.henderson@linaro.org>
	<20190125225714.10234-8-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190125225714.10234-8-richard.henderson@linaro.org>
Date: Mon, 28 Jan 2019 11:06:14 +0000
Message-ID: <871s4xnis9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/6] tests/tcg/aarch64: Add pauth smoke
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
Cc: peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tests/tcg/aarch64/pauth-1.c       | 23 +++++++++++++++++++++++
>  tests/tcg/aarch64/Makefile.target |  7 ++++++-
>  2 files changed, 29 insertions(+), 1 deletion(-)
>  create mode 100644 tests/tcg/aarch64/pauth-1.c
>
> diff --git a/tests/tcg/aarch64/pauth-1.c b/tests/tcg/aarch64/pauth-1.c
> new file mode 100644
> index 0000000000..9bd8d28ede
> --- /dev/null
> +++ b/tests/tcg/aarch64/pauth-1.c
> @@ -0,0 +1,23 @@
> +#include <assert.h>
> +#include <sys/prctl.h>
> +
> +asm(".arch armv8.4-a");
> +
> +#ifndef PR_PAC_RESET_KEYS
> +#define PR_PAC_RESET_KEYS  54
> +#define PR_PAC_APDAKEY     (1 << 2)
> +#endif
> +
> +int main()
> +{
> +    int x;
> +    void *p0 =3D &x, *p1, *p2;
> +
> +    asm volatile("pacdza %0" : "=3Dr"(p1) : "0"(p0));
> +    prctl(PR_PAC_RESET_KEYS, PR_PAC_APDAKEY);
> +    asm volatile("pacdza %0" : "=3Dr"(p2) : "0"(p0));
> +
> +    assert(p1 !=3D p0);
> +    assert(p1 !=3D p2);
> +    return 0;
> +}
> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefi=
le.target
> index 08c45b8470..e80d07276c 100644
> --- a/tests/tcg/aarch64/Makefile.target
> +++ b/tests/tcg/aarch64/Makefile.target
> @@ -8,10 +8,15 @@ VPATH 		+=3D $(AARCH64_SRC)
>  # we don't build any of the ARM tests
>  AARCH64_TESTS=3D$(filter-out $(ARM_TESTS), $(TESTS))
>  AARCH64_TESTS+=3Dfcvt
> -TESTS:=3D$(AARCH64_TESTS)
>
>  fcvt: LDFLAGS+=3D-lm
>
>  run-fcvt: fcvt
>  	$(call run-test,$<,$(QEMU) $<, "$< on $(TARGET_NAME)")
>  	$(call diff-out,$<,$(AARCH64_SRC)/fcvt.ref)
> +
> +AARCH64_TESTS +=3D pauth-1
> +pauth-%: CFLAGS +=3D -O -g

We build all tests with:

  CFLAGS+=3D-Wall -O0 -g -fno-strict-aliasing

mainly because the first thing you want to do when they fail is run them
through gdb to see what went wrong. Do you actually need optimisation on
for the build to work? Everything else looks good though:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> +run-pauth-%: QEMU +=3D -cpu max
> +
> +TESTS:=3D$(AARCH64_TESTS)


--
Alex Benn=C3=A9e
