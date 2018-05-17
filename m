Received: from eggs.gnu.org ([2001:4830:134:3::10]:47529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <antonynpavlov@gmail.com>) id 1fJDvl-00064R-6i
	for qemu-devel@nongnu.org; Thu, 17 May 2018 04:06:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <antonynpavlov@gmail.com>) id 1fJDvg-00084W-FE
	for qemu-devel@nongnu.org; Thu, 17 May 2018 04:06:33 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:43196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <antonynpavlov@gmail.com>)
	id 1fJDvg-000843-1B
	for qemu-devel@nongnu.org; Thu, 17 May 2018 04:06:28 -0400
Received: by mail-lf0-x242.google.com with SMTP id n18-v6so7356199lfh.10
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 01:06:27 -0700 (PDT)
Date: Thu, 17 May 2018 11:23:12 +0300
From: Antony Pavlov <antonynpavlov@gmail.com>
Message-Id: <20180517112312.ec27e97d19c82aaee8178bcf@gmail.com>
In-Reply-To: <20180507210838.16451-1-antonynpavlov@gmail.com>
References: <20180507210838.16451-1-antonynpavlov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] RISC-V: make it possible to alter default
 reset vector
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>

On Tue,  8 May 2018 00:08:38 +0300
Antony Pavlov <antonynpavlov@gmail.com> wrote:

Please comment this patch!

> The RISC-V Instruction Set Manual, Volume II:
> Privileged Architecture, Version 1.10 states
> that upon reset the pc is set to
> an implementation-defined reset vector
> (see chapter 3.3 Reset).
>=20
> This patch makes it possible to alter default
> reset vector by setting "rstvec" property
> for TYPE_RISCV_HART_ARRAY.
>=20
> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> Cc: Michael Clark <mjc@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/riscv/riscv_hart.c         |  3 +++
>  include/hw/riscv/riscv_hart.h |  1 +
>  target/riscv/cpu.c            | 17 ++++++++++-------
>  target/riscv/cpu.h            |  2 ++
>  4 files changed, 16 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> index 14e3c186fe..98e5e50f33 100644
> --- a/hw/riscv/riscv_hart.c
> +++ b/hw/riscv/riscv_hart.c
> @@ -27,6 +27,7 @@
>  static Property riscv_harts_props[] =3D {
>      DEFINE_PROP_UINT32("num-harts", RISCVHartArrayState, num_harts, 1),
>      DEFINE_PROP_STRING("cpu-type", RISCVHartArrayState, cpu_type),
> +    DEFINE_PROP_UINT64("rstvec", RISCVHartArrayState, rstvec, DEFAULT_RS=
TVEC),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> @@ -50,6 +51,8 @@ static void riscv_harts_realize(DeviceState *dev, Error=
 **errp)
>          s->harts[n].env.mhartid =3D n;
>          object_property_add_child(OBJECT(s), "harts[*]", OBJECT(&s->hart=
s[n]),
>                                    &error_abort);
> +        object_property_set_uint(OBJECT(&s->harts[n]), s->rstvec,
> +                                 "rstvec", &err);
>          qemu_register_reset(riscv_harts_cpu_reset, &s->harts[n]);
>          object_property_set_bool(OBJECT(&s->harts[n]), true,
>                                   "realized", &err);
> diff --git a/include/hw/riscv/riscv_hart.h b/include/hw/riscv/riscv_hart.h
> index 0671d88a44..3cc19e2b60 100644
> --- a/include/hw/riscv/riscv_hart.h
> +++ b/include/hw/riscv/riscv_hart.h
> @@ -34,6 +34,7 @@ typedef struct RISCVHartArrayState {
>      uint32_t num_harts;
>      char *cpu_type;
>      RISCVCPU *harts;
> +    uint64_t rstvec;
>  } RISCVHartArrayState;
> =20
>  #endif
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 5a527fbba0..061aa5cc6b 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -23,6 +23,7 @@
>  #include "exec/exec-all.h"
>  #include "qapi/error.h"
>  #include "migration/vmstate.h"
> +#include "hw/qdev-properties.h"
> =20
>  /* RISC-V CPU definitions */
> =20
> @@ -112,7 +113,6 @@ static void riscv_any_cpu_init(Object *obj)
>      CPURISCVState *env =3D &RISCV_CPU(obj)->env;
>      set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVU);
>      set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
> -    set_resetvec(env, DEFAULT_RSTVEC);
>  }
> =20
>  #if defined(TARGET_RISCV32)
> @@ -122,7 +122,6 @@ static void rv32gcsu_priv1_09_1_cpu_init(Object *obj)
>      CPURISCVState *env =3D &RISCV_CPU(obj)->env;
>      set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
>      set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_09_1);
> -    set_resetvec(env, DEFAULT_RSTVEC);
>      set_feature(env, RISCV_FEATURE_MMU);
>  }
> =20
> @@ -131,7 +130,6 @@ static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
>      CPURISCVState *env =3D &RISCV_CPU(obj)->env;
>      set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
>      set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
> -    set_resetvec(env, DEFAULT_RSTVEC);
>      set_feature(env, RISCV_FEATURE_MMU);
>  }
> =20
> @@ -140,7 +138,6 @@ static void rv32imacu_nommu_cpu_init(Object *obj)
>      CPURISCVState *env =3D &RISCV_CPU(obj)->env;
>      set_misa(env, RV32 | RVI | RVM | RVA | RVC | RVU);
>      set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
> -    set_resetvec(env, DEFAULT_RSTVEC);
>  }
> =20
>  #elif defined(TARGET_RISCV64)
> @@ -150,7 +147,6 @@ static void rv64gcsu_priv1_09_1_cpu_init(Object *obj)
>      CPURISCVState *env =3D &RISCV_CPU(obj)->env;
>      set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
>      set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_09_1);
> -    set_resetvec(env, DEFAULT_RSTVEC);
>      set_feature(env, RISCV_FEATURE_MMU);
>  }
> =20
> @@ -159,7 +155,6 @@ static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
>      CPURISCVState *env =3D &RISCV_CPU(obj)->env;
>      set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
>      set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
> -    set_resetvec(env, DEFAULT_RSTVEC);
>      set_feature(env, RISCV_FEATURE_MMU);
>  }
> =20
> @@ -168,7 +163,6 @@ static void rv64imacu_nommu_cpu_init(Object *obj)
>      CPURISCVState *env =3D &RISCV_CPU(obj)->env;
>      set_misa(env, RV64 | RVI | RVM | RVA | RVC | RVU);
>      set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
> -    set_resetvec(env, DEFAULT_RSTVEC);
>  }
> =20
>  #endif
> @@ -292,6 +286,7 @@ static void riscv_cpu_disas_set_info(CPUState *s, dis=
assemble_info *info)
>  static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>  {
>      CPUState *cs =3D CPU(dev);
> +    RISCVCPU *cpu =3D RISCV_CPU(dev);
>      RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(dev);
>      Error *local_err =3D NULL;
> =20
> @@ -302,6 +297,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error=
 **errp)
>      }
> =20
>      qemu_init_vcpu(cs);
> +    set_resetvec(&cpu->env, cpu->rstvec);
>      cpu_reset(cs);
> =20
>      mcc->parent_realize(dev, errp);
> @@ -315,6 +311,11 @@ static void riscv_cpu_init(Object *obj)
>      cs->env_ptr =3D &cpu->env;
>  }
> =20
> +static Property riscv_cpu_properties[] =3D {
> +    DEFINE_PROP_UINT64("rstvec", RISCVCPU, rstvec, DEFAULT_RSTVEC),
> +    DEFINE_PROP_END_OF_LIST()
> +};
> +
>  static const VMStateDescription vmstate_riscv_cpu =3D {
>      .name =3D "cpu",
>      .unmigratable =3D 1,
> @@ -329,6 +330,8 @@ static void riscv_cpu_class_init(ObjectClass *c, void=
 *data)
>      mcc->parent_realize =3D dc->realize;
>      dc->realize =3D riscv_cpu_realize;
> =20
> +    dc->props =3D riscv_cpu_properties;
> +
>      mcc->parent_reset =3D cc->reset;
>      cc->reset =3D riscv_cpu_reset;
> =20
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 41e06ac0f9..80f7772b04 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -210,6 +210,8 @@ typedef struct RISCVCPU {
>      CPUState parent_obj;
>      /*< public >*/
>      CPURISCVState env;
> +
> +    uint64_t rstvec;
>  } RISCVCPU;
> =20
>  static inline RISCVCPU *riscv_env_get_cpu(CPURISCVState *env)
> --=20
> 2.17.0
>=20


--=20
Best regards,
=A0 Antony Pavlov
