Received: from eggs.gnu.org ([208.118.235.92]:44995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gfNAo-00020m-Bu
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 05:57:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gfNAk-00071U-AR
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 05:57:54 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gfNAc-0006y6-BM
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 05:57:45 -0500
Received: by mail-wm1-x343.google.com with SMTP id y139so766925wmc.5
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 02:57:39 -0800 (PST)
MIME-Version: 1.0
References: <20181221090410.27250-1-marcandre.lureau@redhat.com>
	<20181221090410.27250-26-marcandre.lureau@redhat.com>
	<20181221163426.1e0bbb35.cohuck@redhat.com>
In-Reply-To: <20181221163426.1e0bbb35.cohuck@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 4 Jan 2019 14:57:26 +0400
Message-ID: <CAJ+F1CLedF6tTqn3YSp9QeMchh_4LxBfiDCkLqn+8x2Q88GTDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, QEMU <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

Hi

On Fri, Dec 21, 2018 at 7:34 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Fri, 21 Dec 2018 13:04:07 +0400
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>
> > All qdev_prop_register_global() set &error_fatal for errp, except
> > '-rtc driftfix=3Dslew', which arguably should also use &error_fatal, as
> > otherwise failing to apply the property would only report a warning.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  include/hw/qdev-core.h    | 6 ------
> >  hw/core/qdev-properties.c | 4 ++--
> >  qom/cpu.c                 | 1 -
> >  target/i386/cpu.c         | 1 -
> >  target/sparc/cpu.c        | 1 -
> >  vl.c                      | 1 -
> >  6 files changed, 2 insertions(+), 12 deletions(-)
> >
>
> > diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> > index 3467e0485c..a2d25d3d37 100644
> > --- a/hw/core/qdev-properties.c
> > +++ b/hw/core/qdev-properties.c
> > @@ -1238,8 +1238,8 @@ void qdev_prop_set_globals(DeviceState *dev)
> >          if (err !=3D NULL) {
> >              error_prepend(&err, "can't apply global %s.%s=3D%s: ",
> >                            prop->driver, prop->property, prop->value);
> > -            if (!dev->hotplugged && prop->errp) {
> > -                error_propagate(prop->errp, err);
> > +            if (!dev->hotplugged) {
> > +                error_propagate(&error_fatal, err);
>
> Might want to add a comment to this function that any error is fatal
> for non-hotplugged devices.
>

What about adding the following comment to GlobalProperty?

 * An error is fatal for non-hotplugged devices, when the global is applied=
.

> >              } else {
> >                  warn_report_err(err);
> >              }
>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>

thanks

--=20
Marc-Andr=C3=A9 Lureau
