Received: from eggs.gnu.org ([209.51.188.92]:45784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hINad-0004Yw-3a
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 21:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hINab-0000EF-W0
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 21:17:47 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:45132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hINab-0000Cx-Lt
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 21:17:45 -0400
Received: by mail-oi1-x243.google.com with SMTP id y84so7421572oia.12
	for <qemu-devel@nongnu.org>; Sun, 21 Apr 2019 18:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190420161446.2274-1-liq3ea@163.com>
	<20190420161446.2274-2-liq3ea@163.com>
	<46a216be-0898-2d52-485d-fd07428c8b76@redhat.com>
In-Reply-To: <46a216be-0898-2d52-485d-fd07428c8b76@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 22 Apr 2019 09:17:07 +0800
Message-ID: <CAKXe6S+5TTO3Czxsx98rd3d5UvyCnd5gMeWE6RW8b_eeE_b+3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] edu: mmio: set 'max_access_size' to
 8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Li Qiang <liq3ea@163.com>, Jiri Slaby <jslaby@suse.cz>, Paolo Bonzini <pbonzini@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B44=E6=
=9C=8821=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=886:28=E5=86=99=E9=81=
=93=EF=BC=9A

> Hi Li,
>
> The patch title is not very descriptive, maybe "allow 64-bit access"
>
>
> On 4/20/19 6:14 PM, Li Qiang wrote:
> > The edu spec said, the MMIO area can be accessed by 8 bytes.
>
> or 64-bit...
>
> > However currently the 'max_access_size' is not so the MMIO
> > access dispatch can only access 4 bytes one time. This patch
>
> 32-bit
>
> > fixes this to respect the spec.
> >
> > Notice: here the 'min_access_size' is not a must, I set this
> > for completement.
>
> Which one? valid/impl? I think you can drop this comment from the commit
> description.
>
>
Both needed. from memory_access_size, if we has no valid.max_access_size,
this function will set it to 4.

static int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr)
{
    unsigned access_size_max =3D mr->ops->valid.max_access_size;

    /* Regions are assumed to support 1-4 byte accesses unless
       otherwise specified.  */
    if (access_size_max =3D=3D 0) {
        access_size_max =3D 4;
    }
   ...
}

>From access_with_adjusted_size, if we has no impl.max_access_size,
this function will set it to 4.

ps: I will appreciate if anyone can explain what's the meaning of valid and
impl's min/max_access_size
and how it affects the behavior.

Thanks,
Li Qiang

>
> > Signed-off-by: Li Qiang <liq3ea@163.com>
> > ---
> >  hw/misc/edu.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> > index 91af452c9e..65fc32b928 100644
> > --- a/hw/misc/edu.c
> > +++ b/hw/misc/edu.c
> > @@ -289,6 +289,15 @@ static const MemoryRegionOps edu_mmio_ops =3D {
> >      .read =3D edu_mmio_read,
> >      .write =3D edu_mmio_write,
> >      .endianness =3D DEVICE_NATIVE_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D 4,
>
> Per the spec, this is correct.
>
> > +        .max_access_size =3D 8,
>
> Correct.
>
> > +    },
> > +    .impl =3D {
> > +        .min_access_size =3D 4,
>
> OK.
>
> > +        .max_access_size =3D 8,
>
> Correct.
>
> > +    },
> > +
> >  };
> >
> >  /*
> >
>
> With title/description updated:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
>
