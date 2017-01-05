Received: from eggs.gnu.org ([2001:4830:134:3::10]:59232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPBfV-0003dp-JW
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 12:17:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPBfU-0002fn-Gn
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 12:17:37 -0500
Received: from mail-vk0-x236.google.com ([2607:f8b0:400c:c05::236]:35784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cPBfU-0002fO-AS
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 12:17:36 -0500
Received: by mail-vk0-x236.google.com with SMTP id y197so154797741vky.2
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 09:17:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b7f0904f00d135f9b2760b8881dbc9ead23cedbf.1481121503.git.julian@codesourcery.com>
References: <cover.1481121503.git.julian@codesourcery.com>
	<b7f0904f00d135f9b2760b8881dbc9ead23cedbf.1481121503.git.julian@codesourcery.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jan 2017 17:17:13 +0000
Message-ID: <CAFEAcA-EQ-e39uv1rnTUb5SwDZzPrHUfhydY5hzc8CrP4NhX_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 1/6] Add cfgend parameter for ARM CPU
 selection.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julian Brown <julian@codesourcery.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 7 December 2016 at 14:48, Julian Brown <julian@codesourcery.com> wrote:
> The new "cfgend" parameter can be given after the CPU name,
> e.g. "-cpu=arm926,cfgend=yes", and is used to control the reset value
> of the SCTLR register in an architecture-version appropriate way (in a
> similar way to the CFGEND input on physical cores).  Using the option for
> CPUs implementing the ARMv7+ architecture will enable the SCTLR_EE bit,
> and for previous versions it will enable the SCTLR_B bit.
>
> Signed-off-by: Julian Brown <julian@codesourcery.com>
> ---
>  target-arm/cpu.c | 28 +++++++++++++++++++++++++---
>  target-arm/cpu.h |  7 +++++++
>  2 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/target-arm/cpu.c b/target-arm/cpu.c
> index 2eb4098..512964e 100644
> --- a/target-arm/cpu.c
> +++ b/target-arm/cpu.c
> @@ -33,6 +33,7 @@
>  #include "sysemu/sysemu.h"
>  #include "sysemu/kvm.h"
>  #include "kvm_arm.h"
> +#include "exec/cpu-common.h"
>
>  static void arm_cpu_set_pc(CPUState *cs, vaddr value)
>  {
> @@ -497,6 +498,9 @@ static Property arm_cpu_rvbar_property =
>  static Property arm_cpu_has_el3_property =
>              DEFINE_PROP_BOOL("has_el3", ARMCPU, has_el3, true);
>
> +static Property arm_cpu_cfgend_property =
> +            DEFINE_PROP_BOOL("cfgend", ARMCPU, cfgend, false);
> +
>  /* use property name "pmu" to match other archs and virt tools */
>  static Property arm_cpu_has_pmu_property =
>              DEFINE_PROP_BOOL("pmu", ARMCPU, has_pmu, true);
> @@ -559,6 +563,18 @@ static void arm_cpu_post_init(Object *obj)
>          }
>      }
>
> +    qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property,
> +                             &error_abort);
> +
> +    qdev_prop_set_globals(DEVICE(obj));
> +
> +    if (object_property_get_bool(obj, "cfgend", NULL)) {
> +        if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
> +            cpu->reset_sctlr |= SCTLR_EE;
> +        } else {
> +            cpu->reset_sctlr |= SCTLR_B;
> +        }
> +    }

Can we just implement this property the same way we do all
our existing ones, ie just call qdev_property_add_static()
here, and then look at the property value in arm_cpu_realizefn() ?
I'm not clear what the call to qdev_prop_set_globals() is
needed for.

>  }
>
>  static void arm_cpu_finalizefn(Object *obj)
> @@ -758,6 +774,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>  static ObjectClass *arm_cpu_class_by_name(const char *cpu_model)
>  {
>      ObjectClass *oc;
> +    CPUClass *cc;
>      char *typename;
>      char **cpuname;
>
> @@ -765,15 +782,20 @@ static ObjectClass *arm_cpu_class_by_name(const char *cpu_model)
>          return NULL;
>      }
>
> -    cpuname = g_strsplit(cpu_model, ",", 1);
> +    cpuname = g_strsplit(cpu_model, ",", 2);
>      typename = g_strdup_printf("%s-" TYPE_ARM_CPU, cpuname[0]);
>      oc = object_class_by_name(typename);
> -    g_strfreev(cpuname);
> -    g_free(typename);
>      if (!oc || !object_class_dynamic_cast(oc, TYPE_ARM_CPU) ||
>          object_class_is_abstract(oc)) {
> +        g_strfreev(cpuname);
> +        g_free(typename);
>          return NULL;
>      }
> +
> +    cc = CPU_CLASS(oc);
> +    cc->parse_features(typename, cpuname[1], &error_fatal);
> +    g_strfreev(cpuname);
> +

I'm also not clear why this needs to change -- the existing code works
for all of our current properties.

>      return oc;
>  }
>
> diff --git a/target-arm/cpu.h b/target-arm/cpu.h
> index ca5c849..becbfce 100644
> --- a/target-arm/cpu.h
> +++ b/target-arm/cpu.h
> @@ -657,6 +657,13 @@ struct ARMCPU {
>      uint32_t dcz_blocksize;
>      uint64_t rvbar;
>
> +    /* Whether the cfgend input is high (i.e. this CPU should reset into
> +     * big-endian mode).  This setting isn't used directly: instead it modifies
> +     * the reset_sctlr value to have SCTLR_B or SCTLR_EE set, depending on the
> +     * architecture version.
> +     */
> +    bool cfgend;
> +
>      ARMELChangeHook *el_change_hook;
>      void *el_change_hook_opaque;
>  };

thanks
-- PMM
