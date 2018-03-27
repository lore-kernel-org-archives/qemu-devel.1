Received: from eggs.gnu.org ([2001:4830:134:3::10]:35415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f0mrb-00054k-0i
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 07:34:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f0mrW-0006gq-Je
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 07:34:03 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:50268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f0mrW-0006fk-9I
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 07:33:58 -0400
Received: by mail-wm0-x22e.google.com with SMTP id l201so2776269wmg.0
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 04:33:58 -0700 (PDT)
References: <1521663109-32262-1-git-send-email-cota@braap.org>
	<1521663109-32262-5-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1521663109-32262-5-git-send-email-cota@braap.org>
Date: Tue, 27 Mar 2018 12:33:55 +0100
Message-ID: <87vadh92ho.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 04/14] fp-test: add muladd variants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Emilio G. Cota <cota@braap.org> writes:

> These are a few muladd-related operations that the original IBM syntax
> does not specify; model files for these are in muladd.fptest.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  tests/fp-test/fp-test.c     | 24 +++++++++++++++++++++
>  tests/fp-test/muladd.fptest | 51 +++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 75 insertions(+)
>  create mode 100644 tests/fp-test/muladd.fptest
>
> diff --git a/tests/fp-test/fp-test.c b/tests/fp-test/fp-test.c
> index 27637c4..2200d40 100644
> --- a/tests/fp-test/fp-test.c
> +++ b/tests/fp-test/fp-test.c
> @@ -53,6 +53,9 @@ enum op {
>      OP_SUB,
>      OP_MUL,
>      OP_MULADD,
> +    OP_MULADD_NEG_ADDEND,
> +    OP_MULADD_NEG_PRODUCT,
> +    OP_MULADD_NEG_RESULT,
>      OP_DIV,
>      OP_SQRT,
>      OP_MINNUM,
> @@ -69,6 +72,9 @@ static const struct op_desc ops[] =3D {
>      [OP_SUB] =3D       { "-", 2 },
>      [OP_MUL] =3D       { "*", 2 },
>      [OP_MULADD] =3D    { "*+", 3 },
> +    [OP_MULADD_NEG_ADDEND] =3D  { "*+nc", 3 },
> +    [OP_MULADD_NEG_PRODUCT] =3D { "*+np", 3 },
> +    [OP_MULADD_NEG_RESULT] =3D  { "*+nr", 3 },
>      [OP_DIV] =3D       { "/", 2 },
>      [OP_SQRT] =3D      { "V", 1 },
>      [OP_MINNUM] =3D    { "<C", 2 },
> @@ -463,6 +469,15 @@ static enum error soft_tester(struct test_op *t)
>          case OP_MULADD:
>              res =3D float32_muladd(a, b, c, 0, s);
>              break;
> +        case OP_MULADD_NEG_ADDEND:
> +            res =3D float32_muladd(a, b, c, float_muladd_negate_c, s);
> +            break;
> +        case OP_MULADD_NEG_PRODUCT:
> +            res =3D float32_muladd(a, b, c, float_muladd_negate_product,=
 s);
> +            break;
> +        case OP_MULADD_NEG_RESULT:
> +            res =3D float32_muladd(a, b, c, float_muladd_negate_result, =
s);
> +            break;
>          case OP_DIV:
>              res =3D float32_div(a, b, s);
>              break;
> @@ -522,6 +537,15 @@ static enum error soft_tester(struct test_op *t)
>          case OP_MULADD:
>              res64 =3D float64_muladd(a, b, c, 0, s);
>              break;
> +        case OP_MULADD_NEG_ADDEND:
> +            res64 =3D float64_muladd(a, b, c, float_muladd_negate_c, s);
> +            break;
> +        case OP_MULADD_NEG_PRODUCT:
> +            res64 =3D float64_muladd(a, b, c, float_muladd_negate_produc=
t, s);
> +            break;
> +        case OP_MULADD_NEG_RESULT:
> +            res64 =3D float64_muladd(a, b, c, float_muladd_negate_result=
, s);
> +            break;
>          case OP_DIV:
>              res64 =3D float64_div(a, b, s);
>              break;

Are there any intrinsics we could use for the hard variant which would
be useful if we want to run under translation?

> diff --git a/tests/fp-test/muladd.fptest b/tests/fp-test/muladd.fptest
> new file mode 100644
> index 0000000..6cd48ff
> --- /dev/null
> +++ b/tests/fp-test/muladd.fptest
> @@ -0,0 +1,51 @@
> +# nc =3D=3D negate addend
> +b32*+nc =3D0 -Inf -Inf +Inf -> Q i
> +b32*+nc =3D0 -1.7FFFFFP127 -Inf +Inf -> Q i
> +b32*+nc =3D0 -1.6C9AE7P113 -Inf +Inf -> Q i
> +b32*+nc =3D0 -1.000000P-126 -Inf +Inf -> Q i
> +b32*+nc =3D0 -0.7FFFFFP-126 -Inf +Inf -> Q i
> +b32*+nc =3D0 -0.1B977AP-126 -Inf +Inf -> Q i
> +b32*+nc =3D0 -0.000001P-126 -Inf +Inf -> Q i
> +b32*+nc =3D0 -1.000000P0 -Inf +Inf -> Q i
> +b32*+nc =3D0 -Zero -Inf +Inf -> Q i
> +b32*+nc =3D0 +Zero -Inf +Inf -> Q i
> +b32*+nc =3D0 -Zero -1.000000P-126 +1.7FFFFFP127 -> -1.7FFFFFP127
> +b32*+nc =3D0 +Zero -1.000000P-126 +1.7FFFFFP127 -> -1.7FFFFFP127
> +b32*+nc =3D0 -1.000000P-126 -1.7FFFFFP127 -1.4B9156P109 -> +1.4B9156P109=
 x
> +b32*+nc =3D0 -0.7FFFFFP-126 -1.7FFFFFP127 -1.51BA59P-113 -> +1.7FFFFDP1 x
> +b32*+nc =3D0 -0.3D6B57P-126 -1.7FFFFFP127 -1.265398P-67 -> +1.75AD5BP0 x
> +b32*+nc =3D0 -0.000001P-126 -1.7FFFFFP127 -1.677330P-113 -> +1.7FFFFFP-2=
2 x
> +
> +# np =3D=3D negate product
> +b32*+np =3D0 +Inf -Inf -Inf -> Q i
> +b32*+np =3D0 +1.7FFFFFP127 -Inf -Inf -> Q i
> +b32*+np =3D0 +1.6C9AE7P113 -Inf -Inf -> Q i
> +b32*+np =3D0 +1.000000P-126 -Inf -Inf -> Q i
> +b32*+np =3D0 +0.7FFFFFP-126 -Inf -Inf -> Q i
> +b32*+np =3D0 +0.1B977AP-126 -Inf -Inf -> Q i
> +b32*+np =3D0 +0.000001P-126 -Inf -Inf -> Q i
> +b32*+np =3D0 +1.000000P0 -Inf -Inf -> Q i
> +b32*+np =3D0 +Zero -Inf -Inf -> Q i
> +b32*+np =3D0 +Zero -Inf -Inf -> Q i
> +b32*+np =3D0 -Zero -1.000000P-126 -1.7FFFFFP127 -> -1.7FFFFFP127
> +b32*+np =3D0 +Zero -1.000000P-126 -1.7FFFFFP127 -> -1.7FFFFFP127
> +b32*+np =3D0 -1.3A6A89P-18 +1.24E7AEP9 -0.7FFFFFP-126 -> +1.7029E9P-9 x
> +
> +# nr =3D=3D negate result
> +b32*+nr =3D0 -Inf -Inf -Inf -> Q i
> +b32*+nr =3D0 -1.7FFFFFP127 -Inf -Inf -> Q i
> +b32*+nr =3D0 -1.6C9AE7P113 -Inf -Inf -> Q i
> +b32*+nr =3D0 -1.000000P-126 -Inf -Inf -> Q i
> +b32*+nr =3D0 -0.7FFFFFP-126 -Inf -Inf -> Q i
> +b32*+nr =3D0 -0.1B977AP-126 -Inf -Inf -> Q i
> +b32*+nr =3D0 -0.000001P-126 -Inf -Inf -> Q i
> +b32*+nr =3D0 -1.000000P0 -Inf -Inf -> Q i
> +b32*+nr =3D0 -Zero -Inf -Inf -> Q i
> +b32*+nr =3D0 -Zero -Inf -Inf -> Q i
> +b32*+nr =3D0 +Zero -1.000000P-126 -1.7FFFFFP127 -> +1.7FFFFFP127
> +b32*+nr =3D0 -Zero -1.000000P-126 -1.7FFFFFP127 -> +1.7FFFFFP127
> +b32*+nr =3D0 -1.000000P-126 -1.7FFFFFP127 -1.4B9156P109 -> +1.4B9156P109=
 x
> +b32*+nr =3D0 -0.7FFFFFP-126 -1.7FFFFFP127 -1.51BA59P-113 -> -1.7FFFFDP1 x
> +b32*+nr =3D0 -0.3D6B57P-126 -1.7FFFFFP127 -1.265398P-67 -> -1.75AD5BP0 x
> +b32*+nr =3D0 -0.000001P-126 -1.7FFFFFP127 -1.677330P-113 -> -1.7FFFFFP-2=
2 x
> +b32*+nr =3D0 +1.72E53AP-33 -1.7FFFFFP127 -1.5AA684P-2 -> +1.72E539P95 x


--
Alex Benn=C3=A9e
