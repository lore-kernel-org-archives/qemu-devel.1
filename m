Received: from eggs.gnu.org ([2001:4830:134:3::10]:37281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epBid-0006eJ-UX
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 06:40:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epBid-0005Kf-0H
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 06:40:51 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:42101)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epBic-0005I3-QR
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 06:40:50 -0500
Received: by mail-pf0-x241.google.com with SMTP id t15so3401017pfh.9
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 03:40:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-4-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 11:40:29 +0000
Message-ID: <CAFEAcA8h-Y8_zDL1mQuZTarMqWo9LwDgvgwEmpPbmYLfBvtRyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 03/67] target/arm: Add SVE
 decode skeleton
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
> Including only 4, as-yet unimplemented, instruction patterns
> so that the whole thing compiles.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 11 +++++++-
>  target/arm/translate-sve.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++
>  .gitignore                 |  1 +
>  target/arm/Makefile.objs   | 10 ++++++++
>  target/arm/sve.decode      | 45 +++++++++++++++++++++++++++++++++
>  5 files changed, 129 insertions(+), 1 deletion(-)
>  create mode 100644 target/arm/translate-sve.c
>  create mode 100644 target/arm/sve.decode
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index e0e7ebf68c..a50fef98af 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -12772,9 +12772,18 @@ static void disas_a64_insn(CPUARMState *env, DisasContext *s)
>      s->fp_access_checked = false;
>
>      switch (extract32(insn, 25, 4)) {
> -    case 0x0: case 0x1: case 0x2: case 0x3: /* UNALLOCATED */
> +    case 0x0: case 0x1: case 0x3: /* UNALLOCATED */
>          unallocated_encoding(s);
>          break;
> +    case 0x2:
> +        if (!arm_dc_feature(s, ARM_FEATURE_SVE)) {
> +            unallocated_encoding(s);
> +        } else if (!sve_access_check(s) || !fp_access_check(s)) {
> +            /* exception raised */
> +        } else if (!disas_sve(s, insn)) {
> +            unallocated_encoding(s);
> +        }
> +        break;

I realized while working through the rest of the series that this is
too early to do the sve_access_check() and fp_access_check(). Those
only apply to instructions which actually exist, so we mustn't
do the checks until after we've dealt with all the unallocated_encoding()
cases. I think you need to push them down inside disas_sve() somehow.
See also my comments on patch 8.

(We get this wrong for current AArch32 VFP and Neon, but correct
for all of AArch64.)

thanks
-- PMM
