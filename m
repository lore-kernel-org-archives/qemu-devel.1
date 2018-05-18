Received: from eggs.gnu.org ([2001:4830:134:3::10]:43769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fJW8z-0007oo-P6
	for qemu-devel@nongnu.org; Thu, 17 May 2018 23:33:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fJW8w-0008Ir-NX
	for qemu-devel@nongnu.org; Thu, 17 May 2018 23:33:25 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:47041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fJW8w-0008HA-DQ
	for qemu-devel@nongnu.org; Thu, 17 May 2018 23:33:22 -0400
Received: by mail-ot0-x244.google.com with SMTP id t1-v6so7491315ott.13
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 20:33:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180507210838.16451-1-antonynpavlov@gmail.com>
References: <20180507210838.16451-1-antonynpavlov@gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 18 May 2018 15:33:20 +1200
Message-ID: <CAHNT7NsZViSQuig=QmtKRY7m5t-0jXue-HzS1=3imDDmkkFi4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Antony Pavlov <antonynpavlov@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>

On Tue, May 8, 2018 at 9:08 AM, Antony Pavlov <antonynpavlov@gmail.com>
wrote:

> The RISC-V Instruction Set Manual, Volume II:
> Privileged Architecture, Version 1.10 states
> that upon reset the pc is set to
> an implementation-defined reset vector
> (see chapter 3.3 Reset).
>
> This patch makes it possible to alter default
> reset vector by setting "rstvec" property
> for TYPE_RISCV_HART_ARRAY.
>

This one needs some thought. We have already made it possible for a CPU
class to override the reset vector, with consideration of this exact use
case.

The idea with the current approach is that you instantiate your specific
CPU model (target/riscv) in the hardware machine model (hw/riscv) and the
reset vector is a property of the CPU model you are using on your machine,
which is how it is now.

RISCVHartArray needs some work. First it is in 'hw/riscv' not
'target/riscv'. Secondly RISCVHartArray is commented as "heterogenous"
(nevertheless the current implementation is "homogeneous" so apologies if
this mislead you). The intention is that RISCVHartArray can construct a
heterogenous array of different cpu models with some topology. The current
shortcoming of homogeneity is in the current constructor which has only one
model property. The SiFive U54-MC for example has 5 cores, a 'e51' no-MMU
monitor core and 4 'u54' application cores e.g. "e51,u54,u54,u54,u54". The
reset vector should be a property of each CPU, given they can be different
models with different reset vectors. RISCVHartArray is a work in progress.

Background on whay RISCVHartArray exists, as a placeholder that will be
expanded to add support for configuration of "heterogeneous" core
complexes. There is some periphery that needs to reflect on the CPU array
properties. The SiFivePLIC memory layout is dependent on the cores in the "
heterogenous" core complex. We haven't yet wired the PLIC to RISCVHartArray
to get topoology information so it currently uses a mode list property
"M,MS,MS,MS,MS". The idea is that it can eventuall reflect on topology
configuration from the RISCVHartArray. Example: the 'e51' coreplex in the
U54-MC does not support S-mode but the 'u54' coreplex application cores do,
and the interrupt controller memory map is dependent on the topology. Our
idea was to re-use RISCVHartArray logic for instantiating "heterogenous"
core complexes as part of an SOC using some configuration e.g. an array of
cpu models. It's likely that individial CPUs will have different modes,
different reset vectors, different extensions, etc, etc.

Q1. Which CPU are you actually modelling?
Q2. Can you achieve your goal by defining your own CPU? I believe yes.
Q3. What object should have the property of a reset vector?

I believe the answer to Q3 is a specific cpu model, which is how we have
it, not a heterogenous array where some CPUs may indeed have different
reset vectors.

Apologies if RISCVHartArray gave you the idea the harts where homogeneous.
I believe moving a per cpu property onto the array is IMHO not the right
thing to do.

This leads into an RFC that I need to write on modelling dynamically
reconfigurable hardware models that can be produced by SiFive's core
generator. We want an interface that is kinder to the user than complex
command line options... or ones deemed inappropriate such as inferring
toplogy from a device-tree passed with -dtb e.g. an SOC class that
instantiates its cpu cores and hardware blocks as defined in the
device-tree at the given memory addresses with the given interrupt routing,
etc (we understand that this may work for some simple configurations, but
not for more complex configurations). The reset vector is a good example of
a property that is not available in device-tree. In any case the RFC on
configuration models for dynamically reconfigurable hardware will be
another email, however this serves as context for it. i.e. where a property
should be located. In fact we should fix the RISCVHartArray constructor or
possible move the class altogether until we have a good model for
constructing topology without hardcoding it in SOC structures, which for
SiFive's use of QEMU, would be a combinatorial explosion, given the
combinations of cores, extensions and blocks that can be generated by their
core generator, and that we wish to model in QEMU or some derivative, if we
have to maintain reconfigurable hardware support in a SiFive tree. I'll
leave the RFC proper for another email. This is just an abstract.

BTW - there are plently of others you can get to accept this patch ;-) See
the 'Cc.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
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
>
> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> index 14e3c186fe..98e5e50f33 100644
> --- a/hw/riscv/riscv_hart.c
> +++ b/hw/riscv/riscv_hart.c
> @@ -27,6 +27,7 @@
>  static Property riscv_harts_props[] = {
>      DEFINE_PROP_UINT32("num-harts", RISCVHartArrayState, num_harts, 1),
>      DEFINE_PROP_STRING("cpu-type", RISCVHartArrayState, cpu_type),
> +    DEFINE_PROP_UINT64("rstvec", RISCVHartArrayState, rstvec,
> DEFAULT_RSTVEC),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> @@ -50,6 +51,8 @@ static void riscv_harts_realize(DeviceState *dev, Error
> **errp)
>          s->harts[n].env.mhartid = n;
>          object_property_add_child(OBJECT(s), "harts[*]",
> OBJECT(&s->harts[n]),
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
>
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
>
>  /* RISC-V CPU definitions */
>
> @@ -112,7 +113,6 @@ static void riscv_any_cpu_init(Object *obj)
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
>      set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVU);
>      set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
> -    set_resetvec(env, DEFAULT_RSTVEC);
>  }
>
>  #if defined(TARGET_RISCV32)
> @@ -122,7 +122,6 @@ static void rv32gcsu_priv1_09_1_cpu_init(Object *obj)
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
>      set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
>      set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_09_1);
> -    set_resetvec(env, DEFAULT_RSTVEC);
>      set_feature(env, RISCV_FEATURE_MMU);
>  }
>
> @@ -131,7 +130,6 @@ static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
>      set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
>      set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
> -    set_resetvec(env, DEFAULT_RSTVEC);
>      set_feature(env, RISCV_FEATURE_MMU);
>  }
>
> @@ -140,7 +138,6 @@ static void rv32imacu_nommu_cpu_init(Object *obj)
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
>      set_misa(env, RV32 | RVI | RVM | RVA | RVC | RVU);
>      set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
> -    set_resetvec(env, DEFAULT_RSTVEC);
>  }
>
>  #elif defined(TARGET_RISCV64)
> @@ -150,7 +147,6 @@ static void rv64gcsu_priv1_09_1_cpu_init(Object *obj)
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
>      set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
>      set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_09_1);
> -    set_resetvec(env, DEFAULT_RSTVEC);
>      set_feature(env, RISCV_FEATURE_MMU);
>  }
>
> @@ -159,7 +155,6 @@ static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
>      set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
>      set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
> -    set_resetvec(env, DEFAULT_RSTVEC);
>      set_feature(env, RISCV_FEATURE_MMU);
>  }
>
> @@ -168,7 +163,6 @@ static void rv64imacu_nommu_cpu_init(Object *obj)
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
>      set_misa(env, RV64 | RVI | RVM | RVA | RVC | RVU);
>      set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
> -    set_resetvec(env, DEFAULT_RSTVEC);
>  }
>
>  #endif
> @@ -292,6 +286,7 @@ static void riscv_cpu_disas_set_info(CPUState *s,
> disassemble_info *info)
>  static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>  {
>      CPUState *cs = CPU(dev);
> +    RISCVCPU *cpu = RISCV_CPU(dev);
>      RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
>      Error *local_err = NULL;
>
> @@ -302,6 +297,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error
> **errp)
>      }
>
>      qemu_init_vcpu(cs);
> +    set_resetvec(&cpu->env, cpu->rstvec);
>      cpu_reset(cs);
>
>      mcc->parent_realize(dev, errp);
> @@ -315,6 +311,11 @@ static void riscv_cpu_init(Object *obj)
>      cs->env_ptr = &cpu->env;
>  }
>
> +static Property riscv_cpu_properties[] = {
> +    DEFINE_PROP_UINT64("rstvec", RISCVCPU, rstvec, DEFAULT_RSTVEC),
> +    DEFINE_PROP_END_OF_LIST()
> +};
> +
>  static const VMStateDescription vmstate_riscv_cpu = {
>      .name = "cpu",
>      .unmigratable = 1,
> @@ -329,6 +330,8 @@ static void riscv_cpu_class_init(ObjectClass *c, void
> *data)
>      mcc->parent_realize = dc->realize;
>      dc->realize = riscv_cpu_realize;
>
> +    dc->props = riscv_cpu_properties;
> +
>      mcc->parent_reset = cc->reset;
>      cc->reset = riscv_cpu_reset;
>
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
>
>  static inline RISCVCPU *riscv_env_get_cpu(CPURISCVState *env)
> --
> 2.17.0
>
>
