Received: from eggs.gnu.org ([209.51.188.92]:53530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hMbEy-0001wm-8J
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hMbEx-0000sc-3M
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:40:52 -0400
MIME-Version: 1.0
References: <20190503004021.13814-1-alistair.francis@wdc.com>
	<20190503092424.GB17905@redhat.com>
In-Reply-To: <20190503092424.GB17905@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 3 May 2019 09:38:50 -0700
Message-ID: <CAKmqyKO5Mhb5RyA13isjMJY2a6uUOLCmPtcK_HRt3uyWgm9XGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] hw/usb/hcd-xhci: Fix GCC 9 build warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kraxel@redhat.com" <kraxel@redhat.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "laurent@vivier.eu" <laurent@vivier.eu>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On Fri, May 3, 2019 at 2:24 AM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>
> On Fri, May 03, 2019 at 12:42:04AM +0000, Alistair Francis wrote:
> > Fix this build warning with GCC 9 on Fedora 30:
> > hw/usb/hcd-xhci.c:3339:66: error: =E2=80=98%d=E2=80=99 directive output=
 may be truncated writing between 1 and 10 bytes into a region of size 5 [-=
Werror=3Dformat-truncation=3D]
> >  3339 |             snprintf(port->name, sizeof(port->name), "usb2 port=
 #%d", i+1);
> >       |                                                                =
  ^~
> > hw/usb/hcd-xhci.c:3339:54: note: directive argument in the range [1, 21=
47483647]
> >  3339 |             snprintf(port->name, sizeof(port->name), "usb2 port=
 #%d", i+1);
> >       |                                                      ^~~~~~~~~~=
~~~~~
> > In file included from /usr/include/stdio.h:867,
> >                  from /home/alistair/qemu/include/qemu/osdep.h:99,
> >                  from hw/usb/hcd-xhci.c:21:
> > /usr/include/bits/stdio2.h:67:10: note: =E2=80=98__builtin___snprintf_c=
hk=E2=80=99 output between 13 and 22 bytes into a destination of size 16
> >    67 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVE=
L - 1,
> >       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
> >    68 |        __bos (__s), __fmt, __va_arg_pack ());
> >       |        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> > This is the onl patch left if my original series "Fix some GCC 9 build
> > warnings" that hasn't either been accepeted into a maintainers tree or
> > fixed by someone else.
> >
> >  hw/usb/hcd-xhci.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> > index ec28bee319..a15b103b65 100644
> > --- a/hw/usb/hcd-xhci.c
> > +++ b/hw/usb/hcd-xhci.c
> > @@ -3321,6 +3321,8 @@ static void usb_xhci_init(XHCIState *xhci)
> >
> >      usb_bus_new(&xhci->bus, sizeof(xhci->bus), &xhci_bus_ops, dev);
> >
> > +    g_assert(usbports <=3D MAX(MAXPORTS_2, MAXPORTS_3));
> > +
> >      for (i =3D 0; i < usbports; i++) {
> >          speedmask =3D 0;
> >          if (i < xhci->numports_2) {
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> but it looks like Gerd already sent a pull request with my patch for
> this from a few weeks back
>
> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg00543.html

No worries, I'm just glad it's fixed.

Alistair

>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
