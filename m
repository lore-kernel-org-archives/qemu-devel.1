Received: from eggs.gnu.org ([2001:4830:134:3::10]:57883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIN8z-00045B-Qd
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 20:16:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIN8w-0006lJ-Ks
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 20:16:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gIN8w-0006kv-EH
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 20:16:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id f1-v6so157867wmg.1
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 17:16:54 -0700 (PDT)
References: <20181101215739.29788-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ae4bd424-a8bc-710e-1a70-00b319845f0a@redhat.com>
Date: Fri, 2 Nov 2018 01:16:50 +0100
MIME-Version: 1.0
In-Reply-To: <20181101215739.29788-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

On 1/11/18 22:57, Richard Henderson wrote:
> When populating id registers from kvm, on a host that doesn't support
> aarch32 mode at all, aa32_arm_div will not be supported either.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> "Tested" on an APM Mustang, which does support AArch32.  I'm not
> sure, off hand, which cpu(s) don't have it, and Alex didn't say
> in his bug report.  Tsk tsk.  ;-)

Packet provides access to cavium,thunder-88xx cpus which lack aa32.

> 
> 
> r~
> 
> ---
>   target/arm/cpu.h |  5 +++++
>   target/arm/cpu.c | 10 +++++++++-
>   2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 895f9909d8..4521ad5ae8 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -3300,6 +3300,11 @@ static inline bool isar_feature_aa64_fp16(const ARMISARegisters *id)
>       return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, FP) == 1;
>   }
>   
> +static inline bool isar_feature_aa64_a32(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, EL0) == 2;
> +}
> +
>   static inline bool isar_feature_aa64_sve(const ARMISARegisters *id)
>   {
>       return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, SVE) != 0;
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index e08a2d2d79..988d97d1f1 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -828,8 +828,16 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>            * include the various other features that V7VE implies.
>            * Presence of EL2 itself is ARM_FEATURE_EL2, and of the
>            * Security Extensions is ARM_FEATURE_EL3.
> +         *
> +         * V7VE requires ARM division.  However, there exist AArch64 cpus
> +         * without AArch32 support.  When KVM queries ID_ISAR0_EL1 on such
> +         * a host, the value is UNKNOWN.  Similarly, we cannot check
> +         * ID_AA64PFR0 without AArch64 support.  Check everything in order.
>            */
> -        assert(cpu_isar_feature(arm_div, cpu));
> +        if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)
> +            && cpu_isar_feature(aa64_a32, cpu)) {
> +            assert(cpu_isar_feature(arm_div, cpu));
> +        }
>           set_feature(env, ARM_FEATURE_LPAE);
>           set_feature(env, ARM_FEATURE_V7);
>       }
> 
