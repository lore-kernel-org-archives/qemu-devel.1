Received: from eggs.gnu.org ([2001:4830:134:3::10]:53264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f0rfb-0001QW-Nv
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 12:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f0rfY-0002pO-C4
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 12:41:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36786 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f0rfY-0002pD-7O
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 12:41:56 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 28 Mar 2018 00:41:41 +0800
Message-Id: <20180327164141.19075-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2] scsi-disk: Don't enlarge min_io_size to
 max_io_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, danielhb@linux.vnet.ibm.com, eblake@redhat.com, dgibson@redhat.com

Some backends report big max_io_sectors. Making min_io_size the same
value in this case will make it impossible for guest to align memory,
therefore the disk may not be usable at all.

Do not enlarge them when they are zero.

Reported-by: David Gibson <dgibson@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>

---

v2: Leave the values alone if zero. [Paolo]
    At least we can consult block layer for a slightly more sensible
    opt_io_size, but that's for another patch.
---
 hw/scsi/scsi-disk.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index f5ab767ab5..f8ed8cf2b4 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -714,10 +714,12 @@ static int scsi_disk_emulate_inquiry(SCSIRequest *req, uint8_t *outbuf)
 
                 /* min_io_size and opt_io_size can't be greater than
                  * max_io_sectors */
-                min_io_size =
-                    MIN_NON_ZERO(min_io_size, max_io_sectors);
-                opt_io_size =
-                    MIN_NON_ZERO(opt_io_size, max_io_sectors);
+                if (min_io_size) {
+                    min_io_size = MIN(min_io_size, max_io_sectors);
+                }
+                if (opt_io_size) {
+                    opt_io_size = MIN(opt_io_size, max_io_sectors);
+                }
             }
             /* required VPD size with unmap support */
             buflen = 0x40;
-- 
2.14.3
