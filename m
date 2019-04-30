Received: from eggs.gnu.org ([209.51.188.92]:58566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLZuX-0002hi-JU
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:03:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLZs6-0000RJ-Sy
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:01:03 -0400
MIME-Version: 1.0
References: <cover.1556650594.git.alistair.francis@wdc.com>
	<c4768a18309b3918715f96a1f5b2a9a264a5a9e4.1556650594.git.alistair.francis@wdc.com>
	<8ca522c7-d1dd-fe05-f8ab-031b72a9fbef@vivier.eu>
In-Reply-To: <8ca522c7-d1dd-fe05-f8ab-031b72a9fbef@vivier.eu>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Apr 2019 13:59:06 -0700
Message-ID: <CAKmqyKNRO7ESNmngtV3b8EjZfiuuu9QQm6avfwUuGe=NtpS46A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 2/5] hw/usb/hcd-xhci: Fix GCC 9 build
 warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kraxel@redhat.com" <kraxel@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>

On Tue, Apr 30, 2019 at 1:24 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 30/04/2019 =C3=A0 22:09, Alistair Francis a =C3=A9crit :
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
>
> "i" cannot be greater than 15.
>
> perhaps an "assert(i <=3D MAX(MAXPORTS_2, MAXPORTS_3))" can fix the warni=
ng ?

It does seem to stop the warnings, I'll change this patch to use a g_assert=
().

Alistair

>
> Thanks,
> Laurent
>
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
> > ---
> >  hw/usb/hcd-xhci.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
> > index 240caa4e51..9e4988abb6 100644
> > --- a/hw/usb/hcd-xhci.h
> > +++ b/hw/usb/hcd-xhci.h
> > @@ -133,7 +133,7 @@ typedef struct XHCIPort {
> >      uint32_t portnr;
> >      USBPort  *uport;
> >      uint32_t speedmask;
> > -    char name[16];
> > +    char name[24];
> >      MemoryRegion mem;
> >  } XHCIPort;
> >
> >
>
