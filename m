Received: from eggs.gnu.org ([209.51.188.92]:32943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0ABM-0004vg-0q
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 14:20:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0ABL-0002so-0z
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 14:20:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h0ABK-0002YN-Op
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 14:20:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id l5so1278357wrw.6
	for <qemu-devel@nongnu.org>; Sat, 02 Mar 2019 11:20:13 -0800 (PST)
References: <1551467914-11209-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1551467914-11209-9-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a50c806a-698d-3ebd-824f-284e34af8476@redhat.com>
Date: Sat, 2 Mar 2019 20:20:11 +0100
MIME-Version: 1.0
In-Reply-To: <1551467914-11209-9-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 08/10] tests/tcg: target/mips: Add
 wrappers for some MIPS64R6 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net

On 3/1/19 8:18 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Add wrappers for some MIPS64R6 instructions.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  tests/tcg/mips/include/wrappers_mips64r6.h | 64 ++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 tests/tcg/mips/include/wrappers_mips64r6.h
> 
> diff --git a/tests/tcg/mips/include/wrappers_mips64r6.h b/tests/tcg/mips/include/wrappers_mips64r6.h
> new file mode 100644
> index 0000000..c9c34aa
> --- /dev/null
> +++ b/tests/tcg/mips/include/wrappers_mips64r6.h
> @@ -0,0 +1,64 @@
> +/*
> + *  Header file for wrappers around MIPS64R6 instructions assembler
> + *  invocations
> + *
> + *  Copyright (C) 2019  Wave Computing, Inc.
> + *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
> + *
> + *  This program is free software: you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation, either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
> + *
> + */
> +
> +#ifndef WRAPPERS_MIPS64R6_H
> +#define WRAPPERS_MIPS64R6_H
> +
> +
> +#define DO_MIPS64R6__RD__RS(suffix, mnemonic)                          \
> +static inline void do_mips64r6_##suffix(void *input, void *output)     \

'const void *input'

> +{                                                                      \
> +   __asm__ volatile (                                                  \
> +      "ld $t1, 0(%0)\n\t"                                              \
> +      #mnemonic " $t0, $t1\n\t"                                        \
> +      "sd $t0, 0(%1)\n\t"                                              \
> +      :                                                                \
> +      : "r" (input), "r" (output)                                      \
> +      : "t0", "t1", "memory"                                           \
> +   );                                                                  \
> +}
> +
> +DO_MIPS64R6__RD__RS(DCLO, dclo)
> +DO_MIPS64R6__RD__RS(DCLZ, dclz)
> +DO_MIPS64R6__RD__RS(BITSWAP, bitswap)
> +DO_MIPS64R6__RD__RS(DBITSWAP, dbitswap)
> +
> +
> +#define DO_MIPS64R6__RD__RS_RT(suffix, mnemonic)                       \
> +static inline void do_mips64r6_##suffix(void *input1, void *input2,    \

'const void *input1, const void *input2'

> +                                        void *output)                  \
> +{                                                                      \
> +   __asm__ volatile (                                                  \
> +      "ld $t1, 0(%0)\n\t"                                              \
> +      "ld $t2, 0(%1)\n\t"                                              \
> +      #mnemonic " $t0, $t1, $t2\n\t"                                   \
> +      "sd $t0, 0(%2)\n\t"                                              \
> +      :                                                                \
> +      : "r" (input1), "r" (input2), "r" (output)                       \
> +      : "t0", "t1", "memory"                                           \
> +   );                                                                  \
> +}
> +
> +DO_MIPS64R6__RD__RS_RT(DSLLV, dsllv)
> +
> +
> +#endif
> 
