Received: from eggs.gnu.org ([2001:4830:134:3::10]:34135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1djkMU-0000oF-UW
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 06:55:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1djkMQ-0003d8-Co
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 06:55:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1djkMQ-0003cF-32
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 06:55:10 -0400
Date: Mon, 21 Aug 2017 12:55:05 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170821125505.37ce8935@nial.brq.redhat.com>
In-Reply-To: <c65c99e5-5d60-5aef-7e69-ce236f6b7d4e@amsat.org>
References: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
	<1503050939-227939-2-git-send-email-imammedo@redhat.com>
	<c65c99e5-5d60-5aef-7e69-ce236f6b7d4e@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.11 01/27] sparc: convert cpu models
 to SPARC cpu subclasses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

On Fri, 18 Aug 2017 16:00:37 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Hi Igor,
>=20
> On 08/18/2017 07:08 AM, Igor Mammedov wrote:
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
> > CC: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >=20
> > v2:
> >    * make base class abstract (Philippe Mathieu-Daud=C3=A9 <f4bug@amsat=
.org>)
> > ---
> >   target/sparc/cpu-qom.h |   2 +
> >   target/sparc/cpu.c     | 121 +++++++++++++++++++++++++++++++++-------=
---------
> >   2 files changed, 84 insertions(+), 39 deletions(-)
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
> > index d606eb5..2994c09 100644
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
> > +    name =3D strtok(str, ","); =20
>=20
> you can free 'str' once here:
>=20
>         g_free(str);
>=20
> > +    oc =3D cpu_class_by_name(TYPE_SPARC_CPU, name);
> > +    if (oc =3D=3D NULL) {
> > +        g_free(str); =20
>=20
> drop
>=20
> > +        return NULL;
> > +    }
> > +    g_free(str); =20
>=20
> drop

I'll fix it up if I have to respin series (note this function is removed wi=
thin series)

[...]
=20

> Anyway I can't start Aurelien's image [1] with this commit:
Can't reproduce it locally (either dirty/clean tree rebuild)
with ./configure --enable-debug

=20
> $ sparc-softmmu/qemu-system-sparc -hda debian_etch_sparc_small.qcow2
> qemu: Unable to find Sparc CPU definition
for this kind of error guest image doesn't matter as error happens during m=
achine_init()

> [1] https://people.debian.org/~aurel32/qemu/sparc/
It boots just fine with default CPU model:

./sparc-softmmu/qemu-system-sparc -hda debian_etch_sparc_small.qcow2

and with explicitly specified one:

sparc-softmmu/qemu-system-sparc -cpu "Fujitsu MB86904"

I get from "info qom-tree"
...
 /device[0] (Fujitsu-MB86904-sparc-cpu)
...
