Received: from eggs.gnu.org ([2001:4830:134:3::10]:48390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e36od-00045Z-8S
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 16:44:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e36oY-0000dH-CU
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 16:44:19 -0400
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:49951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e36oY-0000aQ-5N
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 16:44:14 -0400
Received: by mail-pf0-x235.google.com with SMTP id l188so11264918pfc.6
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 13:44:11 -0700 (PDT)
References: <20171013162438.32458-1-alex.bennee@linaro.org>
	<20171013162438.32458-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <585e84d8-90be-2e76-cc60-db0baad1d511@linaro.org>
Date: Fri, 13 Oct 2017 13:44:07 -0700
MIME-Version: 1.0
In-Reply-To: <20171013162438.32458-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 02/30] arm: introduce ARM_V8_FP16
 feature bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 10/13/2017 09:24 AM, Alex Bennée wrote:
> ---
>  target/arm/cpu.h   | 1 +
>  target/arm/cpu64.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 89d49cdcb2..3a0f27c782 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1340,6 +1340,7 @@ enum arm_features {
>      ARM_FEATURE_VBAR, /* has cp15 VBAR */
>      ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
>      ARM_FEATURE_JAZELLE, /* has (trivial) Jazelle implementation */
> +    ARM_FEATURE_V8_FP16, /* implements v8.2 half-precision float */
>  };
>  
>  static inline int arm_feature(CPUARMState *env, int feature)
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 670c07ab6e..973614dfc6 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -226,6 +226,7 @@ static void aarch64_any_initfn(Object *obj)
>      set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
>      set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
>      set_feature(&cpu->env, ARM_FEATURE_CRC);
> +    set_feature(&cpu->env, ARM_FEATURE_V8_FP16);
>      cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
>      cpu->dcz_blocksize = 7; /*  512 bytes */
>  }
> 

Need to update linux-user/elfload.c, get_elf_hwcap as well (HWCAP_ASIMDHP).
I suppose that will be a separate patch, since we're missing 8 bits from
current linux/arch/arm64/include/uapi/asm/hwcap.h.

... and we probably need to report a kernel arm32 bug that there is no
equivalent bit defined there.

Anyway, as far as this goes,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
