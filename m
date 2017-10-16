Received: from eggs.gnu.org ([2001:4830:134:3::10]:56304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1e41wD-0005xo-TX
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:43:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1e41wC-0001I7-Go
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:43:57 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_wci=BT69jDM6uNa=JCM=b5GD4pO2vRQUNi6cX-B1QGA@mail.gmail.com>
References: <20170920201737.25723-1-f4bug@amsat.org>
	<20170920201737.25723-4-f4bug@amsat.org>
	<CAFEAcA_wci=BT69jDM6uNa=JCM=b5GD4pO2vRQUNi6cX-B1QGA@mail.gmail.com>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Mon, 16 Oct 2017 15:13:53 +0530
Message-ID: <CALHRZuoc9ddSfcwSK+4Le+k8DP6B5nhBfbKuVK_D-hNXcmFzNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 3/5] msf2: Add Smartfusion2 SPI
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi Peter,

On Tue, Oct 10, 2017 at 6:24 PM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 20 September 2017 at 21:17, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
> wrote:
> > From: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> >
> > Modelled Microsemi's Smartfusion2 SPI controller.
> >
> > Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> > Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
> > Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> > +#define FRAMESZ_MASK         0x1F
>
> > +static void set_fifodepth(MSSSpiState *s)
> > +{
> > +    unsigned int size =3D s->regs[R_SPI_DFSIZE] & FRAMESZ_MASK;
> > +
> > +    if (size <=3D 8) {
> > +        s->fifo_depth =3D 32;
> > +    } else if (size <=3D 16) {
> > +        s->fifo_depth =3D 16;
> > +    } else if (size <=3D 32) {
> > +        s->fifo_depth =3D 8;
> > +    } else {
> > +        s->fifo_depth =3D 4;
> > +    }
> > +}
>
> Hi. Coverity points out (CID 1381483) that the "else" case here
> is dead code, because the FRAMESZ_MASK of 0x1F means that size
> cannot be 32 or more.
>
> Paolo kindly checked up with the spec at
> https://www.eecs.umich.edu/courses/eecs373/readings/Actel_SmartFusion_MSS=
_
> UserGuide.pdf
> which says that this register's field is bits [5:0] which
> would imply an 0x3f mask is needed. On the other hand it also
> says that "maximum value is 32", so what is the else clause
> doing anyway?
>

I will remove the else, change mask to 0x3F and add check for max 32 in
spi_write:
  case R_SPI_DFSIZE:
        if (s->enabled || (value &  FRAMESZ_MASK) > 32) {
            break;
        }
        s->regs[R_SPI_DFSIZE] =3D value;
        break;

Thanks for pointing out.
Sundeep


>
> thanks
> -- PMM
>
