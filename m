Received: from eggs.gnu.org ([2001:4830:134:3::10]:55689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dilwJ-0008Od-8Y
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 14:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dilwG-0004DF-3g
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 14:24:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dilwF-0004Cy-QY
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 14:24:08 -0400
Date: Fri, 18 Aug 2017 15:24:04 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170818182404.GC27715@localhost.localdomain>
References: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
	<1503050939-227939-4-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1503050939-227939-4-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 03/27] sparc: convert cpu features
 to qdev properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

On Fri, Aug 18, 2017 at 12:08:35PM +0200, Igor Mammedov wrote:
> SPARC is the last target that uses legacy way of parsing
> and initializing cpu features, drop legacy approach and
> convert features to properties so that SPARC could as minimum
> benefit from generic cpu_generic_init(), common with
> x86 +-feat parser
> 
> PS:
> the main purpose is to remove legacy way of cpu creation as
> a blocker for unifying cpu creation code across targets.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
[...]
> ---
> CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> CC: Artyom Tarasenko <atar4qemu@gmail.com>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  target/sparc/cpu.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index f4e7343..e735d73 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -22,6 +22,8 @@
>  #include "cpu.h"
>  #include "qemu/error-report.h"
>  #include "exec/exec-all.h"
> +#include "hw/qdev-properties.h"
> +#include "qapi/visitor.h"
>  
>  //#define DEBUG_FEATURES
>  
> @@ -853,6 +855,69 @@ static void sparc_cpu_initfn(Object *obj)
>      }
>  }
>  
> +static void sparc_get_nwindows(Object *obj, Visitor *v, const char *name,
> +                               void *opaque, Error **errp)
> +{
> +    SPARCCPU *cpu = SPARC_CPU(obj);
> +    int64_t value = cpu->env.def.nwindows;
> +
> +    visit_type_int(v, name, &value, errp);
> +}
> +
> +static void sparc_set_nwindows(Object *obj, Visitor *v, const char *name,
> +                               void *opaque, Error **errp)
> +{
> +    const int64_t min = MIN_NWINDOWS;
> +    const int64_t max = MAX_NWINDOWS;
> +    SPARCCPU *cpu = SPARC_CPU(obj);
> +    Error *err = NULL;
> +    int64_t value;
> +
> +    visit_type_int(v, name, &value, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    if (value < min || value > max) {
> +        error_setg(errp, "Property %s.%s doesn't take value %" PRId64
> +                   " (minimum: %" PRId64 ", maximum: %" PRId64 ")",
> +                   object_get_typename(obj), name ? name : "null",
> +                   value, min, max);
> +        return;
> +    }
> +    cpu->env.def.nwindows = value;

I think it would be much simpler to just validate nwindows at
realize time and use DEFINE_PROP_UINT32 below, but I won't mind
if you really prefer the custom setter.

But I have another question:

> +}
> +
> +static PropertyInfo qdev_prop_nwindows = {
> +    .name  = "int",
> +    .get   = sparc_get_nwindows,
> +    .set   = sparc_set_nwindows,
> +};
> +
> +static Property sparc_cpu_properties[] = {
> +    DEFINE_PROP_BIT("float",    SPARCCPU, env.def.features, 0, false),
> +    DEFINE_PROP_BIT("float128", SPARCCPU, env.def.features, 1, false),
> +    DEFINE_PROP_BIT("swap",     SPARCCPU, env.def.features, 2, false),
> +    DEFINE_PROP_BIT("mul",      SPARCCPU, env.def.features, 3, false),
> +    DEFINE_PROP_BIT("div",      SPARCCPU, env.def.features, 4, false),
> +    DEFINE_PROP_BIT("flush",    SPARCCPU, env.def.features, 5, false),
> +    DEFINE_PROP_BIT("fsqrt",    SPARCCPU, env.def.features, 6, false),
> +    DEFINE_PROP_BIT("fmul",     SPARCCPU, env.def.features, 7, false),
> +    DEFINE_PROP_BIT("vis1",     SPARCCPU, env.def.features, 8, false),
> +    DEFINE_PROP_BIT("vis2",     SPARCCPU, env.def.features, 9, false),
> +    DEFINE_PROP_BIT("fsmuld",   SPARCCPU, env.def.features, 10, false),
> +    DEFINE_PROP_BIT("hypv",     SPARCCPU, env.def.features, 11, false),
> +    DEFINE_PROP_BIT("cmt",      SPARCCPU, env.def.features, 12, false),
> +    DEFINE_PROP_BIT("gl",       SPARCCPU, env.def.features, 13, false),
> +    DEFINE_PROP_UNSIGNED("iu-version", SPARCCPU, env.def.iu_version, 0,
> +                         qdev_prop_uint64, target_ulong),
> +    DEFINE_PROP_UINT32("fpu-version", SPARCCPU, env.def.fpu_version, 0),
> +    DEFINE_PROP_UINT32("mmu-version", SPARCCPU, env.def.mmu_version, 0),
> +    { .name  = "nwindows", .info  = &qdev_prop_nwindows },

What's the advantage of using a custom PropertyInfo struct if you
can just call object_class_property_add() at
sparc_cpu_class_init()?

> +    DEFINE_PROP_END_OF_LIST()
> +};
> +
>  static void sparc_cpu_class_init(ObjectClass *oc, void *data)
>  {
>      SPARCCPUClass *scc = SPARC_CPU_CLASS(oc);
> @@ -861,6 +926,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
>  
>      scc->parent_realize = dc->realize;
>      dc->realize = sparc_cpu_realizefn;
> +    dc->props = sparc_cpu_properties;
>  
>      scc->parent_reset = cc->reset;
>      cc->reset = sparc_cpu_reset;
> -- 
> 2.7.4
> 
> 

-- 
Eduardo
