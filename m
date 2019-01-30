Received: from eggs.gnu.org ([209.51.188.92]:56963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry.fleytman@janustech.com>) id 1golLq-0002Qj-L1
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 03:36:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry.fleytman@janustech.com>) id 1golLo-0006lE-Pb
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 03:36:06 -0500
Received: from mail-dm3nam05on072a.outbound.protection.outlook.com
	([2a01:111:f400:fe51::72a]:62202
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dmitry.fleytman@janustech.com>)
	id 1golLo-0006km-5m
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 03:36:04 -0500
From: Dmitry Fleytman <dmitry.fleytman@janustech.com>
Date: Wed, 30 Jan 2019 08:35:58 +0000
Message-ID: <30B18A05-8414-4047-BBAB-DA584B2BE518@janustech.com>
References: <20190128200444.5128-1-yuri.benditovich@janustech.com>
	<20190128200444.5128-3-yuri.benditovich@janustech.com>
In-Reply-To: <20190128200444.5128-3-yuri.benditovich@janustech.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0AE36BEE9090124DB845FB1EA4696691@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/2] usb: implement XHCI underrun/overrun
 events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuri Benditovich <yuri.benditovich@janustech.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



> On 28 Jan 2019, at 22:05, Yuri Benditovich <yuri.benditovich@janustech.co=
m> wrote:
>=20
> Implement underrun/overrun events of isochronous endpoints
> according to XHCI spec (4.10.3.1)
> Guest software restarts data streaming when receives these events.
> The XHCI reports these events using interrupter assigned
> to the slot (as these events do not have TRB), so current
> commit adds the field of assigned interrupter to the
> XHCISlot structure. Guest software assigns interrupter to the
> slot on 'Address Device' and 'Evaluate Context' commands.
>=20
> Signed-off-by: Yuri Benditovich <yuri.benditovich@janustech.com>

Reviewed-by: Dmitry Fleytman <dmitry.fleytman@janustech.com>

> ---
> hw/usb/hcd-xhci.c | 17 +++++++++++++++--
> hw/usb/hcd-xhci.h |  1 +
> 2 files changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index 1a8fd96..19c64f7 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -1949,6 +1949,16 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, =
unsigned int streamid)
>     while (1) {
>         length =3D xhci_ring_chain_length(xhci, ring);
>         if (length <=3D 0) {
> +            if (epctx->type =3D=3D ET_ISO_OUT || epctx->type =3D=3D ET_I=
SO_IN) {
> +                /* 4.10.3.1 */
> +                XHCIEvent ev =3D { ER_TRANSFER };
> +                ev.ccode  =3D epctx->type =3D=3D ET_ISO_IN ?
> +                    CC_RING_OVERRUN : CC_RING_UNDERRUN;
> +                ev.slotid =3D epctx->slotid;
> +                ev.epid   =3D epctx->epid;
> +                ev.ptr    =3D epctx->ring.dequeue;
> +                xhci_event(xhci, &ev, xhci->slots[epctx->slotid-1].intr)=
;
> +            }
>             break;
>         }
>         xfer =3D xhci_ep_alloc_xfer(epctx, length);
> @@ -2028,6 +2038,7 @@ static TRBCCode xhci_disable_slot(XHCIState *xhci, =
unsigned int slotid)
>     xhci->slots[slotid-1].enabled =3D 0;
>     xhci->slots[slotid-1].addressed =3D 0;
>     xhci->slots[slotid-1].uport =3D NULL;
> +    xhci->slots[slotid-1].intr =3D 0;
>     return CC_SUCCESS;
> }
>=20
> @@ -2127,6 +2138,7 @@ static TRBCCode xhci_address_slot(XHCIState *xhci, =
unsigned int slotid,
>     slot =3D &xhci->slots[slotid-1];
>     slot->uport =3D uport;
>     slot->ctx =3D octx;
> +    slot->intr =3D get_field(slot_ctx[2], TRB_INTR);
>=20
>     /* Make sure device is in USB_STATE_DEFAULT state */
>     usb_device_reset(dev);
> @@ -2300,8 +2312,9 @@ static TRBCCode xhci_evaluate_slot(XHCIState *xhci,=
 unsigned int slotid,
>=20
>         slot_ctx[1] &=3D ~0xFFFF; /* max exit latency */
>         slot_ctx[1] |=3D islot_ctx[1] & 0xFFFF;
> -        slot_ctx[2] &=3D ~0xFF00000; /* interrupter target */
> -        slot_ctx[2] |=3D islot_ctx[2] & 0xFF000000;
> +        /* update interrupter target field */
> +        xhci->slots[slotid-1].intr =3D get_field(islot_ctx[2], TRB_INTR)=
;
> +        set_field(&slot_ctx[2], xhci->slots[slotid-1].intr, TRB_INTR);
>=20
>         DPRINTF("xhci: output slot context: %08x %08x %08x %08x\n",
>                 slot_ctx[0], slot_ctx[1], slot_ctx[2], slot_ctx[3]);
> diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
> index fc36a4c..240caa4 100644
> --- a/hw/usb/hcd-xhci.h
> +++ b/hw/usb/hcd-xhci.h
> @@ -140,6 +140,7 @@ typedef struct XHCIPort {
> typedef struct XHCISlot {
>     bool enabled;
>     bool addressed;
> +    uint16_t intr;
>     dma_addr_t ctx;
>     USBPort *uport;
>     XHCIEPContext *eps[31];
> --=20
> 2.9.5
>=20
