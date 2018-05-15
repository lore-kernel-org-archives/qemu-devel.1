Received: from eggs.gnu.org ([208.118.235.92]:53759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIYN0-0007Hl-G8
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:43:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIYMx-0002D0-DN
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:43:54 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:54835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fIYMx-0002Cq-50
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:43:51 -0400
Received: by mail-wm0-x244.google.com with SMTP id f6-v6so436675wmc.4
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 04:43:50 -0700 (PDT)
References: <20180514221219.7091-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180514221219.7091-1-richard.henderson@linaro.org>
Date: Tue, 15 May 2018 12:43:48 +0100
Message-ID: <87po1xf8jv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 00/28] softfloat patch roundup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> This is my SNaN patch set, Alex's float-float refactor, and a couple
> of other random outstanding fpu patches.  This has been reordered so
> as to be bisectable, since the float-float refactor requires the snan
> work to avoid breakage.
>
> This was built on top of pm215/target-arm.next to make it easier to
> test.
> The whole tree is
>
>   git://github.com/rth7680/qemu.git fpu-roundup

Whole series:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Also I ran Emilio's benchmarks:

  https://i.imgur.com/Lww65Nx.png

Looks OK.

>
> Changes since last:
>   - Use v5 instead of v3, since Alex was up to v4 with float-float.
>   - Incorporate feedback from pm215.
>   - Include float128 fix from Petr.
>   - Include further cleanups for default_nan and silence_nan.
>     The first of these was inspired by a comment from pm215;
>     the rest follow as logical extensions.
>
>
> r~
>
>
> Alex Benn=C3=A9e (4):
>   target/arm: convert conversion helpers to fpst/ahp_flag
>   target/arm: squash FZ16 behaviour for conversions
>   fpu/softfloat: Partial support for ARM Alternative half-precision
>   fpu/softfloat: re-factor float to float conversions
>
> Petr Tesarik (1):
>   fpu/softfloat: Fix conversion from uint64 to float128
>
> Richard Henderson (23):
>   fpu/softfloat: Merge NO_SIGNALING_NANS definitions
>   fpu/softfloat: Split floatXX_silence_nan from floatXX_maybe_silence_nan
>   fpu/softfloat: Move softfloat-specialize.h below FloatParts definition
>   fpu/softfloat: Canonicalize NaN fraction
>   fpu/softfloat: Introduce parts_is_snan_frac
>   fpu/softfloat: Replace float_class_dnan with parts_default_nan
>   fpu/softfloat: Replace float_class_msnan with parts_silence_nan
>   target/arm: Use floatX_silence_nan when we have already checked for SNaN
>   target/arm: Remove floatX_maybe_silence_nan from conversions
>   target/hppa: Remove floatX_maybe_silence_nan from conversions
>   target/m68k: Use floatX_silence_nan when we have already checked for SN=
aN
>   target/mips: Remove floatX_maybe_silence_nan from conversions
>   target/riscv: Remove floatX_maybe_silence_nan from conversions
>   target/s390x: Remove floatX_maybe_silence_nan from conversions
>   fpu/softfloat: Use float*_silence_nan in propagateFloat*NaN
>   fpu/softfloat: Remove floatX_maybe_silence_nan
>   fpu/softfloat: Specialize on snan_bit_is_one
>   fpu/softfloat: Make is_nan et al available to softfloat-specialize.h
>   fpu/softfloat: Pass FloatClass to pickNaN
>   fpu/softfloat: Pass FloatClass to pickNaNMulAdd
>   fpu/softfloat: Define floatN_default_nan in terms of parts_default_nan
>   fpu/softfloat: Clean up parts_default_nan
>   fpu/softfloat: Define floatN_silence_nan in terms of parts_silence_nan
>
>  fpu/softfloat-specialize.h    | 691 ++++++++++++++-------------------
>  include/fpu/softfloat-types.h |   1 +
>  include/fpu/softfloat.h       |  18 +-
>  target/arm/helper.h           |  10 +-
>  target/arm/translate.h        |  12 +
>  fpu/softfloat.c               | 708 ++++++++++++----------------------
>  target/arm/helper-a64.c       |   7 +-
>  target/arm/helper.c           | 114 +++---
>  target/arm/translate-a64.c    |  38 +-
>  target/arm/translate.c        |  74 +++-
>  target/hppa/cpu.c             |   1 -
>  target/hppa/op_helper.c       |   2 -
>  target/m68k/softfloat.c       |   3 +-
>  target/mips/msa_helper.c      |   4 -
>  target/mips/op_helper.c       |   2 -
>  target/ppc/fpu_helper.c       |   1 -
>  target/riscv/fpu_helper.c     |   6 +-
>  target/s390x/fpu_helper.c     |  12 +-
>  target/sh4/cpu.c              |   1 -
>  target/unicore32/cpu.c        |   2 -
>  20 files changed, 701 insertions(+), 1006 deletions(-)


--
Alex Benn=C3=A9e
