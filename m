Received: from eggs.gnu.org ([209.51.188.92]:53985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gvqkO-0000t9-7V
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:46:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gvqkH-0007LC-I9
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:46:41 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gvqkB-0007Js-Uj
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:46:34 -0500
Received: by mail-ot1-x344.google.com with SMTP id g1so30707344otj.11
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 13:46:30 -0800 (PST)
MIME-Version: 1.0
References: <20190218175529.11237-1-svens@stackframe.org>
	<20190218175529.11237-2-svens@stackframe.org>
	<861e47de-978b-b48c-d144-e50040d45bf4@redhat.com>
In-Reply-To: <861e47de-978b-b48c-d144-e50040d45bf4@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Feb 2019 21:46:18 +0000
Message-ID: <CAFEAcA9fO+ny5gz6BmO5caghvxQ4xZNDdtm0JxLm9mkpkokJ_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] lsi: use ldn_le_p()/stn_le_p()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Sven Schnelle <svens@stackframe.org>, QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>, deller@gmx.de

On Mon, 18 Feb 2019 at 21:41, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Hi Sven,
>
> On 2/18/19 6:55 PM, Sven Schnelle wrote:
> > Signed-off-by: Sven Schnelle <svens@stackframe.org>
> > ---
> >  hw/scsi/lsi53c895a.c | 19 ++-----------------
> >  1 file changed, 2 insertions(+), 17 deletions(-)
> >
> > diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> > index c493e3c4c7..93c4434bfb 100644
> > --- a/hw/scsi/lsi53c895a.c
> > +++ b/hw/scsi/lsi53c895a.c
> > @@ -2078,29 +2078,14 @@ static void lsi_ram_write(void *opaque, hwaddr =
addr,
> >                            uint64_t val, unsigned size)
> >  {
> >      LSIState *s =3D opaque;
> > -    uint32_t newval;
> > -    uint32_t mask;
> > -    int shift;
> > -
> > -    newval =3D s->script_ram[addr >> 2];
> > -    shift =3D (addr & 3) * 8;
> > -    mask =3D ((uint64_t)1 << (size * 8)) - 1;
> > -    newval &=3D ~(mask << shift);
> > -    newval |=3D val << shift;
> > -    s->script_ram[addr >> 2] =3D newval;
> > +    stn_le_p(((void*)s->script_ram) + addr, size, val);
>
> If you want to do pointer arithmetic, it is safer to cast to a uintptr_t.
> But since you update all the places that use script_ram[], it seems
> pointless to keep it as an array of uint32_t. We can simply convert it
> to an array of char.

Ah, yes -- when I suggested the cast on #qemu I hadn't
realized that these read and write functions were the
only places that access script_ram[] -- I'd assumed
that some code in the device model was going to read it to
execute whatever these scripts are.

thanks
-- PMM
