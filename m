Received: from eggs.gnu.org ([209.51.188.92]:55840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLZeu-0002jO-Ar
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLZes-00005G-Db
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:47:24 -0400
MIME-Version: 1.0
References: <cover.1556650594.git.alistair.francis@wdc.com>
	<f2aaec5b3c12a8512cd7078f3a5d1230906d80ea.1556650594.git.alistair.francis@wdc.com>
	<6650d0b8-1c5c-a8ea-ef92-a69ad50f7d8b@redhat.com>
In-Reply-To: <6650d0b8-1c5c-a8ea-ef92-a69ad50f7d8b@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Apr 2019 13:45:23 -0700
Message-ID: <CAKmqyKP0-Aikd3+fF-u=be_2ZaRtfa6Sx-Cxu49uFtXgN9C_Ew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 3/5] hw/usb/dev-mtp: Fix GCC 9 build
 warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "laurent@vivier.eu" <laurent@vivier.eu>, "kraxel@redhat.com" <kraxel@redhat.com>

On Tue, Apr 30, 2019 at 1:37 PM Eric Blake <eblake@redhat.com> wrote:
>
> On 4/30/19 3:09 PM, Alistair Francis wrote:
> > Fix this warning with GCC 9 on Fedora 30:
> > hw/usb/dev-mtp.c:1715:36: error: taking address of packed member of =E2=
=80=98struct <anonymous>=E2=80=99 may result in an unaligned pointer value =
[-Werror=3Daddress-of-packed-member]
> >  1715 |                             dataset->filename);
> >       |                             ~~~~~~~^~~~~~~~~~
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  hw/usb/dev-mtp.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> > index 99548b012d..6de85d99e6 100644
> > --- a/hw/usb/dev-mtp.c
> > +++ b/hw/usb/dev-mtp.c
> > @@ -1711,9 +1711,22 @@ static void usb_mtp_write_metadata(MTPState *s, =
uint64_t dlen)
> >      assert(!s->write_pending);
> >      assert(p !=3D NULL);
> >
> > +/*
> > + * We are about to access a packed struct. We are confident that the p=
ointer
> > + * address won't be unalligned, so we ignore GCC warnings.
>
> unaligned

Fixed.

>
> Aren't there other potential proposed patches floating around for this
> issue that do not involve messing with pragmas?

I'm not sure, I haven't seen anything. I'm more then open to a better
fix, this is the best option I could think of.

Alistair

>
> > + */
> > +#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && QEMU_GNUC_PREREQ(9,=
 0)
> > +#pragma GCC diagnostic push
> > +#pragma GCC diagnostic ignored "-Waddress-of-packed-member"
> > +#endif
> > +
> >      filename =3D utf16_to_str(MIN(dataset->length, filename_chars),
> >                              dataset->filename);
> >
> > +#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && QEMU_GNUC_PREREQ(9,=
 0)
> > +#pragma GCC diagnostic pop
> > +#endif
> > +
> >      if (strchr(filename, '/')) {
> >          usb_mtp_queue_result(s, RES_PARAMETER_NOT_SUPPORTED, d->trans,
> >                               0, 0, 0, 0);
> >
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
