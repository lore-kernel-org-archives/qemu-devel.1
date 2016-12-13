Received: from eggs.gnu.org ([2001:4830:134:3::10]:60546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cGr8Z-0005Xu-06
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 12:45:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cGr8U-0002rD-Dh
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 12:45:10 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cGr8U-0002qK-1r
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 12:45:06 -0500
Received: by mail-lf0-f67.google.com with SMTP id y21so4275884lfa.0
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 09:45:05 -0800 (PST)
MIME-Version: 1.0
References: <583d59a6.dcc6370a.3a361.b5d4@mx.google.com>
	<CAKXe6S+BB_72vZLWDhJk65Qm1Uh-2COKEEwM9YyaCF4aL1x1nA@mail.gmail.com>
In-Reply-To: <CAKXe6S+BB_72vZLWDhJk65Qm1Uh-2COKEEwM9YyaCF4aL1x1nA@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 13 Dec 2016 17:43:53 +0000
Message-ID: <CAJ+F1C+NpMcr+Kx9uOYbmjrPf2bQ5LBh+qVosG1OWMVi6wqJgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] audio: ac97: add exit function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, kraxel@redhat.com, qemu-devel@nongnu.org
Cc: Li Qiang <liqiang6-s@360.cn>

Hi

On Tue, Dec 13, 2016 at 11:56 AM Li Qiang <liq3ea@gmail.com> wrote:

> Ping!
>
> 2016-11-29 18:33 GMT+08:00 Li Qiang <liq3ea@gmail.com>:
>
> > From: Li Qiang <liqiang6-s@360.cn>
> >
> > Currently the ac97 device emulation doesn't have a exit function,
> > hot unplug this device will leak some leak. Add a exit function to
> > avoid this.
> >
> > Signed-off-by: Li Qiang <liqiang6-s@360.cn>
> > ---
> >  hw/audio/ac97.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
> > index cbd959e..2faed35 100644
> > --- a/hw/audio/ac97.c
> > +++ b/hw/audio/ac97.c
> > @@ -1387,6 +1387,13 @@ static void ac97_realize(PCIDevice *dev, Error
> > **errp)
> >      ac97_on_reset (&s->dev.qdev);
> >  }
> >
> > +static void ac97_exit(PCIDevice *dev)
> > +{
> > +    AC97LinkState *s =3D DO_UPCAST(AC97LinkState, dev, dev);
> > +
> > +    AUD_remove_card(&s->card);
> > +}
> > +
>

Looks good, but even better is to close the streams

 diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 2faed35627..3dcfe9d67c 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -1391,6 +1391,9 @@ static void ac97_exit(PCIDevice *dev)
 {
     AC97LinkState *s =3D DO_UPCAST(AC97LinkState, dev, dev);

+    AUD_close_in (&s->card, s->voice_pi);
+    AUD_close_out (&s->card, s->voice_po);
+    AUD_close_in (&s->card, s->voice_mc);
     AUD_remove_card(&s->card);
 }

We could also investigate if AUD_remove_card could do that instead.

>  static int ac97_init (PCIBus *bus)
> >  {
> >      pci_create_simple (bus, -1, "AC97");
> > @@ -1404,6 +1411,7 @@ static void ac97_class_init (ObjectClass *klass,
> > void *data)
> >      PCIDeviceClass *k =3D PCI_DEVICE_CLASS (klass);
> >
> >      k->realize =3D ac97_realize;
> > +    k->exit =3D ac97_exit;
> >      k->vendor_id =3D PCI_VENDOR_ID_INTEL;
> >      k->device_id =3D PCI_DEVICE_ID_INTEL_82801AA_5;
> >      k->revision =3D 0x01;
> > --
> > 1.8.3.1
> >
> >
>
--=20
Marc-Andr=C3=A9 Lureau
