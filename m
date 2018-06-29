Received: from eggs.gnu.org ([2001:4830:134:3::10]:48789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYhoa-0000m5-Pl
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 21:03:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYhoX-0000NQ-M6
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 21:03:08 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYhoX-0000N0-Fn
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 21:03:05 -0400
Received: by mail-qk0-x243.google.com with SMTP id b66-v6so4101518qkj.1
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 18:03:05 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180629001538.11415-1-richard.henderson@linaro.org>
	<20180629001538.11415-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3c8d497a-98bf-732c-980f-f581deca0ce5@amsat.org>
Date: Thu, 28 Jun 2018 22:03:00 -0300
MIME-Version: 1.0
In-Reply-To: <20180629001538.11415-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/6] target/arm: Set ISAR bits for -cpu max
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 06/28/2018 09:15 PM, Richard Henderson wrote:
> For the supported extensions, fill in the appropriate bits in
> ID_ISAR5, ID_ISAR6, ID_AA64ISAR0, ID_AA64ISAR1.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.c   | 24 +++++++++++++++++-------
>  target/arm/cpu64.c | 36 ++++++++++++++++++++++++++++--------
>  2 files changed, 45 insertions(+), 15 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index de1a07a9f1..943c589445 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1795,19 +1795,29 @@ static void arm_max_initfn(Object *obj)
>          kvm_arm_set_cpu_features_from_host(cpu);
>      } else {
>          cortex_a15_initfn(obj);
> +
> +        set_feature(&cpu->env, ARM_FEATURE_V8_AES);
> +        cpu->id_isar5 = deposit32(cpu->id_isar5, 4, 4, 2);
> +        set_feature(&cpu->env, ARM_FEATURE_V8_SHA1);
> +        cpu->id_isar5 = deposit32(cpu->id_isar5, 8, 4, 1);
> +        set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
> +        cpu->id_isar5 = deposit32(cpu->id_isar5, 12, 4, 1);
> +        set_feature(&cpu->env, ARM_FEATURE_CRC);
> +        cpu->id_isar5 = deposit32(cpu->id_isar5, 16, 4, 1);
> +        set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
> +        cpu->id_isar5 = deposit32(cpu->id_isar5, 24, 4, 1);
> +        set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
> +        cpu->id_isar5 = deposit32(cpu->id_isar5, 28, 4, 1);
> +
> +        set_feature(&cpu->env, ARM_FEATURE_V8_DOTPROD);
> +        cpu->id_isar6 = deposit32(cpu->id_isar6, 4, 4, 1);

Since I don't have ARM_FEATURE_V8_DOTPROD, I now realize this series
goes on top of your "target/arm SVE patches" v6:
http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg07698.html

> +
>  #ifdef CONFIG_USER_ONLY
>          /* We don't set these in system emulation mode for the moment,
>           * since we don't correctly set the ID registers to advertise them,
>           */
>          set_feature(&cpu->env, ARM_FEATURE_V8);
> -        set_feature(&cpu->env, ARM_FEATURE_V8_AES);
> -        set_feature(&cpu->env, ARM_FEATURE_V8_SHA1);
> -        set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
>          set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
> -        set_feature(&cpu->env, ARM_FEATURE_CRC);
> -        set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
> -        set_feature(&cpu->env, ARM_FEATURE_V8_DOTPROD);
> -        set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
>  #endif
>      }
>  }
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index d0581d59d8..b24fee45e3 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -230,6 +230,34 @@ static void aarch64_max_initfn(Object *obj)
>          kvm_arm_set_cpu_features_from_host(cpu);
>      } else {
>          aarch64_a57_initfn(obj);
> +
> +        set_feature(&cpu->env, ARM_FEATURE_V8_SHA512);
> +        cpu->id_aa64isar0 = deposit64(cpu->id_aa64isar0, 12, 4, 2);
> +
> +        set_feature(&cpu->env, ARM_FEATURE_V8_ATOMICS);
> +        cpu->id_aa64isar0 = deposit64(cpu->id_aa64isar0, 20, 4, 2);
> +
> +        set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
> +        cpu->id_aa64isar0 = deposit64(cpu->id_aa64isar0, 28, 4, 1);
> +        cpu->id_isar5 = deposit32(cpu->id_isar5, 24, 4, 1);
> +
> +        set_feature(&cpu->env, ARM_FEATURE_V8_SHA3);
> +        cpu->id_aa64isar0 = deposit64(cpu->id_aa64isar0, 32, 4, 1);
> +
> +        set_feature(&cpu->env, ARM_FEATURE_V8_SM3);
> +        cpu->id_aa64isar0 = deposit64(cpu->id_aa64isar0, 36, 4, 1);
> +
> +        set_feature(&cpu->env, ARM_FEATURE_V8_SM4);
> +        cpu->id_aa64isar0 = deposit64(cpu->id_aa64isar0, 40, 4, 1);
> +
> +        set_feature(&cpu->env, ARM_FEATURE_V8_DOTPROD);
> +        cpu->id_aa64isar0 = deposit64(cpu->id_aa64isar0, 44, 4, 1);
> +        cpu->id_isar6 = deposit32(cpu->id_isar6, 4, 4, 1);
> +
> +        set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
> +        cpu->id_aa64isar1 = deposit64(cpu->id_aa64isar1, 16, 4, 1);
> +        cpu->id_isar5 = deposit32(cpu->id_isar5, 28, 4, 1);
> +
>  #ifdef CONFIG_USER_ONLY
>          /* We don't set these in system emulation mode for the moment,
>           * since we don't correctly set the ID registers to advertise them,
> @@ -237,15 +265,7 @@ static void aarch64_max_initfn(Object *obj)
>           * whereas the architecture requires them to be present in both if
>           * present in either.
>           */
> -        set_feature(&cpu->env, ARM_FEATURE_V8_SHA512);
> -        set_feature(&cpu->env, ARM_FEATURE_V8_SHA3);
> -        set_feature(&cpu->env, ARM_FEATURE_V8_SM3);
> -        set_feature(&cpu->env, ARM_FEATURE_V8_SM4);
> -        set_feature(&cpu->env, ARM_FEATURE_V8_ATOMICS);
> -        set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
> -        set_feature(&cpu->env, ARM_FEATURE_V8_DOTPROD);
>          set_feature(&cpu->env, ARM_FEATURE_V8_FP16);
> -        set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
>          set_feature(&cpu->env, ARM_FEATURE_SVE);
>          /* For usermode -cpu max we can use a larger and more efficient DCZ
>           * blocksize since we don't have to follow what the hardware does.
> 
