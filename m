Received: from eggs.gnu.org ([2001:4830:134:3::10]:43584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1cbqLo-0001YN-CL
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 10:09:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1cbqLj-00063b-Ux
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 10:09:36 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1cbqLj-000614-NI
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 10:09:31 -0500
Received: by mail-wm0-x241.google.com with SMTP id r18so3314724wmd.3
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 07:09:28 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
From: Dmitry Fleytman <dmitry@daynix.com>
In-Reply-To: <589bcff4.856d240a.3dcfb.a4be@mx.google.com>
Date: Thu, 9 Feb 2017 17:09:25 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <407C713B-365E-4D96-91BE-3B932EB05450@daynix.com>
References: <589bcff4.856d240a.3dcfb.a4be@mx.google.com>
Subject: Re: [Qemu-devel] [PATCH v2] net: e1000e: fix an infinite loop issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, Li Qiang <liqiang6-s@360.cn>


> On 9 Feb 2017, at 04:11 AM, Li Qiang <liq3ea@gmail.com> wrote:
>=20
> From: Li Qiang <liqiang6-s@360.cn>
>=20
> This issue is like the issue in e1000 network card addressed in
> this commit:
> e1000: eliminate infinite loops on out-of-bounds transfer start.

Hi,

Please see my comments below.

>=20
> Signed-off-by: Li Qiang <liqiang6-s@360.cn>
> ---
>=20
> Changes since v1:
> make wraparound detect in e1000e_ring_empty
>=20
> hw/net/e1000e_core.c | 23 +++++++++++++++++++++--
> 1 file changed, 21 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index 2b11499..d4c56c3 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -806,7 +806,8 @@ typedef struct E1000E_RingInfo_st {
> static inline bool
> e1000e_ring_empty(E1000ECore *core, const E1000E_RingInfo *r)
> {
> -    return core->mac[r->dh] =3D=3D core->mac[r->dt];
> +    return core->mac[r->dh] =3D=3D core->mac[r->dt] ||
> +                core->mac[r->dt] >=3D core->mac[r->dlen];

Here r->dt is index while r->dlen is length in bytes,
so r->dlen should be divided by E1000_RING_DESC_LEN

The same way as you do below while checking for wrap around.

> }
>=20
> static inline uint64_t
> @@ -914,7 +915,7 @@ e1000e_start_xmit(E1000ECore *core, const =
E1000E_TxRing *txr)
>     struct e1000_tx_desc desc;
>     bool ide =3D false;
>     const E1000E_RingInfo *txi =3D txr->i;
> -    uint32_t cause =3D E1000_ICS_TXQE;
> +    uint32_t tdh_start =3D core->mac[txi->dh], cause =3D =
E1000_ICS_TXQE;
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

IIUC infinite loop protection already implemented by your changes for =
e1000e_ring_empty()

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
> @@ -1522,6 +1533,10 @@ e1000e_write_packet_to_guest(E1000ECore *core, =
struct NetRxPkt *pkt,
>             desc_size =3D core->rx_desc_buf_size;
>         }
>=20
> +        if (e1000e_ring_empty(core, rxi)) {
> +            return;
> +        }
> +
>         base =3D e1000e_ring_head_descr(core, rxi);
>=20
>         pci_dma_read(d, base, &desc, core->rx_desc_len);
> @@ -1605,6 +1620,10 @@ e1000e_write_packet_to_guest(E1000ECore *core, =
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


IIUC, infinite loop protection here is covered by newly introduced call =
to e1000e_ring_empty().

~Dmitry

>     } while (desc_offset < total_size);
>=20
>     e1000e_update_rx_stats(core, size, total_size);
> --=20
> 1.8.3.1
>=20
