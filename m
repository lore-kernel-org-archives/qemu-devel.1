Received: from eggs.gnu.org ([2001:4830:134:3::10]:37346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1e7uRK-0000Pe-P8
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 22:32:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1e7uRF-0007Mn-S8
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 22:32:06 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:51866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1e7uRF-0007Ly-Lw
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 22:32:01 -0400
Received: by mail-pg0-x242.google.com with SMTP id p9so4163982pgc.8
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 19:32:01 -0700 (PDT)
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Thu, 26 Oct 2017 19:31:33 -0700
Message-Id: <1509071493-82242-1-git-send-email-eswierk@skyportsystems.com>
In-Reply-To: <5e031fcf-9f97-7d32-2e41-6868f75d284b@redhat.com>
References: <5e031fcf-9f97-7d32-2e41-6868f75d284b@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2] e1000: Faulty tx checksum offload
 corrupts packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Ed Swierk <eswierk@skyportsystems.com>, Dmitry Fleytman <dmitry@daynix.com>, qemu-devel@nongnu.org

On Mon, Oct 23, 2017 at 8:28 PM, Jason Wang <jasowang@redhat.com> wrote:
> 
> On 2017年10月24日 08:22, Ed Swierk wrote:
> > (Another layer of icing on the cake is that QEMU ignores the
> > requirement that a UDP checksum computed as zero be sent as 0xffff,
> > since zero is a special value meaning no checksum. So even when QEMU
> > doesn't corrupt the packet data, the packet sometimes leaves the box
> > with no checksum at all.)
> 
> Please submit another patch for this.

Will do.

> > I have instrumented QEMU and reproduced this behavior with a Windows
> > 10 guest, rather easily with a TCP iperf and a UDP iperf running in
> > parallel. I have also attempted a fix, which is below in very rough
> > form.
> 
> How do you instrument qemu? Can this be reproduced without this?

I can reproduce the bug with just the patchlet below. It would be even
better to devise a test that detects the corruption without modifying
QEMU, as that could be used as a regression test after the bug itself
is fixed. I'll have to ponder that.

> > One puzzle is what to do about e1000e: it shares shares some data
> > structures and a bit of code with e1000, but little else, which is
> > surprising given how similar they are (or should be). The e1000e's
> > handling of TCP segmentation offload and checksum offload is totally
> > different, and problematic for other reasons (it totally ignores most
> > of the context parameters provided by the driver and basically does
> > what it thinks is best by digging into the packet data). Is this
> > divergence intentional?
> 
> Somehow, and if we can find a way to unify the codes, it would be better.
> 
> > Is there a reason not to change e1000e as long
> > as I'm trying to make e1000 more datasheet-conformant?
> 
> Please fix them individually.

I went ahead and reimplemented e1000 as a variant of e1000e. It's just
a proof of concept, but hopefully a step towards eliminating the
redundancy and manintaining just one codebase rather than two. Please
see the patch series I'm sending separately.

Anyway, here's how I catch the tx checksum offload bug, with a Windows
guest running one TCP iperf and one UDP iperf simultaneously through
the same e1000 interface.

 --- a/hw/net/e1000.c
 +++ b/hw/net/e1000.c
 @@ -534,6 +534,30 @@ e1000_send_packet(E1000State *s, const uint8_t *buf, int size)
  }
  
  static void
 +debug_csum(struct e1000_tx *tp, uint16_t oldsum)
 +{
 +    e1000x_txd_props *props = &tp->props;
 +    uint8_t proto = tp->data[14 + 9];
 +    uint32_t sumoff = props->tucso - props->tucss;
 +
 +    if ((proto == 17 && sumoff != 6) ||
 +        (proto == 6 && sumoff != 16)) {
 +        DBGOUT(TXERR, "txsum bug! ver %d src %08x dst %08x len %d proto %d "
 +               "cptse %d sum_needed %x oldsum %x newsum %x realsum %x\n",
 +               tp->data[14] >> 4,
 +               ldl_be_p(tp->data + 14 + 12),
 +               ldl_be_p(tp->data + 14 + 16),
 +               lduw_be_p(tp->data + 14 + 2),
 +               proto,
 +               props->cptse,
 +               props->sum_needed,
 +               oldsum,
 +               lduw_be_p(tp->data + props->tucso),
 +               lduw_be_p(tp->data + props->tucss + (proto == 6 ? 16 : 6)));
 +    }
 +}
 +
 +static void
  xmit_seg(E1000State *s)
  {
      uint16_t len;
 @@ -577,8 +601,10 @@ xmit_seg(E1000State *s)
      }
  
      if (tp->props.sum_needed & E1000_TXD_POPTS_TXSM) {
 +        uint16_t oldsum = lduw_be_p(tp->data + tp->props.tucso);
          putsum(tp->data, tp->size, tp->props.tucso,
                 tp->props.tucss, tp->props.tucse);
 +        debug_csum(tp, oldsum);
      }
      if (tp->props.sum_needed & E1000_TXD_POPTS_IXSM) {
          putsum(tp->data, tp->size, tp->props.ipcso,
 
