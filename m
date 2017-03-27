Received: from eggs.gnu.org ([2001:4830:134:3::10]:49793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1csVba-00075m-KK
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:26:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1csVbU-0007Fb-Gt
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:26:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1csVbU-0007FS-BH
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:26:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 61164619FB
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 14:26:39 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Mon, 27 Mar 2017 22:26:25 +0800
Message-Id: <20170327142625.1249-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] scsi-generic: Fill in opt_xfer_len in INQUIRY
 reply if it is zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

When opt_xfer_len is zero, Linux ignores max_xfer_len erroneously.

While that obviously should be fixed, we do older guests a favor to
always filling in a value.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/scsi/scsi-generic.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 2933119..a55ff87 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -237,9 +237,8 @@ static void scsi_read_complete(void * opaque, int ret)
         assert(max_transfer);
         stl_be_p(&r->buf[8], max_transfer);
         /* Also take care of the opt xfer len. */
-        if (ldl_be_p(&r->buf[12]) > max_transfer) {
-            stl_be_p(&r->buf[12], max_transfer);
-        }
+        stl_be_p(&r->buf[12],
+                 MIN_NON_ZERO(max_transfer, ldl_be_p(&r->buf[12])));
     }
     scsi_req_data(&r->req, len);
     scsi_req_unref(&r->req);
-- 
2.9.3
