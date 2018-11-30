Received: from eggs.gnu.org ([2001:4830:134:3::10]:44709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gShBn-0005GU-G6
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:42:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gShBj-0003jk-9j
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:42:31 -0500
Date: Fri, 30 Nov 2018 12:37:10 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181130123710.35c59ac0@redhat.com>
In-Reply-To: <CAJ+F1CK5NkgsJWFGZ7kvR81KyeOPE_ytk=tOjKqTUGtbfywmJQ@mail.gmail.com>
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
	<20181127092801.21777-17-marcandre.lureau@redhat.com>
	<20181127125644.GB18284@habkost.net>
	<CAMxuvaySoJ2TokV8M81CVU3Hp4dC25c+PW_p2kk+V88-88U-CQ@mail.gmail.com>
	<20181127133527.GI18284@habkost.net>
	<20181128184027.7d584eaa@redhat.com>
	<CAJ+F1CK5NkgsJWFGZ7kvR81KyeOPE_ytk=tOjKqTUGtbfywmJQ@mail.gmail.com>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, QEMU <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Qemu-s390x list <qemu-s390x@nongnu.org>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:sPAPR pseries" <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Thu, 29 Nov 2018 14:32:18 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

> Hi
> On Wed, Nov 28, 2018 at 9:53 PM Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > On Tue, 27 Nov 2018 11:35:27 -0200
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > =20
> > > On Tue, Nov 27, 2018 at 05:10:05PM +0400, Marc-Andr=C3=A9 Lureau wrot=
e: =20
> > > > On Tue, Nov 27, 2018 at 4:57 PM Eduardo Habkost <ehabkost@redhat.co=
m> wrote: =20
> > > > >
> > > > > On Tue, Nov 27, 2018 at 01:27:49PM +0400, Marc-Andr=C3=A9 Lureau =
wrote: =20
> > > > > > Similarly to accel properties, move compat properties out of gl=
obals
> > > > > > registration, and apply the machine compat properties during
> > > > > > device_post_init().
> > > > > >
> > > > > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.=
com> =20
> > > > > [...] =20
> > > > > > diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> > > > > > index 7066d28271..3b31b2c025 100644
> > > > > > --- a/hw/core/qdev.c
> > > > > > +++ b/hw/core/qdev.c
> > > > > > @@ -971,17 +971,26 @@ static void device_initfn(Object *obj)
> > > > > >  }
> > > > > >
> > > > > >  static const GPtrArray *ac_compat_props;
> > > > > > +static const GPtrArray *mc_compat_props; =20
> > why you didn't use just 'compat_props' for both?
> > (it would be cleaner have single registry for compat
> > properties, and the place that takes care of registration
> > will take care of necessary ordering) =20
>=20
> There are two arrays, one from the accelerator class, the other from
> the machine class. We can't make it a singleton (all compats props for
> the various machines would be mixed).
My impression was that we register properties explicitly here,
so only registered ones endup here and in the order they were added.
Hence machine and accel compats could be merged here.
=20
> We could create a third array that would be the set of both, but that
> would require more copy/allocation.
[...]
