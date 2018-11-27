Received: from eggs.gnu.org ([2001:4830:134:3::10]:33514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gRd8A-0007ry-Sl
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:10:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gRd87-00023F-O8
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:10:22 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gRd87-000226-I0
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:10:19 -0500
Received: by mail-qt1-f193.google.com with SMTP id z16so21566167qtq.4
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 05:10:18 -0800 (PST)
MIME-Version: 1.0
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
	<20181127092801.21777-17-marcandre.lureau@redhat.com>
	<20181127125644.GB18284@habkost.net>
In-Reply-To: <20181127125644.GB18284@habkost.net>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 27 Nov 2018 17:10:05 +0400
Message-ID: <CAMxuvaySoJ2TokV8M81CVU3Hp4dC25c+PW_p2kk+V88-88U-CQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Bonzini, Paolo" <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Michael S . Tsirkin" <mst@redhat.com>, david@gibson.dropbear.id.au, cohuck@redhat.com, David Hildenbrand <david@redhat.com>, borntraeger@de.ibm.com, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

On Tue, Nov 27, 2018 at 4:57 PM Eduardo Habkost <ehabkost@redhat.com> wrote=
:
>
> On Tue, Nov 27, 2018 at 01:27:49PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Similarly to accel properties, move compat properties out of globals
> > registration, and apply the machine compat properties during
> > device_post_init().
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> [...]
> > diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> > index 7066d28271..3b31b2c025 100644
> > --- a/hw/core/qdev.c
> > +++ b/hw/core/qdev.c
> > @@ -971,17 +971,26 @@ static void device_initfn(Object *obj)
> >  }
> >
> >  static const GPtrArray *ac_compat_props;
> > +static const GPtrArray *mc_compat_props;
> >
> >  void accel_register_compat_props(const GPtrArray *props)
> >  {
> >      ac_compat_props =3D props;
> >  }
> >
> > +void machine_register_compat_props(const GPtrArray *props)
> > +{
> > +    mc_compat_props =3D props;
> > +}
> > +
> >  static void device_post_init(Object *obj)
> >  {
> >      if (ac_compat_props) {
> >          object_apply_global_props(obj, ac_compat_props, &error_abort);
> >      }
>
> Why not just use MACHINE(qdev_get_machine())->accel->compat_props
> directly?
>
> > +    if (mc_compat_props) {
> > +        object_apply_global_props(obj, mc_compat_props, &error_abort);
> > +    }
>
> Why not just use MACHINE(qdev_get_machine())->compat_props
> directly?

This was the approach in v3, but Igor didn't quite like referencing
machine in qdev:
https://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg04774.html

>
> >
> >      qdev_prop_set_globals(DEVICE(obj));
> >  }
> [...]
>
> --
> Eduardo
