Received: from eggs.gnu.org ([2001:4830:134:3::10]:44989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gMJU5-0003Lv-Pt
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:11:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gMJU2-0003C7-Lx
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:11:01 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:39309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gMJU1-00032T-Fh
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:10:57 -0500
Received: by mail-wr1-f50.google.com with SMTP id b13so10899469wrx.6
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 13:10:53 -0800 (PST)
From: Laurent Vivier <lvivier@redhat.com>
References: <20180629145347.652-1-peter.maydell@linaro.org>
	<20180629145347.652-41-peter.maydell@linaro.org>
Message-ID: <e8d62bcd-f8a9-2a6a-7765-0cf69cc8c1b5@redhat.com>
Date: Mon, 12 Nov 2018 22:10:49 +0100
MIME-Version: 1.0
In-Reply-To: <20180629145347.652-41-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 40/55] target/arm: Enable SVE for
 aarch64-linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 29/06/2018 16:53, Peter Maydell wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> Enable ARM_FEATURE_SVE for the generic "max" cpu.
> 
> Tested-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-id: 20180627043328.11531-35-richard.henderson@linaro.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/elfload.c | 1 +
>  target/arm/cpu.c     | 7 +++++++
>  target/arm/cpu64.c   | 1 +
>  3 files changed, 9 insertions(+)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 13bc78d0c86..d1231ad07a3 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -584,6 +584,7 @@ static uint32_t get_elf_hwcap(void)
>      GET_FEATURE(ARM_FEATURE_V8_ATOMICS, ARM_HWCAP_A64_ATOMICS);
>      GET_FEATURE(ARM_FEATURE_V8_RDM, ARM_HWCAP_A64_ASIMDRDM);
>      GET_FEATURE(ARM_FEATURE_V8_FCMA, ARM_HWCAP_A64_FCMA);
> +    GET_FEATURE(ARM_FEATURE_SVE, ARM_HWCAP_A64_SVE);
>  #undef GET_FEATURE
>  
>      return hwcaps;
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 2ae4fffafb9..6dcc552e143 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -164,6 +164,13 @@ static void arm_cpu_reset(CPUState *s)
>          env->cp15.sctlr_el[1] |= SCTLR_UCT | SCTLR_UCI | SCTLR_DZE;
>          /* and to the FP/Neon instructions */
>          env->cp15.cpacr_el1 = deposit64(env->cp15.cpacr_el1, 20, 2, 3);
> +        /* and to the SVE instructions */
> +        env->cp15.cpacr_el1 = deposit64(env->cp15.cpacr_el1, 16, 2, 3);
> +        env->cp15.cptr_el[3] |= CPTR_EZ;
> +        /* with maximum vector length */
> +        env->vfp.zcr_el[1] = ARM_MAX_VQ - 1;
> +        env->vfp.zcr_el[2] = ARM_MAX_VQ - 1;
> +        env->vfp.zcr_el[3] = ARM_MAX_VQ - 1;
>  #else
>          /* Reset into the highest available EL */
>          if (arm_feature(env, ARM_FEATURE_EL3)) {
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index c50dcd4077d..0360d7efc5e 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -252,6 +252,7 @@ static void aarch64_max_initfn(Object *obj)
>          set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
>          set_feature(&cpu->env, ARM_FEATURE_V8_FP16);
>          set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
> +        set_feature(&cpu->env, ARM_FEATURE_SVE);
>          /* For usermode -cpu max we can use a larger and more efficient DCZ
>           * blocksize since we don't have to follow what the hardware does.
>           */
> 

Running some tests for my pull request, I've found this commit breaks
ltp-full-20180515 sigaltstack01 tests with ubuntu arm64/trusty.

sigaltstack01  274  TBROK  :  tst_sig.c:233: unexpected signal
SIGIOT/SIGABRT(6) received (pid = 15241).
*** Error in `/opt/ltp/testcases/bin/sigaltstack01': free(): invalid
pointer: 0x000000000042a010 ***

Thanks,
Laurent
