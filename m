Received: from eggs.gnu.org ([2001:4830:134:3::10]:44885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctZ7X-0001zD-3S
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 08:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctZ7S-0006pZ-6o
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 08:24:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ctZ7S-0006p5-0n
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 08:24:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F0FFF61BB0
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 12:24:00 +0000 (UTC)
Date: Thu, 30 Mar 2017 13:23:54 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170330122354.GF2800@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] xhci migration breakage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com
Cc: qemu-devel@nongnu.org

Hi Gerd,
  2.9 seems to have an xhci migration breakage, I've bisected it
down to:
commit ddb603ab6c981c1d67cb42266fc700c33e5b2d8f
Author: Gerd Hoffmann <kraxel@redhat.com>
Date:   Mon Jan 30 16:36:46 2017 +0100

    xhci: don't kick in xhci_submit and xhci_fire_ctl_transfer

I guess maybe there's a kick needed pre/post migrate?

(it's https://bugzilla.redhat.com/show_bug.cgi?id=1436616 )

The symptoms on the destination are that the qemu prints:

qemu-kvm: usb-msd: Bad signature 53425300

and the guest sees:
  xhci_hcd 0000:00:06.0: WARN Event TRB for slot 1 ep 0 with no TDs queued?
  xhci_hcd 0000:00:06.0: WARN Event TRB for slot 1 ep 2 with no TDs queued?
  xhci_hcd 0000:00:06.0: WARN Event TRB for slot 1 ep 3 with no TDs queued?

and never gets any more IO on the USB disk.

Any ideas?

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
