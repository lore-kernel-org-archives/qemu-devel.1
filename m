Received: from eggs.gnu.org ([2001:4830:134:3::10]:58398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctsKt-0004s7-On
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 04:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctsKo-0000hD-UW
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 04:55:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ctsKo-0000g1-LV
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 04:55:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B98461B92
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 08:55:05 +0000 (UTC)
Date: Fri, 31 Mar 2017 09:54:59 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170331085459.GB2408@work-vm>
References: <20170330122354.GF2800@work-vm>
	<1490883039.28523.25.camel@redhat.com>
	<20170330174242.GM2800@work-vm>
	<1490939133.1877.3.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490939133.1877.3.camel@redhat.com>
Subject: Re: [Qemu-devel] xhci migration breakage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

* Gerd Hoffmann (kraxel@redhat.com) wrote:
>   Hi,
> 
> > dest:
> > (qemu) red_dispatcher_loadvm_commands: 
> > usb-storage msd post_load 0x7f45f510ee50 sig=0 tag=0
> > 
> > I added these as debug on the 'usb-storage' vmsd element; but
> > the signature/tag being 0 I assume they're not the culprit.
> 
> Yep, no inflight transfer, so highly unlikely (also note that ehci works
> fine according to bugzilla).
> 
> > #6  0x00007febabacae27 in xhci_kick_epctx (epctx=<optimized out>, xfer=<optimized out>, xhci=<optimized out>)
> >     at /root/1436616/qemu/hw/usb/hcd-xhci.c:2103 <- right at the end of xhci_submit
> > #7  0x00007febabacae27 in xhci_kick_epctx (epctx=<optimized out>, xfer=<optimized out>, xhci=<optimized out>)
> >     at /root/1436616/qemu/hw/usb/hcd-xhci.c:2112 right at end of xhci_fire_transfer
> > #8  0x00007febabacae27 in xhci_kick_epctx (epctx=0x7febaec395a0, streamid=0)
> >     at /root/1436616/qemu/hw/usb/hcd-xhci.c:2240
> 
> Recursive xhci_kick_epctx calls, not good.
> 
> Does the attached patch (not tested yet) make any difference?

Nope.

Source:
xhci_submit(slotid=1,epid=3)
xhci: setup packet pid 0x69 addr 1 ep 1
30724@1490950388.025424:usb_xhci_ep_kick slotid 1, epid 4, streamid 0
xhci: set epctx: 23fe22080 state=1 dequeue=0000000035460f41
30724@1490950388.025449:usb_xhci_xfer_start 0x7fbf642facc0: slotid 1, epid 4, streamid 0
xhci_submit(slotid=1,epid=4)
xhci: setup packet pid 0xe1 addr 1 ep 2
30724@1490950388.025649:usb_xhci_ep_kick slotid 1, epid 3, streamid 0
xhci: set epctx: 23fe22060 state=1 dequeue=000000003550e421
30724@1490950388.025674:usb_xhci_xfer_start 0x7fbf642facc0: slotid 1, epid 3, streamid 0
xhci_submit(slotid=1,epid=3)
xhci: setup packet pid 0x69 addr 1 ep 1
30724@1490950388.025790:usb_xhci_ep_kick slotid 1, epid 3, streamid 0
xhci: set epctx: 23fe22060 state=1 dequeue=000000003550e431
30724@1490950388.025807:usb_xhci_xfer_start 0x7fbf642facc0: slotid 1, epid 3, streamid 0
xhci_submit(slotid=1,epid=3)
xhci: setup packet pid 0x69 addr 1 ep 1
30724@1490950388.026700:usb_xhci_ep_kick slotid 1, epid 4, streamid 0
xhci: set epctx: 23fe22080 state=1 dequeue=0000000035460f51
30724@1490950388.026739:usb_xhci_xfer_start 0x7fbf680008f0: slotid 1, epid 4, streamid 0
xhci_submit(slotid=1,epid=4)
xhci: setup packet pid 0xe1 addr 1 ep 2
30724@1490950388.026910:usb_xhci_ep_kick slotid 1, epid 3, streamid 0
xhci: set epctx: 23fe22060 state=1 dequeue=000000003550e441
30724@1490950388.026936:usb_xhci_xfer_start 0x7fbf680008f0: slotid 1, epid 3, streamid 0
xhci_submit(slotid=1,epid=3)
xhci: setup packet pid 0x69 addr 1 ep 1

Dest:
QEMU 2.8.92 monitor - type 'help' for more information
(qemu) red_dispatcher_loadvm_commands: 
usb-storage msd post_load 0x7fbcde35def0 sig=0 tag=0
main_channel_link: add main channel client
main_channel_handle_parsed: net test: latency 210.332000 ms, bitrate 1656610 bps (1.579866 Mbps) LOW BANDWIDTH
red_dispatcher_set_cursor_peer: 
inputs_connect: inputs channel client create

(qemu) c
(qemu) 30736@1490950422.138659:usb_xhci_ep_kick slotid 1, epid 1, streamid 0
xhci: set epctx: 23fe22020 state=1 dequeue=0000000230c87231
30736@1490950422.138695:usb_xhci_xfer_start 0x7fbcdd8cdee0: slotid 1, epid 1, streamid 0
xhci: setup packet pid 0x69 addr 1 ep 0
30736@1490950422.138731:usb_xhci_ep_kick slotid 1, epid 3, streamid 0
xhci: set epctx: 23fe22060 state=1 dequeue=000000003550e441
30736@1490950422.138746:usb_xhci_xfer_start 0x7fbcddaf8f20: slotid 1, epid 3, streamid 0
xhci_submit(slotid=1,epid=3)
xhci: setup packet pid 0x69 addr 1 ep 1
xhci: set epctx: 23fe22060 state=2 dequeue=000000003550e441
30736@1490950422.138769:usb_xhci_ep_kick slotid 1, epid 4, streamid 0
xhci: set epctx: 23fe22080 state=1 dequeue=0000000035460f51
30736@1490950422.138781:usb_xhci_xfer_start 0x7fbcdd76aff0: slotid 1, epid 4, streamid 0
xhci_submit(slotid=1,epid=4)
xhci: setup packet pid 0xe1 addr 1 ep 2
qemu-system-x86_64: usb-msd: Bad signature 53425300

Dave

> cheers,
>   Gerd
> 

> From 1b10b10445ab438c3fa1107f9962add3ae0716c6 Mon Sep 17 00:00:00 2001
> From: Gerd Hoffmann <kraxel@redhat.com>
> Date: Fri, 31 Mar 2017 07:40:45 +0200
> Subject: [PATCH] xhci: set kick_active for retried xfers too
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/usb/hcd-xhci.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index f0af852..8958f95 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -2083,6 +2083,7 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
>          return;
>      }
>  
> +    epctx->kick_active++;
>      if (epctx->retry) {
>          XHCITransfer *xfer = epctx->retry;
>  
> @@ -2093,6 +2094,7 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
>              mfindex = xhci_mfindex_get(xhci);
>              xhci_check_intr_iso_kick(xhci, xfer, epctx, mfindex);
>              if (xfer->running_retry) {
> +                epctx->kick_active--;
>                  return;
>              }
>              xfer->timed_xfer = 0;
> @@ -2101,6 +2103,7 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
>          if (xfer->iso_xfer) {
>              /* retry iso transfer */
>              if (xhci_setup_packet(xfer) < 0) {
> +                epctx->kick_active--;
>                  return;
>              }
>              usb_handle_packet(xfer->packet.ep->dev, &xfer->packet);
> @@ -2109,10 +2112,12 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
>          } else {
>              /* retry nak'ed transfer */
>              if (xhci_setup_packet(xfer) < 0) {
> +                epctx->kick_active--;
>                  return;
>              }
>              usb_handle_packet(xfer->packet.ep->dev, &xfer->packet);
>              if (xfer->packet.status == USB_RET_NAK) {
> +                epctx->kick_active--;
>                  return;
>              }
>              xhci_try_complete_packet(xfer);
> @@ -2126,6 +2131,7 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
>  
>      if (epctx->state == EP_HALTED) {
>          DPRINTF("xhci: ep halted, not running schedule\n");
> +        epctx->kick_active--;
>          return;
>      }
>  
> @@ -2134,6 +2140,7 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
>          uint32_t err;
>          stctx = xhci_find_stream(epctx, streamid, &err);
>          if (stctx == NULL) {
> +            epctx->kick_active--;
>              return;
>          }
>          ring = &stctx->ring;
> @@ -2145,7 +2152,6 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
>      }
>      assert(ring->dequeue != 0);
>  
> -    epctx->kick_active++;
>      while (1) {
>          length = xhci_ring_chain_length(xhci, ring);
>          if (length <= 0) {
> -- 
> 1.8.3.1
> 

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
