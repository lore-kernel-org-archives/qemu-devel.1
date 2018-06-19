Received: from eggs.gnu.org ([2001:4830:134:3::10]:53896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <saipava@xilinx.com>) id 1fVND5-0004xL-Fg
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 16:26:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <saipava@xilinx.com>) id 1fVND2-0008Ib-7c
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 16:26:39 -0400
Received: from mail-co1nam04on0607.outbound.protection.outlook.com
	([2a01:111:f400:fe4d::607]:8736
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <saipava@xilinx.com>) id 1fVND1-0008II-Sr
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 16:26:36 -0400
From: Sai Pavan Boddu <saipava@xilinx.com>
Date: Tue, 19 Jun 2018 20:26:29 +0000
Message-ID: <MWHPR02MB24788091B5359996B7F8FF41CA700@MWHPR02MB2478.namprd02.prod.outlook.com>
References: <1528954027-7938-1-git-send-email-saipava@xilinx.com>
	<20180614112506.b7fj2pcsay35gvqg@toto>
In-Reply-To: <20180614112506.b7fj2pcsay35gvqg@toto>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] xilinx_spips: Make dma transactions as per
 dma_burst_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Edgar Iglesias <edgari@xilinx.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Francisco Iglesias <frasse.iglesias@gmail.com>

Hi Edgar,

I got your suggestion below. Will be sending a V2 asap.

Thanks,
Sai Pavan

> -----Original Message-----
> From: Edgar E. Iglesias [mailto:edgar.iglesias@xilinx.com]
> Sent: Thursday, June 14, 2018 4:55 PM
> To: Sai Pavan Boddu <saipava@xilinx.com>
> Cc: qemu-devel@nongnu.org; Alistair Francis <alistair@alistair23.me>; Pet=
er
> Crosthwaite <crosthwaite.peter@gmail.com>; Peter Maydell
> <peter.maydell@linaro.org>; Francisco Iglesias <frasse.iglesias@gmail.com=
>
> Subject: Re: [PATCH] xilinx_spips: Make dma transactions as per dma_burst=
_size
>=20
> On Thu, Jun 14, 2018 at 10:57:04AM +0530, Sai Pavan Boddu wrote:
> > Qspi dma has a burst length of 64 bytes, So limit transaction length
> > to
> > 64 max.
>=20
> Hi Sai,
>=20
> Is this a v2 or a resend?
>=20
> >
> > Signed-off-by: Sai Pavan Boddu <saipava@xilinx.com>
> > ---
> >  hw/ssi/xilinx_spips.c         | 18 +++++++++++++++---
> >  include/hw/ssi/xilinx_spips.h |  3 ++-
> >  2 files changed, 17 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c index
> > 03f5fae..ea006c4 100644
> > --- a/hw/ssi/xilinx_spips.c
> > +++ b/hw/ssi/xilinx_spips.c
> > @@ -851,12 +851,17 @@ static void xlnx_zynqmp_qspips_notify(void
> *opaque)
> >      {
> >          size_t ret;
> >          uint32_t num;
> > -        const void *rxd =3D pop_buf(recv_fifo, 4, &num);
> > +        const void *rxd;
> > +        int len;
> > +
> > +        len =3D recv_fifo->num >=3D rq->dma_burst_size ? rq->dma_burst=
_size :
> > +                                                   recv_fifo->num;
> > +        rxd =3D pop_buf(recv_fifo, len, &num);
> >
> >          memcpy(rq->dma_buf, rxd, num);
> >
> > -        ret =3D stream_push(rq->dma, rq->dma_buf, 4);
> > -        assert(ret =3D=3D 4);
> > +        ret =3D stream_push(rq->dma, rq->dma_buf, num);
> > +        assert(ret =3D=3D num);
> >          xlnx_zynqmp_qspips_check_flush(rq);
> >      }
> >  }
> > @@ -1337,6 +1342,7 @@ static void xlnx_zynqmp_qspips_realize(DeviceStat=
e
> *dev, Error **errp)
> >      fifo8_create(&s->rx_fifo_g, xsc->rx_fifo_size);
> >      fifo8_create(&s->tx_fifo_g, xsc->tx_fifo_size);
> >      fifo32_create(&s->fifo_g, 32);
> > +    s->dma_buf =3D g_new0(uint8_t, s->dma_burst_size);
>=20
>=20
> This would need to be free'd somewhere.
> But I think you should put a reasonably small limit on the burst size tha=
t users
> can configure and then you can allocate this as an array in XlnxZynqMPQSP=
IPS.
>=20
>=20
>=20
> >  }
> >
> >  static void xlnx_zynqmp_qspips_init(Object *obj) @@ -1411,6 +1417,11
> > @@ static const VMStateDescription vmstate_xlnx_zynqmp_qspips =3D {
> >      }
> >  };
> >
> > +static Property xilinx_zynqmp_qspips_properties[] =3D {
> > +    DEFINE_PROP_UINT32("dma-burst-size", XlnxZynqMPQSPIPS,
> > +dma_burst_size, 64),
>=20
> You need to limit this so users dont pick 4G. Perhaps 2 or 4K max.
>=20
> Cheers,
> Edgar
>=20
>=20
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> >  static Property xilinx_qspips_properties[] =3D {
> >      /* We had to turn this off for 2.10 as it is not compatible with m=
igration.
> >       * It can be enabled but will prevent the device to be migrated.
> > @@ -1463,6 +1474,7 @@ static void
> xlnx_zynqmp_qspips_class_init(ObjectClass *klass, void * data)
> >      dc->realize =3D xlnx_zynqmp_qspips_realize;
> >      dc->reset =3D xlnx_zynqmp_qspips_reset;
> >      dc->vmsd =3D &vmstate_xlnx_zynqmp_qspips;
> > +    dc->props =3D xilinx_zynqmp_qspips_properties;
> >      xsc->reg_ops =3D &xlnx_zynqmp_qspips_ops;
> >      xsc->rx_fifo_size =3D RXFF_A_Q;
> >      xsc->tx_fifo_size =3D TXFF_A_Q;
> > diff --git a/include/hw/ssi/xilinx_spips.h
> > b/include/hw/ssi/xilinx_spips.h index d398a4e..cca1813 100644
> > --- a/include/hw/ssi/xilinx_spips.h
> > +++ b/include/hw/ssi/xilinx_spips.h
> > @@ -95,7 +95,8 @@ typedef struct {
> >      XilinxQSPIPS parent_obj;
> >
> >      StreamSlave *dma;
> > -    uint8_t dma_buf[4];
> > +    uint8_t *dma_buf;
> > +    uint32_t dma_burst_size;
> >      int gqspi_irqline;
> >
> >      uint32_t regs[XLNX_ZYNQMP_SPIPS_R_MAX];
> > --
> > 2.7.4
> >
