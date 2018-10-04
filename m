Received: from eggs.gnu.org ([2001:4830:134:3::10]:52677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g7zhr-0003Iz-8X
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 05:14:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g7zho-0001Iw-0P
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 05:14:03 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g7zhn-0001Ex-3e
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 05:13:59 -0400
Received: by mail-wm1-x342.google.com with SMTP id 193-v6so8195771wme.3
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 02:13:58 -0700 (PDT)
References: <20181003180711.19335-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181003180711.19335-1-richard.henderson@linaro.org>
Date: Thu, 04 Oct 2018 10:13:55 +0100
Message-ID: <871s96rs4s.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/4] softfloat: Fix division
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, cota@braap.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Changes from v1:
>   * Preserve udiv_qrnnd as a separate division primitive that
>     could be used as a building block for float128 division.
>   * Include asm fragments for x86_64, s390x, and ppc64.


It passes my fops fdiv_double test but Emilio's test is reporting:

  Errors found in f64_div, rounding near_even:
  +252.7FFFFFFFFFF80  +001.FFFFFFFFFFFFE
          =3D> +64F.7FFFFFFFFFF82 ....x  expected +64F.7FFFFFFFFFF81 ....x
  +000.FFFFFFFFFFFFF  +3FE.FFFFFFFFFFFFF
          =3D> +001.0000000000000 ...ux  expected +000.FFFFFFFFFFFFF ...ux
  +000.FFFFFFFFFFFFF  -3FE.FFFFFFFFFFFFF
          =3D> -001.0000000000000 ...ux  expected -000.FFFFFFFFFFFFF ...ux
  +000.FFFFFFFFFFFFE  +3FE.FFFFFFFFFFFFF
          =3D> +000.FFFFFFFFFFFFF ...ux  expected +000.FFFFFFFFFFFFE ...ux
  +000.FFFFFFFFFFFFE  +3FF.FFFFFFFFFFFFE
          =3D> +000.8000000000000 ...ux  expected +000.7FFFFFFFFFFFF ...ux
  +000.FFFFFFFFFFFFE  -3FE.FFFFFFFFFFFFF
          =3D> -000.FFFFFFFFFFFFF ...ux  expected -000.FFFFFFFFFFFFE ...ux
  +000.FFFFFFFFFFFFE  -3FF.FFFFFFFFFFFFE
          =3D> -000.8000000000000 ...ux  expected -000.7FFFFFFFFFFFF ...ux
  -401.E7D66F623CB4C  +787.FEFF7FFFFFFFE
          =3D> -078.E8CB4F3CAEDB8 ....x  expected -078.E8CB4F3CAEDB7 ....x
  +3FC.0000000007FEF  +198.0000002000007
          =3D> +662.FFFFFFC00FFD1 ....x  expected +662.FFFFFFC00FFD0 ....x
  -400.FFFFF8000001F  -41C.FFFFFFBFFFFDF
          =3D> +3E2.FFFFF84000031 ....x  expected +3E2.FFFFF84000030 ....x
  -7FE.7FFFFFFFBFFFF  +3FE.FFFFFFFFFFFFE
          =3D> -7FE.7FFFFFFFC0001 ....x  expected -7FE.7FFFFFFFC0000 ....x
  +001.FFFFFFFFFFFFE  +3FF.FFFFFFFFFFFFF
          =3D> +001.0000000000000 ...ux  expected +000.FFFFFFFFFFFFF ...ux
  +001.FFFFFFFFFFFFE  -3FF.FFFFFFFFFFFFF
          =3D> -001.0000000000000 ...ux  expected -000.FFFFFFFFFFFFF ...ux
  +3CA.0000000000000  +4CF.FFFFFE000001F
          =3D> +2F9.0000010000001 ....x  expected +2F9.0000010000000 ....x
  +3FD.0000000000000  -400.000003DFFFFFF
          =3D> -3FB.FFFFF840001E3 ....x  expected -3FB.FFFFF840001E2 ....x
  +2C6.00000000003EF  -400.0000400400000
          =3D> -2C4.FFFF7FF82081E ....x  expected -2C4.FFFF7FF82081D ....x
  +3FD.0000000000001  -3CA.FFFFFF0001FFF
          =3D> -431.0000007FFF006 ....x  expected -431.0000007FFF005 ....x
  -002.FFFFFFFFFFFDE  -400.FFFFFFFFFFFFF
          =3D> +000.FFFFFFFFFFFF0 ...ux  expected +000.FFFFFFFFFFFEF ...ux
  +3FE.0000000000001  -3FF.0000001FFFFFF
          =3D> -3FD.FFFFFFC000005 ....x  expected -3FD.FFFFFFC000004 ....x
  +3FF.0000000000000  -47E.FFFFFC00000FF
          =3D> -37F.000001FFFFFC1 ....x  expected -37F.000001FFFFFC0 ....x

>
> r~
>
>
> Richard Henderson (4):
>   softfloat: Fix division
>   softfloat: Specialize udiv_qrnnd for x86_64
>   softfloat: Specialize udiv_qrnnd for s390x
>   softfloat: Specialize udiv_qrnnd for ppc64
>
>  include/fpu/softfloat-macros.h | 35 +++++++++++++++++++++++++++++++---
>  fpu/softfloat.c                | 35 ++++++++++++++++++++++++++--------
>  2 files changed, 59 insertions(+), 11 deletions(-)


--
Alex Benn=C3=A9e
