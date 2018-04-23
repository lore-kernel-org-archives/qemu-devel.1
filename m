Received: from eggs.gnu.org ([2001:4830:134:3::10]:36568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fAWMz-0003yY-FR
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 03:58:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fAWMu-0003c4-Jg
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 03:58:41 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 23 Apr 2018 09:58:21 +0200
Message-Id: <1524470305-26484-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/4] pc-bios/s390-ccw: Network boot
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
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>

Some patches to improve the network boot experience on s390x:

First patch is just a minor code refactoring which should not have
any visible impact, but makes the following patches easier.

Patch 2 and 3 add support for loading kernels via configuration files,
pxelinux-style and .INS-file style. This way you don't have to manually
glue your ramdisk to your kernel anymore, so this should be quite a
relieve for all users who want to boot Linux via the network.

The last patch makes sure that we leave the machine in a sane state
before jumping into the Linux kernel - i.e. the netboot firmware now
resets the machine with diag308, too, just like the main s390-ccw
is doing it already.

v2:
 - Replaced the patch to shut down virtio-net with the diag308 patch
 - Slightly changed the logic that probes for pxelinux config files:
   The user can now supply a base folder where config files reside
   (the DHCP bootfile name then must end with a slash), and the
   firmware will then only look in that folder for config files
   instead of always probing the "pxelinux.cfg" folder. This way
   we avoid a potential clash with x86 pxelinux.cfg files.
 - Some clean-ups here and there.

Thomas Huth (4):
  pc-bios/s390-ccw/net: Split up net_load() into init, load and uninit
    parts
  pc-bios/s390-ccw/net: Add support for pxelinux-style config files
  pc-bios/s390-ccw/net: Add support for .INS config files
  pc-bios/s390-ccw/net: Use diag308 to reset machine before jumping to
    the OS

 pc-bios/s390-ccw/Makefile    |   4 +-
 pc-bios/s390-ccw/bootmap.c   |  63 +-------
 pc-bios/s390-ccw/bootmap.h   |   4 -
 pc-bios/s390-ccw/jump2ipl.c  |  81 ++++++++++
 pc-bios/s390-ccw/netboot.mak |   8 +-
 pc-bios/s390-ccw/netmain.c   | 344 +++++++++++++++++++++++++++++++++++++++----
 pc-bios/s390-ccw/s390-ccw.h  |   4 +
 7 files changed, 408 insertions(+), 100 deletions(-)
 create mode 100644 pc-bios/s390-ccw/jump2ipl.c

-- 
1.8.3.1
