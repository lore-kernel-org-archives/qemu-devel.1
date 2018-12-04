Received: from eggs.gnu.org ([2001:4830:134:3::10]:54093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gUAa6-0003pC-3D
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:17:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gUAa4-0008AV-GS
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:17:42 -0500
Date: Tue, 4 Dec 2018 14:17:24 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181204141724.5f06bd1b@redhat.com>
In-Reply-To: <20181130114142.GV18284@habkost.net>
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
	<20181127092801.21777-17-marcandre.lureau@redhat.com>
	<20181127125644.GB18284@habkost.net>
	<CAMxuvaySoJ2TokV8M81CVU3Hp4dC25c+PW_p2kk+V88-88U-CQ@mail.gmail.com>
	<20181127133527.GI18284@habkost.net>
	<20181128184027.7d584eaa@redhat.com>
	<CAJ+F1CK5NkgsJWFGZ7kvR81KyeOPE_ytk=tOjKqTUGtbfywmJQ@mail.gmail.com>
	<20181129175055.GQ18284@habkost.net>
	<CAJ+F1CJBKVibRrgjiNKjSJ5ufK=CUodx26aHnKzeL3Cs7adbeA@mail.gmail.com>
	<20181130115526.5974ca7a@redhat.com>
	<20181130114142.GV18284@habkost.net>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, QEMU <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Qemu-s390x list <qemu-s390x@nongnu.org>, "open
	list:ARM" <qemu-arm@nongnu.org>, "open list:sPAPR pseries" <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>

On Fri, 30 Nov 2018 09:41:42 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Fri, Nov 30, 2018 at 11:55:26AM +0100, Igor Mammedov wrote:
> > On Fri, 30 Nov 2018 01:36:03 +0400
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:
> >  =20
> > > Hi
> > >=20
> > > On Thu, Nov 29, 2018 at 9:51 PM Eduardo Habkost <ehabkost@redhat.com>=
 wrote: =20
> > > >
> > > > On Thu, Nov 29, 2018 at 02:32:18PM +0400, Marc-Andr=C3=A9 Lureau wr=
ote:   =20
> > > > > Hi
> > > > > On Wed, Nov 28, 2018 at 9:53 PM Igor Mammedov <imammedo@redhat.co=
m> wrote:   =20
> > > > > >
> > > > > > On Tue, 27 Nov 2018 11:35:27 -0200
> > > > > > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > > > > >   =20
> > > > > > > On Tue, Nov 27, 2018 at 05:10:05PM +0400, Marc-Andr=C3=A9 Lur=
eau wrote:   =20
> > > > > > > > On Tue, Nov 27, 2018 at 4:57 PM Eduardo Habkost <ehabkost@r=
edhat.com> wrote:   =20
> > > > > > > > >
> > > > > > > > > On Tue, Nov 27, 2018 at 01:27:49PM +0400, Marc-Andr=C3=A9=
 Lureau wrote:   =20
> > > > > > > > > > Similarly to accel properties, move compat properties o=
ut of globals
> > > > > > > > > > registration, and apply the machine compat properties d=
uring
> > > > > > > > > > device_post_init().
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau=
@redhat.com>   =20
> > > > > > > > > [...]   =20
> > > > > > > > > > diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> > > > > > > > > > index 7066d28271..3b31b2c025 100644
> > > > > > > > > > --- a/hw/core/qdev.c
> > > > > > > > > > +++ b/hw/core/qdev.c
> > > > > > > > > > @@ -971,17 +971,26 @@ static void device_initfn(Object =
*obj)
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > >  static const GPtrArray *ac_compat_props;
> > > > > > > > > > +static const GPtrArray *mc_compat_props;   =20
> > > > > > why you didn't use just 'compat_props' for both?
> > > > > > (it would be cleaner have single registry for compat
> > > > > > properties, and the place that takes care of registration
> > > > > > will take care of necessary ordering)   =20
> > > > >
> > > > > There are two arrays, one from the accelerator class, the other f=
rom
> > > > > the machine class. We can't make it a singleton (all compats prop=
s for
> > > > > the various machines would be mixed).
> > > > >
> > > > > We could create a third array that would be the set of both, but =
that
> > > > > would require more copy/allocation.   =20
> > > >
> > > > I am failing to see the advantage of replacing the `global_props`
> > > > static variable from qdev-properties.c with a collection of
> > > > separate static variables scattered around the code.  I thought
> > > > the main point of the changes was to reduce the amount of
> > > > duplicate data stored in static variables. =20
> > Main point was to use compats for backends then on top of that=20
> > we added split global from compat properties goal.
> >  =20
> > > > I was expecting something like this:
> > > >
> > > > accel.c:
> > > >
> > > >   void accel_apply_compat_props(AccelState *accel, Object *obj)
> > > >   {
> > > >       object_apply_global_props(obj, ACCEL_GET_CLASS(accel)->compat=
_props, &error_abort);
> > > >   }
> > > >
> > > > machine.c:
> > > >
> > > >   /* Apply compat properties and global properties to an object */
> > > >   void machine_apply_compat_props(MachineState *ms, Object *obj)
> > > >   {
> > > >       accel_apply_compat_props(ms->accel, obj);
> > > >       object_apply_global_props(obj, MACHINE_GET_CLASS(ms)->compat_=
props, &error_abort);
> > > >   }
> > > >
> > > > compat-props.c:
> > > >
> > > >   static void object_apply_compat_props(Object *obj)
> > > >   {
> > > >       MachineState *machine =3D MACHINE(qdev_get_machine());
> > > >       machine_apply_compat_props(machine, obj);
> > > >   }
> > > >
> > > > qdev.c:
> > > >
> > > >   static void device_post_init(Object *obj)
> > > >   {
> > > >       object_apply_compat_props(obj);
> > > >       apply_user_provided_globals(obj);
> > > >   }
> > > >
> > > > object_interface.c:
> > > >
> > > >   void user_creatable_complete(Object *obj, Error **errp)
> > > >   {
> > > >       object_apply_compat_props(obj);
> > > >       ...
> > > >       ucc->complete(...)
> > > >   }
> > > >   =20
> > >=20
> > > I like that solution too (which you also proposed in the other
> > > thread). But we have to decide whether it's acceptable to reference
> > > MachineState, or if the compat properties should be registered. =20
> > I dislike pulling in machine into basic object code and
> > I think a separate compats would be cleaner interface without
> > layer violation. But to unstuck, lets go with qdev_get_machine()
> > for now. =20
>=20
> Which basic object code?  The only reference to machine above is
> at compat-props.c.  I don't see any layering violation here.
I see compat properties as just a set of arbitrary properties
that's applied to objects depending on configuration.
Which currently includes machine version and accel type
but in no way inherently tied to them.

As for layering violation, we do it in device model cases
as it's machine related (ugly 'acceptable' but helps to cut corners)
and with new interface it will be used wit backends which are not
machine related at all.

Doing like you suggest would make it usable with current machine
initialization order (with some fixes) but if one would consider
a bit earlier time (preconfig time) and creating machine step by
step from there it might be less usable (as it needs machine instance,
it still would be possible but probably more tricky (pure speculation)).

So I'd vote for abstracted from machine compat props that could be
called from any object that implements interface and explicit
compats registration (like we do now) and explicit registration failure
if compats happend to be applied to any object. But in case of this
series I'm fine with any approach just to get compat properties work
with backends for now.
