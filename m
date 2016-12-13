Received: from eggs.gnu.org ([2001:4830:134:3::10]:54636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cGsd6-0002b6-4p
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 14:20:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cGsd1-0005dJ-1C
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 14:20:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cGsd0-0005d5-IE
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 14:20:42 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C034380088
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 19:20:41 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1480713496-11213-1-git-send-email-ehabkost@redhat.com>
	<1480713496-11213-18-git-send-email-ehabkost@redhat.com>
	<87zik0qgm6.fsf@dusky.pond.sub.org>
	<20161213125547.GQ3808@thinpad.lan.raisama.net>
Date: Tue, 13 Dec 2016 20:20:39 +0100
In-Reply-To: <20161213125547.GQ3808@thinpad.lan.raisama.net> (Eduardo
	Habkost's message of "Tue, 13 Dec 2016 10:55:47 -0200")
Message-ID: <87shprljp4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.9 17/17] target-i386: Implement
 query-cpu-model-expansion QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: libvir-list@redhat.com, Jiri Denemark <jdenemar@redhat.com>, qemu-devel@nongnu.org

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Tue, Dec 13, 2016 at 11:16:01AM +0100, Markus Armbruster wrote:
>> Eduardo Habkost <ehabkost@redhat.com> writes:
>> 
>> > Implement query-cpu-model-expansion for target-i386.
>> >
>> > The code needs to be careful to handle non-migration-safe
>> > features ("pmu" and "host-cache-info") according to the expansion
>> > type.
>> >
>> > Cc: libvir-list@redhat.com
>> > Cc: Jiri Denemark <jdenemar@redhat.com>
>> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> > ---
>> >  tests/Makefile.include |   3 +
>> >  monitor.c              |   4 +-
>> >  target-i386/cpu.c      | 195 ++++++++++++++++++++++++++++++++++++++++++++++++-
>> >  3 files changed, 200 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/tests/Makefile.include b/tests/Makefile.include
>> > index 63c4347..c7bbfca 100644
>> > --- a/tests/Makefile.include
>> > +++ b/tests/Makefile.include
>> > @@ -251,6 +251,9 @@ check-qtest-x86_64-y += $(check-qtest-i386-y)
>> >  gcov-files-i386-y += i386-softmmu/hw/timer/mc146818rtc.c
>> >  gcov-files-x86_64-y = $(subst i386-softmmu/,x86_64-softmmu/,$(gcov-files-i386-y))
>> >  
>> > +check-simpleqtest-x86_64-y += $(SRC_PATH)/tests/query-cpu-model-test.py
>> > +check-simpleqtest-i386-y += $(SRC_PATH)/tests/query-cpu-model-test.py
>> > +
>> >  check-qtest-alpha-y = tests/boot-serial-test$(EXESUF)
>> >  
>> >  check-qtest-mips-y = tests/endianness-test$(EXESUF)
>> > diff --git a/monitor.c b/monitor.c
>> > index 0841d43..90c12b3 100644
>> > --- a/monitor.c
>> > +++ b/monitor.c
>> > @@ -983,8 +983,10 @@ static void qmp_unregister_commands_hack(void)
>> >  #ifndef TARGET_ARM
>> >      qmp_unregister_command("query-gic-capabilities");
>> >  #endif
>> > -#if !defined(TARGET_S390X)
>> > +#if !defined(TARGET_S390X) && !defined(TARGET_I386)
>> >      qmp_unregister_command("query-cpu-model-expansion");
>> > +#endif
>> > +#if !defined(TARGET_S390X)
>> >      qmp_unregister_command("query-cpu-model-baseline");
>> >      qmp_unregister_command("query-cpu-model-comparison");
>> >  #endif
>> > diff --git a/target-i386/cpu.c b/target-i386/cpu.c
>> > index bf4ac09..198014a 100644
>> > --- a/target-i386/cpu.c
>> > +++ b/target-i386/cpu.c
>> > @@ -29,10 +29,14 @@
>> >  #include "qemu/option.h"
>> >  #include "qemu/config-file.h"
>> >  #include "qapi/qmp/qerror.h"
>> > +#include "qapi/qmp/qstring.h"
>> > +#include "qapi/qmp/qdict.h"
>> > +#include "qapi/qmp/qbool.h"
>> >  
>> >  #include "qapi-types.h"
>> >  #include "qapi-visit.h"
>> >  #include "qapi/visitor.h"
>> > +#include "qom/qom-qobject.h"
>> >  #include "sysemu/arch_init.h"
>> >  
>> >  #if defined(CONFIG_KVM)
>> > @@ -2259,7 +2263,7 @@ static void x86_cpu_apply_props(X86CPU *cpu, PropValue *props)
>> >      }
>> >  }
>> >  
>> > -/* Load data from X86CPUDefinition
>> > +/* Load data from X86CPUDefinition into a X86CPU object
>> >   */
>> >  static void x86_cpu_load_def(X86CPU *cpu, X86CPUDefinition *def, Error **errp)
>> >  {
>> > @@ -2268,6 +2272,11 @@ static void x86_cpu_load_def(X86CPU *cpu, X86CPUDefinition *def, Error **errp)
>> >      char host_vendor[CPUID_VENDOR_SZ + 1];
>> >      FeatureWord w;
>> >  
>> > +    /*NOTE: any property set by this function should be returned by
>> 
>> Space between /* and comment text, please.
>> 
>> Also, consider adding wings to both ends of multi-line comments.
>
> Will do.
>
>> 
>> > +     * x86_cpu_to_dict(), so CPU model data returned by
>> > +     * query-cpu-model-expansion is always complete.
>> > +     */
>> > +
>> >      /* CPU models only set _minimum_ values for level/xlevel: */
>> >      object_property_set_int(OBJECT(cpu), def->level, "min-level", errp);
>> >      object_property_set_int(OBJECT(cpu), def->xlevel, "min-xlevel", errp);
>> > @@ -2312,6 +2321,190 @@ static void x86_cpu_load_def(X86CPU *cpu, X86CPUDefinition *def, Error **errp)
>> >  
>> >  }
>> >  
>> > +/* Convert CPU model data from X86CPU object to a property dictionary
>> > + * that can recreate exactly the same CPU model.
>> > + *
>> > + * This function does the opposite of x86_cpu_load_def(). Any
>> > + * property changed by x86_cpu_load_def() or instance_init
>> > + * methods should be returned by this function too.
>> > + */
>> > +static void x86_cpu_to_dict(X86CPU *cpu, QDict *props, Error **errp)
>> > +{
>> > +    Object *obj = OBJECT(cpu);
>> > +    FeatureWord w;
>> > +    PropValue *pv;
>> > +
>> > +    /* This code could simply iterate over all writeable properties in the
>> > +     * CPU object, and return all of them. But then the aliases properties
>> 
>> "alias properties"?
>
> Will fix it.
>
>> 
>> > +     * would be returned as well. Returning only the known features
>> > +     * is more reliable.
>> > +     */
>> > +    qdict_put_obj(props, "min-level",
>> > +                  object_property_get_qobject(obj, "min-level", errp));
>> > +    qdict_put_obj(props, "min-xlevel",
>> > +                  object_property_get_qobject(obj, "min-xlevel", errp));
>> > +
>> > +    qdict_put_obj(props, "family",
>> > +                  object_property_get_qobject(obj, "family", errp));
>> > +    qdict_put_obj(props, "model",
>> > +                  object_property_get_qobject(obj, "model", errp));
>> > +    qdict_put_obj(props, "stepping",
>> > +                  object_property_get_qobject(obj, "stepping", errp));
>> > +    qdict_put_obj(props, "model-id",
>> > +                  object_property_get_qobject(obj, "model-id", errp));
>> 
>> Incorrect use of the error API: if more than one call fails, the second
>> failure will trip the assertion in error_setv().
>> 
>> If errors should not happen here, use &error_abort.
>> 
>> If errors need to be handled, see "Receive and accumulate multiple
>> errors" in error.h.
>> 
>
> Oops. I will fix it.
>
>> Consider "more than four, use a for":
>> 
>>        static char *prop_name[] = {
>>            "min-level", "min-xlevel", "family", "model", "stepping",
>>            "model-id", NULL
>>        };
>> 
>>        for (pname = prop_name; *pname, pname++) {
>>            qdict_put_obj(props, *pname,
>>                          object_property_get_qobject(obj, *pname,
>>                                                      &error_abort));
>>        }
>
> Good idea, I will do it.
>
>> 
>> > +
>> > +    for (w = 0; w < FEATURE_WORDS; w++) {
>> > +        FeatureWordInfo *fi = &feature_word_info[w];
>> > +        int bit;
>> > +        for (bit = 0; bit < 32; bit++) {
>> > +            if (!fi->feat_names[bit]) {
>> > +                continue;
>> > +            }
>> > +            qdict_put_obj(props, fi->feat_names[bit],
>> > +                          object_property_get_qobject(obj, fi->feat_names[bit],
>> > +                                                      errp));
>> > +        }
>> > +    }
>> > +
>> > +    for (pv = kvm_default_props; pv->prop; pv++) {
>> > +        qdict_put_obj(props, pv->prop,
>> > +                      object_property_get_qobject(obj, pv->prop, errp));
>> > +    }
>> > +    for (pv = tcg_default_props; pv->prop; pv++) {
>> > +        qdict_put_obj(props, pv->prop,
>> > +                      object_property_get_qobject(obj, pv->prop, errp));
>> > +    }
>> > +
>> > +    qdict_put_obj(props, "vendor",
>> > +                  object_property_get_qobject(obj, "vendor", errp));
>> > +
>> > +    /* Set by "host": */
>> > +    qdict_put_obj(props, "lmce",
>> > +                  object_property_get_qobject(obj, "lmce", errp));
>> > +    qdict_put_obj(props, "pmu",
>> > +                  object_property_get_qobject(obj, "pmu", errp));
>> > +
>> > +
>> > +    /* Other properties configurable by the user: */
>> > +    qdict_put_obj(props, "host-cache-info",
>> > +                  object_property_get_qobject(obj, "host-cache-info", errp));
>> > +}
>> > +
>> > +static void object_apply_props(Object *obj, QDict *props, Error **errp)
>> > +{
>> > +    const QDictEntry *prop;
>> > +    Error *err = NULL;
>> > +
>> > +    for (prop = qdict_first(props); prop; prop = qdict_next(props, prop)) {
>> > +        object_property_set_qobject(obj, qdict_entry_value(prop),
>> > +                                         qdict_entry_key(prop), &err);
>> > +        if (err) {
>> > +            break;
>> > +        }
>> > +    }
>> > +
>> > +    error_propagate(errp, err);
>> > +}
>> > +
>> > +static X86CPU *x86_cpu_from_model(CpuModelInfo *model, Error **errp)
>> > +{
>> > +    X86CPU *xc = NULL;
>> > +    X86CPUClass *xcc;
>> > +    Error *err = NULL;
>> > +
>> > +    xcc = X86_CPU_CLASS(cpu_class_by_name(TYPE_X86_CPU, model->name));
>> > +    if (xcc == NULL) {
>> > +        error_setg(&err, "CPU model '%s' not found", model->name);
>> > +        goto out;
>> > +    }
>> > +
>> > +    xc = X86_CPU(object_new(object_class_get_name(OBJECT_CLASS(xcc))));
>> > +    if (model->has_props) {
>> > +        QDict *d = qobject_to_qdict(model->props);
>> > +        if (!d) {
>> > +            error_setg(&err, "model.props must be a dictionary");
>> > +            goto out;
>> 
>> How can this happen?
>
> 'props' is 'any' in the QAPI schema, because (it looks like) QAPI
> doesn't have a 'dict' type.

I see.

>> > +        }
>> > +        object_apply_props(OBJECT(xc), d, &err);
>> > +        if (err) {
>> > +            goto out;
>> > +        }
>> > +    }
>> > +
>> > +    x86_cpu_expand_features(xc, &err);
>> > +    if (err) {
>> > +        goto out;
>> > +    }
>> > +
>> > +out:
>> > +    if (err) {
>> > +        error_propagate(errp, err);
>> > +        object_unref(OBJECT(xc));
>> > +        xc = NULL;
>> > +    }
>> > +    return xc;
>> > +}
>> > +
>> > +CpuModelExpansionInfo *arch_query_cpu_model_expansion(CpuModelExpansionType type,
>> > +                                                      CpuModelInfo *model,
>> > +                                                      Error **errp)
>> > +{
>> > +    X86CPU *xc = NULL;
>> > +    Error *err = NULL;
>> > +    CpuModelExpansionInfo *ret = g_new0(CpuModelExpansionInfo, 1);
>> > +    QDict *props;
>> > +
>> > +    xc = x86_cpu_from_model(model, &err);
>> > +    if (err) {
>> > +        goto out;
>> > +    }
>> > +
>> > +    /* We currently always do full expansion */
>> 
>> This comment made me go "wait, we do full expansion even when @type is
>> CPU_MODEL_EXPANSION_TYPE_STATIC?"  Looks like we first to full
>> expansion, then correct the result according to type.
>
> The comment is a leftover from a previous version where we didn't
> even check expansion type. I will remove it (or clarify it).
>
>> 
>> > +    ret->model = g_new0(CpuModelInfo, 1);
>> > +    ret->model->name = g_strdup("base"); /* the only static model */
>> > +    props = qdict_new();
>> > +    ret->model->props = QOBJECT(props);
>> > +    ret->model->has_props = true;
>> > +    x86_cpu_to_dict(xc, props, &err);
>> > +
>> > +    /* Some features (pmu, host-cache-info) are not migration-safe,
>> > +     * and are handled differently depending on expansion type:
>> > +     */
>> > +    if (type ==  CPU_MODEL_EXPANSION_TYPE_STATIC) {
>> 
>> Single space after ==, please.
>
> Will fix.
>
>> 
>> > +        /* static expansion force migration-unsafe features off: */
>> > +        ret->q_static = ret->migration_safe = true;
>> > +        qdict_del(props, "pmu");
>> > +        qdict_del(props, "host-cache-info");
>> > +    } else if (type == CPU_MODEL_EXPANSION_TYPE_FULL) {
>> > +        QObject *o;
>> > +        /* full expansion clear the static/migration-safe flags
>> > +         * to indicate migration-unsafe features are on:
>> > +         */
>> > +        ret->q_static = true;
>> > +        ret->migration_safe = true;
>> > +
>> > +        o = qdict_get(props, "pmu");
>> > +        if (o && qbool_get_bool(qobject_to_qbool(o))) {
>> > +            ret->q_static = ret->migration_safe = false;
>> > +        }
>> > +        o = qdict_get(props, "host-cache-info");
>> > +        if (o && qbool_get_bool(qobject_to_qbool(o))) {
>> > +            ret->q_static = ret->migration_safe = false;
>> > +        }
>> > +    } else {
>> > +        error_setg(&err, "The requested expansion type is not supported.");
>> 
>> How can this happen?
>> 
>> If it can, it bombs when x86_cpu_to_dict() already set an error (see
>> "use of the error API" above).
>
> This can happen if we change the QAPI schema to support another
> expansion type in the future.

I'd make this an assertion, because it's a programming error.

>
>> 
>> > +    }
>> > +
>> > +out:
>> > +    object_unref(OBJECT(xc));
>> > +    if (err) {
>> > +        error_propagate(errp, err);
>> > +        qapi_free_CpuModelExpansionInfo(ret);
>> > +        ret = NULL;
>> > +    }
>> > +    return ret;
>> > +}
>> > +
>> >  X86CPU *cpu_x86_init(const char *cpu_model)
>> >  {
>> >      return X86_CPU(cpu_generic_init(TYPE_X86_CPU, cpu_model));
