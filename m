Received: from eggs.gnu.org ([2001:4830:134:3::10]:60634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epDA1-0000wD-RX
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:13:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epDA0-0006MJ-Ru
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:13:13 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:38526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epDA0-0006LH-L1
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:13:12 -0500
Received: by mail-pl0-x244.google.com with SMTP id d4so4877103pll.5
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 05:13:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-16-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 13:12:51 +0000
Message-ID: <CAFEAcA-xH_SSR+EcRcauAb=eOrsqLDRoBWfSmt0nhyDWkMh+-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 15/67] target/arm: Implement SVE Integer
 Multiply-Add Group
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
>  target/arm/helper-sve.h    | 18 ++++++++++++++
>  target/arm/sve_helper.c    | 58 +++++++++++++++++++++++++++++++++++++++++++++-
>  target/arm/translate-sve.c | 31 +++++++++++++++++++++++++
>  target/arm/sve.decode      | 17 ++++++++++++++
>  4 files changed, 123 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
> index 11644125d1..b31d497f31 100644
> --- a/target/arm/helper-sve.h
> +++ b/target/arm/helper-sve.h
> @@ -345,6 +345,24 @@ DEF_HELPER_FLAGS_4(sve_neg_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(sve_neg_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(sve_neg_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>
> +DEF_HELPER_FLAGS_6(sve_mla_b, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_6(sve_mla_h, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_6(sve_mla_s, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_6(sve_mla_d, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, i32)
> +
> +DEF_HELPER_FLAGS_6(sve_mls_b, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_6(sve_mls_h, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_6(sve_mls_s, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_6(sve_mls_d, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, i32)
> +
>  DEF_HELPER_FLAGS_5(sve_and_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_5(sve_bic_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_5(sve_eor_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index e11823a727..4b08a38ce8 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -932,6 +932,62 @@ DO_ZPZI_D(sve_asrd_d, int64_t, DO_ASRD)
>  #undef DO_SHR
>  #undef DO_SHL
>  #undef DO_ASRD
> -
>  #undef DO_ZPZI
>  #undef DO_ZPZI_D

Deletion of blank line should be dropped or squashed into earlier patch.

Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
