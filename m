Received: from eggs.gnu.org ([2001:4830:134:3::10]:36158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gRIFJ-00012e-EY
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 09:52:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gRIFE-0003dF-Le
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 09:52:21 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gRIFD-0003cG-Cr
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 09:52:15 -0500
Received: by mail-wr1-x444.google.com with SMTP id t27so11259535wra.6
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 06:52:15 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-24-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025172057.20414-24-cota@braap.org>
Date: Mon, 26 Nov 2018 14:52:12 +0000
Message-ID: <87lg5f51sz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 23/48] translator: add plugin_insn argument
 to translate_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>


Emilio G. Cota <cota@braap.org> writes:

> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/exec/translator.h   | 4 +++-
>  accel/tcg/translator.c      | 4 ++--
>  target/alpha/translate.c    | 3 ++-
>  target/arm/translate-a64.c  | 3 ++-
>  target/arm/translate.c      | 6 ++++--
>  target/hppa/translate.c     | 3 ++-
>  target/i386/translate.c     | 3 ++-
>  target/m68k/translate.c     | 3 ++-
>  target/mips/translate.c     | 3 ++-
>  target/openrisc/translate.c | 3 ++-
>  target/ppc/translate.c      | 3 ++-
>  target/riscv/translate.c    | 3 ++-
>  target/s390x/translate.c    | 3 ++-
>  target/sh4/translate.c      | 3 ++-
>  target/sparc/translate.c    | 3 ++-
>  target/xtensa/translate.c   | 3 ++-
>  16 files changed, 35 insertions(+), 18 deletions(-)
>
> diff --git a/include/exec/translator.h b/include/exec/translator.h
> index 71e7b2c347..a28147b3dd 100644
> --- a/include/exec/translator.h
> +++ b/include/exec/translator.h
> @@ -20,6 +20,7 @@
>
>
>  #include "exec/exec-all.h"
> +#include "qemu/plugin.h"
>  #include "tcg/tcg.h"
>
>
> @@ -112,7 +113,8 @@ typedef struct TranslatorOps {
>      void (*insn_start)(DisasContextBase *db, CPUState *cpu);
>      bool (*breakpoint_check)(DisasContextBase *db, CPUState *cpu,
>                               const CPUBreakpoint *bp);
> -    void (*translate_insn)(DisasContextBase *db, CPUState *cpu);
> +    void (*translate_insn)(DisasContextBase *db, CPUState *cpu,
> +                           struct qemu_plugin_insn *plugin_insn);

I'm not convinced this is the best way to go about it. We end up having
to sprinkle the plugin calls into each decoder rather than keeping all
the infrastructure in the common main loop. However the common loop will
need to know the total number of bytes decoded so we could change the
declaration to:

  int (*translate_insn)(DisasContextBase *db, CPUState *cpu);

and return the number of bytes decoded. It would mean a minor
inefficiency in having to re-read the instruction bytes into a buffer in
preparation for passing to the plugin but it would all at least be in
one place.

--
Alex Benn=C3=A9e
