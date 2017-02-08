Received: from eggs.gnu.org ([2001:4830:134:3::10]:45202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cbPK8-0001RW-Ba
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 05:18:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cbPK6-00030A-CD
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 05:18:04 -0500
Received: from mail-it0-x229.google.com ([2607:f8b0:4001:c0b::229]:37993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cbPK6-0002xy-5R
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 05:18:02 -0500
Received: by mail-it0-x229.google.com with SMTP id c7so99541524itd.1
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 02:18:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7DE30DA8-6CD0-4E51-8558-9DBD0279FDF6@daynix.com>
References: <589996bb.02482e0a.10629.5b0e@mx.google.com>
	<809ED5C6-3D96-4D94-A7D3-5DCB9B2A4DED@daynix.com>
	<CAKXe6SKB2VpBsVmSPE5DnZiNduKvc=SJPsOobrwcrYqqDJbNeg@mail.gmail.com>
	<7DE30DA8-6CD0-4E51-8558-9DBD0279FDF6@daynix.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 8 Feb 2017 18:17:59 +0800
Message-ID: <CAKXe6SJzf5AMG2+9AW__oT7n549ufCZBrkpH6Q8XPdUiDGpufw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] net: e1000e: fix an infinite loop issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dmitry Fleytman <dmitry@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Li Qiang <liqiang6-s@360.cn>

Hello Dmitry,


2017-02-08 18:01 GMT+08:00 Dmitry Fleytman <dmitry@daynix.com>:

>
> On 8 Feb 2017, at 11:30 AM, Li Qiang <liq3ea@gmail.com> wrote:
>
> Hello,
>
> 2017-02-08 16:38 GMT+08:00 Dmitry Fleytman <dmitry@daynix.com>:
>
>> Hello,
>>
>> Thanks for the patch!
>>
>> The problem of infinite loop indeed exists in e1000e, however it is
>> different from the one fixed in e1000.
>> Please find my comments inline.
>>
>>
> If I read the code correctly, I think this issue is the same. Could you
> please explain more? Thanks.
>
>
> I meant that code changes needed to fix it are slightly different.
>

Got.


>
>
>
>> ~Dmitry
>>
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
>> > @@ -914,7 +914,8 @@ e1000e_start_xmit(E1000ECore *core, const
>> E1000E_TxRing *txr)
>> >     struct e1000_tx_desc desc;
>> >     bool ide = false;
>> >     const E1000E_RingInfo *txi = txr->i;
>> > -    uint32_t cause = E1000_ICS_TXQE;
>> > +    uint32_t tdh_start = core->mac[txi->dh], cause = E1000_ICS_TXQE;
>> > +
>> >
>> >     if (!(core->mac[TCTL] & E1000_TCTL_EN)) {
>> >         trace_e1000e_tx_disabled();
>> > @@ -933,6 +934,14 @@ e1000e_start_xmit(E1000ECore *core, const
>> E1000E_TxRing *txr)
>> >         cause |= e1000e_txdesc_writeback(core, base, &desc, &ide,
>> txi->idx);
>> >
>> >         e1000e_ring_advance(core, txi, 1);
>> > +
>> > +        /*
>> > +         * The following avoid infinite loop, just as the e1000
>> > +         */
>> > +        if (core->mac[txi->dh] == tdh_start ||
>> > +            tdh_start >= core->mac[txi->dlen] / E1000_RING_DESC_LEN) {
>> > +            break;
>> > +            }
>>
>> Part of this validity check, namely
>> tdh_start >= core->mac[txi->dlen] / E1000_RING_DESC_LEN)
>> already done by e1000e_ring_advance(), therefore not needed here.
>>
>>
> e1000e_ring_advance() check the added r->dh. Not the original one.
>
>
> Oh, I see now. Right, it does not make sense to check for wraparound in
> case original TDH was out of bounds.
>
> Now I see there is one more problem - in case TDH is out of the
> ring, e1000e_ring_head_descr()
> called from e1000e_start_xmit() will do out of bounds read, so TDH should
> be validated prior to
> reading the descriptor as well.
>
>
IIUC you mean pci_dma_read will do oob read, right? I think this is not a
issue as this is reading data from guest
And guest can provide arbitrary data. For example, just provide 10 bytes
buffer, but tell the qemu it has 1000.


> Similar problem exists on RX also.
>
> Besides that, as I see now, e1000e_ring_empty() is not called on RX
> so validation should be done separately for TX and RX rings.
>
> A function like e1000e_ring_validate() is needed...
>
>
>
>> The second part - full wraparound protection is relevant, but it fixes
>> more symptoms than the cause.
>> The only possible cause for full wraparound is r->dt (tail) value bigger
>> or equal to r->dlen (length),
>> so I would suggest to check for this in e1000e_ring_empty() and cover
>> both TX and RX cases at once.
>>
>>
> Do you mean 'core->mac[r->dt] >= core->mac[r->dlen]' indicate an empty
> ring?
>
>
>
>
So I still confused by this 'full wrapparound', any more explain?


> >     }
>> >
>> >     if (!ide || !e1000e_intrmgr_delay_tx_causes(core, &cause)) {
>> > @@ -1500,6 +1509,7 @@ e1000e_write_packet_to_guest(E1000ECore *core,
>> struct NetRxPkt *pkt,
>> >     size_t desc_size;
>> >     size_t desc_offset = 0;
>> >     size_t iov_ofs = 0;
>> > +    uint32_t rdh_start;
>> >
>> >     struct iovec *iov = net_rx_pkt_get_iovec(pkt);
>> >     size_t size = net_rx_pkt_get_total_len(pkt);
>> > @@ -1509,6 +1519,7 @@ e1000e_write_packet_to_guest(E1000ECore *core,
>> struct NetRxPkt *pkt,
>> >     bool do_ps = e1000e_do_ps(core, pkt, &ps_hdr_len);
>> >
>> >     rxi = rxr->i;
>> > +    rdh_start = core->mac[rxi->dh];
>> >
>> >     do {
>> >         hwaddr ba[MAX_PS_BUFFERS];
>> > @@ -1605,6 +1616,10 @@ e1000e_write_packet_to_guest(E1000ECore *core,
>> struct NetRxPkt *pkt,
>> >         e1000e_ring_advance(core, rxi,
>> >                             core->rx_desc_len / E1000_MIN_RX_DESC_LEN);
>> >
>> > +        if (core->mac[rxi->dh] == rdh_start ||
>> > +            rdh_start >= core->mac[rxi->dlen] / E1000_RING_DESC_LEN) {
>> > +            break;
>> > +            }
>> >     } while (desc_offset < total_size);
>> >
>> >     e1000e_update_rx_stats(core, size, total_size);
>> > --
>> > 1.8.3.1
>> >
>>
>
>
