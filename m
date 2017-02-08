Received: from eggs.gnu.org ([2001:4830:134:3::10]:50309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1cbNls-0005tp-57
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 03:38:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1cbNlp-0003jQ-1n
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 03:38:36 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1cbNlo-0003jL-Qm
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 03:38:32 -0500
Received: by mail-wr0-x242.google.com with SMTP id i10so8037107wrb.0
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 00:38:31 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
From: Dmitry Fleytman <dmitry@daynix.com>
In-Reply-To: <589996bb.02482e0a.10629.5b0e@mx.google.com>
Date: Wed, 8 Feb 2017 10:38:30 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <809ED5C6-3D96-4D94-A7D3-5DCB9B2A4DED@daynix.com>
References: <589996bb.02482e0a.10629.5b0e@mx.google.com>
Subject: Re: [Qemu-devel] [PATCH] net: e1000e: fix an infinite loop issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Li Qiang <liqiang6-s@360.cn>

Hello,

Thanks for the patch!

The problem of infinite loop indeed exists in e1000e, however it is =
different from the one fixed in e1000.
Please find my comments inline.

~Dmitry

> On 7 Feb 2017, at 11:43 AM, Li Qiang <liq3ea@gmail.com> wrote:
>=20
> From: Li Qiang <liqiang6-s@360.cn>
>=20
> This issue is the same as e1000 network card in this commit:
> e1000: eliminate infinite loops on out-of-bounds transfer start.
>=20
> Signed-off-by: Li Qiang <liqiang6-s@360.cn>
> ---
> hw/net/e1000e_core.c | 17 ++++++++++++++++-
> 1 file changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index 2b11499..53f2b1d 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -914,7 +914,8 @@ e1000e_start_xmit(E1000ECore *core, const =
E1000E_TxRing *txr)
>     struct e1000_tx_desc desc;
>     bool ide =3D false;
>     const E1000E_RingInfo *txi =3D txr->i;
> -    uint32_t cause =3D E1000_ICS_TXQE;
> +    uint32_t tdh_start =3D core->mac[txi->dh], cause =3D =
E1000_ICS_TXQE;
> +
>=20
>     if (!(core->mac[TCTL] & E1000_TCTL_EN)) {
>         trace_e1000e_tx_disabled();
> @@ -933,6 +934,14 @@ e1000e_start_xmit(E1000ECore *core, const =
E1000E_TxRing *txr)
>         cause |=3D e1000e_txdesc_writeback(core, base, &desc, &ide, =
txi->idx);
>=20
>         e1000e_ring_advance(core, txi, 1);
> +
> +        /*
> +         * The following avoid infinite loop, just as the e1000
> +         */
> +        if (core->mac[txi->dh] =3D=3D tdh_start ||
> +            tdh_start >=3D core->mac[txi->dlen] / =
E1000_RING_DESC_LEN) {
> +            break;
> +            }

Part of this validity check, namely
tdh_start >=3D core->mac[txi->dlen] / E1000_RING_DESC_LEN)
already done by e1000e_ring_advance(), therefore not needed here.

The second part - full wraparound protection is relevant, but it fixes =
more symptoms than the cause.
The only possible cause for full wraparound is r->dt (tail) value bigger =
or equal to r->dlen (length),
so I would suggest to check for this in e1000e_ring_empty() and cover =
both TX and RX cases at once.

>     }
>=20
>     if (!ide || !e1000e_intrmgr_delay_tx_causes(core, &cause)) {
> @@ -1500,6 +1509,7 @@ e1000e_write_packet_to_guest(E1000ECore *core, =
struct NetRxPkt *pkt,
>     size_t desc_size;
>     size_t desc_offset =3D 0;
>     size_t iov_ofs =3D 0;
> +    uint32_t rdh_start;
>=20
>     struct iovec *iov =3D net_rx_pkt_get_iovec(pkt);
>     size_t size =3D net_rx_pkt_get_total_len(pkt);
> @@ -1509,6 +1519,7 @@ e1000e_write_packet_to_guest(E1000ECore *core, =
struct NetRxPkt *pkt,
>     bool do_ps =3D e1000e_do_ps(core, pkt, &ps_hdr_len);
>=20
>     rxi =3D rxr->i;
> +    rdh_start =3D core->mac[rxi->dh];
>=20
>     do {
>         hwaddr ba[MAX_PS_BUFFERS];
> @@ -1605,6 +1616,10 @@ e1000e_write_packet_to_guest(E1000ECore *core, =
struct NetRxPkt *pkt,
>         e1000e_ring_advance(core, rxi,
>                             core->rx_desc_len / =
E1000_MIN_RX_DESC_LEN);
>=20
> +        if (core->mac[rxi->dh] =3D=3D rdh_start ||
> +            rdh_start >=3D core->mac[rxi->dlen] / =
E1000_RING_DESC_LEN) {
> +            break;
> +            }
>     } while (desc_offset < total_size);
>=20
>     e1000e_update_rx_stats(core, size, total_size);
> --=20
> 1.8.3.1
>=20
