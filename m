Received: from eggs.gnu.org ([2001:4830:134:3::10]:51461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eovlP-0000wc-M7
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 13:38:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eovlO-0002Nx-M1
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 13:38:39 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:36155)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eovlO-0002M1-Fz
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 13:38:38 -0500
Received: by mail-ot0-x241.google.com with SMTP id b15so5522072otf.3
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 10:38:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-7-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 18:38:17 +0000
Message-ID: <CAFEAcA9_pMkSAftSO2y+CXy37fK-NcNypZ-cYzxwAYYq1R+qEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 06/67] target/arm: Implement
 SVE predicate test
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

On 17 February 2018 at 18:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    | 21 +++++++++++++
>  target/arm/helper.h        |  1 +
>  target/arm/sve_helper.c    | 77 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 62 +++++++++++++++++++++++++++++++++++++
>  target/arm/Makefile.objs   |  2 +-
>  target/arm/sve.decode      |  5 +++
>  6 files changed, 167 insertions(+), 1 deletion(-)
>  create mode 100644 target/arm/helper-sve.h
>  create mode 100644 target/arm/sve_helper.c
>
> diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
> new file mode 100644
> index 0000000000..b6e91539ae
> --- /dev/null
> +++ b/target/arm/helper-sve.h
> @@ -0,0 +1,21 @@
> +/*
> + *  AArch64 SVE specific helper definitions
> + *
> + *  Copyright (c) 2018 Linaro, Ltd
> + *

> +/*
> + *  ARM SVE Operations
> + *
> + *  Copyright (c) 2018 Linaro

I think we prefer "Linaro Limited"  (cf https://wiki.linaro.org/Copyright)


> diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
> index 9934cf1d4d..452ac6f453 100644
> --- a/target/arm/Makefile.objs
> +++ b/target/arm/Makefile.objs
> @@ -19,4 +19,4 @@ target/arm/decode-sve.inc.c: $(SRC_PATH)/target/arm/sve.decode $(DECODETREE)
>           "GEN", $(TARGET_DIR)$@)
>
>  target/arm/translate-sve.o: target/arm/decode-sve.inc.c
> -obj-$(TARGET_AARCH64) += translate-sve.o
> +obj-$(TARGET_AARCH64) += translate-sve.o sve_helper.o
> diff --git a/target/arm/sve.decode b/target/arm/sve.decode
> index 0c6a7ba34d..7efaa8fe8e 100644
> --- a/target/arm/sve.decode
> +++ b/target/arm/sve.decode
> @@ -56,6 +56,11 @@ ORR_zzz              00000100 01 1 ..... 001 100 ..... .....         @rd_rn_rm_e0
>  EOR_zzz                00000100 10 1 ..... 001 100 ..... .....         @rd_rn_rm_e0
>  BIC_zzz                00000100 11 1 ..... 001 100 ..... .....         @rd_rn_rm_e0
>
> +### SVE Predicate Misc Group
> +
> +# SVE predicate test
> +PTEST          00100101 01010000 11 pg:4 0 rn:4 00000

Shouldn't this be "0 1 01000011" instead of "01010000 11"
(just a spacing change)? Bits 22 and 23 are op and S, so spacing
it like that makes it easier to compare against the encoding diagram.


Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
