Received: from eggs.gnu.org ([2001:4830:134:3::10]:52802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gRN5q-00087p-J3
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:02:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gRN5o-0008JO-Lk
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:02:54 -0500
MIME-Version: 1.0
References: <20181107123652.23417-1-marcandre.lureau@redhat.com>
	<20181107123652.23417-11-marcandre.lureau@redhat.com>
	<20181126142046.07c5e227@redhat.com>
In-Reply-To: <20181126142046.07c5e227@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 27 Nov 2018 00:02:35 +0400
Message-ID: <CAJ+F1C+XA0hzUCOgxm8MML1QZ-VfVUAG=yq1ZHAh1+t3jMbQgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>, amit@kernel.org, hpoussin@reactos.org, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:sPAPR pseries" <qemu-ppc@nongnu.org>, xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, stefanb@linux.ibm.com, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, atar4qemu@gmail.com, Richard Henderson <rth@twiddle.net>

Hi
On Mon, Nov 26, 2018 at 5:27 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Wed,  7 Nov 2018 16:36:48 +0400
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>
> > It's now possible to use the common function.
> >
> > Teach object_apply_global_props() to warn if Error argument is NULL.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/core/qdev-properties.c | 24 ++----------------------
> >  qom/object.c              |  6 +++++-
> >  2 files changed, 7 insertions(+), 23 deletions(-)
> >
> > diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> > index 8728cbab9f..239535a4cb 100644
> > --- a/hw/core/qdev-properties.c
> > +++ b/hw/core/qdev-properties.c
> > @@ -1223,28 +1223,8 @@ int qdev_prop_check_globals(void)
> >
> >  void qdev_prop_set_globals(DeviceState *dev)
> >  {
> > -    int i;
> > -
> > -    for (i =3D 0; i < global_props()->len; i++) {
> > -        GlobalProperty *prop;
> > -        Error *err =3D NULL;
> > -
> > -        prop =3D g_array_index(global_props(), GlobalProperty *, i);
> > -        if (object_dynamic_cast(OBJECT(dev), prop->driver) =3D=3D NULL=
) {
> > -            continue;
> > -        }
> > -        prop->used =3D true;
> > -        object_property_parse(OBJECT(dev), prop->value, prop->property=
, &err);
> > -        if (err !=3D NULL) {
> > -            error_prepend(&err, "can't apply global %s.%s=3D%s: ",
> > -                          prop->driver, prop->property, prop->value);
> > -            if (!dev->hotplugged) {
> > -                error_propagate(&error_fatal, err);
> > -            } else {
> > -                warn_report_err(err);
> > -            }
> > -        }
> > -    }
> > +    object_apply_global_props(OBJECT(dev), global_props(),
> > +                              dev->hotplugged ? NULL : &error_fatal);
> arguably, it's up to caller to decide it warn or not.
> I'd leave it warning code out of object_apply_global_props() and let call=
er do the job

The problem is that there may be multiple errors, and the remaining
globals should be applied.

I'll add a comment.

> >  }
> >
> >  /* --- 64bit unsigned int 'size' type --- */
> > diff --git a/qom/object.c b/qom/object.c
> > index 9acdf9e16d..b1a7f70550 100644
> > --- a/qom/object.c
> > +++ b/qom/object.c
> > @@ -392,7 +392,11 @@ void object_apply_global_props(Object *obj, GArray=
 *props, Error **errp)
> >          if (err !=3D NULL) {
> >              error_prepend(&err, "can't apply global %s.%s=3D%s: ",
> >                            p->driver, p->property, p->value);
> > -            error_propagate(errp, err);
> > +            if (errp) {
> > +                error_propagate(errp, err);
> > +            } else {
> > +                warn_report_err(err);
> > +            }
> >          }
> >      }
> >  }
>
>


--=20
Marc-Andr=C3=A9 Lureau
