Received: from eggs.gnu.org ([2001:4830:134:3::10]:49048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1u3J-0003DQ-Ot
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 08:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1u3F-0004F9-L3
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 08:54:29 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:54235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1u3F-0004Eo-DV
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 08:54:25 -0400
Received: by mail-wm0-x235.google.com with SMTP id q132so5021414wmd.2
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 05:54:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170920201737.25723-4-f4bug@amsat.org>
References: <20170920201737.25723-1-f4bug@amsat.org>
	<20170920201737.25723-4-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Oct 2017 13:54:03 +0100
Message-ID: <CAFEAcA_wci=BT69jDM6uNa=JCM=b5GD4pO2vRQUNi6cX-B1QGA@mail.gmail.com>
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Subbaraya Sundeep <sundeep.lkml@gmail.com>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 20 September 2017 at 21:17, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
> From: Subbaraya Sundeep <sundeep.lkml@gmail.com>
>
> Modelled Microsemi's Smartfusion2 SPI controller.
>
> Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> +#define FRAMESZ_MASK         0x1F

> +static void set_fifodepth(MSSSpiState *s)
> +{
> +    unsigned int size =3D s->regs[R_SPI_DFSIZE] & FRAMESZ_MASK;
> +
> +    if (size <=3D 8) {
> +        s->fifo_depth =3D 32;
> +    } else if (size <=3D 16) {
> +        s->fifo_depth =3D 16;
> +    } else if (size <=3D 32) {
> +        s->fifo_depth =3D 8;
> +    } else {
> +        s->fifo_depth =3D 4;
> +    }
> +}

Hi. Coverity points out (CID 1381483) that the "else" case here
is dead code, because the FRAMESZ_MASK of 0x1F means that size
cannot be 32 or more.

Paolo kindly checked up with the spec at
https://www.eecs.umich.edu/courses/eecs373/readings/Actel_SmartFusion_MSS_U=
serGuide.pdf
which says that this register's field is bits [5:0] which
would imply an 0x3f mask is needed. On the other hand it also
says that "maximum value is 32", so what is the else clause
doing anyway?

thanks
-- PMM
