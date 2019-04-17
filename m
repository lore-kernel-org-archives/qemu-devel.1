Received: from eggs.gnu.org ([209.51.188.92]:53349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGdNb-0003uh-GA
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 01:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGdNa-0003ft-6A
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 01:45:07 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190417025944.16154-1-ehabkost@redhat.com>
	<20190417025944.16154-6-ehabkost@redhat.com>
Date: Wed, 17 Apr 2019 07:45:01 +0200
In-Reply-To: <20190417025944.16154-6-ehabkost@redhat.com> (Eduardo Habkost's
	message of "Tue, 16 Apr 2019 23:59:44 -0300")
Message-ID: <87wojtyyle.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 5/5] cpu: Add MachineState parameter to
 parse_features()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Like Xu <like.xu@linux.intel.com>, Riku Voipio <riku.voipio@iki.fi>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

Eduardo Habkost <ehabkost@redhat.com> writes:

> The ppc implementation of parse_features() requires the machine
> object to be created before it gets called.  This is far from
> obvious when reading the code at main().
>
> Instead of making it call qdev_get_machine(), require the caller
> of parse_cpu_option() to provide the machine object.
>
> This makes the initialization dependency explicit at main(), and
> will let us move qdev_get_machine() to CONFIG_SOFTMMU in the
> future.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  include/qom/cpu.h               | 5 +++--
>  target/ppc/cpu-qom.h            | 3 ++-
>  exec.c                          | 4 ++--
>  qom/cpu.c                       | 3 ++-
>  target/i386/cpu.c               | 3 ++-
>  target/ppc/translate_init.inc.c | 7 ++++---
>  target/sparc/cpu.c              | 3 ++-
>  vl.c                            | 3 ++-
>  8 files changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index e11b14d9ac..cbc8e103bb 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -164,7 +164,8 @@ typedef struct CPUClass {
>      /*< public >*/
>  
>      ObjectClass *(*class_by_name)(const char *cpu_model);
> -    void (*parse_features)(const char *typename, char *str, Error **errp);
> +    void (*parse_features)(MachineState *machine, const char *typename,
> +                           char *str, Error **errp);
>  
>      void (*reset)(CPUState *cpu);
>      int reset_dump_flags;
> @@ -697,7 +698,7 @@ CPUState *cpu_create(const char *typename);
>   * Returns: type of CPU to create or prints error and terminates process
>   *          if an error occurred.
>   */
> -const char *parse_cpu_option(const char *cpu_option);
> +const char *parse_cpu_option(MachineState *machine, const char *cpu_option);
>  
>  /**
>   * lookup_cpu_class:
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index be9b4c30c3..7891465554 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -167,7 +167,8 @@ typedef struct PowerPCCPUClass {
>      DeviceRealize parent_realize;
>      DeviceUnrealize parent_unrealize;
>      void (*parent_reset)(CPUState *cpu);
> -    void (*parent_parse_features)(const char *type, char *str, Error **errp);
> +    void (*parent_parse_features)(MachineState *machine, const char *type,
> +                                  char *str, Error **errp);
>  
>      uint32_t pvr;
>      bool (*pvr_match)(struct PowerPCCPUClass *pcc, uint32_t pvr);
> diff --git a/exec.c b/exec.c
> index d359e709a6..1ca95df9d8 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -992,7 +992,7 @@ CPUClass *lookup_cpu_class(const char *cpu_model, Error **errp)
>      return CPU_CLASS(oc);
>  }
>  
> -const char *parse_cpu_option(const char *cpu_option)
> +const char *parse_cpu_option(MachineState *machine, const char *cpu_option)
>  {
>      CPUClass *cc;
>      gchar **model_pieces;
> @@ -1002,7 +1002,7 @@ const char *parse_cpu_option(const char *cpu_option)
>  
>      cc = lookup_cpu_class(model_pieces[0], &error_fatal);
>      cpu_type = object_class_get_name(OBJECT_CLASS(cc));
> -    cc->parse_features(cpu_type, model_pieces[1], &error_fatal);
> +    cc->parse_features(machine, cpu_type, model_pieces[1], &error_fatal);
>      g_strfreev(model_pieces);
>      return cpu_type;
>  }
> diff --git a/qom/cpu.c b/qom/cpu.c
> index a8d2958956..c8a7b56148 100644
> --- a/qom/cpu.c
> +++ b/qom/cpu.c
> @@ -291,7 +291,8 @@ ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_model)
>      return cc->class_by_name(cpu_model);
>  }
>  
> -static void cpu_common_parse_features(const char *typename, char *features,
> +static void cpu_common_parse_features(MachineState *machine,
> +                                      const char *typename, char *features,
>                                        Error **errp)
>  {
>      char *val;
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index d6bb57d210..f5e15ac5da 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3528,7 +3528,8 @@ static gint compare_string(gconstpointer a, gconstpointer b)
>  
>  /* Parse "+feature,-feature,feature=foo" CPU feature string
>   */
> -static void x86_cpu_parse_featurestr(const char *typename, char *features,
> +static void x86_cpu_parse_featurestr(MachineState *machine,
> +                                     const char *typename, char *features,
>                                       Error **errp)
>  {
>      char *featurestr; /* Single 'key=value" string being parsed */
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
> index 0bd555eb19..2ad223fcca 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -10119,10 +10119,11 @@ static ObjectClass *ppc_cpu_class_by_name(const char *name)
>      return oc;
>  }
>  
> -static void ppc_cpu_parse_featurestr(const char *type, char *features,
> +static void ppc_cpu_parse_featurestr(MachineState *ms,
> +                                     const char *type, char *features,
>                                       Error **errp)
>  {
> -    Object *machine = qdev_get_machine();
> +    Object *machine = OBJECT(ms);
>      const PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(object_class_by_name(type));
>  
>      if (!features) {
> @@ -10171,7 +10172,7 @@ static void ppc_cpu_parse_featurestr(const char *type, char *features,
>      }
>  
>      /* do property processing with generic handler */
> -    pcc->parent_parse_features(type, features, errp);
> +    pcc->parent_parse_features(ms, type, features, errp);
>  }
>  
>  PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc)
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index 4a4445bdf5..7e360de5ee 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -115,7 +115,8 @@ cpu_add_feat_as_prop(const char *typename, const char *name, const char *val)
>  }
>  
>  /* Parse "+feature,-feature,feature=foo" CPU feature string */
> -static void sparc_cpu_parse_features(const char *typename, char *features,
> +static void sparc_cpu_parse_features(MachineState *machine,
> +                                     const char *typename, char *features,
>                                       Error **errp)
>  {
>      GList *l, *plus_features = NULL, *minus_features = NULL;
> diff --git a/vl.c b/vl.c
> index c57e28d1da..e78c4d5a53 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4466,7 +4466,8 @@ int main(int argc, char **argv, char **envp)
>      /* parse features once if machine provides default cpu_type */
>      current_machine->cpu_type = machine_class->default_cpu_type;
>      if (cpu_option) {
> -        current_machine->cpu_type = parse_cpu_option(cpu_option);
> +        current_machine->cpu_type =
> +            parse_cpu_option(current_machine, cpu_option);
>      }
>      parse_numa_opts(current_machine);

Well, it's not quite as bad as the commit message made me expect: since
we assign to current_machine->cpu_type, we already have a dependence on
machine creation.

Regardless, replacing qdev_get_machine() by explicit data flow is an
improvement.  More so if it really lets us confine qdev_get_machine() to
CONFIG_SOFTMMU.
