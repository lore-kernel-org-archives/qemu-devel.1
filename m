Received: from eggs.gnu.org ([2001:4830:134:3::10]:48616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dilG8-0004TR-Dw
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:40:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dilG5-0004QK-3x
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:40:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dilG4-0004NC-QG
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:40:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 967EC13A90
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 17:40:31 +0000 (UTC)
Date: Fri, 18 Aug 2017 14:40:29 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170818174029.GA27715@localhost.localdomain>
References: <20170816193218.GF3108@localhost.localdomain>
	<1502978877-127751-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502978877-127751-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] target-i386: cpu: convert plus/minus
 properties to global properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, Aug 17, 2017 at 04:07:56PM +0200, Igor Mammedov wrote:
> Since
>  (commit d4a606b3 i386: Don't override -cpu options on -cpu host/max)
> it became possible to delete hack where it was necessary to
> postpone applying plus/minus features to realize time
> after max_features were applied to keep legacy +-feat
> override semantics.
> 
> With above commit it's possible to convert +-feat to a set
> of GlobalProperty items and keep +-feat override semantics,
> these properties should be added to global list at the end
> to override properties that were set with feat=on|off syntax.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
[...]
> +/* Parse "+feature,-feature,feature=foo" CPU feature string */
>  static void x86_cpu_parse_featurestr(const char *typename, char *features,
>                                       Error **errp)
>  {
> +    /* Compatibily hack to maintain legacy +-feat semantic,
> +     * where +-feat overwrites any feature set by
> +     * feat=on|feat even if the later is parsed after +-feat
> +     * (i.e. "-x2apic,x2apic=on" will result in x2apic disabled)
> +     */
> +    GList *l, *plus_features = NULL, *minus_features = NULL;

The warning about ambiguous CPU options exists since 2.8, I think
this is a good opportunity to get rid of the "[+-]feat overrides
feat=on|off" rule and simplify the parsing code.  Do you want to
do this in the same patch?


>      char *featurestr; /* Single 'key=value" string being parsed */
>      static bool cpu_globals_initialized;
>      bool ambiguous = false;
> @@ -2095,7 +2104,6 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
>          const char *val = NULL;
>          char *eq = NULL;
>          char num[32];
> -        GlobalProperty *prop;
>  
>          /* Compatibility syntax: */
>          if (featurestr[0] == '+') {
> @@ -2147,21 +2155,32 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
>              name = "tsc-frequency";
>          }
>  
> -        prop = g_new0(typeof(*prop), 1);
> -        prop->driver = typename;
> -        prop->property = g_strdup(name);
> -        prop->value = g_strdup(val);
> -        prop->errp = &error_fatal;
> -        qdev_prop_register_global(prop);
> +        cpu_add_feat_as_prop(typename, name, val);
>      }
>  
>      if (ambiguous) {
>          warn_report("Compatibility of ambiguous CPU model "
>                      "strings won't be kept on future QEMU versions");
>      }
> +
> +    for (l = plus_features; l; l = l->next) {
> +        const char *name = l->data;
> +        cpu_add_feat_as_prop(typename, name, "on");
> +    }
> +    if (plus_features) {
> +        g_list_free_full(plus_features, g_free);
> +    }
> +
> +    for (l = minus_features; l; l = l->next) {
> +        const char *name = l->data;
> +        cpu_add_feat_as_prop(typename, name, "off");
> +    }
> +    if (minus_features) {
> +        g_list_free_full(minus_features, g_free);
> +    }
>  }
>  
> -static void x86_cpu_expand_features(X86CPU *cpu, Error **errp);
> +static void x86_cpu_expand_features(X86CPU *cpu);
>  static int x86_cpu_filter_features(X86CPU *cpu);
>  
>  /* Check for missing features that may prevent the CPU class from
> @@ -2172,7 +2191,6 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
>  {
>      X86CPU *xc;
>      FeatureWord w;
> -    Error *err = NULL;
>      strList **next = missing_feats;
>  
>      if (xcc->kvm_required && !kvm_enabled()) {
> @@ -2184,18 +2202,7 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
>  
>      xc = X86_CPU(object_new(object_class_get_name(OBJECT_CLASS(xcc))));
>  
> -    x86_cpu_expand_features(xc, &err);
> -    if (err) {
> -        /* Errors at x86_cpu_expand_features should never happen,
> -         * but in case it does, just report the model as not
> -         * runnable at all using the "type" property.
> -         */
> -        strList *new = g_new0(strList, 1);
> -        new->value = g_strdup("type");
> -        *next = new;
> -        next = &new->next;
> -    }
> -
> +    x86_cpu_expand_features(xc);
>      x86_cpu_filter_features(xc);
>  
>      for (w = 0; w < FEATURE_WORDS; w++) {
> @@ -2559,11 +2566,7 @@ static X86CPU *x86_cpu_from_model(const char *model, QDict *props, Error **errp)
>          }
>      }
>  
> -    x86_cpu_expand_features(xc, &err);
> -    if (err) {
> -        goto out;
> -    }
> -
> +    x86_cpu_expand_features(xc);
>  out:
>      if (err) {
>          error_propagate(errp, err);
> @@ -3453,18 +3456,11 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
>  /* Expand CPU configuration data, based on configured features
>   * and host/accelerator capabilities when appropriate.
>   */
> -static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
> +static void x86_cpu_expand_features(X86CPU *cpu)
>  {
>      CPUX86State *env = &cpu->env;
>      FeatureWord w;
> -    GList *l;
> -    Error *local_err = NULL;
>  
> -    /*TODO: Now cpu->max_features doesn't overwrite features
> -     * set using QOM properties, and we can convert
> -     * plus_features & minus_features to global properties
> -     * inside x86_cpu_parse_featurestr() too.
> -     */
>      if (cpu->max_features) {
>          for (w = 0; w < FEATURE_WORDS; w++) {
>              /* Override only features that weren't set explicitly
> @@ -3476,22 +3472,6 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>          }
>      }
>  
> -    for (l = plus_features; l; l = l->next) {
> -        const char *prop = l->data;
> -        object_property_set_bool(OBJECT(cpu), true, prop, &local_err);
> -        if (local_err) {
> -            goto out;
> -        }
> -    }
> -
> -    for (l = minus_features; l; l = l->next) {
> -        const char *prop = l->data;
> -        object_property_set_bool(OBJECT(cpu), false, prop, &local_err);
> -        if (local_err) {
> -            goto out;
> -        }
> -    }
> -
>      if (!kvm_enabled() || !cpu->expose_kvm) {
>          env->features[FEAT_KVM] = 0;
>      }
> @@ -3527,11 +3507,6 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>      if (env->cpuid_xlevel2 == UINT32_MAX) {
>          env->cpuid_xlevel2 = env->cpuid_min_xlevel2;
>      }
> -
> -out:
> -    if (local_err != NULL) {
> -        error_propagate(errp, local_err);
> -    }
>  }
>  
>  /*
> @@ -3587,10 +3562,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> -    x86_cpu_expand_features(cpu, &local_err);
> -    if (local_err) {
> -        goto out;
> -    }
> +    x86_cpu_expand_features(cpu);
>  
>      if (x86_cpu_filter_features(cpu) &&
>          (cpu->check_cpuid || cpu->enforce_cpuid)) {
> -- 
> 2.7.4
> 
> 

-- 
Eduardo
