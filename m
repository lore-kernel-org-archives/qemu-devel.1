Received: from eggs.gnu.org ([2001:4830:134:3::10]:44355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRdX0-00067U-ID
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:36:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRdWy-0000Me-4F
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:36:02 -0500
Date: Tue, 27 Nov 2018 11:35:27 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181127133527.GI18284@habkost.net>
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
	<20181127092801.21777-17-marcandre.lureau@redhat.com>
	<20181127125644.GB18284@habkost.net>
	<CAMxuvaySoJ2TokV8M81CVU3Hp4dC25c+PW_p2kk+V88-88U-CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAMxuvaySoJ2TokV8M81CVU3Hp4dC25c+PW_p2kk+V88-88U-CQ@mail.gmail.com>
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
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Bonzini, Paolo" <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Michael S . Tsirkin" <mst@redhat.com>, david@gibson.dropbear.id.au, cohuck@redhat.com, David Hildenbrand <david@redhat.com>, borntraeger@de.ibm.com, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

On Tue, Nov 27, 2018 at 05:10:05PM +0400, Marc-Andr=E9 Lureau wrote:
> On Tue, Nov 27, 2018 at 4:57 PM Eduardo Habkost <ehabkost@redhat.com> w=
rote:
> >
> > On Tue, Nov 27, 2018 at 01:27:49PM +0400, Marc-Andr=E9 Lureau wrote:
> > > Similarly to accel properties, move compat properties out of global=
s
> > > registration, and apply the machine compat properties during
> > > device_post_init().
> > >
> > > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > [...]
> > > diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> > > index 7066d28271..3b31b2c025 100644
> > > --- a/hw/core/qdev.c
> > > +++ b/hw/core/qdev.c
> > > @@ -971,17 +971,26 @@ static void device_initfn(Object *obj)
> > >  }
> > >
> > >  static const GPtrArray *ac_compat_props;
> > > +static const GPtrArray *mc_compat_props;
> > >
> > >  void accel_register_compat_props(const GPtrArray *props)
> > >  {
> > >      ac_compat_props =3D props;
> > >  }
> > >
> > > +void machine_register_compat_props(const GPtrArray *props)
> > > +{
> > > +    mc_compat_props =3D props;
> > > +}
> > > +
> > >  static void device_post_init(Object *obj)
> > >  {
> > >      if (ac_compat_props) {
> > >          object_apply_global_props(obj, ac_compat_props, &error_abo=
rt);
> > >      }
> >
> > Why not just use MACHINE(qdev_get_machine())->accel->compat_props
> > directly?
> >
> > > +    if (mc_compat_props) {
> > > +        object_apply_global_props(obj, mc_compat_props, &error_abo=
rt);
> > > +    }
> >
> > Why not just use MACHINE(qdev_get_machine())->compat_props
> > directly?
>=20
> This was the approach in v3, but Igor didn't quite like referencing
> machine in qdev:
> https://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg04774.html

I disagree with Igor, here.  Core qdev code already have multiple
references to machine, I don't see any problem with that.

The previous code was clearer and easier to follow, and wasn't
sensitive to subtle changes in initialization ordering (e.g. what
happens if we create a device before *_register_compat_props() is
called?).


>=20
> >
> > >
> > >      qdev_prop_set_globals(DEVICE(obj));
> > >  }
> > [...]
> >
> > --
> > Eduardo

--=20
Eduardo
