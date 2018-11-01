Received: from eggs.gnu.org ([2001:4830:134:3::10]:45838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIH6a-0001bS-Om
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIH6Z-000275-Sq
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:50:04 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIH6Z-00022I-Cn
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:50:03 -0400
Received: by mail-ot1-x341.google.com with SMTP id e9so17026519oti.1
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 10:50:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181101173852.27257-1-laurent@vivier.eu>
References: <20181101173852.27257-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Nov 2018 17:49:41 +0000
Message-ID: <CAFEAcA9+gSUHW++EKtuqWL4ofWAKqO0H5JUGUoyyAhY7h24o0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] softfloat: don't execute ppc64 ISA 3.0B
 instruction if it is not supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <richard.henderson@linaro.org>

On 1 November 2018 at 17:38, Laurent Vivier <laurent@vivier.eu> wrote:
> commit 27ae5109a2 has introduced an assembly instruction only supported
> by ISA 3.0B and it fails to execute on previous versions of the POWER
> CPU (like PowerPC G5).
>
> This patch fixes that by checking the ISA level, and falls back to
> the default C function if the instruction is not supported.
>
> Fixes: 27ae5109a2ba8b6b679cce3e03e16570a34390a0
>        (softfloat: Specialize udiv_qrnnd for ppc64)
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  include/fpu/softfloat-macros.h | 39 ++++++++++++++++++++--------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
>
> diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
> index c86687fa5e..fe98b33df9 100644
> --- a/include/fpu/softfloat-macros.h
> +++ b/include/fpu/softfloat-macros.h
> @@ -78,6 +78,9 @@ this code that are retained.
>  /* Portions of this work are licensed under the terms of the GNU GPL,
>   * version 2 or later. See the COPYING file in the top-level directory.
>   */
> +#if defined(_ARCH_PPC64)
> +extern bool have_isa_3_00;
> +#endif

I was wondering where this bool came from. The answer is
that it's defined in tcg/ppc/tcg-target.inc.c. It's ok to
use it here because fpu/softfloat.c is only compiled if
CONFIG_TCG is true, so the tcg code will be present. The
other user of this include file is target/m68k/softfloat.c,
which also will only be compiled for a ppc host if CONFIG_TCG.

It's a little awkward to be borrowing this tcg/ppc internal
flag into the softfloat code, though.

thanks
-- PMM
