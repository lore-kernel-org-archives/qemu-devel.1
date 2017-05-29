Received: from eggs.gnu.org ([2001:4830:134:3::10]:51325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dFHgH-0008Ta-56
	for qemu-devel@nongnu.org; Mon, 29 May 2017 06:13:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dFHgD-0001um-TN
	for qemu-devel@nongnu.org; Mon, 29 May 2017 06:13:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dFHgD-0001ug-K4
	for qemu-devel@nongnu.org; Mon, 29 May 2017 06:13:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5FB783680C
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 10:13:40 +0000 (UTC)
Date: Mon, 29 May 2017 18:13:31 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170529101331.GA14845@pxdev.xzpeter.org>
References: <1494854073-19898-1-git-send-email-peterx@redhat.com>
	<20170529060813.GF22816@pxdev.xzpeter.org>
	<87k2506ltg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87k2506ltg.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH] msi: remove return code for msi_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On Mon, May 29, 2017 at 11:42:35AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, May 15, 2017 at 09:14:33PM +0800, Peter Xu wrote:
> >> MSI should be supported by all interrupt controllers. Switching the old
> >> check for msi_nonbroken into assertion. Do similar thing to
> >> pci_add_capability2() below that. Then time to remove *errp.
> >> 
> >> Since msi_init() won't fail now, touch up all the callers to avoid
> >> checks against it. One side effect is that we fixed a possible leak in
> >> current edu device.
> >> 
> >> Reported-by: Markus Armbruster <armbru@redhat.com>
> >> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> >> Signed-off-by: Peter Xu <peterx@redhat.com>
> >> ---
> >>  hw/audio/intel-hda.c               | 18 +-----------------
> >>  hw/i386/amd_iommu.c                |  2 +-
> >>  hw/ide/ich.c                       |  6 +-----
> >>  hw/misc/edu.c                      |  4 +---
> >>  hw/net/e1000e.c                    |  6 +-----
> >>  hw/net/trace-events                |  1 -
> >>  hw/net/vmxnet3.c                   |  8 ++------
> >>  hw/pci-bridge/ioh3420.c            | 17 ++++-------------
> >>  hw/pci-bridge/pci_bridge_dev.c     | 19 +------------------
> >>  hw/pci-bridge/xio3130_downstream.c | 11 +++--------
> >>  hw/pci-bridge/xio3130_upstream.c   | 11 +++--------
> >>  hw/pci/msi.c                       | 25 ++++++-------------------
> >>  hw/scsi/megasas.c                  | 18 +-----------------
> >>  hw/scsi/mptsas.c                   | 20 ++------------------
> >>  hw/scsi/trace-events               |  1 -
> >>  hw/scsi/vmw_pvscsi.c               | 12 +++---------
> >>  hw/usb/hcd-xhci.c                  | 16 +---------------
> >>  hw/vfio/pci.c                      | 13 ++-----------
> >>  include/hw/pci/msi.h               |  6 +++---
> >>  19 files changed, 36 insertions(+), 178 deletions(-)
> >
> > Ping?
> >
> > Just to mention in case missed - this is also a bug fix for edu
> > device.
> >
> > Also CC Markus since he's the reporter and I forgot to CC him in
> > previous post. Sorry.
> 
> The patch indeed fixes the leak in the edu device.  It might fix similar
> cleanup errors in other devices; I didn't check.
> 
> The interesting part is of course having devices assert the interrrupt
> controller isn't broken.  The commit message claims "MSI should be
> supported by all interrupt controllers".  Does that mean "you think it
> is supported", or does it mean "it really should be supported"?
> 
> If the former, shouldn't we drop @msi_nonbroken entirely?
> 
> If the latter, why is it okay to assert?
> 
> The Suggested-by makes me suspect this has been explained elsewhere
> already; feel free to send me just a pointer.

I cannot provide a pointer... It was a discussion on IRC.

For me, I cannot guarantee the latter is the truth. So I guess I am
the former case.

IIUC Paolo has the same suggestion there (remove msi_nonbroken
entirely), but the reason is slightly different - device MSI init
should not really depend on the irq controller at all. Or say, even
the irq controller does not have MSI supported, the device should also
be able to declare that capability, while the guest should just skip
that capability since the board/controller does not support MSI at
all.

However here I still added an assertion() and didn't really remove
msi_nonbroken intentionally, since I didn't know whether that'll be
safe enough. This patch kept that variable, and the assertion makes
sure that the behavior would be merely the same (from an
error_report() into an assertion though).

If we really want to totally remove that variable, I can repost a v2,
as long as no one on the list would disagree.

Paolo, please feel free to comment as well if I got anything wrong.

Thanks,

-- 
Peter Xu
