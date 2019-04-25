Received: from eggs.gnu.org ([209.51.188.92]:35644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJeak-0000yI-AY
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:39:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJeaj-00057a-1Z
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:39:10 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hJeai-00056n-O0
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:39:08 -0400
Received: by mail-wm1-x341.google.com with SMTP id 26so3546448wmj.3
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:39:07 -0700 (PDT)
References: <20190408182748.1238-1-jan.bobek@gmail.com>
	<20190408182748.1238-2-jan.bobek@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190408182748.1238-2-jan.bobek@gmail.com>
Date: Thu, 25 Apr 2019 14:39:05 +0100
Message-ID: <874l6mw6fa.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH 1/5] risu_i386: move reginfo_t and
 related defines to risu_reginfo_i386.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Bobek <jan.bobek@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>


Jan Bobek <jan.bobek@gmail.com> writes:

> In order to build risu successfully for i386, we need files
> risu_reginfo_i386.{h,c}; this patch adds the former by extracting the
> relevant code from risu_i386.c.
>
> This patch is pure code motion; no functional changes were made.
>
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  risu_i386.c         | 23 +----------------------
>  risu_reginfo_i386.h | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+), 22 deletions(-)
>  create mode 100644 risu_reginfo_i386.h
>
> diff --git a/risu_i386.c b/risu_i386.c
> index 5e7e01d..6798a78 100644
> --- a/risu_i386.c
> +++ b/risu_i386.c
> @@ -14,28 +14,7 @@
>  #include <string.h>
>
>  #include "risu.h"
> -
> -/* This is the data structure we pass over the socket.
> - * It is a simplified and reduced subset of what can
> - * be obtained with a ucontext_t*
> - */
> -struct reginfo {
> -    uint32_t faulting_insn;
> -    gregset_t gregs;
> -};
> -
> -#ifndef REG_GS
> -/* Assume that either we get all these defines or none */
> -#define REG_GS 0
> -#define REG_FS 1
> -#define REG_ES 2
> -#define REG_DS 3
> -#define REG_ESP 7
> -#define REG_TRAPNO 12
> -#define REG_EIP 14
> -#define REG_EFL 16
> -#define REG_UESP 17
> -#endif
> +#include "risu_reginfo_i386.h"
>
>  struct reginfo master_ri, apprentice_ri;
>
> diff --git a/risu_reginfo_i386.h b/risu_reginfo_i386.h
> new file mode 100644
> index 0000000..5bba439
> --- /dev/null
> +++ b/risu_reginfo_i386.h
> @@ -0,0 +1,37 @@
> +/***********************************************************************=
********
> + * Copyright (c) 2010 Linaro Limited
> + * All rights reserved. This program and the accompanying materials
> + * are made available under the terms of the Eclipse Public License v1.0
> + * which accompanies this distribution, and is available at
> + * http://www.eclipse.org/legal/epl-v10.html
> + *
> + * Contributors:
> + *     Peter Maydell (Linaro) - initial implementation
> + ***********************************************************************=
*******/
> +
> +#ifndef RISU_REGINFO_I386_H
> +#define RISU_REGINFO_I386_H
> +
> +/* This is the data structure we pass over the socket.
> + * It is a simplified and reduced subset of what can
> + * be obtained with a ucontext_t*
> + */
> +struct reginfo {
> +    uint32_t faulting_insn;
> +    gregset_t gregs;
> +};
> +

The actual reg definitions can be dropped here (as rth does in his fixup
series). We can get them from ucontext.

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> +#ifndef REG_GS
> +/* Assume that either we get all these defines or none */
> +#   define REG_GS      0
> +#   define REG_FS      1
> +#   define REG_ES      2
> +#   define REG_DS      3
> +#   define REG_ESP     7
> +#   define REG_TRAPNO 12
> +#   define REG_EIP    14
> +#   define REG_EFL    16
> +#   define REG_UESP   17
> +#endif /* !defined(REG_GS) */
> +
> +#endif /* RISU_REGINFO_I386_H */


--
Alex Benn=C3=A9e
