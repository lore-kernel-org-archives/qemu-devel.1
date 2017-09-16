Received: from eggs.gnu.org ([2001:4830:134:3::10]:38150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0lv-0002wC-6N
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 20:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0lq-00056i-U5
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 20:15:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dt0lp-00055y-Up
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 20:15:42 -0400
Date: Fri, 15 Sep 2017 21:15:35 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170916001535.GB21016@localhost.localdomain>
References: <20170830225225.27925-1-f4bug@amsat.org>
	<20170830225225.27925-6-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170830225225.27925-6-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/7] mips: MIPSCPU model subclasses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Igor Mammedov <imammedo@redhat.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Marcel Apfelbaum <marcel@redhat.com>, James Hogan <james.hogan@imgtec.com>, Yongbok Kim <yongbok.kim@imgtec.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On Wed, Aug 30, 2017 at 07:52:23PM -0300, Philippe Mathieu-Daud=E9 wrote:
> From: Igor Mammedov <imammedo@redhat.com>
>=20
> Register separate QOM types for each mips cpu model,
> so it would be possible to reuse generic CPU creation
> routines.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> [PMD: use internal.h, use void* to hold cpu_def in MIPSCPUClass,
>  mark MIPSCPU abstract]
> Tested-by: James Hogan <james.hogan@imgtec.com>
> ---
>  target/mips/cpu-qom.h        |  1 +
>  target/mips/internal.h       | 59 ++++++++++++++++++++++++++++++++++++=
++++++++
>  target/mips/cpu.c            | 53 ++++++++++++++++++++++++++++++++++++=
++-
>  target/mips/translate.c      | 13 +++++-----
>  target/mips/translate_init.c | 58 ++----------------------------------=
-------
>  5 files changed, 120 insertions(+), 64 deletions(-)
>=20
> diff --git a/target/mips/cpu-qom.h b/target/mips/cpu-qom.h
> index 3f5bf23823..085711d8f9 100644
> --- a/target/mips/cpu-qom.h
> +++ b/target/mips/cpu-qom.h
> @@ -49,6 +49,7 @@ typedef struct MIPSCPUClass {
> =20
>      DeviceRealize parent_realize;
>      void (*parent_reset)(CPUState *cpu);
> +    const void *cpu_def;

Why void*?  The following should be valid even if you don't
include internal.h:

    const struct mips_def_t *cpu_def;


>  } MIPSCPUClass;
> =20
>  typedef struct MIPSCPU MIPSCPU;
> diff --git a/target/mips/internal.h b/target/mips/internal.h
> index cf4c9db427..45ded3484c 100644
> --- a/target/mips/internal.h
> +++ b/target/mips/internal.h
> @@ -7,6 +7,65 @@
>  #ifndef MIPS_INTERNAL_H
>  #define MIPS_INTERNAL_H
> =20
> +
> +/* MMU types, the first four entries have the same layout as the
> +   CP0C0_MT field.  */
> +enum mips_mmu_types {
> +    MMU_TYPE_NONE,
> +    MMU_TYPE_R4000,
> +    MMU_TYPE_RESERVED,
> +    MMU_TYPE_FMT,
> +    MMU_TYPE_R3000,
> +    MMU_TYPE_R6000,
> +    MMU_TYPE_R8000
> +};
> +
> +struct mips_def_t {
> +    const char *name;
> +    int32_t CP0_PRid;
> +    int32_t CP0_Config0;
> +    int32_t CP0_Config1;
> +    int32_t CP0_Config2;
> +    int32_t CP0_Config3;
> +    int32_t CP0_Config4;
> +    int32_t CP0_Config4_rw_bitmask;
> +    int32_t CP0_Config5;
> +    int32_t CP0_Config5_rw_bitmask;
> +    int32_t CP0_Config6;
> +    int32_t CP0_Config7;
> +    target_ulong CP0_LLAddr_rw_bitmask;
> +    int CP0_LLAddr_shift;
> +    int32_t SYNCI_Step;
> +    int32_t CCRes;
> +    int32_t CP0_Status_rw_bitmask;
> +    int32_t CP0_TCStatus_rw_bitmask;
> +    int32_t CP0_SRSCtl;
> +    int32_t CP1_fcr0;
> +    int32_t CP1_fcr31_rw_bitmask;
> +    int32_t CP1_fcr31;
> +    int32_t MSAIR;
> +    int32_t SEGBITS;
> +    int32_t PABITS;
> +    int32_t CP0_SRSConf0_rw_bitmask;
> +    int32_t CP0_SRSConf0;
> +    int32_t CP0_SRSConf1_rw_bitmask;
> +    int32_t CP0_SRSConf1;
> +    int32_t CP0_SRSConf2_rw_bitmask;
> +    int32_t CP0_SRSConf2;
> +    int32_t CP0_SRSConf3_rw_bitmask;
> +    int32_t CP0_SRSConf3;
> +    int32_t CP0_SRSConf4_rw_bitmask;
> +    int32_t CP0_SRSConf4;
> +    int32_t CP0_PageGrain_rw_bitmask;
> +    int32_t CP0_PageGrain;
> +    target_ulong CP0_EBaseWG_rw_bitmask;
> +    int insn_flags;
> +    enum mips_mmu_types mmu_type;
> +};
> +
> +extern const struct mips_def_t mips_defs[];
> +extern const int mips_defs_number;
> +
>  enum CPUMIPSMSADataFormat {
>      DF_BYTE =3D 0,
>      DF_HALF,
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index e3ef835599..84b6f8bf68 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -146,12 +146,37 @@ static void mips_cpu_initfn(Object *obj)
>      CPUState *cs =3D CPU(obj);
>      MIPSCPU *cpu =3D MIPS_CPU(obj);
>      CPUMIPSState *env =3D &cpu->env;
> +    MIPSCPUClass *mcc =3D MIPS_CPU_GET_CLASS(obj);
> =20
>      cs->env_ptr =3D env;
> =20
>      if (tcg_enabled()) {
>          mips_tcg_init();
>      }
> +
> +    if (mcc->cpu_def) {

Why do we need this conditional?  It looks harmless but
unnecessary.

The rest of the patch looks good to me, and if the MIPS
maintainers think the current code is good enough, they have my:

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

(Additional questions/comments below)

> +        env->cpu_model =3D mcc->cpu_def;
> +    }
> +}
> +
> +static char *mips_cpu_type_name(const char *cpu_model)
> +{
> +    return g_strdup_printf("%s-" TYPE_MIPS_CPU, cpu_model);
> +}
> +
> +static ObjectClass *mips_cpu_class_by_name(const char *cpu_model)
> +{
> +    ObjectClass *oc;
> +    char *typename;
> +
> +    if (cpu_model =3D=3D NULL) {
> +        return NULL;
> +    }

For later: isn't this check for cpu_model=3D=3DNULL duplicated on
every single class_by_name implementation?  What about moving it
to cpu_class_by_name()?

> +
> +    typename =3D mips_cpu_type_name(cpu_model);
> +    oc =3D object_class_by_name(typename);
> +    g_free(typename);
> +    return oc;
>  }
> =20
>  static void mips_cpu_class_init(ObjectClass *c, void *data)
> @@ -166,6 +191,7 @@ static void mips_cpu_class_init(ObjectClass *c, voi=
d *data)
>      mcc->parent_reset =3D cc->reset;
>      cc->reset =3D mips_cpu_reset;
> =20
> +    cc->class_by_name =3D mips_cpu_class_by_name;
>      cc->has_work =3D mips_cpu_has_work;
>      cc->do_interrupt =3D mips_cpu_do_interrupt;
>      cc->cpu_exec_interrupt =3D mips_cpu_exec_interrupt;
> @@ -193,14 +219,39 @@ static const TypeInfo mips_cpu_type_info =3D {
>      .parent =3D TYPE_CPU,
>      .instance_size =3D sizeof(MIPSCPU),
>      .instance_init =3D mips_cpu_initfn,
> -    .abstract =3D false,
> +    .abstract =3D true,
>      .class_size =3D sizeof(MIPSCPUClass),
>      .class_init =3D mips_cpu_class_init,
>  };
> =20
> +static void mips_cpu_cpudef_class_init(ObjectClass *oc, void *data)
> +{
> +    MIPSCPUClass *mcc =3D MIPS_CPU_CLASS(oc);
> +    mcc->cpu_def =3D data;
> +}
> +
> +static void mips_register_cpudef_type(const struct mips_def_t *def)
> +{
> +    char *typename =3D mips_cpu_type_name(def->name);
> +    TypeInfo ti =3D {
> +        .name =3D typename,
> +        .parent =3D TYPE_MIPS_CPU,
> +        .class_init =3D mips_cpu_cpudef_class_init,
> +        .class_data =3D (void *)def,
> +    };
> +
> +    type_register(&ti);
> +    g_free(typename);
> +}
> +
>  static void mips_cpu_register_types(void)
>  {
> +    int i;
> +
>      type_register_static(&mips_cpu_type_info);
> +    for (i =3D 0; i < mips_defs_number; i++) {
> +        mips_register_cpudef_type(&mips_defs[i]);
> +    }
>  }
> =20
>  type_init(mips_cpu_register_types)
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 94c38e8755..f7128bc91d 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -20525,16 +20525,15 @@ void cpu_mips_realize_env(CPUMIPSState *env)
> =20
>  MIPSCPU *cpu_mips_init(const char *cpu_model)
>  {
> +    ObjectClass *oc;
>      MIPSCPU *cpu;
> -    CPUMIPSState *env;
> -    const mips_def_t *def;
> =20
> -    def =3D cpu_mips_find_by_name(cpu_model);
> -    if (!def)
> +    oc =3D cpu_class_by_name(TYPE_MIPS_CPU, cpu_model);
> +    if (oc =3D=3D NULL) {
>          return NULL;
> -    cpu =3D MIPS_CPU(object_new(TYPE_MIPS_CPU));
> -    env =3D &cpu->env;
> -    env->cpu_model =3D def;
> +    }
> +
> +    cpu =3D MIPS_CPU(object_new(object_class_get_name(oc)));
> =20
>      object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
> =20
> diff --git a/target/mips/translate_init.c b/target/mips/translate_init.=
c
> index 255d25bacd..8bbded46c4 100644
> --- a/target/mips/translate_init.c
> +++ b/target/mips/translate_init.c
> @@ -51,64 +51,9 @@
>  #define MIPS_CONFIG5                                              \
>  ((0 << CP0C5_M))
> =20
> -/* MMU types, the first four entries have the same layout as the
> -   CP0C0_MT field.  */
> -enum mips_mmu_types {
> -    MMU_TYPE_NONE,
> -    MMU_TYPE_R4000,
> -    MMU_TYPE_RESERVED,
> -    MMU_TYPE_FMT,
> -    MMU_TYPE_R3000,
> -    MMU_TYPE_R6000,
> -    MMU_TYPE_R8000
> -};
> -
> -struct mips_def_t {
> -    const char *name;
> -    int32_t CP0_PRid;
> -    int32_t CP0_Config0;
> -    int32_t CP0_Config1;
> -    int32_t CP0_Config2;
> -    int32_t CP0_Config3;
> -    int32_t CP0_Config4;
> -    int32_t CP0_Config4_rw_bitmask;
> -    int32_t CP0_Config5;
> -    int32_t CP0_Config5_rw_bitmask;
> -    int32_t CP0_Config6;
> -    int32_t CP0_Config7;
> -    target_ulong CP0_LLAddr_rw_bitmask;
> -    int CP0_LLAddr_shift;
> -    int32_t SYNCI_Step;
> -    int32_t CCRes;
> -    int32_t CP0_Status_rw_bitmask;
> -    int32_t CP0_TCStatus_rw_bitmask;
> -    int32_t CP0_SRSCtl;
> -    int32_t CP1_fcr0;
> -    int32_t CP1_fcr31_rw_bitmask;
> -    int32_t CP1_fcr31;
> -    int32_t MSAIR;
> -    int32_t SEGBITS;
> -    int32_t PABITS;
> -    int32_t CP0_SRSConf0_rw_bitmask;
> -    int32_t CP0_SRSConf0;
> -    int32_t CP0_SRSConf1_rw_bitmask;
> -    int32_t CP0_SRSConf1;
> -    int32_t CP0_SRSConf2_rw_bitmask;
> -    int32_t CP0_SRSConf2;
> -    int32_t CP0_SRSConf3_rw_bitmask;
> -    int32_t CP0_SRSConf3;
> -    int32_t CP0_SRSConf4_rw_bitmask;
> -    int32_t CP0_SRSConf4;
> -    int32_t CP0_PageGrain_rw_bitmask;
> -    int32_t CP0_PageGrain;
> -    target_ulong CP0_EBaseWG_rw_bitmask;
> -    int insn_flags;
> -    enum mips_mmu_types mmu_type;
> -};
> -
>  /*********************************************************************=
********/
>  /* MIPS CPU definitions */
> -static const mips_def_t mips_defs[] =3D
> +const mips_def_t mips_defs[] =3D
>  {
>      {
>          .name =3D "4Kc",
> @@ -808,6 +753,7 @@ static const mips_def_t mips_defs[] =3D
> =20
>  #endif
>  };
> +const int mips_defs_number =3D ARRAY_SIZE(mips_defs);
> =20
>  static const mips_def_t *cpu_mips_find_by_name (const char *name)

What's needed to get rid of cpu_mips_find_by_name() completely?

--=20
Eduardo
