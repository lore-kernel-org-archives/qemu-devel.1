Received: from eggs.gnu.org ([2001:4830:134:3::10]:55646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gFomM-0006tp-NN
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 19:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gFomK-00008b-2x
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 19:11:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:33110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gFomJ-00008A-P9
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 19:10:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gFomH-00039b-Ai
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 23:10:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BECF02E80D8
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 23:10:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Oct 2018 23:04:58 -0000
From: Alex Williamson <alex.l.williamson@gmail.com>
Reply-To: Bug 1762707 <1762707@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152335683378.30174.9724305388945769166.malonedeb@gac.canonical.com>
Message-Id: <154050869894.20671.222073409353141682.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1762707] Re: VFIO device gets DMA failures when
 virtio-balloon leak from highmem to lowmem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

There are two scenarios here, if we have a regular, directly assigned
physical device (including VFs), vfio's page pinning will populate the
full memory footprint of the guest regardless of the balloon.  The
balloon is effectively fully deflated, but the balloon driver in the
guest hasn't released the pages back for guest kernel use.  In that case
marking the balloon as deflated at least allows those pages to be used
since they're allocated.  However, if the assigned device is an mdev
device, then the pages might only be pinned on usage, depending on the
vendor driver, and pages acquired by the guest balloon driver are
unlikely to be used by the in-guest driver for the device.  It's always
possible that the mdev vendor driver could pin them anyway, but there is
a chance that those pages are actually still freed to the host until
that point.  Latest QEMU will of course enable the  balloon inhibitor
for either case so further balloon inflation will no longer zap pages.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1762707

Title:
  VFIO device gets DMA failures when virtio-balloon leak from highmem to
  lowmem

Status in QEMU:
  Invalid

Bug description:
  Is there any known conflict between VFIO passthrough device and
  virtio-balloon?

  The VM has:
  1. 4GB system memory
  2. one VFIO passthrough device which supports high address memory DMA and=
 uses GFP_HIGHUSER pages.
  3. Memory balloon device with 4GB target.

  When setting the memory balloon target to 1GB and 4GB in loop during
  runtime (I used the command "virsh qemu-monitor-command debian --hmp
  --cmd balloon 1024"), the VFIO device DMA randomly gets failure.

  More clues:
  1. configure 2GB system memory (no highmem) VM, no issue with similar ope=
rations
  2. setting the memory balloon to higher like 8GB, no issue with similar o=
perations

  I'm also trying to narrow down this issue. It's appreciated for that
  you guys may share some thoughts.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1762707/+subscriptions
