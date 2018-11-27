Received: from eggs.gnu.org ([2001:4830:134:3::10]:57451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gRe6d-0003xv-8N
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:12:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gRe6c-0003w0-Ai
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:12:51 -0500
Date: Tue, 27 Nov 2018 15:12:12 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181127151212.4583e324@redhat.com>
In-Reply-To: <CAJ+F1C+XA0hzUCOgxm8MML1QZ-VfVUAG=yq1ZHAh1+t3jMbQgQ@mail.gmail.com>
References: <20181107123652.23417-1-marcandre.lureau@redhat.com>
	<20181107123652.23417-11-marcandre.lureau@redhat.com>
	<20181126142046.07c5e227@redhat.com>
	<CAJ+F1C+XA0hzUCOgxm8MML1QZ-VfVUAG=yq1ZHAh1+t3jMbQgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v3 10/14] qdev-props: call
 object_apply_global_props()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>, amit@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "open list:ARM" <qemu-arm@nongnu.org>, hpoussin@reactos.org, xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>, "open list:sPAPR pseries" <qemu-ppc@nongnu.org>, Richard Henderson <rth@twiddle.net>, Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>, atar4qemu@gmail.com, stefanb@linux.ibm.com

On Tue, 27 Nov 2018 00:02:35 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

> Hi
> On Mon, Nov 26, 2018 at 5:27 PM Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > On Wed,  7 Nov 2018 16:36:48 +0400
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> > =20
> > > It's now possible to use the common function.
> > >
> > > Teach object_apply_global_props() to warn if Error argument is NULL.
> > >
> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  hw/core/qdev-properties.c | 24 ++----------------------
> > >  qom/object.c              |  6 +++++-
> > >  2 files changed, 7 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> > > index 8728cbab9f..239535a4cb 100644
> > > --- a/hw/core/qdev-properties.c
> > > +++ b/hw/core/qdev-properties.c
> > > @@ -1223,28 +1223,8 @@ int qdev_prop_check_globals(void)
> > >
> > >  void qdev_prop_set_globals(DeviceState *dev)
> > >  {
> > > -    int i;
> > > -
> > > -    for (i =3D 0; i < global_props()->len; i++) {
> > > -        GlobalProperty *prop;
> > > -        Error *err =3D NULL;
> > > -
> > > -        prop =3D g_array_index(global_props(), GlobalProperty *, i);
> > > -        if (object_dynamic_cast(OBJECT(dev), prop->driver) =3D=3D NU=
LL) {
> > > -            continue;
> > > -        }
> > > -        prop->used =3D true;
> > > -        object_property_parse(OBJECT(dev), prop->value, prop->proper=
ty, &err);
> > > -        if (err !=3D NULL) {
> > > -            error_prepend(&err, "can't apply global %s.%s=3D%s: ",
> > > -                          prop->driver, prop->property, prop->value);
> > > -            if (!dev->hotplugged) {
> > > -                error_propagate(&error_fatal, err);
> > > -            } else {
> > > -                warn_report_err(err);
> > > -            }
> > > -        }
> > > -    }
> > > +    object_apply_global_props(OBJECT(dev), global_props(),
> > > +                              dev->hotplugged ? NULL : &error_fatal)=
; =20
> > arguably, it's up to caller to decide it warn or not.
> > I'd leave it warning code out of object_apply_global_props() and let ca=
ller do the job =20
>=20
> The problem is that there may be multiple errors, and the remaining
> globals should be applied.
>
> I'll add a comment.
ok

=20
> > >  }
> > >
> > >  /* --- 64bit unsigned int 'size' type --- */
> > > diff --git a/qom/object.c b/qom/object.c
> > > index 9acdf9e16d..b1a7f70550 100644
> > > --- a/qom/object.c
> > > +++ b/qom/object.c
> > > @@ -392,7 +392,11 @@ void object_apply_global_props(Object *obj, GArr=
ay *props, Error **errp)
> > >          if (err !=3D NULL) {
> > >              error_prepend(&err, "can't apply global %s.%s=3D%s: ",
> > >                            p->driver, p->property, p->value);
> > > -            error_propagate(errp, err);
> > > +            if (errp) {
> > > +                error_propagate(errp, err);
> > > +            } else {
> > > +                warn_report_err(err);
> > > +            }
> > >          }
> > >      }
> > >  } =20
> >
> > =20
>=20
>=20
