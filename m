Received: from eggs.gnu.org ([209.51.188.92]:33686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hJDLp-00083L-T1
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 04:33:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hJDBo-0004Sq-2a
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 04:23:37 -0400
Date: Wed, 24 Apr 2019 09:23:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190424082309.GB28615@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<20190423212246.3542-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190423212246.3542-3-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] machine: Use SupportStatusInfo for
 deprecation info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, mprivozn@redhat.com, Markus Armbruster <armbru@redhat.com>, =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Tue, Apr 23, 2019 at 06:22:45PM -0300, Eduardo Habkost wrote:
> Use SupportStatusInfo to represent deprecation information of
> machine types.
> 
> Instead of using a generic "use XXX instead" message for humans,
> encode the suggested alternative in a machine-friendly way at the
> 'suggested_alternatives' field.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  include/hw/boards.h |  7 ++++---
>  hw/i386/pc_piix.c   |  4 +++-
>  hw/ppc/prep.c       |  4 +++-
>  vl.c                | 13 +++++++++----
>  4 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index e231860666..243bf3c7ce 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -8,6 +8,8 @@
>  #include "hw/qdev.h"
>  #include "qom/object.h"
>  #include "qom/cpu.h"
> +#include "qapi/qapi-types-common.h"
> +
>  
>  /**
>   * memory_region_allocate_system_memory - Allocate a board's main memory
> @@ -105,8 +107,7 @@ typedef struct {
>  
>  /**
>   * MachineClass:
> - * @deprecation_reason: If set, the machine is marked as deprecated. The
> - *    string should provide some clear information about what to use instead.
> + * @support_status: Support and deprecation status of machine type.
>   * @max_cpus: maximum number of CPUs supported. Default: 1
>   * @min_cpus: minimum number of CPUs supported. Default: 1
>   * @default_cpus: number of CPUs instantiated if none are specified. Default: 1
> @@ -169,7 +170,7 @@ struct MachineClass {
>      char *name;
>      const char *alias;
>      const char *desc;
> -    const char *deprecation_reason;
> +    SupportStatusInfo support_status;
>  
>      void (*init)(MachineState *state);
>      void (*reset)(void);
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 8ad8e885c6..97bd401618 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -781,7 +781,9 @@ static void pc_i440fx_0_15_machine_options(MachineClass *m)
>  
>      pc_i440fx_1_0_machine_options(m);
>      m->hw_version = "0.15";
> -    m->deprecation_reason = "use a newer machine type instead";
> +    m->support_status.deprecated = true;
> +    m->support_status.has_suggested_alternative = true;
> +    m->support_status.suggested_alternative = g_strdup("pc");
>      compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
>  }
>  
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 847d320465..9a02b0eec4 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -587,7 +587,9 @@ static void ppc_prep_init(MachineState *machine)
>  
>  static void prep_machine_init(MachineClass *mc)
>  {
> -    mc->deprecation_reason = "use 40p machine type instead";
> +    mc->support_status.deprecated = true;
> +    mc->support_status.has_suggested_alternative = true;
> +    mc->support_status.suggested_alternative = g_strdup("40p");
>      mc->desc = "PowerPC PREP platform";
>      mc->init = ppc_prep_init;
>      mc->block_default_type = IF_IDE;
> diff --git a/vl.c b/vl.c
> index c696ad2a13..99b857ed2a 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2610,7 +2610,7 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b)
>              }
>              printf("%-20s %s%s%s\n", mc->name, mc->desc,
>                     mc->is_default ? " (default)" : "",
> -                   mc->deprecation_reason ? " (deprecated)" : "");
> +                   mc->support_status.deprecated ? " (deprecated)" : "");
>          }
>      }
>  
> @@ -4308,9 +4308,14 @@ int main(int argc, char **argv, char **envp)
>       * called from configure_accelerator().
>       */
>  
> -    if (!qtest_enabled() && machine_class->deprecation_reason) {
> -        error_report("Machine type '%s' is deprecated: %s",
> -                     machine_class->name, machine_class->deprecation_reason);
> +    if (!qtest_enabled() && machine_class->support_status.deprecated) {
> +        error_report("Machine type '%s' is deprecated%s%s", machine_class->name,
> +                     machine_class->support_status.status_message ? ": " : "",
> +                     machine_class->support_status.status_message ?: "");
> +        if (machine_class->support_status.suggested_alternative) {
> +            error_report("Suggested solution: use '%s' machine type instead",
> +                         machine_class->support_status.suggested_alternative);

I'd just drop the word "Suggested solution: " as I think it is fine to just
say "Use foobar machine type instead".


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
