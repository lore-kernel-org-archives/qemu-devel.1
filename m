Received: from eggs.gnu.org ([2001:4830:134:3::10]:60984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dz2Fc-0001UG-TN
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:03:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dz2FW-0001Yx-NG
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:03:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dz2FW-0001YO-EB
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:03:14 -0400
Date: Mon, 2 Oct 2017 17:03:11 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171002170311.70b0dc73@nial.brq.redhat.com>
In-Reply-To: <a8b954a0-255b-0790-fdf0-7d173a5ed3ac@amsat.org>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-5-git-send-email-imammedo@redhat.com>
	<a8b954a0-255b-0790-fdf0-7d173a5ed3ac@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/38] cris: cleanup cpu type name
 composition
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, edgar.iglesias@gmail.com
List-ID: <qemu-devel.nongnu.org>

On Mon, 2 Oct 2017 11:51:42 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Hi Igor,
>=20
> On 10/02/2017 06:07 AM, Igor Mammedov wrote:
> > replace ambiguous TYPE macro with a new CRIS_CPU_TYPE_NAME
> > and use it consistently in the code.
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > CC: edgar.iglesias@gmail.com
> > ---
> >   target/cris/cpu.h |  3 ++
> >   target/cris/cpu.c | 93 +++++++++++++++++++++++-----------------------=
---------
> >   2 files changed, 42 insertions(+), 54 deletions(-)
> >=20
> > diff --git a/target/cris/cpu.h b/target/cris/cpu.h
> > index 5d822de..b64fa35 100644
> > --- a/target/cris/cpu.h
> > +++ b/target/cris/cpu.h
> > @@ -269,6 +269,9 @@ enum {
> >  =20
> >   #define cpu_init(cpu_model) cpu_generic_init(TYPE_CRIS_CPU, cpu_model)
> >  =20
> > +#define CRIS_CPU_TYPE_SUFFIX "-" TYPE_CRIS_CPU
> > +#define CRIS_CPU_TYPE_NAME(name) (name CRIS_CPU_TYPE_SUFFIX)
> > +
> >   #define cpu_signal_handler cpu_cris_signal_handler
> >  =20
> >   /* MMU modes definitions */
> > diff --git a/target/cris/cpu.c b/target/cris/cpu.c
> > index 88d93f2..8681c84 100644
> > --- a/target/cris/cpu.c
> > +++ b/target/cris/cpu.c
> > @@ -71,11 +71,11 @@ static ObjectClass *cris_cpu_class_by_name(const ch=
ar *cpu_model)
> >  =20
> >   #if defined(CONFIG_USER_ONLY)
> >       if (strcasecmp(cpu_model, "any") =3D=3D 0) {
> > -        return object_class_by_name("crisv32-" TYPE_CRIS_CPU);
> > +        return object_class_by_name(CRIS_CPU_TYPE_NAME("crisv32"));
> >       }
> >   #endif
> >  =20
> > -    typename =3D g_strdup_printf("%s-" TYPE_CRIS_CPU, cpu_model);
> > +    typename =3D g_strdup_printf(CRIS_CPU_TYPE_NAME("%s"), cpu_model);
> >       oc =3D object_class_by_name(typename);
> >       g_free(typename);
> >       if (oc !=3D NULL && (!object_class_dynamic_cast(oc, TYPE_CRIS_CPU=
) ||
> > @@ -108,7 +108,7 @@ static void cris_cpu_list_entry(gpointer data, gpoi=
nter user_data)
> >       const char *typename =3D object_class_get_name(oc);
> >       char *name;
> >  =20
> > -    name =3D g_strndup(typename, strlen(typename) - strlen("-" TYPE_CR=
IS_CPU));
> > +    name =3D g_strndup(typename, strlen(typename) - strlen(CRIS_CPU_TY=
PE_SUFFIX));
> >       (*s->cpu_fprintf)(s->file, "  %s\n", name);
> >       g_free(name);
> >   }
> > @@ -259,38 +259,6 @@ static void crisv32_cpu_class_init(ObjectClass *oc=
, void *data)
> >       ccc->vr =3D 32;
> >   }
> >  =20
> > -#define TYPE(model) model "-" TYPE_CRIS_CPU
> > -
> > -static const TypeInfo cris_cpu_model_type_infos[] =3D {
> > -    {
> > -        .name =3D TYPE("crisv8"),
> > -        .parent =3D TYPE_CRIS_CPU,
> > -        .class_init =3D crisv8_cpu_class_init,
> > -    }, {
> > -        .name =3D TYPE("crisv9"),
> > -        .parent =3D TYPE_CRIS_CPU,
> > -        .class_init =3D crisv9_cpu_class_init,
> > -    }, {
> > -        .name =3D TYPE("crisv10"),
> > -        .parent =3D TYPE_CRIS_CPU,
> > -        .class_init =3D crisv10_cpu_class_init,
> > -    }, {
> > -        .name =3D TYPE("crisv11"),
> > -        .parent =3D TYPE_CRIS_CPU,
> > -        .class_init =3D crisv11_cpu_class_init,
> > -    }, {
> > -        .name =3D TYPE("crisv17"),
> > -        .parent =3D TYPE_CRIS_CPU,
> > -        .class_init =3D crisv17_cpu_class_init,
> > -    }, {
> > -        .name =3D TYPE("crisv32"),
> > -        .parent =3D TYPE_CRIS_CPU,
> > -        .class_init =3D crisv32_cpu_class_init,
> > -    }
> > -};
> > -
> > -#undef TYPE
> > -
> >   static void cris_cpu_class_init(ObjectClass *oc, void *data)
> >   {
> >       DeviceClass *dc =3D DEVICE_CLASS(oc);
> > @@ -324,24 +292,41 @@ static void cris_cpu_class_init(ObjectClass *oc, =
void *data)
> >       cc->disas_set_info =3D cris_disas_set_info;
> >   }
> >  =20
> > -static const TypeInfo cris_cpu_type_info =3D {
> > -    .name =3D TYPE_CRIS_CPU,
> > -    .parent =3D TYPE_CPU,
> > -    .instance_size =3D sizeof(CRISCPU),
> > -    .instance_init =3D cris_cpu_initfn,
> > -    .abstract =3D true,
> > -    .class_size =3D sizeof(CRISCPUClass),
> > -    .class_init =3D cris_cpu_class_init,
> > -};
> > -
> > -static void cris_cpu_register_types(void)
> > -{
> > -    int i;
> > -
> > -    type_register_static(&cris_cpu_type_info);
> > -    for (i =3D 0; i < ARRAY_SIZE(cris_cpu_model_type_infos); i++) {
> > -        type_register_static(&cris_cpu_model_type_infos[i]);
> > +static const TypeInfo cris_cpu_model_type_infos[] =3D {
> > +    {
> > +        .name =3D TYPE_CRIS_CPU,
> > +        .parent =3D TYPE_CPU,
> > +        .instance_size =3D sizeof(CRISCPU),
> > +        .instance_init =3D cris_cpu_initfn,
> > +        .abstract =3D true,
> > +        .class_size =3D sizeof(CRISCPUClass),
> > +        .class_init =3D cris_cpu_class_init,
> > +    },
> > +    {
> > +        .name =3D CRIS_CPU_TYPE_NAME("crisv8"),
> > +        .parent =3D TYPE_CRIS_CPU,
> > +        .class_init =3D crisv8_cpu_class_init, =20
>=20
> what about using your scattering macro like in the Alpha port? i.e.:
I've thought that I did it but it seems that it got lost along the way,
I'll post here v2 that will do it

>=20
>       DEFINE_CRIS_CPU_TYPE("crisv8", crisv8_cpu_class_init),
>=20
> > +    }, {
> > +        .name =3D CRIS_CPU_TYPE_NAME("crisv9"),
> > +        .parent =3D TYPE_CRIS_CPU,
> > +        .class_init =3D crisv9_cpu_class_init, =20
>=20
>       ...
>=20
> > +    }, {
> > +        .name =3D CRIS_CPU_TYPE_NAME("crisv10"),
> > +        .parent =3D TYPE_CRIS_CPU,
> > +        .class_init =3D crisv10_cpu_class_init,
> > +    }, {
> > +        .name =3D CRIS_CPU_TYPE_NAME("crisv11"),
> > +        .parent =3D TYPE_CRIS_CPU,
> > +        .class_init =3D crisv11_cpu_class_init,
> > +    }, {
> > +        .name =3D CRIS_CPU_TYPE_NAME("crisv17"),
> > +        .parent =3D TYPE_CRIS_CPU,
> > +        .class_init =3D crisv17_cpu_class_init,
> > +    }, {
> > +        .name =3D CRIS_CPU_TYPE_NAME("crisv32"),
> > +        .parent =3D TYPE_CRIS_CPU,
> > +        .class_init =3D crisv32_cpu_class_init,
> >       }
> > -}
> > +};
> >  =20
> > -type_init(cris_cpu_register_types)
> > +type_init_from_array(cris_cpu_model_type_infos)
> >  =20
