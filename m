Received: from eggs.gnu.org ([2001:4830:134:3::10]:41391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <janne.huttunen@nokia.com>) id 1cnoLA-0005wp-Mv
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:26:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <janne.huttunen@nokia.com>) id 1cnoL7-0003ue-Ib
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:26:24 -0400
Received: from mail-eopbgr10114.outbound.protection.outlook.com
	([40.107.1.114]:59760
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <janne.huttunen@nokia.com>)
	id 1cnoL7-0003tJ-0W
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:26:21 -0400
From: Janne Huttunen <janne.huttunen@nokia.com>
Date: Tue, 14 Mar 2017 14:50:07 +0200
Message-ID: <cover.1489494746.git.janne.huttunen@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC][PATCH 0/6] "bootonceindex" property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: janne.huttunen@nokia.com

This series implements a "bootonceindex" property for setting the boot
source priorities for the next boot only. In principle it is supposed
to do the same thing as the '-boot once=' argument but in a compatible
way with the 'bootindex' mechanism.

The basic idea is to have a second list that is sorted by the values
of the "bootonceindex" properties. When the boot order is requested,
the new list is returned if it is not empty and the list is cleared.
The normal bootindex list is only used when there are no devices on
the "once" list.

So far I have only added the support for a couple of devices and
lightly tested it on x86_64 system emulation.

Some questions:

  - Is there already some (reasonable) way to accomplish the same
    effect in QEMU?

  - Does this approach make sense? Any better ideas?

  - Any suggestions for better function / property names?

  - Should the series be split or squashed differently? I tried to
    make it easy to review, but...

  - Are the object life times (no dangling pointers left behind)
    and (lack of) locking correct? As far as I can see, they should
    be, but someone with more experience with this codebase may see
    something I don't...

  - If this approach is going to be merged, any volunteers for
    converting the rest of the devices? Or can the conversion be
    left to be done one by one at some later date? I can try to
    convert more of them, but testing them all is likely not going
    to be possible.

  - Any other suggestions/ideas/comments?


Janne Huttunen (6):
  Re-factor bootdevice list handling, pt1.
  Re-factor bootdevice list handling, pt2.
  Add support for "bootonceindex" property.
  Clear the boot once list after it has been used.
  Support "bootonceindex" property for virtio-net interfaces.
  Support "bootonceindex" property for SCSI disks.

 bootdevice.c             | 112 ++++++++++++++++++++++++++++++++++++-----------
 hw/net/virtio-net.c      |   3 ++
 hw/nvram/fw_cfg.c        |   2 +
 hw/ppc/spapr.c           |   2 +
 hw/s390x/ipl.c           |   2 +
 hw/scsi/scsi-bus.c       |   3 ++
 hw/virtio/virtio-pci.c   |   2 +
 include/hw/block/block.h |   1 +
 include/net/net.h        |   1 +
 include/sysemu/sysemu.h  |   4 ++
 10 files changed, 106 insertions(+), 26 deletions(-)

-- 
2.7.4
