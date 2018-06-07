Received: from eggs.gnu.org ([2001:4830:134:3::10]:41975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQtw9-00088i-EX
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:22:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQtw6-0003oV-KG
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:22:41 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  7 Jun 2018 14:22:30 +0200
Message-Id: <1528374154-14680-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/4] pc-bios/s390-ccw: Allow network booting
 via pxelinux.cfg
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

This patch series adds pxelinux.cfg-style network booting to the s390-ccw
firmware. The core pxelinux.cfg loading and parsing logic has recently
been merged to SLOF, so these patches now just have to make sure to call
the right functions to get the config file loaded and parsed. Once this is
done, the kernel and initrd are loaded separately, and are then glued
together in RAM.

v2:
 - Update SLOF submodule now that the git mirror is in sync again
 - Last parameter to tftp_get_error_info() must not be NULL
 - Check CC when calling STSI, and use a #define for the UUID offset
 - Only support files with the magic "# pxelinux" string comment when
   trying to guess the contents of a file that has been downloaded via
   the "bootfile" DHCP parameter. This is just for developers' convenience,
   the official way to specify pxelinux.cfg files is to use the DHCP
   options 209 and 210 instead.

Thomas Huth (4):
  roms: Update SLOF submodule to current status
  pc-bios/s390-ccw/net: Update code for the latest changes in SLOF
  pc-bios/s390-ccw/net: Add support for pxelinux-style config files
  pc-bios/s390-ccw/net: Try to load pxelinux.cfg file accoring to the
    UUID

 pc-bios/s390-ccw/netboot.mak |   9 +-
 pc-bios/s390-ccw/netmain.c   | 226 +++++++++++++++++++++++++++++--------------
 roms/SLOF                    |   2 +-
 3 files changed, 162 insertions(+), 75 deletions(-)

-- 
1.8.3.1
