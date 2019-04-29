Received: from eggs.gnu.org ([209.51.188.92]:60181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL6O4-0003fg-TQ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:32:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL6O3-0005fm-Rs
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:32:04 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39991)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL6O3-0005fQ-Lv
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:32:03 -0400
Received: by mail-ot1-x344.google.com with SMTP id w6so8580582otl.7
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 06:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-3-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 14:31:51 +0100
Message-ID: <CAFEAcA_KNSzerED7aLVeieVC4W15zfu0oKfV8PY0b46Db3xJCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 02/36] tcg: Split out
 target/arch/cpu-param.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 28 Mar 2019 at 23:40, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> For all targets, into this new file move TARGET_LONG_BITS,
> TARGET_PAGE_BITS, TARGET_PHYS_ADDR_SPACE_BITS,
> TARGET_VIRT_ADDR_SPACE_BITS, and NB_MMU_MODES.
>
> Include this new file from exec/cpu-defs.h.
>
> This now removes the somewhat odd requirement that target/arch/cpu.h
> defines TARGET_LONG_BITS before including exec/cpu-defs.h, so push the
> bulk of the includes within target/arch/cpu.h to the top.
>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


Your new headers all need the standard copyright/license
header comment and multiple-include guard.
> diff --git a/target/xtensa/cpu-param.h b/target/xtensa/cpu-param.h
> new file mode 100644
> index 0000000000..000e6026c0
> --- /dev/null
> +++ b/target/xtensa/cpu-param.h
> @@ -0,0 +1,9 @@
> +#define TARGET_LONG_BITS 32
> +#define TARGET_PAGE_BITS 12
> +#define TARGET_PHYS_ADDR_SPACE_BITS 32
> +#ifdef CONFIG_USER_ONLY
> +#define TARGET_VIRT_ADDR_SPACE_BITS 30
> +#else
> +#define TARGET_VIRT_ADDR_SPACE_BITS 32
> +#endif
> +#define NB_MMU_MODES 4
> diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
> index 4d8152682f..93440357b0 100644
> --- a/target/xtensa/cpu.h
> +++ b/target/xtensa/cpu.h
> @@ -28,28 +28,17 @@
>  #ifndef XTENSA_CPU_H
>  #define XTENSA_CPU_H
>
> -#define ALIGNED_ONLY
> -#define TARGET_LONG_BITS 32
> -
> -/* Xtensa processors have a weak memory model */
> -#define TCG_GUEST_DEFAULT_MO      (0)
> -
> -#define CPUArchState struct CPUXtensaState
> -
>  #include "qemu-common.h"
>  #include "cpu-qom.h"
>  #include "exec/cpu-defs.h"
>  #include "xtensa-isa.h"
>
> -#define NB_MMU_MODES 4
> +#define ALIGNED_ONLY

ALIGNED_ONLY is a config thing that tcg.h needs to see -- if
we define it this low in the cpu.h file it seems a bit fragile
whether or not tcg.h will get included by something else
before we get to the definition... (This probably applies
to a few of the other cpu.h files too.)

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
