Received: from eggs.gnu.org ([2001:4830:134:3::10]:36371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Utr-0007wU-8S
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Utm-0007dy-Hb
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:43 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f4Utm-0007cs-AY
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:38 -0400
Received: by mail-wm0-x242.google.com with SMTP id r82so4637440wme.0
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 10:11:38 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  6 Apr 2018 19:11:10 +0200
Message-Id: <1523034681-33787-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
References: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 09/20] scsi-disk: Don't enlarge min_io_size to
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
Cc: Fam Zheng <famz@redhat.com>

From: Fam Zheng <famz@redhat.com>

Some backends report big max_io_sectors. Making min_io_size the same
value in this case will make it impossible for guest to align memory,
therefore the disk may not be usable at all.

Do not enlarge them when they are zero.

Reported-by: David Gibson <dgibson@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>

Message-Id: <20180327164141.19075-1-famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index f5ab767..f8ed8cf 100644
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
1.8.3.1
