Received: from eggs.gnu.org ([2001:4830:134:3::10]:39866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ewZLD-0000Rt-Re
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 16:19:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ewZLC-0006Fk-TV
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 16:19:11 -0400
Date: Thu, 15 Mar 2018 22:18:57 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180315221840-mutt-send-email-mst@kernel.org>
References: <1521100145-15304-1-git-send-email-thuth@redhat.com>
	<1521100145-15304-2-git-send-email-thuth@redhat.com>
	<cd0806bc-6503-6cab-5f23-a92128ad0af3@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <cd0806bc-6503-6cab-5f23-a92128ad0af3@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] tests/boot-sector: Add magic bytes to
 s390x boot code header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Victor Kaplansky <victork@redhat.com>, qemu-block@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-s390x@nongnu.org, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>

On Thu, Mar 15, 2018 at 12:47:08PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 03/15/2018 08:49 AM, Thomas Huth wrote:
> > We're going to use the s390x boot code for testing CD-ROM booting.
> > But the ISO loader of the s390-ccw bios is a little bit more picky
> > than the network loader and expects some magic bytes in the header
> > of the file (see linux_s390_magic in pc-bios/s390-ccw/bootmap.c), so
> > we've got to add them in our boot code here, too.
> >=20
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  tests/boot-sector.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/tests/boot-sector.c b/tests/boot-sector.c
> > index c373f0e..04721c9 100644
> > --- a/tests/boot-sector.c
> > +++ b/tests/boot-sector.c
> > @@ -68,8 +68,11 @@ static uint8_t x86_boot_sector[512] =3D {
> >  };
> > =20
> >  /* For s390x, use a mini "kernel" with the appropriate signature */
> > -static const uint8_t s390x_psw[] =3D {
> > -    0x00, 0x08, 0x00, 0x00, 0x80, 0x01, 0x00, 0x00
> > +static const uint8_t s390x_psw_and_magic[] =3D {
>=20
> Can you add a comment such "see linux_s390_magic in
> pc-bios/s390-ccw/bootmap.c"?

Or better yet, copy the code comment from there.

> > +    0x00, 0x08, 0x00, 0x00, 0x80, 0x01, 0x00, 0x00,
> > +    0x02, 0x00, 0x00, 0x18, 0x60, 0x00, 0x00, 0x50,
> > +    0x02, 0x00, 0x00, 0x68, 0x60, 0x00, 0x00, 0x50,
> > +    0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40
> >  };
> >  static const uint8_t s390x_code[] =3D {
> >      0xa7, 0xf4, 0x00, 0x0a,                                /* j 0x10=
010 */
> > @@ -110,7 +113,7 @@ int boot_sector_init(char *fname)
> >      } else if (g_str_equal(arch, "s390x")) {
> >          len =3D 0x10000 + sizeof(s390x_code);
> >          boot_code =3D g_malloc0(len);
> > -        memcpy(boot_code, s390x_psw, sizeof(s390x_psw));
> > +        memcpy(boot_code, s390x_psw_and_magic, sizeof(s390x_psw_and_=
magic));
> >          memcpy(&boot_code[0x10000], s390x_code, sizeof(s390x_code));
> >      } else {
> >          g_assert_not_reached();
> >=20
