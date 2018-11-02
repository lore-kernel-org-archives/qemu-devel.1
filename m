Received: from eggs.gnu.org ([2001:4830:134:3::10]:60250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIW4n-0003u6-Ua
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 05:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIW4n-00018Y-A3
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 05:49:13 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIW4n-000189-3p
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 05:49:13 -0400
Received: by mail-oi1-x242.google.com with SMTP id f21-v6so1125549oig.1
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 02:49:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181101215739.29788-1-richard.henderson@linaro.org>
References: <20181101215739.29788-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Nov 2018 09:48:51 +0000
Message-ID: <CAFEAcA_HrcAfHaLW+hT0btN6C=GZv7VYWmhz3ri-QSL9ySZ0qg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: Conditionalize arm_div assert
 on aarch32 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 1 November 2018 at 21:57, Richard Henderson
<richard.henderson@linaro.org> wrote:
> When populating id registers from kvm, on a host that doesn't support
> aarch32 mode at all, aa32_arm_div will not be supported either.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>
> "Tested" on an APM Mustang, which does support AArch32.  I'm not
> sure, off hand, which cpu(s) don't have it, and Alex didn't say
> in his bug report.  Tsk tsk.  ;-)
>
>
> r~
>
> ---
>  target/arm/cpu.h |  5 +++++
>  target/arm/cpu.c | 10 +++++++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 895f9909d8..4521ad5ae8 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -3300,6 +3300,11 @@ static inline bool isar_feature_aa64_fp16(const ARMISARegisters *id)
>      return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, FP) == 1;
>  }
>
> +static inline bool isar_feature_aa64_a32(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, EL0) == 2;
> +}
> +

Doesn't the stuff in the Arm ARM's "Principles of the ID
scheme for fields in ID registers" about signed and unsigned
values for ID register fields strictly mean you want to be
testing (unsigned) >= 2 here rather than strict equality?

thanks
-- PMM
