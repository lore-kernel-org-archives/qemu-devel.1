Received: from eggs.gnu.org ([209.51.188.92]:43590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hHcb2-00074C-Ip
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hHcb1-00066v-IS
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:07:04 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:35347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hHcb1-00066H-Ak
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:07:03 -0400
Received: by mail-wm1-x32f.google.com with SMTP id y197so7714167wmd.0
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 16:07:03 -0700 (PDT)
References: <20190416083150.19649-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190416083150.19649-1-richard.henderson@linaro.org>
Date: Fri, 19 Apr 2019 23:07:00 +0000
Message-ID: <87zholfvcb.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] tcg: Fix launchpad 1824853
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

> This is a case where we generate more than 64k code for a mere 231
> guest instructions.

I would like to know more! Are these unrolled vector ops or something else?

> This hits some assertions within TCG that we're
> not overflowing the uint16_t that we use for representing our
> unwind info.
>
> Fix this by returning an error indication, rather than asserting.
> This lets us try again from tb_gen_code with a lower max_insns.
>
> This should resolve the problem for x86 as a host.  There are other
> failure modes wrt out-of-range relocations that might affect the
> RISC hosts.  I'm going to leave those for a different patch set.
>
>
> r~
>
>
> Richard Henderson (2):
>   tcg: Hoist max_insns computation to tb_gen_code
>   tcg: Restart after TB code generation overflow
>
>  include/exec/exec-all.h       |  4 +--
>  include/exec/translator.h     |  3 +-
>  accel/tcg/translate-all.c     | 54 +++++++++++++++++++++++++++++------
>  accel/tcg/translator.c        | 15 ++--------
>  target/alpha/translate.c      |  4 +--
>  target/arm/translate.c        |  4 +--
>  target/cris/translate.c       | 10 +------
>  target/hppa/translate.c       |  5 ++--
>  target/i386/translate.c       |  4 +--
>  target/lm32/translate.c       | 10 +------
>  target/m68k/translate.c       |  4 +--
>  target/microblaze/translate.c | 10 +------
>  target/mips/translate.c       |  4 +--
>  target/moxie/translate.c      | 11 ++-----
>  target/nios2/translate.c      | 14 ++-------
>  target/openrisc/translate.c   |  4 +--
>  target/ppc/translate.c        |  4 +--
>  target/riscv/translate.c      |  4 +--
>  target/s390x/translate.c      |  4 +--
>  target/sh4/translate.c        |  4 +--
>  target/sparc/translate.c      |  4 +--
>  target/tilegx/translate.c     | 12 +-------
>  target/tricore/translate.c    | 16 ++---------
>  target/unicore32/translate.c  | 10 +------
>  target/xtensa/translate.c     |  4 +--
>  tcg/tcg.c                     |  4 +++
>  26 files changed, 93 insertions(+), 133 deletions(-)


--
Alex Benn=C3=A9e
