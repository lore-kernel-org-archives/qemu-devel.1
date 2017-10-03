Received: from eggs.gnu.org ([2001:4830:134:3::10]:51328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dzPHT-0006ld-W1
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 11:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dzPHA-00070B-RU
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 11:38:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dzPHA-0006zW-IL
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 11:38:28 -0400
Date: Tue, 3 Oct 2017 17:38:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171003173824.7aaf882b@nial.brq.redhat.com>
In-Reply-To: <1b559ae7-4fe5-6ba2-5bb1-98d9e7c68c6f@amsat.org>
References: <20171002192404.GC17385@localhost.localdomain>
	<1507032886-199950-1-git-send-email-imammedo@redhat.com>
	<1b559ae7-4fe5-6ba2-5bb1-98d9e7c68c6f@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qom: add helpers REGISTER_STATIC_TYPE[S]()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org

On Tue, 3 Oct 2017 10:29:22 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Hi Igor,
>=20
> On 10/03/2017 09:14 AM, Igor Mammedov wrote:
> > it will help to remove code duplication in places
> > that currently open code registration of static
> > type[s] and remove necessity to declare function
> > for type_init() to call, when only static types
> > need to be registered.
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > I'm going to use it for CPU types in followup patches
> >=20
> > CC: ehabkost@redhat.com
> > ---
> >  include/qemu/module.h | 10 ++++++++++
> >  include/qom/object.h  | 10 ++++++++++
> >  qom/object.c          |  9 +++++++++
> >  3 files changed, 29 insertions(+)
> >=20
> > diff --git a/include/qemu/module.h b/include/qemu/module.h
> > index 56dd218..60dd632 100644
> > --- a/include/qemu/module.h
> > +++ b/include/qemu/module.h
> > @@ -52,6 +52,16 @@ typedef enum {
> >  #define type_init(function) module_init(function, MODULE_INIT_QOM)
> >  #define trace_init(function) module_init(function, MODULE_INIT_TRACE)
> > =20
> > +#define REGISTER_STATIC_TYPES(t, nr)                                  =
      \ =20
>=20
> ok
>=20
> > +static void do_qemu_init_ ## t(void)                                  =
      \
> > +{                                                                     =
      \
> > +    type_register_static_array(t, nr);                                =
      \
> > +}                                                                     =
      \
> > +type_init(do_qemu_init_ ## t)
> > +
> > +#define REGISTER_STATIC_TYPE(t)                                       =
      \ =20
>=20
> eh why not...
>=20
> What's your plan for your "generalize parsing of cpu_model (2)" series?
> re-post the whole? If you just change this macro you can keep my R-b for =
it.
It looks like I'll have to amend and repost series.
I'd prefer to keep type_init_from_array() patch for now as it does what's n=
eed
and in line with current type_init().
But it seems Eduardo doesn't like it and want's a more generalized way
to handle typeinfo array or single typeinfo.
So most likely I'll end-up keeping *_cpu_register_types() functions and call
type_register_static_array() from there replacing only loops.

>=20
> > +    REGISTER_STATIC_TYPES(t, 1)
> > +
> >  #define block_module_load_one(lib) module_load_one("block-", lib)
> > =20
> >  void register_module_init(void (*fn)(void), module_init_type type);
> > diff --git a/include/qom/object.h b/include/qom/object.h
> > index f3e5cff..17fcadd 100644
> > --- a/include/qom/object.h
> > +++ b/include/qom/object.h
> > @@ -789,6 +789,16 @@ Type type_register_static(const TypeInfo *info);
> >  Type type_register(const TypeInfo *info);
> > =20
> >  /**
> > + * type_register_static_array:
> > + * @infos: The array of the new type #TypeInfo structures.
> > + * @nr_infos: number of entries in @infos
> > + *
> > + * @infos and all of the strings it points to should exist for the lif=
e time
> > + * that the type is registered.
> > + */
> > +void type_register_static_array(const TypeInfo *infos, int nr_infos);
> > +
> > +/**
> >   * object_class_dynamic_cast_assert:
> >   * @klass: The #ObjectClass to attempt to cast.
> >   * @typename: The QOM typename of the class to cast to.
> > diff --git a/qom/object.c b/qom/object.c
> > index 3e18537..40b1729 100644
> > --- a/qom/object.c
> > +++ b/qom/object.c
> > @@ -151,6 +151,15 @@ TypeImpl *type_register_static(const TypeInfo *inf=
o)
> >      return type_register(info);
> >  }
> > =20
> > +void type_register_static_array(const TypeInfo *infos, int nr_infos)
> > +{
> > +    int i;
> > +
> > +    for (i =3D 0; i < nr_infos; i++) {
> > +        assert(type_register_static(&infos[i]));
> > +    }
> > +} =20
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> > +
> >  static TypeImpl *type_get_by_name(const char *name)
> >  {
> >      if (name =3D=3D NULL) {
> >  =20
>=20
