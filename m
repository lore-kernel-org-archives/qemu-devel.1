Received: from eggs.gnu.org ([2001:4830:134:3::10]:60464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dvIMo-0007jf-1T
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dvIMm-00058B-Sk
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:27:18 -0400
References: <20170918195100.17593-1-andrew.smirnov@gmail.com>
	<20170918195100.17593-5-andrew.smirnov@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <dbc5a135-10d5-e332-94b3-4e59596f1d76@redhat.com>
Date: Fri, 22 Sep 2017 15:27:05 +0800
MIME-Version: 1.0
In-Reply-To: <20170918195100.17593-5-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/17] imx_fec: Change queue flushing
 heuristics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, yurovsky@gmail.com



On 2017=E5=B9=B409=E6=9C=8819=E6=97=A5 03:50, Andrey Smirnov wrote:
> In current implementation, packet queue flushing logic seem to suffer
> from a deadlock like scenario if a packet is received by the interface
> before before Rx ring is initialized by Guest's driver. Consider the
> following sequence of events:
>
> 	1. A QEMU instance is started against a TAP device on Linux
> 	   host, running Linux guest, e. g., something to the effect
> 	   of:
>
> 	   qemu-system-arm \
> 	      -net nic,model=3Dimx.fec,netdev=3Dlan0 \
> 	      netdev tap,id=3Dlan0,ifname=3Dtap0,script=3Dno,downscript=3Dno \
> 	      ... rest of the arguments ...
>
> 	2. Once QEMU starts, but before guest reaches the point where
> 	   FEC deriver is done initializing the HW, Guest, via TAP
> 	   interface, receives a number of multicast MDNS packets from
> 	   Host (not necessarily true for every OS, but it happens at
> 	   least on Fedora 25)
>
> 	3. Recieving a packet in such a state results in
> 	   imx_eth_can_receive() returning '0', which in turn causes
> 	   tap_send() to disable corresponding event (tap.c:203)
>
> 	4. Once Guest's driver reaches the point where it is ready to
> 	   recieve packets it prepares Rx ring descriptors and writes
> 	   ENET_RDAR_RDAR to ENET_RDAR register to indicate to HW that
> 	   more descriptors are ready. And at this points emulation
> 	   layer does this:
>
> 	   	 s->regs[index] =3D ENET_RDAR_RDAR;
>                   imx_eth_enable_rx(s);
>
> 	   which, combined with:
>
> 	   	  if (!s->regs[ENET_RDAR]) {
> 		     qemu_flush_queued_packets(qemu_get_queue(s->nic));
> 		  }

Not familiar with FEC, but if you are tracking 0->1 transition, why not=20
simply introduce a parameter of imx_eth_enable_rx() to force the flushing=
?

Thanks

>
> 	   results in Rx queue never being flushed and corresponding
> 	   I/O event beign disabled.
>
> Change the code to remember the fact that can_receive callback was
> called before Rx ring was ready and use it to make a decision if
> receive queue needs to be flushed.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>   hw/net/imx_fec.c         | 6 ++++--
>   include/hw/net/imx_fec.h | 1 +
>   2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
> index 84085afe09..767402909d 100644
> --- a/hw/net/imx_fec.c
> +++ b/hw/net/imx_fec.c
> @@ -544,8 +544,9 @@ static void imx_eth_enable_rx(IMXFECState *s)
>  =20
>       if (rx_ring_full) {
>           FEC_PRINTF("RX buffer full\n");
> -    } else if (!s->regs[ENET_RDAR]) {
> +    } else if (s->needs_flush) {
>           qemu_flush_queued_packets(qemu_get_queue(s->nic));
> +        s->needs_flush =3D false;
>       }
>  =20
>       s->regs[ENET_RDAR] =3D rx_ring_full ? 0 : ENET_RDAR_RDAR;
> @@ -930,7 +931,8 @@ static int imx_eth_can_receive(NetClientState *nc)
>  =20
>       FEC_PRINTF("\n");
>  =20
> -    return s->regs[ENET_RDAR] ? 1 : 0;
> +    s->needs_flush =3D !s->regs[ENET_RDAR];
> +    return !!s->regs[ENET_RDAR];
>   }
>  =20
>   static ssize_t imx_fec_receive(NetClientState *nc, const uint8_t *buf=
,
> diff --git a/include/hw/net/imx_fec.h b/include/hw/net/imx_fec.h
> index 62ad473b05..4bc8f03ec2 100644
> --- a/include/hw/net/imx_fec.h
> +++ b/include/hw/net/imx_fec.h
> @@ -252,6 +252,7 @@ typedef struct IMXFECState {
>       uint32_t phy_int_mask;
>  =20
>       bool is_fec;
> +    bool needs_flush;
>   } IMXFECState;
>  =20
>   #endif
