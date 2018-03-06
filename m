Received: from eggs.gnu.org ([2001:4830:134:3::10]:45364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1etEKH-0000IE-Kv
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:16:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1etEKG-0003Kj-EY
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:16:25 -0500
Date: Tue, 6 Mar 2018 16:16:17 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180306161617.07459ef6@redhat.com>
In-Reply-To: <20180306125526.27838-5-peter.maydell@linaro.org>
References: <20180306125526.27838-1-peter.maydell@linaro.org>
	<20180306125526.27838-5-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/6] target/arm: Make 'any' CPU just an
 alias for 'max'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0?= =?UTF-8?B?aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, patches@linaro.org

On Tue,  6 Mar 2018 12:55:24 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> Now we have a working '-cpu max', the linux-user-only
> 'any' CPU is pretty much the same thing, so implement it
> that way.
> 
> For the moment we don't add any of the extra feature bits
> to the system-emulation "max", because we don't set the
> ID register bits we would need to to advertise those
> features as present.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.c   | 50 +++++++++++++++++++++++----------------------
>  target/arm/cpu64.c | 59 ++++++++++++++++++++++++++----------------------------
>  2 files changed, 54 insertions(+), 55 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index e46ddcc613..c8d3da2140 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -965,9 +965,17 @@ static ObjectClass *arm_cpu_class_by_name(const char *cpu_model)
>      ObjectClass *oc;
>      char *typename;
>      char **cpuname;
> +    const char *cpunamestr;
>  
>      cpuname = g_strsplit(cpu_model, ",", 1);
> -    typename = g_strdup_printf(ARM_CPU_TYPE_NAME("%s"), cpuname[0]);
> +    cpunamestr = cpuname[0];
> +#ifdef CONFIG_USER_ONLY
> +    /* For backwards compatibility usermode emulation allows "-cpu any",
> +     * which has the same semantics as "-cpu max".
> +     */
> +    cpunamestr = "max";
shouldn't it be
 if (!strcmp(cpuname[0], "any")) {
     cpunamestr = "max";
 }


> +#endif
> +    typename = g_strdup_printf(ARM_CPU_TYPE_NAME("%s"), cpunamestr);
>      oc = object_class_by_name(typename);
>      g_strfreev(cpuname);
>      g_free(typename);
> @@ -1711,29 +1719,23 @@ static void arm_max_initfn(Object *obj)
>          kvm_arm_set_cpu_features_from_host(cpu);
>      } else {
>          cortex_a15_initfn(obj);
> -        /* In future we might add feature bits here even if the
> -         * real-world A15 doesn't implement them.
> -         */
> -    }
> -}
> -#endif
> -
>  #ifdef CONFIG_USER_ONLY
> -static void arm_any_initfn(Object *obj)
> -{
> -    ARMCPU *cpu = ARM_CPU(obj);
> -    set_feature(&cpu->env, ARM_FEATURE_V8);
> -    set_feature(&cpu->env, ARM_FEATURE_VFP4);
> -    set_feature(&cpu->env, ARM_FEATURE_NEON);
> -    set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
> -    set_feature(&cpu->env, ARM_FEATURE_V8_AES);
> -    set_feature(&cpu->env, ARM_FEATURE_V8_SHA1);
> -    set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
> -    set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
> -    set_feature(&cpu->env, ARM_FEATURE_CRC);
> -    set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
> -    set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
> -    cpu->midr = 0xffffffff;
> +        /* We don't set these in system emulation mode for the moment,
> +         * since we don't correctly set the ID registers to advertise them,
> +         */
> +        set_feature(&cpu->env, ARM_FEATURE_V8);
> +        set_feature(&cpu->env, ARM_FEATURE_VFP4);
> +        set_feature(&cpu->env, ARM_FEATURE_NEON);
> +        set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
> +        set_feature(&cpu->env, ARM_FEATURE_V8_AES);
> +        set_feature(&cpu->env, ARM_FEATURE_V8_SHA1);
> +        set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
> +        set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
> +        set_feature(&cpu->env, ARM_FEATURE_CRC);
> +        set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
> +        set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
> +#endif
> +    }
>  }
>  #endif
>  
> @@ -1789,7 +1791,7 @@ static const ARMCPUInfo arm_cpus[] = {
>      { .name = "max",         .initfn = arm_max_initfn },
>  #endif
>  #ifdef CONFIG_USER_ONLY
> -    { .name = "any",         .initfn = arm_any_initfn },
> +    { .name = "any",         .initfn = arm_max_initfn },
Note,
 'any' will disappear from "-cpu help"
but that's probably fine, old users would still be able to use alias
and new ones won't even suspect about its existence and use 'max'.

[...]
