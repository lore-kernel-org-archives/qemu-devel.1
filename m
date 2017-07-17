Received: from eggs.gnu.org ([2001:4830:134:3::10]:41526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dX4kj-00076a-Ay
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:03:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dX4ki-0007MF-6y
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:03:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dX4kh-0007KT-Tm
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:03:52 -0400
Date: Mon, 17 Jul 2017 14:03:43 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170717140343.0026e05d@nial.brq.redhat.com>
In-Reply-To: <20170712162058.10538-2-ehabkost@redhat.com>
References: <20170712162058.10538-1-ehabkost@redhat.com>
	<20170712162058.10538-2-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] target/i386: Use simple static
 property for "model-id"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, 12 Jul 2017 13:20:55 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> Instead of storing the raw CPUID data in CPUX86State and having
> to convert the data back and forth on the QOM getter/setter, use
> a simple static string property, and calculate CPUID data inside
> cpu_x86_cpuid().
wouldn't this slow down 'cpuid' instruction execution,
especially in tcg mode?

Why do you need this patch except of nice code reduction it gives?

> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  target/i386/cpu.h |  2 +-
>  target/i386/cpu.c | 62 ++++++++++++++++---------------------------------------
>  2 files changed, 19 insertions(+), 45 deletions(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 7a228af..f56a3ea 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1151,7 +1151,7 @@ typedef struct CPUX86State {
>      FeatureWordArray features;
>      /* Features that were explicitly enabled/disabled */
>      FeatureWordArray user_features;
> -    uint32_t cpuid_model[12];
> +    char *model_id;
>  
>      /* MTRRs */
>      uint64_t mtrr_fixed[11];
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index c571772..30b704c 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1828,43 +1828,6 @@ static void x86_cpuid_set_vendor(Object *obj, const char *value,
>      }
>  }
>  
> -static char *x86_cpuid_get_model_id(Object *obj, Error **errp)
> -{
> -    X86CPU *cpu = X86_CPU(obj);
> -    CPUX86State *env = &cpu->env;
> -    char *value;
> -    int i;
> -
> -    value = g_malloc(48 + 1);
> -    for (i = 0; i < 48; i++) {
> -        value[i] = env->cpuid_model[i >> 2] >> (8 * (i & 3));
> -    }
> -    value[48] = '\0';
> -    return value;
> -}
> -
> -static void x86_cpuid_set_model_id(Object *obj, const char *model_id,
> -                                   Error **errp)
> -{
> -    X86CPU *cpu = X86_CPU(obj);
> -    CPUX86State *env = &cpu->env;
> -    int c, len, i;
> -
> -    if (model_id == NULL) {
> -        model_id = "";
> -    }
> -    len = strlen(model_id);
> -    memset(env->cpuid_model, 0, 48);
> -    for (i = 0; i < 48; i++) {
> -        if (i >= len) {
> -            c = '\0';
> -        } else {
> -            c = (uint8_t)model_id[i];
> -        }
> -        env->cpuid_model[i >> 2] |= c << (8 * (i & 3));
> -    }
> -}
> -
>  static void x86_cpuid_get_tsc_freq(Object *obj, Visitor *v, const char *name,
>                                     void *opaque, Error **errp)
>  {
> @@ -2899,10 +2862,23 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>      case 0x80000002:
>      case 0x80000003:
>      case 0x80000004:
> -        *eax = env->cpuid_model[(index - 0x80000002) * 4 + 0];
> -        *ebx = env->cpuid_model[(index - 0x80000002) * 4 + 1];
> -        *ecx = env->cpuid_model[(index - 0x80000002) * 4 + 2];
> -        *edx = env->cpuid_model[(index - 0x80000002) * 4 + 3];
> +        {
> +            int i;
> +            int len = strlen(env->model_id);
> +            uint32_t model[4] = { 0, 0, 0, 0 };
> +
> +            for (i = 0; i < 16; i++) {
> +                int p = (index - 0x80000002) * 16 + i;
> +                if (p >= len) {
> +                    continue;
> +                }
> +                model[i >> 2] |= ((uint8_t)env->model_id[p]) << (8 * (i & 3));
> +            }
> +            *eax = model[0];
> +            *ebx = model[1];
> +            *ecx = model[2];
> +            *edx = model[3];
> +        }
>          break;
>      case 0x80000005:
>          /* cache info (L1 cache) */
> @@ -3868,9 +3844,6 @@ static void x86_cpu_initfn(Object *obj)
>      object_property_add_str(obj, "vendor",
>                              x86_cpuid_get_vendor,
>                              x86_cpuid_set_vendor, NULL);
> -    object_property_add_str(obj, "model-id",
> -                            x86_cpuid_get_model_id,
> -                            x86_cpuid_set_model_id, NULL);
>      object_property_add(obj, "tsc-frequency", "int",
>                          x86_cpuid_get_tsc_freq,
>                          x86_cpuid_set_tsc_freq, NULL, NULL, NULL);
> @@ -4004,6 +3977,7 @@ static Property x86_cpu_properties[] = {
>      DEFINE_PROP_UINT32("phys-bits", X86CPU, phys_bits, 0),
>      DEFINE_PROP_BOOL("host-phys-bits", X86CPU, host_phys_bits, false),
>      DEFINE_PROP_BOOL("fill-mtrr-mask", X86CPU, fill_mtrr_mask, true),
> +    DEFINE_PROP_STRING("model-id", X86CPU, env.model_id),
>      DEFINE_PROP_UINT32("level", X86CPU, env.cpuid_level, UINT32_MAX),
>      DEFINE_PROP_UINT32("xlevel", X86CPU, env.cpuid_xlevel, UINT32_MAX),
>      DEFINE_PROP_UINT32("xlevel2", X86CPU, env.cpuid_xlevel2, UINT32_MAX),
