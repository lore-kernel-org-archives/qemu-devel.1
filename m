Received: from eggs.gnu.org ([2001:4830:134:3::10]:57092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dnLu8-00013y-13
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:36:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dnLu6-0008Lq-Ue
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:36:52 -0400
Received: from mail-vk0-x243.google.com ([2607:f8b0:400c:c05::243]:33927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dnLu6-0008Li-P4
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:36:50 -0400
Received: by mail-vk0-x243.google.com with SMTP id x85so60099vkx.1
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 02:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20170831035306.29170-1-f4bug@amsat.org>
	<20170831035306.29170-2-f4bug@amsat.org>
	<be9ca245-f1af-e78a-aa12-c479e59b2985@redhat.com>
In-Reply-To: <be9ca245-f1af-e78a-aa12-c479e59b2985@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 31 Aug 2017 09:36:39 +0000
Message-ID: <CAJ+F1C+sdOFyNT9-HMEkaSTbt4diPEA-m=+Do2x7GObyyxb7fQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/7] serial: add serial_chr_nonnull() to
 use the null backend when none provided
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

Hi

On Thu, Aug 31, 2017 at 7:20 AM Thomas Huth <thuth@redhat.com> wrote:

> On 31.08.2017 05:53, Philippe Mathieu-Daud=C3=A9 wrote:
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >  include/hw/char/serial.h |  1 +
> >  hw/char/serial.c         | 13 +++++++++++++
> >  2 files changed, 14 insertions(+)
> >
> > diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
> > index c4daf11a14..96bccb39e1 100644
> > --- a/include/hw/char/serial.h
> > +++ b/include/hw/char/serial.h
> > @@ -93,6 +93,7 @@ SerialState *serial_mm_init(MemoryRegion
> *address_space,
> >                              hwaddr base, int it_shift,
> >                              qemu_irq irq, int baudbase,
> >                              Chardev *chr, enum device_endian end);
> > +Chardev *serial_chr_nonnull(Chardev *chr);
>
> Why do you need the prototype? Please make the function static if
> possible (otherwise please add some rationale in the patch description).
>

It's being used from other units in following patches


> >  /* serial-isa.c */
> >  #define TYPE_ISA_SERIAL "isa-serial"
> > diff --git a/hw/char/serial.c b/hw/char/serial.c
> > index 9aec6c60d8..7a100db107 100644
> > --- a/hw/char/serial.c
> > +++ b/hw/char/serial.c
> > @@ -1025,6 +1025,19 @@ static const MemoryRegionOps serial_mm_ops[3] =
=3D {
> >      },
> >  };
> >
> > +Chardev *serial_chr_nonnull(Chardev *chr)
> > +{
> > +    static int serial_id;
> > +    char *label;
> > +
> > +    label =3D g_strdup_printf("discarding-serial%d", serial_id++);
> > +    chr =3D qemu_chr_new(label, "null");
>
> That looks wrong - you're ignoring the input parameter and always open
> the "null" device? Shouldn't there be a "if (chr) return chr;" in front
> of this?
>

I think its missing too.

The function name and usage isn't obvious. I would rather see the caller
use "chr ?: serial_chr_null()" rather than "serial_chr_nonnull(chr)".


--=20
Marc-Andr=C3=A9 Lureau
