Received: from eggs.gnu.org ([2001:4830:134:3::10]:60620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gSiMq-0001Hj-Bh
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:58:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gSiMn-0000xW-0a
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:58:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:16201)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gSiMk-0000w1-Ku
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:57:55 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 02843316467F
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 12:57:54 +0000 (UTC)
Date: Fri, 30 Nov 2018 10:57:49 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181130125749.GF18284@habkost.net>
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
	<20181127092801.21777-26-marcandre.lureau@redhat.com>
	<20181129174900.GP18284@habkost.net>
	<20181130133456.727fe935@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181130133456.727fe935@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v4 25/28] machine: add compat-props
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On Fri, Nov 30, 2018 at 01:34:56PM +0100, Igor Mammedov wrote:
> On Thu, 29 Nov 2018 15:49:00 -0200
> Eduardo Habkost <ehabkost@redhat.com> wrote:
>=20
> > On Tue, Nov 27, 2018 at 01:27:58PM +0400, Marc-Andr=E9 Lureau wrote:
> > > Let's make compatiblity properties an interface, so that objects ot=
her
> > > than QDev can benefit from having machine compatiblity properties.
> > >=20
> > > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com> =20
> > [...]
> > > diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> > > index 3b31b2c025..b0ee05f837 100644
> > > --- a/hw/core/qdev.c
> > > +++ b/hw/core/qdev.c
> > > @@ -970,28 +970,8 @@ static void device_initfn(Object *obj)
> > >      QLIST_INIT(&dev->gpios);
> > >  }
> > > =20
> > > -static const GPtrArray *ac_compat_props;
> > > -static const GPtrArray *mc_compat_props;
> > > -
> > > -void accel_register_compat_props(const GPtrArray *props)
> > > -{
> > > -    ac_compat_props =3D props;
> > > -}
> > > -
> > > -void machine_register_compat_props(const GPtrArray *props)
> > > -{
> > > -    mc_compat_props =3D props;
> > > -}
> > > -
> > >  static void device_post_init(Object *obj)
> > >  {
> > > -    if (ac_compat_props) {
> > > -        object_apply_global_props(obj, ac_compat_props, &error_abo=
rt);
> > > -    }
> > > -    if (mc_compat_props) {
> > > -        object_apply_global_props(obj, mc_compat_props, &error_abo=
rt);
> > > -    }
> > > -
> > >      qdev_prop_set_globals(DEVICE(obj));
> > >  }
> > > =20
> > > @@ -1124,6 +1104,10 @@ static const TypeInfo device_type_info =3D {
> > >      .class_init =3D device_class_init,
> > >      .abstract =3D true,
> > >      .class_size =3D sizeof(DeviceClass),
> > > +    .interfaces =3D (InterfaceInfo[]) {
> > > +        { TYPE_COMPAT_PROPS },
> > > +        { }
> > > +    } =20
> >=20
> > At first I thought TYPE_COMPAT_PROPS was a practical way to
> > implement this feature, but now I'm worried: the ordering between
> > compat_props_post_init() qdev_prop_set_globals() is very
> > important (user-provided globals must always be set after compat
> > props), and here the ordering is implicit and easy to break
> > accidentally.
> >=20
> > What if instead of a QOM interface we just provide a simple
> > object_apply_compat_props() function?  e.g.:
> >=20
> > qdev.c:
> >=20
> >   static void device_post_init(Object *obj)
> >   {
> >       object_apply_compat_props(obj);
> >       apply_user_provided_globals(obj);
> >   }
> >=20
> > object_interface.c:
> >=20
> >   void user_creatable_complete(Object *obj, Error **errp)
> >   {
> >       object_apply_compat_props(obj);
> >       ...
> >       ucc->complete(...)
> >   }
> this would work as long as nothing is happening between
> object_new() ... user_creatable_complete() but look at
> current users of user_creatable_complete() so it's
> fragile too.

You are right.  This could be solved by:

  void user_creatable_post_init(Object *obj)
  {
      object_apply_compat_props(obj);
  }


>=20
> Reasons for compat props interface are the same as for
> instance_post_init/device_post_init.
>=20
> the thing we can do here is getting rid of device_post_init
> and making device override TYPE_COMPAT_PROPS::instance_post_init
> to make explicit ordering like we do everywhere else:
>=20
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 6b3cc55..46ad6f5 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -1033,11 +1033,19 @@ static void device_unparent(Object *obj)
>      }
>  }
> =20
> +device_compat_props()
> +{
> +    dc->parent_compat_props()
> +    apply_global_props()
> +}
> +
>  static void device_class_init(ObjectClass *class, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(class);
> =20
>      class->unparent =3D device_unparent;
> +    dc->parent_compat_props =3D COMPAT_PROPS_GET_CLASS(class)->instanc=
e_post_init
> +    COMPAT_PROPS_GET_CLASS(class)->instance_post_init =3D device_compa=
t_props()
> =20
>      /* by default all devices were considered as hotpluggable,
>       * so with intent to check it in generic qdev_unplug() /

The only advantage I saw in TYPE_COMPAT_PROPS interface was to
easily allow objects to implement behavior without manually
implementing post_init.  Now we can't use the interface without
an even more complex way of overriding post_init, so what's the
point?

Why not just call object_apply_compat_props() at
device_post_init()?

>=20
> > Most people don't understand QOM interfaces and their
> > initialization ordering rules.  Everybody understands C function
> > calls.
> >=20
> > > [...] =20
> >=20
>=20

--=20
Eduardo
