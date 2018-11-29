Received: from eggs.gnu.org ([2001:4830:134:3::10]:54471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gSOlb-0000mJ-E9
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:02:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gSOlZ-0007NL-SK
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:02:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gSOlZ-0007Ma-I1
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:02:13 -0500
Date: Thu, 29 Nov 2018 14:02:06 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181129160206.GL18284@habkost.net>
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
	<20181127092801.21777-16-marcandre.lureau@redhat.com>
	<20181127194019.GQ18284@habkost.net>
	<CAMxuvaz0FitnFiSD3Ma9r_7z0oM6A_Z3D2nbAh=YBp3mEC72rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAMxuvaz0FitnFiSD3Ma9r_7z0oM6A_Z3D2nbAh=YBp3mEC72rg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v4 15/28] hw: apply accel compat
 properties without touching globals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, sstabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, "Bonzini, Paolo" <pbonzini@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, Igor Mammedov <imammedo@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Wed, Nov 28, 2018 at 12:02:21AM +0400, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Tue, Nov 27, 2018 at 11:40 PM Eduardo Habkost <ehabkost@redhat.com> =
wrote:
> >
> > On Tue, Nov 27, 2018 at 01:27:48PM +0400, Marc-Andr=E9 Lureau wrote:
> > > Introduce object_apply_global_props() function, to apply compatibil=
ity
> > > properties from a GPtrArray.
> > >
> > > For accel compatibility properties, apply them during
> > > device_post_init(), after accel_register_compat_props() has set the=
m.
> > >
> > > To populate the compatibility properties, introduce SET_COMPAT(), a
> > > more generic version of SET_MACHINE_COMPAT() that can set compat
> > > properties on other objects than Machine, and using GPtrArray.
> > >
> > > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  include/hw/qdev-core.h | 13 +++++++++++++
> > >  include/qom/object.h   |  3 +++
> > >  include/sysemu/accel.h |  4 +---
> > >  accel/accel.c          | 12 ------------
> > >  hw/core/qdev.c         | 11 +++++++++++
> > >  hw/xen/xen-common.c    | 38 +++++++++++++++++++-------------------
> > >  qom/object.c           | 25 +++++++++++++++++++++++++
> > >  vl.c                   |  2 +-
> > >  8 files changed, 73 insertions(+), 35 deletions(-)
> > >
> > > diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> > > index a24d0dd566..82afd3c50d 100644
> > > --- a/include/hw/qdev-core.h
> > > +++ b/include/hw/qdev-core.h
> > > @@ -267,6 +267,19 @@ typedef struct GlobalProperty {
> > >      Error **errp;
> > >  } GlobalProperty;
> > >
> > > +#define SET_COMPAT(S, COMPAT)                                     =
  \
> > > +    do {                                                          =
  \
> > > +        int i;                                                    =
  \
> > > +        static GlobalProperty props[] =3D {                       =
    \
> > > +            COMPAT                                                =
  \
> > > +        };                                                        =
  \
> > > +        for (i =3D 0; i < G_N_ELEMENTS(props); i++) {             =
    \
> > > +            g_ptr_array_add((S)->compat_props, (void *)&props[i]);=
  \
> > > +        }                                                         =
  \
> > > +    } while (0)
> >
> > I think this macro would be an acceptable alternative to the
> > existing SET_MACHINE_COMPAT macro trickery, but:
> >
> > > +
> > > +void accel_register_compat_props(const GPtrArray *props);
> > [...]
> > > @@ -185,7 +183,9 @@ static void xen_accel_class_init(ObjectClass *o=
c, void *data)
> > >      ac->init_machine =3D xen_init;
> > >      ac->setup_post =3D xen_setup_post;
> > >      ac->allowed =3D &xen_allowed;
> > > -    ac->global_props =3D xen_compat_props;
> > > +    ac->compat_props =3D g_ptr_array_new();
> > > +
> > > +    SET_COMPAT(ac, XEN_COMPAT);
> >
> > I think this is a step backwards.  I like us to be able to
> > register compat properties without macro magic.  The existence of
> > SET_MACHINE_COMPAT is a bug and not a feature.
> >
> > If you really want to use GPtrArray instead of a simple
> > GlobalProperty* field (I'm not sure I understand the reasoning
> > behind the choice to use GPtrArray), what about:
>=20
> Except in the Xen case, It needs to register multiple GlobalProperty*,
> not necessarily from contiguous in memory. That's why we have an array
> of ptr.

If you also need to register multiple properties not from a
contiguous array, would a simple wrapper that does a single
g_ptr_array_add() call be enough?


>=20
> >
> > static GPtrArray *build_compat_props_array(GlobalProperty *props)
> > {
> >     GlobalProperty *p =3D props;
> >     GPtrArray *array =3D g_ptr_array_new();
> >     while (p->driver) {
> >         g_ptr_array_add(array, (void *)p);
> >     }
> >     return array;
> > }
> >
> >
> > static void xen_accel_class_init(ObjectClass *oc, void *data)
> > {
> >     ...
> >     ac->compat_props =3D build_compat_props_array(xen_compat_props);
>=20
> If we would register from one place, that would be fine.
>=20
> We could replace the macro by a function, then we would have to
> declare the GlobalProperty arrays manually basically.

I would prefer to replace the macro with a function, if possible.
What do you mean by declaring the GlobalProperty arrays manually?


>=20
> > }
> >
> >
> >
> > >  }
> > >
> > >  #define TYPE_XEN_ACCEL ACCEL_CLASS_NAME("xen")
> > > diff --git a/qom/object.c b/qom/object.c
> > > index 17921c0a71..dbdab0aead 100644
> > > --- a/qom/object.c
> > > +++ b/qom/object.c
> > > @@ -370,6 +370,31 @@ static void object_post_init_with_type(Object =
*obj, TypeImpl *ti)
> > >      }
> > >  }
> > >
> > > +void object_apply_global_props(Object *obj, const GPtrArray *props=
, Error **errp)
> > > +{
> > > +    Error *err =3D NULL;
> > > +    int i;
> > > +
> > > +    if (!props) {
> > > +        return;
> > > +    }
> > > +
> > > +    for (i =3D 0; i < props->len; i++) {
> > > +        GlobalProperty *p =3D g_ptr_array_index(props, i);
> > > +
> > > +        if (object_dynamic_cast(obj, p->driver) =3D=3D NULL) {
> > > +            continue;
> > > +        }
> > > +        p->used =3D true;
> > > +        object_property_parse(obj, p->value, p->property, &err);
> > > +        if (err !=3D NULL) {
> > > +            error_prepend(&err, "can't apply global %s.%s=3D%s: ",
> > > +                          p->driver, p->property, p->value);
> > > +            error_propagate(errp, err);
> > > +        }
> > > +    }
> > > +}
> > > +
> > >  static void object_initialize_with_type(void *data, size_t size, T=
ypeImpl *type)
> > >  {
> > >      Object *obj =3D data;
> > > diff --git a/vl.c b/vl.c
> > > index fa25d1ae2d..c06e94271c 100644
> > > --- a/vl.c
> > > +++ b/vl.c
> > > @@ -2963,7 +2963,7 @@ static void user_register_global_props(void)
> > >   */
> > >  static void register_global_properties(MachineState *ms)
> > >  {
> > > -    accel_register_compat_props(ms->accelerator);
> > > +    accel_register_compat_props(ACCEL_GET_CLASS(ms->accelerator)->=
compat_props);
> > >      machine_register_compat_props(ms);
> > >      user_register_global_props();
> > >  }
> > > --
> > > 2.20.0.rc1
> > >
> > >
> >
> > --
> > Eduardo

--=20
Eduardo
