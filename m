Received: from eggs.gnu.org ([2001:4830:134:3::10]:47150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gS41y-0000RM-Fy
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:53:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gS41w-0003a0-Cr
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:53:46 -0500
Date: Wed, 28 Nov 2018 15:53:09 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181128175309.GY18284@habkost.net>
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
	<20181127092801.21777-17-marcandre.lureau@redhat.com>
	<20181127125644.GB18284@habkost.net>
	<CAMxuvaySoJ2TokV8M81CVU3Hp4dC25c+PW_p2kk+V88-88U-CQ@mail.gmail.com>
	<20181127133527.GI18284@habkost.net>
	<20181128184027.7d584eaa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181128184027.7d584eaa@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v4 16/28] hw: apply machine compat
 properties without touching globals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Bonzini, Paolo" <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Michael S . Tsirkin" <mst@redhat.com>, david@gibson.dropbear.id.au, cohuck@redhat.com, David Hildenbrand <david@redhat.com>, borntraeger@de.ibm.com, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

On Wed, Nov 28, 2018 at 06:40:27PM +0100, Igor Mammedov wrote:
> On Tue, 27 Nov 2018 11:35:27 -0200
> Eduardo Habkost <ehabkost@redhat.com> wrote:
>=20
> > On Tue, Nov 27, 2018 at 05:10:05PM +0400, Marc-Andr=E9 Lureau wrote:
> > > On Tue, Nov 27, 2018 at 4:57 PM Eduardo Habkost <ehabkost@redhat.co=
m> wrote: =20
> > > >
> > > > On Tue, Nov 27, 2018 at 01:27:49PM +0400, Marc-Andr=E9 Lureau wro=
te: =20
> > > > > Similarly to accel properties, move compat properties out of gl=
obals
> > > > > registration, and apply the machine compat properties during
> > > > > device_post_init().
> > > > >
> > > > > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com=
> =20
> > > > [...] =20
> > > > > diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> > > > > index 7066d28271..3b31b2c025 100644
> > > > > --- a/hw/core/qdev.c
> > > > > +++ b/hw/core/qdev.c
> > > > > @@ -971,17 +971,26 @@ static void device_initfn(Object *obj)
> > > > >  }
> > > > >
> > > > >  static const GPtrArray *ac_compat_props;
> > > > > +static const GPtrArray *mc_compat_props;
> why you didn't use just 'compat_props' for both?
> (it would be cleaner have single registry for compat
> properties, and the place that takes care of registration
> will take care of necessary ordering)
>=20
> > > > >
> > > > >  void accel_register_compat_props(const GPtrArray *props)
> > > > >  {
> > > > >      ac_compat_props =3D props;
> > > > >  }
> > > > >
> > > > > +void machine_register_compat_props(const GPtrArray *props)
> > > > > +{
> > > > > +    mc_compat_props =3D props;
> > > > > +}
> > > > > +
> > > > >  static void device_post_init(Object *obj)
> > > > >  {
> > > > >      if (ac_compat_props) {
> > > > >          object_apply_global_props(obj, ac_compat_props, &error=
_abort);
> > > > >      } =20
> > > >
> > > > Why not just use MACHINE(qdev_get_machine())->accel->compat_props
> > > > directly?
> > > > =20
> > > > > +    if (mc_compat_props) {
> > > > > +        object_apply_global_props(obj, mc_compat_props, &error=
_abort);
> > > > > +    } =20
> > > >
> > > > Why not just use MACHINE(qdev_get_machine())->compat_props
> > > > directly? =20
> > >=20
> > > This was the approach in v3, but Igor didn't quite like referencing
> > > machine in qdev:
> > > https://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg04774.h=
tml =20
> >=20
> > I disagree with Igor, here.  Core qdev code already have multiple
> > references to machine, I don't see any problem with that.
> (There are only 3 calls to qdev_get_machine() in core qdev.c
> blame me for adding one there. Which were hacks so we won't
> have to re-factor core qdev code. But that doesn't justify adding more.=
)
>=20
> This patch is an interim one and later in 25/28
> device_post_init() content is moved to a more generic compat interface
> implementation. That intended for use with types derived from Object
> (i.e. not only qdev stuff). Hence I'd like to decouple it from
> machine as a standalone feature as much as possible. So that
> machine (or whatever else) will opt in in using facility.

Why do you want to decouple that from machine?  The whole purpose
of the code being added by this patch (and of TYPE_COMPAT_PROPS)
is to have objects being affected by machine-provided and
accel-provided compat properties.  Having a dependency on
machine+accel is part of its specification.


>=20
> > The previous code was clearer and easier to follow, and wasn't
> > sensitive to subtle changes in initialization ordering (e.g. what
> > happens if we create a device before *_register_compat_props() is
> > called?).
> Indeed It seems clearer to follow (that was my first impression as well=
),
> until I went through whole series and thought it's basically the same,
> So my choice was to use cleaner approach that we won't have to rewrite
> in near future.

Why you think it is cleaner?  Copying data around to static
variables isn't cleaner and it's more fragile.

>=20
> Thanks for bringing up ordering issue, we probably have one in this ser=
ies.
>=20
> But beside possible issue here, even with v3 variant we would still hav=
e
> issues if objects are created before machine and accelerator instances =
are
> created.
> More correct way could be to register compat properties right away at
> select_machine() time, we don't really need an instance for that, just =
access
> to machine_class and do the same for 'accel' option. (that's probably d=
oable
> within this series) + some time later (on top of this series) a check t=
hat
> no TYPE_COMPAT_PROPS were created at the moment compat properties are r=
egistered
> so we would notice when we write something wrong.

What problem you are trying to solve with this extra complexity,
exactly?

>=20
> If it's too much of refactoring (series is already big as it is), I wou=
ld
> compromise on qdev_get_machine() and adding TODO comments (or a series =
on top)
> to make it correct and "race-resistant".

It's not clear to me what the TODO comment would say.  What's the
issue you're trying to solve?


>=20
> Marc are you sure it actually will work as expected with Object derived=
 types?
>    register_global_properties()
> is being called after
>    qemu_opts_foreach(... user_creatable_add_opts_foreach, object_create=
_initial ...)
> so there is no compat properties registered when objects are created.
> =20
> > >  =20
> > > > =20
> > > > >
> > > > >      qdev_prop_set_globals(DEVICE(obj));
> > > > >  } =20
> > > > [...]
> > > >
> > > > --
> > > > Eduardo =20
> >=20
>=20

--=20
Eduardo
