Received: from eggs.gnu.org ([2001:4830:134:3::10]:47904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cgWZu-0005bO-EJ
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:03:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cgWZo-0007cA-A8
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:03:30 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:33806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cgWZn-0007bm-VL
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:03:24 -0500
Received: by mail-lf0-x244.google.com with SMTP id h67so181282lfg.1
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 05:03:23 -0800 (PST)
MIME-Version: 1.0
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
	<20170221141451.28305-24-marcandre.lureau@redhat.com>
	<967ff11e-ed7c-85b9-2c67-b3fb5335769e@redhat.com>
In-Reply-To: <967ff11e-ed7c-85b9-2c67-b3fb5335769e@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 22 Feb 2017 13:03:10 +0000
Message-ID: <CAJ+F1CLBs4tGRf2V3rvu7pYrW7h7jbHPBYkr26PPcDxYeF8T8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 23/30] bus: do not unref hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Hi

On Wed, Feb 22, 2017 at 3:39 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

>
>
> On 21/02/2017 15:14, Marc-Andr=C3=A9 Lureau wrote:
> > Apparently, none of the bus owner give a reference to the hotplug
> > handler property, do not unref it on bus release.
> >
> > Furthermore, a bus is allowed to be its own hotplug handler, which can
> > be seen in qbus_set_bus_hotplug_handler() function. However, in this
> > case, the reference can't be given to the property, or this will create
> > a cyclic dependency and the bus will never be free.
> >
> > Each bus owner should manage the lifecycle of the hotplug handler.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Almost all qbus_set_hotplug_handler callers are using it to set the
> parent device (that is, the "adapter" or "bridge", whatever you want to
> call it) as the hotplug handler.
>
> The exception is piix4_update_bus_hotplug.  This one is the only case
> where OBJ_PROP_LINK_UNREF_ON_RELEASE would be right.  Luckily, there
> _is_ a reference to that device somewhere else to keep it alive, namely
> in /machine's acpi-device prop.  So this case is a bit hacky (not your
> fault) but works as well.  In addition the PIIX4_PM device is not
> hot(un)pluggable.
>

I understand you agree with my change, correct?

>
> Can you please add a comment to piix4_update_bus_hotplug explaining that
> the PIIX4PMState cannot outlive the PCIBus, because /machine keeps it
> alive?
>

 Do you mean PCIBus cannot outlive PIIX4PMState? (ie the PIIX4PMState will
always be there since it's linked from /machine)

thanks

>
> >
> > diff --git a/hw/core/bus.c b/hw/core/bus.c
> > index cf383fc1af..4651f24486 100644
> > --- a/hw/core/bus.c
> > +++ b/hw/core/bus.c
> > @@ -197,7 +197,7 @@ static void qbus_initfn(Object *obj)
> >                               TYPE_HOTPLUG_HANDLER,
> >                               (Object **)&bus->hotplug_handler,
> >                               object_property_allow_set_link,
> > -                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
> > +                             0,
> >                               NULL);
> >      object_property_add_bool(obj, "realized",
> >                               bus_get_realized, bus_set_realized, NULL)=
;
> > --
> > 2.11.0.295.gd7dffce1c.dirty
> >
> >
> >
>
> --
Marc-Andr=C3=A9 Lureau
