Received: from eggs.gnu.org ([2001:4830:134:3::10]:49011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1cbRac-0000Eo-8S
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 07:43:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1cbRaZ-0000qU-5m
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 07:43:14 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1cbRaY-0000qO-Ri
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 07:43:11 -0500
Received: by mail-wm0-x244.google.com with SMTP id r18so33116757wmd.3
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 04:43:10 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
From: Dmitry Fleytman <dmitry@daynix.com>
In-Reply-To: <CAKXe6SJzf5AMG2+9AW__oT7n549ufCZBrkpH6Q8XPdUiDGpufw@mail.gmail.com>
Date: Wed, 8 Feb 2017 14:43:06 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <FF08E4FC-A10A-4453-9939-35C33625C2EB@daynix.com>
References: <589996bb.02482e0a.10629.5b0e@mx.google.com>
	<809ED5C6-3D96-4D94-A7D3-5DCB9B2A4DED@daynix.com>
	<CAKXe6SKB2VpBsVmSPE5DnZiNduKvc=SJPsOobrwcrYqqDJbNeg@mail.gmail.com>
	<7DE30DA8-6CD0-4E51-8558-9DBD0279FDF6@daynix.com>
	<CAKXe6SJzf5AMG2+9AW__oT7n549ufCZBrkpH6Q8XPdUiDGpufw@mail.gmail.com>
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


> On 8 Feb 2017, at 12:17 PM, Li Qiang <liq3ea@gmail.com> wrote:
>=20
> Hello Dmitry,
>=20
>=20
> 2017-02-08 18:01 GMT+08:00 Dmitry Fleytman <dmitry@daynix.com>:
>=20
>> On 8 Feb 2017, at 11:30 AM, Li Qiang <liq3ea@gmail.com> wrote:
>>=20
>> Hello,=20
>>=20
>> 2017-02-08 16:38 GMT+08:00 Dmitry Fleytman <dmitry@daynix.com>:
>> Hello,
>>=20
>> Thanks for the patch!
>>=20
>> The problem of infinite loop indeed exists in e1000e, however it is =
different from the one fixed in e1000.
>> Please find my comments inline.
>>=20
>>=20
>> If I read the code correctly, I think this issue is the same. Could =
you please explain more? Thanks.
>=20
> I meant that code changes needed to fix it are slightly different.
>=20
> Got.
> =20
>=20
>> =20
>> ~Dmitry
>>=20
>> > On 7 Feb 2017, at 11:43 AM, Li Qiang <liq3ea@gmail.com> wrote:
>> >
>> > From: Li Qiang <liqiang6-s@360.cn>
>> >
>> > This issue is the same as e1000 network card in this commit:
>> > e1000: eliminate infinite loops on out-of-bounds transfer start.
>> >
>> > Signed-off-by: Li Qiang <liqiang6-s@360.cn>
>> > ---
>> > hw/net/e1000e_core.c | 17 ++++++++++++++++-
>> > 1 file changed, 16 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
>> > index 2b11499..53f2b1d 100644
>> > --- a/hw/net/e1000e_core.c
>> > +++ b/hw/net/e1000e_core.c
>> > @@ -914,7 +914,8 @@ e1000e_start_xmit(E1000ECore *core, const =
E1000E_TxRing *txr)
>> >     struct e1000_tx_desc desc;
>> >     bool ide =3D false;
>> >     const E1000E_RingInfo *txi =3D txr->i;
>> > -    uint32_t cause =3D E1000_ICS_TXQE;
>> > +    uint32_t tdh_start =3D core->mac[txi->dh], cause =3D =
E1000_ICS_TXQE;
>> > +
>> >
>> >     if (!(core->mac[TCTL] & E1000_TCTL_EN)) {
>> >         trace_e1000e_tx_disabled();
>> > @@ -933,6 +934,14 @@ e1000e_start_xmit(E1000ECore *core, const =
E1000E_TxRing *txr)
>> >         cause |=3D e1000e_txdesc_writeback(core, base, &desc, &ide, =
txi->idx);
>> >
>> >         e1000e_ring_advance(core, txi, 1);
>> > +
>> > +        /*
>> > +         * The following avoid infinite loop, just as the e1000
>> > +         */
>> > +        if (core->mac[txi->dh] =3D=3D tdh_start ||
>> > +            tdh_start >=3D core->mac[txi->dlen] / =
E1000_RING_DESC_LEN) {
>> > +            break;
>> > +            }
>>=20
>> Part of this validity check, namely
>> tdh_start >=3D core->mac[txi->dlen] / E1000_RING_DESC_LEN)
>> already done by e1000e_ring_advance(), therefore not needed here.
>>=20
>>=20
>> e1000e_ring_advance() check the added r->dh. Not the original one.
>=20
> Oh, I see now. Right, it does not make sense to check for wraparound =
in case original TDH was out of bounds.
>=20
> Now I see there is one more problem - in case TDH is out of the ring, =
e1000e_ring_head_descr()
> called from e1000e_start_xmit() will do out of bounds read, so TDH =
should be validated prior to
> reading the descriptor as well.
>=20
>=20
> IIUC you mean pci_dma_read will do oob read, right? I think this is =
not a issue as this is reading data from guest
> And guest can provide arbitrary data. For example, just provide 10 =
bytes buffer, but tell the qemu it has 1000.

Agree.

> =20
> Similar problem exists on RX also.
>=20
> Besides that, as I see now, e1000e_ring_empty() is not called on RX
> so validation should be done separately for TX and RX rings.
>=20
> A function like e1000e_ring_validate() is needed...
>=20
>> =20
>> The second part - full wraparound protection is relevant, but it =
fixes more symptoms than the cause.
>> The only possible cause for full wraparound is r->dt (tail) value =
bigger or equal to r->dlen (length),
>> so I would suggest to check for this in e1000e_ring_empty() and cover =
both TX and RX cases at once.
>>=20
>>=20
>> Do you mean 'core->mac[r->dt] >=3D core->mac[r->dlen]' indicate an =
empty ring?
>> =20
>=20
> So I still confused by this 'full wrapparound', any more explain?=20

Yes, I would indicate an empty ring when r->dt in invalid. That would do =
the job.

Having e1000e_ring_empty() fixed, you might call it from
e1000e_write_packet_to_guest() to fix RX issues as well.

> =20
>> >     }
>> >
>> >     if (!ide || !e1000e_intrmgr_delay_tx_causes(core, &cause)) {
>> > @@ -1500,6 +1509,7 @@ e1000e_write_packet_to_guest(E1000ECore =
*core, struct NetRxPkt *pkt,
>> >     size_t desc_size;
>> >     size_t desc_offset =3D 0;
>> >     size_t iov_ofs =3D 0;
>> > +    uint32_t rdh_start;
>> >
>> >     struct iovec *iov =3D net_rx_pkt_get_iovec(pkt);
>> >     size_t size =3D net_rx_pkt_get_total_len(pkt);
>> > @@ -1509,6 +1519,7 @@ e1000e_write_packet_to_guest(E1000ECore =
*core, struct NetRxPkt *pkt,
>> >     bool do_ps =3D e1000e_do_ps(core, pkt, &ps_hdr_len);
>> >
>> >     rxi =3D rxr->i;
>> > +    rdh_start =3D core->mac[rxi->dh];
>> >
>> >     do {
>> >         hwaddr ba[MAX_PS_BUFFERS];
>> > @@ -1605,6 +1616,10 @@ e1000e_write_packet_to_guest(E1000ECore =
*core, struct NetRxPkt *pkt,
>> >         e1000e_ring_advance(core, rxi,
>> >                             core->rx_desc_len / =
E1000_MIN_RX_DESC_LEN);
>> >
>> > +        if (core->mac[rxi->dh] =3D=3D rdh_start ||
>> > +            rdh_start >=3D core->mac[rxi->dlen] / =
E1000_RING_DESC_LEN) {
>> > +            break;
>> > +            }
>> >     } while (desc_offset < total_size);
>> >
>> >     e1000e_update_rx_stats(core, size, total_size);
>> > --
>> > 1.8.3.1
>> >
