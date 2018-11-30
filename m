Received: from eggs.gnu.org ([2001:4830:134:3::10]:34232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gSgSW-0006F9-1o
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:55:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gSgSV-0002c3-2R
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:55:43 -0500
Date: Fri, 30 Nov 2018 11:55:26 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181130115526.5974ca7a@redhat.com>
In-Reply-To: <CAJ+F1CJBKVibRrgjiNKjSJ5ufK=CUodx26aHnKzeL3Cs7adbeA@mail.gmail.com>
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
	<20181127092801.21777-17-marcandre.lureau@redhat.com>
	<20181127125644.GB18284@habkost.net>
	<CAMxuvaySoJ2TokV8M81CVU3Hp4dC25c+PW_p2kk+V88-88U-CQ@mail.gmail.com>
	<20181127133527.GI18284@habkost.net>
	<20181128184027.7d584eaa@redhat.com>
	<CAJ+F1CK5NkgsJWFGZ7kvR81KyeOPE_ytk=tOjKqTUGtbfywmJQ@mail.gmail.com>
	<20181129175055.GQ18284@habkost.net>
	<CAJ+F1CJBKVibRrgjiNKjSJ5ufK=CUodx26aHnKzeL3Cs7adbeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, QEMU <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Qemu-s390x list <qemu-s390x@nongnu.org>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:sPAPR pseries" <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>

On Fri, 30 Nov 2018 01:36:03 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

> Hi
>=20
> On Thu, Nov 29, 2018 at 9:51 PM Eduardo Habkost <ehabkost@redhat.com> wro=
te:
> >
> > On Thu, Nov 29, 2018 at 02:32:18PM +0400, Marc-Andr=C3=A9 Lureau wrote:=
 =20
> > > Hi
> > > On Wed, Nov 28, 2018 at 9:53 PM Igor Mammedov <imammedo@redhat.com> w=
rote: =20
> > > >
> > > > On Tue, 27 Nov 2018 11:35:27 -0200
> > > > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > > > =20
> > > > > On Tue, Nov 27, 2018 at 05:10:05PM +0400, Marc-Andr=C3=A9 Lureau =
wrote: =20
> > > > > > On Tue, Nov 27, 2018 at 4:57 PM Eduardo Habkost <ehabkost@redha=
t.com> wrote: =20
> > > > > > >
> > > > > > > On Tue, Nov 27, 2018 at 01:27:49PM +0400, Marc-Andr=C3=A9 Lur=
eau wrote: =20
> > > > > > > > Similarly to accel properties, move compat properties out o=
f globals
> > > > > > > > registration, and apply the machine compat properties during
> > > > > > > > device_post_init().
> > > > > > > >
> > > > > > > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@red=
hat.com> =20
> > > > > > > [...] =20
> > > > > > > > diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> > > > > > > > index 7066d28271..3b31b2c025 100644
> > > > > > > > --- a/hw/core/qdev.c
> > > > > > > > +++ b/hw/core/qdev.c
> > > > > > > > @@ -971,17 +971,26 @@ static void device_initfn(Object *obj)
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  static const GPtrArray *ac_compat_props;
> > > > > > > > +static const GPtrArray *mc_compat_props; =20
> > > > why you didn't use just 'compat_props' for both?
> > > > (it would be cleaner have single registry for compat
> > > > properties, and the place that takes care of registration
> > > > will take care of necessary ordering) =20
> > >
> > > There are two arrays, one from the accelerator class, the other from
> > > the machine class. We can't make it a singleton (all compats props for
> > > the various machines would be mixed).
> > >
> > > We could create a third array that would be the set of both, but that
> > > would require more copy/allocation. =20
> >
> > I am failing to see the advantage of replacing the `global_props`
> > static variable from qdev-properties.c with a collection of
> > separate static variables scattered around the code.  I thought
> > the main point of the changes was to reduce the amount of
> > duplicate data stored in static variables.
Main point was to use compats for backends then on top of that=20
we added split global from compat properties goal.

> > I was expecting something like this:
> >
> > accel.c:
> >
> >   void accel_apply_compat_props(AccelState *accel, Object *obj)
> >   {
> >       object_apply_global_props(obj, ACCEL_GET_CLASS(accel)->compat_pro=
ps, &error_abort);
> >   }
> >
> > machine.c:
> >
> >   /* Apply compat properties and global properties to an object */
> >   void machine_apply_compat_props(MachineState *ms, Object *obj)
> >   {
> >       accel_apply_compat_props(ms->accel, obj);
> >       object_apply_global_props(obj, MACHINE_GET_CLASS(ms)->compat_prop=
s, &error_abort);
> >   }
> >
> > compat-props.c:
> >
> >   static void object_apply_compat_props(Object *obj)
> >   {
> >       MachineState *machine =3D MACHINE(qdev_get_machine());
> >       machine_apply_compat_props(machine, obj);
> >   }
> >
> > qdev.c:
> >
> >   static void device_post_init(Object *obj)
> >   {
> >       object_apply_compat_props(obj);
> >       apply_user_provided_globals(obj);
> >   }
> >
> > object_interface.c:
> >
> >   void user_creatable_complete(Object *obj, Error **errp)
> >   {
> >       object_apply_compat_props(obj);
> >       ...
> >       ucc->complete(...)
> >   }
> > =20
>=20
> I like that solution too (which you also proposed in the other
> thread). But we have to decide whether it's acceptable to reference
> MachineState, or if the compat properties should be registered.
I dislike pulling in machine into basic object code and
I think a separate compats would be cleaner interface without
layer violation. But to unstuck, lets go with qdev_get_machine()
for now.

=20
> --
> Marc-Andr=C3=A9 Lureau
>=20
