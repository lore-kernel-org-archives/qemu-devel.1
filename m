Received: from eggs.gnu.org ([209.51.188.92]:44585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gzjds-0003Sm-2i
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:00:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gzjdq-0005hN-6h
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:00:04 -0500
Received: from 4.mo3.mail-out.ovh.net ([178.33.46.10]:59417)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gzjdp-0005e8-7C
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:00:02 -0500
Received: from player695.ha.ovh.net (unknown [10.109.146.20])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 714181FE8D7
	for <qemu-devel@nongnu.org>; Fri,  1 Mar 2019 15:59:57 +0100 (CET)
Date: Fri, 1 Mar 2019 15:59:51 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190301155951.11122086@bahia.lan>
In-Reply-To: <CAFEAcA_B4fMvhP+cXhZQX0g5FMq1MvPxcfboT=pDSu9Ww_fFNA@mail.gmail.com>
References: <155137665241.44413.528147250140332507.stgit@bahia.lan>
	<CAFEAcA_B4fMvhP+cXhZQX0g5FMq1MvPxcfboT=pDSu9Ww_fFNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] usb-mtp: Fix build with gcc 9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Bandan Das <bsd@redhat.com>

On Thu, 28 Feb 2019 18:28:23 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Thu, 28 Feb 2019 at 17:57, Greg Kurz <groug@kaod.org> wrote:
> >
> > Build fails with gcc 9:
> >
> >   CC      hw/usb/dev-mtp.o
> > hw/usb/dev-mtp.c: In function =E2=80=98usb_mtp_write_metadata=E2=80=99:
> > hw/usb/dev-mtp.c:1754:36: error: taking address of packed member of =E2=
=80=98struct <anonymous>=E2=80=99 may result in an unaligned pointer value =
[-Werror=3Daddress-of-packed-member]
> >  1754 |                             dataset->filename);
> >       |                             ~~~~~~~^~~~~~~~~~
> > cc1: all warnings being treated as errors
> >
> > The way the MTP protocol encodes strings with a leading 8-bit unsigned
> > integer containing the string length causes the @filename field of the
> > packed ObjectInfo structure to be unaligned.
> >
> > Use a temporary buffer for the utf16 filename instead of passing the
> > dataset->filename pointer around.
> >
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/usb/dev-mtp.c |   18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> > index 4ee4fc5a893a..8a0ef7f9f4a8 100644
> > --- a/hw/usb/dev-mtp.c
> > +++ b/hw/usb/dev-mtp.c
> > @@ -1692,13 +1692,25 @@ static void usb_mtp_write_metadata(MTPState *s,=
 uint64_t dlen)
> >      MTPObject *o;
> >      MTPObject *p =3D usb_mtp_object_lookup(s, s->dataset.parent_handle=
);
> >      uint32_t next_handle =3D s->next_handle;
> > +    uint16_t *utf16_filename;
> > +    uint8_t filename_len;
> >
> >      assert(!s->write_pending);
> >      assert(p !=3D NULL);
> >
> > -    filename =3D utf16_to_str(MIN(dataset->length,
> > -                                dlen - offsetof(ObjectInfo, filename)),
> > -                            dataset->filename);
> > +    /*
> > +     * MTP Specification 3.2.3 Strings
> > +     * Strings in PTP (and thus MTP) consist of standard 2-byte Unicode
> > +     * characters as defined by ISO 10646. Strings begin with a single=
, 8-bit
> > +     * unsigned integer that identifies the number of characters to fo=
llow (not
> > +     * bytes).
> > +     *
> > +     * This causes dataset->filename to be unaligned.
> > +     */
> > +    filename_len =3D MIN(dataset->length, dlen - offsetof(ObjectInfo, =
filename));
> > +    utf16_filename =3D g_memdup(dataset->filename, filename_len * 2);
> > +    filename =3D utf16_to_str(filename_len, utf16_filename);
> > +    g_free(utf16_filename); =20
>=20
> I think there's an underlying problem with this code which we
> should deal with differently. The 'dataset' local in this
> file is (I think) pointing at on-the-wire information from
> the USB device, but we're treating it as an array of
> host-order uint16_t values. Is this really correct on a
> big-endian host ?

I don't know much about usb-mtp and the MTP spec says:

https://theta360blog.files.wordpress.com/2016/04/mtpforusb-ifv1-1.pdf

3.1.1 Multi-byte Data

The standard format for multi-byte data in this specification is
big-endian. That is, the bits within a byte will be read such that
the most significant byte is read first. The actual multi-byte data
sent over the transport may not necessarily adhere to this same
format, and the actual multi-byte data used on the devices may also
use a different multi-byte format. The big-endian convention only
applies within this document, except where otherwise stated.

So I'm not sure about what the code should really do here... :-\

> Do we do the right thing if we are
> passed a malicious USB packet that ends halfway through a
> utf16_t character, or do we index off the end of the packet
> data ?
>=20

Can you elaborate ?

> I think that we should define the "filename" field in
> ObjectInfo to be a uint8_t array, make utf16_to_str()
> take a uint8_t* for its data array, and have it do the
> reading of data from the array with lduw_he_p(), which
> can handle accessing unaligned data.
>=20
> We should also check what the endianness of other fields in
> the ObjectInfo struct is (eg "format" and "size" and see
> whether we should be doing byte swapping here.
>=20

I don't have any idea on that... the code just seems to assume
everything is host endian.

> PS: it is a bit confusing that in this function the local
> variable "dataset" is a pointer to a struct of entirely
> different type to the one that s->dataset is.
>=20

Maybe Gerd or Bandan can comment on that.

> thanks
> -- PMM
