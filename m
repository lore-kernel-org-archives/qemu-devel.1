Received: from eggs.gnu.org ([2001:4830:134:3::10]:59225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e80Ss-0003oK-Vn
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 04:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e80Ss-0001aa-7o
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 04:58:07 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Fri, 27 Oct 2017 04:57:52 -0400
Message-Id: <cover.1509094209.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] Don't write headers if BDS is INACTIVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, aik@ozlabs.ru, mreitz@redhat.com, den@openvz.org, stefanha@redhat.com

VHDX and Parallels both blindly write headers to the image file
if the images are opened R/W.  This causes an assert if the QEMU run
state is INMIGRATE.  Rather than blindly write on open, latch the first
write to the image, and update the header then.

Jeff Cody (4):
  block/vhdx.c: Don't blindly update the header
  block/parallels: code movement
  block/parallels: Don't update header until the first actual write
  qemu-iotests: update unsupported image formats in 194

 block/parallels.c      | 49 ++++++++++++++++++++++++++++++++-----------------
 block/vhdx.c           |  7 -------
 tests/qemu-iotests/194 |  2 +-
 3 files changed, 33 insertions(+), 25 deletions(-)

-- 
2.13.6
