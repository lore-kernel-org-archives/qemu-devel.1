Received: from eggs.gnu.org ([2001:4830:134:3::10]:45048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f8mFb-0000el-Jh
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 08:31:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f8mFa-0003Dr-Ms
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 08:31:51 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 18 Apr 2018 14:31:43 +0200
Message-Id: <1524054707-20663-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2.13 0/4] pc-bios/s390-ccw: Network boot
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>

Some patches to improve the network boot experience on s390x:

First, make sure that we shut down the virtio-net device before jumping
into the kernel. Otherwise some incoming packets might destroy some of
the kernel's data if it has not taken over the device yet.

Then the last two patches add support for loading kernels via
configuration files - pxelinux-style and .INS-file style. This way
you don't have to manually glue your ramdisk to your kernel anymore,
so this should be quite a relieve for all users who want to boot
Linux via the network.

The config file parsers have been completely written by myself from
scratch and only tested with some config files that I came up with
on my own. So if anybody has some pre-existing pxelinux config files
already for booting a s390x, I'd appreciate some testing to see whether
this works as expected for you, too!

Thomas Huth (4):
  pc-bios/s390-ccw/net: Split up net_load() into init, load and uninit
    parts
  pc-bios/s390-ccw/net: Stop virtio-net device before jumping into the
    OS
  pc-bios/s390-ccw/net: Add support for pxelinux-style config files
  pc-bios/s390-ccw/net: Add support for .INS config files

 pc-bios/s390-ccw/netboot.mak  |   5 +-
 pc-bios/s390-ccw/netmain.c    | 312 ++++++++++++++++++++++++++++++++++++++----
 pc-bios/s390-ccw/virtio-net.c |   8 ++
 pc-bios/s390-ccw/virtio.c     |  19 ++-
 pc-bios/s390-ccw/virtio.h     |   3 +
 5 files changed, 312 insertions(+), 35 deletions(-)

-- 
1.8.3.1
