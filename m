Received: from eggs.gnu.org ([2001:4830:134:3::10]:44850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dzKaR-0007oS-MF
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:38:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dzKaN-00022M-6Z
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:38:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dzKaM-00021Z-U2
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:37:59 -0400
Date: Tue, 3 Oct 2017 12:37:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171003123754.0f2dd9fe@nial.brq.redhat.com>
In-Reply-To: <71226704-7e3b-25e7-3155-4a84ceba5c51@amsat.org>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-23-git-send-email-imammedo@redhat.com>
	<71226704-7e3b-25e7-3155-4a84ceba5c51@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 22/38] xtensa: cleanup cpu type name
 composition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, jcmvbkbc@gmail.com

On Mon, 2 Oct 2017 17:35:39 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> On 10/02/2017 06:08 AM, Igor Mammedov wrote:
> > use new XTENSA_CPU_TYPE_NAME to compose CPU type name
> > to bring xtensa in line with all other targets that
> > will similar macro.
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > CC: jcmvbkbc@gmail.com
> > ---
> >   target/xtensa/cpu.h    | 4 ++++
> >   target/xtensa/cpu.c    | 2 +-
> >   target/xtensa/helper.c | 2 +-
> >   3 files changed, 6 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
> > index 4803331..b17d7d9 100644
> > --- a/target/xtensa/cpu.h
> > +++ b/target/xtensa/cpu.h
> > @@ -469,11 +469,15 @@ void xtensa_cpu_do_unaligned_access(CPUState *cpu=
, vaddr addr,
> >   #define cpu_signal_handler cpu_xtensa_signal_handler
> >   #define cpu_list xtensa_cpu_list
> >  =20
> > +#define XTENSA_CPU_TYPE_SUFFIX "-" TYPE_XTENSA_CPU
> > +#define XTENSA_CPU_TYPE_NAME(model) model XTENSA_CPU_TYPE_SUFFIX
> > +
> >   #ifdef TARGET_WORDS_BIGENDIAN
> >   #define XTENSA_DEFAULT_CPU_MODEL "fsf"
> >   #else
> >   #define XTENSA_DEFAULT_CPU_MODEL "dc232b"
> >   #endif
> > +#define XTENSA_DEFAULT_CPU_TYPE XTENSA_CPU_TYPE_NAME(XTENSA_DEFAULT_CP=
U_MODEL) =20
>=20
> I see XTENSA_DEFAULT_CPU_MODEL is used in mc->desc, any idea to be able=20
> to use this instead?
mc-desc is the reason why I've left XTENSA_DEFAULT_CPU_MODEL as is, and
having that there were no point in adding yet another ifdef for type,
XTENSA_DEFAULT_CPU_MODEL works just fine here.

>=20
> #ifdef TARGET_WORDS_BIGENDIAN
> # define XTENSA_DEFAULT_CPU_TYPE XTENSA_CPU_TYPE_NAME("fsf")
> #else
> # define XTENSA_DEFAULT_CPU_TYPE XTENSA_CPU_TYPE_NAME("dc232b")
> #endif
>=20
> >  =20
> >   #define cpu_init(cpu_model) cpu_generic_init(TYPE_XTENSA_CPU, cpu_mod=
el)
> >  =20
> > diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
> > index dcdc765..b5f7079 100644
> > --- a/target/xtensa/cpu.c
> > +++ b/target/xtensa/cpu.c
> > @@ -83,7 +83,7 @@ static ObjectClass *xtensa_cpu_class_by_name(const ch=
ar *cpu_model)
> >       ObjectClass *oc;
> >       char *typename;
> >  =20
> > -    typename =3D g_strdup_printf("%s-" TYPE_XTENSA_CPU, cpu_model);
> > +    typename =3D g_strdup_printf(XTENSA_CPU_TYPE_NAME("%s"), cpu_model=
);
> >       oc =3D object_class_by_name(typename);
> >       g_free(typename);
> >       if (oc =3D=3D NULL || !object_class_dynamic_cast(oc, TYPE_XTENSA_=
CPU) ||
> > diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
> > index e8fba20..216f198 100644
> > --- a/target/xtensa/helper.c
> > +++ b/target/xtensa/helper.c
> > @@ -76,7 +76,7 @@ void xtensa_register_core(XtensaConfigList *node)
> >  =20
> >       node->next =3D xtensa_cores;
> >       xtensa_cores =3D node;
> > -    type.name =3D g_strdup_printf("%s-" TYPE_XTENSA_CPU, node->config-=
>name);
> > +    type.name =3D g_strdup_printf(XTENSA_CPU_TYPE_NAME("%s"), node->co=
nfig->name);
> >       type_register(&type);
> >       g_free((gpointer)type.name);
> >   }
> >  =20
