Received: from eggs.gnu.org ([2001:4830:134:3::10]:55613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eu0kb-0004vk-Rf
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eu0kX-0000DP-VN
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:58:49 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:43434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eu0kX-0000Cr-LM
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:58:45 -0500
Received: by mail-wr0-x242.google.com with SMTP id a63so3120361wrc.10
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 10:58:45 -0800 (PST)
References: <20180308130626.12393-1-peter.maydell@linaro.org>
	<20180308130626.12393-4-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180308130626.12393-4-peter.maydell@linaro.org>
Date: Thu, 08 Mar 2018 18:58:43 +0000
Message-ID: <876066l7h8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/6] target/arm: Add "-cpu max" support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Igor Mammedov <imammedo@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Add support for "-cpu max" for ARM guests. This CPU type behaves
> like "-cpu host" when KVM is enabled, and like a system CPU with
> the maximum possible feature set otherwise. (Note that this means
> it won't be migratable across versions, as we will likely add
> features to it in future.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/cpu-qom.h |  2 ++
>  target/arm/cpu.c     | 24 ++++++++++++++++++++++++
>  target/arm/cpu64.c   | 21 +++++++++++++++++++++
>  3 files changed, 47 insertions(+)
>
> diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
> index a42495bac9..d135ff8e06 100644
> --- a/target/arm/cpu-qom.h
> +++ b/target/arm/cpu-qom.h
> @@ -33,6 +33,8 @@ struct arm_boot_info;
>  #define ARM_CPU_GET_CLASS(obj) \
>      OBJECT_GET_CLASS(ARMCPUClass, (obj), TYPE_ARM_CPU)
>
> +#define TYPE_ARM_MAX_CPU "max-" TYPE_ARM_CPU
> +
>  /**
>   * ARMCPUClass:
>   * @parent_realize: The parent class' realize handler.
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 1a58a2c094..e46ddcc613 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1697,6 +1697,27 @@ static void pxa270c5_initfn(Object *obj)
>      cpu->reset_sctlr =3D 0x00000078;
>  }
>
> +#ifndef TARGET_AARCH64
> +/* -cpu max: if KVM is enabled, like -cpu host (best possible with this =
host);
> + * otherwise, a CPU with as many features enabled as our emulation suppo=
rts.
> + * The version of '-cpu max' for qemu-system-aarch64 is defined in cpu64=
.c;
> + * this only needs to handle 32 bits.
> + */
> +static void arm_max_initfn(Object *obj)
> +{
> +    ARMCPU *cpu =3D ARM_CPU(obj);
> +
> +    if (kvm_enabled()) {
> +        kvm_arm_set_cpu_features_from_host(cpu);
> +    } else {
> +        cortex_a15_initfn(obj);
> +        /* In future we might add feature bits here even if the
> +         * real-world A15 doesn't implement them.
> +         */
> +    }
> +}
> +#endif
> +
>  #ifdef CONFIG_USER_ONLY
>  static void arm_any_initfn(Object *obj)
>  {
> @@ -1764,6 +1785,9 @@ static const ARMCPUInfo arm_cpus[] =3D {
>      { .name =3D "pxa270-b1",   .initfn =3D pxa270b1_initfn },
>      { .name =3D "pxa270-c0",   .initfn =3D pxa270c0_initfn },
>      { .name =3D "pxa270-c5",   .initfn =3D pxa270c5_initfn },
> +#ifndef TARGET_AARCH64
> +    { .name =3D "max",         .initfn =3D arm_max_initfn },
> +#endif
>  #ifdef CONFIG_USER_ONLY
>      { .name =3D "any",         .initfn =3D arm_any_initfn },
>  #endif
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 4228713b19..9042d3dfd1 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -28,6 +28,7 @@
>  #include "hw/arm/arm.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/kvm.h"
> +#include "kvm_arm.h"
>
>  static inline void set_feature(CPUARMState *env, int feature)
>  {
> @@ -212,6 +213,25 @@ static void aarch64_a53_initfn(Object *obj)
>      define_arm_cp_regs(cpu, cortex_a57_a53_cp_reginfo);
>  }
>
> +/* -cpu max: if KVM is enabled, like -cpu host (best possible with this =
host);
> + * otherwise, a CPU with as many features enabled as our emulation suppo=
rts.
> + * The version of '-cpu max' for qemu-system-arm is defined in cpu.c;
> + * this only needs to handle 64 bits.
> + */
> +static void aarch64_max_initfn(Object *obj)
> +{
> +    ARMCPU *cpu =3D ARM_CPU(obj);
> +
> +    if (kvm_enabled()) {
> +        kvm_arm_set_cpu_features_from_host(cpu);
> +    } else {
> +        aarch64_a57_initfn(obj);
> +        /* In future we might add feature bits here even if the
> +         * real-world A57 doesn't implement them.
> +         */
> +    }
> +}
> +
>  #ifdef CONFIG_USER_ONLY
>  static void aarch64_any_initfn(Object *obj)
>  {
> @@ -247,6 +267,7 @@ typedef struct ARMCPUInfo {
>  static const ARMCPUInfo aarch64_cpus[] =3D {
>      { .name =3D "cortex-a57",         .initfn =3D aarch64_a57_initfn },
>      { .name =3D "cortex-a53",         .initfn =3D aarch64_a53_initfn },
> +    { .name =3D "max",                .initfn =3D aarch64_max_initfn },
>  #ifdef CONFIG_USER_ONLY
>      { .name =3D "any",         .initfn =3D aarch64_any_initfn },
>  #endif


--
Alex Benn=C3=A9e
