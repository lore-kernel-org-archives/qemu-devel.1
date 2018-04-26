Received: from eggs.gnu.org ([2001:4830:134:3::10]:51595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBdCp-0003lg-PG
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 05:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBdCj-0002pv-SY
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 05:28:47 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 26 Apr 2018 11:28:27 +0200
Message-Id: <1524734910-17970-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/3] pc-bios/s390-ccw: Some few network boot
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

Note: I've decided to removed the pxelinux.cfg patches from this series
for now, since full pxelinux support requires to parse some additional
DHCP options (see https://tools.ietf.org/html/rfc5071), and for this, the
SLOF libnet code needs to be changed first. So I guess I first have to
implement pxelinux.cfg support for PPC, too, which will likely take a
little bit longer...
Thus to keep this series short and reviewable, and to avoid that the other
patches bit-rot on my hard disk, I've now only included the patches that
are not related to pxelinux.cfg.

The first patch is just a minor code refactoring which should not have
any visible impact, but makes the following patches easier.

The second patch makes sure that we leave the machine in a sane state
before jumping into the Linux kernel - i.e. the netboot firmware now
resets the machine with diag308, too, just like the main s390-ccw
is doing it already.

Patch 3 adds support for loading kernels via .INS configuration files.
You can find these .INS config files on ISO images, so with this patch,
it should be possible to boot if the TFTP server is configured to use
the contents of such an ISO image.

v4:
 - s/uninit/release/ in the title of the first patch
 - Set schid of the network device in 184
 - Jump to 0x10000 start address if S390EP magic is available

Thomas Huth (3):
  pc-bios/s390-ccw/net: Split up net_load() into init, load and release
    parts
  pc-bios/s390-ccw/net: Use diag308 to reset machine before jumping to
    the OS
  pc-bios/s390-ccw/net: Add support for .INS config files

 pc-bios/s390-ccw/Makefile    |   4 +-
 pc-bios/s390-ccw/bootmap.c   |  63 +---------------
 pc-bios/s390-ccw/bootmap.h   |   4 --
 pc-bios/s390-ccw/jump2ipl.c  |  91 +++++++++++++++++++++++
 pc-bios/s390-ccw/netboot.mak |   3 +-
 pc-bios/s390-ccw/netmain.c   | 168 +++++++++++++++++++++++++++++++++++--------
 pc-bios/s390-ccw/s390-ccw.h  |   4 ++
 7 files changed, 240 insertions(+), 97 deletions(-)
 create mode 100644 pc-bios/s390-ccw/jump2ipl.c

-- 
1.8.3.1
