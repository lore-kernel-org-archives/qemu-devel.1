Received: from eggs.gnu.org ([209.51.188.92]:54067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr63I-0002Iw-Qa
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:06:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr63B-0006AB-HM
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:06:33 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40155)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr636-00066T-Sf
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:06:26 -0500
Received: by mail-ot1-x341.google.com with SMTP id s5so7626787oth.7
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 11:06:17 -0800 (PST)
MIME-Version: 1.0
References: <20190114011122.5995-1-richard.henderson@linaro.org>
	<20190114011122.5995-2-richard.henderson@linaro.org>
In-Reply-To: <20190114011122.5995-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Feb 2019 19:06:04 +0000
Message-ID: <CAFEAcA9Kj5fXB6fe_hJAGbqG0ftjh9+VrqQQEy4bEQ6iFB508A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 01/17] target/arm: Add MTE_ACTIVE to
 tb_flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Mon, 14 Jan 2019 at 01:11, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> When MTE is fully enabled, i.e. access to tags are enabled and
> tag checks affect the PE, then arrange to perform the check
> while stripping the TBI.
>
> The check is not yet implemented, just the plumbing to that point.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


> @@ -0,0 +1,32 @@
> +/*
> + * ARM v8.5-MemTag Operations
> + *
> + * Copyright (c) 2019 Linaro, Ltd.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.

Do you mean LGPL version 2.1 here, or GPL version 2?

> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "internals.h"
> +#include "exec/exec-all.h"
> +#include "exec/cpu_ldst.h"
> +#include "exec/helper-proto.h"
> +
> +
> +uint64_t HELPER(mte_check)(CPUARMState *env, uint64_t ptr)
> +{
> +    /* Only unchecked implemented so far.  */
> +    return sextract64(ptr, 0, 55);

Are you sure this is right? I think that unchecked accesses
should work the same as if MTE isn't active at all, ie
do all the stuff gen_top_byte_ignore() does. If you look
at the pseudocode for AArch64.MemSingle[]:
https://developer.arm.com/docs/ddi0596/b/shared-pseudocode-functions/aarch64-functionsmemory-pseudocode#AArch64.MemSingle.write.4

the address (hidden inside 'memaddrdesc' passed down to the
_Mem[] accessor isn't changed by any of the code guarded by
the "if HaveMTEExt()" conditional.

In fact both checked and unchecked accesses ought to do this to
get the vaddr to use from the input vaddr.

> +}
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index ee6f71c98f..0286507bae 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -339,7 +339,13 @@ static void gen_a64_set_pc(DisasContext *s, TCGv_i64 src)
>  static TCGv_i64 clean_data_tbi(DisasContext *s, TCGv_i64 addr)
>  {
>      TCGv_i64 clean = new_tmp_a64(s);
> -    gen_top_byte_ignore(s, clean, addr, s->tbid);
> +
> +    /* FIXME: SP+OFS is always unchecked.  */
> +    if (s->tbid && s->mte_active) {
> +        gen_helper_mte_check(clean, cpu_env, addr);
> +    } else {
> +        gen_top_byte_ignore(s, clean, addr, s->tbid);
> +    }
>      return clean;
>  }

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
