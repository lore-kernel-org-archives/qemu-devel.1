Received: from eggs.gnu.org ([2001:4830:134:3::10]:33956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eyuoH-0003Te-6p
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 03:38:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eyuoC-0003m9-7l
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 03:38:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58232 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eyuoC-0003lt-3c
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 03:38:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F675406805B
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 07:38:37 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Thu, 22 Mar 2018 15:38:22 +0800
Message-Id: <20180322073822.25795-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] scsi-disk: Don't enlarge min_io_size to
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, eblake@redhat.com

Some backends report big max_io_sectors. Making min_io_size the same
value in this case will make it impossible for guest to align memory,
therefore the disk may not be usable at all.

Change the default behavior (when min_io_size and opt_io_size are not
specified in the command line), do not assume max_io_sectors is a good
value for opt_io_size and min_io_size, use 512 instead.

Reported-by: David Gibson <dgibson@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/scsi/scsi-disk.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 5b7a48f5a5..76e3c9eaa4 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -714,10 +714,8 @@ static int scsi_disk_emulate_inquiry(SCSIRequest *req, uint8_t *outbuf)
 
                 /* min_io_size and opt_io_size can't be greater than
                  * max_io_sectors */
-                min_io_size =
-                    MIN_NON_ZERO(min_io_size, max_io_sectors);
-                opt_io_size =
-                    MIN_NON_ZERO(opt_io_size, max_io_sectors);
+                min_io_size = MIN(min_io_size ? : 512, max_io_sectors);
+                opt_io_size = MIN(opt_io_size ? : 512, max_io_sectors);
             }
             /* required VPD size with unmap support */
             buflen = 0x40;
-- 
2.14.3
