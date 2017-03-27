Received: from eggs.gnu.org ([2001:4830:134:3::10]:60831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csXJq-0006sG-2W
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:16:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csXJl-00010i-5w
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:16:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1csXJl-0000zW-0C
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:16:29 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1F526C054C58
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 16:16:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 27 Mar 2017 18:16:15 +0200
Message-Id: <20170327161615.19637-10-pbonzini@redhat.com>
In-Reply-To: <20170327161615.19637-1-pbonzini@redhat.com>
References: <20170327161615.19637-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 9/9] scsi-generic: Fill in opt_xfer_len in
 INQUIRY reply if it is zero
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

When opt_xfer_len is zero, Linux ignores max_xfer_len erroneously.

While that obviously should be fixed, we do older guests a favor to
always filling in a value.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170327142625.1249-1-famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
