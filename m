Received: from eggs.gnu.org ([2001:4830:134:3::10]:33033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1diLeK-000856-Ra
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 10:19:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1diLeJ-00009m-40
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 10:19:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1diLeI-00009A-Qo
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 10:19:51 -0400
Date: Thu, 17 Aug 2017 16:11:11 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170817161111.59a2a172@nial.brq.redhat.com>
In-Reply-To: <1271b275-1b18-4e1a-b59c-976c723e8062@amsat.org>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
	<1500040339-119465-5-git-send-email-imammedo@redhat.com>
	<1271b275-1b18-4e1a-b59c-976c723e8062@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/28] sparc: convert cpu models to SPARC
 cpu subclasses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Andreas =?UTF-8?B?RsOkcmJl?= =?UTF-8?B?cg==?= <afaerber@suse.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>

On Thu, 17 Aug 2017 00:50:50 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> On 07/14/2017 10:51 AM, Igor Mammedov wrote:
> > QOMfy cpu models handling introducing propper cpu types
> > for each cpu model.
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > with this and conversion of features to properties,
> > it would be possible to replace cpu_sparc_init() with
> > cpu_generic_init() and reuse common -cpu handling
> > infrastructure.
> >=20
> > CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > CC: Artyom Tarasenko <atar4qemu@gmail.com>
> > ---
> >   target/sparc/cpu-qom.h |   2 +
> >   target/sparc/cpu.c     | 119 +++++++++++++++++++++++++++++++++-------=
---------
> >   2 files changed, 83 insertions(+), 38 deletions(-)
> >=20
> > diff --git a/target/sparc/cpu-qom.h b/target/sparc/cpu-qom.h
> > index f63af72..af6d57a 100644
> > --- a/target/sparc/cpu-qom.h
> > +++ b/target/sparc/cpu-qom.h
> > @@ -35,6 +35,7 @@
> >   #define SPARC_CPU_GET_CLASS(obj) \
> >       OBJECT_GET_CLASS(SPARCCPUClass, (obj), TYPE_SPARC_CPU)
> >  =20
> > +typedef struct sparc_def_t sparc_def_t;
> >   /**
> >    * SPARCCPUClass:
> >    * @parent_realize: The parent class' realize handler.
> > @@ -49,6 +50,7 @@ typedef struct SPARCCPUClass {
> >  =20
> >       DeviceRealize parent_realize;
> >       void (*parent_reset)(CPUState *cpu);
> > +    sparc_def_t *cpu_def;
> >   } SPARCCPUClass;
> >  =20
> >   typedef struct SPARCCPU SPARCCPU;
> > diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> > index d606eb5..f8cf751 100644
> > --- a/target/sparc/cpu.c
> > +++ b/target/sparc/cpu.c
> > @@ -25,8 +25,6 @@
> >  =20
> >   //#define DEBUG_FEATURES
> >  =20
> > -static int cpu_sparc_find_by_name(sparc_def_t *cpu_def, const char *cp=
u_model);
> > -
> >   /* CPUClass::reset() */
> >   static void sparc_cpu_reset(CPUState *s)
> >   {
> > @@ -111,17 +109,9 @@ static int cpu_sparc_register(SPARCCPU *cpu, const=
 char *cpu_model)
> >   {
> >       CPUSPARCState *env =3D &cpu->env;
> >       char *s =3D g_strdup(cpu_model);
> > -    char *featurestr, *name =3D strtok(s, ",");
> > -    sparc_def_t def1, *def =3D &def1;
> > +    char *featurestr =3D strtok(s, ",");
> >       Error *err =3D NULL;
> >  =20
> > -    if (cpu_sparc_find_by_name(def, name) < 0) {
> > -        g_free(s);
> > -        return -1;
> > -    }
> > -
> > -    env->def =3D g_memdup(def, sizeof(*def));
> > -
> >       featurestr =3D strtok(NULL, ",");
> >       sparc_cpu_parse_features(CPU(cpu), featurestr, &err);
> >       g_free(s);
> > @@ -130,18 +120,18 @@ static int cpu_sparc_register(SPARCCPU *cpu, cons=
t char *cpu_model)
> >           return -1;
> >       }
> >  =20
> > -    env->version =3D def->iu_version;
> > -    env->fsr =3D def->fpu_version;
> > -    env->nwindows =3D def->nwindows;
> > +    env->version =3D env->def->iu_version;
> > +    env->fsr =3D env->def->fpu_version;
> > +    env->nwindows =3D env->def->nwindows;
> >   #if !defined(TARGET_SPARC64)
> > -    env->mmuregs[0] |=3D def->mmu_version;
> > +    env->mmuregs[0] |=3D env->def->mmu_version;
> >       cpu_sparc_set_id(env, 0);
> > -    env->mxccregs[7] |=3D def->mxcc_version;
> > +    env->mxccregs[7] |=3D env->def->mxcc_version;
> >   #else
> > -    env->mmu_version =3D def->mmu_version;
> > -    env->maxtl =3D def->maxtl;
> > -    env->version |=3D def->maxtl << 8;
> > -    env->version |=3D def->nwindows - 1;
> > +    env->mmu_version =3D env->def->mmu_version;
> > +    env->maxtl =3D env->def->maxtl;
> > +    env->version |=3D env->def->maxtl << 8;
> > +    env->version |=3D env->def->nwindows - 1;
> >   #endif
> >       return 0;
> >   }
> > @@ -149,8 +139,19 @@ static int cpu_sparc_register(SPARCCPU *cpu, const=
 char *cpu_model)
> >   SPARCCPU *cpu_sparc_init(const char *cpu_model)
> >   {
> >       SPARCCPU *cpu;
> > +    ObjectClass *oc;
> > +    char *str, *name;
> > +
> > +    str =3D g_strdup(cpu_model);
> > +    name =3D strtok(str, ",");
> > +    oc =3D cpu_class_by_name(TYPE_SPARC_CPU, name);
> > +    if (oc =3D=3D NULL) {
> > +        g_free(str);
> > +        return NULL;
> > +    }
> > +    g_free(str);
> >  =20
> > -    cpu =3D SPARC_CPU(object_new(TYPE_SPARC_CPU));
> > +    cpu =3D SPARC_CPU(object_new(object_class_get_name(oc)));
> >  =20
> >       if (cpu_sparc_register(cpu, cpu_model) < 0) {
> >           object_unref(OBJECT(cpu));
> > @@ -553,23 +554,6 @@ static void add_flagname_to_bitmaps(const char *fl=
agname, uint32_t *features)
> >       error_report("CPU feature %s not found", flagname);
> >   }
> >  =20
> > -static int cpu_sparc_find_by_name(sparc_def_t *cpu_def, const char *na=
me)
> > -{
> > -    unsigned int i;
> > -    const sparc_def_t *def =3D NULL;
> > -
> > -    for (i =3D 0; i < ARRAY_SIZE(sparc_defs); i++) {
> > -        if (strcasecmp(name, sparc_defs[i].name) =3D=3D 0) {
> > -            def =3D &sparc_defs[i];
> > -        }
> > -    }
> > -    if (!def) {
> > -        return -1;
> > -    }
> > -    memcpy(cpu_def, def, sizeof(*def));
> > -    return 0;
> > -}
> > -
> >   static void sparc_cpu_parse_features(CPUState *cs, char *features,
> >                                        Error **errp)
> >   {
> > @@ -796,6 +780,36 @@ static bool sparc_cpu_has_work(CPUState *cs)
> >              cpu_interrupts_enabled(env);
> >   }
> >  =20
> > +static char *sparc_cpu_type_name(const char *cpu_model)
> > +{
> > +    char *name =3D g_strdup_printf("%s-" TYPE_SPARC_CPU, cpu_model);
> > +    char *s =3D name;
> > +
> > +    /* SPARC cpu model names happen to have whitespaces,
> > +     * as type names shouldn't have spaces replace them with '-'
> > +     */
> > +    while ((s =3D strchr(s, ' '))) {
> > +        *s =3D '-';
> > +    }
> > +
> > +    return name;
> > +}
> > +
> > +static ObjectClass *sparc_cpu_class_by_name(const char *cpu_model)
> > +{
> > +    ObjectClass *oc;
> > +    char *typename;
> > +
> > +    if (cpu_model =3D=3D NULL) {
> > +        return NULL;
> > +    }
> > +
> > +    typename =3D sparc_cpu_type_name(cpu_model);
> > +    oc =3D object_class_by_name(typename);
> > +    g_free(typename);
> > +    return oc;
> > +}
> > +
> >   static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
> >   {
> >       CPUState *cs =3D CPU(dev);
> > @@ -825,6 +839,7 @@ static void sparc_cpu_initfn(Object *obj)
> >   {
> >       CPUState *cs =3D CPU(obj);
> >       SPARCCPU *cpu =3D SPARC_CPU(obj);
> > +    SPARCCPUClass *scc =3D SPARC_CPU_GET_CLASS(obj);
> >       CPUSPARCState *env =3D &cpu->env;
> >  =20
> >       cs->env_ptr =3D env;
> > @@ -832,6 +847,8 @@ static void sparc_cpu_initfn(Object *obj)
> >       if (tcg_enabled()) {
> >           gen_intermediate_code_init(env);
> >       }
> > +
> > +    env->def =3D g_memdup(scc->cpu_def, sizeof(*scc->cpu_def));
> >   }
> >  =20
> >   static void sparc_cpu_uninitfn(Object *obj)
> > @@ -854,6 +871,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, v=
oid *data)
> >       scc->parent_reset =3D cc->reset;
> >       cc->reset =3D sparc_cpu_reset;
> >  =20
> > +    cc->class_by_name =3D sparc_cpu_class_by_name;
> >       cc->has_work =3D sparc_cpu_has_work;
> >       cc->do_interrupt =3D sparc_cpu_do_interrupt;
> >       cc->cpu_exec_interrupt =3D sparc_cpu_exec_interrupt;
> > @@ -893,9 +911,34 @@ static const TypeInfo sparc_cpu_type_info =3D { =20
>=20
> Same here, shouldn't this class be now abstract?
it should, I'll post v2 series for review with this fixed
since this and 8/28 change causes too many conflicts and
series doesn't apply to current master cleanly so it
has to be rebased anyway.

>=20
> >       .class_init =3D sparc_cpu_class_init,
> >   };
> >  =20
> > +static void sparc_cpu_cpudef_class_init(ObjectClass *oc, void *data)
> > +{
> > +    SPARCCPUClass *scc =3D SPARC_CPU_CLASS(oc);
> > +    scc->cpu_def =3D data;
> > +}
> > +
> > +static void sparc_register_cpudef_type(const struct sparc_def_t *def)
> > +{
> > +    char *typename =3D sparc_cpu_type_name(def->name);
> > +    TypeInfo ti =3D {
> > +        .name =3D typename,
> > +        .parent =3D TYPE_SPARC_CPU,
> > +        .class_init =3D sparc_cpu_cpudef_class_init,
> > +        .class_data =3D (void *)def,
> > +    };
> > +
> > +    type_register(&ti);
> > +    g_free(typename);
> > +}
> > +
> >   static void sparc_cpu_register_types(void)
> >   {
> > +    int i;
> > +
> >       type_register_static(&sparc_cpu_type_info);
> > +    for (i =3D 0; i < ARRAY_SIZE(sparc_defs); i++) {
> > +        sparc_register_cpudef_type(&sparc_defs[i]);
> > +    }
> >   }
> >  =20
> >   type_init(sparc_cpu_register_types)
> >  =20
