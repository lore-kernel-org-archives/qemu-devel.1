Received: from eggs.gnu.org ([208.118.235.92]:46698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gfNH1-00056Y-26
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 06:04:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gfNGx-00020v-6w
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 06:04:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gfNGw-0001z9-S8
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 06:04:15 -0500
Date: Fri, 4 Jan 2019 12:04:06 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190104120406.52438fb2.cohuck@redhat.com>
In-Reply-To: <CAJ+F1CLedF6tTqn3YSp9QeMchh_4LxBfiDCkLqn+8x2Q88GTDg@mail.gmail.com>
References: <20181221090410.27250-1-marcandre.lureau@redhat.com>
	<20181221090410.27250-26-marcandre.lureau@redhat.com>
	<20181221163426.1e0bbb35.cohuck@redhat.com>
	<CAJ+F1CLedF6tTqn3YSp9QeMchh_4LxBfiDCkLqn+8x2Q88GTDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 25/28] qdev-props: remove errp from
 GlobalProperty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Cc: Igor Mammedov <imammedo@redhat.com>, QEMU <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

On Fri, 4 Jan 2019 14:57:26 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

> Hi
>=20
> On Fri, Dec 21, 2018 at 7:34 PM Cornelia Huck <cohuck@redhat.com> wrote:
> >
> > On Fri, 21 Dec 2018 13:04:07 +0400
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> > =20
> > > All qdev_prop_register_global() set &error_fatal for errp, except
> > > '-rtc driftfix=3Dslew', which arguably should also use &error_fatal, =
as
> > > otherwise failing to apply the property would only report a warning.
> > >
> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
> > >  include/hw/qdev-core.h    | 6 ------
> > >  hw/core/qdev-properties.c | 4 ++--
> > >  qom/cpu.c                 | 1 -
> > >  target/i386/cpu.c         | 1 -
> > >  target/sparc/cpu.c        | 1 -
> > >  vl.c                      | 1 -
> > >  6 files changed, 2 insertions(+), 12 deletions(-)
> > > =20
> > =20
> > > diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> > > index 3467e0485c..a2d25d3d37 100644
> > > --- a/hw/core/qdev-properties.c
> > > +++ b/hw/core/qdev-properties.c
> > > @@ -1238,8 +1238,8 @@ void qdev_prop_set_globals(DeviceState *dev)
> > >          if (err !=3D NULL) {
> > >              error_prepend(&err, "can't apply global %s.%s=3D%s: ",
> > >                            prop->driver, prop->property, prop->value);
> > > -            if (!dev->hotplugged && prop->errp) {
> > > -                error_propagate(prop->errp, err);
> > > +            if (!dev->hotplugged) {
> > > +                error_propagate(&error_fatal, err); =20
> >
> > Might want to add a comment to this function that any error is fatal
> > for non-hotplugged devices.
> > =20
>=20
> What about adding the following comment to GlobalProperty?
>=20
>  * An error is fatal for non-hotplugged devices, when the global is appli=
ed.

Sounds good.

>=20
> > >              } else {
> > >                  warn_report_err(err);
> > >              } =20
> >
> > Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> > =20
>=20
> thanks
>=20
