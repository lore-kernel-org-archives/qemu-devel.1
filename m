Received: from eggs.gnu.org ([2001:4830:134:3::10]:60217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1etxtC-0001HV-PJ
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:55:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1etxt8-0004PB-4N
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:55:30 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:51933)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1etxt7-0004Ob-Pa
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:55:26 -0500
Received: by mail-wm0-x243.google.com with SMTP id h21so206204wmd.1
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 07:55:25 -0800 (PST)
References: <20180308130626.12393-1-peter.maydell@linaro.org>
	<20180308130626.12393-3-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180308130626.12393-3-peter.maydell@linaro.org>
Date: Thu, 08 Mar 2018 15:55:23 +0000
Message-ID: <877eqmlfys.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/6] target/arm: Move definition of
 'host' cpu type into cpu.c
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

> Move the definition of the 'host' cpu type into cpu.c, where all the
> other CPU types are defined.  We can do this now we've decoupled it
> from the KVM-specific host feature probing.  This means we now create
> the type unconditionally (assuming we were built with KVM support at
> all), but if you try to use it without -enable-kvm this will end
> up in the "host cpu probe failed and KVM not enabled" path in
> arm_cpu_realizefn(), for an appropriate error message.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/cpu.c | 24 ++++++++++++++++++++++++
>  target/arm/kvm.c | 19 -------------------
>  2 files changed, 24 insertions(+), 19 deletions(-)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index abf9fb2160..1a58a2c094 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1858,6 +1858,26 @@ static void arm_cpu_class_init(ObjectClass *oc, vo=
id *data)
>  #endif
>  }
>
> +#ifdef CONFIG_KVM
> +static void arm_host_initfn(Object *obj)
> +{
> +    ARMCPU *cpu =3D ARM_CPU(obj);
> +
> +    kvm_arm_set_cpu_features_from_host(cpu);
> +}
> +
> +static const TypeInfo host_arm_cpu_type_info =3D {
> +    .name =3D TYPE_ARM_HOST_CPU,
> +#ifdef TARGET_AARCH64
> +    .parent =3D TYPE_AARCH64_CPU,
> +#else
> +    .parent =3D TYPE_ARM_CPU,
> +#endif
> +    .instance_init =3D arm_host_initfn,
> +};
> +
> +#endif
> +
>  static void cpu_register(const ARMCPUInfo *info)
>  {
>      TypeInfo type_info =3D {
> @@ -1902,6 +1922,10 @@ static void arm_cpu_register_types(void)
>          cpu_register(info);
>          info++;
>      }
> +
> +#ifdef CONFIG_KVM
> +    type_register_static(&host_arm_cpu_type_info);
> +#endif
>  }
>
>  type_init(arm_cpu_register_types)
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 1c0e57690a..ecc39ac295 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -152,23 +152,6 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
>      env->features =3D arm_host_cpu_features.features;
>  }
>
> -static void kvm_arm_host_cpu_initfn(Object *obj)
> -{
> -    ARMCPU *cpu =3D ARM_CPU(obj);
> -
> -    kvm_arm_set_cpu_features_from_host(cpu);
> -}
> -
> -static const TypeInfo host_arm_cpu_type_info =3D {
> -    .name =3D TYPE_ARM_HOST_CPU,
> -#ifdef TARGET_AARCH64
> -    .parent =3D TYPE_AARCH64_CPU,
> -#else
> -    .parent =3D TYPE_ARM_CPU,
> -#endif
> -    .instance_init =3D kvm_arm_host_cpu_initfn,
> -};
> -
>  int kvm_arch_init(MachineState *ms, KVMState *s)
>  {
>      /* For ARM interrupt delivery is always asynchronous,
> @@ -184,8 +167,6 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>
>      cap_has_mp_state =3D kvm_check_extension(s, KVM_CAP_MP_STATE);
>
> -    type_register_static(&host_arm_cpu_type_info);
> -
>      return 0;
>  }


--
Alex Benn=C3=A9e
