Received: from eggs.gnu.org ([209.51.188.92]:46450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hINfu-0006Pr-J4
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 21:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hINft-0004XS-F4
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 21:23:14 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:35800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hINft-0004Wu-9r
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 21:23:13 -0400
Received: by mail-oi1-x22b.google.com with SMTP id j132so7474011oib.2
	for <qemu-devel@nongnu.org>; Sun, 21 Apr 2019 18:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190420161446.2274-1-liq3ea@163.com>
	<20190420161446.2274-3-liq3ea@163.com>
	<51d2ae28-267a-2710-8401-bad769e2d2c0@redhat.com>
In-Reply-To: <51d2ae28-267a-2710-8401-bad769e2d2c0@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 22 Apr 2019 09:22:35 +0800
Message-ID: <CAKXe6SJLyUwLOQhmkoWENwLE-bFrVmUYxbRgh7pmYKtS5C9d8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/3] edu: mmio: allow mmio read dispatch
 accept 8 bytes
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
=9C=8821=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=886:44=E5=86=99=E9=81=
=93=EF=BC=9A

> Hi Li,
>
> On 4/20/19 6:14 PM, Li Qiang wrote:
> > The edu spec said when address >=3D 0x80, the MMIO area can
>
> "says"
>
> > be accessed by 8 bytes.
> >
> > Signed-off-by: Li Qiang <liq3ea@163.com>
> > ---
> >  hw/misc/edu.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> > index 65fc32b928..4018dddcb8 100644
> > --- a/hw/misc/edu.c
> > +++ b/hw/misc/edu.c
> > @@ -189,6 +189,10 @@ static uint64_t edu_mmio_read(void *opaque, hwaddr
> addr, unsigned size)
>
> Completing the diff ...:
>
>        if (size !=3D 4) {
>
> >          return val;
> >      }
> >
> > +    if (addr >=3D 0x80 && size !=3D 4 && size !=3D 8) {
>
> ... to show this code is unreachable for size =3D=3D 8.
>
>
Ohhh, yes



> > +        return val;
> > +    }
> > +
> >      switch (addr) {
> >      case 0x00:
> >          val =3D 0x010000edu;
> >
>
> I think the change you wanted is:
>
> -- >8 --
> @@ -185,7 +185,11 @@ static uint64_t edu_mmio_read(void *opaque, hwaddr
> addr, unsigned size)
>      EduState *edu =3D opaque;
>      uint64_t val =3D ~0ULL;
>
> -    if (size !=3D 4) {
> +    if (addr < 0x80 && size !=3D 4) {
> +        return val;
> +    }
> +
> +    if (addr >=3D 0x80 && size !=3D 4 && size !=3D 8) {
>          return val;
>      }
>
>

Yes, this is what I want. Thanks, will change to this in next revision.

Thanks,
Li Qiang



> ---
>
> Another cleaner way to solve this is use 2 MemoryRegionOps, one for the
> first 0x80 addresses and another for the rest.
>
> Regards,
>
> Phil.
>
