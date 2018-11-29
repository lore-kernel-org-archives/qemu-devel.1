Received: from eggs.gnu.org ([2001:4830:134:3::10]:58978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gSQT0-0002Fz-HB
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:51:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gSQSz-0008MV-KZ
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:51:10 -0500
Date: Thu, 29 Nov 2018 15:50:55 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181129175055.GQ18284@habkost.net>
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
	<20181127092801.21777-17-marcandre.lureau@redhat.com>
	<20181127125644.GB18284@habkost.net>
	<CAMxuvaySoJ2TokV8M81CVU3Hp4dC25c+PW_p2kk+V88-88U-CQ@mail.gmail.com>
	<20181127133527.GI18284@habkost.net>
	<20181128184027.7d584eaa@redhat.com>
	<CAJ+F1CK5NkgsJWFGZ7kvR81KyeOPE_ytk=tOjKqTUGtbfywmJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CK5NkgsJWFGZ7kvR81KyeOPE_ytk=tOjKqTUGtbfywmJQ@mail.gmail.com>
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
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, QEMU <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Qemu-s390x list <qemu-s390x@nongnu.org>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:sPAPR pseries" <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Thu, Nov 29, 2018 at 02:32:18PM +0400, Marc-Andr=E9 Lureau wrote:
> Hi
> On Wed, Nov 28, 2018 at 9:53 PM Igor Mammedov <imammedo@redhat.com> wro=
te:
> >
> > On Tue, 27 Nov 2018 11:35:27 -0200
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> >
> > > On Tue, Nov 27, 2018 at 05:10:05PM +0400, Marc-Andr=E9 Lureau wrote=
:
> > > > On Tue, Nov 27, 2018 at 4:57 PM Eduardo Habkost <ehabkost@redhat.=
com> wrote:
> > > > >
> > > > > On Tue, Nov 27, 2018 at 01:27:49PM +0400, Marc-Andr=E9 Lureau w=
rote:
> > > > > > Similarly to accel properties, move compat properties out of =
globals
> > > > > > registration, and apply the machine compat properties during
> > > > > > device_post_init().
> > > > > >
> > > > > > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.c=
om>
> > > > > [...]
> > > > > > diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> > > > > > index 7066d28271..3b31b2c025 100644
> > > > > > --- a/hw/core/qdev.c
> > > > > > +++ b/hw/core/qdev.c
> > > > > > @@ -971,17 +971,26 @@ static void device_initfn(Object *obj)
> > > > > >  }
> > > > > >
> > > > > >  static const GPtrArray *ac_compat_props;
> > > > > > +static const GPtrArray *mc_compat_props;
> > why you didn't use just 'compat_props' for both?
> > (it would be cleaner have single registry for compat
> > properties, and the place that takes care of registration
> > will take care of necessary ordering)
>=20
> There are two arrays, one from the accelerator class, the other from
> the machine class. We can't make it a singleton (all compats props for
> the various machines would be mixed).
>=20
> We could create a third array that would be the set of both, but that
> would require more copy/allocation.

I am failing to see the advantage of replacing the `global_props`
static variable from qdev-properties.c with a collection of
separate static variables scattered around the code.  I thought
the main point of the changes was to reduce the amount of
duplicate data stored in static variables.

I was expecting something like this:

accel.c:

  void accel_apply_compat_props(AccelState *accel, Object *obj)
  {
      object_apply_global_props(obj, ACCEL_GET_CLASS(accel)->compat_props=
, &error_abort);
  }

machine.c:

  /* Apply compat properties and global properties to an object */
  void machine_apply_compat_props(MachineState *ms, Object *obj)
  {
      accel_apply_compat_props(ms->accel, obj);
      object_apply_global_props(obj, MACHINE_GET_CLASS(ms)->compat_props,=
 &error_abort);
  }

compat-props.c:

  static void object_apply_compat_props(Object *obj)
  {
      MachineState *machine =3D MACHINE(qdev_get_machine());
      machine_apply_compat_props(machine, obj);
  }

qdev.c:

  static void device_post_init(Object *obj)
  {
      object_apply_compat_props(obj);
      apply_user_provided_globals(obj);
  }

object_interface.c:

  void user_creatable_complete(Object *obj, Error **errp)
  {
      object_apply_compat_props(obj);
      ...
      ucc->complete(...)
  }

--=20
Eduardo
