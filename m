Received: from eggs.gnu.org ([2001:4830:134:3::10]:53898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gWiJt-0000c8-99
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 08:43:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gWiJs-0003OR-AU
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 08:43:29 -0500
Date: Tue, 11 Dec 2018 14:43:13 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181211144313.12befbbb@redhat.com>
In-Reply-To: <20181204142023.15982-17-marcandre.lureau@redhat.com>
References: <20181204142023.15982-1-marcandre.lureau@redhat.com>
	<20181204142023.15982-17-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v5 16/19] RFC: arm: replace
 instance_post_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "open
	list:ARM" <qemu-arm@nongnu.org>, ehabkost@redhat.com, Andrew Jones <drjones@redhat.com>

On Tue,  4 Dec 2018 18:20:20 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Replace arm_cpu_post_init() instance callback by calling it from leaf
> classes, to avoid potential ordering issue with other post_init callbacks.
>=20
> Note: this patch is no longer needed in this series, since the
> compat-props interface approach was abandoned.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
Current call chain is
  aarch64_a57_initfn()
  arm_cpu_post_init()
  device_post_init()

so no compats nor globals influence arm_cpu_post_init() flow,
so it's save to squash it in initfn.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
=20
> ---
>  target/arm/cpu.h   |  2 ++
>  target/arm/cpu.c   | 15 ++++++++++++---
>  target/arm/cpu64.c | 11 ++++++++++-
>  3 files changed, 24 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 2a73fed9a0..84fba2b24b 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -884,6 +884,8 @@ static inline ARMCPU *arm_env_get_cpu(CPUARMState *en=
v)
>      return container_of(env, ARMCPU, env);
>  }
> =20
> +void arm_cpu_post_init(Object *obj);
> +
>  uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz);
> =20
>  #define ENV_GET_CPU(e) CPU(arm_env_get_cpu(e))
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 60411f6bfe..8a4aae7438 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -734,7 +734,7 @@ static Property arm_cpu_pmsav7_dregion_property =3D
>  static Property arm_cpu_initsvtor_property =3D
>              DEFINE_PROP_UINT32("init-svtor", ARMCPU, init_svtor, 0);
> =20
> -static void arm_cpu_post_init(Object *obj)
> +void arm_cpu_post_init(Object *obj)
>  {
>      ARMCPU *cpu =3D ARM_CPU(obj);
> =20
> @@ -2094,6 +2094,7 @@ static void arm_host_initfn(Object *obj)
>      ARMCPU *cpu =3D ARM_CPU(obj);
> =20
>      kvm_arm_set_cpu_features_from_host(cpu);
> +    arm_cpu_post_init(ARM_CPU(obj));
>  }
> =20
>  static const TypeInfo host_arm_cpu_type_info =3D {
> @@ -2108,14 +2109,23 @@ static const TypeInfo host_arm_cpu_type_info =3D {
> =20
>  #endif
> =20
> +static void arm_cpu_instance_init(Object *obj)
> +{
> +    const ARMCPUInfo *info =3D object_class_get_class_data(object_get_cl=
ass(obj));
> +
> +    info->initfn(obj);
> +    arm_cpu_post_init(obj);
> +}
> +
>  static void cpu_register(const ARMCPUInfo *info)
>  {
>      TypeInfo type_info =3D {
>          .parent =3D TYPE_ARM_CPU,
>          .instance_size =3D sizeof(ARMCPU),
> -        .instance_init =3D info->initfn,
> +        .instance_init =3D arm_cpu_instance_init,
>          .class_size =3D sizeof(ARMCPUClass),
>          .class_init =3D info->class_init,
> +        .class_data =3D (void *)info,
>      };
> =20
>      type_info.name =3D g_strdup_printf("%s-" TYPE_ARM_CPU, info->name);
> @@ -2128,7 +2138,6 @@ static const TypeInfo arm_cpu_type_info =3D {
>      .parent =3D TYPE_CPU,
>      .instance_size =3D sizeof(ARMCPU),
>      .instance_init =3D arm_cpu_initfn,
> -    .instance_post_init =3D arm_cpu_post_init,
>      .instance_finalize =3D arm_cpu_finalizefn,
>      .abstract =3D true,
>      .class_size =3D sizeof(ARMCPUClass),
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 873f059bf2..dbfc3ee490 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -447,14 +447,23 @@ static void aarch64_cpu_class_init(ObjectClass *oc,=
 void *data)
>      cc->gdb_arch_name =3D aarch64_gdb_arch_name;
>  }
> =20
> +static void aarch64_cpu_instance_init(Object *obj)
> +{
> +    const ARMCPUInfo *info =3D object_class_get_class_data(object_get_cl=
ass(obj));
> +
> +    info->initfn(obj);
> +    arm_cpu_post_init(obj);
> +}
> +
>  static void aarch64_cpu_register(const ARMCPUInfo *info)
>  {
>      TypeInfo type_info =3D {
>          .parent =3D TYPE_AARCH64_CPU,
>          .instance_size =3D sizeof(ARMCPU),
> -        .instance_init =3D info->initfn,
> +        .instance_init =3D aarch64_cpu_instance_init,
>          .class_size =3D sizeof(ARMCPUClass),
>          .class_init =3D info->class_init,
> +        .class_data =3D (void *)info,
>      };
> =20
>      type_info.name =3D g_strdup_printf("%s-" TYPE_ARM_CPU, info->name);
