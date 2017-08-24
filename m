Received: from eggs.gnu.org ([2001:4830:134:3::10]:38459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkvNT-0003GJ-81
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkvNP-0008Na-75
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:53:07 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:37282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkvNP-0008NJ-1x
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:53:03 -0400
Received: by mail-qt0-x243.google.com with SMTP id g13so7195qta.4
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 09:53:02 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1503592308-93913-1-git-send-email-imammedo@redhat.com>
	<1503592308-93913-7-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5f5aec1b-2891-d65a-6b48-0bc236d3b267@amsat.org>
Date: Thu, 24 Aug 2017 13:52:56 -0300
MIME-Version: 1.0
In-Reply-To: <1503592308-93913-7-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.11 v3 06/25] sparc: make cpu feature
 parsing property based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>

On 08/24/2017 01:31 PM, Igor Mammedov wrote:
> with features converted to properties we can use the same
> approach as x86 for features parsing and drop legacy
> approach that manipulated CPU instance directly.
> New sparc_cpu_parse_features() will allow only +-feat
> and explicitly disable feat=on|off syntax for now.
> 
> With that in place and sparc_cpu_parse_features() providing
> generic CPUClass::parse_features callback, the cpu_sparc_init()
> will do the same job as cpu_generic_init() so replace content
> of cpu_sparc_init() with it.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> CC: Riku Voipio <riku.voipio@iki.fi>
> CC: Laurent Vivier <laurent@vivier.eu>
> CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> CC: Artyom Tarasenko <atar4qemu@gmail.com>
> CC: Philippe Mathieu-Daudé <f4bug@amsat.org>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> 
> v3:
>    * drop cpu_legacy_parse_featurestr() and reimplement
>      sparc_cpu_parse_features() similar to x86 parser
>      but without x86 baggage.
> v2:
>    * use new cpu_legacy_parse_featurestr() without
>      plus_features/minus_features
>    * drop cpu_legacy_apply_features() as it's been removed in
>      previuos patch and new cpu_legacy_parse_featurestr()
>      does its job
> ---
>   target/sparc/cpu.c | 208 +++++++++++++++++++----------------------------------
>   1 file changed, 75 insertions(+), 133 deletions(-)
> 
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index 9dfc150..c02ca85 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -104,50 +104,92 @@ static void cpu_sparc_disas_set_info(CPUState *cpu, disassemble_info *info)
>   #endif
>   }
>   
> -static void sparc_cpu_parse_features(CPUState *cs, char *features,
> -                                     Error **errp);
> +static void
> +cpu_add_feat_as_prop(const char *typename, const char *name, const char *val)
> +{
> +    GlobalProperty *prop = g_new0(typeof(*prop), 1);
> +    prop->driver = typename;
> +    prop->property = g_strdup(name);
> +    prop->value = g_strdup(val);
> +    prop->errp = &error_fatal;
> +    qdev_prop_register_global(prop);
> +}
>   
> -static int cpu_sparc_register(SPARCCPU *cpu, const char *cpu_model)
> +/* Parse "+feature,-feature,feature=foo" CPU feature string */
> +static void sparc_cpu_parse_features(const char *typename, char *features,
> +                                     Error **errp)
>   {
> -    char *s = g_strdup(cpu_model);
> -    char *featurestr = strtok(s, ",");
> -    Error *err = NULL;
> +    GList *l, *plus_features = NULL, *minus_features = NULL;
> +    char *featurestr; /* Single 'key=value" string being parsed */
> +    static bool cpu_globals_initialized;
>   
> -    featurestr = strtok(NULL, ",");
> -    sparc_cpu_parse_features(CPU(cpu), featurestr, &err);
> -    g_free(s);
> -    if (err) {
> -        error_report_err(err);
> -        return -1;
> +    if (cpu_globals_initialized) {
> +        return;
>       }
> +    cpu_globals_initialized = true;
>   
> -    return 0;
> -}
> +    if (!features) {
> +        return;
> +    }
>   
> -SPARCCPU *cpu_sparc_init(const char *cpu_model)
> -{
> -    SPARCCPU *cpu;
> -    ObjectClass *oc;
> -    char *str, *name;
> +    for (featurestr = strtok(features, ",");
> +         featurestr;
> +         featurestr = strtok(NULL, ",")) {
> +        const char *name;
> +        const char *val = NULL;
> +        char *eq = NULL;
>   
> -    str = g_strdup(cpu_model);
> -    name = strtok(str, ",");
> -    oc = cpu_class_by_name(TYPE_SPARC_CPU, name);
> -    g_free(str);
> -    if (oc == NULL) {
> -        return NULL;
> -    }
> +        /* Compatibility syntax: */
> +        if (featurestr[0] == '+') {
> +            plus_features = g_list_append(plus_features,
> +                                          g_strdup(featurestr + 1));
> +            continue;
> +        } else if (featurestr[0] == '-') {
> +            minus_features = g_list_append(minus_features,
> +                                           g_strdup(featurestr + 1));
> +            continue;
> +        }
>   
> -    cpu = SPARC_CPU(object_new(object_class_get_name(oc)));
> +        eq = strchr(featurestr, '=');
> +        name = featurestr;
> +        if (eq) {
> +            *eq++ = 0;
> +            val = eq;
> +            if (!strcasecmp(val, "on") ||
> +                !strcasecmp(val, "off") ||
> +                !strcasecmp(val, "true") ||
> +                !strcasecmp(val, "false")) {
> +                error_setg(errp, "Boolean properties in format %s=%s"
> +                                 " are not supported", name, val);
> +                return;
> +            }
> +        } else {
> +            error_setg(errp, "Unsupported property format: %s", name);
> +            return;
> +        }
> +        cpu_add_feat_as_prop(typename, name, val);
> +    }
>   
> -    if (cpu_sparc_register(cpu, cpu_model) < 0) {
> -        object_unref(OBJECT(cpu));
> -        return NULL;
> +    for (l = plus_features; l; l = l->next) {
> +        const char *name = l->data;
> +        cpu_add_feat_as_prop(typename, name, "on");
> +    }
> +    if (plus_features) {
> +        g_list_free_full(plus_features, g_free);
>       }
>   
> -    object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
> +    for (l = minus_features; l; l = l->next) {
> +        const char *name = l->data;
> +        cpu_add_feat_as_prop(typename, name, "off");
> +    }
> +    if (minus_features) {
> +        g_list_free_full(minus_features, g_free);
> +    }
> +}
>   
> -    return cpu;
> +SPARCCPU *cpu_sparc_init(const char *cpu_model)
> +{
> +    return SPARC_CPU(cpu_generic_init(TYPE_SPARC_CPU, cpu_model));
>   }
>   
>   void cpu_sparc_set_id(CPUSPARCState *env, unsigned int cpu)
> @@ -528,107 +570,6 @@ static void print_features(FILE *f, fprintf_function cpu_fprintf,
>       }
>   }
>   
> -static void add_flagname_to_bitmaps(const char *flagname, uint32_t *features)
> -{
> -    unsigned int i;
> -
> -    for (i = 0; i < ARRAY_SIZE(feature_name); i++) {
> -        if (feature_name[i] && !strcmp(flagname, feature_name[i])) {
> -            *features |= 1 << i;
> -            return;
> -        }
> -    }
> -    error_report("CPU feature %s not found", flagname);
> -}
> -
> -static void sparc_cpu_parse_features(CPUState *cs, char *features,
> -                                     Error **errp)
> -{
> -    SPARCCPU *cpu = SPARC_CPU(cs);
> -    sparc_def_t *cpu_def = &cpu->env.def;
> -    char *featurestr;
> -    uint32_t plus_features = 0;
> -    uint32_t minus_features = 0;
> -    uint64_t iu_version;
> -    uint32_t fpu_version, mmu_version, nwindows;
> -
> -    featurestr = features ? strtok(features, ",") : NULL;
> -    while (featurestr) {
> -        char *val;
> -
> -        if (featurestr[0] == '+') {
> -            add_flagname_to_bitmaps(featurestr + 1, &plus_features);
> -        } else if (featurestr[0] == '-') {
> -            add_flagname_to_bitmaps(featurestr + 1, &minus_features);
> -        } else if ((val = strchr(featurestr, '='))) {
> -            *val = 0; val++;
> -            if (!strcmp(featurestr, "iu_version")) {
> -                char *err;
> -
> -                iu_version = strtoll(val, &err, 0);
> -                if (!*val || *err) {
> -                    error_setg(errp, "bad numerical value %s", val);
> -                    return;
> -                }
> -                cpu_def->iu_version = iu_version;
> -#ifdef DEBUG_FEATURES
> -                fprintf(stderr, "iu_version %" PRIx64 "\n", iu_version);
> -#endif
> -            } else if (!strcmp(featurestr, "fpu_version")) {
> -                char *err;
> -
> -                fpu_version = strtol(val, &err, 0);
> -                if (!*val || *err) {
> -                    error_setg(errp, "bad numerical value %s", val);
> -                    return;
> -                }
> -                cpu_def->fpu_version = fpu_version;
> -#ifdef DEBUG_FEATURES
> -                fprintf(stderr, "fpu_version %x\n", fpu_version);
> -#endif
> -            } else if (!strcmp(featurestr, "mmu_version")) {
> -                char *err;
> -
> -                mmu_version = strtol(val, &err, 0);
> -                if (!*val || *err) {
> -                    error_setg(errp, "bad numerical value %s", val);
> -                    return;
> -                }
> -                cpu_def->mmu_version = mmu_version;
> -#ifdef DEBUG_FEATURES
> -                fprintf(stderr, "mmu_version %x\n", mmu_version);
> -#endif
> -            } else if (!strcmp(featurestr, "nwindows")) {
> -                char *err;
> -
> -                nwindows = strtol(val, &err, 0);
> -                if (!*val || *err || nwindows > MAX_NWINDOWS ||
> -                    nwindows < MIN_NWINDOWS) {
> -                    error_setg(errp, "bad numerical value %s", val);
> -                    return;
> -                }
> -                cpu_def->nwindows = nwindows;
> -#ifdef DEBUG_FEATURES
> -                fprintf(stderr, "nwindows %d\n", nwindows);
> -#endif
> -            } else {
> -                error_setg(errp, "unrecognized feature %s", featurestr);
> -                return;
> -            }
> -        } else {
> -            error_setg(errp, "feature string `%s' not in format "
> -                             "(+feature|-feature|feature=xyz)", featurestr);
> -            return;
> -        }
> -        featurestr = strtok(NULL, ",");
> -    }
> -    cpu_def->features |= plus_features;
> -    cpu_def->features &= ~minus_features;
> -#ifdef DEBUG_FEATURES
> -    print_features(stderr, fprintf, cpu_def->features, NULL);
> -#endif
> -}
> -
>   void sparc_cpu_list(FILE *f, fprintf_function cpu_fprintf)
>   {
>       unsigned int i;
> @@ -931,6 +872,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
>       cc->reset = sparc_cpu_reset;
>   
>       cc->class_by_name = sparc_cpu_class_by_name;
> +    cc->parse_features = sparc_cpu_parse_features;
>       cc->has_work = sparc_cpu_has_work;
>       cc->do_interrupt = sparc_cpu_do_interrupt;
>       cc->cpu_exec_interrupt = sparc_cpu_exec_interrupt;
> 
